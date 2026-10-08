Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762B2CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnSn-0006mR-E0; Thu, 08 Oct 2026 08:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xEnSg-0006mB-Iq
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xEnSe-0007QQ-6I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791463379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VrvIWzdLlqcZ/Gz/f2HmrXfKMkG9YCwD+x1W/fRoKIQ=;
 b=BPfPfNVRrF+l9gQl8pAPlM/4eNDxO3MWBAHNCtkah5l+rSgc7UnAC/Y4IU2XNmcIMIdwyo
 GWi9lYwv4v2s9mfDbnZ9JH/M3SBysn88cS0g0BzgxYPXrSSwIuivOWwV0pfgGHUlYDgW3j
 RBJH0wC04yYzuFZRFW8kQ/Jonxj29MU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-7W3WouGPN8G-RFXZGpMXpA-1; Thu,
 08 Oct 2026 08:42:57 -0400
X-MC-Unique: 7W3WouGPN8G-RFXZGpMXpA-1
X-Mimecast-MFC-AGG-ID: 7W3WouGPN8G-RFXZGpMXpA_1791463376
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2C61187A5EE; Thu,  8 Oct 2026 12:42:56 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.50.10.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22301800446; Thu,  8 Oct 2026 12:42:53 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, dholler@redhat.com,
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com,
 kramdoss@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v2 1/2] qga: Add guest-get-driver-packages command for Windows
Date: Thu,  8 Oct 2026 15:39:19 +0300
Message-ID: <20261008123920.3861059-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URI_TRY_3LD=0.647 autolearn=no autolearn_force=no
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

Add a new guest-get-driver-packages command that returns out-of-box
driver packages from the Windows Driver Store, enumerated via the
DISM API (DismGetDrivers).  Each entry includes the published INF
name, original INF name, version, and provider.

Load DismApi.dll dynamically with LoadLibraryExW so that its absence
does not prevent qemu-ga from starting.  Initialize DISM lazily once
per QGA process and open a separate online DISM session for each
command invocation, with process cleanup registered through
ga_command_state_add.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 292 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  31 +++++
 2 files changed, 323 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2bf5581aaa..e01033d8c5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -28,6 +28,7 @@
 #include <wtsapi32.h>
 #include <wininet.h>
 #include <pdh.h>
+#include <dismapi.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -1981,12 +1982,15 @@ done:
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
@@ -2455,6 +2459,294 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
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
+GuestDriverPackageList *qmp_guest_get_driver_packages(Error **errp)
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
 char *qga_get_host_name(Error **errp)
 {
     wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8cd0ba048b..081c99bc74 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1590,6 +1590,37 @@
   'returns': ['GuestDeviceInfo'],
   'if': 'CONFIG_WIN32' }
 
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
+# @guest-get-driver-packages:
+#
+# Retrieve out-of-box driver packages installed in the guest.
+#
+# Since: 11.2
+##
+{ 'command': 'guest-get-driver-packages',
+  'returns': ['GuestDriverPackage'],
+  'if': 'CONFIG_WIN32' }
+
 ##
 # @GuestAuthorizedKeys:
 #
-- 
2.55.0


