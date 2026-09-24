Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0933FC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lfF-0004N3-AG; Thu, 24 Sep 2026 11:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1x9lf8-0004Ma-94
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1x9lf4-0002NT-Nq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790264821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=THrTuwZeegpA+RjsM+kxw+5CUyfp8I7WQFZr5eWUOQU=;
 b=J8+EozLZ9kbDKrbIF6L6kOGzzt2fs1oo43O79H7vSBvNtaV82Rn9LInMgx7nFHjorPN59e
 cfy95vHNklWW9zowbpPrk4LuxEL4vWtZJ+skpqrPx7jFXfMaMagR1fKsVLgOu1dZ5MoXqf
 GjfSTBwebY9u2pBO1RteRAEvhpp+GU8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-QjWW2VCANgSl9XUyt-IRXQ-1; Thu,
 24 Sep 2026 11:45:37 -0400
X-MC-Unique: QjWW2VCANgSl9XUyt-IRXQ-1
X-Mimecast-MFC-AGG-ID: QjWW2VCANgSl9XUyt-IRXQ_1790264737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6699183450E
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:45:36 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3723B18005B5; Thu, 24 Sep 2026 15:45:33 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, dholler@redhat.com, armbru@redhat.com,
 fdeutsch@redhat.com, yvugenfi@redhat.com,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH] qga: Add guest-get-drivers command for Windows
Date: Thu, 24 Sep 2026 18:44:24 +0300
Message-ID: <20260924154424.3786199-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=0.745 autolearn=no autolearn_force=no
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

Add a new guest-get-drivers command that reports two independent lists
of Windows driver information:

 - packages: out-of-box driver packages enumerated with the DISM API
   (DismGetDrivers). Each entry includes the published INF name,
   original INF name, version, and provider.
 - services: registered driver services enumerated with the Service
   Control Manager (EnumServicesStatusExW). Each entry includes the
   service name, configured binary path, current SCM status, and
   FileVersion and CompanyName metadata from the driver binary.

Load DismApi.dll dynamically with LoadLibraryExW so that its absence
does not prevent qemu-ga from starting. Initialize DISM lazily once per
QGA process and open a separate online DISM session for each command
invocation, with process cleanup registered through ga_command_state_add.

Normalize driver binary paths from the service database before reading
version resources, including SystemRoot, environment-variable, NT-prefix,
and relative path forms.

Link against version.dll (-lversion) for the GetFileVersionInfo and
VerQueryValue APIs.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 683 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   5 +-
 qga/qapi-schema.json |  89 ++++++
 3 files changed, 775 insertions(+), 2 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2bf5581aaa..0dc94d808e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -28,6 +28,8 @@
 #include <wtsapi32.h>
 #include <wininet.h>
 #include <pdh.h>
+#include <dismapi.h>
+#include <winver.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -1981,12 +1983,15 @@ done:
     g_free(rawpasswddata);
 }
 
+static void ga_cleanup_dism_api(void);
+
 /* register init/cleanup routines for stateful command groups */
 void ga_command_state_init(GAState *s, GACommandState *cs)
 {
     if (!vss_initialized()) {
         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
     }
+    ga_command_state_add(cs, NULL, ga_cleanup_dism_api);
 }
 
 /* MINGW is missing two fields: IncomingFrames & OutgoingFrames */
@@ -2455,6 +2460,684 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     return head;
 }
 
+static void error_setg_dism(Error **errp, HRESULT hr, const char *msg)
+{
+    if (HRESULT_FACILITY(hr) == FACILITY_WIN32) {
+        error_setg_win32(errp, HRESULT_CODE(hr), "%s", msg);
+    } else {
+        error_setg(errp, "%s (HRESULT 0x%08" PRIx32 ")", msg,
+                   (uint32_t)hr);
+    }
+}
+
+static void ga_log_dism_error(HRESULT hr, const char *msg)
+{
+    Error *local_err = NULL;
+
+    error_setg_dism(&local_err, hr, msg);
+    slog("%s", error_get_pretty(local_err));
+    error_free(local_err);
+}
+
+typedef HRESULT WINAPI QGADismInitializeFunc(
+    DismLogLevel log_level, PCWSTR log_file_path, PCWSTR scratch_directory);
+typedef HRESULT WINAPI QGADismShutdownFunc(void);
+typedef HRESULT WINAPI QGADismOpenSessionFunc(
+    PCWSTR image_path, PCWSTR windows_directory, PCWSTR system_drive,
+    DismSession *session);
+typedef HRESULT WINAPI QGADismCloseSessionFunc(DismSession session);
+typedef HRESULT WINAPI QGADismGetDriversFunc(
+    DismSession session, WINBOOL all_drivers,
+    DismDriverPackage **driver_package, unsigned int *driver_count);
+typedef HRESULT WINAPI QGADismDeleteFunc(void *dism_structure);
+
+typedef struct QGADismApi {
+    HMODULE module;
+    QGADismInitializeFunc *initialize;
+    QGADismShutdownFunc *shutdown;
+    QGADismOpenSessionFunc *open_session;
+    QGADismCloseSessionFunc *close_session;
+    QGADismGetDriversFunc *get_drivers;
+    QGADismDeleteFunc *delete;
+} QGADismApi;
+
+static QGADismApi dism_api;
+static bool dism_initialized;
+
+static FARPROC ga_get_dism_function(HMODULE module, const char *name,
+                                    Error **errp)
+{
+    FARPROC function = GetProcAddress(module, name);
+
+    if (function == NULL) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to resolve %s from DismApi.dll", name);
+    }
+    return function;
+}
+
+static void ga_unload_dism_api(QGADismApi *api)
+{
+    if (api->module != NULL && !FreeLibrary(api->module)) {
+        slog("failed to unload DismApi.dll, error=%lu", GetLastError());
+    }
+    memset(api, 0, sizeof(*api));
+}
+
+/*
+ * Load DISM from System32 and resolve its entry points at runtime, so a
+ * missing DismApi.dll prevents only this command rather than QGA startup.
+ */
+static bool ga_load_dism_api(QGADismApi *api, Error **errp)
+{
+    api->module = LoadLibraryExW(L"DismApi.dll", NULL,
+                                 LOAD_LIBRARY_SEARCH_SYSTEM32);
+    if (api->module == NULL) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to load DismApi.dll");
+        return false;
+    }
+
+    api->initialize = (QGADismInitializeFunc *)
+        ga_get_dism_function(api->module, "DismInitialize", errp);
+    if (api->initialize == NULL) {
+        goto fail;
+    }
+    api->shutdown = (QGADismShutdownFunc *)
+        ga_get_dism_function(api->module, "DismShutdown", errp);
+    if (api->shutdown == NULL) {
+        goto fail;
+    }
+    api->open_session = (QGADismOpenSessionFunc *)
+        ga_get_dism_function(api->module, "DismOpenSession", errp);
+    if (api->open_session == NULL) {
+        goto fail;
+    }
+    api->close_session = (QGADismCloseSessionFunc *)
+        ga_get_dism_function(api->module, "DismCloseSession", errp);
+    if (api->close_session == NULL) {
+        goto fail;
+    }
+    api->get_drivers = (QGADismGetDriversFunc *)
+        ga_get_dism_function(api->module, "DismGetDrivers", errp);
+    if (api->get_drivers == NULL) {
+        goto fail;
+    }
+    api->delete = (QGADismDeleteFunc *)
+        ga_get_dism_function(api->module, "DismDelete", errp);
+    if (api->delete == NULL) {
+        goto fail;
+    }
+
+    return true;
+
+fail:
+    ga_unload_dism_api(api);
+    return false;
+}
+
+static bool ga_ensure_dism_api(Error **errp)
+{
+    HRESULT hr;
+
+    if (dism_initialized) {
+        return true;
+    }
+
+    if (!ga_load_dism_api(&dism_api, errp)) {
+        return false;
+    }
+
+    hr = dism_api.initialize(DismLogErrors, NULL, NULL);
+    if (FAILED(hr)) {
+        error_setg_dism(errp, hr, "failed to initialize DISM");
+        ga_unload_dism_api(&dism_api);
+        return false;
+    }
+
+    dism_initialized = true;
+    return true;
+}
+
+static void ga_cleanup_dism_api(void)
+{
+    HRESULT hr;
+
+    if (dism_initialized) {
+        hr = dism_api.shutdown();
+        if (FAILED(hr)) {
+            ga_log_dism_error(hr, "failed to shut down DISM");
+        }
+        dism_initialized = false;
+    }
+
+    ga_unload_dism_api(&dism_api);
+}
+
+static char *ga_utf16_to_utf8_required(const WCHAR *str, const char *name,
+                                       Error **errp)
+{
+    g_autoptr(GError) gerr = NULL;
+    char *ret;
+
+    if (str == NULL || str[0] == L'\0') {
+        error_setg(errp, "driver %s is missing", name);
+        return NULL;
+    }
+
+    ret = g_utf16_to_utf8(str, -1, NULL, NULL, &gerr);
+    if (ret == NULL) {
+        error_setg(errp, "failed to convert driver %s to UTF-8: %s",
+                   name, gerr->message);
+    }
+    return ret;
+}
+
+static const WCHAR *ga_windows_path_basename(const WCHAR *path)
+{
+    const WCHAR *name = path;
+
+    while (*path != L'\0') {
+        if (*path == L'\\' || *path == L'/') {
+            name = path + 1;
+        }
+        path++;
+    }
+    return name;
+}
+
+static GuestDriverPackageList *ga_get_driver_packages(Error **errp)
+{
+    GuestDriverPackageList *head = NULL, **tail = &head;
+    DismSession session = DISM_SESSION_DEFAULT;
+    DismDriverPackage *drivers = NULL;
+    Error *local_err = NULL;
+    HRESULT hr;
+    UINT count = 0;
+    UINT i;
+
+    if (!ga_ensure_dism_api(&local_err)) {
+        goto out;
+    }
+
+    hr = dism_api.open_session(DISM_ONLINE_IMAGE, NULL, NULL, &session);
+    if (FAILED(hr)) {
+        error_setg_dism(&local_err, hr,
+                        "failed to open online DISM session");
+        goto out;
+    }
+
+    /*
+     * FALSE retrieves only out-of-box drivers, meaning drivers that were
+     * not originally included in the Windows image. See:
+     * https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism/dismgetdrivers-function
+     */
+    hr = dism_api.get_drivers(session, FALSE, &drivers, &count);
+    if (FAILED(hr)) {
+        error_setg_dism(&local_err, hr,
+                        "failed to enumerate driver packages");
+        goto out;
+    }
+
+    for (i = 0; i < count; i++) {
+        g_autoptr(GuestDriverPackage) package = NULL;
+
+        package = g_new0(GuestDriverPackage, 1);
+        package->name = ga_utf16_to_utf8_required(drivers[i].PublishedName,
+                                                  "package name", &local_err);
+        if (package->name == NULL) {
+            goto out;
+        }
+
+        if (drivers[i].OriginalFileName != NULL &&
+            drivers[i].OriginalFileName[0] != L'\0') {
+            const WCHAR *original_name = ga_windows_path_basename(
+                drivers[i].OriginalFileName);
+
+            if (original_name[0] != L'\0') {
+                package->original_name = g_utf16_to_utf8(
+                    original_name, -1, NULL, NULL, NULL);
+            }
+        }
+
+        package->version = g_strdup_printf("%u.%u.%u.%u",
+                                           drivers[i].MajorVersion,
+                                           drivers[i].MinorVersion,
+                                           drivers[i].Build,
+                                           drivers[i].Revision);
+
+        if (drivers[i].ProviderName != NULL &&
+            drivers[i].ProviderName[0] != L'\0') {
+            package->vendor = g_utf16_to_utf8(drivers[i].ProviderName, -1,
+                                              NULL, NULL, NULL);
+        }
+
+        QAPI_LIST_APPEND(tail, g_steal_pointer(&package));
+    }
+
+out:
+    if (drivers != NULL) {
+        hr = dism_api.delete(drivers);
+        if (FAILED(hr)) {
+            if (local_err == NULL) {
+                error_setg_dism(&local_err, hr,
+                                "failed to release driver package data");
+            } else {
+                ga_log_dism_error(hr,
+                                  "failed to release driver package data");
+            }
+        }
+    }
+    if (session != DISM_SESSION_DEFAULT) {
+        hr = dism_api.close_session(session);
+        if (FAILED(hr)) {
+            if (local_err == NULL) {
+                error_setg_dism(&local_err, hr,
+                                "failed to close online DISM session");
+            } else {
+                ga_log_dism_error(hr,
+                                  "failed to close online DISM session");
+            }
+        }
+    }
+    if (local_err != NULL) {
+        qapi_free_GuestDriverPackageList(head);
+        head = NULL;
+        error_propagate(errp, local_err);
+    }
+    return head;
+}
+
+static bool ga_driver_service_status(DWORD state,
+                                     GuestDriverServiceStatus *status)
+{
+    switch (state) {
+    case SERVICE_STOPPED:
+        *status = GUEST_DRIVER_SERVICE_STATUS_STOPPED;
+        return true;
+    case SERVICE_START_PENDING:
+        *status = GUEST_DRIVER_SERVICE_STATUS_START_PENDING;
+        return true;
+    case SERVICE_STOP_PENDING:
+        *status = GUEST_DRIVER_SERVICE_STATUS_STOP_PENDING;
+        return true;
+    case SERVICE_RUNNING:
+        *status = GUEST_DRIVER_SERVICE_STATUS_RUNNING;
+        return true;
+    case SERVICE_CONTINUE_PENDING:
+        *status = GUEST_DRIVER_SERVICE_STATUS_CONTINUE_PENDING;
+        return true;
+    case SERVICE_PAUSE_PENDING:
+        *status = GUEST_DRIVER_SERVICE_STATUS_PAUSE_PENDING;
+        return true;
+    case SERVICE_PAUSED:
+        *status = GUEST_DRIVER_SERVICE_STATUS_PAUSED;
+        return true;
+    default:
+        return false;
+    }
+}
+
+/* Convert an SCM driver path into a path usable by Win32 file APIs. */
+static WCHAR *ga_resolve_driver_path(const WCHAR *path)
+{
+    WCHAR windows_dir[MAX_PATH + 1];
+    g_autofree WCHAR *trimmed = NULL;
+    g_autofree WCHAR *expanded = NULL;
+    const WCHAR *start = path;
+    const WCHAR *end;
+    const WCHAR *remainder = NULL;
+    size_t prefix_len;
+    size_t path_len;
+    size_t windows_len;
+    DWORD expanded_len;
+    UINT windows_dir_len;
+
+    while (*start != L'\0' && iswspace(*start)) {
+        start++;
+    }
+    end = start + wcslen(start);
+    while (end > start && iswspace(end[-1])) {
+        end--;
+    }
+    if (end - start >= 2 && start[0] == L'"' && end[-1] == L'"') {
+        start++;
+        end--;
+    }
+    if (end == start) {
+        return NULL;
+    }
+
+    path_len = end - start;
+    trimmed = g_new(WCHAR, path_len + 1);
+    memcpy(trimmed, start, path_len * sizeof(WCHAR));
+    trimmed[path_len] = L'\0';
+
+    expanded_len = ExpandEnvironmentStringsW(trimmed, NULL, 0);
+    if (expanded_len == 0) {
+        return NULL;
+    }
+    expanded = g_new(WCHAR, expanded_len);
+    path_len = ExpandEnvironmentStringsW(trimmed, expanded, expanded_len);
+    if (path_len == 0 || path_len > expanded_len) {
+        return NULL;
+    }
+
+    prefix_len = wcslen(L"\\SystemRoot");
+    if (_wcsnicmp(expanded, L"\\SystemRoot", prefix_len) == 0 &&
+        (expanded[prefix_len] == L'\0' ||
+         expanded[prefix_len] == L'\\' ||
+         expanded[prefix_len] == L'/')) {
+        remainder = expanded + prefix_len;
+    } else {
+        prefix_len = wcslen(L"SystemRoot");
+        if (_wcsnicmp(expanded, L"SystemRoot", prefix_len) == 0 &&
+            (expanded[prefix_len] == L'\0' ||
+             expanded[prefix_len] == L'\\' ||
+             expanded[prefix_len] == L'/')) {
+            remainder = expanded + prefix_len;
+        }
+    }
+
+    windows_dir_len = GetWindowsDirectoryW(windows_dir,
+                                            ARRAY_SIZE(windows_dir));
+    if (windows_dir_len == 0 || windows_dir_len >= ARRAY_SIZE(windows_dir)) {
+        return NULL;
+    }
+    windows_len = windows_dir_len;
+
+    if (remainder != NULL) {
+        WCHAR *ret = g_new(WCHAR, windows_len + wcslen(remainder) + 1);
+
+        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
+        wcscpy(ret + windows_len, remainder);
+        return ret;
+    }
+
+    if (wcsncmp(expanded, L"\\??\\", 4) == 0) {
+        return g_memdup2(expanded + 4,
+                         (wcslen(expanded + 4) + 1) * sizeof(WCHAR));
+    }
+
+    if ((iswalpha(expanded[0]) && expanded[1] == L':') ||
+        expanded[0] == L'\\') {
+        return g_steal_pointer(&expanded);
+    }
+
+    path_len = wcslen(expanded);
+    start = expanded;
+    while (*start == L'\\' || *start == L'/') {
+        start++;
+        path_len--;
+    }
+    {
+        WCHAR *ret = g_new(WCHAR, windows_len + path_len + 2);
+
+        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
+        ret[windows_len] = L'\\';
+        wcscpy(ret + windows_len + 1, start);
+        return ret;
+    }
+}
+
+typedef struct QGAVersionTranslation {
+    WORD language;
+    WORD code_page;
+} QGAVersionTranslation;
+
+/* Return CompanyName from a localized file-version string table. */
+static char *ga_get_file_vendor(const void *version_info)
+{
+    QGAVersionTranslation *translations = NULL;
+    static const QGAVersionTranslation fallback = { 0x0409, 0x04b0 };
+    UINT translations_len = 0;
+    UINT count = 0;
+    UINT i;
+
+    if (VerQueryValueW(version_info, L"\\VarFileInfo\\Translation",
+                       (void **)&translations, &translations_len) &&
+        translations != NULL) {
+        count = translations_len / sizeof(*translations);
+    }
+
+    for (i = 0; i <= count; i++) {
+        const QGAVersionTranslation *translation;
+        WCHAR query[64];
+        WCHAR *company = NULL;
+        UINT company_len = 0;
+        char *vendor;
+
+        translation = i < count ? &translations[i] : &fallback;
+        swprintf(query, ARRAY_SIZE(query),
+                 L"\\StringFileInfo\\%04x%04x\\CompanyName",
+                 translation->language, translation->code_page);
+        if (!VerQueryValueW(version_info, query, (void **)&company,
+                            &company_len) || company_len <= 1) {
+            continue;
+        }
+        vendor = g_utf16_to_utf8(company, -1, NULL, NULL, NULL);
+        if (vendor != NULL && vendor[0] != '\0') {
+            return vendor;
+        }
+        g_free(vendor);
+    }
+    return NULL;
+}
+
+/* Add optional FileVersion and CompanyName data from a driver binary. */
+static bool ga_get_driver_file_metadata(const WCHAR *path,
+                                        GuestDriverService *service,
+                                        Error **errp)
+{
+    g_autofree void *version_info = NULL;
+    VS_FIXEDFILEINFO *fixed_info = NULL;
+    PVOID old_redirection = NULL;
+    DWORD ignored;
+    DWORD version_size;
+    UINT fixed_info_len;
+    bool redirection_disabled;
+    bool version_loaded = false;
+
+    redirection_disabled =
+        Wow64DisableWow64FsRedirection(&old_redirection);
+
+    version_size = GetFileVersionInfoSizeW(path, &ignored);
+    if (version_size != 0) {
+        version_info = g_malloc(version_size);
+        version_loaded = GetFileVersionInfoW(path, 0, version_size,
+                                             version_info);
+    }
+
+    if (redirection_disabled &&
+        !Wow64RevertWow64FsRedirection(old_redirection)) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to restore WOW64 filesystem redirection "
+                         "for driver service '%s'", service->name);
+        return false;
+    }
+
+    if (!version_loaded) {
+        return true;
+    }
+
+    if (VerQueryValueW(version_info, L"\\", (void **)&fixed_info,
+                       &fixed_info_len) &&
+        fixed_info_len >= sizeof(*fixed_info) &&
+        fixed_info->dwSignature == VS_FFI_SIGNATURE) {
+        service->version = g_strdup_printf(
+            "%u.%u.%u.%u",
+            HIWORD(fixed_info->dwFileVersionMS),
+            LOWORD(fixed_info->dwFileVersionMS),
+            HIWORD(fixed_info->dwFileVersionLS),
+            LOWORD(fixed_info->dwFileVersionLS));
+    }
+
+    service->vendor = ga_get_file_vendor(version_info);
+    return true;
+}
+
+/*
+ * Add optional configuration and binary metadata for one driver service.
+ * Ordinary per-service lookup failures leave optional fields unset.
+ */
+static bool ga_get_driver_service_config(SC_HANDLE manager,
+                                         const WCHAR *name,
+                                         GuestDriverService *service,
+                                         Error **errp)
+{
+    SC_HANDLE handle;
+    g_autofree QUERY_SERVICE_CONFIGW *config = NULL;
+    g_autofree WCHAR *resolved_path = NULL;
+    DWORD size = 0;
+    DWORD err;
+    bool success = true;
+
+    handle = OpenServiceW(manager, name, SERVICE_QUERY_CONFIG);
+    if (handle == NULL) {
+        slog("failed to open configuration for driver service '%s', "
+             "error=%lu", service->name, GetLastError());
+        return true;
+    }
+
+    QueryServiceConfigW(handle, NULL, 0, &size);
+    err = GetLastError();
+    if (err != ERROR_INSUFFICIENT_BUFFER) {
+        slog("failed to get configuration size for driver service '%s', "
+             "error=%lu", service->name, err);
+        goto out;
+    }
+
+    config = g_malloc(size);
+    if (!QueryServiceConfigW(handle, config, size, &size)) {
+        slog("failed to get configuration for driver service '%s', "
+             "error=%lu", service->name, GetLastError());
+        goto out;
+    }
+
+    if (config->lpBinaryPathName == NULL ||
+        config->lpBinaryPathName[0] == L'\0') {
+        goto out;
+    }
+
+    service->driver_path = g_utf16_to_utf8(config->lpBinaryPathName, -1,
+                                           NULL, NULL, NULL);
+
+    resolved_path = ga_resolve_driver_path(config->lpBinaryPathName);
+    if (resolved_path != NULL &&
+        !ga_get_driver_file_metadata(resolved_path, service, errp)) {
+        success = false;
+    }
+
+out:
+    CloseServiceHandle(handle);
+    return success;
+}
+
+static GuestDriverServiceList *ga_get_driver_services(Error **errp)
+{
+    GuestDriverServiceList *head = NULL, **tail = &head;
+    g_autofree BYTE *buffer = NULL;
+    SC_HANDLE manager = NULL;
+    DWORD buffer_size = 256 * 1024;
+    DWORD bytes_needed;
+    DWORD services_returned;
+    DWORD resume = 0;
+    DWORD err;
+    bool complete;
+    bool success = false;
+
+    manager = OpenSCManagerW(NULL, NULL, SC_MANAGER_ENUMERATE_SERVICE);
+    if (manager == NULL) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to open service control manager");
+        goto out;
+    }
+
+    buffer = g_malloc(buffer_size);
+    do {
+        ENUM_SERVICE_STATUS_PROCESSW *services;
+        DWORD i;
+
+        bytes_needed = 0;
+        services_returned = 0;
+        complete = EnumServicesStatusExW(manager, SC_ENUM_PROCESS_INFO,
+                                         SERVICE_DRIVER, SERVICE_STATE_ALL,
+                                         buffer, buffer_size, &bytes_needed,
+                                         &services_returned, &resume, NULL);
+        if (!complete) {
+            err = GetLastError();
+            if (err != ERROR_MORE_DATA) {
+                error_setg_win32(errp, err,
+                                 "failed to enumerate driver services");
+                goto out;
+            }
+            if (services_returned == 0) {
+                error_setg(errp, "driver service enumeration made no "
+                           "progress (buffer needs %lu bytes)", bytes_needed);
+                goto out;
+            }
+        }
+
+        services = (ENUM_SERVICE_STATUS_PROCESSW *)buffer;
+        for (i = 0; i < services_returned; i++) {
+            g_autoptr(GuestDriverService) service = NULL;
+
+            service = g_new0(GuestDriverService, 1);
+            service->name = ga_utf16_to_utf8_required(
+                services[i].lpServiceName, "service name", errp);
+            if (service->name == NULL) {
+                goto out;
+            }
+            if (!ga_driver_service_status(
+                    services[i].ServiceStatusProcess.dwCurrentState,
+                    &service->status)) {
+                error_setg(errp, "driver service '%s' has unknown state %lu",
+                           service->name,
+                           services[i].ServiceStatusProcess.dwCurrentState);
+                goto out;
+            }
+
+            if (!ga_get_driver_service_config(manager,
+                                              services[i].lpServiceName,
+                                              service, errp)) {
+                goto out;
+            }
+            QAPI_LIST_APPEND(tail, g_steal_pointer(&service));
+        }
+    } while (!complete);
+    success = true;
+
+out:
+    if (manager != NULL) {
+        CloseServiceHandle(manager);
+    }
+    if (!success) {
+        qapi_free_GuestDriverServiceList(head);
+        head = NULL;
+    }
+    return head;
+}
+
+GuestDriverInfo *qmp_guest_get_drivers(Error **errp)
+{
+    g_autoptr(GuestDriverInfo) info = g_new0(GuestDriverInfo, 1);
+    Error *local_err = NULL;
+
+    info->packages = ga_get_driver_packages(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    info->services = ga_get_driver_services(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return g_steal_pointer(&info);
+}
+
 char *qga_get_host_name(Error **errp)
 {
     wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb..15860d938d 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -94,8 +94,9 @@ qga_ss = qga_ss.apply({})
 gen_tlb = []
 qga_libs = []
 if host_os == 'windows'
-  qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
-               '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
+  qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
+               '-lwininet', '-liphlpapi', '-lnetapi32', '-lsetupapi',
+               '-lcfgmgr32', '-luserenv', '-lpdh', '-lversion' ]
   if have_qga_vss
     qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8cd0ba048b..b20cf7135a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1590,6 +1590,95 @@
   'returns': ['GuestDeviceInfo'],
   'if': 'CONFIG_WIN32' }
 
+##
+# @GuestDriverServiceStatus:
+#
+# @stopped: the service is stopped
+#
+# @start-pending: the service is starting
+#
+# @stop-pending: the service is stopping
+#
+# @running: the service is running
+#
+# @continue-pending: the service is resuming
+#
+# @pause-pending: the service is pausing
+#
+# @paused: the service is paused
+#
+# Since: 11.2
+##
+{ 'enum': 'GuestDriverServiceStatus',
+  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
+            'continue-pending', 'pause-pending', 'paused' ],
+  'if': 'CONFIG_WIN32' }
+
+##
+# @GuestDriverPackage:
+#
+# An out-of-box driver package installed in the guest.
+#
+# @name: published INF name
+#
+# @original-name: base name of the original INF file
+#
+# @version: four-part version from the package INF DriverVer entry
+#
+# @vendor: package provider from the INF metadata
+#
+# Since: 11.2
+##
+{ 'struct': 'GuestDriverPackage',
+  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
+            '*vendor': 'str' },
+  'if': 'CONFIG_WIN32' }
+
+##
+# @GuestDriverService:
+#
+# @name: service name
+#
+# @driver-path: driver binary path configured in the service database
+#
+# @version: four-part FileVersion from the driver binary
+#
+# @vendor: CompanyName from the driver binary
+#
+# @status: current service status
+#
+# Since: 11.2
+##
+{ 'struct': 'GuestDriverService',
+  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
+            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
+  'if': 'CONFIG_WIN32' }
+
+##
+# @GuestDriverInfo:
+#
+# @packages: out-of-box driver packages installed in the guest
+#
+# @services: registered driver services
+#
+# Since: 11.2
+##
+{ 'struct': 'GuestDriverInfo',
+  'data': { 'packages': ['GuestDriverPackage'],
+            'services': ['GuestDriverService'] },
+  'if': 'CONFIG_WIN32' }
+
+##
+# @guest-get-drivers:
+#
+# Retrieve information about Windows driver packages and services.
+#
+# Since: 11.2
+##
+{ 'command': 'guest-get-drivers',
+  'returns': 'GuestDriverInfo',
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @GuestAuthorizedKeys:
 #
-- 
2.55.0


