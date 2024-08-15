Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E7CC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnJ-0004Le-Sd; Thu, 15 Aug 2024 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn4-0003Wj-B2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn1-0000Di-T4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:26 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so15908381fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733362; x=1724338162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOj2cgvMvGGvvAwDFJY/i7+D7jI4xMnmqcjq9GVb3BQ=;
 b=hoIQySz3fOp8NAtyT23B9ad5O/YAHSJk3fA8ewT0NspYq7zvPaFVu6DClT6zjVcHLK
 37ayg7N9z8nr1+GDzOyJlUM/DbzqaZm8AkDT0STf6Fo9qf3uBb0BeAio6o2DBR9+rtRt
 icTid+lDZ2xHU9J7BXaHN+xnw4oB60CwLP2HEk4ckKdcBn/96Bc8Q3Or+DigU95RReHc
 /NCc9qX2xds1CVn0dbuM/f0S8eTlV1w2+piQZb4r+z16wpoIiTDzY9wSnWNcsIWBRb2B
 k3zTuZT5aC191x7H4inSBw5IQsyT+owaN4uE7QgH7lkzItfo/rKvF9VVQbG8qobN2Sy7
 CoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733362; x=1724338162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOj2cgvMvGGvvAwDFJY/i7+D7jI4xMnmqcjq9GVb3BQ=;
 b=OMDOLOIgmoa9/hyTzNV/w0zPDwFltXu0AjxzWldY7OAgKNrdEiXZrZjFRI2FWDT4/x
 ki0+xFIU18ZGsVlbYC8Rv06SrRY6ydh4wvzQUopldvW1KvNB9/KXWC3pSeqLl0+CVGg5
 as9aNcBdjPebn/p14xnbNKKvjD5BEC71l6HCNqTZCX+s2lZMfF++IdBCp3OHF7xQ2ysS
 xDgpLdqkljOSGxpWEzkMGTIjZ5lucYJ4VHAgvSkQhc+DyTZHSBJ/vhlVqwJfAynQ165f
 fj5gLXgEjIttJhb8XLbgDIAMqCwEqb6OQ4SfEej8g+ry15xJraw+4edSE6HmrXZm554c
 X6fw==
X-Gm-Message-State: AOJu0Yw1DdasYgKN8MbEnCuo7TvKBBSws/fn7C5Y5YjBfHalT2zrmSum
 FgNi7YZW1JN2eYl0j3BWo+EZYT4HCD8K1mReM9PirBxOn2pU/aP3KUH4pkDyIzw=
X-Google-Smtp-Source: AGHT+IHRt2mu9zgT2DnLwWUlbpdFU+rI3JPPqFqEql1LRzDDs3Fndaq7ZpPqLVBo2SV7ZaL9JYiLxg==
X-Received: by 2002:a2e:99d1:0:b0:2f2:9df8:e64e with SMTP id
 38308e7fff4ca-2f3aa1df09dmr42915991fa.11.1723733361248; 
 Thu, 15 Aug 2024 07:49:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383946441sm113194966b.148.2024.08.15.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA87C5FD74;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Subject: [PULL 13/21] Revert "replay: stop us hanging in rr_wait_io_event"
Date: Thu, 15 Aug 2024 15:49:03 +0100
Message-Id: <20240815144911.1931487-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Message-Id: <20240813050638.446172-6-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-14-alex.bennee@linaro.org>

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
2.39.2


