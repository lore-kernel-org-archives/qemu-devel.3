Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E2C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8LF-0003ff-Qp; Thu, 06 Jun 2024 04:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8LE-0003fX-AF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:19:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8L9-0000rD-Uu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:19:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dbfe31905so659159f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717661956; x=1718266756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OyXcp8vrclFr1oJUz8AG9k8Q0P9TnGe2LT290Okjq30=;
 b=PGY+sQShgWCppRHo/6BJ5f+/6IIuNPufXhLVosJaNpUtWHoWPF5dsJmvXofKqwC2ZP
 Y5j43lpN3vaA3YUPP9TW0nKLU9rXkZ4JbpsFcrljVG8w54sxUEv2A3Uu43C/vFuWfMdD
 lSNI8V9R65ri9ua2Il7MOFF7huJGc35fUhQBzF0MU65estDG1vX/mCIA5cwn5wZxAoJ+
 DOIyIhqFFmxeP9zqDTBCr5OqHzg4BWhFPzdl5SHAyTGQc1oM67hcyqfGOrr1e3gpq/TY
 tFaoWQBNsJM2QasMmRGun318Bkg51G8jvwsc/VvU955ZI5pIZmidoku+zEIzJIsYH+gA
 HDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661956; x=1718266756;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyXcp8vrclFr1oJUz8AG9k8Q0P9TnGe2LT290Okjq30=;
 b=eMUTpyDBECftasLwMjma67ygsYQwfMK0c9+Q8e5+ZojajIC/uKMWfkAJSupp2mWXkW
 FyX5tqMp5CxCqW8EWspuCj2MxwLCQkoaG+ZiEbHWA4VXdU/QhEg3Al0bXEbl1Ie2526R
 AzKQmExUFR0O4UrLoDq9D+/IUr9JdQPwvgEBtzxJBnY71f/2Mf0HWul4wNqNh39uN5vp
 dAZaaRy70n4A1PnUGWyFnQEtJCqfqUTNQrSpbqZfrNCNzRwsLTEAPvVexvjJ3/NPoKgU
 aaKFIZJ8+N4BfG8auxOLSucB8MZ8g6HYiKIKrSux1Ir08Dj8yaYW3hx+CaRhixTmO5Vl
 njPQ==
X-Gm-Message-State: AOJu0YyAjzhTsx4tv2SeVDSW7/SlJqh4ksLCGbJGzmdTDfqXPIFyhnyi
 TqsHEQH0lJCPAAMGZ7aw1KJec8YsOaFzQBjWqK8P54PkXgHuif3sAzws+WeDwIa5HoiSeR0wDeh
 czsY=
X-Google-Smtp-Source: AGHT+IE97331mLZSHQB8hrUSEys/D6bhzp6eX8AZvtod6V7LmQYio/jqxCGWiM3Gvc4J2zKbRwWzyA==
X-Received: by 2002:a05:6000:8a:b0:355:21f:be1f with SMTP id
 ffacd0b85a97d-35e84062d42mr3346704f8f.4.1717661956448; 
 Thu, 06 Jun 2024 01:19:16 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm888955f8f.50.2024.06.06.01.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:19:16 -0700 (PDT)
Date: Thu, 06 Jun 2024 11:17:39 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 03/20] qga: move linux suspend command impls to
 commands-linux.c
User-Agent: meli 0.8.5
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-4-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-4-berrange@redhat.com>
Message-ID: <engg2.ezubxa8t1lxg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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

On Tue, 04 Jun 2024 16:49, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>The qmp_guest_suspend_{disk,ram,hybrid} command impls in
>commands-posix.c are surrounded by '#ifdef __linux__' so should
>instead live in commands-linux.c
>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> qga/commands-linux.c | 265 +++++++++++++++++++++++++++++++++++++++++++
> qga/commands-posix.c | 265 -------------------------------------------
> 2 files changed, 265 insertions(+), 265 deletions(-)
>
>diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>index 78580ac39d..3fabf54882 100644
>--- a/qga/commands-linux.c
>+++ b/qga/commands-linux.c
>@@ -286,6 +286,271 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
> }
> #endif /* CONFIG_FSFREEZE */
> 
>+
>+#define LINUX_SYS_STATE_FILE "/sys/power/state"
>+#define SUSPEND_SUPPORTED 0
>+#define SUSPEND_NOT_SUPPORTED 1
>+
>+typedef enum {
>+    SUSPEND_MODE_DISK = 0,
>+    SUSPEND_MODE_RAM = 1,
>+    SUSPEND_MODE_HYBRID = 2,
>+} SuspendMode;
>+
>+/*
>+ * Executes a command in a child process using g_spawn_sync,
>+ * returning an int >= 0 representing the exit status of the
>+ * process.
>+ *
>+ * If the program wasn't found in path, returns -1.
>+ *
>+ * If a problem happened when creating the child process,
>+ * returns -1 and errp is set.
>+ */
>+static int run_process_child(const char *command[], Error **errp)
>+{
>+    int exit_status, spawn_flag;
>+    GError *g_err = NULL;
>+    bool success;
>+
>+    spawn_flag = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
>+                 G_SPAWN_STDERR_TO_DEV_NULL;
>+
>+    success =  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
>+                            NULL, NULL, NULL, NULL,
>+                            &exit_status, &g_err);
>+
>+    if (success) {
>+        return WEXITSTATUS(exit_status);
>+    }
>+
>+    if (g_err && (g_err->code != G_SPAWN_ERROR_NOENT)) {
>+        error_setg(errp, "failed to create child process, error '%s'",
>+                   g_err->message);
>+    }
>+
>+    g_error_free(g_err);
>+    return -1;
>+}
>+
>+static bool systemd_supports_mode(SuspendMode mode, Error **errp)
>+{
>+    const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
>+                                     "systemd-hybrid-sleep"};
>+    const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
>+    int status;
>+
>+    status = run_process_child(cmd, errp);
>+
>+    /*
>+     * systemctl status uses LSB return codes so we can expect
>+     * status > 0 and be ok. To assert if the guest has support
>+     * for the selected suspend mode, status should be < 4. 4 is
>+     * the code for unknown service status, the return value when
>+     * the service does not exist. A common value is status = 3
>+     * (program is not running).
>+     */
>+    if (status > 0 && status < 4) {
>+        return true;
>+    }
>+
>+    return false;
>+}
>+
>+static void systemd_suspend(SuspendMode mode, Error **errp)
>+{
>+    Error *local_err = NULL;
>+    const char *systemctl_args[3] = {"hibernate", "suspend", "hybrid-sleep"};
>+    const char *cmd[3] = {"systemctl", systemctl_args[mode], NULL};
>+    int status;
>+
>+    status = run_process_child(cmd, &local_err);
>+
>+    if (status == 0) {
>+        return;
>+    }
>+
>+    if ((status == -1) && !local_err) {
>+        error_setg(errp, "the helper program 'systemctl %s' was not found",
>+                   systemctl_args[mode]);
>+        return;
>+    }
>+
>+    if (local_err) {
>+        error_propagate(errp, local_err);
>+    } else {
>+        error_setg(errp, "the helper program 'systemctl %s' returned an "
>+                   "unexpected exit status code (%d)",
>+                   systemctl_args[mode], status);
>+    }
>+}
>+
>+static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
>+{
>+    Error *local_err = NULL;
>+    const char *pmutils_args[3] = {"--hibernate", "--suspend",
>+                                   "--suspend-hybrid"};
>+    const char *cmd[3] = {"pm-is-supported", pmutils_args[mode], NULL};
>+    int status;
>+
>+    status = run_process_child(cmd, &local_err);
>+
>+    if (status == SUSPEND_SUPPORTED) {
>+        return true;
>+    }
>+
>+    if ((status == -1) && !local_err) {
>+        return false;
>+    }
>+
>+    if (local_err) {
>+        error_propagate(errp, local_err);
>+    } else {
>+        error_setg(errp,
>+                   "the helper program '%s' returned an unexpected exit"
>+                   " status code (%d)", "pm-is-supported", status);
>+    }
>+
>+    return false;
>+}
>+
>+static void pmutils_suspend(SuspendMode mode, Error **errp)
>+{
>+    Error *local_err = NULL;
>+    const char *pmutils_binaries[3] = {"pm-hibernate", "pm-suspend",
>+                                       "pm-suspend-hybrid"};
>+    const char *cmd[2] = {pmutils_binaries[mode], NULL};
>+    int status;
>+
>+    status = run_process_child(cmd, &local_err);
>+
>+    if (status == 0) {
>+        return;
>+    }
>+
>+    if ((status == -1) && !local_err) {
>+        error_setg(errp, "the helper program '%s' was not found",
>+                   pmutils_binaries[mode]);
>+        return;
>+    }
>+
>+    if (local_err) {
>+        error_propagate(errp, local_err);
>+    } else {
>+        error_setg(errp,
>+                   "the helper program '%s' returned an unexpected exit"
>+                   " status code (%d)", pmutils_binaries[mode], status);
>+    }
>+}
>+
>+static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
>+{
>+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
>+    const char *sysfile_str = sysfile_strs[mode];
>+    char buf[32]; /* hopefully big enough */
>+    int fd;
>+    ssize_t ret;
>+
>+    if (!sysfile_str) {
>+        error_setg(errp, "unknown guest suspend mode");
>+        return false;
>+    }
>+
>+    fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
>+    if (fd < 0) {
>+        return false;
>+    }
>+
>+    ret = read(fd, buf, sizeof(buf) - 1);
>+    close(fd);
>+    if (ret <= 0) {
>+        return false;
>+    }
>+    buf[ret] = '\0';
>+
>+    if (strstr(buf, sysfile_str)) {
>+        return true;
>+    }
>+    return false;
>+}
>+
>+static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>+{
>+    g_autoptr(GError) local_gerr = NULL;
>+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
>+    const char *sysfile_str = sysfile_strs[mode];
>+
>+    if (!sysfile_str) {
>+        error_setg(errp, "unknown guest suspend mode");
>+        return;
>+    }
>+
>+    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
>+                             -1, &local_gerr)) {
>+        error_setg(errp, "suspend: cannot write to '%s': %s",
>+                   LINUX_SYS_STATE_FILE, local_gerr->message);
>+        return;
>+    }
>+}
>+
>+static void guest_suspend(SuspendMode mode, Error **errp)
>+{
>+    Error *local_err = NULL;
>+    bool mode_supported = false;
>+
>+    if (systemd_supports_mode(mode, &local_err)) {
>+        mode_supported = true;
>+        systemd_suspend(mode, &local_err);
>+
>+        if (!local_err) {
>+            return;
>+        }
>+    }
>+
>+    error_free(local_err);
>+    local_err = NULL;
>+
>+    if (pmutils_supports_mode(mode, &local_err)) {
>+        mode_supported = true;
>+        pmutils_suspend(mode, &local_err);
>+
>+        if (!local_err) {
>+            return;
>+        }
>+    }
>+
>+    error_free(local_err);
>+    local_err = NULL;
>+
>+    if (linux_sys_state_supports_mode(mode, &local_err)) {
>+        mode_supported = true;
>+        linux_sys_state_suspend(mode, &local_err);
>+    }
>+
>+    if (!mode_supported) {
>+        error_free(local_err);
>+        error_setg(errp,
>+                   "the requested suspend mode is not supported by the guest");
>+    } else {
>+        error_propagate(errp, local_err);
>+    }
>+}
>+
>+void qmp_guest_suspend_disk(Error **errp)
>+{
>+    guest_suspend(SUSPEND_MODE_DISK, errp);
>+}
>+
>+void qmp_guest_suspend_ram(Error **errp)
+{
>+    guest_suspend(SUSPEND_MODE_RAM, errp);
>+}
>+
>+void qmp_guest_suspend_hybrid(Error **errp)
>+{
>+    guest_suspend(SUSPEND_MODE_HYBRID, errp);
>+}
>+
> /* Transfer online/offline status between @vcpu and the guest system.
>  *
>  * On input either @errp or *@errp must be NULL.
>diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>index a8ef41f175..ef21da63be 100644
>--- a/qga/commands-posix.c
>+++ b/qga/commands-posix.c
>@@ -1738,271 +1738,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
> }
> #endif /* CONFIG_FSTRIM */
> 
>-
>-#define LINUX_SYS_STATE_FILE "/sys/power/state"
>-#define SUSPEND_SUPPORTED 0
>-#define SUSPEND_NOT_SUPPORTED 1
>-
>-typedef enum {
>-    SUSPEND_MODE_DISK = 0,
>-    SUSPEND_MODE_RAM = 1,
>-    SUSPEND_MODE_HYBRID = 2,
>-} SuspendMode;
>-
>-/*
>- * Executes a command in a child process using g_spawn_sync,
>- * returning an int >= 0 representing the exit status of the
>- * process.
>- *
>- * If the program wasn't found in path, returns -1.
>- *
>- * If a problem happened when creating the child process,
>- * returns -1 and errp is set.
>- */
>-static int run_process_child(const char *command[], Error **errp)
>-{
>-    int exit_status, spawn_flag;
>-    GError *g_err = NULL;
>-    bool success;
>-
>-    spawn_flag = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
>-                 G_SPAWN_STDERR_TO_DEV_NULL;
>-
>-    success =  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
>-                            NULL, NULL, NULL, NULL,
>-                            &exit_status, &g_err);
>-
>-    if (success) {
>-        return WEXITSTATUS(exit_status);
>-    }
>-
>-    if (g_err && (g_err->code != G_SPAWN_ERROR_NOENT)) {
>-        error_setg(errp, "failed to create child process, error '%s'",
>-                   g_err->message);
>-    }
>-
>-    g_error_free(g_err);
>-    return -1;
>-}
>-
>-static bool systemd_supports_mode(SuspendMode mode, Error **errp)
>-{
>-    const char *systemctl_args[3] = {"systemd-hibernate", "systemd-suspend",
>-                                     "systemd-hybrid-sleep"};
>-    const char *cmd[4] = {"systemctl", "status", systemctl_args[mode], NULL};
>-    int status;
>-
>-    status = run_process_child(cmd, errp);
>-
>-    /*
>-     * systemctl status uses LSB return codes so we can expect
>-     * status > 0 and be ok. To assert if the guest has support
>-     * for the selected suspend mode, status should be < 4. 4 is
>-     * the code for unknown service status, the return value when
>-     * the service does not exist. A common value is status = 3
>-     * (program is not running).
>-     */
>-    if (status > 0 && status < 4) {
>-        return true;
>-    }
>-
>-    return false;
>-}
>-
>-static void systemd_suspend(SuspendMode mode, Error **errp)
>-{
>-    Error *local_err = NULL;
>-    const char *systemctl_args[3] = {"hibernate", "suspend", "hybrid-sleep"};
>-    const char *cmd[3] = {"systemctl", systemctl_args[mode], NULL};
>-    int status;
>-
>-    status = run_process_child(cmd, &local_err);
>-
>-    if (status == 0) {
>-        return;
>-    }
>-
>-    if ((status == -1) && !local_err) {
>-        error_setg(errp, "the helper program 'systemctl %s' was not found",
>-                   systemctl_args[mode]);
>-        return;
>-    }
>-
>-    if (local_err) {
>-        error_propagate(errp, local_err);
>-    } else {
>-        error_setg(errp, "the helper program 'systemctl %s' returned an "
>-                   "unexpected exit status code (%d)",
>-                   systemctl_args[mode], status);
>-    }
>-}
>-
>-static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
>-{
>-    Error *local_err = NULL;
>-    const char *pmutils_args[3] = {"--hibernate", "--suspend",
>-                                   "--suspend-hybrid"};
>-    const char *cmd[3] = {"pm-is-supported", pmutils_args[mode], NULL};
>-    int status;
>-
>-    status = run_process_child(cmd, &local_err);
>-
>-    if (status == SUSPEND_SUPPORTED) {
>-        return true;
>-    }
>-
>-    if ((status == -1) && !local_err) {
>-        return false;
>-    }
>-
>-    if (local_err) {
>-        error_propagate(errp, local_err);
>-    } else {
>-        error_setg(errp,
>-                   "the helper program '%s' returned an unexpected exit"
>-                   " status code (%d)", "pm-is-supported", status);
>-    }
>-
>-    return false;
>-}
>-
>-static void pmutils_suspend(SuspendMode mode, Error **errp)
>-{
>-    Error *local_err = NULL;
>-    const char *pmutils_binaries[3] = {"pm-hibernate", "pm-suspend",
>-                                       "pm-suspend-hybrid"};
>-    const char *cmd[2] = {pmutils_binaries[mode], NULL};
>-    int status;
>-
>-    status = run_process_child(cmd, &local_err);
>-
>-    if (status == 0) {
>-        return;
>-    }
>-
>-    if ((status == -1) && !local_err) {
>-        error_setg(errp, "the helper program '%s' was not found",
>-                   pmutils_binaries[mode]);
>-        return;
>-    }
>-
>-    if (local_err) {
>-        error_propagate(errp, local_err);
>-    } else {
>-        error_setg(errp,
>-                   "the helper program '%s' returned an unexpected exit"
>-                   " status code (%d)", pmutils_binaries[mode], status);
>-    }
>-}
>-
>-static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
>-{
>-    const char *sysfile_strs[3] = {"disk", "mem", NULL};
>-    const char *sysfile_str = sysfile_strs[mode];
>-    char buf[32]; /* hopefully big enough */
>-    int fd;
>-    ssize_t ret;
>-
>-    if (!sysfile_str) {
>-        error_setg(errp, "unknown guest suspend mode");
>-        return false;
>-    }
>-
>-    fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
>-    if (fd < 0) {
>-        return false;
>-    }
>-
>-    ret = read(fd, buf, sizeof(buf) - 1);
>-    close(fd);
>-    if (ret <= 0) {
>-        return false;
>-    }
>-    buf[ret] = '\0';
>-
>-    if (strstr(buf, sysfile_str)) {
>-        return true;
>-    }
>-    return false;
>-}
>-
>-static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>-{
>-    g_autoptr(GError) local_gerr = NULL;
>-    const char *sysfile_strs[3] = {"disk", "mem", NULL};
>-    const char *sysfile_str = sysfile_strs[mode];
>-
>-    if (!sysfile_str) {
>-        error_setg(errp, "unknown guest suspend mode");
>-        return;
>-    }
>-
>-    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
>-                             -1, &local_gerr)) {
>-        error_setg(errp, "suspend: cannot write to '%s': %s",
>-                   LINUX_SYS_STATE_FILE, local_gerr->message);
>-        return;
>-    }
>-}
>-
>-static void guest_suspend(SuspendMode mode, Error **errp)
>-{
>-    Error *local_err = NULL;
>-    bool mode_supported = false;
>-
>-    if (systemd_supports_mode(mode, &local_err)) {
>-        mode_supported = true;
>-        systemd_suspend(mode, &local_err);
>-
>-        if (!local_err) {
>-            return;
>-        }
>-    }
>-
>-    error_free(local_err);
>-    local_err = NULL;
>-
>-    if (pmutils_supports_mode(mode, &local_err)) {
>-        mode_supported = true;
>-        pmutils_suspend(mode, &local_err);
>-
>-        if (!local_err) {
>-            return;
>-        }
>-    }
>-
>-    error_free(local_err);
>-    local_err = NULL;
>-
>-    if (linux_sys_state_supports_mode(mode, &local_err)) {
>-        mode_supported = true;
>-        linux_sys_state_suspend(mode, &local_err);
>-    }
>-
>-    if (!mode_supported) {
>-        error_free(local_err);
>-        error_setg(errp,
>-                   "the requested suspend mode is not supported by the guest");
>-    } else {
>-        error_propagate(errp, local_err);
>-    }
>-}
>-
>-void qmp_guest_suspend_disk(Error **errp)
>-{
>-    guest_suspend(SUSPEND_MODE_DISK, errp);
>-}
>-
>-void qmp_guest_suspend_ram(Error **errp)
>-{
>-    guest_suspend(SUSPEND_MODE_RAM, errp);
>-}
>-
>-void qmp_guest_suspend_hybrid(Error **errp)
>-{
>-    guest_suspend(SUSPEND_MODE_HYBRID, errp);
>-}
>-
> #endif /* __linux__ */
> 
> #if defined(__linux__) || defined(__FreeBSD__)
>-- 
>2.45.1
>
>

