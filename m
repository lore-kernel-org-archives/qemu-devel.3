Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7116CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx6H-0000LT-7U; Tue, 26 May 2026 15:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx67-0000Kk-ED; Tue, 26 May 2026 15:05:51 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx65-0004Zx-TS; Tue, 26 May 2026 15:05:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A56E9600C3;
 Tue, 26 May 2026 19:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873531F000E9;
 Tue, 26 May 2026 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779822347;
 bh=RL/zGi1pDp8yTNmI8IAlrRDAo9DD/BZhQK5MCrsVinw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AExbJ3M5lZsidIVUfa8PNzQDQasBx1nwdKbO0j99/VtuoHrjP4E60NvcVDqH1bNRE
 SlTi68109/0ZbANnV/Y+KGUvnYC9PSjJsh2zZypDCQHNbr8ivWPSA8x5kC57AhZR5M
 k7jTNMnbWWSiMLdlQHrBQHFHLP+mNVf1xlz4khq0QouC4eJXZZKBBh75yw62MkjkxQ
 0PKzh9Ghfv9/biirLKkHC/08VunKY7N2QQFbTEFZBW7IgFPngYb0+Va/k3hmMGKWkS
 eI2h4OJKw9kFuD32PSrKfkkFGyMHsqV9/g+mN9CwB7zylyoxHgMp1qHATYpIeXTzq2
 xvOXZqXZJC2/Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 02/12] linux-user/mips: save/restore FCSR across signal
 delivery
Date: Tue, 26 May 2026 21:05:25 +0200
Message-ID: <20260526190535.10833-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190535.10833-1-deller@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
---
 linux-user/mips/signal.c | 7 +++++++
 target/mips/cpu.h        | 3 +++
 target/mips/fpu.c        | 5 +++++
 3 files changed, 15 insertions(+)

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
index 346713705a..392406aff8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1384,6 +1384,9 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
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
2.54.0


