Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AC606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XgFeObUw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwW2-0003Ry-Ll; Thu, 19 Nov 2026 02:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwW1-0003Rn-Pl
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwVz-0007I9-1q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795073102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vxTAxqjMtikxHuOiHUza2DXggWEWi95hSzk0hddP/g=;
 b=XgFeObUwKJs7cD6mmjTUBP4O8i5P66Al3BtJlU9mOjgp4Nt/1C79HZaD4bQ2BiaCYH37+j
 cFdAaa7iVS7fqf7qZonbeEw9meXKDIt+TLcnFSQbiO8BjYfMcsWwNuEiwEpLeFD13aYwCk
 F7Cq4Iagw6ONUxNoFhi1AhnCXZK7sDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-qQ5zYNZkPkGMi3NuU74y6g-1; Thu,
 19 Nov 2026 02:25:00 -0500
X-MC-Unique: qQ5zYNZkPkGMi3NuU74y6g-1
X-Mimecast-MFC-AGG-ID: qQ5zYNZkPkGMi3NuU74y6g_1795073099
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 401C518004FC; Thu, 19 Nov 2026 07:24:59 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77FDE195604E; Thu, 19 Nov 2026 07:24:56 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, dholler@redhat.com,
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com,
 kramdoss@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v5 2/2] qga: Add guest-get-driver-services command for Windows
Date: Thu, 19 Nov 2026 09:24:37 +0200
Message-ID: <20261119072437.1418565-3-eashurov@redhat.com>
In-Reply-To: <20261119072437.1418565-1-eashurov@redhat.com>
References: <20261119072437.1418565-1-eashurov@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 qga/commands-win32.c | 364 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   5 +-
 qga/qapi-schema.json |  57 +++++++
 3 files changed, 424 insertions(+), 2 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e01033d8c5..e11260c8f0 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -29,6 +29,7 @@
 #include <wininet.h>
 #include <pdh.h>
 #include <dismapi.h>
+#include <winver.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -2747,6 +2748,369 @@ out:
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
+        expanded[1] = L'\\';
+
+        return g_steal_pointer(&expanded);
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
index 5cc43b87df..9703909d57 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -99,8 +99,9 @@ if host_os == 'freebsd'
   qga_libs += ['-ldevstat']
 endif
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
index 71417657fd..383ce1a872 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1541,6 +1541,33 @@
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
+# Since: 12.0
+##
+{ 'enum': 'GuestDriverServiceStatus',
+  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
+            'continue-pending', 'pause-pending', 'paused', 'unknown' ],
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @GuestDriverPackage:
 #     An out-of-box driver package installed in the guest
@@ -1561,6 +1588,26 @@
             '*vendor': 'str' },
   'if': 'CONFIG_WIN32' }
 
+##
+# @GuestDriverService:
+#
+# @name: service name
+#
+# @driver-path: driver binary path configured in the service database
+#
+# @version: four-part version of the driver binary
+#
+# @vendor: driver vendor name from the driver binary
+#
+# @status: current service status
+#
+# Since: 12.0
+##
+{ 'struct': 'GuestDriverService',
+  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
+            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @guest-get-driver-packages:
 #     Retrieve out-of-box driver packages installed in the guest.
@@ -1571,6 +1618,16 @@
   'returns': ['GuestDriverPackage'],
   'if': 'CONFIG_WIN32' }
 
+##
+# @guest-get-driver-services:
+#     Retrieve registered driver services in the guest.
+#
+# Since: 12.0
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


