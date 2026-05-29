Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE1CD6E43
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDj-0002qG-DO; Thu, 28 May 2026 18:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDh-0002p6-54; Thu, 28 May 2026 18:28:53 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDf-0006u7-8S; Thu, 28 May 2026 18:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007325; x=1780612125; i=deller@gmx.de;
 bh=Xc00vLTGfB9GCkXWLG2d1pjuXzcuA7jsuGuy2MEi98Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=J3iup0751gfz9Wm3qJMMsQHzPHfd5dA56pGFARu0vh55H+ehnfHj3pDgetbXeCeD
 btRSncpFGTlfrLUVWFoNm61iGWIqJqObgpFP0gOOUaaiw3KmS0i92Wt26dcYPUoF9
 chui9u6lAc8jydQFF4FpJ80AVYx6PjVo/lPuc5jWRyDdQl0OPp9nBJZilBJPGg9TH
 l7plQpHpb6PK/uA3VbcmrKTFsPF/R4Si4fOvBfOm8aOKIJ/yOXvISkf1I752okXYJ
 AMQeJqq3T9oBMtr14OWEG70PzyDjgx2Bbk8Qmw57jP3ebDknVQPh7s4Z7M+5dh6FP
 m79I45NnPUzrvDNZrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1wn4SN1Tje-00RQnM; Fri, 29
 May 2026 00:28:45 +0200
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
Subject: [PULL v2 03/10] linux-user/sh4: preserve T/M/Q bits across signal
 delivery
Date: Fri, 29 May 2026 02:25:40 +0200
Message-ID: <20260529002548.19293-4-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MeMmQsjSWAThhV9htHj6EQ8iEZsVnIwtWPjfdONFKmkOTJLVKrh
 l/Fsx+vuDOvcBBpINub9aT6VQ/0ZtR1B1YJlvi+IEXUO0u8PMkqDKDnlZn8npnMJ9Y26R6r
 7ix/naet5lZYXiFTzOnY2Depsc7vDF6kFeLaqneyj69layZ4P7/nqqJxHY6DbCCC+D9gIw3
 hscT3cOy/xKQ2uK94LodQ==
UI-OutboundReport: notjunk:1;M01:P0:LRyspfaRCXA=;MFKwL07Pq5X2zTUkuEVuJSr0KDd
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

QEMU keeps the SH4 T, M and Q status-register bits outside env->sr, in
the dedicated env->sr_t, env->sr_m and env->sr_q fields; cpu_read_sr()
folds them back into the architectural SR value and cpu_write_sr()
splits them back out.

setup_sigcontext() saved the bare env->sr (so the T/M/Q bits were always
zero in the signal frame) and restore_sigcontext() wrote the value
straight back into env->sr without updating sr_t/sr_m/sr_q. As a result
the T bit was never preserved across signal delivery: on sigreturn the
interrupted code resumed with whatever T value the signal handler last
left behind. Any conditional branch (or addc/subc/rotcl/div1, etc.)
immediately following the interrupted instruction could then take the
wrong path.

This is the cause of the long-standing intermittent failures of the
tests/tcg/multiarch/signals.c test on sh4, which was marked BROKEN. With
a SIGRTMIN timer firing every millisecond across many threads, the race
was hit a few percent of the time and corrupted the guest heap, surfacing
as a SIGSEGV in memset, a malloc assertion, or an rseq registration abort.

Traced on a deterministic rr recording: a cmp/hi set T=3D0, the timer
signal interrupted the very next instruction (a bf), the handler left
T=3D1, and the resumed bf took glibc calloc's MORECORE_CLEARS branch,
using the old top-chunk size as the clear length for a freshly split
small chunk and running memset off the end of the heap.

Fix setup_sigcontext()/restore_sigcontext() to use cpu_read_sr() and
cpu_write_sr() so the T, M and Q bits round-trip correctly, and drop the
BROKEN annotation on the sh4 signals test.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by M=
agnus Damm.")
Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/sh4/signal.c       | 12 ++++++++++--
 tests/tcg/sh4/Makefile.target |  7 -------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index d70be24c38..cc36425c49 100644
=2D-- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -131,8 +131,10 @@ static void setup_sigcontext(struct target_sigcontext=
 *sc,
     COPY(gregs[14]); COPY(gregs[15]);
     COPY(gbr); COPY(mach);
     COPY(macl); COPY(pr);
-    COPY(sr); COPY(pc);
+    COPY(pc);
 #undef COPY
+    /* The T, M and Q bits live outside env->sr; fold them back in. */
+    __put_user(cpu_read_sr(regs), &sc->sc_sr);
=20
     for (i=3D0; i<16; i++) {
         __put_user(regs->fregs[i], &sc->sc_fpregs[i]);
@@ -159,8 +161,14 @@ static void restore_sigcontext(CPUSH4State *regs, str=
uct target_sigcontext *sc)
     COPY(gregs[14]); COPY(gregs[15]);
     COPY(gbr); COPY(mach);
     COPY(macl); COPY(pr);
-    COPY(sr); COPY(pc);
+    COPY(pc);
 #undef COPY
+    /* The T, M and Q bits live outside env->sr; unfold them. */
+    {
+        uint32_t sr;
+        __get_user(sr, &sc->sc_sr);
+        cpu_write_sr(regs, sr);
+    }
=20
     for (i=3D0; i<16; i++) {
         __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 7852fa62d8..b7a8737be0 100644
=2D-- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -3,13 +3,6 @@
 # SuperH specific tweaks
 #
=20
-# This triggers failures for sh4-linux about 10% of the time.
-# Random SIGSEGV at unpredictable guest address, cause unknown.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN")
-run-plugin-signals-with-%:
-	$(call skip-test, $<, "BROKEN")
-
 VPATH +=3D $(SRC_PATH)/tests/tcg/sh4
=20
 test-macl: CFLAGS +=3D -O -g
=2D-=20
2.54.0


