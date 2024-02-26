Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646ECC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWNk-0002Yd-GL; Mon, 26 Feb 2024 03:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNc-0002WZ-FF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:32 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNa-0005lN-U9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:32 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-599fc25071bso1912390eaf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936229; x=1709541029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QbQrwI7LbjDLb11lwT50wvHJ8OkZKMnnh3T95lKpRc=;
 b=H7HxTA8rUeal4gY21AzwlLeofDksIFGkgBy/yCnIjHiJ5UBU2xPSUXyZqjYYY+0Psn
 kIynUicomlat0rqGlcwK75U/T3vFnh85bGr7Y4C3a3ieb+jZObUAWEXhQdFa9rJL8s+D
 Il5+NA31bYmhs8A2PO2WQFtrdYpHTzspJTg6dwiu9QXKSlv5+Zbe7zAvjiePs2GHvUDn
 tpKHHQbfsQaQWj4eqSeQbaq5cwLG/qLmJz/WIPckcz/VC4qKX1TBLHJt8+xYRo+q48ag
 movRE51dbteB4LKfqvSeEmO3ubrU3pwBKYipTHTEczD5imte1LqxUM7ZxUD5nLuhlwe9
 6ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936229; x=1709541029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QbQrwI7LbjDLb11lwT50wvHJ8OkZKMnnh3T95lKpRc=;
 b=tr9df4BIq8fL3tb07cQX7gJlIwMONiRS7t+JrxEWIGl4By50PpjLbur9lBsBnQ4dFe
 xiW71YCZQltn892TNhi5ExJgEH3XGRjEzqJ6HGwg8M7gyyOj6jstkPKiCMdeAkiBAqaT
 Mnr/BmBAU+uCj3ZoHgX2zLQWhlYwu5/mPqby399ri+KDDBahwslbdl9xIOV9bl72ZFnP
 q1CYlQ/GiIoJXEPvK54sho7pub3kdp5gBbC7cbXGjgZzV3138JwkoXluLRVlJtps0j/s
 ydafMOOcsTR8TbkdkWzx6+uVELxUKeYmfHQR0O0gPWSdQoPJmYEOVm4vGndnnFy6lL0p
 81CQ==
X-Gm-Message-State: AOJu0YyGZZGlEVg4z785UYd4i6AGkBHA3MfaSgBrrPQTvlCKPCF8grkx
 qYmUIHY16LNTjs+1XSMAa1xE1QucyplSwQEcS71X+ETBtqBrBg4pTNIcTem0
X-Google-Smtp-Source: AGHT+IGYbP5g8Mpg/RzKsUpa05A47yO1tewdk2zxJH7PqgGhBRGoh6Mn0KFmhfnx2ZQblPAke5fJaQ==
X-Received: by 2002:a05:6358:1989:b0:17b:7ab1:22c8 with SMTP id
 v9-20020a056358198900b0017b7ab122c8mr7685570rwn.13.1708936228787; 
 Mon, 26 Feb 2024 00:30:28 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:28 -0800 (PST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 5/9] Revert "replay: stop us hanging in rr_wait_io_event"
Date: Mon, 26 Feb 2024 18:29:41 +1000
Message-ID: <20240226082945.1452499-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
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
index 2951eed3bd..ee2b979dfc 100644
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


