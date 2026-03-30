Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D611061B0E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EPS-0007gi-50; Mon, 30 Mar 2026 11:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w7EPQ-0007gU-8o
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w7EPM-0003Ff-PG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774884002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SyxU+VB3YJH6Jla/Pk3XIMOej61g24pSm81zr1vN4xk=;
 b=VlBiZFeF9+OIis4cOHjFiONui6n1sn7V3w/Xv8xJfLdRygoFtEP5rUFWDY1w7g78Ig+VDG
 HuUfqd9MV9aXYMTybwrmOtn6cVkV357R2j+I1OEdQ7Wus/ZPEcQSlTS519gY2+De/r8X0U
 he0e21Rbpjc239a+cTKU42W/pFmR7ms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-hbHCwq6gOVyMMlcWG1Rlsw-1; Mon,
 30 Mar 2026 11:20:00 -0400
X-MC-Unique: hbHCwq6gOVyMMlcWG1Rlsw-1
X-Mimecast-MFC-AGG-ID: hbHCwq6gOVyMMlcWG1Rlsw_1774884000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1DF21956046
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 15:19:59 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.44.33.212])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77C291800351; Mon, 30 Mar 2026 15:19:57 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, yvugenfi@redhat.com, berrange@redhat.com,
 Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v2] qga: add security info to guest-get-osinfo
Date: Mon, 30 Mar 2026 18:19:41 +0300
Message-ID: <20260330151941.2207789-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Extend guest-get-osinfo to include security features status
(VBS, Secure Boot, TPM) in a nested 'security' field.
OS-specific data (e.g. Windows DeviceGuard) is separated
using a union to allow future per-OS extensions.

The implementation queries Win32_DeviceGuard and Win32_Tpm via
WMI, and reads the SecureBoot UEFI variable through
GetFirmwareEnvironmentVariable().

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/commands-win32.c | 421 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  91 +++++++++-
 2 files changed, 511 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..39ebdcf2cd 100644
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
 
@@ -2764,3 +2769,419 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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
+/*
+ * Read the SecureBoot UEFI variable.  On legacy BIOS systems the field
+ * is omitted (not applicable).
+ */
+static void get_secure_boot_status(GuestSecurityInfo *info,
+                                   Error **errp)
+{
+    Error *local_err = NULL;
+    BYTE value = 0;
+    DWORD ret;
+
+    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ret = GetFirmwareEnvironmentVariableA("SecureBoot",
+        "{8be4df61-93ca-11d2-aa0d-00e098032b8c}", &value, sizeof(value));
+
+    if (ret == 0) {
+        DWORD err = GetLastError();
+        if (err == ERROR_INVALID_FUNCTION) {
+            return;
+        }
+        if (err == ERROR_ENVVAR_NOT_FOUND) {
+            info->has_secure_boot = true;
+            info->secure_boot = false;
+            return;
+        }
+        error_setg_win32(errp, err,
+                         "failed to read SecureBoot UEFI variable");
+        return;
+    }
+
+    info->has_secure_boot = true;
+    info->secure_boot = (value == 1);
+}
+
+/*
+ * Query Win32_Tpm WMI class for TPM presence and version.
+ */
+static void get_tpm_info(GuestSecurityInfo *info, Error **errp)
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
+        /* TPM namespace may not exist -- field omitted (unknown) */
+        error_free(local_err);
+        return;
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
+        info->has_tpm_present = true;
+        info->tpm_present = false;
+        goto out;
+    }
+
+    info->has_tpm_present = true;
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
+    get_secure_boot_status(info, &local_err);
+    if (local_err) {
+        g_warning("SecureBoot query failed: %s",
+                  error_get_pretty(local_err));
+        error_free(local_err);
+        local_err = NULL;
+    }
+
+    get_tpm_info(info, &local_err);
+    if (local_err) {
+        g_warning("TPM query failed: %s",
+                  error_get_pretty(local_err));
+        error_free(local_err);
+        local_err = NULL;
+    }
+
+    osinfo->security = info;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..2247f77cff 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1490,6 +1490,8 @@
 #     * POSIX: as defined by os-release(5)
 #     * Windows: contains string "server" or "client"
 #
+# @security: Security features status (since 10.3)
+#
 # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
 #    @version, @version-id, @variant and @variant-id follow the
 #    definition specified in os-release(5).  Refer to the manual page
@@ -1508,7 +1510,8 @@
       '*kernel-release': 'str', '*kernel-version': 'str',
       '*machine': 'str', '*id': 'str', '*name': 'str',
       '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
-      '*variant': 'str', '*variant-id': 'str' } }
+      '*variant': 'str', '*variant-id': 'str',
+      '*security': 'GuestSecurityInfo' } }
 
 ##
 # @guest-get-osinfo:
@@ -1952,3 +1955,89 @@
   'returns': ['GuestNetworkRoute'],
   'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
 }
+
+##
+# @GuestSecurityInfoWindows:
+#
+# Windows-specific security features from Win32_DeviceGuard.
+#
+# @vbs-status: VirtualizationBasedSecurityStatus
+#
+# @available-security-properties:
+#     AvailableSecurityProperties
+#
+# @code-integrity-policy-enforcement-status:
+#     CodeIntegrityPolicyEnforcementStatus
+#
+# @required-security-properties: RequiredSecurityProperties
+#
+# @security-services-configured:
+#     SecurityServicesConfigured
+#
+# @security-services-running: SecurityServicesRunning
+#
+# @usr-cfg-code-integrity-policy-enforcement-status:
+#     UsermodeCodeIntegrityPolicyEnforcementStatus
+#
+# Since: 10.3
+##
+{ 'struct': 'GuestSecurityInfoWindows',
+  'data': {
+      '*vbs-status': 'int',
+      '*available-security-properties': ['int'],
+      '*code-integrity-policy-enforcement-status': 'int',
+      '*required-security-properties': ['int'],
+      '*security-services-configured': ['int'],
+      '*security-services-running': ['int'],
+      '*usr-cfg-code-integrity-policy-enforcement-status':
+          'int' } }
+
+##
+# @GuestSecurityInfoType:
+#
+# Guest operating system type for security info.
+#
+# @windows: Microsoft Windows
+#
+# Since: 10.3
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
+# Since: 10.3
+##
+{ 'union': 'GuestSecurityInfoOs',
+  'base': { 'type': 'GuestSecurityInfoType' },
+  'discriminator': 'type',
+  'data': {
+      'windows': 'GuestSecurityInfoWindows' } }
+
+##
+# @GuestSecurityInfo:
+#
+# Guest security features status.  Fields are optional; a missing
+# field means the information is not available on this platform.
+#
+# @tpm-present: Whether a TPM device is present
+#
+# @tpm-version: TPM specification version (e.g. "2.0")
+#
+# @secure-boot: Whether UEFI Secure Boot is enabled
+#
+# @os: OS-specific security information
+#
+# Since: 10.3
+##
+{ 'struct': 'GuestSecurityInfo',
+  'data': {
+      '*tpm-present': 'bool',
+      '*tpm-version': 'str',
+      '*secure-boot': 'bool',
+      '*os': 'GuestSecurityInfoOs' } }
-- 
2.51.0


