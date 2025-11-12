Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF89CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 06:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4Xu-0004uI-VN; Wed, 12 Nov 2025 01:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4XD-0004Er-Gu; Wed, 12 Nov 2025 01:40:51 -0500
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vJ4XA-0000Nl-QW; Wed, 12 Nov 2025 01:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1762929642; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=jg5TkTO748lZiwpb6DdyvyyVCvBW5iNyU+Brojw00o0=;
 b=MhSJAjkgu38rh53mAZNly4yzwbwWRQui735Bs4YywfdEjWG84OVY2jXU5oD5GkSiIL/E44xCgJUGGWfSJOAkK9HAUKIGESsJQvPNV1pn5E13tVj4Qo4+NN9OZsIOmycTqkVMz2vfZ9ZwhcBeBYvH6HMpMYWXQo/NR6IxinFZALs=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WsF6VIz_1762929639 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 14:40:39 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v3 2/6] target/riscv: Implement core SMMPT lookup logic
Date: Wed, 12 Nov 2025 14:40:22 +0800
Message-Id: <20251112064026.44222-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251112064026.44222-1-zhiwei_liu@linux.alibaba.com>
References: <20251112064026.44222-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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
---
 target/riscv/cpu_helper.c  |   5 +-
 target/riscv/meson.build   |   1 +
 target/riscv/pmp.h         |   3 +
 target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
 target/riscv/riscv_smmpt.h |  15 ++
 5 files changed, 295 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/riscv_smmpt.c

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de..a055a8ab20 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
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
index fdefe88ccd..4fbf7802a1 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -33,6 +33,7 @@ riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
   'pmp.c',
+  'riscv_smmpt.c',
   'debug.c',
   'monitor.c',
   'machine.c',
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf24169..d9c5e74345 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -85,6 +85,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
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
index 0000000000..b7b47c5ae1
--- /dev/null
+++ b/target/riscv/riscv_smmpt.c
@@ -0,0 +1,274 @@
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
+#include "system/memory.h"
+
+typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
+                               MemTxAttrs, MemTxResult *);
+
+static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldl(as, addr, attrs, result);
+}
+
+static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldq(as, addr, attrs, result);
+}
+
+typedef union {
+    uint64_t raw;
+    struct {
+        uint32_t v:1;
+        uint32_t l:1;
+        uint32_t rsv1:5;
+        uint32_t perms:24;
+        uint32_t n:1;
+    } leaf32;
+    struct {
+        uint32_t v:1;
+        uint32_t l:1;
+        uint32_t rsv1:8;
+        uint32_t ppn:22;
+    } nonleaf32;
+    struct {
+        uint64_t v:1;
+        uint64_t l:1;
+        uint64_t rsv1:8;
+        uint64_t perms:48;
+        uint64_t rsv2:5;
+        uint64_t n:1;
+    } leaf64;
+    struct {
+        uint64_t v:1;
+        uint64_t l:1;
+        uint64_t rsv1:8;
+        uint64_t ppn:52;
+        uint64_t rsv2:1;
+        uint64_t n:1;
+    } nonleaf64;
+} mpte_union_t;
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
+    mpte_union_t *u = (mpte_union_t *)&mpte;
+
+    if (mxl == MXL_RV32) {
+        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;
+    }
+    return leaf ? (u->leaf64.rsv1 << 5) | u->leaf64.rsv2
+                : (u->nonleaf64.rsv1 << 1) | u->nonleaf64.rsv2;
+}
+
+static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    mpte_union_t *u = (mpte_union_t *)&mpte;
+
+    return (mxl == MXL_RV32) ? u->leaf32.perms : u->leaf64.perms;
+}
+
+static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, bool *nlnapot)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    mpte_union_t *u = (mpte_union_t *)&mpte;
+    if (mxl == MXL_RV32) {
+        *nlnapot = false;
+        return true;
+    }
+    *nlnapot = u->nonleaf64.n;
+    return u->nonleaf64.n ? (u->nonleaf64.ppn & 0x1ff) == 0x100 : true;
+}
+
+static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
+                             bool nlnapot)
+{
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    mpte_union_t *u = (mpte_union_t *)&mpte;
+
+    if (nlnapot) {
+        return deposit64(u->nonleaf64.ppn, 0, 9, pn & 0x1ff);
+    }
+    return (mxl == MXL_RV32) ? u->nonleaf32.ppn : u->nonleaf64.ppn;
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
+                         mpt_access_t *allowed_access,
+                         MMUAccessType access_type)
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
+        *allowed_access = ACCESS_ALLOW_RWX;
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
+        case ACCESS_ALLOW_R:
+            *allowed_access = ACCESS_ALLOW_R;
+            return access_type == MMU_DATA_LOAD;
+        case ACCESS_ALLOW_X:
+            *allowed_access = ACCESS_ALLOW_X;
+            return access_type == MMU_INST_FETCH;
+        case ACCESS_ALLOW_RX:
+            *allowed_access = ACCESS_ALLOW_R;
+            return (access_type == MMU_DATA_LOAD ||
+                    access_type == MMU_INST_FETCH);
+        case ACCESS_ALLOW_RW:
+            *allowed_access = ACCESS_ALLOW_RW;
+            return (access_type == MMU_DATA_LOAD ||
+                    access_type == MMU_DATA_STORE);
+        case ACCESS_ALLOW_RWX:
+            *allowed_access = ACCESS_ALLOW_RWX;
+            return true;
+        default:
+            return false;
+        }
+    }
+    return false;
+}
+
+bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
+                        mpt_access_t *allowed_access, MMUAccessType access_type)
+{
+    bool mpt_has_access;
+    mpt_mode_t mode = env->mptmode;
+
+    mpt_has_access = smmpt_lookup(env, addr, mode,
+                                  allowed_access, access_type);
+    return mpt_has_access;
+}
+
+/*
+ * Convert MPT access to TLB page privilege.
+ */
+int smmpt_access_to_page_prot(mpt_access_t mpt_access)
+{
+    int prot;
+    switch (mpt_access) {
+    case ACCESS_ALLOW_R:
+        prot = PAGE_READ;
+        break;
+    case ACCESS_ALLOW_X:
+        prot = PAGE_EXEC;
+        break;
+    case ACCESS_ALLOW_RX:
+        prot = PAGE_READ | PAGE_EXEC;
+        break;
+    case ACCESS_ALLOW_RW:
+        prot = PAGE_READ | PAGE_WRITE;
+        break;
+    case ACCESS_ALLOW_RWX:
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        break;
+    default:
+        prot = 0;
+        break;
+    }
+
+    return prot;
+}
diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
index 74dcccf4be..0d0597f8eb 100644
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
@@ -18,4 +21,16 @@ typedef enum {
     SMMPTMAX
 } mpt_mode_t;
 
+typedef enum {
+    ACCESS_ALLOW_R = 0b001,
+    ACCESS_ALLOW_X = 0b100,
+    ACCESS_ALLOW_RX = 0b101 ,
+    ACCESS_ALLOW_RW = 0b011,
+    ACCESS_ALLOW_RWX = 0b111,
+} mpt_access_t;
+
+int smmpt_access_to_page_prot(mpt_access_t mpt_access);
+bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
+                        mpt_access_t *allowed_access,
+                        MMUAccessType access_type);
 #endif
-- 
2.25.1


