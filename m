Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A03CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxzN-0004fL-11; Tue, 26 May 2026 16:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxz9-0004ZY-RE; Tue, 26 May 2026 16:02:46 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxz8-0002u5-27; Tue, 26 May 2026 16:02:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47A3F43515;
 Tue, 26 May 2026 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49201F000E9;
 Tue, 26 May 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779825759;
 bh=pGlSoLvSkWLWM09alJZgROZ3NJFIPwvSs1E7yFYC654=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=di+Fdfz4XoQ/QPnbPMlxcSA/NStguprg2514Elzv+645tTbBgaqssnsRigRHM2H7a
 3RA8IvTnafVY8gi8gWLqyB6aPUQPs+fX+Vqa3EssWaUfUkvJbR3GKpoU8R6EoBSHn1
 XlrLYD2AdibArCyU8pfXds+YwqSKz6mumPhqoxDNlBg4PKAwe8JaYnERAi0mvg78nm
 ChAY7/ZSYAx7fuEG9nLD+FhiSYWfh3g+/Ez/hYhekyW3L0XfsU8azPGcBfUo2Wu2pl
 Jh9o9Xrq2OJpFcSaRrC0u5KoCU6gNBwNLVN0w4G504MSDy8sxRRoX1AF381mMEAygS
 CeaG3kvku/Zaw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 07/12] linux-user/s390x: restore fpu_status rounding mode from
 FPC on sigreturn
Date: Tue, 26 May 2026 22:02:02 +0200
Message-ID: <20260526200207.79738-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526200207.79738-1-deller@kernel.org>
References: <20260526200207.79738-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
The rounding mode bits [2:0] of FPC are reflected into the derived
env->fpu_status via set_float_rounding_mode(); every architectural
write to FPC goes through HELPER(sfpc) which keeps the two in sync.

restore_sigregs() restored FPC with a direct assignment:

    __get_user(env->fpc, &sc->fpregs.fpc);

This wrote env->fpc correctly but never updated env->fpu_status, so on
sigreturn the interrupted code resumed with whatever rounding mode the
signal handler last installed in fpu_status.

Factor the two-step "write fpc + sync fpu_status" logic out of
HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
it from restore_sigregs() in place of the direct assignment.

cpu_s390x_load_fpc() partially reuses the sanity check from
HELPER(sfpc): if the FPC value has an invalid rounding mode or reserved
bits set, it falls back to 0, matching the kernel's fpu_lfpc_safe()
behavior where a corrupt signal frame value causes a specification
exception and 0 is used instead.

HELPER(sfpc) now calls cpu_s390x_load_fpc() after its full
specification-exception check, including the FEAT_FLOATING_POINT_EXT
test that is not needed for the signal restore path.

Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a signal")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/s390x/signal.c     |  6 +++++-
 target/s390x/cpu.h            |  1 +
 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index 96d1c8d11c..28ad80bde4 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, target_sigregs *sc)
     for (i = 0; i < 16; i++) {
         __get_user(env->aregs[i], &sc->regs.acrs[i]);
     }
-    __get_user(env->fpc, &sc->fpregs.fpc);
+    {
+        uint32_t fpc;
+        __get_user(fpc, &sc->fpregs.fpc);
+        cpu_s390x_load_fpc(env, fpc);
+    }
     for (i = 0; i < 16; i++) {
         __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
     }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3acbe83f0f..f55b79ef8a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -895,6 +895,7 @@ void s390_init_sigp(void);
 /* helper.c */
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 6ca0b7162b..107025e675 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -1087,6 +1087,19 @@ static const int fpc_to_rnd[8] = {
     float_round_to_odd,
 };
 
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
+{
+    /*
+     * Mimic kernel fpu_lfpc_safe(): a corrupt signal frame value that would
+     * trigger a specification exception instead results in FPC being set to 0.
+     */
+    if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u) {
+        fpc = 0;
+    }
+    env->fpc = fpc;
+    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+}
+
 /* set fpc */
 void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
@@ -1094,12 +1107,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
         (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
-
-    /* Install everything in the main FPC.  */
-    env->fpc = fpc;
-
-    /* Install the rounding mode in the shadow fpu_status.  */
-    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+    cpu_s390x_load_fpc(env, fpc);
 }
 
 /* set fpc and signal */
-- 
2.54.0


