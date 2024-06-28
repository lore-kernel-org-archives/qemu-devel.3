Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA5BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAxx-0006nV-T1; Fri, 28 Jun 2024 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwr-0004wK-1m
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:32 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwh-0005k5-FA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:28 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e7d2278d8so719600e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578592; x=1720183392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QedgY3rQrh3/N+Rjk6g1alJFiDBF8+JfOXizag4FY8E=;
 b=vhU2/PG+w1b9OZBPuWHPVUh9BF+G37n9XLACFR6JgeQGrvrGYnYblAe2Zbqh4WxUfd
 JU64OxZsxRS5hopFo19wb/N4nP/lc1cDOkQF77/9x9+Oynca6r7d+loA1EfN5UCc+Nvc
 xWKxTY65Zjyick7rkK/WQCumNpD0zQkWhnKJizdbHQ7UvyTw/ecBbSCGPFEx9htsdTA2
 8vfE8D20GDEcK60ka75WKZeqf43+sX3mWB7D1eIfsr8WcxCH7VtomEV8UUPjesbtvi+I
 J8DV/btTheqpvZ+2LR+uEIdueCtWJd8arBKtjG99PaN66OWVYMhJaTJl8NHrjMf7gAUH
 9ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578592; x=1720183392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QedgY3rQrh3/N+Rjk6g1alJFiDBF8+JfOXizag4FY8E=;
 b=PVpvLxp8NP69n/SP1wxYC/+BGew+AItB3zNF0XBahj/eWCowaqpxK1LW/HP/YHOPFQ
 K7faVRCNYe9pWwdtNRQaxWWCzU5gzO/lvYL6cU4VwS7YmIfEo7ZZUNZt8wEkTyEdglX7
 isd+O7CrKDi8sahs2kgKMEQ551/VycwnjJxAK36YHPYYllIOO35UGSm129HRJB2rQO71
 T0TWQyTp+4A3VAehwsw4wm8Bs9d7fCGwtMKP4o2A23thryk9IWf90EwSRrlNoC0BKu2T
 OIeHOfDbzvyCk3vmMiBiwJ29XDcfR+uvNIeycHcYV9zCWosNnDCzqwlqzVI+bwE0+d/G
 8VaQ==
X-Gm-Message-State: AOJu0YypDtOFr8GasdyV/WVHomjpL94YlymhXkwPCwr2MEnKuGn0qHk8
 9rPPRHgiROE6p8vbBh+AK9S+ep2DrZL/iH0UQAjRtLaSHWJMcbqdBm4t1WSqu6s=
X-Google-Smtp-Source: AGHT+IEwUX9PV2BOxISxk8j+C0LpKSigGbqwdTvEIza5HAZ8ML0n0Y+IMVPREkd7gSzM5T2O7F9rHA==
X-Received: by 2002:ac2:5609:0:b0:52c:dea7:f0db with SMTP id
 2adb3069b0e04-52ce1832b34mr12008345e87.23.1719578592259; 
 Fri, 28 Jun 2024 05:43:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d138sm76428566b.158.2024.06.28.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72EE85FA3C;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 15/23] gdbstub: Add support for target-specific stubs
Date: Fri, 28 Jun 2024 13:42:50 +0100
Message-Id: <20240628124258.832466-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Currently, it's not possible to have stubs specific to a given target,
even though there are GDB features which are target-specific, like, for
instance, memory tagging.

This commit introduces gdb_extend_qsupported_features,
gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
to extend the qSupported string, the query handler table, and the set
handler table, allowing target-specific stub implementations.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240628050850.536447-4-gustavo.romero@linaro.org>
---
 include/gdbstub/commands.h |  22 ++++++++
 gdbstub/gdbstub.c          | 102 ++++++++++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 639257493e..306dfdef97 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -69,4 +69,26 @@ typedef struct GdbCmdParseEntry {
  */
 int gdb_put_packet(const char *buf);
 
+/**
+ * gdb_extend_query_table() - Extend query table.
+ * @table: The table with the additional query packet handlers.
+ * @size: The number of handlers to be added.
+ */
+void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
+
+/**
+ * gdb_extend_set_table() - Extend set table.
+ * @table: The table with the additional set packet handlers.
+ * @size: The number of handlers to be added.
+ */
+void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
+
+/**
+ * gdb_extend_qsupported_features() - Extend the qSupported features string.
+ * @qsupported_features: The additional qSupported feature(s) string. The string
+ * should start with a semicolon and, if there are more than one feature, the
+ * features should be separate by a semiocolon.
+ */
+void gdb_extend_qsupported_features(char *qsupported_features);
+
 #endif /* GDBSTUB_COMMANDS_H */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9ff2f4177d..b1ca253f97 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1609,6 +1609,20 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
+static char *extended_qsupported_features;
+void gdb_extend_qsupported_features(char *qsupported_features)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert the feature strings are the same on all CPUs, or is set only
+     * once (1 CPU).
+     */
+    g_assert(extended_qsupported_features == NULL ||
+             g_strcmp0(extended_qsupported_features, qsupported_features) == 0);
+
+    extended_qsupported_features = qsupported_features;
+}
+
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
     CPUClass *cc;
@@ -1648,6 +1662,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
+
+    if (extended_qsupported_features) {
+        g_string_append(gdbserver_state.str_buf, extended_qsupported_features);
+    }
+
     gdb_put_strbuf();
 }
 
@@ -1729,6 +1748,41 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     },
 };
 
+/* Compares if a set of command parsers is equal to another set of parsers. */
+static bool cmp_cmds(GdbCmdParseEntry *c, GdbCmdParseEntry *d, int size)
+{
+    for (int i = 0; i < size; i++) {
+        if (!(c[i].handler == d[i].handler &&
+            g_strcmp0(c[i].cmd, d[i].cmd) == 0 &&
+            c[i].cmd_startswith == d[i].cmd_startswith &&
+            g_strcmp0(c[i].schema, d[i].schema) == 0)) {
+
+            /* Sets are different. */
+            return false;
+        }
+    }
+
+    /* Sets are equal, i.e. contain the same command parsers. */
+    return true;
+}
+
+static GdbCmdParseEntry *extended_query_table;
+static int extended_query_table_size;
+void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert query table is the same on all CPUs, or is set only once
+     * (1 CPU).
+     */
+    g_assert(extended_query_table == NULL ||
+             (extended_query_table_size == size &&
+              cmp_cmds(extended_query_table, table, size)));
+
+    extended_query_table = table;
+    extended_query_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_curr_tid,
@@ -1821,6 +1875,22 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
 #endif
 };
 
+static GdbCmdParseEntry *extended_set_table;
+static int extended_set_table_size;
+void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert set table is the same on all CPUs, or is set only once (1 CPU).
+     */
+    g_assert(extended_set_table == NULL ||
+             (extended_set_table_size == size &&
+              cmp_cmds(extended_set_table, table, size)));
+
+    extended_set_table = table;
+    extended_set_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_set_table[] = {
     /* Order is important if has same prefix */
     {
@@ -1859,11 +1929,21 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
-                            gdb_gen_query_table,
-                            ARRAY_SIZE(gdb_gen_query_table))) {
-        gdb_put_packet("");
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           gdb_gen_query_table,
+                           ARRAY_SIZE(gdb_gen_query_table))) {
+        return;
+    }
+
+    if (extended_query_table &&
+        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           extended_query_table,
+                           extended_query_table_size)) {
+        return;
     }
+
+    /* Can't handle query, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_gen_set(GArray *params, void *user_ctx)
@@ -1878,11 +1958,21 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
-        gdb_put_packet("");
+        return;
     }
+
+    if (extended_set_table &&
+        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           extended_set_table,
+                           extended_set_table_size)) {
+        return;
+    }
+
+    /* Can't handle set, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_target_halt(GArray *params, void *user_ctx)
-- 
2.39.2


