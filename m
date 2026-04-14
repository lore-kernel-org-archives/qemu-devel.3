Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0AFF9D0D3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeVv-0000GE-EZ; Tue, 14 Apr 2026 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1wCeVt-0000G0-S9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1wCeVq-0004wN-7N
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776175988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z4cAyYjhB1JL75emTOEhz758wY9XkPfXmhQM2nLHomA=;
 b=VlTaJUrshjT2OVItWQC6qqQFWOmevMPHet6I1rf4rk6u39uQN8tXDV0tZxzZEC8IkuFepV
 hdFZ8PbbQnEcU+NARwhPjeiXSfYy3EoNHOZuXgcp4TjUis0YdlP+aQTiYmLr+dVwi4HAsr
 npowzt3EnHNHDm7woQW9N+RV+PCPORo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-C6yv_4h6OLasXnoPj_dtbw-1; Tue,
 14 Apr 2026 10:13:04 -0400
X-MC-Unique: C6yv_4h6OLasXnoPj_dtbw-1
X-Mimecast-MFC-AGG-ID: C6yv_4h6OLasXnoPj_dtbw_1776175982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F34419560B2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 14:13:02 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.36])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1813180049F; Tue, 14 Apr 2026 14:12:59 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, berrange@redhat.com, armbru@redhat.com,
 yvugenfi@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v3] qga: add security info to guest-get-osinfo
Date: Tue, 14 Apr 2026 17:11:11 +0300
Message-ID: <20260414141111.2471509-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
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

Extend guest-get-osinfo to include security features status
(VBS, Secure Boot, TPM) in a nested 'security' field.
OS-specific data (e.g. Windows DeviceGuard) is separated
using a union to allow future per-OS extensions.

TPM and Secure Boot information are represented as dedicated
structs (GuestSecurityTPMInfo and GuestSecuritySecureBootInfo).

The implementation queries Win32_DeviceGuard and Win32_Tpm via
WMI, and reads UEFI variables (SecureBoot, SetupMode, AuditMode,
DeployedMode) through GetFirmwareEnvironmentVariable().

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 437 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 134 ++++++++++++-
 2 files changed, 570 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..0c8ab5af1b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -28,6 +28,7 @@
 #include <wtsapi32.h>
 #include <wininet.h>
 #include <pdh.h>
+#include <wbemidl.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -2252,6 +2253,8 @@ static char *ga_get_current_arch(void)
     return result;
 }
 
+static void populate_security_info(GuestOSInfo *osinfo);
+
 GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 {
     Error *local_err = NULL;
@@ -2289,6 +2292,8 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     info->variant = g_strdup(server ? "server" : "client");
     info->variant_id = g_strdup(server ? "server" : "client");
 
+    populate_security_info(info);
+
     return info;
 }
 
@@ -2764,3 +2769,435 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
     g_hash_table_destroy(interface_metric_cache);
     return head;
 }
+
+/*
+ * WMI GUIDs
+ */
+static const GUID qga_CLSID_WbemLocator = {
+    0x4590f811, 0x1d3a, 0x11d0,
+    {0x89, 0x1f, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}
+};
+static const GUID qga_IID_IWbemLocator = {
+    0xdc12a687, 0x737f, 0x11cf,
+    {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}
+};
+
+static IWbemServices *wmi_connect_to_namespace(const wchar_t *namespace_path,
+                                               Error **errp)
+{
+    HRESULT hr;
+    IWbemLocator *locator = NULL;
+    IWbemServices *services = NULL;
+    BSTR bstr_ns = SysAllocString(namespace_path);
+
+    if (!bstr_ns) {
+        error_setg(errp, "failed to allocate WMI namespace string");
+        return NULL;
+    }
+
+    hr = CoCreateInstance(&qga_CLSID_WbemLocator, NULL, CLSCTX_INPROC_SERVER,
+                          &qga_IID_IWbemLocator, (LPVOID *)&locator);
+    if (FAILED(hr)) {
+        error_setg_win32(errp, hr, "failed to create IWbemLocator");
+        goto out;
+    }
+
+    hr = locator->lpVtbl->ConnectServer(locator, bstr_ns, NULL, NULL, NULL,
+                                        0, NULL, NULL, &services);
+    if (FAILED(hr)) {
+        error_setg_win32(errp, hr, "failed to connect to WMI namespace");
+        goto out;
+    }
+
+    hr = CoSetProxyBlanket((IUnknown *)services,
+                           RPC_C_AUTHN_WINNT, RPC_C_AUTHZ_NONE, NULL,
+                           RPC_C_AUTHN_LEVEL_CALL,
+                           RPC_C_IMP_LEVEL_IMPERSONATE,
+                           NULL, EOAC_NONE);
+    if (FAILED(hr)) {
+        error_setg_win32(errp, hr, "failed to set WMI proxy blanket");
+        services->lpVtbl->Release(services);
+        services = NULL;
+    }
+
+out:
+    SysFreeString(bstr_ns);
+    if (locator) {
+        locator->lpVtbl->Release(locator);
+    }
+    return services;
+}
+
+static IEnumWbemClassObject *wmi_exec_query(IWbemServices *services,
+                                            const wchar_t *query,
+                                            Error **errp)
+{
+    HRESULT hr;
+    IEnumWbemClassObject *enumerator = NULL;
+    BSTR bstr_wql = SysAllocString(L"WQL");
+    BSTR bstr_query = SysAllocString(query);
+
+    if (!bstr_wql || !bstr_query) {
+        error_setg(errp, "failed to allocate WMI query strings");
+        goto out;
+    }
+
+    hr = services->lpVtbl->ExecQuery(services, bstr_wql, bstr_query,
+                                     WBEM_FLAG_RETURN_IMMEDIATELY |
+                                     WBEM_FLAG_FORWARD_ONLY,
+                                     NULL, &enumerator);
+    if (FAILED(hr)) {
+        error_setg_win32(errp, hr, "WMI query failed");
+    }
+
+out:
+    SysFreeString(bstr_wql);
+    SysFreeString(bstr_query);
+    return enumerator;
+}
+
+static HRESULT wmi_get_property(IWbemClassObject *obj, const wchar_t *name,
+                                VARIANT *var)
+{
+    return obj->lpVtbl->Get(obj, name, 0, var, NULL, NULL);
+}
+
+/* Read a WMI integer property (VT_I4 or VT_UI4). */
+static bool wmi_get_int_property(IWbemClassObject *obj,
+                                 const wchar_t *name,
+                                 int64_t *out)
+{
+    VARIANT var;
+    bool ret = false;
+
+    VariantInit(&var);
+    if (SUCCEEDED(wmi_get_property(obj, name, &var))) {
+        if (V_VT(&var) == VT_I4) {
+            *out = V_I4(&var);
+            ret = true;
+        } else if (V_VT(&var) == VT_UI4) {
+            *out = V_UI4(&var);
+            ret = true;
+        }
+    }
+    VariantClear(&var);
+    return ret;
+}
+
+/* Read an integer SAFEARRAY WMI property into a QAPI intList. */
+static bool wmi_safearray_to_int_list(IWbemClassObject *obj,
+                                      const wchar_t *prop_name,
+                                      intList **list)
+{
+    VARIANT var;
+    HRESULT hr;
+    LONG lb, ub, i;
+    uint32_t *data = NULL;
+
+    VariantInit(&var);
+    hr = wmi_get_property(obj, prop_name, &var);
+    if (FAILED(hr) || V_VT(&var) == VT_NULL) {
+        VariantClear(&var);
+        return false;
+    }
+
+    if (!(V_VT(&var) & VT_ARRAY)) {
+        VariantClear(&var);
+        return false;
+    }
+
+    SAFEARRAY *sa = V_ARRAY(&var);
+    if (FAILED(SafeArrayGetLBound(sa, 1, &lb)) ||
+        FAILED(SafeArrayGetUBound(sa, 1, &ub))) {
+        VariantClear(&var);
+        return false;
+    }
+
+    if (FAILED(SafeArrayAccessData(sa, (void **)&data))) {
+        VariantClear(&var);
+        return false;
+    }
+
+    intList **tail = list;
+    for (i = 0; i <= ub - lb; i++) {
+        QAPI_LIST_APPEND(tail, (int64_t)data[i]);
+    }
+
+    SafeArrayUnaccessData(sa);
+    VariantClear(&var);
+    return true;
+}
+
+/*
+ * Query Win32_DeviceGuard WMI class for VBS and related properties.
+ */
+static void get_device_guard_info(GuestSecurityInfoWindows *info,
+                                  Error **errp)
+{
+    Error *local_err = NULL;
+    IWbemServices *services = NULL;
+    IEnumWbemClassObject *enumerator = NULL;
+    IWbemClassObject *obj = NULL;
+    ULONG count = 0;
+    HRESULT hr;
+    int64_t val;
+
+    services = wmi_connect_to_namespace(
+        L"ROOT\\Microsoft\\Windows\\DeviceGuard", &local_err);
+    if (!services) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    enumerator = wmi_exec_query(services,
+        L"SELECT * FROM Win32_DeviceGuard", &local_err);
+    if (!enumerator) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
+                                   &obj, &count);
+    if (FAILED(hr)) {
+        error_setg_win32(errp, hr, "failed to enumerate Win32_DeviceGuard");
+        goto out;
+    }
+    if (count == 0) {
+        error_setg(errp, "no Win32_DeviceGuard instance found");
+        goto out;
+    }
+
+    if (wmi_get_int_property(obj, L"VirtualizationBasedSecurityStatus",
+                             &val)) {
+        info->has_vbs_status = true;
+        info->vbs_status = val;
+    }
+
+    if (wmi_get_int_property(obj, L"CodeIntegrityPolicyEnforcementStatus",
+                             &val)) {
+        info->has_code_integrity_policy_enforcement_status = true;
+        info->code_integrity_policy_enforcement_status = val;
+    }
+
+    if (wmi_get_int_property(obj,
+                             L"UsermodeCodeIntegrityPolicyEnforcementStatus",
+                             &val)) {
+        info->has_usr_cfg_code_integrity_policy_enforcement_status = true;
+        info->usr_cfg_code_integrity_policy_enforcement_status = val;
+    }
+
+    if (wmi_safearray_to_int_list(obj, L"AvailableSecurityProperties",
+                                  &info->available_security_properties)) {
+        info->has_available_security_properties = true;
+    }
+
+    if (wmi_safearray_to_int_list(obj, L"RequiredSecurityProperties",
+                                  &info->required_security_properties)) {
+        info->has_required_security_properties = true;
+    }
+
+    if (wmi_safearray_to_int_list(obj, L"SecurityServicesConfigured",
+                                  &info->security_services_configured)) {
+        info->has_security_services_configured = true;
+    }
+
+    if (wmi_safearray_to_int_list(obj, L"SecurityServicesRunning",
+                                  &info->security_services_running)) {
+        info->has_security_services_running = true;
+    }
+
+    obj->lpVtbl->Release(obj);
+    obj = NULL;
+
+    /* Drain remaining results */
+    while (true) {
+        hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
+                                      &obj, &count);
+        if (FAILED(hr) || count == 0) {
+            break;
+        }
+        obj->lpVtbl->Release(obj);
+        obj = NULL;
+    }
+
+out:
+    if (obj) {
+        obj->lpVtbl->Release(obj);
+    }
+    if (enumerator) {
+        enumerator->lpVtbl->Release(enumerator);
+    }
+    if (services) {
+        services->lpVtbl->Release(services);
+    }
+}
+
+#define EFI_GLOBAL_VARIABLE_GUID \
+    "{8be4df61-93ca-11d2-aa0d-00e098032b8c}"
+
+/*
+ * Read a single-byte UEFI variable.  Returns true on success and
+ * stores the value in *out.  Returns false on failure.
+ */
+static bool read_efi_var(const char *name, BYTE *out)
+{
+    DWORD ret = GetFirmwareEnvironmentVariableA(
+        name, EFI_GLOBAL_VARIABLE_GUID, out, sizeof(*out));
+    return ret != 0;
+}
+
+/*
+ * Read UEFI Secure Boot variables.  Returns NULL on legacy BIOS
+ * systems or when the information is unavailable.
+ */
+static GuestSecuritySecureBootInfo *get_secure_boot_info(void)
+{
+    Error *local_err = NULL;
+    GuestSecuritySecureBootInfo *sb;
+    BYTE value = 0;
+
+    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
+    if (local_err) {
+        g_warning("SecureBoot privilege failed: %s",
+                  error_get_pretty(local_err));
+        error_free(local_err);
+        return NULL;
+    }
+
+    if (!read_efi_var("SecureBoot", &value)) {
+        DWORD err = GetLastError();
+        if (err == ERROR_INVALID_FUNCTION) {
+            return NULL;
+        }
+        if (err == ERROR_ENVVAR_NOT_FOUND) {
+            sb = g_new0(GuestSecuritySecureBootInfo, 1);
+            sb->enabled = false;
+            return sb;
+        }
+        g_warning("failed to read SecureBoot UEFI variable: 0x%lx", err);
+        return NULL;
+    }
+
+    sb = g_new0(GuestSecuritySecureBootInfo, 1);
+    sb->enabled = (value == 1);
+
+    if (read_efi_var("SetupMode", &value)) {
+        sb->has_setup_mode = true;
+        sb->setup_mode = (value == 1);
+    }
+
+    if (read_efi_var("AuditMode", &value)) {
+        sb->has_audit_mode = true;
+        sb->audit_mode = (value == 1);
+    }
+
+    if (read_efi_var("DeployedMode", &value)) {
+        sb->has_deployed_mode = true;
+        sb->deployed_mode = (value == 1);
+    }
+
+    return sb;
+}
+
+/*
+ * Query Win32_Tpm WMI class for TPM presence and version.
+ * Returns a GuestSecurityTPMInfo on success, or NULL if no TPM
+ * is found or the namespace is unavailable.
+ */
+static GuestSecurityTPMInfo *get_tpm_info(void)
+{
+    Error *local_err = NULL;
+    IWbemServices *services = NULL;
+    IEnumWbemClassObject *enumerator = NULL;
+    IWbemClassObject *obj = NULL;
+    ULONG count = 0;
+    HRESULT hr;
+    VARIANT var;
+    GuestSecurityTPMInfo *tpm = NULL;
+
+    services = wmi_connect_to_namespace(
+        L"ROOT\\CIMV2\\Security\\MicrosoftTpm", &local_err);
+    if (!services) {
+        error_free(local_err);
+        return NULL;
+    }
+
+    enumerator = wmi_exec_query(services,
+        L"SELECT * FROM Win32_Tpm", &local_err);
+    if (!enumerator) {
+        error_free(local_err);
+        goto out;
+    }
+
+    hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
+                                   &obj, &count);
+    if (FAILED(hr) || count == 0) {
+        goto out;
+    }
+
+    tpm = g_new0(GuestSecurityTPMInfo, 1);
+
+    /* SpecVersion is "major.minor, revision, errata" e.g. "2.0, 0, 1.59" */
+    VariantInit(&var);
+    if (SUCCEEDED(wmi_get_property(obj, L"SpecVersion", &var)) &&
+        V_VT(&var) == VT_BSTR && V_BSTR(&var)) {
+        g_autofree char *version = g_utf16_to_utf8(
+            (const gunichar2 *)V_BSTR(&var), -1, NULL, NULL, NULL);
+        if (version) {
+            char *dot = strchr(version, '.');
+            if (dot) {
+                *dot = '\0';
+            }
+            tpm->major_version = g_ascii_strtoll(version, NULL, 10);
+        }
+    }
+    VariantClear(&var);
+
+    obj->lpVtbl->Release(obj);
+    obj = NULL;
+
+    /* Drain remaining results */
+    while (true) {
+        hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
+                                      &obj, &count);
+        if (FAILED(hr) || count == 0) {
+            break;
+        }
+        obj->lpVtbl->Release(obj);
+        obj = NULL;
+    }
+
+out:
+    if (obj) {
+        obj->lpVtbl->Release(obj);
+    }
+    if (enumerator) {
+        enumerator->lpVtbl->Release(enumerator);
+    }
+    if (services) {
+        services->lpVtbl->Release(services);
+    }
+    return tpm;
+}
+
+static void populate_security_info(GuestOSInfo *osinfo)
+{
+    Error *local_err = NULL;
+    GuestSecurityInfo *info = g_new0(GuestSecurityInfo, 1);
+
+    info->os = g_new0(GuestSecurityInfoOs, 1);
+    info->os->type = GUEST_SECURITY_INFO_TYPE_WINDOWS;
+
+    get_device_guard_info(&info->os->u.windows, &local_err);
+    if (local_err) {
+        g_warning("DeviceGuard query failed: %s",
+                  error_get_pretty(local_err));
+        error_free(local_err);
+        local_err = NULL;
+    }
+
+    info->secure_boot = get_secure_boot_info();
+    info->tpm = get_tpm_info();
+
+    osinfo->security = info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..6f4b61355b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1490,6 +1490,10 @@
 #     * POSIX: as defined by os-release(5)
 #     * Windows: contains string "server" or "client"
 #
+# @security: Security features status.  Present if any security
+#     information (TPM, Secure Boot, etc.) could be retrieved.
+#     Currently populated on Windows guests only (since 11.1)
+#
 # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
 #    @version, @version-id, @variant and @variant-id follow the
 #    definition specified in os-release(5).  Refer to the manual page
@@ -1508,7 +1512,8 @@
       '*kernel-release': 'str', '*kernel-version': 'str',
       '*machine': 'str', '*id': 'str', '*name': 'str',
       '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
-      '*variant': 'str', '*variant-id': 'str' } }
+      '*variant': 'str', '*variant-id': 'str',
+      '*security': 'GuestSecurityInfo' } }
 
 ##
 # @guest-get-osinfo:
@@ -1952,3 +1957,130 @@
   'returns': ['GuestNetworkRoute'],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
 }
+
+##
+# @GuestSecurityInfoWindows:
+#
+# Windows-specific security features from the Win32_DeviceGuard
+# WMI class.  All values are raw integers as provided by the
+# Windows API.  See
+# https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity
+# for the meaning of each value.
+#
+# @vbs-status: Whether VBS is enabled and running.
+#
+# @available-security-properties: Relevant security properties
+#     available for VBS and memory integrity.
+#
+# @code-integrity-policy-enforcement-status: Code integrity
+#     policy enforcement status.
+#
+# @required-security-properties: Required security properties
+#     to enable VBS.
+#
+# @security-services-configured: Whether Credential Guard or
+#     memory integrity is configured.
+#
+# @security-services-running: Whether Credential Guard or
+#     memory integrity is running.
+#
+# @usr-cfg-code-integrity-policy-enforcement-status: User-mode
+#     code integrity policy enforcement status.
+#
+# Since: 11.1
+##
+{ 'struct': 'GuestSecurityInfoWindows',
+  'data': {
+      '*vbs-status': 'int',
+      '*available-security-properties': ['int'],
+      '*code-integrity-policy-enforcement-status': 'int',
+      '*required-security-properties': ['int'],
+      '*security-services-configured': ['int'],
+      '*security-services-running': ['int'],
+      '*usr-cfg-code-integrity-policy-enforcement-status': 'int' } }
+
+##
+# @GuestSecurityInfoType:
+#
+# Guest operating system type for security info.
+#
+# @windows: Microsoft Windows
+#
+# Since: 11.1
+##
+{ 'enum': 'GuestSecurityInfoType',
+  'data': ['windows'] }
+
+##
+# @GuestSecurityInfoOs:
+#
+# OS-specific security information.
+#
+# @type: guest operating system type
+#
+# Since: 11.1
+##
+{ 'union': 'GuestSecurityInfoOs',
+  'base': { 'type': 'GuestSecurityInfoType' },
+  'discriminator': 'type',
+  'data': {
+      'windows': 'GuestSecurityInfoWindows' } }
+
+##
+# @GuestSecurityTPMInfo:
+#
+# TPM device information.  The presence of this struct indicates
+# that a TPM device exists on the guest.
+#
+# @major-version: TPM specification major version (e.g. 1 or 2)
+#
+# Since: 11.1
+##
+{ 'struct': 'GuestSecurityTPMInfo',
+  'data': {
+      'major-version': 'int' } }
+
+##
+# @GuestSecuritySecureBootInfo:
+#
+# UEFI Secure Boot information.  The presence of this struct
+# indicates that the guest supports UEFI Secure Boot.
+#
+# @enabled: Whether Secure Boot is currently enabled
+#
+# @audit-mode: Whether Secure Boot is in audit mode
+#
+# @deployed-mode: Whether Secure Boot is in deployed mode
+#
+# @setup-mode: Whether Secure Boot is in setup mode
+#
+# Since: 11.1
+##
+{ 'struct': 'GuestSecuritySecureBootInfo',
+  'data': {
+      'enabled': 'bool',
+      '*audit-mode': 'bool',
+      '*deployed-mode': 'bool',
+      '*setup-mode': 'bool' } }
+
+##
+# @GuestSecurityInfo:
+#
+# Guest security features status.  Fields are optional; a missing
+# field means the information is not available on this guest OS.
+#
+# @tpm: TPM device information.  Absent if no TPM is present
+#     or the information is unavailable.
+#
+# @secure-boot: UEFI Secure Boot information.  Absent on
+#     legacy BIOS systems or if unavailable.
+#
+# @os: OS-specific security information
+#
+# Since: 11.1
+##
+{ 'struct': 'GuestSecurityInfo',
+  'data': {
+      '*tpm': 'GuestSecurityTPMInfo',
+      '*secure-boot': 'GuestSecuritySecureBootInfo',
+      '*os': 'GuestSecurityInfoOs' } }
-- 
2.51.0


