Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149C1C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYZ-0007VW-FN; Tue, 04 Jun 2024 09:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYX-0007Dc-AT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYU-0003Cc-DV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRSsWVC3cw+Ko6ofdfEb/eTPlDkeBJ6vGSs+sArOcqc=;
 b=SDtlGOYEgW7eKq0hWpu/+irbj9jcnwR3QRNcK+l5R0JYx5fTnkXVK/o2AEjAy7o4fCU0An
 peMJDbGMSOxrB4qw5YKj0v3hiRp5SkYTAaNrZbOxOjF42WE8Ki4tTnHAk1qp0KTjdCNAGD
 rkCb4NEbXvij6iyZPAr/YdzI078xuCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-TcTV_JL2On2C3gAdlmTQ2w-1; Tue, 04 Jun 2024 09:50:24 -0400
X-MC-Unique: TcTV_JL2On2C3gAdlmTQ2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3200185B920;
 Tue,  4 Jun 2024 13:50:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6237C15C40;
 Tue,  4 Jun 2024 13:50:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 20/20] qga: centralize logic for disabling/enabling commands
Date: Tue,  4 Jun 2024 14:49:33 +0100
Message-ID: <20240604134933.220112-21-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is confusing having many different pieces of code enabling and
disabling commands, and it is not clear that they all have the same
semantics, especially wrt prioritization of the block/allow lists.

Centralizing the code in a single method "ga_apply_command_filters"
will provide a strong guarantee of consistency and clarify the
intended behaviour.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/main.c | 110 ++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index e8f52f0794..c7b7b0a9bc 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -419,60 +419,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
     return strcmp(str1, str2);
 }
 
-/* disable commands that aren't safe for fsfreeze */
-static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
+static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
 {
-    bool allowed = false;
     int i = 0;
+    GAConfig *config = state->config;
     const char *name = qmp_command_name(cmd);
+    /* Fallback policy is allow everything */
+    bool allowed = true;
 
-    while (ga_freeze_allowlist[i] != NULL) {
-        if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
+    if (config->allowedrpcs) {
+        /*
+         * If an allow-list is given, this changes the fallback
+         * policy to deny everything
+         */
+        allowed = false;
+
+        if (g_list_find_custom(config->allowedrpcs, name, ga_strcmp) != NULL) {
             allowed = true;
         }
-        i++;
-    }
-    if (!allowed) {
-        g_debug("disabling command: %s", name);
-        qmp_disable_command(&ga_commands, name, "the agent is in frozen state");
     }
-}
-
-/* [re-]enable all commands, except those explicitly blocked by user */
-static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
-{
-    GAState *s = opaque;
-    GList *blockedrpcs = s->blockedrpcs;
-    GList *allowedrpcs = s->allowedrpcs;
-    const char *name = qmp_command_name(cmd);
 
-    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL) {
-        if (qmp_command_is_enabled(cmd)) {
-            return;
+    /*
+     * If both allowedrpcs and blockedrpcs are set, the blocked
+     * list will take priority
+     */
+    if (config->blockedrpcs) {
+        if (g_list_find_custom(config->blockedrpcs, name, ga_strcmp) != NULL) {
+            allowed = false;
         }
+    }
 
-        if (allowedrpcs &&
-            g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
-            return;
-        }
+    /*
+     * If frozen, this filtering must take priority over
+     * absolutely everything
+     */
+    if (state->frozen) {
+        allowed = false;
 
-        g_debug("enabling command: %s", name);
-        qmp_enable_command(&ga_commands, name);
+        while (ga_freeze_allowlist[i] != NULL) {
+            if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
+                allowed = true;
+            }
+            i++;
+        }
     }
+
+    return allowed;
 }
 
-/* disable commands that aren't allowed */
-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
+static void ga_apply_command_filters_iter(const QmpCommand *cmd, void *opaque)
 {
-    GList *allowedrpcs = opaque;
+    GAState *state = opaque;
+    bool want = ga_command_is_allowed(cmd, state);
+    bool have = qmp_command_is_enabled(cmd);
     const char *name = qmp_command_name(cmd);
 
-    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
+    if (want == have) {
+        return;
+    }
+
+    if (qmp_command_is_enabled(cmd)) {
         g_debug("disabling command: %s", name);
         qmp_disable_command(&ga_commands, name, "the command is not allowed");
+    } else {
+        g_debug("enabling command: %s", name);
+        qmp_enable_command(&ga_commands, name);
     }
 }
 
+static void ga_apply_command_filters(GAState *state)
+{
+    qmp_for_each_command(&ga_commands, ga_apply_command_filters_iter, state);
+}
+
 static bool ga_create_file(const char *path)
 {
     int fd = open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
@@ -505,15 +524,14 @@ void ga_set_frozen(GAState *s)
     if (ga_is_frozen(s)) {
         return;
     }
-    /* disable all forbidden (for frozen state) commands */
-    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     g_warning("disabling logging due to filesystem freeze");
-    ga_disable_logging(s);
     s->frozen = true;
     if (!ga_create_file(s->state_filepath_isfrozen)) {
         g_warning("unable to create %s, fsfreeze may not function properly",
                   s->state_filepath_isfrozen);
     }
+    ga_apply_command_filters(s);
+    ga_disable_logging(s);
 }
 
 void ga_unset_frozen(GAState *s)
@@ -545,12 +563,12 @@ void ga_unset_frozen(GAState *s)
     }
 
     /* enable all disabled, non-blocked and allowed commands */
-    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
     s->frozen = false;
     if (!ga_delete_file(s->state_filepath_isfrozen)) {
         g_warning("unable to delete %s, fsfreeze may not function properly",
                   s->state_filepath_isfrozen);
     }
+    ga_apply_command_filters(s);
 }
 
 #ifdef CONFIG_FSFREEZE
@@ -1414,7 +1432,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
             s->deferred_options.log_filepath = config->log_filepath;
         }
         ga_disable_logging(s);
-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     } else {
         if (config->daemonize) {
             become_daemon(config->pid_filepath);
@@ -1438,25 +1455,8 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
         return NULL;
     }
 
-    if (config->allowedrpcs) {
-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, config->allowedrpcs);
-        s->allowedrpcs = config->allowedrpcs;
-    }
+    ga_apply_command_filters(s);
 
-    /*
-     * Some commands can be blocked due to system limitation.
-     * Initialize blockedrpcs list even if allowedrpcs specified.
-     */
-    config->blockedrpcs = ga_command_init_blockedrpcs(config->blockedrpcs);
-    if (config->blockedrpcs) {
-        GList *l = config->blockedrpcs;
-        s->blockedrpcs = config->blockedrpcs;
-        do {
-            g_debug("disabling command: %s", (char *)l->data);
-            qmp_disable_command(&ga_commands, l->data, NULL);
-            l = g_list_next(l);
-        } while (l);
-    }
     s->command_state = ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
-- 
2.45.1


