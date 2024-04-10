Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F4FCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSN3-0002bK-Re; Wed, 10 Apr 2024 03:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLY-0006Ju-6j; Wed, 10 Apr 2024 03:26:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLV-0004ap-FI; Wed, 10 Apr 2024 03:26:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C86C5D693;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9A058B02D4;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191755 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 36/87] target/i386: use separate MMU indexes for 32-bit
 accesses
Date: Wed, 10 Apr 2024 10:22:09 +0300
Message-Id: <20240410072303.4191455-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Accesses from a 32-bit environment (32-bit code segment for instruction
accesses, EFER.LMA==0 for processor accesses) have to mask away the
upper 32 bits of the address.  While a bit wasteful, the easiest way
to do so is to use separate MMU indexes.  These days, QEMU anyway is
compiled with a fixed value for NB_MMU_MODES.  Split MMU_USER_IDX,
MMU_KSMAP_IDX and MMU_KNOSMAP_IDX in two.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 90f641531c782c873a05895f411c05fbbbef3c49)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: move changes for x86_cpu_mmu_index() to cpu_mmu_index() due to missing
 v8.2.0-1030-gace0c5fe59 "target/i386: Populate CPUClass.mmu_index")

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index df1f602758..70e6713ba3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2289,27 +2289,42 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP64_IDX    0
+#define MMU_KSMAP32_IDX    1
+#define MMU_USER64_IDX     2
+#define MMU_USER32_IDX     3
+#define MMU_KNOSMAP64_IDX  4
+#define MMU_KNOSMAP32_IDX  5
+#define MMU_PHYS_IDX       6
+#define MMU_NESTED_IDX     7
+
+#ifdef CONFIG_USER_ONLY
+#ifdef TARGET_X86_64
+#define MMU_USER_IDX MMU_USER64_IDX
+#else
+#define MMU_USER_IDX MMU_USER32_IDX
+#endif
+#endif
 
 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
+    int mmu_index_base =
+        (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
 }
 
 static inline bool is_mmu_index_smap(int mmu_index)
 {
-    return mmu_index == MMU_KSMAP_IDX;
+    return (mmu_index & ~1) == MMU_KSMAP64_IDX;
 }
 
 static inline bool is_mmu_index_user(int mmu_index)
 {
-    return mmu_index == MMU_USER_IDX;
+    return (mmu_index & ~1) == MMU_USER64_IDX;
 }
 
 static inline bool is_mmu_index_32(int mmu_index)
@@ -2320,9 +2335,12 @@ static inline bool is_mmu_index_32(int mmu_index)
 
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
-    return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
-        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
 }
 
 #define CC_DST  (env->cc_dst)
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 18fde700c1..8f7011d966 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -542,7 +542,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         if (likely(use_stage2)) {
             in.cr3 = env->nested_cr3;
             in.pg_mode = env->nested_pg_mode;
-            in.mmu_idx = MMU_USER_IDX;
+            in.mmu_idx =
+                env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
             if (!mmu_translate(env, &in, out, err)) {
-- 
2.39.2


