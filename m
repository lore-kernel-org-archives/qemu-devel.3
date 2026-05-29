Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12849CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57d-00068w-OL; Fri, 29 May 2026 17:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57b-00067V-7d; Fri, 29 May 2026 17:52:03 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57Z-0007ZU-EY; Fri, 29 May 2026 17:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091506; x=1780696306; i=deller@gmx.de;
 bh=SSCUOdK3kHnYCbYGr73WYWLZgnAlsZTFEaClNXCa5XE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JYQCDBNqxb8oO7tB+wnp4/BAlnibkByfQqaTaGPVYaTIQxI5kFvGLKigJtARHxeh
 O50yZSi4OQ2IMr1lHAY7SwLsA2QuvblfyUdMDajN2ltTtzN/3dll/QVhY7u2305N4
 7dqVXUVA4LrQMHiPeBILDaB1BmAEfBpl3kvbSMQfeNKc+s8dKGmflxUSnsn54BxOa
 StKVHd1HsfESspRxxcJcc4HPffjLQS3iEA3mbf5hrLmmI7lB/heWhdxvZgcxy0zRX
 O2pcXnwzwf2REeQy4qoKwsmRoSZ3g8QM04G3RsZuYK/8TF3W4DJnnBck1pWDqLuzq
 T0oXtUX3ePvH3Ne59Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1x4Nre2l4N-00iY24; Fri, 29
 May 2026 23:51:45 +0200
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
Subject: [PULL v3 06/10] linux-user/s390x: restore fpu_status rounding mode
 from FPC on sigreturn
Date: Fri, 29 May 2026 23:51:15 +0200
Message-ID: <20260529215119.73244-7-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wlLhPYPWfVsIVeAMKCIffa22iqI5PCkeWktgYMvSagow+6m/GoY
 T1psliTOSBfu3T6tLSJBgfj4E8+BxVVBg6xFsDZiZEMJ6a3J/JPjgFW7YqRZ3ftx1k0dpsz
 jLFRzl3yOyLJSz8R36DjxBPqC2ogQp0We75y8IMZbeSB+4X2p6VEAqnp3yA3lo4BTu/8Ma2
 Nz2Zx7D8v+RJA+7uWCyAA==
UI-OutboundReport: notjunk:1;M01:P0:JbLRqwRv6XU=;e7dOQb2iuUYIFCMIkbaDgntfzK1
 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
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


