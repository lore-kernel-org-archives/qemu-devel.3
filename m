Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BFBCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 06:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4h4-0006b3-Db; Wed, 12 Nov 2025 01:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4g9-0006KP-Bi; Wed, 12 Nov 2025 01:50:07 -0500
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4g4-0001W1-Qq; Wed, 12 Nov 2025 01:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1762930191; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=tlr9sCUL6V++sbLTdaeqGWUww1CNWs3RY2Moe66SfGU=;
 b=PRIVqPIHXHKX/K9I8g+PDhiGNyms3BsMy2fmwuDffcotpb3pvlL78vjFVWG6xIMBbHd/T17pybCIt01T+rsA6BROJ7057zb0Z+S55Wo4ZNX387wEkaAp/SChvdTT3/9u2dQFcmPuHIoe42SEjX0ohJREKQhzYoA1TzIM1Mfq3Q0=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WsFCr9f_1762930190 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 14:49:50 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v4 1/6] target/riscv: Add basic definitions and CSRs for SMMPT
Date: Wed, 12 Nov 2025 14:49:40 +0800
Message-Id: <20251112064945.46533-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
References: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch lays the groundwork for the SMMPT (Supervisor Domains Access
Protection) extension by introducing its fundamental components.

It adds:
- New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
  the extension.
- Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
- The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
  `csr.c`.
- New fields in `CPUArchState` to store the state of these new CSRs.
- A new translation failure reason `TRANSLATE_MPT_FAIL`.

This provides the necessary infrastructure for the core MPT logic and
MMU integration that will follow.

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h                |  9 ++-
 target/riscv/cpu_bits.h           | 27 +++++++++
 target/riscv/cpu_cfg_fields.h.inc |  2 +
 target/riscv/csr.c                | 95 +++++++++++++++++++++++++++++++
 target/riscv/riscv_smmpt.h        | 21 +++++++
 5 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/riscv_smmpt.h

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..dfe21d31a7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -130,7 +130,8 @@ enum {
     TRANSLATE_SUCCESS,
     TRANSLATE_FAIL,
     TRANSLATE_PMP_FAIL,
-    TRANSLATE_G_STAGE_FAIL
+    TRANSLATE_G_STAGE_FAIL,
+    TRANSLATE_MPT_FAIL
 };
 
 /* Extension context status */
@@ -181,6 +182,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
 #include "debug.h"
+#include "riscv_smmpt.h"
 #endif
 
 #define RV_VLEN_MAX 1024
@@ -487,6 +489,11 @@ struct CPUArchState {
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
     uint64_t henvcfg;
+    /* Smsdid */
+    uint32_t mptmode;
+    uint32_t sdid;
+    uint64_t mptppn;
+    uint32_t msdcfg;
 #endif
 
     /* Fields from here on are preserved across CPU reset. */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..c6a34863d1 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1164,4 +1164,31 @@ typedef enum CTRType {
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
 #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
+
+/* Smsdid */
+#define CSR_MMPT        0xbc0
+#define CSR_MSDCFG      0xbd1
+
+#define MMPT_MODE_MASK_32   0xC0000000
+#define MMPT_SDID_MASK_32   0x3F000000
+#define MMPT_PPN_MASK_32    0x003FFFFF
+
+#define MMPT_MODE_SHIFT_32  30
+#define MMPT_SDID_SHIFT_32  24
+
+#define MMPT_MODE_MASK_64   0xF000000000000000ULL
+#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
+#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
+
+#define MPTE_L3_VALID       0x0000100000000000ULL
+#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
+
+#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
+#define MPTE_L2_RESERVED_32    0xFE000000
+
+#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
+#define MPTE_L1_RESERVED_32    0xFFFF0000
+
+#define MMPT_MODE_SHIFT_64  60
+#define MMPT_SDID_SHIFT_64  54
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..a0dffd9f30 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -60,6 +60,8 @@ BOOL_FIELD(ext_svpbmt)
 BOOL_FIELD(ext_svrsw60t59b)
 BOOL_FIELD(ext_svvptc)
 BOOL_FIELD(ext_svukte)
+BOOL_FIELD(ext_smmpt)
+BOOL_FIELD(ext_smsdid)
 BOOL_FIELD(ext_zdinx)
 BOOL_FIELD(ext_zaamo)
 BOOL_FIELD(ext_zacas)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..e14f80a540 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -794,6 +794,15 @@ static RISCVException rnmi(CPURISCVState *env, int csrno)
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
+
+static RISCVException smsdid(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_cfg(env)->ext_smsdid) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
 #endif
 
 static RISCVException seed(CPURISCVState *env, int csrno)
@@ -5470,6 +5479,89 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mmpt(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    if (riscv_cpu_xlen(env) == 32) {
+        uint32_t value = 0;
+        value |= env->mptmode << MMPT_MODE_SHIFT_32;
+        value |= (env->sdid << MMPT_SDID_SHIFT_32) & MMPT_SDID_MASK_32;
+        value |= env->mptppn & MMPT_PPN_MASK_32;
+        *val = value;
+    } else if (riscv_cpu_xlen(env) == 64) {
+        uint64_t value_64 = 0;
+        uint32_t mode_value = env->mptmode;
+        /* mpt_mode_t convert to mmpt.mode value */
+        if (mode_value) {
+            mode_value -= SMMPT43 - SMMPT34;
+        }
+        value_64 |= (uint64_t)mode_value << MMPT_MODE_SHIFT_64;
+        value_64 |= ((uint64_t)env->sdid << MMPT_SDID_SHIFT_64)
+                    & MMPT_SDID_MASK_64;
+        value_64 |= (uint64_t)env->mptppn & MMPT_PPN_MASK_64;
+        *val = value_64;
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mmpt(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    uint32_t mode_value = 0;
+    if (!riscv_cpu_cfg(env)->ext_smmpt) {
+        goto set_remaining_fields_zero;
+    }
+
+    if (riscv_cpu_xlen(env) == 32) {
+        mode_value = (val & MMPT_MODE_MASK_32) >> MMPT_MODE_SHIFT_32;
+        /* If mode is bare, the remaining fields in mmpt must be zero */
+        if (mode_value == SMMPTBARE) {
+            goto set_remaining_fields_zero;
+        } else if (mode_value <= SMMPT34) {
+            /* Only write the legal value */
+            env->mptmode = mode_value;
+        }
+        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
+        env->mptppn = val & MMPT_PPN_MASK_32;
+    } else if (riscv_cpu_xlen(env) == 64) {
+        mode_value = (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
+        if (mode_value == SMMPTBARE) {
+            goto set_remaining_fields_zero;
+        } else if (mode_value < SMMPTMAX) {
+            /* convert to mpt_mode_t */
+            mode_value += SMMPT43 - SMMPT34;
+            env->mptmode = mode_value;
+        }
+        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
+        env->mptppn = val & MMPT_PPN_MASK_64;
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    return RISCV_EXCP_NONE;
+
+set_remaining_fields_zero:
+    env->sdid = 0;
+    env->mptmode = SMMPTBARE;
+    env->mptppn = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_msdcfg(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
+{
+    *val = env->msdcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_msdcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val, uintptr_t ra)
+{
+    env->msdcfg = val;
+    return RISCV_EXCP_NONE;
+}
+
 #endif
 
 /* Crypto Extension */
@@ -6666,6 +6758,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                              write_mhpmcounterh                         },
     [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
                              .min_priv_ver = PRIV_VERSION_1_12_0 },
+    /* Supervisor Domain Identifier and Protection Registers */
+    [CSR_MMPT] =    { "mmpt",   smsdid,  read_mmpt,   write_mmpt   },
+    [CSR_MSDCFG] =  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },
 
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
new file mode 100644
index 0000000000..74dcccf4be
--- /dev/null
+++ b/target/riscv/riscv_smmpt.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU RISC-V Smmpt (Memory Protection Table)
+ *
+ * Copyright (c) 2024 Alibaba Group. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_SMMPT_H
+#define RISCV_SMMPT_H
+
+typedef enum {
+    SMMPTBARE = 0,
+    SMMPT34   = 1,
+    SMMPT43   = 2,
+    SMMPT52   = 3,
+    SMMPT64   = 4,
+    SMMPTMAX
+} mpt_mode_t;
+
+#endif
-- 
2.25.1


