Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD721CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUQa-000493-GM; Sat, 13 Jun 2026 15:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQT-00043N-Rz; Sat, 13 Jun 2026 15:53:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQS-00043j-0p; Sat, 13 Jun 2026 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380259; bh=sjwTMIMk1KhYJ9D5Q2FW52WytCeRspT0hTEheUQbs6Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AIB57BAN9ctq46cIl1qnLH7mSuO3ox9yCGLHDaBwLpGzDIa0o1fIPYYudji8e9DBK
 JOkgQ1Ld1D0LNqztnGtbdCefdch/9P6NwY45O92hbmk409oBP7JwxYD205Y/ZoP4Iq
 w1pfO+V6mANSx1PX7uUHRrOyChYy8HnEY9AzC6P1DUhyjjsTU2+c3e6OUfPViH67j/
 ckTmeHXqg/y9G2eBllDZQQF0cZci4OD62Dnc6y5uxhUKkKjukaxKTDE9jdk9J5lOBO
 5p/8uBpNP7RX8SuBC926W1R3rSp/hmQ6QWK6DfJ9O6vQmcKdvYgFWpsBncyZucHrJf
 3VWLzHV9CJT5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D73F61B6E2D;
 Sat, 13 Jun 2026 22:50:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C2E43CE8A7;
 Sat, 13 Jun 2026 22:51:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 30/56] linux-user/mips: save/restore FCSR across
 signal delivery
Date: Sat, 13 Jun 2026 22:50:44 +0300
Message-ID: <20260613195116.1807273-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

QEMU keeps the MIPS FPU control/status register (FCSR, fcr31) in
env->active_fpu.fcr31.  The rounding mode, flush-to-zero (FS), and
NaN-2008 mode bits in fcr31 are reflected into the derived
env->active_fpu.fp_status via set_float_rounding_mode() and friends;
every architectural write to FCSR goes through helper_ctc1() which
calls restore_fp_status() to keep the two in sync.

Both target_sigcontext variants (O32 and N32/N64) have an sc_fpc_csr
field that holds FCSR, but setup_sigcontext() never wrote it and
restore_sigcontext() never read it.  As a result:

  - The signal frame always delivered sc_fpc_csr == 0 to the handler,
    so sigaction(SA_SIGINFO) handlers that inspect the interrupted
    context see the wrong FCSR.

  - On sigreturn, active_fpu.fcr31 retained whatever value the signal
    handler last installed (if any), and active_fpu.fp_status was
    never resynced.  Interrupted code resumed with the wrong rounding
    mode, FS flag, and NaN-2008 semantics.

Fix setup_sigcontext() to save fcr31 into sc_fpc_csr.  Fix
restore_sigcontext() to read it back (masked to fcr31_rw_bitmask as
the kernel does) and call cpu_mips_restore_fp_status() to resync
fp_status from the restored fcr31.

Add cpu_mips_restore_fp_status() in target/mips/fpu.c (which already
defines ieee_rm and includes fpu_helper.h), and declare it in cpu.h.

Fixes: 084d0497a0 ("mips-linux-user: Save and restore fpu and dsp from sigcontext")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 84b920ccb5ee5287747af2d36d1ece6367b6a40e)
(Mjt: context fixup in target/mips/cpu.h)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index d69a5d73dd..1b10012726 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -134,6 +134,7 @@ static inline void setup_sigcontext(CPUMIPSState *regs,
     for (i = 0; i < 32; ++i) {
         __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    __put_user(regs->active_fpu.fcr31, &sc->sc_fpc_csr);
 }
 
 static inline void
@@ -165,6 +166,12 @@ restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
     for (i = 0; i < 32; ++i) {
         __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    {
+        uint32_t fcr31;
+        __get_user(fcr31, &sc->sc_fpc_csr);
+        regs->active_fpu.fcr31 = fcr31 & regs->active_fpu.fcr31_rw_bitmask;
+        cpu_mips_restore_fp_status(regs);
+    }
 }
 
 /*
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..ae1fcad7bd 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1377,6 +1377,9 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
                             MIPS_HFLAG_HWRENA_ULR);
 }
 
+/* fpu.c */
+void cpu_mips_restore_fp_status(CPUMIPSState *env);
+
 /**
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
diff --git a/target/mips/fpu.c b/target/mips/fpu.c
index c7c487c1f9..8b661865ca 100644
--- a/target/mips/fpu.c
+++ b/target/mips/fpu.c
@@ -17,6 +17,11 @@ const FloatRoundMode ieee_rm[4] = {
     float_round_down
 };
 
+void cpu_mips_restore_fp_status(CPUMIPSState *env)
+{
+    restore_fp_status(env);
+}
+
 const char fregnames[32][4] = {
     "f0",  "f1",  "f2",  "f3",  "f4",  "f5",  "f6",  "f7",
     "f8",  "f9",  "f10", "f11", "f12", "f13", "f14", "f15",
-- 
2.47.3


