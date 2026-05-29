Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E85CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDn-0002t6-A3; Thu, 28 May 2026 18:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDl-0002s0-II; Thu, 28 May 2026 18:28:57 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDj-0006vK-Pp; Thu, 28 May 2026 18:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007324; x=1780612124; i=deller@gmx.de;
 bh=PVa3lEqa3sR5wLAKVwNAtEMeTXZdD91sxqfReCXvHL0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sp3SmvmnbBUcsGiRV48LtJSxNIDpP845putWL9gx1cWT34G/N98Bl11PUiWMWX5q
 4SJIdpniQLavNH+Wn1N6cailLDpuqe2PnZEGVWiZaHy07yyciHVipL293F9hzlaxm
 fSQkkDqDzBqABm0v1mT1o9p643UxHUYA9DT75tXxplICL9tjaJO1UshLq5sdw9aSA
 JB0gYx+rEGpDN2QHH+RWwd2HgnJli67dgsgW9zUnQYyjwji0Ztwud/0RRcODvI6Rh
 TJn8KLG9wEpqfbsSCTPtDX+ShFICqfxdnB1TQLr1il06wak88BcC78+8Xa0Nb3z+B
 V+Qiiu95d++3xaXKNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1wwJnj2Pwy-00abvW; Fri, 29
 May 2026 00:28:43 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 02/10] linux-user/mips: save/restore FCSR across signal
 delivery
Date: Fri, 29 May 2026 02:25:39 +0200
Message-ID: <20260529002548.19293-3-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JaZZdhiIy+0iMci+QaqZSXLpVZqEOExxItq2RgXB5T8/6/F2PeR
 ra4PlsNwQy961gOUTz0a+vZElL/LaHI7pJ3C4MZMCN2MiPE8Hgag11dKcIhRE0LF652invv
 JXfLblUjCS1MxrTGwoHaJiW88snyCAFfnxZ+IcNHVo8VuD1z9YjoV3jJzoAF6xGgml7+BVi
 SRZarpGC07FIk58vnjCwQ==
UI-OutboundReport: notjunk:1;M01:P0:7wJNohgIzao=;+BBqqhAeG7TCpkMsYbUrGAj39HU
 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
 hCp0DOGG9JiBLASYTF9NmVLqFF328CgM6cxrmrL
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


