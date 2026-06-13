Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5D3CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUeh-0005HB-Kp; Sat, 13 Jun 2026 16:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeE-0004fY-9X; Sat, 13 Jun 2026 16:08:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeB-0002En-Qj; Sat, 13 Jun 2026 16:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381069; bh=Wqggm+YI9CGOXrC37tB98c0M6KNUDE9ZIppSxjX+MCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I9pW3OrS0CEJJGmi0aTM7FMMDzA4bgCmNUWDGTxQPSsVEfIhtI/DpQxV/BaJmsQro
 cdljc1DUS4YgQrclKH/VCkaABmHq+pnx3p71r/xGbobiSbYOg6kHWwWFrMl972KQ9Y
 +RsM/J1OegTvZVZDU+qnbmO5UZCQy7vr3xyFRK3rN0RyZ4Adw+PfwrtjLNSrQq1XcN
 6GWCyrGG/ZfH33UtxH5ocBlhLp1cYgYyLLE5Kq626sHGE1x+IHgEkQzFtumwDeGLQE
 CemXaMjZ3VbgV60GHoAxY/qdbh6Gdaw+wKT/6J6iaoecCvraXB/f5YDRmrYoB6415B
 pYBuzY9xVwshw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5C50E1B6E8D;
 Sat, 13 Jun 2026 23:04:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B7A683CE8EF;
 Sat, 13 Jun 2026 23:04:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 37/61] linux-user/sh4: preserve T/M/Q bits across
 signal delivery
Date: Sat, 13 Jun 2026 23:03:20 +0300
Message-ID: <20260613200411.1808021-37-mjt@tls.msk.ru>
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

Traced on a deterministic rr recording: a cmp/hi set T=0, the timer
signal interrupted the very next instruction (a bf), the handler left
T=1, and the resumed bf took glibc calloc's MORECORE_CLEARS branch,
using the old top-chunk size as the clear length for a freshly split
small chunk and running memset off the end of the heap.

Fix setup_sigcontext()/restore_sigcontext() to use cpu_read_sr() and
cpu_write_sr() so the T, M and Q bits round-trip correctly, and drop the
BROKEN annotation on the sh4 signals test.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by Magnus Damm.")
Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6bf4c0295cccf74f3c5c0b674328b97d6fd1505c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index d70be24c38..cc36425c49 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -131,8 +131,10 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     COPY(gregs[14]); COPY(gregs[15]);
     COPY(gbr); COPY(mach);
     COPY(macl); COPY(pr);
-    COPY(sr); COPY(pc);
+    COPY(pc);
 #undef COPY
+    /* The T, M and Q bits live outside env->sr; fold them back in. */
+    __put_user(cpu_read_sr(regs), &sc->sc_sr);
 
     for (i=0; i<16; i++) {
         __put_user(regs->fregs[i], &sc->sc_fpregs[i]);
@@ -159,8 +161,14 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
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
 
     for (i=0; i<16; i++) {
         __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 7852fa62d8..b7a8737be0 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -3,13 +3,6 @@
 # SuperH specific tweaks
 #
 
-# This triggers failures for sh4-linux about 10% of the time.
-# Random SIGSEGV at unpredictable guest address, cause unknown.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN")
-run-plugin-signals-with-%:
-	$(call skip-test, $<, "BROKEN")
-
 VPATH += $(SRC_PATH)/tests/tcg/sh4
 
 test-macl: CFLAGS += -O -g
-- 
2.47.3


