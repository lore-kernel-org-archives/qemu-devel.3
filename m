Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCh-0002mo-CZ; Mon, 18 Mar 2024 11:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCf-0002mR-Pn
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:09 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCa-0007rF-8B
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e675db6fbaso2634665a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776821; x=1711381621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKpzpXj/rNwSAlMipdDJMEvIfQrihazLg7YHWN/oksU=;
 b=cejnqJC2fZhv8J58rFo4uI5m97t+7z3PUOidixe6tBiXd8PC8pxm8Wem+JRviOGBhN
 dKMn2GYnVy9ssr3CiZnBQAorVsi+HsDZksFpnOkpQUxPCk6fYNqUDXTI9sB1ng4+EvFf
 YNlxFgd87x45ddJcqXMCFx+vkb5E5RSVtiRkMiEL5u5Mx/iXuPojTXy/V7K2Np2mJ7+P
 ANCLbwnNX+4BphHZkY20XVGk1AuZqR+C2OAGAHbTujjCeetyVh2GAGccfBTyzo0NZmLl
 6H8BWrCnwbzn4jvtVh2bNew8NGWnJ0TK18MzTOiyNBpM781HCVwfrIw0znvyj0uArb7G
 DRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776821; x=1711381621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKpzpXj/rNwSAlMipdDJMEvIfQrihazLg7YHWN/oksU=;
 b=o5Z71DQYPOcX9zoV2Kfps0a1jogAU2do46WxKwCUy37TWAg9Wi04B6r/KHWzBgaWCy
 4KazT8GQYAwRrmkrB+9TYYd/eB9z6N4ewd2kNU4q+LOVK54UZQpdhM3h3+PKly5I4MwR
 yiPCEHB+iS6irabbS/7UwRXWca+hYfFRaXbTi+11EiaLHUnWg7926/ZqhOyWmSVT24q3
 0MRcNhTxvwiWl96miNaWLxmrAaT2EG2xbUv50Yi7UEl5FIOXz4UAv4yS8pLDSwAgT2KE
 V2PGwQQa7Fpv0OPRmIOR+BHid/fQ/nn13D0SHHNZ1bisr866f9NEQZqpO3A8kAS0Estv
 svaA==
X-Gm-Message-State: AOJu0YwZ4ZHqT02/ZmmBFHXkH6oPl4NY4ySbYU0/Un59RJDR/uwcWXpm
 8aXtvxGqKuzCe9BBs9QDKnesCfG5BJeW4LYftQ55rA6FKtZB7eLn9XehRr50nNg=
X-Google-Smtp-Source: AGHT+IGkUFdHxsrsNruOAN0Rj049+O1vLPe/LU/3Vi7YHIKGXgOa9KqmeqwBpoJmTiLG/AdBaDHCNA==
X-Received: by 2002:a05:6870:418d:b0:220:941d:18be with SMTP id
 y13-20020a056870418d00b00220941d18bemr13353120oac.25.1710776821348; 
 Mon, 18 Mar 2024 08:47:01 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 05/24] Revert "replay: stop us hanging in rr_wait_io_event"
Date: Tue, 19 Mar 2024 01:46:02 +1000
Message-ID: <20240318154621.2361161-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.

That commit causes reverse_debugging.py test failures, and does
not seem to solve the root cause of the problem x86-64 still
hangs in record/replay tests.

The problem with short-cutting the iowait that was taken during
record phase is that related events will not get consumed at the
same points (e.g., reading the clock).

A hang with zero icount always seems to be a symptom of an earlier
problem that has caused the recording to become out of synch with
the execution and consumption of events by replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/sysemu/replay.h      |  5 -----
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 replay/replay.c              | 21 ---------------------
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f229b2109c..8102fa54f0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -73,11 +73,6 @@ int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
 void replay_account_executed_instructions(void);
 
-/**
- * replay_can_wait: check if we should pause for wait-io
- */
-bool replay_can_wait(void);
-
 /* Processing clocks and other time sources */
 
 /*! Save the specified clock */
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 894e73e52c..a942442a33 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle() && replay_can_wait()) {
+    while (all_cpu_threads_idle()) {
         rr_stop_kick_timer();
         qemu_cond_wait_bql(first_cpu->halt_cond);
     }
diff --git a/replay/replay.c b/replay/replay.c
index b8564a4813..895fa6b67a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -451,27 +451,6 @@ void replay_start(void)
     replay_enable_events();
 }
 
-/*
- * For none/record the answer is yes.
- */
-bool replay_can_wait(void)
-{
-    if (replay_mode == REPLAY_MODE_PLAY) {
-        /*
-         * For playback we shouldn't ever be at a point we wait. If
-         * the instruction count has reached zero and we have an
-         * unconsumed event we should go around again and consume it.
-         */
-        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
-            return false;
-        } else {
-            replay_sync_error("Playback shouldn't have to iowait");
-        }
-    }
-    return true;
-}
-
-
 void replay_finish(void)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
-- 
2.42.0


