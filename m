Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx6c-0000Us-3T; Tue, 26 May 2026 15:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6F-0000M3-8r; Tue, 26 May 2026 15:06:01 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6D-0004ba-Ma; Tue, 26 May 2026 15:05:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6A6C600AB;
 Tue, 26 May 2026 19:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161181F000E9;
 Tue, 26 May 2026 19:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779822355;
 bh=2NUQ5FfWOGem1CUHXmWxzCYzWNN2B5soNsg/vFqDPfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oGokoU6WBrdDSTBX5HduQ3NU8nI/7EohgU/Lye8N4/gDGGBunFmn4M5idzSl9SBnq
 nuX0cUWd3HD+A6jZUn7fTvEzRtKnDUYb9PtNiPzGCLKkU2FFPxwgjbFkbmVat1tkqe
 Y3nJ2mTG7+i3P8SIVON/F/AfcvaLDC+xIAppgbtt8vKgzHf0Nj7Fb1WB6huiPaxCXE
 8kogdgyZum0l3nDh1H9dXjy5XEag9/AQOJmBMsKJHaHT+B5cC7uTX0xS8xW3CWvPtj
 X+6tdLa0oaSLb9kpbf15//A6mTRlIBnhLfpb7W/nQcnWL82QeyQuIf0GgqUp4Xc77e
 SGXhy/ZoOurHA==
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
Subject: [PATCH 04/12] linux-user/sh4: preserve T/M/Q bits across signal
 delivery
Date: Tue, 26 May 2026 21:05:27 +0200
Message-ID: <20260526190535.10833-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190535.10833-1-deller@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
---
 linux-user/sh4/signal.c       | 12 ++++++++++--
 tests/tcg/sh4/Makefile.target |  7 -------
 2 files changed, 10 insertions(+), 9 deletions(-)

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
2.54.0


