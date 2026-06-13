Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBDDCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUew-0007LE-5d; Sat, 13 Jun 2026 16:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeH-0004op-TY; Sat, 13 Jun 2026 16:08:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeG-0002XF-5e; Sat, 13 Jun 2026 16:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381069; bh=KvFtXIX1HFBGkwW0GZ3bAtgD4Ty2bNFPvJplYQFqrN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j149CcLj79tJCZjNoYQpTV1IP1S/JYbPV7ZsIYcGXXDcWrackcbI/8AiE9yMUQY68
 R/OPwYxJrAWiS/kBg41YWqgRubSPj0Tt5NuYn3/kkhf77gsO5BHXYbj56lBWGsfYhE
 MYeu59V7A8RU1OYuM2relVsMlamnGyM2e1q0JHYD8Ja4411lHegQn1qt2tQ2kP96+O
 vYsaE9WPK/8oem6LdcM6Aautg/s+cT54z5SrLNWwv1cJ131j1CyXKVrtTnRLpyr1NW
 LZXB79MrNqiYIo/hC4QcjlsIxTQUVlSuQJUsONlNilw47uS+HnGZOifOr++4aqGesd
 1kPgoShLhS/KQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F07D1B6E8F;
 Sat, 13 Jun 2026 23:04:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD0483CE8F1;
 Sat, 13 Jun 2026 23:04:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 39/61] linux-user/s390x: restore fpu_status rounding
 mode from FPC on sigreturn
Date: Sat, 13 Jun 2026 23:03:22 +0300
Message-ID: <20260613200411.1808021-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 2762cd51ee033dccb3167110376dd125244cc819)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index aa931cb674..af488cda17 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -924,6 +924,7 @@ void s390_init_sigp(void);
 /* helper.c */
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 1ba43715ac..83aa88a754 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -896,6 +896,19 @@ static const int fpc_to_rnd[8] = {
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
@@ -903,12 +916,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
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
2.47.3


