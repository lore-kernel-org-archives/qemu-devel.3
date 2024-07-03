Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B07C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOx6j-0007p6-1s; Wed, 03 Jul 2024 06:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOx6h-0007ka-OU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:20:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOx6Q-00007v-4C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:20:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso28121575e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720002038; x=1720606838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nq1FX7GGfO/Z9btklap79Ee+aoD2jA16PoWUi8Kvu8U=;
 b=Wzj4E2MjKRkl2Zf0y0RkXAzylBaQRXKlJxoZoJ9IrxqEMDAYXFaYKxS+sCauEESKp3
 EXGIe4RJDjAnr6G6kYQ6B2agQJ1YQIkcZnhKYgGG5tnZI53PZw96xIR47oyh1CCjNLi4
 TAZbGLmyIdN6GAxkB+8QDDcxyO7bFU/8OJWjTkyJQ7ajg5uICJ1ax/z+ldFBPti9ucFa
 CwA2hFgi2X3ZOO+e+DHAmBE++m4qN2m43aSN7wujZQY7JPMWkP78W3WyWw0Qmtlyi8UI
 y3Iv9Xlvps5sHDYyLATKCB1YEpXe8tEnLp3gLdIzv1MvjRiNfdIj1wNK2oB9V1HBdrMB
 mdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720002038; x=1720606838;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nq1FX7GGfO/Z9btklap79Ee+aoD2jA16PoWUi8Kvu8U=;
 b=EppKz+CFWjpambPFKMtjnUnP3tMvOF4RednQGOx6Z1BKZ47ZTkXoeXtM7ydXZ6EDWa
 MOjtYQ6csrCBfiyMRqCvrFr9XVOb6WNlk+vxf52xem1DHFLy9scDBqluMuq+biNU838M
 FmzuaLPZFxggGL336KER1aLvqkA664UlOGgQvHNpOCU3IpGFo95hkwMBY2GwSXAkY6I7
 Qj2zgcpDtmrj4uVZbgEHsa+DQ+R70U/sSOWleDRxu0nBds+hS6Wd5tTOLHTJ3fQnPG5k
 M/JebQC3/F2DLaA8Yqefm5P2B2/hEJaWM5mxveMCk5FzTtNS2uVG0zXw6fhbHYiqSr2O
 MGvA==
X-Gm-Message-State: AOJu0YzBO8TOJIuZKALcqpoleu0NABCTEJht8pUttekNHd6N4rJ/mo74
 Sl51T7sTOQkfEewmlrwISeJeQLeeRcKxQOO8u5mDu38msjP2hgmqDEp7cslECiJNISvgm+Lcksl
 lcDc=
X-Google-Smtp-Source: AGHT+IFtOLGRcuU3bpq+Ti42xywACyQDGhjhOAjJynYhxU100s7HbH1RLnHF9i5RUfXvkbIOKDZIVA==
X-Received: by 2002:a05:600c:41c5:b0:424:aa6c:8db2 with SMTP id
 5b1f17b1804b1-4257a0096damr76124715e9.11.1720002038141; 
 Wed, 03 Jul 2024 03:20:38 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm235638685e9.31.2024.07.03.03.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:20:37 -0700 (PDT)
Date: Wed, 03 Jul 2024 13:01:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 22/22] qga: centralize logic for disabling/enabling
 commands
User-Agent: meli 0.8.6
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-17-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-17-berrange@redhat.com>
Message-ID: <g1m2c.r93vk15jos2y@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello Daniel,

This cleanup seems like a good idea,

On Thu, 13 Jun 2024 18:44, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>It is confusing having many different pieces of code enabling and
>disabling commands, and it is not clear that they all have the same
>semantics, especially wrt prioritization of the block/allow lists.
>The code attempted to prevent the user from setting both the block
>and allow lists concurrently, however, the logic was flawed as it
>checked settings in the configuration file  separately from the
>command line arguments. Thus it was possible to set a block list
>in the config file and an allow list via a command line argument.
>The --dump-conf option also creates a configuration file with both
>keys present, even if unset, which means it is creating a config
>that cannot actually be loaded again.
>
>Centralizing the code in a single method "ga_apply_command_filters"
>will provide a strong guarantee of consistency and clarify the
>intended behaviour. With this there is no compelling technical
>reason to prevent concurrent setting of both the allow and block
>lists, so this flawed restriction is removed.
>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>---
> docs/interop/qemu-ga.rst |  14 +++++
> qga/commands-posix.c     |   6 --
> qga/commands-win32.c     |   6 --
> qga/main.c               | 128 +++++++++++++++++----------------------
> 4 files changed, 70 insertions(+), 84 deletions(-)
>
>diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
>index e42b370319..e35dcaf0e7 100644
>--- a/docs/interop/qemu-ga.rst
>+++ b/docs/interop/qemu-ga.rst
>@@ -28,6 +28,20 @@ configuration options on the command line. For the same key, the last
> option wins, but the lists accumulate (see below for configuration
> file format).
> 
>+If an allowed RPCs list is defined in the configuration, then all
>+RPCs will be blocked by default, except for the allowed list.
>+
>+If a blocked RPCs list is defined in the configuration, then all
>+RPCs will be allowed by default, except for the blocked list.
>+
>+If both allowed and blocked RPCs lists are defined in the configuration,
>+then all RPCs will be blocked by default, and then allowed list will
>+be applied, followed by the blocked list.

Nit: Missing an article here

-then all RPCs will be blocked by default, and then allowed list will
+then all RPCs will be blocked by default, then the allowed list will


>+
>+While filesystems are frozen, all except for a designated safe set
>+of RPCs will blocked, regardless of what the general configuration
>+declares.
>+
> Options
> -------
> 
>diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>index f4104f2760..578d29f228 100644
>--- a/qga/commands-posix.c
>+++ b/qga/commands-posix.c
>@@ -1136,12 +1136,6 @@ error:
> 
> #endif /* HAVE_GETIFADDRS */
> 
>-/* add unsupported commands to the list of blocked RPCs */
>-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>-{
>-    return blockedrpcs;
>-}
>-
> /* register init/cleanup routines for stateful command groups */
> void ga_command_state_init(GAState *s, GACommandState *cs)
> {
>diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>index 5866cc2e3c..61b36da469 100644
>--- a/qga/commands-win32.c
>+++ b/qga/commands-win32.c
>@@ -1958,12 +1958,6 @@ done:
>     g_free(rawpasswddata);
> }
> 
>-/* add unsupported commands to the list of blocked RPCs */
>-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>-{
>-    return blockedrpcs;
>-}
>-
> /* register init/cleanup routines for stateful command groups */
> void ga_command_state_init(GAState *s, GACommandState *cs)
> {
>diff --git a/qga/main.c b/qga/main.c
>index f68a32bf7b..72c16fead8 100644
>--- a/qga/main.c
>+++ b/qga/main.c
>@@ -419,60 +419,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
>     return strcmp(str1, str2);
> }
> 
>-/* disable commands that aren't safe for fsfreeze */
>-static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
>+static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
> {
>-    bool allowed = false;
>     int i = 0;
>+    GAConfig *config = state->config;
>     const char *name = qmp_command_name(cmd);
>+    /* Fallback policy is allow everything */
>+    bool allowed = true;
> 
>-    while (ga_freeze_allowlist[i] != NULL) {
>-        if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
>+    if (config->allowedrpcs) {
>+        /*
>+         * If an allow-list is given, this changes the fallback
>+         * policy to deny everything
>+         */
>+        allowed = false;
>+
>+        if (g_list_find_custom(config->allowedrpcs, name, ga_strcmp) != NULL) {
>             allowed = true;
>         }
>-        i++;
>     }
>-    if (!allowed) {
>-        g_debug("disabling command: %s", name);
>-        qmp_disable_command(&ga_commands, name, "the agent is in frozen state");
>-    }
>-}
> 
>-/* [re-]enable all commands, except those explicitly blocked by user */
>-static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
>-{
>-    GAState *s = opaque;
>-    GList *blockedrpcs = s->blockedrpcs;
>-    GList *allowedrpcs = s->allowedrpcs;
>-    const char *name = qmp_command_name(cmd);
>-
>-    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL) {
>-        if (qmp_command_is_enabled(cmd)) {
>-            return;
>+    /*
>+     * If both allowedrpcs and blockedrpcs are set, the blocked
>+     * list will take priority
>+     */
>+    if (config->blockedrpcs) {
>+        if (g_list_find_custom(config->blockedrpcs, name, ga_strcmp) != NULL) {
>+            allowed = false;
>         }
>+    }
> 
>-        if (allowedrpcs &&
>-            g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
>-            return;
>-        }
>+    /*
>+     * If frozen, this filtering must take priority over
>+     * absolutely everything
>+     */
>+    if (state->frozen) {
>+        allowed = false;
> 
>-        g_debug("enabling command: %s", name);
>-        qmp_enable_command(&ga_commands, name);
>+        while (ga_freeze_allowlist[i] != NULL) {
>+            if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
>+                allowed = true;
>+            }
>+            i++;
>+        }
>     }
>+
>+    return allowed;
> }

IUUC, we can check by priority here: first check if (state->frozen), 
then blockedrpcs, then allowedrpcs and then return a default fallback 
value allowed = config->blockedrpcs != NULL && config->allowedrpcs != 
NULL

This way the function will sort of document what is written on the docs 
as well.


> 
>-/* disable commands that aren't allowed */
>-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
>+static void ga_apply_command_filters_iter(const QmpCommand *cmd, void *opaque)
> {
>-    GList *allowedrpcs = opaque;
>+    GAState *state = opaque;
>+    bool want = ga_command_is_allowed(cmd, state);
>+    bool have = qmp_command_is_enabled(cmd);
>     const char *name = qmp_command_name(cmd);
> 
>-    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
>+    if (want == have) {
>+        return;
>+    }
>+
>+    if (qmp_command_is_enabled(cmd)) {

Nit:

  if (have) {

Since it's already declared.

>         g_debug("disabling command: %s", name);
>         qmp_disable_command(&ga_commands, name, "the command is not allowed");
>+    } else {
>+        g_debug("enabling command: %s", name);
>+        qmp_enable_command(&ga_commands, name);
>     }
> }
> 
>+static void ga_apply_command_filters(GAState *state)

Nit: inline?

>+{
>+    qmp_for_each_command(&ga_commands, ga_apply_command_filters_iter, state);
>+}
>+
> static bool ga_create_file(const char *path)
> {
>     int fd = open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
>@@ -505,15 +524,14 @@ void ga_set_frozen(GAState *s)
>     if (ga_is_frozen(s)) {
>         return;
>     }
>-    /* disable all forbidden (for frozen state) commands */
>-    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
>     g_warning("disabling logging due to filesystem freeze");
>-    ga_disable_logging(s);
>     s->frozen = true;
>     if (!ga_create_file(s->state_filepath_isfrozen)) {
>         g_warning("unable to create %s, fsfreeze may not function properly",
>                   s->state_filepath_isfrozen);
>     }
>+    ga_apply_command_filters(s);
>+    ga_disable_logging(s);
> }
> 
> void ga_unset_frozen(GAState *s)
>@@ -545,12 +563,12 @@ void ga_unset_frozen(GAState *s)
>     }
> 
>     /* enable all disabled, non-blocked and allowed commands */
>-    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
>     s->frozen = false;
>     if (!ga_delete_file(s->state_filepath_isfrozen)) {
>         g_warning("unable to delete %s, fsfreeze may not function properly",
>                   s->state_filepath_isfrozen);
>     }
>+    ga_apply_command_filters(s);
> }
> 
> #ifdef CONFIG_FSFREEZE
>@@ -1082,13 +1100,6 @@ static void config_load(GAConfig *config, const char *confpath, bool required)
>                                           split_list(config->aliststr, ","));
>     }
> 
>-    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL) &&
>-        g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
>-        g_critical("wrong config, using 'block-rpcs' and 'allow-rpcs' keys at"
>-                   " the same time is not allowed");
>-        exit(EXIT_FAILURE);
>-    }
>-
> end:
>     g_key_file_free(keyfile);
>     if (gerr && (required ||
>@@ -1168,7 +1179,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
> {
>     const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
>     int opt_ind = 0, ch;
>-    bool block_rpcs = false, allow_rpcs = false;
>     const struct option lopt[] = {
>         { "help", 0, NULL, 'h' },
>         { "version", 0, NULL, 'V' },
>@@ -1264,7 +1274,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
>             }
>             config->blockedrpcs = g_list_concat(config->blockedrpcs,
>                                                 split_list(optarg, ","));
>-            block_rpcs = true;
>             break;
>         }
>         case 'a': {
>@@ -1274,7 +1283,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
>             }
>             config->allowedrpcs = g_list_concat(config->allowedrpcs,
>                                                 split_list(optarg, ","));
>-            allow_rpcs = true;
>             break;
>         }
> #ifdef _WIN32
>@@ -1315,12 +1323,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
>             exit(EXIT_FAILURE);
>         }
>     }
>-
>-    if (block_rpcs && allow_rpcs) {
>-        g_critical("wrong commandline, using --block-rpcs and --allow-rpcs at the"
>-                   " same time is not allowed");
>-        exit(EXIT_FAILURE);
>-    }
> }
> 
> static void config_free(GAConfig *config)
>@@ -1431,7 +1433,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
>             s->deferred_options.log_filepath = config->log_filepath;
>         }
>         ga_disable_logging(s);
>-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
>     } else {
>         if (config->daemonize) {
>             become_daemon(config->pid_filepath);
>@@ -1455,25 +1456,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
>         return NULL;
>     }
> 
>-    if (config->allowedrpcs) {
>-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, config->allowedrpcs);
>-        s->allowedrpcs = config->allowedrpcs;
>-    }
>-
>-    /*
>-     * Some commands can be blocked due to system limitation.
>-     * Initialize blockedrpcs list even if allowedrpcs specified.
>-     */
>-    config->blockedrpcs = ga_command_init_blockedrpcs(config->blockedrpcs);
>-    if (config->blockedrpcs) {
>-        GList *l = config->blockedrpcs;
>-        s->blockedrpcs = config->blockedrpcs;
>-        do {
>-            g_debug("disabling command: %s", (char *)l->data);
>-            qmp_disable_command(&ga_commands, l->data, NULL);
>-            l = g_list_next(l);
>-        } while (l);
>-    }
>     s->command_state = ga_command_state_new();
>     ga_command_state_init(s, s->command_state);
>     ga_command_state_init_all(s->command_state);
>@@ -1499,6 +1481,8 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
>     }
> #endif
> 
>+    ga_apply_command_filters(s);
>+
>     ga_state = s;
>     return s;
> }
>-- 
>2.45.1
>
>

