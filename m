Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290BAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeB-0002Ty-IY; Mon, 11 Mar 2024 13:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjje7-0002SU-J6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjje3-0007IZ-5V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6277f72d8so3092554b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178859; x=1710783659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u895+LbS4NiKCuuM6UrCOG79P0KhuQg+ZEmtgS4/K2E=;
 b=MLS+tVtF8tnuE+Wfr9P1XDz8h1rLrSpRAXtrqzZvJ/41h1jsbiwixMAvib4Msgp4B5
 AtHpvyLbXsM06QzCHr2meK4DqOhcbPWmYHqz7Mr2YApmoAaEGmF49IcgFqUNaO2xQINx
 XKh7hdUW8CCEnMuGOo1mzz0nXXcN24hY5hniAnw2DfEZgn63DKCo3WTcT3rZeM/PwDxe
 DcbYfrw+9KjeqOtOk/WT9Od4b8I1xpgxL1k3jxqoJVTHakHqEWK6byLlnLb9Ymdp1Y7x
 9k0zQmqPGXASy2JkuTqdw3U0MK4+pnVrei6P/uB/7oMxVCSy6lX05WVk08l9tHkSeeqj
 wCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178859; x=1710783659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u895+LbS4NiKCuuM6UrCOG79P0KhuQg+ZEmtgS4/K2E=;
 b=pRlX5KHFaDiaJgYKfc43CGVD6UV7+QyrhaUbyK6WtLtahLKXWB0+CBFOhppz9LrE/8
 PZdK4c7YAU788he0qbEWh226Bykk6VshSy+pMM1AlQZ4NxKmFUxVjoaMWVa9f8mPWWxL
 +kagR46xPCGYuFTNwokKvNQw3qiolVFIE0PNk70wKUKXBkgCOdX7uR4a9hTSs594Omxd
 1+k6T3erYYeR1q3HpdnOA+Be8qicO1ozcsFrBnbsxgEphylr9mA6i0x1arQpJbIN2CMm
 aEmJazHZ6kpPNy/mUZtuxkZAR2WIfXJW0GdC6+cLyVN9IafEAEx8MrgJ+Qfd5Hei7Axn
 1YHQ==
X-Gm-Message-State: AOJu0YyEWeONnY/TMQWvkJj+K2tT3o/pRtgK/gYsotlwcCKryUJEDqVI
 mL1fC4nSNuWhuJJVfAspH2G92W5X5MIIi02XKePzSZVG93crdhtgE9kj10ee0QQ=
X-Google-Smtp-Source: AGHT+IEvJtFLwNk7l5adFSH5CStdqLWPWCyWd59X/ATmK8V3LZNvontfMQEiEZhm4Iuc33BGdrsHTQ==
X-Received: by 2002:a05:6a20:748e:b0:1a1:8ba3:500f with SMTP id
 p14-20020a056a20748e00b001a18ba3500fmr5491486pzd.31.1710178858883; 
 Mon, 11 Mar 2024 10:40:58 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:40:58 -0700 (PDT)
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
Subject: [PATCH v4 04/24] replay: allow runstate shutdown->running when
 replaying trace
Date: Tue, 12 Mar 2024 03:40:06 +1000
Message-ID: <20240311174026.2177152-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

When replaying a trace, it is possible to go from shutdown to running
with a reverse-debugging step. This can be useful if the problem being
debugged triggers a reset or shutdown.

This can be tested by making a recording of a machine that shuts down,
then using -action shutdown=pause when replaying it. Continuing to the
end of the trace then reverse-stepping in gdb crashes due to invalid
runstate transition.

Just permitting the transition seems to be all that's necessary for
reverse-debugging to work well in such a state.

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/sysemu/runstate.h |  1 +
 replay/replay.c           |  2 ++
 system/runstate.c         | 31 ++++++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4..fe25eed3c0 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -9,6 +9,7 @@ void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
 bool runstate_needs_reset(void);
+void runstate_replay_enable(void);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 
diff --git a/replay/replay.c b/replay/replay.c
index a2c576c16e..b8564a4813 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -385,6 +385,8 @@ static void replay_enable(const char *fname, int mode)
         replay_fetch_data_kind();
     }
 
+    runstate_replay_enable();
+
     replay_init_events();
 }
 
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860eca..8f9ee034de 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -182,6 +182,12 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE__MAX, RUN_STATE__MAX },
 };
 
+static const RunStateTransition replay_play_runstate_transitions_def[] = {
+    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
+
+    { RUN_STATE__MAX, RUN_STATE__MAX },
+};
+
 static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
 
 bool runstate_check(RunState state)
@@ -189,14 +195,33 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
-static void runstate_init(void)
+static void transitions_set_valid(const RunStateTransition *rst)
 {
     const RunStateTransition *p;
 
-    memset(&runstate_valid_transitions, 0, sizeof(runstate_valid_transitions));
-    for (p = &runstate_transitions_def[0]; p->from != RUN_STATE__MAX; p++) {
+    for (p = rst; p->from != RUN_STATE__MAX; p++) {
         runstate_valid_transitions[p->from][p->to] = true;
     }
+}
+
+void runstate_replay_enable(void)
+{
+    assert(replay_mode != REPLAY_MODE_NONE);
+
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        /*
+         * When reverse-debugging, it is possible to move state from
+         * shutdown to running.
+         */
+        transitions_set_valid(&replay_play_runstate_transitions_def[0]);
+    }
+}
+
+static void runstate_init(void)
+{
+    memset(&runstate_valid_transitions, 0, sizeof(runstate_valid_transitions));
+
+    transitions_set_valid(&runstate_transitions_def[0]);
 
     qemu_mutex_init(&vmstop_lock);
 }
-- 
2.42.0


