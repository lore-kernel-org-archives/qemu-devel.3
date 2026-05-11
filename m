Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5AECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ3n-0008D9-As; Mon, 11 May 2026 08:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMQ3i-00085I-JO; Mon, 11 May 2026 08:48:30 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMQ3f-00014v-FC; Mon, 11 May 2026 08:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778503702; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=XIO88KH9Y6vGgIPm9dbHrNrVu2WE3uu60szC1b1egbc=;
 b=RKWiidIUNUhbkXMH68U7LiGIi6E7AOdIwGgEeTUkCTnb+VuZY9gnWePlYCA9Mu1YGHNPgPNNafb2Ldq3a89bkgevMyqzUnwgdV0khFxvDgS2Zadv0RwYLlWDp645SgPSJbN8bpY1T0x8JbZvUS00XrpUxm2sBOBWQkPQvGEOYfA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R831e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X2k9qjz_1778503700; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2k9qjz_1778503700 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 11 May 2026 20:48:20 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 2/6] target/riscv: Implement core SMMPT lookup logic
Date: Mon, 11 May 2026 20:47:01 +0800
Message-Id: <20260511124705.28161-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch introduces the core implementation for the Memory Protection Table
(MPT) walk, which is the central mechanism of the SMMPT extension.

A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
implements the `smmpt_lookup()` function, which performs a multi-level
page table-like walk starting from the physical address specified in the
`mptppn` CSR field. This walk determines the access permissions (read,
write, execute) for a given physical address.

The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.) and
correctly handles leaf and non-leaf entries, including reserved bit
checks. Helper functions for parsing MPT entries and converting access
permissions are also included in the new `riscv_smmpt.h` header.

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu_helper.c  |   5 +-
 target/riscv/meson.build   |   1 +
 target/riscv/pmp.h         |   3 +
 target/riscv/riscv_smmpt.c | 227 +++++++++++++++++++++++++++++++++++++
 target/riscv/riscv_smmpt.h |   5 +
 5 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 39c3486ae0..d0f0e77dfe 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1139,9 +1139,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
  * @access_type: The type of MMU access
  * @mode: Indicates current privilege level.
  */
-static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
-                                    int size, MMUAccessType access_type,
-                                    int mode)
+int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
+                             int size, MMUAccessType access_type, int mode)
 {
     pmp_priv_t pmp_priv;
     bool pmp_has_privs;
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..568ea4bd88 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -35,6 +35,7 @@ riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
   'pmp.c',
+  'riscv_smmpt.c',
   'debug.c',
   'monitor.c',
   'machine.c',
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 17307ef88a..02d6d712ba 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -87,6 +87,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
 void pmp_unlock_entries(CPURISCVState *env);
+int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
+                             int size, MMUAccessType access_type,
+                             int mode);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
new file mode 100644
index 0000000000..3e9eccf70e
--- /dev/null
+++ b/target/riscv/riscv_smmpt.c
@@ -0,0 +1,227 @@
+/*
+ * QEMU RISC-V Smmpt (Memory Protection Table)
+ *
+ * Copyright (c) 2024 Alibaba Group. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_smmpt.h"
+#include "pmp.h"
+#include "exec/page-protection.h"
+#include "system/memory.h"
+
+typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
+                               MemTxAttrs, MemTxResult *);
+
+static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldl_le(as, addr, attrs, result);
+}
+
+static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldq_le(as, addr, attrs, result);
+}
+
+/*
+ * MPT entry bit field positions:
+ *
+ * 32-bit leaf:     v[0], l[1], rsv1[6:2], perms[30:7], n[31]
+ * 32-bit nonleaf:  v[0], l[1], rsv1[9:2], ppn[31:10]
+ * 64-bit leaf:     v[0], l[1], rsv1[9:2], perms[57:10], rsv2[62:58], n[63]
+ * 64-bit nonleaf:  v[0], l[1], rsv1[9:2], ppn[61:10], rsv2[62], n[63]
+ */
+
+static inline bool mpte_is_leaf(uint64_t mpte)
+{
+   return mpte & 0x2;
+}
+
+static inline bool mpte_is_valid(uint64_t mpte)
+{
+    return mpte & 0x1;
+}
+
+static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    bool leaf = mpte_is_leaf(mpte);
+
+    if (mxl == MXL_RV32) {
+        /* leaf32.rsv1 = bits[6:2], nonleaf32.rsv1 = bits[9:2] */
+        return leaf ? extract32(mpte, 2, 5) : extract32(mpte, 2, 8);
+    }
+    if (leaf) {
+        /* leaf64.rsv1 = bits[9:2], leaf64.rsv2 = bits[62:58] */
+        return (extract64(mpte, 2, 8) << 5) | extract64(mpte, 58, 5);
+    }
+    /* nonleaf64.rsv1 = bits[9:2], nonleaf64.rsv2 = bit[62] */
+    return (extract64(mpte, 2, 8) << 1) | extract64(mpte, 62, 1);
+}
+
+static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+
+    /* leaf32.perms = bits[30:7], leaf64.perms = bits[57:10] */
+    return (mxl == MXL_RV32) ? extract32(mpte, 7, 24) : extract64(mpte, 10, 48);
+}
+
+static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, bool *nlnapot)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    uint64_t n_bit, ppn;
+
+    if (mxl == MXL_RV32) {
+        *nlnapot = false;
+        return true;
+    }
+    /* nonleaf64.n = bit[63], nonleaf64.ppn = bits[61:10] */
+    n_bit = extract64(mpte, 63, 1);
+    ppn = extract64(mpte, 10, 52);
+    *nlnapot = n_bit;
+    return n_bit ? (ppn & 0x1ff) == 0x100 : true;
+}
+
+static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
+                             bool nlnapot)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    /* nonleaf64.ppn = bits[61:10], nonleaf32.ppn = bits[31:10] */
+    uint64_t ppn = (mxl == MXL_RV32) ? extract32(mpte, 10, 22)
+                                     : extract64(mpte, 10, 52);
+
+    if (nlnapot) {
+        return deposit64(ppn, 0, 9, pn & 0x1ff);
+    }
+    return ppn;
+}
+
+/* Caller should assert i before call this interface */
+static int mpt_get_pn(hwaddr addr, int i, mpt_mode_t mode)
+{
+    if (mode == SMMPT34) {
+        return i == 0
+            ? extract64(addr, 15, 10)
+            : extract64(addr, 25, 9);
+    } else {
+        int offset = 16 + i * 9;
+        if ((mode == SMMPT64) && (i == 4)) {
+            return extract64(addr, offset, 12);
+        } else {
+            return extract64(addr, offset, 9);
+        }
+    }
+}
+
+/* Caller should assert i before call this interface */
+static int mpt_get_pi(hwaddr addr, int i, mpt_mode_t mode)
+{
+    if (mode == SMMPT34) {
+        return i == 0
+            ? extract64(addr, 12, 3)
+            : extract64(addr, 22, 3);
+    } else {
+        int offset = 16 + i * 9;
+        return extract64(addr, offset - 4, 4);
+    }
+}
+
+static bool smmpt_lookup(CPURISCVState *env, hwaddr addr, mpt_mode_t mode,
+                         int *prot, MMUAccessType access_type)
+{
+    MemTxResult res;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    CPUState *cs = env_cpu(env);
+    hwaddr mpte_addr, base = (hwaddr)env->mptppn << PGSHIFT;
+    load_entry_fn *load_entry;
+    uint32_t mptesize, levels, xwr;
+    int pn, pi, pmp_prot, pmp_ret;
+    uint64_t mpte, perms;
+
+    switch (mode) {
+    case SMMPT34:
+        load_entry = &load_entry_32; levels = 2; mptesize = 4; break;
+    case SMMPT43:
+        load_entry = &load_entry_64; levels = 3; mptesize = 8; break;
+        break;
+    case SMMPT52:
+        load_entry = &load_entry_64; levels = 4; mptesize = 8; break;
+    case SMMPT64:
+        load_entry = &load_entry_64; levels = 5; mptesize = 8; break;
+    case SMMPTBARE:
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return true;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    for (int i = levels - 1; i >= 0 ; i--) {
+        /* 1. Get pn[i] as the mpt index */
+        pn = mpt_get_pn(addr, i, mode);
+        /* 2. Get mpte address and get mpte */
+        mpte_addr = base + pn * mptesize;
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, mpte_addr,
+                                           mptesize, MMU_DATA_LOAD, PRV_M);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return false;
+        }
+        mpte = load_entry(cs->as, mpte_addr, attrs, &res);
+        /* 3. Check valid bit and reserve bits of mpte */
+        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
+            return false;
+        }
+
+        /* 4. Process non-leaf node */
+        if (!mpte_is_leaf(mpte)) {
+            bool nlnapot = false;
+            if (i == 0) {
+                return false;
+            }
+            if (!mpte_check_nlnapot(env, mpte, &nlnapot)) {
+                return false;
+            }
+            base = mpte_get_ppn(env, mpte, pn, nlnapot) << PGSHIFT;
+            continue;
+        }
+
+        /* 5. Process leaf node */
+        pi = mpt_get_pi(addr, i, mode);
+        perms = mpte_get_perms(env, mpte);
+        xwr = (perms >> (pi * 3)) & 0x7;
+        switch (xwr) {
+        case PAGE_READ:
+            *prot = PAGE_READ;
+            return access_type == MMU_DATA_LOAD;
+        case PAGE_EXEC:
+            *prot = PAGE_EXEC;
+            return access_type == MMU_INST_FETCH;
+        case PAGE_READ | PAGE_EXEC:
+            *prot = PAGE_READ | PAGE_EXEC;
+            return (access_type == MMU_DATA_LOAD ||
+                    access_type == MMU_INST_FETCH);
+        case PAGE_READ | PAGE_WRITE:
+            *prot = PAGE_READ | PAGE_WRITE;
+            return (access_type == MMU_DATA_LOAD ||
+                    access_type == MMU_DATA_STORE);
+        case PAGE_READ | PAGE_WRITE | PAGE_EXEC:
+            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            return true;
+        default:
+            return false;
+        }
+    }
+    return false;
+}
+
+bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
+                        int *prot, MMUAccessType access_type)
+{
+    mpt_mode_t mode = env->mptmode;
+
+    return smmpt_lookup(env, addr, mode, prot, access_type);
+}
diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
index 74dcccf4be..c15637036e 100644
--- a/target/riscv/riscv_smmpt.h
+++ b/target/riscv/riscv_smmpt.h
@@ -9,6 +9,9 @@
 #ifndef RISCV_SMMPT_H
 #define RISCV_SMMPT_H
 
+#include "cpu.h"
+#include "exec/mmu-access-type.h"
+
 typedef enum {
     SMMPTBARE = 0,
     SMMPT34   = 1,
@@ -18,4 +21,6 @@ typedef enum {
     SMMPTMAX
 } mpt_mode_t;
 
+bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
+                        int *prot, MMUAccessType access_type);
 #endif
-- 
2.43.0


