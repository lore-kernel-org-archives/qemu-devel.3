Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A91067034
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gr1-00057r-4z; Thu, 12 Mar 2026 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w0gqx-00057J-89
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w0gqu-0005gU-8T
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773325044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CcGz6pNTKWsGA2wDTrRYtn08jywOQTf+sdHFBdEH9w=;
 b=NtlB2Pf8KYIO/sZpqJkKwx23eh6jhZWNheW/WkiGaIqlwy5TRWLT5NKiPeeBD3JniI92Qp
 Wwi0IMJKeJd2RWj4PjVPW9WX5+xru3xw1mDlp5zvSRnngUUZBTGXdKHHwUKpNDnW7/+Pyr
 kdH6gF7RHLet6hljM3/ICJGz3QlJ6Kk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-A4qPo_P4MdWw83w4uhCtBA-1; Thu,
 12 Mar 2026 10:17:23 -0400
X-MC-Unique: A4qPo_P4MdWw83w4uhCtBA-1
X-Mimecast-MFC-AGG-ID: A4qPo_P4MdWw83w4uhCtBA_1773325042
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 491671945104
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:17:22 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.45.226.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8001A19560B7; Thu, 12 Mar 2026 14:17:20 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, berrange@redhat.com,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v1] qga: rework slog to support multiple severity levels
Date: Thu, 12 Mar 2026 16:16:57 +0200
Message-ID: <20260312141657.1701801-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ga_log() forwarded all "syslog" domain messages unconditionally,
bypassing the log level filter. Furthermore, slog() hardcoded
all messages to G_LOG_LEVEL_INFO, causing log spam from frequent
guest-ping calls.

- Split slog() into slog_error() (WARNING), slog() (MESSAGE), and slog_trace() (INFO)
- Apply s->log_level filtering to "syslog" in ga_log()
- Move guest-ping to slog_trace()
- Move error messages to slog_error()

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3214

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-linux.c   |  6 ++++--
 qga/commands-posix.c   | 13 +++++++------
 qga/commands-win32.c   | 34 +++++++++++++++++-----------------
 qga/commands.c         | 30 ++++++++++++++++++++++++------
 qga/guest-agent-core.h |  2 ++
 qga/main.c             |  6 +++++-
 6 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 378f4d080c..b924e44517 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -44,7 +44,8 @@ static int dev_major_minor(const char *devpath,
     *devminor = 0;
 
     if (stat(devpath, &st) < 0) {
-        slog("failed to stat device file '%s': %s", devpath, strerror(errno));
+        slog_error("failed to stat device file '%s': %s",
+                   devpath, strerror(errno));
         return -1;
     }
     if (S_ISDIR(st.st_mode)) {
@@ -2072,7 +2073,8 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
         }
 
         if (i < 5) {
-            slog("Parsing cpu stat from %s failed, see \"man proc\"", cpustats);
+            slog_error("Parsing cpu stat from %s failed, see \"man proc\"",
+                       cpustats);
             break;
         }
 
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..e7dc92fed0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -645,7 +645,7 @@ GuestFileWrite *qmp_guest_file_write(int64_t handle, const char *buf_b64,
     write_count = fwrite(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to write to file");
-        slog("guest-file-write failed, handle: %" PRId64, handle);
+        slog_error("guest-file-write failed, handle: %" PRId64, handle);
     } else {
         write_data = g_new0(GuestFileWrite, 1);
         write_data->count = write_count;
@@ -849,8 +849,8 @@ static void guest_fsfreeze_cleanup(void)
     if (ga_is_frozen(ga_state) == GUEST_FSFREEZE_STATUS_FROZEN) {
         qmp_guest_fsfreeze_thaw(&err);
         if (err) {
-            slog("failed to clean up frozen filesystems: %s",
-                 error_get_pretty(err));
+            slog_error("failed to clean up frozen filesystems: %s",
+                       error_get_pretty(err));
             error_free(err);
         }
     }
@@ -1282,19 +1282,20 @@ static GKeyFile *ga_parse_osrelease(const char *fname)
     const char *group = "[os-release]\n";
 
     if (!g_file_get_contents(fname, &content, NULL, &err)) {
-        slog("failed to read '%s', error: %s", fname, err->message);
+        slog_error("failed to read '%s', error: %s", fname, err->message);
         goto fail;
     }
 
     if (!g_utf8_validate(content, -1, NULL)) {
-        slog("file is not utf-8 encoded: %s", fname);
+        slog_error("file is not utf-8 encoded: %s", fname);
         goto fail;
     }
     content2 = g_strdup_printf("%s%s", group, content);
 
     if (!g_key_file_load_from_data(keys, content2, -1, G_KEY_FILE_NONE,
                                    &err)) {
-        slog("failed to parse file '%s', error: %s", fname, err->message);
+        slog_error("failed to parse file '%s', error: %s", fname,
+                   err->message);
         goto fail;
     }
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..cada3135fc 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -361,7 +361,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 
     if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
         g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        slog("guest-shutdown failed: %s", emsg);
+        slog_error("guest-shutdown failed: %s", emsg);
         error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
     }
 }
@@ -426,7 +426,7 @@ GuestFileWrite *qmp_guest_file_write(int64_t handle, const char *buf_b64,
     is_ok = WriteFile(fh, buf, count, &write_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to write to file");
-        slog("guest-file-write-failed, handle: %" PRId64, handle);
+        slog_error("guest-file-write-failed, handle: %" PRId64, handle);
     } else {
         write_data = g_new0(GuestFileWrite, 1);
         write_data->count = (size_t) write_count;
@@ -1310,8 +1310,8 @@ static void guest_fsfreeze_cleanup(void)
     if (ga_is_frozen(ga_state) == GUEST_FSFREEZE_STATUS_FROZEN) {
         qmp_guest_fsfreeze_thaw(&err);
         if (err) {
-            slog("failed to clean up frozen filesystems: %s",
-                 error_get_pretty(err));
+            slog_error("failed to clean up frozen filesystems: %s",
+                   error_get_pretty(err));
             error_free(err);
         }
     }
@@ -1464,7 +1464,7 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
 
     if (!SetSuspendState(*mode == GUEST_SUSPEND_MODE_DISK, TRUE, TRUE)) {
         g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        slog("failed to suspend guest: %s", emsg);
+        slog_error("failed to suspend guest: %s", emsg);
         ret = -1;
     }
     g_free(mode);
@@ -2174,8 +2174,8 @@ static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)
         }
         ++table;
     }
-    slog("failed to lookup Windows version: major=%lu, minor=%lu",
-        major, minor);
+    slog_error("failed to lookup Windows version: major=%lu, minor=%lu",
+               major, minor);
     return g_strdup("N/A");
 }
 
@@ -2244,8 +2244,8 @@ static char *ga_get_current_arch(void)
         break;
     case PROCESSOR_ARCHITECTURE_UNKNOWN:
     default:
-        slog("unknown processor architecture 0x%0x",
-            info.wProcessorArchitecture);
+        slog_error("unknown processor architecture 0x%0x",
+                   info.wProcessorArchitecture);
         result = g_strdup("unknown");
         break;
     }
@@ -2308,14 +2308,14 @@ static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propName,
         buffer, &buffer_len, 0);
     if (cr != CR_SUCCESS && cr != CR_BUFFER_SMALL) {
 
-        slog("failed to get property size, error=0x%lx", cr);
+        slog_error("failed to get property size, error=0x%lx", cr);
         return NULL;
     }
     buffer = g_new0(BYTE, buffer_len + 1);
     cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
         buffer, &buffer_len, 0);
     if (cr != CR_SUCCESS) {
-        slog("failed to get device property, error=0x%lx", cr);
+        slog_error("failed to get device property, error=0x%lx", cr);
         return NULL;
     }
     return g_steal_pointer(&buffer);
@@ -2329,7 +2329,7 @@ static GStrv ga_get_hardware_ids(DEVINST devInstance)
     g_autofree LPWSTR property = (LPWSTR)cm_get_property(devInstance,
         &qga_DEVPKEY_Device_HardwareIds, &cm_type);
     if (property == NULL) {
-        slog("failed to get hardware IDs");
+        slog_error("failed to get hardware IDs");
         return NULL;
     }
     if (*property == '\0') {
@@ -2385,7 +2385,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         name = (LPWSTR)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_NAME, &cm_type);
         if (name == NULL) {
-            slog("failed to get device description");
+            slog_error("failed to get device description");
             continue;
         }
         device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL, NULL);
@@ -2424,7 +2424,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         version = (LPWSTR)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_Device_DriverVersion, &cm_type);
         if (version == NULL) {
-            slog("failed to get driver version");
+            slog_error("failed to get driver version");
             continue;
         }
         device->driver_version = g_utf16_to_utf8(version, -1, NULL,
@@ -2437,7 +2437,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         date = (LPFILETIME)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_Device_DriverDate, &cm_type);
         if (date == NULL) {
-            slog("failed to get driver date");
+            slog_error("failed to get driver date");
             continue;
         }
         device->driver_date = filetime_to_ns(date);
@@ -2479,8 +2479,8 @@ static VOID CALLBACK load_avg_callback(PVOID hCounter, BOOLEAN timedOut)
         (PDH_HCOUNTER)hCounter, PDH_FMT_DOUBLE, 0, &displayValue);
     /* Skip updating the load if we can't get the value successfully */
     if (err != ERROR_SUCCESS) {
-        slog("PdhGetFormattedCounterValue failed to get load value with 0x%lx",
-             err);
+        slog_error("PdhGetFormattedCounterValue failed to get load value"
+                   " with 0x%lx", err);
         return;
     }
     currentLoad = displayValue.doubleValue;
diff --git a/qga/commands.c b/qga/commands.c
index 5f20af25d3..ed52a7d3c2 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -38,6 +38,24 @@ void slog(const gchar *fmt, ...)
 {
     va_list ap;
 
+    va_start(ap, fmt);
+    g_logv("syslog", G_LOG_LEVEL_MESSAGE, fmt, ap);
+    va_end(ap);
+}
+
+void slog_error(const gchar *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    g_logv("syslog", G_LOG_LEVEL_WARNING, fmt, ap);
+    va_end(ap);
+}
+
+void slog_trace(const gchar *fmt, ...)
+{
+    va_list ap;
+
     va_start(ap, fmt);
     g_logv("syslog", G_LOG_LEVEL_INFO, fmt, ap);
     va_end(ap);
@@ -56,7 +74,7 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)
 
 void qmp_guest_ping(Error **errp)
 {
-    slog("guest-ping called");
+    slog_trace("guest-ping called");
 }
 
 static void qmp_command_info(const QmpCommand *cmd, void *opaque)
@@ -285,8 +303,8 @@ static void guest_exec_task_setup(gpointer data)
          * inside the parent, not the child.
          */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) != 0) {
-            slog("dup2() failed to merge stderr into stdout: %s",
-                 strerror(errno));
+            slog_error("dup2() failed to merge stderr into stdout: %s",
+                       strerror(errno));
         }
     }
 
@@ -295,8 +313,8 @@ static void guest_exec_task_setup(gpointer data)
     sigact.sa_handler = SIG_DFL;
 
     if (sigaction(SIGPIPE, &sigact, NULL) != 0) {
-        slog("sigaction() failed to reset child process's SIGPIPE: %s",
-             strerror(errno));
+        slog_error("sigaction() failed to reset child process's SIGPIPE: %s",
+                   strerror(errno));
     }
 #endif
 }
@@ -626,7 +644,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
 
     read_data = guest_file_read_unsafe(gfh, count, errp);
     if (!read_data) {
-        slog("guest-file-write failed, handle: %" PRId64, handle);
+        slog_error("guest-file-write failed, handle: %" PRId64, handle);
     }
 
     return read_data;
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index d9f3922adf..7c50e43dfc 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -41,6 +41,8 @@ bool ga_logging_enabled(GAState *s);
 void ga_disable_logging(GAState *s);
 void ga_enable_logging(GAState *s);
 void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
+void G_GNUC_PRINTF(1, 2) slog_error(const gchar *fmt, ...);
+void G_GNUC_PRINTF(1, 2) slog_trace(const gchar *fmt, ...);
 void ga_set_response_delimited(GAState *s);
 bool ga_is_frozen(GAState *s);
 void ga_set_frozen(GAState *s);
diff --git a/qga/main.c b/qga/main.c
index fd19c7037d..bc786593fd 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -392,6 +392,9 @@ static void ga_log(const gchar *domain, GLogLevelFlags level,
 
     level &= G_LOG_LEVEL_MASK;
     if (g_strcmp0(domain, "syslog") == 0) {
+        if (!(level & s->log_level)) {
+            return;
+        }
 #ifndef _WIN32
         syslog(glib_log_level_to_system(level), "%s: %s", level_str, msg);
 #else
@@ -1673,7 +1676,8 @@ int main(int argc, char **argv)
     GAConfig *config = g_new0(GAConfig, 1);
     int socket_activation;
 
-    config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
+    config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL
+                      | G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE;
 
     qemu_init_exec_dir(argv[0]);
     qga_qmp_init_marshal(&ga_commands);
-- 
2.51.0


