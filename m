Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16580C4450E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk129-0006lk-Gl; Wed, 15 Jul 2026 10:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11z-0006g7-Ff; Wed, 15 Jul 2026 10:56:17 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wk11u-00052w-HO; Wed, 15 Jul 2026 10:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784127347; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=EZeokRcPmyS1pMC+5nbXh8BHk/bNmq2BQUbViTV7gfk=;
 b=MrrRwFhuu96EYlO3RMyHWxJHTaGE8PeQ49v5wEuH8Ya1YCrnk0hSjCk8C9D7TSGS0XuxMIzNLu4Z5plTQlLfH4Nc7ralymm6EcBRakTJ40EQr2ra9kWG1w+/i+UMLOKCd9Q2ikOyGh/a84Osydb05Ip43rDJc4OtwJmxs1u0IF8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X79XjOD_1784127031; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X79XjOD_1784127031 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 15 Jul 2026 22:50:31 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v7 03/11] target/riscv: Implement core SMMPT lookup logic
Date: Wed, 15 Jul 2026 22:50:08 +0800
Message-Id: <20260715145016.17369-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
References: <20260715145016.17369-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.)
and correctly handles leaf and non-leaf entries, including reserved bit
checks. Both non-NAPOT leaf entries (per-page XWR tuples) and NAPOT leaf
entries (a single XWR tuple with a G granularity field) are supported, as
defined by the v0.4.9 MPTE format. Helper functions for parsing MPT
entries and converting access permissions are included in the new
`riscv_smmpt.h` header.

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/meson.build      |   1 +
 target/riscv/riscv_smmpt.c    | 339 ++++++++++++++++++++++++++++++++++
 target/riscv/riscv_smmpt.h    |   5 +
 target/riscv/tcg/cpu_helper.c |   6 +-
 target/riscv/tcg/pmp.h        |   3 +
 5 files changed, 351 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 42d0f6d538..51257a8f3a 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,6 +22,7 @@ riscv_ss.add(files(
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
+  'riscv_smmpt.c',
   'monitor.c',
   'machine.c',
   'time_helper.c',
diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
new file mode 100644
index 0000000000..5bdc474dbb
--- /dev/null
+++ b/target/riscv/riscv_smmpt.c
@@ -0,0 +1,339 @@
+/*
+ * QEMU RISC-V Smmpt (Memory Protection Table)
+ *
+ * Copyright (c) 2024 Alibaba Group. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Implements the MPT lookup algorithm per SMMTT specification v0.4.9.
+ *
+ * MPTE format (v0.4.9):
+ *
+ * 32-bit non-leaf:  V[0], L=0[1], Reserved[9:2], PPN[31:10]
+ * 32-bit non-NAPOT leaf: V[0], L=1[1], N=0[2], Reserved[7:3], XWR[31:8]
+ * 32-bit NAPOT leaf: V[0], L=1[1], N=1[2], Reserved[7:3], XWR[10:8], 0[11],
+ *                    G[15:12], Reserved[31:16]
+ *
+ * 64-bit non-leaf:  V[0], L=0[1], Reserved[9:2], PPN[53:10], Reserved[63:54]
+ * 64-bit non-NAPOT leaf: V[0], L=1[1], N=0[2], Reserved[7:3], XWR[55:8],
+ *                         Reserved[63:56]
+ * 64-bit NAPOT leaf: V[0], L=1[1], N=1[2], Reserved[7:3], XWR[10:8], 0[11],
+ *                    G[15:12], Reserved[63:16]
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_smmpt.h"
+#include "tcg/pmp.h"
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
+static inline bool mpte_is_valid(uint64_t mpte)
+{
+    return mpte & 0x1;
+}
+
+static inline bool mpte_is_leaf(uint64_t mpte)
+{
+    return mpte & 0x2;
+}
+
+static inline bool mpte_get_n(uint64_t mpte)
+{
+    return (mpte >> 2) & 0x1;
+}
+
+/*
+ * Get reserved bits from MPTE. Returns non-zero if any reserved bit is set.
+ */
+static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    bool leaf = mpte_is_leaf(mpte);
+    bool napot = mpte_get_n(mpte);
+
+    if (mxl == MXL_RV32) {
+        if (!leaf) {
+            /* non-leaf32: Reserved = bits[9:2] */
+            return extract32(mpte, 2, 8);
+        }
+        if (!napot) {
+            /* non-NAPOT leaf32: Reserved = bits[7:3] (XWR fills [31:8]) */
+            return extract32(mpte, 3, 5);
+        }
+        /* NAPOT leaf32: Reserved = bits[7:3] | bit[11] (mbz) | bits[31:16] */
+        return extract32(mpte, 3, 5) | extract32(mpte, 11, 1) |
+               extract32(mpte, 16, 16);
+    }
+
+    /* RV64 */
+    if (!leaf) {
+        /* non-leaf64: Reserved = bits[9:2] | bits[63:54] */
+        return extract64(mpte, 2, 8) | extract64(mpte, 54, 10);
+    }
+    if (!napot) {
+        /* non-NAPOT leaf64: Reserved = bits[7:3] | bits[63:56] */
+        return extract64(mpte, 3, 5) | extract64(mpte, 56, 8);
+    }
+    /* NAPOT leaf64: Reserved = bits[7:3] | bit[11] (mbz) | bits[63:16] */
+    return extract64(mpte, 3, 5) | extract64(mpte, 11, 1) |
+           extract64(mpte, 16, 48);
+}
+
+/*
+ * Get PPN from a non-leaf MPTE.
+ * RV32 non-leaf: PPN = bits[31:10] (22 bits)
+ * RV64 non-leaf: PPN = bits[53:10] (44 bits)
+ */
+static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+
+    if (mxl == MXL_RV32) {
+        return extract32(mpte, 10, 22);
+    }
+    return extract64(mpte, 10, 44);
+}
+
+/*
+ * Get XWR permission for a specific page index from a non-NAPOT leaf.
+ * The XWR base bit is 8 for both RV32 and RV64; only the number of
+ * entries differs (pi in 0..7 for RV32, 0..15 for RV64).
+ */
+static uint32_t mpte_get_xwr(CPURISCVState *env, uint64_t mpte, int pi)
+{
+    return extract64(mpte, 8 + pi * 3, 3);
+}
+
+/*
+ * Get single XWR from a NAPOT leaf.
+ * The NAPOT XWR base bit is 8 for both RV32 and RV64 (bits[10:8]).
+ */
+static uint32_t mpte_get_napot_xwr(CPURISCVState *env, uint64_t mpte)
+{
+    return extract64(mpte, 8, 3);
+}
+
+/*
+ * Get G field from a NAPOT leaf.
+ * The G base bit is 12 for both RV32 and RV64 (bits[15:12]).
+ */
+static uint32_t mpte_get_g(CPURISCVState *env, uint64_t mpte)
+{
+    return extract64(mpte, 12, 4);
+}
+
+/*
+ * Validate the G encoding for the given MPT mode.
+ * Smmpt34: only G=6 is valid
+ * Smmpt43/52/64: only G=4 is valid
+ */
+static bool mpte_validate_g(uint32_t g, mpt_mode_t mode)
+{
+    switch (mode) {
+    case SMMPT34:
+        return g == 6;
+    case SMMPT43:
+    case SMMPT52:
+    case SMMPT64:
+        return g == 4;
+    default:
+        return false;
+    }
+}
+
+/*
+ * Get page number index pn[i] from the supervisor physical address.
+ *
+ * Smmpt34 (34-bit SPA):
+ *   SPA layout: range_offset[14:0], pn[0][24:15] (10 bits),
+ *   pn[1][33:25] (9 bits)
+ *
+ * Smmpt43/52/64 (RV64 MPT):
+ *   SPA layout: range_offset[15:0], pn[0][24:16] (9 bits), ...
+ *   For Smmpt64, pn[4] (top level) is 12 bits.
+ */
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
+/*
+ * Get the page index within a leaf MPTE.
+ *
+ * Smmpt34: pi = SPA[14:12] (3 bits) for level 0, SPA[24:22] for level 1
+ * Smmpt43/52/64: pi = SPA[offset-4 +: 4] (4 bits)
+ */
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
+/*
+ * Check XWR permission bits against the access type.
+ * Returns true if access is allowed.
+ *
+ * The 3-bit XWR field uses the same bit order as RISC-V PTE permissions
+ * (bit0 = R, bit1 = W, bit2 = X), matching QEMU's PAGE_READ / PAGE_WRITE /
+ * PAGE_EXEC. As with PTEs, writable-but-not-readable encodings are reserved.
+ *
+ * XWR encoding (bit2=X, bit1=W, bit0=R):
+ *   000 = No access
+ *   001 = Read only
+ *   010 = Reserved (fault)
+ *   011 = Read + Write
+ *   100 = Execute only
+ *   101 = Read + Execute
+ *   110 = Reserved (fault)
+ *   111 = Read + Write + Execute
+ */
+static bool mpt_check_xwr(uint32_t xwr, int *prot, MMUAccessType access_type)
+{
+    switch (xwr) {
+    case 0: /* No access */
+        return false;
+    case PAGE_EXEC: /* 100: Execute only */
+        *prot = PAGE_EXEC;
+        return access_type == MMU_INST_FETCH;
+    case PAGE_READ | PAGE_EXEC: /* 101: Read + Execute */
+        *prot = PAGE_READ | PAGE_EXEC;
+        return (access_type == MMU_DATA_LOAD ||
+                access_type == MMU_INST_FETCH);
+    case PAGE_READ: /* 001: Read only */
+        *prot = PAGE_READ;
+        return access_type == MMU_DATA_LOAD;
+    case PAGE_READ | PAGE_WRITE: /* 011: Read + Write */
+        *prot = PAGE_READ | PAGE_WRITE;
+        return (access_type == MMU_DATA_LOAD ||
+                access_type == MMU_DATA_STORE);
+    case PAGE_READ | PAGE_WRITE | PAGE_EXEC: /* 111: R+W+X */
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return true;
+    default: /* 010, 110: Reserved - fault */
+        return false;
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
+    uint32_t mptesize, levels, xwr, g;
+    int pn, pi, pmp_prot, pmp_ret;
+    uint64_t mpte;
+
+    switch (mode) {
+    case SMMPT34:
+        load_entry = &load_entry_32; levels = 2; mptesize = 4; break;
+    case SMMPT43:
+        load_entry = &load_entry_64; levels = 3; mptesize = 8; break;
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
+
+    for (int i = levels - 1; i >= 0; i--) {
+        /* Step 1: Get pn[i] as the MPT index */
+        pn = mpt_get_pn(addr, i, mode);
+
+        /* Step 2: Load MPTE from memory */
+        mpte_addr = base + pn * mptesize;
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, mpte_addr,
+                                           mptesize, MMU_DATA_LOAD, PRV_M);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return false;
+        }
+        mpte = load_entry(cs->as, mpte_addr, attrs, &res);
+        if (res != MEMTX_OK) {
+            return false;
+        }
+
+        /* Step 3: Check valid bit and reserved bits */
+        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
+            return false;
+        }
+
+        /* Step 3 (cont): non-leaf with N=1 is a fault */
+        if (!mpte_is_leaf(mpte) && mpte_get_n(mpte)) {
+            return false;
+        }
+
+        /* Step 4: Process non-leaf node */
+        if (!mpte_is_leaf(mpte)) {
+            if (i == 0) {
+                return false;
+            }
+            base = mpte_get_ppn(env, mpte) << PGSHIFT;
+            continue;
+        }
+
+        /* Step 5 & 6: Process leaf node */
+        if (!mpte_get_n(mpte)) {
+            /* Step 5: Non-NAPOT leaf - get XWR[pi] */
+            pi = mpt_get_pi(addr, i, mode);
+            xwr = mpte_get_xwr(env, mpte, pi);
+        } else {
+            /* Step 6: NAPOT leaf - validate G, get single XWR */
+            g = mpte_get_g(env, mpte);
+            if (!mpte_validate_g(g, mode)) {
+                return false;
+            }
+            xwr = mpte_get_napot_xwr(env, mpte);
+        }
+
+        /* Step 7: Check permission */
+        return mpt_check_xwr(xwr, prot, access_type);
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
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..354506c565 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -903,9 +903,9 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
  * @access_type: The type of MMU access
  * @mode: Indicates current privilege level.
  */
-static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
-                                    int size, MMUAccessType access_type,
-                                    privilege_mode_t mode)
+int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
+                             int size, MMUAccessType access_type,
+                             privilege_mode_t mode)
 {
     pmp_priv_t pmp_priv;
     bool pmp_has_privs;
diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h
index 4c95c2767a..16c0db93c6 100644
--- a/target/riscv/tcg/pmp.h
+++ b/target/riscv/tcg/pmp.h
@@ -80,6 +80,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
 void pmp_unlock_entries(CPURISCVState *env);
+int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
+                             int size, MMUAccessType access_type,
+                             privilege_mode_t mode);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-- 
2.43.0


