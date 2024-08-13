Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054B9C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjkg-00012r-6a; Tue, 13 Aug 2024 01:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkd-0000xA-Jo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:19 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkc-0007oE-07
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:19 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db16b2c1d2so3819485b6e.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525636; x=1724130436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxC6+fJQNBcolqA9lH8im4XMAaTrrHgjAGNcvzMGa6U=;
 b=dQxgpSh++//e8TfyhagcEf+24JG6ol0EcIL1jrpnaj60iECmlG2Y6a7IG37yFx95Da
 gTplG5+K91Ay7h+iLzoTNSlfykxSlqWqgNPUn6wLYvLQTzHrvFX/5p7eqgiZKL/kB47l
 h+KHLB58NoNwDYccMPRzyTJ8Z0HgH3RkcH/fyOkfOyECh/QOmC14fgCzZ6kIm75Jmb5R
 ewqBZDuZ0dmmPWNcQ/G1/jymWo0omYMrUnbbEFZGJCUDQo9WiWTigD4+8TgYcgUhGBCK
 cZyqp/wosNHoVLJ+Sn0g1CwBGAAEGTIluZZWj/u+/iq6UlVPtq/s1uMT3p5viW5VBCuU
 Dp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525636; x=1724130436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxC6+fJQNBcolqA9lH8im4XMAaTrrHgjAGNcvzMGa6U=;
 b=RXpQfsCmYa3rcgm/2zXecQ48rZsTzzjzRzOBkV9X200WlItZ+mlVrEtA8jzLKak7DG
 jyoIdgILUOxODz3F1tiFuT68cPWC51elVtsJZb/ct3yuYxlCAHm6sjAt2keiVgmTiSfH
 i4jv/rUNIHznbcPglcFaoLQJ5U/YVdMH2Yk5CQKCVTFqAePRhmYnSqtyfT47nHL2JAzm
 9qvV0N7UIJ3hQZ0VfRUK8dUT0EedaZuNwe3N27xGaIr2kiOaNvUS6hyMOZ+vR+GXEygI
 ev0GEXwsezvH+dBXXq52iwzIY9nMtqXoy/kLB+MJrs55PZFwObjnnensx0GhQ2fKvRM4
 Hucw==
X-Gm-Message-State: AOJu0Yz1bh+qX31hwamGKQiqxjX3+jaRzE+U58dAtxOyQB1f+anqhkus
 dBr9FZb50M1LW3RlIy6h1HThkxljy6JTrZUU6o0fxoYqK0/Kjey/oPUBPYf6
X-Google-Smtp-Source: AGHT+IGbiSQryOgbRw+kc3oOTWDk5aa9I6/QRXAJxA4HBKKwqzEB52PFtnVosP0H6YVbDAznBCVAaQ==
X-Received: by 2002:a05:6870:a708:b0:260:fc49:3e96 with SMTP id
 586e51a60fabf-26fcb8a006emr2927601fac.46.1723525636367; 
 Mon, 12 Aug 2024 22:07:16 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:16 -0700 (PDT)
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
Subject: [PATCH v6 05/10] Revert "replay: stop us hanging in rr_wait_io_event"
Date: Tue, 13 Aug 2024 15:06:32 +1000
Message-ID: <20240813050638.446172-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Acked-by: Alex Bennée <alex.bennee@linaro.org>
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
index 48c38714bd..c59c77da4b 100644
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
2.45.2


