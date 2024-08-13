Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E49C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy43-0006pa-9v; Tue, 13 Aug 2024 16:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3r-0005vo-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:08 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3R-0006EM-Tf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:04 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so79078591fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580620; x=1724185420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKnLVSpjxmewuCirNFwcFUTWuBBv0LU3PKhxtt5azvQ=;
 b=AUVma06k0D8LMAdpY2jTxZD4+BGXaRJgh52JGrvItXso7Lp47bgkyyT7EYRSGDy7+h
 hOfz/j//uHvnYMqrYnUy4GYCIe75u0vfXYmlSKlH/CXhBJTGr0oBUN0J/r/trrg5oTvL
 StuM26nUzdGUNELGrVR4va3pzAJZcx4hIpPbH9vj4QPGmel/ksuzzH/eX6KMi/Jio8mB
 8jNxuswa6YlDQ2UQkeqcS/2aY+N2Aq8CI9zpcrXLDjwsEl3lwB0YbGeg7r+UpnMI166b
 rzkwI86Wg7MopZZo1+2OVQK1FOZfuoDVdjJdt+1xlCtQNJ6NSWPFMLWdM7beOxxumh3/
 H9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580620; x=1724185420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKnLVSpjxmewuCirNFwcFUTWuBBv0LU3PKhxtt5azvQ=;
 b=buvlBkOVThyCywVx4838wxU1QGMHfCsiaGafa2ei8NyiDXD/0e8OeHWyrEdwi40XZ0
 ZWv9b8F5RxKcJEaXDq8GzKf8VvNm+qF48aQKUHVRt8iHdKQ4eWCYWpG7dGVXGtdYRD0C
 kPEOun6c33ryXyUv0yytNG2SRcPmrJEHcRNe4LzhNOOJd1M1QZpHm6v6I8utpUHVYBnM
 NukjU+zONDtQbOOMyNQuGpbbLkpe7QGMwDMzsBUGiEhmPvqb2jzXpVglJt3Rb5KA/qzP
 m/3s+uk5OeMCxRmjhkAPPX7CBn/cFgLlIpu4/KGLd1YYe4qESmRZC+hErkWY+wHeatDn
 S6NA==
X-Gm-Message-State: AOJu0YxoP2n2R7dPymSNjwx7x8CoXYqxUTk9WLNbIv7YIXccWObNbPMx
 v/zAWaFi8eILkU8lVjhed5nDnL9QHsG59uA0lBxusZMDK8LIomIHdIzasZkw05w=
X-Google-Smtp-Source: AGHT+IEJM7GCjG6FXle0qtVKynHXGKsll+H0P8kU2TbGzKLAw57ANQNr6l0i2885LCsZ/JHq16ex3w==
X-Received: by 2002:a05:651c:19ac:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f3aa1d9de7mr3336041fa.2.1723580619507; 
 Tue, 13 Aug 2024 13:23:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429deb4a4aesm893215e9.14.2024.08.13.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B99B5FCF1;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 12/21] replay: allow runstate shutdown->running when
 replaying trace
Date: Tue, 13 Aug 2024 21:23:20 +0100
Message-Id: <20240813202329.1237572-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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
---
 include/sysemu/runstate.h |  1 +
 replay/replay.c           |  2 ++
 system/runstate.c         | 31 ++++++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

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


