Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBCEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQf6-0005Zg-5W; Wed, 28 Feb 2024 15:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQel-00057u-RM; Wed, 28 Feb 2024 15:36:04 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeX-0001J3-Vv; Wed, 28 Feb 2024 15:35:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C80E51774;
 Wed, 28 Feb 2024 23:35:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3C9618BA7C;
 Wed, 28 Feb 2024 23:35:22 +0300 (MSK)
Received: (nullmailer pid 267635 invoked by uid 1000);
 Wed, 28 Feb 2024 20:35:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 42/47] target/i386: check validity of VMCB addresses
Date: Wed, 28 Feb 2024 23:35:10 +0300
Message-Id: <20240228203521.267565-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MSR_VM_HSAVE_PA bits 0-11 are reserved, as are the bits above the
maximum physical address width of the processor.  Setting them to
1 causes a #GP (see "15.30.4 VM_HSAVE_PA MSR" in the AMD manual).

The same is true of VMCB addresses passed to VMRUN/VMLOAD/VMSAVE,
even though the manual is not clear on that.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit d09c79010ffd880dc69e7a21e3cfdef90b928fb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index e1528b7f80..1901712ece 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -201,6 +201,9 @@ void helper_wrmsr(CPUX86State *env)
         tlb_flush(cs);
         break;
     case MSR_VM_HSAVE_PA:
+        if (val & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+            goto error;
+        }
         env->vm_hsave = val;
         break;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 2d27731b60..744aed4b31 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -164,14 +164,19 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     uint64_t new_cr3;
     uint64_t new_cr4;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
+
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmrun! " TARGET_FMT_lx "\n", addr);
 
     env->vm_vmcb = addr;
@@ -465,14 +470,19 @@ void helper_vmload(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMLOAD, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
@@ -521,14 +531,19 @@ void helper_vmsave(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMSAVE, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
-- 
2.39.2


