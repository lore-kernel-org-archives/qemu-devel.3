Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94484C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqq8-0005fa-Jt; Mon, 22 Jul 2024 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq6-0005Wt-DN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq3-0002RR-VB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso3503326a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646258; x=1722251058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOA3flkzKrxX9n6zT74lJ3BeaHTQSwskXB32JdvIhZs=;
 b=QhM0veX8fSgUxwxhg5YMau6mnPPsLjAnW+z/M+us9jjv/w7+2wSHgcPhgg7upI8mce
 rq/YiG4+p0oAJEx7FlhStyGoIsmOuuc2pNOBLa5zW61ut4MNKdgcTGdZIHvY485hWpxc
 QS8ljbbUG8skwIMWqVsnYxR68gTlIqlwWtzW9k5uzk8JJuwQR2IxoYeBt8YT3/bYUlf/
 zGS8zUJ3mNE1vvjw9pVMXyGmGd1Gc3Ewe/9EoeHT2CGTIcV9g2QmJRCIFPCtTcsN3qQN
 jVm+v49D8fboe7zD97HzH6tUg2IEt3TceEF/HfyEoxasPCCLuZAq5u4CgOWdi9RyAhJH
 D+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646258; x=1722251058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOA3flkzKrxX9n6zT74lJ3BeaHTQSwskXB32JdvIhZs=;
 b=ajuan/lhOSBJ6pz5bI37a9bLmu4gW4IFp5MS0sXS1NK6okyWUsng9RR3FZsTdTdb6d
 zKP5rNb4EKqMNafnAW2h+5oKhBFNG2XU8wQh+y/C9Ifhcbsxhzk9mSLGET7wUd32d7H6
 gkq98LYf+6dc3gjug/41kBkwwr7AZH/RRFlGxalFv1I7YJcOkw69gxuU2VtrNG3bwuTT
 neV3n5RJQT1YAPbGySG9gfzKU0TeYNNY28Y5tPjBrs5+I8sExDmJmoO8Y4OlTfB68WIM
 664LjwqCizH+8pYH9i9+vWarmNC4w6+hLAOGlb2IJGGjVDP+euoH0d6OJ83ZXs9EYhJb
 dZXw==
X-Gm-Message-State: AOJu0Yy/XJxQnxvcpK8NL3igpiGKRM4/WFn0T5MeI0ZAC+AIXNucpRSI
 tKPfg30uSewHTNJlUA57Stclm06FDWQgSg4qf70Q6zIu5Oq2FioTqwNIz9myrUn5wo5k07rxoos
 u
X-Google-Smtp-Source: AGHT+IGVLOhEQeK01aG49QrEXTjXQSPg+hsRCMjLIQbKbEly9C+xvQxfjxkuHRzn+Tyas2t1SDSuow==
X-Received: by 2002:a17:907:968e:b0:a6f:1443:1e24 with SMTP id
 a640c23a62f3a-a7a4c0f43edmr470180166b.34.1721646257932; 
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c922d15sm412555266b.168.2024.07.22.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9CDF5F948;
 Mon, 22 Jul 2024 12:04:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 03/16] gdbstub: Re-factor gdb command extensions
Date: Mon, 22 Jul 2024 12:04:00 +0100
Message-Id: <20240722110413.118418-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Coverity reported a memory leak (CID 1549757) in this code and its
admittedly rather clumsy handling of extending the command table.
Instead of handing over a full array of the commands lets use the
lighter weight GPtrArray and simply test for the presence of each
entry as we go. This avoids complications of transferring ownership of
arrays and keeps the final command entries as static entries in the
target code.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-4-alex.bennee@linaro.org>

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index f3058f9dda..40f0514fe9 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -74,23 +74,28 @@ int gdb_put_packet(const char *buf);
 
 /**
  * gdb_extend_query_table() - Extend query table.
- * @table: The table with the additional query packet handlers.
- * @size: The number of handlers to be added.
+ * @table: GPtrArray of GdbCmdParseEntry entries.
+ *
+ * The caller should free @table afterwards
  */
-void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
+void gdb_extend_query_table(GPtrArray *table);
 
 /**
  * gdb_extend_set_table() - Extend set table.
- * @table: The table with the additional set packet handlers.
- * @size: The number of handlers to be added.
+ * @table: GPtrArray of GdbCmdParseEntry entries.
+ *
+ * The caller should free @table afterwards
  */
-void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
+void gdb_extend_set_table(GPtrArray *table);
 
 /**
  * gdb_extend_qsupported_features() - Extend the qSupported features string.
  * @qsupported_features: The additional qSupported feature(s) string. The string
  * should start with a semicolon and, if there are more than one feature, the
- * features should be separate by a semiocolon.
+ * features should be separate by a semicolon.
+ *
+ * The caller should free @qsupported_features afterwards if
+ * dynamically allocated.
  */
 void gdb_extend_qsupported_features(char *qsupported_features);
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index da22d04121..757b1fae92 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -359,8 +359,8 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
 void arm_cpu_register_gdb_commands(ARMCPU *cpu);
-void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *, GArray *,
-                                       GArray *);
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *,
+                                       GPtrArray *, GPtrArray *);
 
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b9ad0a063e..b7be8e5a44 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1614,18 +1614,21 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
-static char *extended_qsupported_features;
-void gdb_extend_qsupported_features(char *qsupported_features)
-{
-    /*
-     * We don't support different sets of CPU gdb features on different CPUs yet
-     * so assert the feature strings are the same on all CPUs, or is set only
-     * once (1 CPU).
-     */
-    g_assert(extended_qsupported_features == NULL ||
-             g_strcmp0(extended_qsupported_features, qsupported_features) == 0);
 
-    extended_qsupported_features = qsupported_features;
+static char **extra_query_flags;
+
+void gdb_extend_qsupported_features(char *qflags)
+{
+    if (!extra_query_flags) {
+        extra_query_flags = g_new0(char *, 2);
+        extra_query_flags[0] = g_strdup(qflags);
+    } else if (!g_strv_contains((const gchar * const *) extra_query_flags,
+                                qflags)) {
+        int len = g_strv_length(extra_query_flags);
+        extra_query_flags = g_realloc_n(extra_query_flags, len + 2,
+                                        sizeof(char *));
+        extra_query_flags[len] = g_strdup(qflags);
+    }
 }
 
 static void handle_query_supported(GArray *params, void *user_ctx)
@@ -1668,8 +1671,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
 
-    if (extended_qsupported_features) {
-        g_string_append(gdbserver_state.str_buf, extended_qsupported_features);
+    if (extra_query_flags) {
+        int extras = g_strv_length(extra_query_flags);
+        for (int i = 0; i < extras; i++) {
+            g_string_append(gdbserver_state.str_buf, extra_query_flags[i]);
+        }
     }
 
     gdb_put_strbuf();
@@ -1753,39 +1759,58 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     },
 };
 
-/* Compares if a set of command parsers is equal to another set of parsers. */
-static bool cmp_cmds(GdbCmdParseEntry *c, GdbCmdParseEntry *d, int size)
+/**
+ * extend_table() - extend one of the command tables
+ * @table: the command table to extend (or NULL)
+ * @extensions: a list of GdbCmdParseEntry pointers
+ *
+ * The entries themselves should be pointers to static const
+ * GdbCmdParseEntry entries. If the entry is already in the table we
+ * skip adding it again.
+ *
+ * Returns (a potentially freshly allocated) GPtrArray of GdbCmdParseEntry
+ */
+static GPtrArray *extend_table(GPtrArray *table, GPtrArray *extensions)
 {
-    for (int i = 0; i < size; i++) {
-        if (!(c[i].handler == d[i].handler &&
-            g_strcmp0(c[i].cmd, d[i].cmd) == 0 &&
-            c[i].cmd_startswith == d[i].cmd_startswith &&
-            g_strcmp0(c[i].schema, d[i].schema) == 0)) {
+    if (!table) {
+        table = g_ptr_array_new();
+    }
 
-            /* Sets are different. */
-            return false;
+    for (int i = 0; i < extensions->len; i++) {
+        gpointer entry = g_ptr_array_index(extensions, i);
+        if (!g_ptr_array_find(table, entry, NULL)) {
+            g_ptr_array_add(table, entry);
         }
     }
 
-    /* Sets are equal, i.e. contain the same command parsers. */
-    return true;
+    return table;
 }
 
-static GdbCmdParseEntry *extended_query_table;
-static int extended_query_table_size;
-void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
+/**
+ * process_extended_table() - run through an extended command table
+ * @table: the command table to check
+ * @data: parameters
+ *
+ * returns true if the command was found and executed
+ */
+static bool process_extended_table(GPtrArray *table, const char *data)
 {
-    /*
-     * We don't support different sets of CPU gdb features on different CPUs yet
-     * so assert query table is the same on all CPUs, or is set only once
-     * (1 CPU).
-     */
-    g_assert(extended_query_table == NULL ||
-             (extended_query_table_size == size &&
-              cmp_cmds(extended_query_table, table, size)));
+    for (int i = 0; i < table->len; i++) {
+        const GdbCmdParseEntry *entry = g_ptr_array_index(table, i);
+        if (process_string_cmd(data, entry, 1)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 
-    extended_query_table = table;
-    extended_query_table_size = size;
+/* Ptr to GdbCmdParseEntry */
+static GPtrArray *extended_query_table;
+
+void gdb_extend_query_table(GPtrArray *new_queries)
+{
+    extended_query_table = extend_table(extended_query_table, new_queries);
 }
 
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
@@ -1880,20 +1905,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
 #endif
 };
 
-static GdbCmdParseEntry *extended_set_table;
-static int extended_set_table_size;
-void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
-{
-    /*
-     * We don't support different sets of CPU gdb features on different CPUs yet
-     * so assert set table is the same on all CPUs, or is set only once (1 CPU).
-     */
-    g_assert(extended_set_table == NULL ||
-             (extended_set_table_size == size &&
-              cmp_cmds(extended_set_table, table, size)));
+/* Ptr to GdbCmdParseEntry */
+static GPtrArray *extended_set_table;
 
-    extended_set_table = table;
-    extended_set_table_size = size;
+void gdb_extend_set_table(GPtrArray *new_set)
+{
+    extended_set_table = extend_table(extended_set_table, new_set);
 }
 
 static const GdbCmdParseEntry gdb_gen_set_table[] = {
@@ -1924,26 +1941,28 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
 
 static void handle_gen_query(GArray *params, void *user_ctx)
 {
+    const char *data;
+
     if (!params->len) {
         return;
     }
 
-    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    data = gdb_get_cmd_param(params, 0)->data;
+
+    if (process_string_cmd(data,
                            gdb_gen_query_set_common_table,
                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    if (process_string_cmd(data,
                            gdb_gen_query_table,
                            ARRAY_SIZE(gdb_gen_query_table))) {
         return;
     }
 
     if (extended_query_table &&
-        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
-                           extended_query_table,
-                           extended_query_table_size)) {
+        process_extended_table(extended_query_table, data)) {
         return;
     }
 
@@ -1953,26 +1972,28 @@ static void handle_gen_query(GArray *params, void *user_ctx)
 
 static void handle_gen_set(GArray *params, void *user_ctx)
 {
+    const char *data;
+
     if (!params->len) {
         return;
     }
 
-    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    data = gdb_get_cmd_param(params, 0)->data;
+
+    if (process_string_cmd(data,
                            gdb_gen_query_set_common_table,
                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    if (process_string_cmd(data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
         return;
     }
 
     if (extended_set_table &&
-        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
-                           extended_set_table,
-                           extended_set_table_size)) {
+        process_extended_table(extended_set_table, data)) {
         return;
     }
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index c3a9b5eb1e..554b8736bb 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -477,11 +477,9 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 
 void arm_cpu_register_gdb_commands(ARMCPU *cpu)
 {
-    GArray *query_table =
-        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
-    GArray *set_table =
-        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
-    GString *qsupported_features = g_string_new(NULL);
+    g_autoptr(GPtrArray) query_table = g_ptr_array_new();
+    g_autoptr(GPtrArray) set_table = g_ptr_array_new();
+    g_autoptr(GString) qsupported_features = g_string_new(NULL);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
     #ifdef TARGET_AARCH64
@@ -492,16 +490,12 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
 
     /* Set arch-specific handlers for 'q' commands. */
     if (query_table->len) {
-        gdb_extend_query_table(&g_array_index(query_table,
-                                              GdbCmdParseEntry, 0),
-                                              query_table->len);
+        gdb_extend_query_table(query_table);
     }
 
     /* Set arch-specific handlers for 'Q' commands. */
     if (set_table->len) {
-        gdb_extend_set_table(&g_array_index(set_table,
-                             GdbCmdParseEntry, 0),
-                             set_table->len);
+        gdb_extend_set_table(set_table);
     }
 
     /* Set arch-specific qSupported feature. */
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 2e2bc2700b..c8cef8cbc0 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -564,7 +564,7 @@ enum Command {
     NUM_CMDS
 };
 
-static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
+static const GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
     [qMemTags] = {
         .handler = handle_q_memtag,
         .cmd_startswith = true,
@@ -590,17 +590,16 @@ static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
 #endif /* CONFIG_USER_ONLY */
 
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
-                                       GArray *qtable, GArray *stable)
+                                       GPtrArray *qtable, GPtrArray *stable)
 {
 #ifdef CONFIG_USER_ONLY
     /* MTE */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         g_string_append(qsupported, ";memory-tagging+");
 
-        g_array_append_val(qtable, cmd_handler_table[qMemTags]);
-        g_array_append_val(qtable, cmd_handler_table[qIsAddressTagged]);
-
-        g_array_append_val(stable, cmd_handler_table[QMemTags]);
+        g_ptr_array_add(qtable, (gpointer) &cmd_handler_table[qMemTags]);
+        g_ptr_array_add(qtable, (gpointer) &cmd_handler_table[qIsAddressTagged]);
+        g_ptr_array_add(stable, (gpointer) &cmd_handler_table[QMemTags]);
     }
 #endif
 }
-- 
2.39.2


