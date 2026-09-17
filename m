Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE09C982DC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7EMt-0008HZ-Qh; Thu, 17 Sep 2026 11:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x7EMo-0008F9-3t
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x7EMX-00030X-S0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789660163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gXsgD9aeUmhzLoJqn2DRizwCL4Lga8IhLPEIIiubbGI=;
 b=a5wxEaW9XD6Dr4ZQUQJhsKL4L8BMS0QC1fV1q1jeDiKfmdzCFep0J3asJu7bnpqnrlAE27
 zkNI3Sr5M2QKO9tsHlYSjeFc8vOaIpIksGKVjCwiD3OCtQmpxqPeadMLoKPmAJDB23VeCN
 QWgvRcC1RCETF8W9s9qS9FdvW89xKZ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-D4viizJXOTuVGsbSwGQdWQ-1; Thu,
 17 Sep 2026 11:49:10 -0400
X-MC-Unique: D4viizJXOTuVGsbSwGQdWQ-1
X-Mimecast-MFC-AGG-ID: D4viizJXOTuVGsbSwGQdWQ_1789660149
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB241830191; Thu, 17 Sep 2026 15:49:09 +0000 (UTC)
Received: from aagbaria-thinkpadt14gen6.raanaii.csb (unknown [10.47.238.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 473D31800581; Thu, 17 Sep 2026 15:49:06 +0000 (UTC)
From: Abed Agbaria <aagbaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kkostiuk@redhat.com, michael.roth@amd.com,
 Abed Agbaria <aagbaria@redhat.com>
Subject: [PATCH v2] qga/vss-win32: remove orphaned VSS provider service
Date: Thu, 17 Sep 2026 18:49:00 +0300
Message-ID: <20260917154901.321702-1-aagbaria@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aagbaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

COMRegister() probes the COM+ catalog to decide whether to unregister
first, but it is the SCM that blocks installation when a service of the
same name is left over.  If the COM+ application is gone and the service
survives, install fails with 0x80070431 and never recovers.

 - Check the SCM as well as the COM+ catalog in COMRegister().
 - Delete the provider service in COMUnregister() and at the
   DllUnregisterServer() call sites in DllRegisterServer().

Opening the SCM, opening the provider service and closing both handles
is boilerplate that StopService() already contains, so move it into
QGAProviderOpenService(), which returns a single service handle and
reports the win32 error through an out parameter, and convert
StopService() to it.  The service handle stays valid after the SCM
handle is closed, so the helper closes it and each caller is left with
one handle to release.

While at it, fix two pre-existing problems in StopService():

 - It logged errmsg(E_FAIL, ...) and returned E_FAIL for every failure,
   discarding the GetLastError() value.  It now passes the win32 error
   code to errmsg() and returns HRESULT_FROM_WIN32().
 - It opened the SCM with SC_MANAGER_ALL_ACCESS, which implies
   SC_MANAGER_CREATE_SERVICE and is therefore refused to
   non-administrators, and passed that same SCM mask to OpenService()
   as a service access mask.  Each operation now requests only what it
   needs: SC_MANAGER_CONNECT on the SCM, and SERVICE_QUERY_CONFIG,
   DELETE or SERVICE_STOP on the service.

StopService()'s return value changes from E_FAIL to a specific
HRESULT_FROM_WIN32(); its only caller, in requester.cpp, ignores it.

Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
---
 qga/vss-win32/install.cpp | 122 ++++++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 17 deletions(-)

v1: https://lore.kernel.org/qemu-devel/20260915145320.215663-1-aagbaria@redhat.com/

v2:
 - Pass win32 error codes to errmsg() consistently instead of mixing
   error codes and HRESULTs (Marc-André)
 - Factor the SCM/OpenService boilerplate into QGAProviderOpenService()
   and convert the existing StopService() to it (Marc-André)
 - Restrict StopService() to the access rights it actually needs

Tested on a Windows guest by replacing the installed build with this
one and running a full install/uninstall cycle, including installation
over a leftover provider service.

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5b7a8e9bc5..cfafc2d95e 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -241,6 +241,96 @@ out:
     return hr;
 }
 
+/*
+ * Open the QGA VSS provider service with the requested access rights.
+ *
+ * On success, return a service handle which the caller must release with
+ * CloseServiceHandle().  On failure, return NULL and store the win32 error
+ * code in *err.  ERROR_SERVICE_DOES_NOT_EXIST just means the service is not
+ * installed, which is a normal condition for all callers, so it is not
+ * reported here; the caller decides what it means.
+ */
+static SC_HANDLE QGAProviderOpenService(DWORD access, DWORD *err)
+{
+    qga_debug_begin;
+
+    SC_HANDLE service = NULL;
+    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
+
+    *err = ERROR_SUCCESS;
+
+    if (!manager) {
+        *err = GetLastError();
+        errmsg(*err, "Failed to open service manager");
+        goto out;
+    }
+
+    service = OpenService(manager, QGA_PROVIDER_NAME, access);
+    if (!service) {
+        *err = GetLastError();
+        if (*err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            errmsg(*err, "Failed to open service");
+        }
+    }
+
+out:
+    if (manager) {
+        CloseServiceHandle(manager);
+    }
+    qga_debug_end;
+    return service;
+}
+
+/* Check whether the QGA VSS provider service is registered with the SCM */
+static bool QGAProviderServiceExists(void)
+{
+    qga_debug_begin;
+
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(SERVICE_QUERY_CONFIG, &err);
+
+    if (service) {
+        CloseServiceHandle(service);
+    }
+
+    qga_debug_end;
+    return service != NULL;
+}
+
+/* Delete a QGA VSS provider service that COM+ no longer owns */
+static HRESULT QGAProviderRemoveService(void)
+{
+    qga_debug_begin;
+
+    HRESULT hr = S_OK;
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(DELETE, &err);
+
+    if (!service) {
+        if (err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            hr = HRESULT_FROM_WIN32(err);
+        }
+        goto out;
+    }
+
+    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
+
+    if (!DeleteService(service)) {
+        err = GetLastError();
+        if (err != ERROR_SERVICE_MARKED_FOR_DELETE) {
+            hr = HRESULT_FROM_WIN32(err);
+            errmsg(err, "Failed to delete service");
+        }
+    }
+
+out:
+    if (service) {
+        CloseServiceHandle(service);
+    }
+    qga_debug_end;
+    return hr;
+}
+
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
@@ -251,6 +341,7 @@ STDAPI COMUnregister(void)
 
     DllUnregisterServer();
     chk(QGAProviderFind(QGAProviderRemove, NULL));
+    chk(QGAProviderRemoveService());
 out:
     qga_debug_end;
     return hr;
@@ -286,7 +377,7 @@ STDAPI COMRegister(void)
     }
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
-    if (count) {
+    if (count || QGAProviderServiceExists()) {
         qga_debug("QGA VSS Provider is already installed. Attempting to unregister first.");
         hr = COMUnregister();
         if (FAILED(hr)) {
@@ -499,6 +590,7 @@ STDAPI DllRegisterServer(void)
                                      g_gProviderVersion);
     if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
         hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
                                          const_cast<WCHAR * >
                                          (QGA_PROVIDER_LNAME),
@@ -515,6 +607,7 @@ STDAPI DllRegisterServer(void)
 out:
     if (FAILED(hr)) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
     }
 
     qga_debug_end;
@@ -575,29 +668,24 @@ STDAPI StopService(void)
     qga_debug_begin;
 
     HRESULT hr = S_OK;
-    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
-    SC_HANDLE service = NULL;
-
-    if (!manager) {
-        errmsg(E_FAIL, "Failed to open service manager");
-        hr = E_FAIL;
-        goto out;
-    }
-    service = OpenService(manager, QGA_PROVIDER_NAME, SC_MANAGER_ALL_ACCESS);
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(SERVICE_STOP, &err);
 
     if (!service) {
-        errmsg(E_FAIL, "Failed to open service");
-        hr =  E_FAIL;
+        hr = HRESULT_FROM_WIN32(err);
         goto out;
     }
-    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
-        errmsg(E_FAIL, "Failed to stop service");
-        hr = E_FAIL;
+
+    if (!ControlService(service, SERVICE_CONTROL_STOP, NULL)) {
+        err = GetLastError();
+        hr = HRESULT_FROM_WIN32(err);
+        errmsg(err, "Failed to stop service");
     }
 
 out:
-    CloseServiceHandle(service);
-    CloseServiceHandle(manager);
+    if (service) {
+        CloseServiceHandle(service);
+    }
     qga_debug_end;
     return hr;
 }
-- 
2.55.0


