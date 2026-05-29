Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D0CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57K-000609-Kz; Fri, 29 May 2026 17:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57I-0005yT-Ir; Fri, 29 May 2026 17:51:44 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57G-0007Ta-Fc; Fri, 29 May 2026 17:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091499; x=1780696299; i=deller@gmx.de;
 bh=Xc00vLTGfB9GCkXWLG2d1pjuXzcuA7jsuGuy2MEi98Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Y9w6jZgN16UY0t1vDb0a7rmzRv2JmJ2gN+zl24lUnraTlI/0LnFNoSATSra8pLdm
 3WHCOu8GDd+Qq2WsTh+tlnDP8iT8E3tL3qMvU9YdUL5fzBz/Sxf06lCJnz+KBo4dk
 heryx510oOT41wtAd/lLkZotU09HFWgfJXAzrisV4pUiTQV2lr6k+iLCqU+a7d6kv
 3p3n48ww/kqefs6lXCUFovE6Qh93Zdzs3XwJ4PScr1i8YqNJHuwN2o1S7YlGRoKyf
 zUaoIHrS3qcpKsYNHs+DQ7gbbmCT6QphwzvbowdnJes/uDWFZIcQLYj+uFUSNP95y
 AiuV/cxirT54NjOdVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1wOQHp47Cl-002vk8; Fri, 29
 May 2026 23:51:39 +0200
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
Subject: [PULL v3 03/10] linux-user/sh4: preserve T/M/Q bits across signal
 delivery
Date: Fri, 29 May 2026 23:51:12 +0200
Message-ID: <20260529215119.73244-4-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jJC4jJBbAbREoT0+az6fUjBujh9eR9+Qv/4n7Ujxidm5MO5M0mi
 LAsWNRL2SjqjJaDq/OIZEB+qfqtBWU2fQ/l8ZJ8wBf/3uhIAIVqxEogpOSrHGsDVoAcJ+g/
 X6TEMQV9He9U97pvgzIZtJAA8qxBorKriBwln0Tcod06+SM5MMp8uIRioapFxQBDKDmryF9
 swnobfYOGTL4U0pBdFqZg==
UI-OutboundReport: notjunk:1;M01:P0:yMCCN017WOQ=;JB//cjI8by9QVgvs2CQZl5NzF/+
 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
 q8mCOreyhI7GdoqPyc=
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


