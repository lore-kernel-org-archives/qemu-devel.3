Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6ECC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcxo-0001s0-Le; Mon, 10 Aug 2026 23:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtcxi-0001iP-Pl; Mon, 10 Aug 2026 23:15:34 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liliang2057@phytium.com.cn>)
 id 1wtcxe-0005WH-2D; Mon, 10 Aug 2026 23:15:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwB3fxvOk3pqToQxAw--.9572S2;
 Tue, 11 Aug 2026 11:15:26 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfHTAk3pqUTgiAA--.58848S4;
 Tue, 11 Aug 2026 11:15:19 +0800 (CST)
From: Liang Li <liliang2057@phytium.com.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, tangtao1634@phytium.com.cn,
 Liang Li <liliang2057@phytium.com.cn>
Subject: [RFC PATCH 1/1] target/riscv: fix vector fault-only-first vl
 truncation under plugin memory callbacks
Date: Tue, 11 Aug 2026 11:14:55 +0800
Message-ID: <20260811031455.1330838-2-liliang2057@phytium.com.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260811031455.1330838-1-liliang2057@phytium.com.cn>
References: <20260811031455.1330838-1-liliang2057@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfHTAk3pqUTgiAA--.58848S4
X-CM-SenderInfo: 5oloxttqjsikux6sx5pwlxzhxfrphubq/1tbiAQAEAGp6JskBcwAAsI
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liliang205
 7@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF4UJFyDAF15ZF1xtw4rGrg_yoWfuw43pF
 40kFyYkayvgryxXay3Xry2vF4rKw1rJrWUCas5G3sY9ws8Xr1SqwsagFW2va15Gr4kZw4Y
 qFn0vryUXry7AFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=liliang2057@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The fault-only-first vector load (vle*ff, e.g. vle8ff.v) decides how many
elements it can safely load by probing memory and truncating vl at the first
faulting element.  When a plugin registers a vcpu memory callback, that probe
goes through probe_access_flags(), which returns a non-zero "not plain RAM"
flag for ordinary RAM: TLB_MMIO via force_mmio in system mode (commit
6d03226b42), or TLB_FORCE_SLOW in user mode.

For a normal load these flags only affect the fast/slow path selection and
the data is still read correctly.  But vext_ldff() treats any flag other
than TLB_WATCHPOINT as "this element faults", so the first non-first element
is reported faulting and vl is truncated to 1.  The loaded data stays
correct, but a vectorized strlen/scan degenerates from N bytes/iter to
1 byte/iter, inflating the dynamic instruction count whenever a
memory-observing plugin is attached.

Fix it by routing vext_ldff()'s probes through probe_access_full_mmu(), which
probes with check_mem_cbs=false (it reports the memory mapping itself,
unaffected by plugin instrumentation).  The plain-load path (vext_page_ldst_us)
is unchanged, so plugin observation of real loads/stores is preserved.  A
user-mode counterpart of probe_access_full_mmu() is added, since it previously
only existed in system mode.

Reproduced on master (v11.1.0-rc3) with a minimal memory-callback plugin and
a vle8ff strlen guest: enabling the plugin inflates the vle8ff execution
count ~16x without the fix, and has no effect with it.

Fixes: 17288e38bebf ("optimize the memory probing for vector fault-only-first loads.")
Signed-off-by: Liang Li <liliang2057@phytium.com.cn>
---
 accel/tcg/user-exec.c            | 35 ++++++++++++++++++++++----
 include/accel/tcg/probe.h        |  8 ++++--
 target/riscv/tcg/vector_helper.c | 42 ++++++++++++++++++++++++--------
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a35aca7..9e6e641 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -750,7 +750,8 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
 
 static int probe_access_internal(CPUArchState *env, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
-                                 bool nonfault, uintptr_t ra)
+                                 bool nonfault, uintptr_t ra,
+                                 bool ignore_plugin)
 {
     int acc_flag;
     bool maperr;
@@ -772,7 +773,8 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     if (guest_addr_valid_untagged_vaddr(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
-            if (access_type != MMU_INST_FETCH
+            if (!ignore_plugin
+                && access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
                 return TLB_FORCE_SLOW;
             }
@@ -797,18 +799,40 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
     int flags;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-    flags = probe_access_internal(env, addr, size, access_type, nonfault, ra);
+    flags = probe_access_internal(env, addr, size, access_type, nonfault, ra,
+                                  false);
     *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(env), addr);
     return flags;
 }
 
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull)
+{
+    int flags;
+
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+    /*
+     * Semantic probe (e.g. RISC-V fault-only-first vl decision): ignore plugin
+     * memory callbacks so force_mmio/TLB_FORCE_SLOW does not skew the result.
+     * Mirrors the system-mode implementation (check_mem_cbs=false).
+     */
+    flags = probe_access_internal(env, addr, size, access_type, true, 0, true);
+    *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(env), addr);
+    if (pfull) {
+        *pfull = NULL;
+    }
+    return flags;
+}
+
 void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t ra)
 {
     int flags;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-    flags = probe_access_internal(env, addr, size, access_type, false, ra);
+    flags = probe_access_internal(env, addr, size, access_type,
+                                  false, ra, false);
     g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
@@ -825,7 +849,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 {
     int flags;
 
-    flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
+    flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH,
+                                  false, 0, false);
     g_assert(flags == 0);
 
     *hostp = g2h_untagged_vaddr(addr);
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index 0b78890..d02eba8 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -91,6 +91,8 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       bool nonfault, void **phost,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 
+#endif /* !CONFIG_USER_ONLY */
+
 /**
  * probe_access_full_mmu:
  * Like probe_access_full, except:
@@ -100,13 +102,15 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
  * handling another potential mmu fault, this function never raises
  * exceptions (akin to @nonfault true for probe_access_full).
  * Likewise this function does not trigger plugin instrumentation.
+ *
+ * Available in both system and user mode; used by semantic probes such as
+ * the RISC-V vector fault-only-first vl decision, which must not be skewed
+ * by plugin memory callbacks (force_mmio / TLB_FORCE_SLOW).
  */
 int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
                           void **phost, CPUTLBEntryFull **pfull);
 
-#endif /* !CONFIG_USER_ONLY */
-
 /**
  * tlb_vaddr_to_host:
  * @env: CPUArchState
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e321ca2..ea4cbbd 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -163,14 +163,29 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
  */
 static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
                         uintptr_t ra, MMUAccessType access_type, int mmu_index,
-                        void **host, int *flags, bool nonfault)
+                        void **host, int *flags, bool nonfault,
+                        bool ignore_plugin)
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
 
     if (flags != NULL) {
-        *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                    access_type, mmu_index, nonfault, host, ra);
+        if (ignore_plugin) {
+            /*
+             * Semantic probe (e.g. fault-only-first vl decision): must reflect
+             * the memory mapping itself, not be skewed by plugin memory
+             * callbacks (force_mmio would otherwise report TLB_MMIO for plain
+             * RAM and truncate vl). probe_access_full_mmu passes
+             * check_mem_cbs=false internally.
+             */
+            CPUTLBEntryFull *full = NULL;
+            *flags = probe_access_full_mmu(env, adjust_addr(env, addr), curlen,
+                                           access_type, mmu_index, host, &full);
+        } else {
+            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                        access_type, mmu_index, nonfault,
+                                        host, ra);
+        }
     } else {
         probe_access(env, adjust_addr(env, addr), curlen, access_type,
                      mmu_index, ra);
@@ -180,9 +195,16 @@ static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
         addr += curlen;
         curlen = len - curlen;
         if (flags != NULL) {
-            *flags |= probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                         access_type, mmu_index, nonfault,
-                                         host, ra);
+            if (ignore_plugin) {
+                CPUTLBEntryFull *full = NULL;
+                *flags |= probe_access_full_mmu(env, adjust_addr(env, addr),
+                                                curlen, access_type, mmu_index,
+                                                host, &full);
+            } else {
+                *flags |= probe_access_flags(env, adjust_addr(env, addr),
+                                             curlen, access_type, mmu_index,
+                                             nonfault, host, ra);
+            }
         } else {
             probe_access(env, adjust_addr(env, addr), curlen, access_type,
                          mmu_index, ra);
@@ -396,7 +418,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
 
     /* Check page permission/pmp/watchpoint/etc. */
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
-                true);
+                true, false);
 
     if (flags == 0) {
         if (nf == 1) {
@@ -710,7 +732,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 
     /* Check page permission/pmp/watchpoint/etc. */
     probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA_LOAD,
-                mmu_index, &host, &flags, true);
+                mmu_index, &host, &flags, true, true);
 
     if (flags & ~TLB_WATCHPOINT) {
         /* probe every access */
@@ -722,7 +744,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
             if (i == 0) {
                 /* Allow fault on first element. */
                 probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD,
-                            mmu_index, &host, NULL, false);
+                            mmu_index, &host, NULL, false, true);
             } else {
                 remain = nf << log2_esz;
                 while (remain > 0) {
@@ -730,7 +752,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 
                     /* Probe nonfault on subsequent elements. */
                     probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
-                                mmu_index, &host, &flags, true);
+                                mmu_index, &host, &flags, true, true);
 
                     /*
                      * Stop if invalid (unmapped) or mmio (transaction may
-- 
2.51.1


