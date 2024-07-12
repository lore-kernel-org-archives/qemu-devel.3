Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A078C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGHG-0002T7-EH; Fri, 12 Jul 2024 09:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGH6-0001vl-Qz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGH4-0003kl-27
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeI52+vdkaI59K6ejpX0UAFKYDK7QeGJvRxnrz/9WnI=;
 b=iMNN2BGQ2Ru6nswn4EQMi9l6p1Y5DIrKZxyGB3fGjbckTttTCVYrc8rvu9NalDrvmezCV3
 PZv+qDPWpdgkvYI5moVCgB7Ktftvm4PyncYWWzNFZZEJdrz+aFH145NAn5cuALdQqoJLBJ
 gryJsuJOQcApjqRxPjnZx73TGSrzt1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-hgEFgaRTO3iV-wpK2LsI0A-1; Fri,
 12 Jul 2024 09:25:17 -0400
X-MC-Unique: hgEFgaRTO3iV-wpK2LsI0A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 054BF196CDEF; Fri, 12 Jul 2024 13:25:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8A751955E76; Fri, 12 Jul 2024 13:25:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 03/22] qga: move linux suspend command impls to
 commands-linux.c
Date: Fri, 12 Jul 2024 14:24:40 +0100
Message-ID: <20240712132459.3974109-4-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qmp_guest_suspend_{disk,ram,hybrid} command impls in
commands-posix.c are surrounded by '#ifdef __linux__' so should
instead live in commands-linux.c

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-linux.c | 265 +++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c | 265 -------------------------------------------
 2 files changed, 265 insertions(+), 265 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 78580ac39d..3fabf54882 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -286,6 +286,271 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
 }
 #endif /* CONFIG_FSFREEZE */
 
+
+#define LINUX_SYS_STATE_FILE "/sys/power/state"
+#define SUSPEND_SUPPORTED 0
+#define SUSPEND_NOT_SUPPORTED 1
+
+typedef enum {
+    SUSPEND_MODE_DISK = 0,
+    SUSPEND_MODE_RAM = 1,
+    SUSPEND_MODE_HYBRID = 2,
+} SuspendMode;
+
+/*
+ * Executes a command in a child process using g_spawn_sync,
+ * returning an int >= 0 representing the exit status of the
+ * process.
+ *
+ * If the program wasn't found in path, returns -1.
+ *
+ * If a problem happened when creating the child process,
+ * returns -1 and errp is set.
+ */
+static int run_process_child(const char *command[], Error **errp)
+{
+    int exit_status, spawn_flag;
+    GError *g_err = NULL;
+    bool success;
+
+    spawn_flag = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
+                 G_SPAWN_STDERR_TO_DEV_NULL;
+
+    success =  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
+                            NULL, NULL, NULL, NULL,
+                            &exit_status, &g_err);
+
+    if (success) {
+        return WEXITSTATUS(exit_status);
+    }
+
+    if (g_err && (g_err->code != G_SPAWN_ERROR_NOENT)) {
+        error_setg(errp, "failed to create child process, error '%s'",
+                   g_err->message);
+    }
+
+    g_error_free(g_err);
+    return -1;
+}
+
+static bool systemd_supports_mode(SuspendMode mode, Error **errp)
+{
+    const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
+                                     "systemd-hybrid-sleep"};
+    const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, errp);
+
+    /*
+     * systemctl status uses LSB return codes so we can expect
+     * status > 0 and be ok. To assert if the guest has support
+     * for the selected suspend mode, status should be < 4. 4 is
+     * the code for unknown service status, the return value when
+     * the service does not exist. A common value is status = 3
+     * (program is not running).
+     */
+    if (status > 0 && status < 4) {
+        return true;
+    }
+
+    return false;
+}
+
+static void systemd_suspend(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *systemctl_args[3] = {"hibernate", "suspend", "hybrid-sleep"};
+    const char *cmd[3] = {"systemctl", systemctl_args[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    if (status == 0) {
+        return;
+    }
+
+    if ((status == -1) && !local_err) {
+        error_setg(errp, "the helper program 'systemctl %s' was not found",
+                   systemctl_args[mode]);
+        return;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        error_setg(errp, "the helper program 'systemctl %s' returned an "
+                   "unexpected exit status code (%d)",
+                   systemctl_args[mode], status);
+    }
+}
+
+static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *pmutils_args[3] = {"--hibernate", "--suspend",
+                                   "--suspend-hybrid"};
+    const char *cmd[3] = {"pm-is-supported", pmutils_args[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    if (status == SUSPEND_SUPPORTED) {
+        return true;
+    }
+
+    if ((status == -1) && !local_err) {
+        return false;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        error_setg(errp,
+                   "the helper program '%s' returned an unexpected exit"
+                   " status code (%d)", "pm-is-supported", status);
+    }
+
+    return false;
+}
+
+static void pmutils_suspend(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *pmutils_binaries[3] = {"pm-hibernate", "pm-suspend",
+                                       "pm-suspend-hybrid"};
+    const char *cmd[2] = {pmutils_binaries[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    if (status == 0) {
+        return;
+    }
+
+    if ((status == -1) && !local_err) {
+        error_setg(errp, "the helper program '%s' was not found",
+                   pmutils_binaries[mode]);
+        return;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        error_setg(errp,
+                   "the helper program '%s' returned an unexpected exit"
+                   " status code (%d)", pmutils_binaries[mode], status);
+    }
+}
+
+static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
+{
+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
+    const char *sysfile_str = sysfile_strs[mode];
+    char buf[32]; /* hopefully big enough */
+    int fd;
+    ssize_t ret;
+
+    if (!sysfile_str) {
+        error_setg(errp, "unknown guest suspend mode");
+        return false;
+    }
+
+    fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
+    if (fd < 0) {
+        return false;
+    }
+
+    ret = read(fd, buf, sizeof(buf) - 1);
+    close(fd);
+    if (ret <= 0) {
+        return false;
+    }
+    buf[ret] = '\0';
+
+    if (strstr(buf, sysfile_str)) {
+        return true;
+    }
+    return false;
+}
+
+static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
+{
+    g_autoptr(GError) local_gerr = NULL;
+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
+    const char *sysfile_str = sysfile_strs[mode];
+
+    if (!sysfile_str) {
+        error_setg(errp, "unknown guest suspend mode");
+        return;
+    }
+
+    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
+                             -1, &local_gerr)) {
+        error_setg(errp, "suspend: cannot write to '%s': %s",
+                   LINUX_SYS_STATE_FILE, local_gerr->message);
+        return;
+    }
+}
+
+static void guest_suspend(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    bool mode_supported = false;
+
+    if (systemd_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        systemd_suspend(mode, &local_err);
+
+        if (!local_err) {
+            return;
+        }
+    }
+
+    error_free(local_err);
+    local_err = NULL;
+
+    if (pmutils_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        pmutils_suspend(mode, &local_err);
+
+        if (!local_err) {
+            return;
+        }
+    }
+
+    error_free(local_err);
+    local_err = NULL;
+
+    if (linux_sys_state_supports_mode(mode, &local_err)) {
+        mode_supported = true;
+        linux_sys_state_suspend(mode, &local_err);
+    }
+
+    if (!mode_supported) {
+        error_free(local_err);
+        error_setg(errp,
+                   "the requested suspend mode is not supported by the guest");
+    } else {
+        error_propagate(errp, local_err);
+    }
+}
+
+void qmp_guest_suspend_disk(Error **errp)
+{
+    guest_suspend(SUSPEND_MODE_DISK, errp);
+}
+
+void qmp_guest_suspend_ram(Error **errp)
+{
+    guest_suspend(SUSPEND_MODE_RAM, errp);
+}
+
+void qmp_guest_suspend_hybrid(Error **errp)
+{
+    guest_suspend(SUSPEND_MODE_HYBRID, errp);
+}
+
 /* Transfer online/offline status between @vcpu and the guest system.
  *
  * On input either @errp or *@errp must be NULL.
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index a8ef41f175..ef21da63be 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1738,271 +1738,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 }
 #endif /* CONFIG_FSTRIM */
 
-
-#define LINUX_SYS_STATE_FILE "/sys/power/state"
-#define SUSPEND_SUPPORTED 0
-#define SUSPEND_NOT_SUPPORTED 1
-
-typedef enum {
-    SUSPEND_MODE_DISK = 0,
-    SUSPEND_MODE_RAM = 1,
-    SUSPEND_MODE_HYBRID = 2,
-} SuspendMode;
-
-/*
- * Executes a command in a child process using g_spawn_sync,
- * returning an int >= 0 representing the exit status of the
- * process.
- *
- * If the program wasn't found in path, returns -1.
- *
- * If a problem happened when creating the child process,
- * returns -1 and errp is set.
- */
-static int run_process_child(const char *command[], Error **errp)
-{
-    int exit_status, spawn_flag;
-    GError *g_err = NULL;
-    bool success;
-
-    spawn_flag = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
-                 G_SPAWN_STDERR_TO_DEV_NULL;
-
-    success =  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
-                            NULL, NULL, NULL, NULL,
-                            &exit_status, &g_err);
-
-    if (success) {
-        return WEXITSTATUS(exit_status);
-    }
-
-    if (g_err && (g_err->code != G_SPAWN_ERROR_NOENT)) {
-        error_setg(errp, "failed to create child process, error '%s'",
-                   g_err->message);
-    }
-
-    g_error_free(g_err);
-    return -1;
-}
-
-static bool systemd_supports_mode(SuspendMode mode, Error **errp)
-{
-    const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
-                                     "systemd-hybrid-sleep"};
-    const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
-    int status;
-
-    status = run_process_child(cmd, errp);
-
-    /*
-     * systemctl status uses LSB return codes so we can expect
-     * status > 0 and be ok. To assert if the guest has support
-     * for the selected suspend mode, status should be < 4. 4 is
-     * the code for unknown service status, the return value when
-     * the service does not exist. A common value is status = 3
-     * (program is not running).
-     */
-    if (status > 0 && status < 4) {
-        return true;
-    }
-
-    return false;
-}
-
-static void systemd_suspend(SuspendMode mode, Error **errp)
-{
-    Error *local_err = NULL;
-    const char *systemctl_args[3] = {"hibernate", "suspend", "hybrid-sleep"};
-    const char *cmd[3] = {"systemctl", systemctl_args[mode], NULL};
-    int status;
-
-    status = run_process_child(cmd, &local_err);
-
-    if (status == 0) {
-        return;
-    }
-
-    if ((status == -1) && !local_err) {
-        error_setg(errp, "the helper program 'systemctl %s' was not found",
-                   systemctl_args[mode]);
-        return;
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-    } else {
-        error_setg(errp, "the helper program 'systemctl %s' returned an "
-                   "unexpected exit status code (%d)",
-                   systemctl_args[mode], status);
-    }
-}
-
-static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
-{
-    Error *local_err = NULL;
-    const char *pmutils_args[3] = {"--hibernate", "--suspend",
-                                   "--suspend-hybrid"};
-    const char *cmd[3] = {"pm-is-supported", pmutils_args[mode], NULL};
-    int status;
-
-    status = run_process_child(cmd, &local_err);
-
-    if (status == SUSPEND_SUPPORTED) {
-        return true;
-    }
-
-    if ((status == -1) && !local_err) {
-        return false;
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-    } else {
-        error_setg(errp,
-                   "the helper program '%s' returned an unexpected exit"
-                   " status code (%d)", "pm-is-supported", status);
-    }
-
-    return false;
-}
-
-static void pmutils_suspend(SuspendMode mode, Error **errp)
-{
-    Error *local_err = NULL;
-    const char *pmutils_binaries[3] = {"pm-hibernate", "pm-suspend",
-                                       "pm-suspend-hybrid"};
-    const char *cmd[2] = {pmutils_binaries[mode], NULL};
-    int status;
-
-    status = run_process_child(cmd, &local_err);
-
-    if (status == 0) {
-        return;
-    }
-
-    if ((status == -1) && !local_err) {
-        error_setg(errp, "the helper program '%s' was not found",
-                   pmutils_binaries[mode]);
-        return;
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-    } else {
-        error_setg(errp,
-                   "the helper program '%s' returned an unexpected exit"
-                   " status code (%d)", pmutils_binaries[mode], status);
-    }
-}
-
-static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
-{
-    const char *sysfile_strs[3] = {"disk", "mem", NULL};
-    const char *sysfile_str = sysfile_strs[mode];
-    char buf[32]; /* hopefully big enough */
-    int fd;
-    ssize_t ret;
-
-    if (!sysfile_str) {
-        error_setg(errp, "unknown guest suspend mode");
-        return false;
-    }
-
-    fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
-    if (fd < 0) {
-        return false;
-    }
-
-    ret = read(fd, buf, sizeof(buf) - 1);
-    close(fd);
-    if (ret <= 0) {
-        return false;
-    }
-    buf[ret] = '\0';
-
-    if (strstr(buf, sysfile_str)) {
-        return true;
-    }
-    return false;
-}
-
-static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
-{
-    g_autoptr(GError) local_gerr = NULL;
-    const char *sysfile_strs[3] = {"disk", "mem", NULL};
-    const char *sysfile_str = sysfile_strs[mode];
-
-    if (!sysfile_str) {
-        error_setg(errp, "unknown guest suspend mode");
-        return;
-    }
-
-    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
-                             -1, &local_gerr)) {
-        error_setg(errp, "suspend: cannot write to '%s': %s",
-                   LINUX_SYS_STATE_FILE, local_gerr->message);
-        return;
-    }
-}
-
-static void guest_suspend(SuspendMode mode, Error **errp)
-{
-    Error *local_err = NULL;
-    bool mode_supported = false;
-
-    if (systemd_supports_mode(mode, &local_err)) {
-        mode_supported = true;
-        systemd_suspend(mode, &local_err);
-
-        if (!local_err) {
-            return;
-        }
-    }
-
-    error_free(local_err);
-    local_err = NULL;
-
-    if (pmutils_supports_mode(mode, &local_err)) {
-        mode_supported = true;
-        pmutils_suspend(mode, &local_err);
-
-        if (!local_err) {
-            return;
-        }
-    }
-
-    error_free(local_err);
-    local_err = NULL;
-
-    if (linux_sys_state_supports_mode(mode, &local_err)) {
-        mode_supported = true;
-        linux_sys_state_suspend(mode, &local_err);
-    }
-
-    if (!mode_supported) {
-        error_free(local_err);
-        error_setg(errp,
-                   "the requested suspend mode is not supported by the guest");
-    } else {
-        error_propagate(errp, local_err);
-    }
-}
-
-void qmp_guest_suspend_disk(Error **errp)
-{
-    guest_suspend(SUSPEND_MODE_DISK, errp);
-}
-
-void qmp_guest_suspend_ram(Error **errp)
-{
-    guest_suspend(SUSPEND_MODE_RAM, errp);
-}
-
-void qmp_guest_suspend_hybrid(Error **errp)
-{
-    guest_suspend(SUSPEND_MODE_HYBRID, errp);
-}
-
 #endif /* __linux__ */
 
 #if defined(__linux__) || defined(__FreeBSD__)
-- 
2.45.1


