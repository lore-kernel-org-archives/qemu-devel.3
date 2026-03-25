Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5E7103A9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5M7C-00018k-B6; Wed, 25 Mar 2026 07:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w5M7A-00018X-Jx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w5M77-0002hu-NN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774436968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ER+6eVy2i8wo+kSqgzP5AtDhQyBhdJZqwozpLL45S7s=;
 b=NYZ96IRoh4S1Vz7E5Fv9jXFQUSnWnWxBZBy7wXHkPC7TeKraZw0EHbrjAKtLFARZ4CoiZX
 fJQd46xlaTC1W3SujPuAdshaFCfOYqeB3vjaS0nnTIbWztn+sojOd32MGlLwfgahHal+8M
 pbnqFe05WcVDUNXQDYqQpq6/+UkLJ90=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-xTmRGIJQMa-XM35wnQ723Q-1; Wed,
 25 Mar 2026 07:09:26 -0400
X-MC-Unique: xTmRGIJQMa-XM35wnQ723Q-1
X-Mimecast-MFC-AGG-ID: xTmRGIJQMa-XM35wnQ723Q_1774436966
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1A70180034F
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 11:09:25 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.180])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E758D1955F2E; Wed, 25 Mar 2026 11:09:23 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kkostiuk@redhat.com, yvugenfi@redhat.com,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v3 1/2] qga: replace slog() with standard GLib logging
Date: Wed, 25 Mar 2026 13:08:59 +0200
Message-ID: <20260325110900.2065942-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace qga-specific slog() calls with standard GLib logging APIs.
Use g_info() for command execution messages and g_warning() for
non-fatal failures, and remove the use of "syslog" as a log domain.

Rework ga_log() to route messages to the log file and
syslog/Event Viewer, filtering by log level. Debug messages are
excluded from syslog even with --debug.

- Default log level includes ERROR, CRITICAL, and WARNING
- -v/--verbose enables MESSAGE and INFO
- --debug enables all levels including DEBUG

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-linux.c   |  6 ++---
 qga/commands-posix.c   | 26 +++++++++---------
 qga/commands-win32.c   | 60 +++++++++++++++++++++---------------------
 qga/commands.c         | 29 ++++++--------------
 qga/guest-agent-core.h |  1 -
 qga/main.c             | 39 +++++++++++++++++++--------
 6 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 378f4d080c..a722de2e6a 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -44,7 +44,7 @@ static int dev_major_minor(const char *devpath,
     *devminor = 0;
 
     if (stat(devpath, &st) < 0) {
-        slog("failed to stat device file '%s': %s", devpath, strerror(errno));
+        g_warning("failed to stat device file '%s': %s", devpath, strerror(errno));
         return -1;
     }
     if (S_ISDIR(st.st_mode)) {
@@ -1158,7 +1158,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
     int fd;
     struct fstrim_range r;
 
-    slog("guest-fstrim called");
+    g_info("guest-fstrim called");
 
     QTAILQ_INIT(&mounts);
     if (!build_fs_mount_list(&mounts, errp)) {
@@ -2072,7 +2072,7 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
         }
 
         if (i < 5) {
-            slog("Parsing cpu stat from %s failed, see \"man proc\"", cpustats);
+            g_warning("Parsing cpu stat from %s failed, see \"man proc\"", cpustats);
             break;
         }
 
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..96939a6f36 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
     const char *reboot_flag = "-r";
 #endif
 
-    slog("guest-shutdown called, mode: %s", mode);
+    g_info("guest-shutdown called, mode: %s", mode);
     if (!mode || strcmp(mode, "powerdown") == 0) {
         if (access(POWEROFF_CMD_PATH, X_OK) == 0) {
             shutdown_cmd = POWEROFF_CMD_PATH;
@@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode,
     if (!mode) {
         mode = "r";
     }
-    slog("guest-file-open called, filepath: %s, mode: %s", path, mode);
+    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode);
     fh = safe_open_or_create(path, mode, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode,
         return -1;
     }
 
-    slog("guest-file-open, handle: %" PRId64, handle);
+    g_info("guest-file-open, handle: %" PRId64, handle);
     return handle;
 }
 
@@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
     GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
     int ret;
 
-    slog("guest-file-close called, handle: %" PRId64, handle);
+    g_info("guest-file-close called, handle: %" PRId64, handle);
     if (!gfh) {
         return;
     }
@@ -645,7 +645,7 @@ GuestFileWrite *qmp_guest_file_write(int64_t handle, const char *buf_b64,
     write_count = fwrite(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to write to file");
-        slog("guest-file-write failed, handle: %" PRId64, handle);
+        g_warning("guest-file-write failed, handle: %" PRId64, handle);
     } else {
         write_data = g_new0(GuestFileWrite, 1);
         write_data->count = write_count;
@@ -760,7 +760,7 @@ static void execute_fsfreeze_hook(FsfreezeHookArg arg, Error **errp)
 
     const char *argv[] = {hook, arg_str, NULL};
 
-    slog("executing fsfreeze hook with arg '%s'", arg_str);
+    g_info("executing fsfreeze hook with arg '%s'", arg_str);
     ga_run_command(argv, NULL, "execute fsfreeze hook", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -793,7 +793,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     FsMountList mounts;
     Error *local_err = NULL;
 
-    slog("guest-fsfreeze called");
+    g_info("guest-fsfreeze called");
 
     execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &local_err);
     if (local_err) {
@@ -833,7 +833,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     if (ret >= 0) {
         ga_unset_frozen(ga_state);
-        slog("guest-fsthaw called");
+        g_info("guest-fsthaw called");
         execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
     } else {
         ret = 0;
@@ -849,8 +849,8 @@ static void guest_fsfreeze_cleanup(void)
     if (ga_is_frozen(ga_state) == GUEST_FSFREEZE_STATUS_FROZEN) {
         qmp_guest_fsfreeze_thaw(&err);
         if (err) {
-            slog("failed to clean up frozen filesystems: %s",
-                 error_get_pretty(err));
+            g_warning("failed to clean up frozen filesystems: %s",
+                      error_get_pretty(err));
             error_free(err);
         }
     }
@@ -1282,19 +1282,19 @@ static GKeyFile *ga_parse_osrelease(const char *fname)
     const char *group = "[os-release]\n";
 
     if (!g_file_get_contents(fname, &content, NULL, &err)) {
-        slog("failed to read '%s', error: %s", fname, err->message);
+        g_warning("failed to read '%s', error: %s", fname, err->message);
         goto fail;
     }
 
     if (!g_utf8_validate(content, -1, NULL)) {
-        slog("file is not utf-8 encoded: %s", fname);
+        g_warning("file is not utf-8 encoded: %s", fname);
         goto fail;
     }
     content2 = g_strdup_printf("%s%s", group, content);
 
     if (!g_key_file_load_from_data(keys, content2, -1, G_KEY_FILE_NONE,
                                    &err)) {
-        slog("failed to parse file '%s', error: %s", fname, err->message);
+        g_warning("failed to parse file '%s', error: %s", fname, err->message);
         goto fail;
     }
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..d26b0041ce 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
     if (!mode) {
         mode = "r";
     }
-    slog("guest-file-open called, filepath: %s, mode: %s", path, mode);
+    g_info("guest-file-open called, filepath: %s, mode: %s", path, mode);
     guest_flags = find_open_flag(mode);
     if (guest_flags == NULL) {
         error_setg(errp, "invalid file open mode");
@@ -267,7 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
         goto done;
     }
 
-    slog("guest-file-open, handle: % " PRId64, fd);
+    g_info("guest-file-open, handle: % " PRId64, fd);
 
 done:
     g_free(w_path);
@@ -278,7 +278,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
 {
     bool ret;
     GuestFileHandle *gfh = guest_file_handle_find(handle, errp);
-    slog("guest-file-close called, handle: %" PRId64, handle);
+    g_info("guest-file-close called, handle: %" PRId64, handle);
     if (gfh == NULL) {
         return;
     }
@@ -337,7 +337,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
     Error *local_err = NULL;
     UINT shutdown_flag = EWX_FORCE;
 
-    slog("guest-shutdown called, mode: %s", mode);
+    g_info("guest-shutdown called, mode: %s", mode);
 
     if (!mode || strcmp(mode, "powerdown") == 0) {
         shutdown_flag |= EWX_POWEROFF;
@@ -361,7 +361,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 
     if (!ExitWindowsEx(shutdown_flag, SHTDN_REASON_FLAG_PLANNED)) {
         g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        slog("guest-shutdown failed: %s", emsg);
+        g_warning("guest-shutdown failed: %s", emsg);
         error_setg_win32(errp, GetLastError(), "guest-shutdown failed");
     }
 }
@@ -426,7 +426,7 @@ GuestFileWrite *qmp_guest_file_write(int64_t handle, const char *buf_b64,
     is_ok = WriteFile(fh, buf, count, &write_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to write to file");
-        slog("guest-file-write-failed, handle: %" PRId64, handle);
+        g_warning("guest-file-write failed, handle: %" PRId64, handle);
     } else {
         write_data = g_new0(GuestFileWrite, 1);
         write_data->count = (size_t) write_count;
@@ -1255,7 +1255,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
         return 0;
     }
 
-    slog("guest-fsfreeze called");
+    g_info("guest-fsfreeze called");
 
     /* cannot risk guest agent blocking itself on a write in this state */
     ga_set_frozen(ga_state);
@@ -1294,7 +1294,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     ga_unset_frozen(ga_state);
 
-    slog("guest-fsthaw called");
+    g_info("guest-fsthaw called");
 
     return i;
 }
@@ -1310,8 +1310,8 @@ static void guest_fsfreeze_cleanup(void)
     if (ga_is_frozen(ga_state) == GUEST_FSFREEZE_STATUS_FROZEN) {
         qmp_guest_fsfreeze_thaw(&err);
         if (err) {
-            slog("failed to clean up frozen filesystems: %s",
-                 error_get_pretty(err));
+            g_warning("failed to clean up frozen filesystems: %s",
+                      error_get_pretty(err));
             error_free(err);
         }
     }
@@ -1464,7 +1464,7 @@ static DWORD WINAPI do_suspend(LPVOID opaque)
 
     if (!SetSuspendState(*mode == GUEST_SUSPEND_MODE_DISK, TRUE, TRUE)) {
         g_autofree gchar *emsg = g_win32_error_message(GetLastError());
-        slog("failed to suspend guest: %s", emsg);
+        g_warning("failed to suspend guest: %s", emsg);
         ret = -1;
     }
     g_free(mode);
@@ -2174,8 +2174,8 @@ static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)
         }
         ++table;
     }
-    slog("failed to lookup Windows version: major=%lu, minor=%lu",
-        major, minor);
+    g_warning("failed to lookup Windows version: major=%lu, minor=%lu",
+              major, minor);
     return g_strdup("N/A");
 }
 
@@ -2198,8 +2198,8 @@ static char *ga_get_win_product_name(Error **errp)
     err = RegQueryValueExA(key, "ProductName", NULL, NULL,
                             (LPBYTE)result, &size);
     if (err == ERROR_MORE_DATA) {
-        slog("ProductName longer than expected (%lu bytes), retrying",
-                size);
+        g_info("ProductName longer than expected (%lu bytes), retrying",
+               size);
         g_free(result);
         result = NULL;
         if (size > 0) {
@@ -2244,8 +2244,8 @@ static char *ga_get_current_arch(void)
         break;
     case PROCESSOR_ARCHITECTURE_UNKNOWN:
     default:
-        slog("unknown processor architecture 0x%0x",
-            info.wProcessorArchitecture);
+        g_warning("unknown processor architecture 0x%0x",
+                  info.wProcessorArchitecture);
         result = g_strdup("unknown");
         break;
     }
@@ -2308,14 +2308,14 @@ static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propName,
         buffer, &buffer_len, 0);
     if (cr != CR_SUCCESS && cr != CR_BUFFER_SMALL) {
 
-        slog("failed to get property size, error=0x%lx", cr);
+        g_warning("failed to get property size, error=0x%lx", cr);
         return NULL;
     }
     buffer = g_new0(BYTE, buffer_len + 1);
     cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
         buffer, &buffer_len, 0);
     if (cr != CR_SUCCESS) {
-        slog("failed to get device property, error=0x%lx", cr);
+        g_warning("failed to get device property, error=0x%lx", cr);
         return NULL;
     }
     return g_steal_pointer(&buffer);
@@ -2329,7 +2329,7 @@ static GStrv ga_get_hardware_ids(DEVINST devInstance)
     g_autofree LPWSTR property = (LPWSTR)cm_get_property(devInstance,
         &qga_DEVPKEY_Device_HardwareIds, &cm_type);
     if (property == NULL) {
-        slog("failed to get hardware IDs");
+        g_warning("failed to get hardware IDs");
         return NULL;
     }
     if (*property == '\0') {
@@ -2371,7 +2371,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         return NULL;
     }
 
-    slog("enumerating devices");
+    g_info("enumerating devices");
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         bool skip = true;
         g_autofree LPWSTR name = NULL;
@@ -2385,7 +2385,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         name = (LPWSTR)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_NAME, &cm_type);
         if (name == NULL) {
-            slog("failed to get device description");
+            g_warning("failed to get device description");
             continue;
         }
         device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL, NULL);
@@ -2393,7 +2393,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             error_setg(errp, "conversion to utf8 failed (driver name)");
             return NULL;
         }
-        slog("querying device: %s", device->driver_name);
+        g_info("querying device: %s", device->driver_name);
         hw_ids = ga_get_hardware_ids(dev_info_data.DevInst);
         if (hw_ids == NULL) {
             continue;
@@ -2424,7 +2424,7 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         version = (LPWSTR)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_Device_DriverVersion, &cm_type);
         if (version == NULL) {
-            slog("failed to get driver version");
+            g_warning("failed to get driver version");
             continue;
         }
         device->driver_version = g_utf16_to_utf8(version, -1, NULL,
@@ -2437,15 +2437,15 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
         date = (LPFILETIME)cm_get_property(dev_info_data.DevInst,
             &qga_DEVPKEY_Device_DriverDate, &cm_type);
         if (date == NULL) {
-            slog("failed to get driver date");
+            g_warning("failed to get driver date");
             continue;
         }
         device->driver_date = filetime_to_ns(date);
         device->has_driver_date = true;
 
-        slog("driver: %s\ndriver version: %" PRId64 ",%s\n",
-             device->driver_name, device->driver_date,
-             device->driver_version);
+        g_info("driver: %s\ndriver version: %" PRId64 ",%s\n",
+               device->driver_name, device->driver_date,
+               device->driver_version);
         QAPI_LIST_APPEND(tail, g_steal_pointer(&device));
     }
 
@@ -2479,8 +2479,8 @@ static VOID CALLBACK load_avg_callback(PVOID hCounter, BOOLEAN timedOut)
         (PDH_HCOUNTER)hCounter, PDH_FMT_DOUBLE, 0, &displayValue);
     /* Skip updating the load if we can't get the value successfully */
     if (err != ERROR_SUCCESS) {
-        slog("PdhGetFormattedCounterValue failed to get load value with 0x%lx",
-             err);
+        g_warning("PdhGetFormattedCounterValue failed to get load value"
+                  " with 0x%lx", err);
         return;
     }
     currentLoad = displayValue.doubleValue;
diff --git a/qga/commands.c b/qga/commands.c
index 5f20af25d3..55edd9fd4c 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -30,19 +30,6 @@
  */
 #define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
 
-/* Note: in some situations, like with the fsfreeze, logging may be
- * temporarily disabled. if it is necessary that a command be able
- * to log for accounting purposes, check ga_logging_enabled() beforehand.
- */
-void slog(const gchar *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    g_logv("syslog", G_LOG_LEVEL_INFO, fmt, ap);
-    va_end(ap);
-}
-
 int64_t qmp_guest_sync_delimited(int64_t id, Error **errp)
 {
     ga_set_response_delimited(ga_state);
@@ -56,7 +43,7 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)
 
 void qmp_guest_ping(Error **errp)
 {
-    slog("guest-ping called");
+    g_info("guest-ping called");
 }
 
 static void qmp_command_info(const QmpCommand *cmd, void *opaque)
@@ -149,7 +136,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
     GuestExecInfo *gei;
     GuestExecStatus *ges;
 
-    slog("guest-exec-status called, pid: %u", (uint32_t)pid);
+    g_info("guest-exec-status called, pid: %u", (uint32_t)pid);
 
     gei = guest_exec_info_find(pid);
     if (gei == NULL) {
@@ -251,7 +238,7 @@ static char **guest_exec_get_args(const strList *entry, bool log)
     args[i] = NULL;
 
     if (log) {
-        slog("guest-exec called: \"%s\"", str);
+        g_info("guest-exec called: \"%s\"", str);
     }
     g_free(str);
 
@@ -285,8 +272,8 @@ static void guest_exec_task_setup(gpointer data)
          * inside the parent, not the child.
          */
         if (dup2(STDOUT_FILENO, STDERR_FILENO) != 0) {
-            slog("dup2() failed to merge stderr into stdout: %s",
-                 strerror(errno));
+            g_warning("dup2() failed to merge stderr into stdout: %s",
+                      strerror(errno));
         }
     }
 
@@ -295,8 +282,8 @@ static void guest_exec_task_setup(gpointer data)
     sigact.sa_handler = SIG_DFL;
 
     if (sigaction(SIGPIPE, &sigact, NULL) != 0) {
-        slog("sigaction() failed to reset child process's SIGPIPE: %s",
-             strerror(errno));
+        g_warning("sigaction() failed to reset child process's SIGPIPE: %s",
+                  strerror(errno));
     }
 #endif
 }
@@ -626,7 +613,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
 
     read_data = guest_file_read_unsafe(gfh, count, errp);
     if (!read_data) {
-        slog("guest-file-write failed, handle: %" PRId64, handle);
+        g_warning("guest-file-read failed, handle: %" PRId64, handle);
     }
 
     return read_data;
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index d9f3922adf..0f2d1b3415 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -40,7 +40,6 @@ void ga_command_state_free(GACommandState *cs);
 bool ga_logging_enabled(GAState *s);
 void ga_disable_logging(GAState *s);
 void ga_enable_logging(GAState *s);
-void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
 void ga_set_response_delimited(GAState *s);
 bool ga_is_frozen(GAState *s);
 void ga_set_frozen(GAState *s);
diff --git a/qga/main.c b/qga/main.c
index fd19c7037d..40b92ec686 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -286,7 +286,8 @@ QEMU_COPYRIGHT "\n"
 #endif
 "  -t, --statedir    specify dir to store state information (absolute paths\n"
 "                    only, default is %s)\n"
-"  -v, --verbose     log extra debugging information\n"
+"  -v, --verbose     enable verbose logging (info and above)\n"
+"  --debug           enable debug logging (all messages)\n"
 "  -V, --version     print version information and exit\n"
 "  -d, --daemonize   become a daemon\n"
 #ifdef _WIN32
@@ -391,18 +392,24 @@ static void ga_log(const gchar *domain, GLogLevelFlags level,
     }
 
     level &= G_LOG_LEVEL_MASK;
-    if (g_strcmp0(domain, "syslog") == 0) {
+    if (!(level & s->log_level)) {
+        return;
+    }
+
+    if (s->log_file) {
+        g_autoptr(GDateTime) now = g_date_time_new_now_utc();
+        g_autofree char *nowstr = g_date_time_format(now, "%s.%f");
+        fprintf(s->log_file, "%s: %s: %s\n", nowstr, level_str, msg);
+        fflush(s->log_file);
+    }
+
+    if (level & ~G_LOG_LEVEL_DEBUG) {
 #ifndef _WIN32
         syslog(glib_log_level_to_system(level), "%s: %s", level_str, msg);
 #else
         ReportEvent(s->event_log, glib_log_level_to_system(level),
                     0, 1, NULL, 1, 0, &msg, NULL);
 #endif
-    } else if (level & s->log_level) {
-        g_autoptr(GDateTime) now = g_date_time_new_now_utc();
-        g_autofree char *nowstr = g_date_time_format(now, "%s.%f");
-        fprintf(s->log_file, "%s: %s: %s\n", nowstr, level_str, msg);
-        fflush(s->log_file);
     }
 }
 
@@ -1140,7 +1147,10 @@ static void config_load(GAConfig *config, const char *confpath, bool required)
     }
     if (g_key_file_has_key(keyfile, "general", "verbose", NULL) &&
         g_key_file_get_boolean(keyfile, "general", "verbose", &gerr)) {
-        /* enable all log levels */
+        config->log_level |= G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO;
+    }
+    if (g_key_file_has_key(keyfile, "general", "debug", NULL) &&
+        g_key_file_get_boolean(keyfile, "general", "debug", &gerr)) {
         config->log_level = G_LOG_LEVEL_MASK;
     }
     if (g_key_file_has_key(keyfile, "general", "retry-path", NULL)) {
@@ -1214,7 +1224,9 @@ static void config_dump(GAConfig *config)
 #endif
     g_key_file_set_string(keyfile, "general", "statedir", config->state_dir);
     g_key_file_set_boolean(keyfile, "general", "verbose",
-                           config->log_level == G_LOG_LEVEL_MASK);
+                           config->log_level & G_LOG_LEVEL_INFO);
+    g_key_file_set_boolean(keyfile, "general", "debug",
+                           config->log_level & G_LOG_LEVEL_DEBUG);
     g_key_file_set_boolean(keyfile, "general", "retry-path",
                            config->retry_path);
     tmp = list_join(config->blockedrpcs, ',');
@@ -1238,6 +1250,7 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
+    enum { OPT_DEBUG = 256 };
     const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
     int opt_ind = 0, ch;
     const struct option lopt[] = {
@@ -1251,6 +1264,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "fsfreeze-hook", 2, NULL, 'F' },
 #endif
         { "verbose", 0, NULL, 'v' },
+        { "debug", 0, NULL, OPT_DEBUG },
         { "method", 1, NULL, 'm' },
         { "path", 1, NULL, 'p' },
         { "daemonize", 0, NULL, 'd' },
@@ -1313,7 +1327,9 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             config->state_dir = g_strdup(optarg);
             break;
         case 'v':
-            /* enable all log levels */
+            config->log_level |= G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO;
+            break;
+        case OPT_DEBUG:
             config->log_level = G_LOG_LEVEL_MASK;
             break;
         case 'V':
@@ -1673,7 +1689,8 @@ int main(int argc, char **argv)
     GAConfig *config = g_new0(GAConfig, 1);
     int socket_activation;
 
-    config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
+    config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL
+                      | G_LOG_LEVEL_WARNING;
 
     qemu_init_exec_dir(argv[0]);
     qga_qmp_init_marshal(&ga_commands);
-- 
2.51.0


