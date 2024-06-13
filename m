Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F25C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8o-0000fJ-9r; Thu, 13 Jun 2024 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8m-0000dq-MM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8k-0005pi-9D
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f70131063cso12235375ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299293; x=1718904093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4X1Q5LR9CyzMxkopn2wmWu6BnVGz6FW4Yqv/puuawE=;
 b=p2OrYXpR1HkR8nJzBJhXud+xUm70qYR/82yxBtfKTMA0VESxFhj56qzwWDkAxfKNtJ
 +Dgfb7OsSYJHoa3NpWewuw5B73NduD+MU9PlX06GlgbzJs/kV8EH3RRt6HLI7X7BS7fC
 uh3yJB6sQfXE1l96XK8cpZctWBsiDpfv5Np9aAJTEzCFP9Dk/MnA13/eOVlBhlaQA5i3
 NYizkRjqIL4Tvwcr0u8TmIRv54SDmlCCTZ3K293xLIIgxhpSDtoPbuAdyuVkP6n/Y2bq
 2BXqG14HzpUfDf7HsuJNjAE7Fc35KYgu5bLsJSZ0/pDaVfTbNDZdzDb5IJaZmdX/YvF0
 D7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299293; x=1718904093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4X1Q5LR9CyzMxkopn2wmWu6BnVGz6FW4Yqv/puuawE=;
 b=uuqq/OAB3qmAPQgGAqhAJoMf7bQ5qVyFBRpolMg1/05eDEMW/LoRErH+tsAMvQydYV
 d19fCbykw5KJEZhuv3buWIXnHfTU1ScgkbYEGCzyiq8BcfmdqhxJG8AHvzq+5zHrVsQx
 H2/YgF7N73F+/043kIBt8i+TP/UOSwGbaB1PIpbVniRS+qhBCcVfvVJFq+zzsUZAMyOI
 XzkApHNYptFXS7qJsXcBeJdvDjsFQp64laBxsrun06aIR6UfJmPDHMjY2jG9Fr1GBMUM
 +ft+lK5PFgWkImpkhg4FWlWoX+90DMEXEihc1tCgYNiy1477kNpI26yGUG242NZOrK7o
 4ebw==
X-Gm-Message-State: AOJu0YyEahZSdil0T0/wYZDjF5ELQPrLEPrcmpuQ4Unfph3d6AUtcRnC
 wHAswmgRfJn8eXTg1ElN546ilxObdUzgHVEdoALrTOuMElCWfCOstsATtU47VGeqL/YEL4MlXul
 L
X-Google-Smtp-Source: AGHT+IEJZimLwNKCk2RVUZo+iWQmCfWbpm1Awa0enFfC+T1lhos71YaT/CvSFlWQV+OdXVkZg3jWNg==
X-Received: by 2002:a17:903:2451:b0:1f8:52c2:3461 with SMTP id
 d9443c01a7336-1f8627da703mr3532695ad.30.1718299292657; 
 Thu, 13 Jun 2024 10:21:32 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:32 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 3/9] gdbstub: Add support for target-specific stubs
Date: Thu, 13 Jun 2024 17:20:57 +0000
Message-Id: <20240613172103.2987519-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

Currently, it's not possible to have stubs specific to a given target,
even though there are GDB features which are target-specific, like, for
instance, memory tagging.

This commit introduces gdb_extend_qsupported_features,
gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
to extend the qSupported string, the query handler table, and the set
handler table, allowing target-specific stub implementations.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c          | 59 ++++++++++++++++++++++++++++++++++----
 include/gdbstub/commands.h | 22 ++++++++++++++
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9ff2f4177d..e69cc5131e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1609,6 +1609,12 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
+static char *extended_qsupported_features;
+void gdb_extend_qsupported_features(char *qsupported_features)
+{
+    extended_qsupported_features = qsupported_features;
+}
+
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
     CPUClass *cc;
@@ -1648,6 +1654,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
+
+    if (extended_qsupported_features) {
+        g_string_append(gdbserver_state.str_buf, extended_qsupported_features);
+    }
+
     gdb_put_strbuf();
 }
 
@@ -1729,6 +1740,14 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     },
 };
 
+static GdbCmdParseEntry *extended_query_table;
+static int extended_query_table_size;
+void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
+{
+    extended_query_table = table;
+    extended_query_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_curr_tid,
@@ -1821,6 +1840,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
 #endif
 };
 
+static GdbCmdParseEntry *extended_set_table;
+static int extended_set_table_size;
+void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
+{
+    extended_set_table = table;
+    extended_set_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_set_table[] = {
     /* Order is important if has same prefix */
     {
@@ -1859,11 +1886,21 @@ static void handle_gen_query(GArray *params, void *user_ctx)
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
@@ -1878,11 +1915,21 @@ static void handle_gen_set(GArray *params, void *user_ctx)
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
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index dd45c38472..2204c3ddbe 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
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
-- 
2.34.1


