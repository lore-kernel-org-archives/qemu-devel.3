Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF4CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnT2-0006vz-8i; Thu, 08 Oct 2026 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xEnSr-0006qg-G0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xEnSn-0007RO-KG
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791463387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EeBJNu3C6pzgP4vLVkQmhd3kQ74ALtsNPtfSu6tnrA=;
 b=UoOLGd/Wts1ctxH78e2+XVwX7UMZpDBnbaHn/yxfi300VKU/cgfTmHuub392y8t1+tUw9K
 TiyZo/f6PBoO0KPw8K2MFjXP4WJ+CBXXakriNKNJ8UecYYoDQg0xdeEbiKUoor9eSFCzqb
 WZWpUfAKeMB0I4sgWOyPKrmjLqaepRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-DcNstNj0PjiO0TPqrwM-XA-1; Thu,
 08 Oct 2026 08:43:06 -0400
X-MC-Unique: DcNstNj0PjiO0TPqrwM-XA-1
X-Mimecast-MFC-AGG-ID: DcNstNj0PjiO0TPqrwM-XA_1791463385
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A6C51800BC9; Thu,  8 Oct 2026 12:43:05 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.50.10.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC78E1800446; Thu,  8 Oct 2026 12:43:02 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, dholler@redhat.com,
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com,
 kramdoss@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v2 2/2] qga: Add guest-get-driver-services command for Windows
Date: Thu,  8 Oct 2026 15:39:20 +0300
Message-ID: <20261008123920.3861059-2-eashurov@redhat.com>
In-Reply-To: <20261008123920.3861059-1-eashurov@redhat.com>
References: <20261008123920.3861059-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new guest-get-driver-services command that returns registered
driver services from the Service Control Manager
(EnumServicesStatusExW).  Each entry includes the service name,
configured binary path, current SCM status, and FileVersion and
CompanyName metadata extracted from the driver binary.

Normalize driver binary paths from the service database before
reading version resources, including SystemRoot,
environment-variable, NT-prefix, and relative path forms.

Unrecognized SCM service states are reported as "unknown" with a
log message rather than aborting the enumeration, so that future
Windows versions do not break the command.

Link against version.dll (-lversion) for the GetFileVersionInfo
and VerQueryValue APIs.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 363 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   5 +-
 qga/qapi-schema.json |  58 +++++++
 3 files changed, 424 insertions(+), 2 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e01033d8c5..1031fd52d9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -29,6 +29,7 @@
 #include <wininet.h>
 #include <pdh.h>
 #include <dismapi.h>
+#include <winver.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -2747,6 +2748,368 @@ out:
     return head;
 }
 
+static GuestDriverServiceStatus ga_driver_service_status(DWORD state)
+{
+    switch (state) {
+    case SERVICE_STOPPED:
+        return GUEST_DRIVER_SERVICE_STATUS_STOPPED;
+    case SERVICE_START_PENDING:
+        return GUEST_DRIVER_SERVICE_STATUS_START_PENDING;
+    case SERVICE_STOP_PENDING:
+        return GUEST_DRIVER_SERVICE_STATUS_STOP_PENDING;
+    case SERVICE_RUNNING:
+        return GUEST_DRIVER_SERVICE_STATUS_RUNNING;
+    case SERVICE_CONTINUE_PENDING:
+        return GUEST_DRIVER_SERVICE_STATUS_CONTINUE_PENDING;
+    case SERVICE_PAUSE_PENDING:
+        return GUEST_DRIVER_SERVICE_STATUS_PAUSE_PENDING;
+    case SERVICE_PAUSED:
+        return GUEST_DRIVER_SERVICE_STATUS_PAUSED;
+    default:
+        return GUEST_DRIVER_SERVICE_STATUS_UNKNOWN;
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
+GuestDriverServiceList *qmp_guest_get_driver_services(Error **errp)
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
+            service->status = ga_driver_service_status(
+                services[i].ServiceStatusProcess.dwCurrentState);
+            if (service->status == GUEST_DRIVER_SERVICE_STATUS_UNKNOWN) {
+                slog("driver service '%s' has unknown state %lu",
+                     service->name,
+                     services[i].ServiceStatusProcess.dwCurrentState);
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
index 081c99bc74..913fe25924 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1590,6 +1590,33 @@
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
+# @unknown: SCM returned a service state not recognized by this
+#     QGA version
+#
+# Since: 11.2
+##
+{ 'enum': 'GuestDriverServiceStatus',
+  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
+            'continue-pending', 'pause-pending', 'paused', 'unknown' ],
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @GuestDriverPackage:
 #
@@ -1610,6 +1637,26 @@
             '*vendor': 'str' },
   'if': 'CONFIG_WIN32' }
 
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
 ##
 # @guest-get-driver-packages:
 #
@@ -1621,6 +1668,17 @@
   'returns': ['GuestDriverPackage'],
   'if': 'CONFIG_WIN32' }
 
+##
+# @guest-get-driver-services:
+#
+# Retrieve registered driver services in the guest.
+#
+# Since: 11.2
+##
+{ 'command': 'guest-get-driver-services',
+  'returns': ['GuestDriverService'],
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @GuestAuthorizedKeys:
 #
-- 
2.55.0


