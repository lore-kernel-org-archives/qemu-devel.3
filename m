Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA1CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDm-0002sp-FR; Thu, 28 May 2026 18:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDk-0002rB-TL; Thu, 28 May 2026 18:28:56 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDj-0006uu-2W; Thu, 28 May 2026 18:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007327; x=1780612127; i=deller@gmx.de;
 bh=yWj4xfI21hAF7hx/PxKNj42DxCD1V6gQuobYl06oyYI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hOGvbiNkBVFeiBssnZ+FL9VcplfU6g3wGWBfyIGT0Ef5zvkGImXR5PYUBhOCg5Zf
 TJ6WclqbFMjKV/CW5MNzIGYwu7+WuOhROZvVdubaZ7NPgfIT5ywBXMaB9Vuvl0r2Z
 m/XfGnswjVj31O1UeXD/72PwVS1cnLiR04FgldbmJMJ0aizuF6n4UXisXZpuUjtyq
 94zilRIOwu7vQuQC2LqUnwpwDPHglUZ+9ZmO7x+Jy3anTuS/uzh7sxc4iexhlfMu/
 kBxIFf54IvfNLDa0Dys/3RC0wzcriTxzZWohRIzenA/BW/OHwF2dYxVSkKhuwojWi
 eTk4iQWKsJ3Fm3Kr8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1wsHOE0Nw5-00W7tb; Fri, 29
 May 2026 00:28:47 +0200
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
Subject: [PULL v2 04/10] linux-user/sh4: restore FP rounding mode on sigreturn
Date: Fri, 29 May 2026 02:25:41 +0200
Message-ID: <20260529002548.19293-5-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3OHMdlONlWuxlRATav7FiOQGpaHyx9U/ZQh+ssgp2GZyXjyCsX
 YKXTSn3UBTPrYwVFIXUlX1oob64TLsYuFjoEVkLIfypgx6Dh5CSWdPateUMGAkvolx093KX
 lR+lE6wxiis9WuCg40Uwb9MNEiwP9eEHWcTSWgkP+/vXtgBbV/xJglEn6iTTtnTW+D5nqKN
 ACBZHM5iXXpH0Vgjazpfg==
UI-OutboundReport: notjunk:1;M01:P0:WCRdGhsEtgg=;I7t5nZDfUz85LaalPBhEVB4s4oe
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

The SH4 FPSCR rounding-mode (RM) and denormal (DN) bits are not held
only in env->fpscr: they are also reflected into the derived
env->fp_status via set_float_rounding_mode()/set_flush_to_zero(). The
guest keeps the two in sync by routing every write to FPSCR through
helper_ld_fpscr().

restore_sigcontext() wrote the saved value straight into env->fpscr and
never touched env->fp_status, so on sigreturn the interrupted code
resumed with whatever FP rounding mode and flush-to-zero setting the
signal handler last installed. (regs->flags =3D 0 forces the FR/SZ/PR TB
flags to be recomputed, but fp_status is runtime float state, not a TB
flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
problem just fixed for the integer status register.

Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
into cpu_load_fpscr() and use it from restore_sigcontext() so the
rounding mode round-trips correctly across signal delivery.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by M=
agnus Damm.")
Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/sh4/signal.c | 7 ++++++-
 target/sh4/cpu.h        | 3 +++
 target/sh4/op_helper.c  | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index cc36425c49..00290d6e40 100644
=2D-- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -173,7 +173,12 @@ static void restore_sigcontext(CPUSH4State *regs, str=
uct target_sigcontext *sc)
     for (i=3D0; i<16; i++) {
         __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
     }
-    __get_user(regs->fpscr, &sc->sc_fpscr);
+    /* Resync the derived float_status state, not just env->fpscr. */
+    {
+        uint32_t fpscr;
+        __get_user(fpscr, &sc->sc_fpscr);
+        cpu_load_fpscr(regs, fpscr);
+    }
     __get_user(regs->fpul, &sc->sc_fpul);
=20
     regs->tra =3D -1;         /* disable syscall checks */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 4b0f3f6d97..3302702376 100644
=2D-- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -379,4 +379,7 @@ static inline void cpu_write_sr(CPUSH4State *env, uint=
32_t sr)
     env->sr =3D sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
=20
+/* Set FPSCR and the derived float_status rounding/flush-to-zero state. *=
/
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val);
+
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 669bc84cb6..cf0f80e4a5 100644
=2D-- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -204,7 +204,7 @@ void helper_macw(CPUSH4State *env, int32_t arg0, int32=
_t arg1)
     }
 }
=20
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr =3D val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) =3D=3D FPSCR_RM_ZERO) {
@@ -215,6 +215,11 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) !=3D 0, &env->fp_status);
 }
=20
+void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+{
+    cpu_load_fpscr(env, val);
+}
+
 static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
 {
     int xcpt, cause, enable;
=2D-=20
2.54.0


