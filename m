Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5960C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnK-0004Np-DB; Thu, 15 Aug 2024 10:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn4-0003Vt-3j
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn2-0000Dm-2G
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so881407a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733362; x=1724338162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q14NFcjm+pOoVDQJIzMT7lWclsNqJbgHZCvrVMkJVPA=;
 b=X3hMY+d36VaFj6tWAMdcMu+SwliPV2N/R3jif1BlRK8EwqzBjHCp2RWqpC0IqgBUo1
 LyWtrPk4J18AH1D7giV2fDG9+qzNa1JV5hxvbQaDUwOe219HMKfdDlGfR6XyVi8ETWl1
 37S2KqbuuWelohA+DI444nB9QOCqJEKzROZLfPhGXTRD4/kByCv6t5lE0kOsHJDjXdY3
 AQRuDKcjqD2tVSuh2UYzFxYfpsa03UXjElQEYm72bhTbM6Mj/RPfbDQ7v2ZQ/x1c0DeS
 8Yl3PorN6bHGcsFSRmPz4qaxiCiiYFSv8fTWnPWIT56h+v+IyREv1/CTv3Mn+XvrBrDy
 l+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733362; x=1724338162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q14NFcjm+pOoVDQJIzMT7lWclsNqJbgHZCvrVMkJVPA=;
 b=vlxSTxTgtN0cmOe5TYKcSX4x2MjJM8xxJ8GDluvdGwpC+gMLFPPoHT2Uyy6LfmX44T
 F9j3W8j+i5/OUdenhwd4+4GjC+U5kiwU7Ywm/Snzvdqowj9FzGqjQp8ahQ5MYwDhUZoh
 cHJjuigAmIP5jK0iBKLJOZcGs2PEEKsouUhRdhYvmMWLuIMf4BY4r4kQ+KlPb4RrQNPT
 AGj6OvWSnWnb4KNESpifF1Z7gKuaYQ+F6nf9vX64Je1JP3CYb6cGetiSce1RFP6J03TR
 g03paBn6JgGEx+1GpCUvueMi+YhR+un39BPvJcWb7vgplLr4oR/ZoAvsBTcnAIQt5hTb
 1iUw==
X-Gm-Message-State: AOJu0Yzkbki2jKTyHNopZXySJu55j0zmSjnv5DUsml8cZHxzZNXjYdN4
 I8QEAa5eJDy6klzNUT4hKB/qbgHEPDJ3DrpnFFgWQCki73ynv/KrXCEQTF/9+Is=
X-Google-Smtp-Source: AGHT+IGSLzj0jLlcFFdgKGNL1moTkKTD+RSr8ZHkEKmu5ihEzUTw2aIQvSJ8nj1PR9CEijArGRGvnQ==
X-Received: by 2002:a17:907:e2d7:b0:a7a:acae:3419 with SMTP id
 a640c23a62f3a-a837ce46bc2mr294083166b.28.1723733362137; 
 Thu, 15 Aug 2024 07:49:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cf9c3sm112156966b.70.2024.08.15.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFDD85FD40;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Subject: [PULL 12/21] replay: allow runstate shutdown->running when replaying
 trace
Date: Thu, 15 Aug 2024 15:49:02 +0100
Message-Id: <20240815144911.1931487-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

When replaying a trace, it is possible to go from shutdown to running
with a reverse-debugging step. This can be useful if the problem being
debugged triggers a reset or shutdown.

This can be tested by making a recording of a machine that shuts down,
then using -action shutdown=pause when replaying it. Continuing to the
end of the trace then reverse-stepping in gdb crashes due to invalid
runstate transition.

Just permitting the transition seems to be all that's necessary for
reverse-debugging to work well in such a state.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-5-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-13-alex.bennee@linaro.org>

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index e210a37abf..11c7ff3ffb 100644
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
index c833316f6d..a0e2a5fd22 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -181,6 +181,12 @@ static const RunStateTransition runstate_transitions_def[] = {
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
@@ -188,14 +194,33 @@ bool runstate_check(RunState state)
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
2.39.2


