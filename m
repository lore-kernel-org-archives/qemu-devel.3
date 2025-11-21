Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD6ACFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd5y-0003vc-Vy; Fri, 21 Nov 2025 21:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcst-0007f9-3H; Fri, 21 Nov 2025 20:57:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcrW-0007RM-TV; Fri, 21 Nov 2025 20:57:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C56D616CA8B;
 Fri, 21 Nov 2025 21:44:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 847C7321CC7;
 Fri, 21 Nov 2025 21:44:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 80/81] target/i386: svm: fix sign extension of exit
 code
Date: Fri, 21 Nov 2025 21:44:19 +0300
Message-ID: <20251121184424.1137669-80-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The exit_code parameter of cpu_vmexit is declared as uint32_t, but exit
codes are 64 bits wide according to the AMD SVM specification.  And because
uint32_t is unsigned, this causes exit codes to be zero-extended, for example
writing SVM_EXIT_ERR as 0xffff_ffff instead of the expected 0xffff_ffff_ffff_ffff.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2977
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9c3afb9d9b92d166d227b43d890c6a8ad33a928d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 54d845379c..906d32970d 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -100,7 +100,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
 /* sysemu/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
-G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
+G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint64_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env);
 #endif
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index fd9fadad00..70bbde305c 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -128,7 +128,7 @@ static inline bool virtual_gif_enabled(CPUX86State *env)
     return false;
 }
 
-static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint32_t exit_code, uintptr_t retaddr)
+static inline bool virtual_vm_load_save_enabled(CPUX86State *env, uint64_t exit_code, uintptr_t retaddr)
 {
     uint64_t lbr_ctl;
 
@@ -723,7 +723,7 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
     }
 }
 
-void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
+void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
@@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
 
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
                   PRIx64 ", " TARGET_FMT_lx ")!\n",
-                  exit_code, exit_info_1,
+                  (uint32_t)exit_code, exit_info_1,
                   x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                    control.exit_info_2)),
                   env->eip);
-- 
2.47.3


