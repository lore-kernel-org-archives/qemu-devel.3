Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8AFEA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq7If-0007z8-4y; Wed, 11 Feb 2026 05:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq7Ic-0007yg-VD
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq7Ia-0005wO-2i
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770805098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+opFV59lOmkovnJoL29o2Kllbz8+HfC0/3PIzlkgYE=;
 b=e3qJfxYl/MScZMGxm/4CyV2WB8i3JDM2V/p6C/FPhUEmyAv12qEzngA3RPXLF6zmgIe8vD
 QlbhZBTnFmZGymzi6AIKcbuKqE72dWHrBVNXCKIxVQORwewUCVAvYYfTba+WJyBIqRCXgM
 0zEeZ3NALbp0ATYA4AtHVY5aDo6Krxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-Cw5TTPOANsueIwJH8Lys5w-1; Wed,
 11 Feb 2026 05:18:17 -0500
X-MC-Unique: Cw5TTPOANsueIwJH8Lys5w-1
X-Mimecast-MFC-AGG-ID: Cw5TTPOANsueIwJH8Lys5w_1770805096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A7401955E72
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 10:18:15 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0605B180066A; Wed, 11 Feb 2026 10:18:13 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v2 1/2] qga: Move CoInitialize/CoInitializeSecurity to main
 process thread
Date: Wed, 11 Feb 2026 12:17:43 +0200
Message-ID: <20260211101744.757548-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

Problem:
Two issues with COM initialization:

Issue #1: Incorrect call order
- requester_init() called CoInitializeSecurity first
- Per Microsoft documentation, CoInitialize() must be called BEFORE
  CoInitializeSecurity()

Issue #2: Incorrect call location
- CoInitializeSecurity was called from dll instead of the main process
- Per Microsoft documentation, CoInitializeSecurity() must be called exactly once per process from
  the main executable, not from a DLL

Reference:
https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-coinitializesecurity
https://learn.microsoft.com/en-us/windows/win32/api/objbase/nf-objbase-coinitialize

This caused incorrect COM initialization, preventing VSS Writers from
calling back via IVssWriterCallback (hr = 0x80070005, Access denied,
Event ID 8194).

Fix:
- Initialize COM in main.c for both service and CLI modes
- Call CoInitialize() followed by CoInitializeSecurity() in correct order
  in the main thread before any VSS operations
- Add proper CoUninitialize() cleanup

Result:
VSS Writers can now successfully call back to the agent. Event ID 8194
error is resolved.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/main.c                  | 42 +++++++++++++++++++++++++++++++++++++
 qga/vss-win32/requester.cpp | 13 ------------
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index dd1c216f9a..fd19c7037d 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -32,6 +32,8 @@
 #include "qemu/systemd.h"
 #include "qemu-version.h"
 #ifdef _WIN32
+#include <windows.h>
+#include <objbase.h>
 #include <dbt.h>
 #include <pdh.h>
 #include "qga/service-win32.h"
@@ -830,6 +832,29 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
     return ret;
 }
 
+/* Initialize COM for VSS operations */
+static HRESULT init_com(void)
+{
+    HRESULT hr;
+
+    hr = CoInitialize(NULL);
+    if (FAILED(hr)) {
+        return hr;
+    }
+
+    hr = CoInitializeSecurity(
+        NULL, -1, NULL, NULL,
+        RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
+        RPC_C_IMP_LEVEL_IDENTIFY,
+        NULL, EOAC_NONE, NULL);
+    if (FAILED(hr)) {
+        CoUninitialize();
+        return hr;
+    }
+
+    return S_OK;
+}
+
 VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
 {
     GAService *service = &ga_state->service;
@@ -842,6 +867,13 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
         return;
     }
 
+    /* Initialize COM for VSS operations in the service thread */
+    HRESULT hr_com = init_com();
+    if (FAILED(hr_com)) {
+        g_critical("Failed to initialize COM in service thread: 0x%lx", hr_com);
+        return;
+    }
+
     service->status.dwServiceType = SERVICE_WIN32;
     service->status.dwCurrentState = SERVICE_RUNNING;
     service->status.dwControlsAccepted = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_SHUTDOWN;
@@ -866,6 +898,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
 
     run_agent(ga_state);
 
+    CoUninitialize();
+
     UnregisterDeviceNotification(service->device_notification_handle);
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
@@ -1719,7 +1753,15 @@ int main(int argc, char **argv)
         StartServiceCtrlDispatcher(service_table);
         ret = EXIT_SUCCESS;
     } else {
+        HRESULT hr_com = init_com();
+        if (FAILED(hr_com)) {
+            g_critical("Failed to initialize COM: 0x%lx", hr_com);
+            ret = EXIT_FAILURE;
+            goto end;
+        }
+
         ret = run_agent(s);
+        CoUninitialize();
     }
 #else
     ret = run_agent(s);
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 74489fcd0a..626d6ab1ff 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -60,15 +60,6 @@ STDAPI requester_init(void)
 {
     qga_debug_begin;
 
-    COMInitializer initializer; /* to call CoInitializeSecurity */
-    HRESULT hr = CoInitializeSecurity(
-        NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
-        RPC_C_IMP_LEVEL_IDENTIFY, NULL, EOAC_NONE, NULL);
-    if (FAILED(hr)) {
-        qga_debug("failed to CoInitializeSecurity (error %lx)", hr);
-        return hr;
-    }
-
     hLib = LoadLibraryA("VSSAPI.DLL");
     if (!hLib) {
         qga_debug("failed to load VSSAPI.DLL");
@@ -320,8 +311,6 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         return;
     }
 
-    CoInitialize(NULL);
-
     /* Allow unrestricted access to events */
     InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
     SetSecurityDescriptorDacl(&sd, TRUE, NULL, FALSE);
@@ -562,7 +551,6 @@ out:
 
 out1:
     requester_cleanup();
-    CoUninitialize();
 
     qga_debug_end;
 }
@@ -643,7 +631,6 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
     *num_vols = vss_ctx.cFrozenVols;
     requester_cleanup();
 
-    CoUninitialize();
     StopService();
 
     qga_debug_end;
-- 
2.51.0


