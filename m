Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998CAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnI-0004E2-3e; Thu, 15 Aug 2024 10:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn5-0003aR-8F
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn2-0000Dr-Cm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:26 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7aac70e30dso120862566b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733363; x=1724338163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGNwWa3S5TX7tw+jVxHwopux+SCGaD9vnHCk/doezEQ=;
 b=TEradAnQNc2vat9wviJ0YlSOR+iYRNK5Md2UgbZ2CGu4ikk0fsM5iS1IwZuOUMpVDs
 s1wCAuL+1IWS0JbCnS99fJ4BzqSBEAdCtX9blWUpm5fxL5w6IGxv1dNijYTxGkZYEeYi
 bReg9k+Yvlcfpe5RLmrJdJ+C4xxFmb7+BTD+8YAlGbKzUSRzhKKY4xSq2bM3GO1YRGu8
 sftTUXw39akPMU8ZP17NF/Ie+18Cofx6jri4jbwFT50hir7i7pgER5L7dnThl6Psif7j
 JYaPEdlKjC0GWITM1b6RZU1qLj2M7aweKsA/k874a5DXnzd+hlv8A6NezVR7c1Q2+CSC
 Idsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733363; x=1724338163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGNwWa3S5TX7tw+jVxHwopux+SCGaD9vnHCk/doezEQ=;
 b=tuswgPRJrqRA6zICxyTD8YE5rU3fVh7MX2VwVDutwJBopvm54pbNHI7MkvYTb4d9v/
 +BqQNZHHYeNs6ig1skV75hC1EkicS1bGKWkeNDhfhD7BwAzpZC1TFJm8cqvcrjGsBILz
 AfuHGDkkei1/zLCA1mqHNxUtmNJcEbeB3OpuGxrPhRI2qCpL6mmdTYK0QfNkRpyUmqO8
 G1uzIW9lpfOvnGYxESwBI6XURhLxqy4h66kMKwzQZDhl2U1YlphJGRagKwQQqMP5Lmcg
 a9wbWZ+w+RVL4DQPxMxrdrsd3jF9AnxbrQ8C0Ho6FQ8VANiO7CEH3x3F/vaBR7737DYz
 FU9g==
X-Gm-Message-State: AOJu0YzuixN3NxeQppnajZ5zvy5vYdmhsryW6T4L4CvqltqpvUxIZPP6
 J8tt+SMM8guz+keOSZDpOJGcAxJUmvUypaT8Xue+AkuozQidBZJvk4mBPVTtCOzlUrWu1ubSU8g
 6
X-Google-Smtp-Source: AGHT+IFG+JYdR8k28AF8t9wmxtN9aFr6ywujt3U9J0/xHVK7QUhooazY37v4RAVC7Hfg0OThu1yHbQ==
X-Received: by 2002:a17:907:d58f:b0:a77:d7f1:42eb with SMTP id
 a640c23a62f3a-a8366d396ebmr495271366b.23.1723733362446; 
 Thu, 15 Aug 2024 07:49:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cefe0sm112307466b.47.2024.08.15.07.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B35ED5F8ED;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 21/21] plugins: fix race condition with scoreboards
Date: Thu, 15 Aug 2024 15:49:11 +0100
Message-Id: <20240815144911.1931487-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

A deadlock can be created if a new vcpu (a) triggers a scoreboard
reallocation, and another vcpu (b) wants to create a new scoreboard at
the same time.

In this case, (a) holds the plugin lock, and starts an exclusive
section, waiting for (b). But at the same time, (b) is waiting for
plugin lock.

The solution is to drop the lock before entering the exclusive section.

This bug can be easily reproduced by creating a callback for any tb
exec, that allocates a new scoreboard. In this case, as soon as we reach
more than 16 vcpus, the deadlock occurs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240812220748.95167-2-pierrick.bouvier@linaro.org>
[AJB: tweak var position to meet coding style]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240813202329.1237572-22-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index 12c67b4b4e..2897453cac 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -214,30 +214,49 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
 
 static void plugin_grow_scoreboards__locked(CPUState *cpu)
 {
-    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
+    size_t scoreboard_size = plugin.scoreboard_alloc_size;
+    bool need_realloc = false;
+
+    if (cpu->cpu_index < scoreboard_size) {
         return;
     }
 
-    bool need_realloc = FALSE;
-    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
-        plugin.scoreboard_alloc_size *= 2;
-        need_realloc = TRUE;
+    while (cpu->cpu_index >= scoreboard_size) {
+        scoreboard_size *= 2;
+        need_realloc = true;
     }
 
+    if (!need_realloc) {
+        return;
+    }
 
-    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
-        /* nothing to do, we just updated sizes for future scoreboards */
+    if (QLIST_EMPTY(&plugin.scoreboards)) {
+        /* just update size for future scoreboards */
+        plugin.scoreboard_alloc_size = scoreboard_size;
         return;
     }
 
+    /*
+     * A scoreboard creation/deletion might be in progress. If a new vcpu is
+     * initialized at the same time, we are safe, as the new
+     * plugin.scoreboard_alloc_size was not yet written.
+     */
+    qemu_rec_mutex_unlock(&plugin.lock);
+
     /* cpus must be stopped, as tb might still use an existing scoreboard. */
     start_exclusive();
-    struct qemu_plugin_scoreboard *score;
-    QLIST_FOREACH(score, &plugin.scoreboards, entry) {
-        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    /* re-acquire lock */
+    qemu_rec_mutex_lock(&plugin.lock);
+    /* in case another vcpu is created between unlock and exclusive section. */
+    if (scoreboard_size > plugin.scoreboard_alloc_size) {
+        struct qemu_plugin_scoreboard *score;
+        QLIST_FOREACH(score, &plugin.scoreboards, entry) {
+            g_array_set_size(score->data, scoreboard_size);
+        }
+        plugin.scoreboard_alloc_size = scoreboard_size;
+        /* force all tb to be flushed, as scoreboard pointers were changed. */
+        tb_flush(cpu);
     }
-    /* force all tb to be flushed, as scoreboard pointers were changed. */
-    tb_flush(cpu);
     end_exclusive();
 }
 
-- 
2.39.2


