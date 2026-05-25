Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B562CCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXCh-000608-Es; Mon, 25 May 2026 11:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCf-0005zY-JW
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:53 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCd-00073a-VL
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:53 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7cb345cb5bfso76101067b3.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722811; x=1780327611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qvqScCwzZVAqBywuCMXx/NqxejVB6s7QovnQzogZffo=;
 b=CNP37Ygr0mrD1qHPkjJHObNSa2iH+ipQQlfoRHcSHZWIHYqntnfFN89Kwp0ePs1LGL
 wlcArES0wj4rLps6mlweTMGpH1oPdVwddF7KwGpe/vxmFTezlMwd/1oAXK6haAj4yNZt
 Q/K2EtO/AsEf6vJAfgBvvkHzOwovoSoqm1UcZHshlmFOfmRiofzO5nJ7yoGpocTzwUoc
 DNKDWQZYBsqDX6WXmA1Fn351nhsJj3Y/X8XfQcCtkbV2j1Rkhc0mtO071ETKHeiM6l+z
 g3aeNTycDESNgl67zW/DzZZoRiX6HQtCu3b8BG5RNfnKcTYgi8EksLRw2sV5fk/m9+ya
 mM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722811; x=1780327611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvqScCwzZVAqBywuCMXx/NqxejVB6s7QovnQzogZffo=;
 b=Z6aPMy4Z+Ii27BIx4UxZ2ICO0q4KDuPOZjhjofCK3uKQDh4/qTvYQYipmciDHqFvAw
 KisvoJUdykaSG/MaQMLWcP7O0fIe50yaNj5OqQfTAmc1zfu5xEbKbE0/a2TEfCzDQ3S4
 7LpQIdon0bUmW7nNcQzMFU1PxDuiKzhW4Oty9QAmYsRbFYHwsPm2/eFNoIxx93pqVL3/
 I3n/jsW1Bk5Owie7lbPuSwv1Ip3P2upYze0rZiqy0MfrlgBmDN2NYSTdBD3tluCLzPb8
 39QAlr/uTKj7agHAq7CZfp8CqQTZArwjAq0/LHZwz9a3rNuCZ8rdPQAXvtfxAa22V4W0
 n2kQ==
X-Gm-Message-State: AOJu0YwV8N/t7+lsR7S+1cFFavqSvhlqrzE6eF+5q2P0zU6jZb+E7DNZ
 9nax0QgrDLnTwgq5VAd40LMXU7UeasWCFMEcbXjfwaXdJ0dS/g3gJA5dRBOsdl/b
X-Gm-Gg: Acq92OHX1g2tnf/XJ0YXo9bS6ZDDwaZtX2fWwlLEYf3pzbCoiw0NPuckjosLBpQRldT
 RRU2mWZXBgWY1M9SiaWgRcdV5FFLNDR1wCYe9xbsETZcLy1Uo5/Wn2CSQcucQ8BRqgrcmXl4PUs
 HvZu2j7+LBcndeTSi4YkVsWQ8HEC0QY1kL7qMqPB/2AjTRPoQF2jVCqLdd54UxbtAssRl0zndWK
 lerCmHXIZK6iJywjNTFWofBlJWVgntX/VTahRHwSoiJ0OYZKD0A0VskxhDa+VRJ3LwIIGHwbf2X
 VOMWg/O5Yxt1vBi1JHUgtJvhvQnstK7MvQOwgo1NXqX7n1ghXDCZ4QKhz3TDL39+0XXDjzvujvA
 Qu/RmSb1lC3LNNLIFhpAvXVqoDi0Okm9QwdjWU5X1yq/Bvoj0AV7KG+F9012VjkiC/4DZmP9wBg
 3JWFWINN9Fy4//tYd/KYXTzSZ7822IL0RhB9DO1f3M0QhL8fHkkhBvkCzBPgLRD7I2rD2EkGDnS
 4DvDVFi5CDAew==
X-Received: by 2002:a05:690c:9a83:b0:7cf:d242:d963 with SMTP id
 00721157ae682-7d3376b8c62mr165767857b3.37.1779722810864; 
 Mon, 25 May 2026 08:26:50 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d38be31027sm47750887b3.28.2026.05.25.08.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:26:50 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/3] linux-user/sh4: preserve T/M/Q bits across signal delivery
Date: Mon, 25 May 2026 11:26:40 -0400
Message-ID: <20260525152642.4121729-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 linux-user/sh4/signal.c       | 12 ++++++++++--
 tests/tcg/sh4/Makefile.target |  7 -------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git ./linux-user/sh4/signal.c ./linux-user/sh4/signal.c
index d70be24c38..cc36425c49 100644
--- ./linux-user/sh4/signal.c
+++ ./linux-user/sh4/signal.c
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
diff --git ./tests/tcg/sh4/Makefile.target ./tests/tcg/sh4/Makefile.target
index 7852fa62d8..b7a8737be0 100644
--- ./tests/tcg/sh4/Makefile.target
+++ ./tests/tcg/sh4/Makefile.target
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
2.53.0


