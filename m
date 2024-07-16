Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52005C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgaJ-00068q-4X; Tue, 16 Jul 2024 07:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTgZx-0004zm-7Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:42:46 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTgZu-0006UD-TO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:42:44 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e37feeso6630557a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721130158; x=1721734958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bx18rqi4jDY8+2uStTKkW27rK/9dqrmkRYtusDvfm4Y=;
 b=IYYdd4Zl1HMWlUR3AKEXpHyIwzTp5TnsEwQpqxGaCfUYHt1TcefQmGo6F2/q+KsYTU
 Sc/Ynph6WqLd4DIMS8hua1iZYo4u7jCMdUtXrOV6BWnDrVCmMZj5g9rxOmiviYuOl5Zr
 Npb5VP43Dz5I5NqDt/gbAAh1F4Ftd+X+qoOsmQT0abJ4KECXVfABgKC4+JAIrIeM3TE5
 2t4sDwkH9jOBvCEPeOCeVaoBdACXza4Tpu2Xp2fwTzfHLIv544pHq6EBVbyUvMfGpD3x
 FviyzlvJtegceDBKrYaTiQ05ItEKMoSlBlGRvBviZUd+ifPv1CGyvtGCv+c5/ERaA2lx
 47ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721130158; x=1721734958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bx18rqi4jDY8+2uStTKkW27rK/9dqrmkRYtusDvfm4Y=;
 b=f9v59fhF0UbzhVmpDOqBgBcKQZ2IjDlh8DbU6M2FIlvF9aPQudRD6aGvCz9mOVyEFs
 oIy52u3qGUdzTCiVDA0THCCnhNLztH7WTUYO7xO4Tp1dDtBhfI/e58jqtF+EgyaNDZ7r
 UHgaHTqQVt883pWcmI9RsiH+HMvdrPoG6rYcnDFcQefSsEX9fYmswPMR/HzrQnmkcU5t
 tNpZpMziVkvBkp++jJxCjWySjTESjI5e6Lr31/Kv82JsDkgubMiZKmcI4Aov0loniWAy
 RS7HLIf5pEtUCTR8bX6+EWH+XLevHGSVp3ZlCs93aBNBRcuF4AvgeYz+oDjg9SFgebXb
 qipg==
X-Gm-Message-State: AOJu0Yz9oelvwbEy1368XTkMloZGRswodcrfD7LBR5vU+hPAbwGwRRAR
 puBbLa4crQDVbZkII1vPoSiv7Qz98DxshNRcB5lkfSu4/gZSKNXNAK58QC9bx+Gd/pd/BGQJWG+
 b
X-Google-Smtp-Source: AGHT+IGTYArVxkWoNOrkJsxFufKKXHjTe3u+WIGO2w7UDf34L5cUIrKPT93j0y+h+slQ6Ol2ho2jSg==
X-Received: by 2002:a05:6402:26c6:b0:57d:101f:ae9f with SMTP id
 4fb4d7f45d1cf-59ef06bad2fmr1309321a12.33.1721130158001; 
 Tue, 16 Jul 2024 04:42:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b25526dc8sm4784467a12.46.2024.07.16.04.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 04:42:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81AE75F7A0;
 Tue, 16 Jul 2024 12:42:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] gdbstub: Re-factor gdb command extensions
Date: Tue, 16 Jul 2024 12:42:29 +0100
Message-Id: <20240716114229.329355-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/commands.h |  19 ++++--
 target/arm/internals.h     |   4 +-
 gdbstub/gdbstub.c          | 127 +++++++++++++++++++++----------------
 target/arm/gdbstub.c       |  16 ++---
 target/arm/gdbstub64.c     |  11 ++--
 5 files changed, 95 insertions(+), 82 deletions(-)

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
index b9ad0a063e..fd7b4ecddb 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1615,17 +1615,16 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
 }
 
 static char *extended_qsupported_features;
+
 void gdb_extend_qsupported_features(char *qsupported_features)
 {
-    /*
-     * We don't support different sets of CPU gdb features on different CPUs yet
-     * so assert the feature strings are the same on all CPUs, or is set only
-     * once (1 CPU).
-     */
-    g_assert(extended_qsupported_features == NULL ||
-             g_strcmp0(extended_qsupported_features, qsupported_features) == 0);
-
-    extended_qsupported_features = qsupported_features;
+    if (!extended_qsupported_features) {
+        extended_qsupported_features = g_strdup(qsupported_features);
+    } else if (!g_strrstr(extended_qsupported_features, qsupported_features)) {
+        char *old = extended_qsupported_features;
+        extended_qsupported_features = g_strdup_printf("%s%s", old, qsupported_features);
+        g_free(old);
+    }
 }
 
 static void handle_query_supported(GArray *params, void *user_ctx)
@@ -1753,39 +1752,59 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
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
+static GPtrArray * extend_table(GPtrArray *table, GPtrArray *extensions)
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
+
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
 
-    extended_query_table = table;
-    extended_query_table_size = size;
+
+/* Ptr to GdbCmdParseEntry */
+static GPtrArray *extended_query_table;
+
+void gdb_extend_query_table(GPtrArray *new_queries)
+{
+    extended_query_table = extend_table(extended_query_table, new_queries);
 }
 
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
@@ -1880,20 +1899,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
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
@@ -1924,26 +1935,28 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
 
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
 
@@ -1953,26 +1966,28 @@ static void handle_gen_query(GArray *params, void *user_ctx)
 
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


