Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B37C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWNb-0002T5-4y; Mon, 26 Feb 2024 03:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNW-0002Qg-45
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNU-0005iV-EL
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:25 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc09556599so24259035ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936223; x=1709541023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQuCe4WHCbklHlT19DTaQUw/vc5/AugcEjGjIpSmyJk=;
 b=VkopBpRfcB3vV4GKmQSISWbSJrCOcQnJxdoGTgsiI4fmFR5iPhbeCeDsZH/PEO8nP+
 cFt+tN2h2G3wXyT8QyigDOOz0PFM1vGG1IILr7t4oUPQy/pNv/AUydz4lp8tqGYOBgsC
 sATaYUpBUjcFuZmFG3tbnwn+N8mKA3zzq1nDjGZ+jK6/BKzipZ9ISriYnDig8R8Dvu/G
 1D4HI0nRznEt11L11WpCIDZrTJ9T/401MIC6/QjPcqBUf+Dj4Ojtrj+zXx9QL3PYrVEC
 i/47q8FjmBNrdgWyDpczu8FUH9zcda+VoCkKQ47GQ/gRS59BPkG9+/IW9on2U0T5DYEQ
 G52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936223; x=1709541023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQuCe4WHCbklHlT19DTaQUw/vc5/AugcEjGjIpSmyJk=;
 b=It/nbBWGhPOTz3GjsAqupsTbzeNW+y26N7yDoaS4tffJBTYKSKVYBlRdZd4HzBEocN
 WHlTsxGU5LMG/EX3+B2RkDjhHtR0BlIKhc2ezxycpW9ee3gIwQeJu1JnEYagxeck3fCJ
 XLYphm39cCBhnNW7g9i4ZSdd/vqZZOyLHO/iB/xJudC3DP/oscu2rg3sZ78bV47zpYs8
 7qinqcaYWM3E7SWew+3deI08AD/5F6TtLX+XuiyCGA3bK+kKUffJWHy4gO9g60A7s+Gg
 BvZ+tk4CNAf8wk6KeDW6B4CE8FefN14+4vN3UVBunMgFR7u+o+qZhxGsZDA3t+q9uxJ8
 Lzig==
X-Gm-Message-State: AOJu0Yxw3pX/xUjDxBi343Fw0HaZcdsy56Kl+9U1mnRF+mwESWnt8JaP
 Y06zWGdauJITPnIEkzC1KVeSb36bSVMLlIgIItCNObrDnJZduTliTRsMWwnb
X-Google-Smtp-Source: AGHT+IFHPAJZZbd282Gn6yrVKd0J8Ika6JlAfhK8qRmTVQsLfph7xSVpChW59Uyn6Vvg++JDy0ndHQ==
X-Received: by 2002:a17:902:ef48:b0:1dc:8eba:42c3 with SMTP id
 e8-20020a170902ef4800b001dc8eba42c3mr6740617plx.23.1708936222765; 
 Mon, 26 Feb 2024 00:30:22 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:22 -0800 (PST)
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
Subject: [PATCH v3 4/9] replay: allow runstate shutdown->running when
 replaying trace
Date: Mon, 26 Feb 2024 18:29:40 +1000
Message-ID: <20240226082945.1452499-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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
 system/runstate.c         | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

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
index 3fd241a4fc..2951eed3bd 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -383,6 +383,8 @@ static void replay_enable(const char *fname, int mode)
         /* go to the beginning */
         fseek(replay_file, HEADER_SIZE, SEEK_SET);
         replay_fetch_data_kind();
+
+        runstate_replay_enable();
     }
 
     replay_init_events();
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860eca..bd0fed8657 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -182,6 +182,12 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE__MAX, RUN_STATE__MAX },
 };
 
+static const RunStateTransition replay_runstate_transitions_def[] = {
+    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
+
+    { RUN_STATE__MAX, RUN_STATE__MAX },
+};
+
 static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
 
 bool runstate_check(RunState state)
@@ -189,6 +195,19 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
+void runstate_replay_enable(void)
+{
+    const RunStateTransition *p;
+
+    assert(replay_mode == REPLAY_MODE_PLAY);
+
+    for (p = &replay_runstate_transitions_def[0]; p->from != RUN_STATE__MAX;
+         p++) {
+        runstate_valid_transitions[p->from][p->to] = true;
+    }
+
+}
+
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.42.0


