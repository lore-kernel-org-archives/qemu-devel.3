Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B78EA3F18
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq68T-0007ff-M1; Wed, 11 Feb 2026 04:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq68R-0007fB-Hd
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq68O-0007sp-Re
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770800623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC/rJDEZ0ZY1+kXtHEHFg/DgvhgH8WZ1ZWMDx08SXJk=;
 b=gCdsH+0pRvz2vb2snrWGHZ0RLiaG7EH7ik1aclWHDmjVmPQOKCqTkGMhA5bn2lB8FNL503
 Bel+pasGI8w6JtnmZCcA03qEuifuiN3kpzHRxYimqsiA4DDPMjWmAVQmYU+/nyvqZDVo+K
 B0nC0yR1SrDCLgas/+nwcLs5uPvBc2g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-e12B3CH1OsS29LPi1Lo3sg-1; Wed,
 11 Feb 2026 04:02:20 -0500
X-MC-Unique: e12B3CH1OsS29LPi1Lo3sg-1
X-Mimecast-MFC-AGG-ID: e12B3CH1OsS29LPi1Lo3sg_1770800540
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41DB19560B3; Wed, 11 Feb 2026 09:02:19 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CB0A1956053; Wed, 11 Feb 2026 09:02:17 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: konstantin.kostiuk@gmail.com,
	Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH 1/2] qga: Move CoInitialize/CoInitializeSecurity to main
 process thread
Date: Wed, 11 Feb 2026 11:01:48 +0200
Message-ID: <20260211090151.747926-3-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qga/main.c                  | 43 +++++++++++++++++++++++++++++++++++++
 qga/vss-win32/requester.cpp | 15 ++-----------
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index dd1c216f9a..210d9983ab 100644
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
@@ -842,6 +844,24 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
         return;
     }
 
+    /* Initialize COM for VSS operations in the service thread */
+    HRESULT hr_com = CoInitialize(NULL);
+    if (FAILED(hr_com)) {
+        g_critical("Failed to initialize COM in service thread: 0x%lx", hr_com);
+        return;
+    }
+
+    hr_com = CoInitializeSecurity(
+        NULL, -1, NULL, NULL,
+        RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
+        RPC_C_IMP_LEVEL_IDENTIFY,
+        NULL, EOAC_NONE, NULL);
+    if (FAILED(hr_com)) {
+        g_critical("Failed to initialize COM security in service thread: 0x%lx", hr_com);
+        CoUninitialize();
+        return;
+    }
+
     service->status.dwServiceType = SERVICE_WIN32;
     service->status.dwCurrentState = SERVICE_RUNNING;
     service->status.dwControlsAccepted = SERVICE_ACCEPT_STOP | SERVICE_ACCEPT_SHUTDOWN;
@@ -866,6 +886,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
 
     run_agent(ga_state);
 
+    CoUninitialize();
+
     UnregisterDeviceNotification(service->device_notification_handle);
     service->status.dwCurrentState = SERVICE_STOPPED;
     SetServiceStatus(service->status_handle, &service->status);
@@ -1714,12 +1736,33 @@ int main(int argc, char **argv)
 
 #ifdef _WIN32
     if (config->daemonize) {
+        /* Service mode */
         SERVICE_TABLE_ENTRY service_table[] = {
             { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } };
         StartServiceCtrlDispatcher(service_table);
         ret = EXIT_SUCCESS;
     } else {
+        HRESULT hr_com = CoInitialize(NULL);
+        if (FAILED(hr_com)) {
+            g_critical("Failed to initialize COM: 0x%lx", hr_com);
+            ret = EXIT_FAILURE;
+            goto end;
+        }
+
+        hr_com = CoInitializeSecurity(
+            NULL, -1, NULL, NULL,
+            RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
+            RPC_C_IMP_LEVEL_IDENTIFY,
+            NULL, EOAC_NONE, NULL);
+        if (FAILED(hr_com)) {
+            g_critical("Failed to initialize COM security: 0x%lx", hr_com);
+            CoUninitialize();
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
index 74489fcd0a..9d978759f1 100644
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
@@ -562,7 +551,7 @@ out:
 
 out1:
     requester_cleanup();
-    CoUninitialize();
+    /* COM is managed at process level in main.c - don't call CoUninitialize here */
 
     qga_debug_end;
 }
@@ -643,7 +632,7 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
     *num_vols = vss_ctx.cFrozenVols;
     requester_cleanup();
 
-    CoUninitialize();
+    /* COM is managed at process level in main.c - don't call CoUninitialize here */
     StopService();
 
     qga_debug_end;
-- 
2.51.0


