Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FA7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDl-0002s4-Lt; Thu, 28 May 2026 18:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDj-0002qF-Bv; Thu, 28 May 2026 18:28:55 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDh-0006uL-Ew; Thu, 28 May 2026 18:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007331; x=1780612131; i=deller@gmx.de;
 bh=SSCUOdK3kHnYCbYGr73WYWLZgnAlsZTFEaClNXCa5XE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=towmhOtvrjO0uQQ8QNb3ZUmXYw4FfAoX3lMPulF1Gg0DOWgpHzrZjogTi5ZP+xtk
 nwA+VBJbToos1zIcR8WPHpPghjDlFJ/SdtaOU1U/98iP9t1tJgLNo48nxweJeeTmE
 7Wbpt/wpDiY2T7ssIRo5v4s/QTmCz9Joxe/b30bZrOaYeOEpX32/URJrX67JZB4xM
 2XkC5jkSn3Gwm7oS+p3A+g8+yelkaphqGZukwdw7yjBEsZ/4FIdmJrJJR7sOotYxd
 AwfhKbX9p9FH2LvgIi7CeLbeV0ZhGyl69nYuBxpTFgzb44M8lx0Bo5XC3w+vvb5DT
 AIoxbDOM+R3v38xa8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1wwanX47Ez-00aKwd; Fri, 29
 May 2026 00:28:51 +0200
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
Subject: [PULL v2 06/10] linux-user/s390x: restore fpu_status rounding mode
 from FPC on sigreturn
Date: Fri, 29 May 2026 02:25:43 +0200
Message-ID: <20260529002548.19293-7-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lI13H5Beg9AzgyXznX56EtqeKo4+egXVi0CcB6zsEBuhjLYX41P
 ZzgN0Vj51/p1QhPIZlSipnUiHgmw4JcAzGJ506seNNqOuJ23ONgXcWXJm/L+4C3Oh6U15Lz
 +wU/4hR2ZqCuLA4eCv0xU6pnPzAj9dz8m3fWIjRGe/hmxvKFulTELObRpr3uARjFTuAWTsN
 mM8h1WBN8pWwE1f0Our2w==
UI-OutboundReport: notjunk:1;M01:P0:KK/t2R23oTs=;Wum7zW3XB7f8dGD9+LKUgrIpFTb
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

Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a sig=
nal")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/s390x/signal.c     |  6 +++++-
 target/s390x/cpu.h            |  1 +
 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index 96d1c8d11c..28ad80bde4 100644
=2D-- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, targe=
t_sigregs *sc)
     for (i =3D 0; i < 16; i++) {
         __get_user(env->aregs[i], &sc->regs.acrs[i]);
     }
-    __get_user(env->fpc, &sc->fpregs.fpc);
+    {
+        uint32_t fpc;
+        __get_user(fpc, &sc->fpregs.fpc);
+        cpu_s390x_load_fpc(env, fpc);
+    }
     for (i =3D 0; i < 16; i++) {
         __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
     }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3acbe83f0f..f55b79ef8a 100644
=2D-- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -895,6 +895,7 @@ void s390_init_sigp(void);
 /* helper.c */
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
=20
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 6ca0b7162b..107025e675 100644
=2D-- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -1087,6 +1087,19 @@ static const int fpc_to_rnd[8] =3D {
     float_round_to_odd,
 };
=20
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
+{
+    /*
+     * Mimic kernel fpu_lfpc_safe(): a corrupt signal frame value that wo=
uld
+     * trigger a specification exception instead results in FPC being set=
 to 0.
+     */
+    if (fpc_to_rnd[fpc & 0x7] =3D=3D -1 || fpc & 0x03030088u) {
+        fpc =3D 0;
+    }
+    env->fpc =3D fpc;
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
-    env->fpc =3D fpc;
-
-    /* Install the rounding mode in the shadow fpu_status.  */
-    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+    cpu_s390x_load_fpc(env, fpc);
 }
=20
 /* set fpc and signal */
=2D-=20
2.54.0


