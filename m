Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D031F506C1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w278U-0007iU-Bd; Mon, 16 Mar 2026 08:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w277h-0007bv-Sy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w277c-0007Rp-Gg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773664354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O+Hpy1ArqlIu124DGvtA7z9hNV0JwJ6yTa03OYWNFWU=;
 b=RAzaTVB6USUMOj9KA69h66KIzJmzB8ZHK99/7JEQeG57GXDTzQ8EaSLyOQex2dYKgd0UG9
 NZ9H137wmtfGtjWJBwq9ovPYh5KIDZSqwpgSzBkrtcd3alGWSLUVA11eUBrGIDAmNijNvE
 ezt+sGiJiI+yDwgPJW0+6kV1M1vv5JQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-YwLYdWq7MCOYXqF2GFD_2w-1; Mon,
 16 Mar 2026 08:32:32 -0400
X-MC-Unique: YwLYdWq7MCOYXqF2GFD_2w-1
X-Mimecast-MFC-AGG-ID: YwLYdWq7MCOYXqF2GFD_2w_1773664351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78BE1944F12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 12:32:31 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EED731955F19; Mon, 16 Mar 2026 12:32:29 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v1] qga: add guest-get-windows-security-info command
Date: Mon, 16 Mar 2026 14:31:43 +0200
Message-ID: <20260316123144.1758888-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new Windows-only QGA command to retrieve Windows security
features status including VBS, Secure Boot, and TPM information
from the guest.

The implementation queries Win32_DeviceGuard and Win32_Tpm via
WMI, and reads the SecureBoot UEFI variable through
GetFirmwareEnvironmentVariable().

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 404 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  56 ++++++
 2 files changed, 460 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..8da9ef521f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -28,6 +28,7 @@
 #include <wtsapi32.h>
 #include <wininet.h>
 #include <pdh.h>
+#include <wbemidl.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -2764,3 +2765,406 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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
+static void get_device_guard_info(GuestWindowsSecurityInfo *info,
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
+/*
+ * Read the SecureBoot UEFI variable to determine whether Secure Boot
+ * is enabled.  Returns false on legacy BIOS systems.
+ */
+static bool get_secure_boot_status(Error **errp)
+{
+    Error *local_err = NULL;
+    BYTE value = 0;
+    DWORD ret;
+
+    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    ret = GetFirmwareEnvironmentVariableA("SecureBoot",
+        "{8be4df61-93ca-11d2-aa0d-00e098032b8c}", &value, sizeof(value));
+
+    if (ret == 0) {
+        DWORD err = GetLastError();
+        if (err == ERROR_INVALID_FUNCTION || err == ERROR_ENVVAR_NOT_FOUND) {
+            return false;
+        }
+        error_setg_win32(errp, err,
+                         "failed to read SecureBoot UEFI variable");
+        return false;
+    }
+
+    return value == 1;
+}
+
+/*
+ * Query Win32_Tpm WMI class for TPM presence and version.
+ */
+static void get_tpm_info(GuestWindowsSecurityInfo *info, Error **errp)
+{
+    Error *local_err = NULL;
+    IWbemServices *services = NULL;
+    IEnumWbemClassObject *enumerator = NULL;
+    IWbemClassObject *obj = NULL;
+    ULONG count = 0;
+    HRESULT hr;
+    VARIANT var;
+
+    services = wmi_connect_to_namespace(
+        L"ROOT\\CIMV2\\Security\\MicrosoftTpm", &local_err);
+    if (!services) {
+        /* TPM namespace may not exist -- not an error */
+        error_free(local_err);
+        info->tpm_present = false;
+        return;
+    }
+
+    enumerator = wmi_exec_query(services,
+        L"SELECT * FROM Win32_Tpm", &local_err);
+    if (!enumerator) {
+        error_free(local_err);
+        info->tpm_present = false;
+        goto out;
+    }
+
+    hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
+                                   &obj, &count);
+    if (FAILED(hr) || count == 0) {
+        info->tpm_present = false;
+        goto out;
+    }
+
+    info->tpm_present = true;
+
+    VariantInit(&var);
+    if (SUCCEEDED(wmi_get_property(obj, L"SpecVersion", &var)) &&
+        V_VT(&var) == VT_BSTR && V_BSTR(&var)) {
+        info->tpm_version = g_utf16_to_utf8(
+            (const gunichar2 *)V_BSTR(&var), -1, NULL, NULL, NULL);
+        if (info->tpm_version) {
+            /* keep only the part before the first comma */
+            char *comma = strchr(info->tpm_version, ',');
+            if (comma) {
+                *comma = '\0';
+            }
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
+}
+
+GuestWindowsSecurityInfo *qmp_guest_get_windows_security_info(Error **errp)
+{
+    Error *local_err = NULL;
+    GuestWindowsSecurityInfo *info = g_new0(GuestWindowsSecurityInfo, 1);
+
+    get_device_guard_info(info, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err;
+    }
+
+    info->secure_boot = get_secure_boot_status(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err;
+    }
+
+    get_tpm_info(info, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err;
+    }
+
+    return info;
+
+err:
+    qapi_free_GuestWindowsSecurityInfo(info);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..f54fdf942f 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1952,3 +1952,59 @@
   'returns': ['GuestNetworkRoute'],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
 }
+
+##
+# @GuestWindowsSecurityInfo:
+#
+# Windows security features status.
+#
+# @vbs-status: VirtualizationBasedSecurityStatus
+#
+# @available-security-properties: AvailableSecurityProperties
+#
+# @code-integrity-policy-enforcement-status:
+#     CodeIntegrityPolicyEnforcementStatus
+#
+# @required-security-properties: RequiredSecurityProperties
+#
+# @security-services-configured: SecurityServicesConfigured
+#
+# @security-services-running: SecurityServicesRunning
+#
+# @usr-cfg-code-integrity-policy-enforcement-status:
+#     UsermodeCodeIntegrityPolicyEnforcementStatus
+#
+# @secure-boot: Whether UEFI Secure Boot is enabled
+#
+# @tpm-present: Whether a TPM device is present
+#
+# @tpm-version: TPM specification version string (e.g. "2.0")
+#
+# Since: 10.3
+##
+{ 'struct': 'GuestWindowsSecurityInfo',
+  'data': {
+      'vbs-status': 'int',
+      '*available-security-properties': ['int'],
+      '*code-integrity-policy-enforcement-status': 'int',
+      '*required-security-properties': ['int'],
+      '*security-services-configured': ['int'],
+      '*security-services-running': ['int'],
+      '*usr-cfg-code-integrity-policy-enforcement-status': 'int',
+      'secure-boot': 'bool',
+      'tpm-present': 'bool',
+      '*tpm-version': 'str' },
+  'if': 'CONFIG_WIN32' }
+
+##
+# @guest-get-windows-security-info:
+#
+# Retrieve Windows security features status (VBS, Secure Boot, TPM).
+#
+# Returns: @GuestWindowsSecurityInfo
+#
+# Since: 10.3
+##
+{ 'command': 'guest-get-windows-security-info',
+  'returns': 'GuestWindowsSecurityInfo',
+  'if': 'CONFIG_WIN32' }
-- 
2.51.0


