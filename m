Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9DFEC11B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5M7N-00019r-Gs; Wed, 25 Mar 2026 07:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w5M7L-00019Q-QB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w5M7J-0002jZ-Ox
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774436981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeQ0+ZzVAvwN2bLlHeeLUOO+d+FsdP4uIA1wF0prHw0=;
 b=XdM45ymDZ6Vrfr+sN0ozTSidbgz6LfdQ9Wt/mdr9w4Dutkc3PBOSzdBbO0gQq49/B3d7bR
 zGgoeZ8lRQbwMzoGacd8uxIaz41JbrYA/Bhq0Ykeho+w2xQuk7bwPhsWde0e867L92rhM8
 5+qwgd8uh1IR1lfpQGXrbCm4Dn7Y9b8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-1dQDSCGTPmSeQIks_k6AJQ-1; Wed,
 25 Mar 2026 07:09:37 -0400
X-MC-Unique: 1dQDSCGTPmSeQIks_k6AJQ-1
X-Mimecast-MFC-AGG-ID: 1dQDSCGTPmSeQIks_k6AJQ_1774436976
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B273519560AA
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 11:09:36 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.180])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3CE719560B1; Wed, 25 Mar 2026 11:09:34 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kkostiuk@redhat.com, yvugenfi@redhat.com,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v3 2/2] qga: add --audit option for command logging control
Date: Wed, 25 Mar 2026 13:09:00 +0200
Message-ID: <20260325110900.2065942-2-eashurov@redhat.com>
In-Reply-To: <20260325110900.2065942-1-eashurov@redhat.com>
References: <20260325110900.2065942-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add -A/--audit=LIST option to control which guest agent commands
are logged at info level (visible with --verbose) and which at
debug level (visible only with --debug).

Patterns are comma-separated and checked in order; the first match
wins. Patterns starting with '!' log the command at debug level
instead of info.
For example: --audit=!guest-ping,* logs all commands
at info level except guest-ping.

Move command logging from individual handlers into process_event()
so all commands are logged in one place. Keep g_debug() calls in
handlers for useful details like file paths, handles, and PIDs.

The default pattern is '*', so all commands are logged at info
level unless configured otherwise.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-linux.c |  2 --
 qga/commands-posix.c | 11 +++---
 qga/commands-win32.c | 14 +++-----
 qga/commands.c       |  5 ++-
 qga/main.c           | 82 ++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index a722de2e6a..8df83963fa 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1158,8 +1158,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
     int fd;
     struct fstrim_range r;
 
-    g_info("guest-fstrim called");
-
     QTAILQ_INIT(&mounts);
     if (!build_fs_mount_list(&mounts, errp)) {
         return NULL;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 96939a6f36..6a3e6c78e3 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
     const char *reboot_flag = "-r";
 #endif
 
-    g_info("guest-shutdown called, mode: %s", mode);
+    g_debug("guest-shutdown mode: %s", mode);
     if (!mode || strcmp(mode, "powerdown") == 0) {
         if (access(POWEROFF_CMD_PATH, X_OK) == 0) {
             shutdown_cmd = POWEROFF_CMD_PATH;
@@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode,
     if (!mode) {
         mode = "r";
     }
-    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode);
+    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
     fh = safe_open_or_create(path, mode, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode,
         return -1;
     }
 
-    g_info("guest-file-open, handle: %" PRId64, handle);
+    g_debug("guest-file-open handle: %" PRId64, handle);
     return handle;
 }
 
@@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
     GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
     int ret;
 
-    g_info("guest-file-close called, handle: %" PRId64, handle);
+    g_debug("guest-file-close handle: %" PRId64, handle);
     if (!gfh) {
         return;
     }
@@ -793,8 +793,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     FsMountList mounts;
     Error *local_err = NULL;
 
-    g_info("guest-fsfreeze called");
-
     execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -833,7 +831,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     if (ret >= 0) {
         ga_unset_frozen(ga_state);
-        g_info("guest-fsthaw called");
         execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
     } else {
         ret = 0;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d26b0041ce..e916d081f5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
     if (!mode) {
         mode = "r";
     }
-    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode);
+    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
     guest_flags = find_open_flag(mode);
     if (guest_flags == NULL) {
         error_setg(errp, "invalid file open mode");
@@ -267,8 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
         goto done;
     }
 
-    g_info("guest-file-open, handle: % " PRId64, fd);
-
+    g_debug("guest-file-open handle: %" PRId64, fd);
 done:
     g_free(w_path);
     return fd;
@@ -278,7 +277,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
 {
     bool ret;
     GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
-    g_info("guest-file-close called, handle: %" PRId64, handle);
+    g_debug("guest-file-close handle: %" PRId64, handle);
     if (gfh == NULL) {
         return;
     }
@@ -337,8 +336,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
     Error *local_err = NULL;
     UINT shutdown_flag = EWX_FORCE;
 
-    g_info("guest-shutdown called, mode: %s", mode);
-
+    g_debug("guest-shutdown mode: %s", mode);
     if (!mode || strcmp(mode, "powerdown") == 0) {
         shutdown_flag |= EWX_POWEROFF;
     } else if (strcmp(mode, "halt") == 0) {
@@ -1255,8 +1253,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
         return 0;
     }
 
-    g_info("guest-fsfreeze called");
-
     /* cannot risk guest agent blocking itself on a write in this state */
     ga_set_frozen(ga_state);
 
@@ -1294,8 +1290,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     ga_unset_frozen(ga_state);
 
-    g_info("guest-fsthaw called");
-
     return i;
 }
 
diff --git a/qga/commands.c b/qga/commands.c
index 55edd9fd4c..36b99819af 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -43,7 +43,6 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)
 
 void qmp_guest_ping(Error **errp)
 {
-    g_info("guest-ping called");
 }
 
 static void qmp_command_info(const QmpCommand *cmd, void *opaque)
@@ -136,7 +135,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
     GuestExecInfo *gei;
     GuestExecStatus *ges;
 
-    g_info("guest-exec-status called, pid: %u", (uint32_t)pid);
+    g_debug("guest-exec-status pid: %u", (uint32_t)pid);
 
     gei = guest_exec_info_find(pid);
     if (gei == NULL) {
@@ -238,7 +237,7 @@ static char **guest_exec_get_args(const strList *entry, bool log)
     args[i] = NULL;
 
     if (log) {
-        g_info("guest-exec called: \"%s\"", str);
+        g_debug("guest-exec called: \"%s\"", str);
     }
     g_free(str);
 
diff --git a/qga/main.c b/qga/main.c
index 40b92ec686..8392d74451 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -87,8 +87,10 @@ struct GAConfig {
 #endif
     gchar *bliststr; /* blockedrpcs may point to this string */
     gchar *aliststr; /* allowedrpcs may point to this string */
+    gchar *auditstr;
     GList *blockedrpcs;
     GList *allowedrpcs;
+    GList *audit_patterns;
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
@@ -116,6 +118,7 @@ struct GAState {
     bool frozen;
     GList *blockedrpcs;
     GList *allowedrpcs;
+    GList *audit_patterns;
     char *state_filepath_isfrozen;
     struct {
         const char *log_filepath;
@@ -288,6 +291,11 @@ QEMU_COPYRIGHT "\n"
 "                    only, default is %s)\n"
 "  -v, --verbose     enable verbose logging (info and above)\n"
 "  --debug           enable debug logging (all messages)\n"
+"  -A, --audit=LIST  comma-separated list of command patterns to log at\n"
+"                    info level (default: *, no spaces).\n"
+"                    Patterns prefixed with '!' are logged at debug level.\n"
+"                    Patterns are evaluated in order; the first match wins.\n"
+"                    Example: --audit=!guest-ping,*\n"
 "  -V, --version     print version information and exit\n"
 "  -d, --daemonize   become a daemon\n"
 #ifdef _WIN32
@@ -413,6 +421,33 @@ static void ga_log(const gchar *domain, GLogLevelFlags level,
     }
 }
 
+static void ga_audit_log(GAState *s, const char *command)
+{
+    GList *l;
+
+    if (!command) {
+        return;
+    }
+
+    for (l = s->audit_patterns; l; l = l->next) {
+        const char *pattern = l->data;
+
+        if (pattern[0] == '!') {
+            if (g_pattern_match_simple(pattern + 1, command)) {
+                g_debug("%s called", command);
+                return;
+            }
+        } else {
+            if (g_pattern_match_simple(pattern, command)) {
+                g_info("%s called", command);
+                return;
+            }
+        }
+    }
+
+    g_debug("%s called", command);
+}
+
 void ga_set_response_delimited(GAState *s)
 {
     s->delimit_response = true;
@@ -706,7 +741,27 @@ static void process_event(void *opaque, QObject *obj, Error *err)
     }
 
     g_debug("processing command");
-    rsp = qmp_dispatch(&ga_commands, obj, false, NULL);
+    {
+        QDict *dict = qobject_to(QDict, obj);
+        const char *command = dict ? qdict_get_try_str(dict, "execute") : NULL;
+        /*
+         * Remember if logging was enabled.
+         * fs-freeze disables logs, so when fs-thaw re-enables
+         * them we re-audit to make sure the thaw is logged.
+         */
+        bool logging_before = ga_logging_enabled(s);
+        bool audit = command && qmp_find_command(&ga_commands, command);
+
+        if (audit) {
+            ga_audit_log(s, command);
+        }
+
+        rsp = qmp_dispatch(&ga_commands, obj, false, NULL);
+
+        if (!logging_before && audit) {
+            ga_audit_log(s, command);
+        }
+    }
 
 end:
     ret = send_response(s, rsp);
@@ -1157,6 +1212,14 @@ static void config_load(GAConfig *config, const char *confpath, bool required)
         config->retry_path =
             g_key_file_get_boolean(keyfile, "general", "retry-path", &gerr);
     }
+    if (g_key_file_has_key(keyfile, "general", "audit", NULL)) {
+        config->auditstr =
+            g_key_file_get_string(keyfile, "general", "audit", &gerr);
+        config->audit_patterns = g_list_concat(config->audit_patterns,
+                                               g_list_reverse(
+                                                   split_list(config->auditstr,
+                                                              ",")));
+    }
 
     if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL)) {
         config->bliststr =
@@ -1229,6 +1292,9 @@ static void config_dump(GAConfig *config)
                            config->log_level & G_LOG_LEVEL_DEBUG);
     g_key_file_set_boolean(keyfile, "general", "retry-path",
                            config->retry_path);
+    tmp = list_join(config->audit_patterns, ',');
+    g_key_file_set_string(keyfile, "general", "audit", tmp);
+    g_free(tmp);
     tmp = list_join(config->blockedrpcs, ',');
     g_key_file_set_string(keyfile, "general", "block-rpcs", tmp);
     g_free(tmp);
@@ -1251,7 +1317,7 @@ static void config_dump(GAConfig *config)
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
     enum { OPT_DEBUG = 256 };
-    const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
+    const char *sopt = "hVvdc:m:p:l:f:F::b:a:A:s:t:Dr";
     int opt_ind = 0, ch;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
@@ -1270,6 +1336,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "daemonize", 0, NULL, 'd' },
         { "block-rpcs", 1, NULL, 'b' },
         { "allow-rpcs", 1, NULL, 'a' },
+        { "audit", 1, NULL, 'A' },
 #ifdef _WIN32
         { "service", 1, NULL, 's' },
 #endif
@@ -1362,6 +1429,10 @@ static void config_parse(GAConfig *config, int argc, char **argv)
                                                 split_list(optarg, ","));
             break;
         }
+        case 'A':
+            g_list_free_full(config->audit_patterns, g_free);
+            config->audit_patterns = g_list_reverse(split_list(optarg, ","));
+            break;
 #ifdef _WIN32
         case 's':
             config->service = optarg;
@@ -1416,6 +1487,8 @@ static void config_free(GAConfig *config)
 #endif
     g_list_free_full(config->blockedrpcs, g_free);
     g_list_free_full(config->allowedrpcs, g_free);
+    g_list_free_full(config->audit_patterns, g_free);
+    g_free(config->auditstr);
     g_free(config);
 }
 
@@ -1459,6 +1532,7 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
     g_assert(ga_state == NULL);
 
     s->log_level = config->log_level;
+    s->audit_patterns = config->audit_patterns;
     s->log_file = stderr;
 #ifdef CONFIG_FSFREEZE
     s->fsfreeze_hook = config->fsfreeze_hook;
@@ -1698,6 +1772,10 @@ int main(int argc, char **argv)
     init_dfl_pathnames();
     config_parse(config, argc, argv);
 
+    if (config->audit_patterns == NULL) {
+        config->audit_patterns = g_list_append(NULL, g_strdup("*"));
+    }
+
     if (config->pid_filepath == NULL) {
         config->pid_filepath = g_strdup(dfl_pathnames.pidfile);
     }
-- 
2.51.0


