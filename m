Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD7D132C8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xLF-000184-HN; Mon, 04 Nov 2024 08:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xLB-00016Z-1A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xL8-0002nK-Fj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCxCbwJhT84ro2F56D8d8/42Ll9ptQpTH8wGx4HWQFQ=;
 b=TB+wsJGeB+ga1fdVoDLBHTyQ/qEne+kb0QYIl/zpr7WUEEWI+0d7DDd0aLPmDWsyVcG6lV
 ajV96MklNLGsInX0MuHXJ6xNjOBqeEpPeq/XNYkZ3D8QUcpTPRRfJlRcfAvmi4TiSzD7/z
 kdvk+rsmonm4nW+FSDtZF4bycBMDyUs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-ABTYQ7DlNaqBLDdMOlJMCg-1; Mon,
 04 Nov 2024 08:41:50 -0500
X-MC-Unique: ABTYQ7DlNaqBLDdMOlJMCg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 908411956096; Mon,  4 Nov 2024 13:41:49 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEEE21956086; Mon,  4 Nov 2024 13:41:47 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/3] qga: fix missing static and prototypes windows warnings
Date: Mon,  4 Nov 2024 15:41:38 +0200
Message-ID: <20241104134139.225514-3-kkostiuk@redhat.com>
In-Reply-To: <20241104134139.225514-1-kkostiuk@redhat.com>
References: <20241104134139.225514-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reported by clang++, but not by g++.

../qga/vss-win32/provider.cpp:48:6: error: no previous prototype for function 'LockModule' [-Werror,-Wmissing-prototypes]
   48 | void LockModule(BOOL lock)
      |      ^
../qga/vss-win32/provider.cpp:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   48 | void LockModule(BOOL lock)
      | ^
      | static
../qga/vss-win32/provider.cpp:531:13: error: no previous prototype for function 'DllMain' [-Werror,-Wmissing-prototypes]
  531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
      |             ^
../qga/vss-win32/provider.cpp:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
      | ^
      | static

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20241031040426.772604-7-pierrick.bouvier@linaro.org
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp   | 6 +++++-
 qga/vss-win32/provider.cpp  | 5 ++++-
 qga/vss-win32/requester.cpp | 8 ++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 84944133f7..5cea5bcf74 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -39,7 +39,7 @@ const GUID CLSID_WbemLocator = { 0x4590f811, 0x1d3a, 0x11d0,
 const GUID IID_IWbemLocator = { 0xdc12a687, 0x737f, 0x11cf,
     {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24} };
 
-void errmsg(DWORD err, const char *text)
+static void errmsg(DWORD err, const char *text)
 {
     /*
      * `text' contains function call statement when errmsg is called via chk().
@@ -242,6 +242,7 @@ out:
 }
 
 /* Unregister this module from COM+ Applications Catalog */
+STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
 {
     qga_debug_begin;
@@ -256,6 +257,7 @@ out:
 }
 
 /* Register this module to COM+ Applications Catalog */
+STDAPI COMRegister(void);
 STDAPI COMRegister(void)
 {
     qga_debug_begin;
@@ -380,11 +382,13 @@ out:
     return hr;
 }
 
+STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
 {
     COMRegister();
 }
 
+STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
 {
     COMUnregister();
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index cc72e5ef1b..a102a23fbf 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -45,7 +45,7 @@ const IID IID_IVssEnumObject = { 0xAE1C7110, 0x2F60, 0x11d3,
     {0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3} };
 
 
-void LockModule(BOOL lock)
+static void LockModule(BOOL lock)
 {
     if (lock) {
         InterlockedIncrement(&g_nComObjsInUse);
@@ -527,6 +527,9 @@ STDAPI DllCanUnloadNow()
     return g_nComObjsInUse == 0 ? S_OK : S_FALSE;
 }
 
+EXTERN_C
+BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved);
+
 EXTERN_C
 BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
 {
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e70..4401d55e3a 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -254,8 +254,8 @@ out:
     qga_debug_end;
 }
 
-DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
-                          DWORD defaultData)
+static DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
+                                 DWORD defaultData)
 {
     qga_debug_begin;
 
@@ -272,12 +272,12 @@ DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
     return dwordData;
 }
 
-bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
+static bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
 {
     return (vssBT > VSS_BT_UNDEFINED && vssBT < VSS_BT_OTHER);
 }
 
-VSS_BACKUP_TYPE get_vss_backup_type(
+static VSS_BACKUP_TYPE get_vss_backup_type(
     VSS_BACKUP_TYPE defaultVssBT = DEFAULT_VSS_BACKUP_TYPE)
 {
     qga_debug_begin;
-- 
2.47.0


