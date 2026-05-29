Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64ACD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57K-0005zr-8P; Fri, 29 May 2026 17:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57I-0005yS-EJ; Fri, 29 May 2026 17:51:44 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57G-0007TZ-HX; Fri, 29 May 2026 17:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091497; x=1780696297; i=deller@gmx.de;
 bh=PVa3lEqa3sR5wLAKVwNAtEMeTXZdD91sxqfReCXvHL0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iSAr62t2ZaGlAEgw5c68PHz1K59Lu1sg2F4PllpzK9F9uRwWDGQrrhixI1gQrOPu
 IYljvIdMzm6pzlDiuSop+kB0E3GTn6PF4hpdezaZu+E2VvCqdb05+0oFb3ooDyERG
 Qbup5UPimYM/N8x/SKfsAwi92dyZIm8CnXLKhDrmyc+ReRsRPhSj7DmOLucCf9yrK
 bLsfHYDfyg/89Jgv5gx392FGGbelIVX+f0Xy76DBezOu2VRwkeTgSaROGdzNWrPJd
 MwrKZJg8FRsq4scknFoGQ5zxWXTbf5SjnsROwX/aaMERPRoCk9AKWda3GUnMglMXO
 fC6Gv21JNufBNpVSAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1xAyVP3DAR-00pAo4; Fri, 29
 May 2026 23:51:37 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL v3 02/10] linux-user/mips: save/restore FCSR across signal
 delivery
Date: Fri, 29 May 2026 23:51:11 +0200
Message-ID: <20260529215119.73244-3-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLyC3gnuq3R+cNFJHolS0RoX1WPnDszarHGof0z9Q4innE4/hpS
 qmuOn/PlaXYQrSClNhD+ami5B27z0YtzJjJKztTv+o41RbYpjVk/r2j4rIlwQS5HXH27UtG
 it3BWn2cGirI++i0xQG2eDke/79zxG+Q9rI9qoB82YElVKJ6AEyVbUXdrTJfmBJCD5SS7eY
 f8UBmSNsvrXfqnic6fLQw==
UI-OutboundReport: notjunk:1;M01:P0:+TXx7BchHvk=;tXv1xnLL5U4CaCMz8CDSHwrzyJK
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

  - The signal frame always delivered sc_fpc_csr =3D=3D 0 to the handler,
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

Fixes: 084d0497a0 ("mips-linux-user: Save and restore fpu and dsp from sig=
context")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mips/signal.c | 7 +++++++
 target/mips/cpu.h        | 3 +++
 target/mips/fpu.c        | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index d69a5d73dd..1b10012726 100644
=2D-- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -134,6 +134,7 @@ static inline void setup_sigcontext(CPUMIPSState *regs=
,
     for (i =3D 0; i < 32; ++i) {
         __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    __put_user(regs->active_fpu.fcr31, &sc->sc_fpc_csr);
 }
=20
 static inline void
@@ -165,6 +166,12 @@ restore_sigcontext(CPUMIPSState *regs, struct target_=
sigcontext *sc)
     for (i =3D 0; i < 32; ++i) {
         __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    {
+        uint32_t fcr31;
+        __get_user(fcr31, &sc->sc_fpc_csr);
+        regs->active_fpu.fcr31 =3D fcr31 & regs->active_fpu.fcr31_rw_bitm=
ask;
+        cpu_mips_restore_fp_status(regs);
+    }
 }
=20
 /*
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..392406aff8 100644
=2D-- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1384,6 +1384,9 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
=20
+/* fpu.c */
+void cpu_mips_restore_fp_status(CPUMIPSState *env);
+
 /**
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
diff --git a/target/mips/fpu.c b/target/mips/fpu.c
index c7c487c1f9..8b661865ca 100644
=2D-- a/target/mips/fpu.c
+++ b/target/mips/fpu.c
@@ -17,6 +17,11 @@ const FloatRoundMode ieee_rm[4] =3D {
     float_round_down
 };
=20
+void cpu_mips_restore_fp_status(CPUMIPSState *env)
+{
+    restore_fp_status(env);
+}
+
 const char fregnames[32][4] =3D {
     "f0",  "f1",  "f2",  "f3",  "f4",  "f5",  "f6",  "f7",
     "f8",  "f9",  "f10", "f11", "f12", "f13", "f14", "f15",
=2D-=20
2.54.0


