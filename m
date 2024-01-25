Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA859C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2Hh-0006p3-Tj; Thu, 25 Jan 2024 11:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Hd-0006kT-Ju
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:08:53 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Hc-0000LQ-4Q
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:08:53 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cf6d5117f9so4026425a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706198930; x=1706803730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ83V6u3JjoeeV13hHMhpfCkNlbCNZFwOk7uKsoQQk8=;
 b=R7BEaC7B+4lN8ueXVTp1iV/kSqP0LkCgt7NVJBtgNlXshd8D5GNJ15QrOprlKSrjMX
 lVuDfqj8Hwqo3IPzPv8moJV42+G5Vr6TN1dCafcoGI4AYfUL1c4jUD8A9uvshsUX9d1b
 bO7CUUZO2lrIixTcgQxwT56ALrQnG309xN+h/MeInWtElaDoomN1a4MMTi1AS2tCYphb
 +p2j8UspmrRVGLh474iXaeCSvjlRtwWiv03orsnWsqCH+VeWAzBwsEjDXYtEwEq9I1ox
 K+UYZtKIJn2c11ELlE3yIuVYZvIXyEtTKbg8kvCpcLBnqXFu7BuFjd51Ok2Fyx4Pqpdk
 kWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198930; x=1706803730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQ83V6u3JjoeeV13hHMhpfCkNlbCNZFwOk7uKsoQQk8=;
 b=osMWaVoq5F5Qjmmp0ZTFoxiS2uKJWW3nWNiACEfMast8fNrkg9PrnRQnuKYYItpL7V
 nEpug6vaUUThlp9mdVy5e3hBWquavgenOmJsJk553Q9eT3HnhIbganT77DZEminIH+JK
 s0h11PPHlSo0SawnLS7Z6Ks19Hyg7O3wxG7NGrk2NcV07Aq4cJ+mRJGT9mf2nFY0OriX
 GH2QcS8HeH/Vg6yh8YR1BWfez82NjrsFJ4GVrYEFr0zuYdduqsiw4lQYt5HEnsBtx40h
 1bh8/+GofKRldcjyWbNti15j4IH+xzOYoC0uV7BqLhq28B1rPtXrefTFq5DcFpTEZnIY
 GuVw==
X-Gm-Message-State: AOJu0YxnQ0iX1/INt8DbBovTUlU7JQVfhsDIA3xHGTNVHgZF/0lkQsM0
 NqsPJMaW3iQn+j924RJq0QLl0KEqgLAA9lgxsZuPKqxUa6kc3JYn0OVXQ9u6
X-Google-Smtp-Source: AGHT+IGnpf/EMqVVaDkzyvRuvSPQDS3JC94doqdKlZqcM3tX4d9JgJltw7QaxVQBrRJLPS75wIs07w==
X-Received: by 2002:a17:90b:3711:b0:28f:f728:c3f4 with SMTP id
 mg17-20020a17090b371100b0028ff728c3f4mr829646pjb.72.1706198929781; 
 Thu, 25 Jan 2024 08:08:49 -0800 (PST)
Received: from wheely.local0.net (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b00293851b198csm14190pjb.56.2024.01.25.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:08:49 -0800 (PST)
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
Subject: [PATCH v2 1/4] replay: allow runstate shutdown->running when
 replaying trace
Date: Fri, 26 Jan 2024 02:08:32 +1000
Message-ID: <20240125160835.480488-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125160835.480488-1-npiggin@gmail.com>
References: <20240125160835.480488-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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

When replaying a trace, it is possible to go from shutdown to
running with a reverse-debugging step. This can be useful if the
problem being debugged triggers a reset or shutdown.

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


