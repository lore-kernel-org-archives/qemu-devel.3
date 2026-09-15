Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196DDC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RHK-0008Rd-3k; Tue, 15 Sep 2026 07:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHI-0008Nf-4u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RHG-0001qf-6R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqIBFZngfcTGR4vOmOjvGoM6AErrj1Ho2k4OMoq6+4w=;
 b=JSFLaVz8xnmpl9b8cWBESUKCYePm17sofGlGKIx+UPxdB6GHL4l/IcQvmAtD7xZ8o1MFKD
 yqMMvuUdlrwBiL0Q+pxIyCOy+lemfgunzVeoXcFBeN5/hMbDKcn9EbEcGt2qyMXu7MrdNi
 JHFbOmLsAb4v0Os0UANCjR8pXrPFLAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-4h8SQIqJO5i8SJofXyN9BA-1; Tue,
 15 Sep 2026 07:24:39 -0400
X-MC-Unique: 4h8SQIqJO5i8SJofXyN9BA-1
X-Mimecast-MFC-AGG-ID: 4h8SQIqJO5i8SJofXyN9BA_1789471478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 774B01869D9C; Tue, 15 Sep 2026 11:24:38 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E66D8195604C; Tue, 15 Sep 2026 11:24:36 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 18/19] qga/vss-win32: restrict access to freeze/thaw
 synchronisation events
Date: Tue, 15 Sep 2026 14:23:36 +0300
Message-ID: <20260915112337.43307-19-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The freeze, thaw and timeout events were created with a NULL DACL,
granting unrestricted access. Any local process could open and signal
them, allowing an unprivileged guest process to trigger a filesystem
freeze or premature thaw.

Replace the NULL DACL with an explicit ACL that grants EVENT_ALL_ACCESS
only to SYSTEM and the built-in Administrators group, which are the
accounts under which the VSS service and qemu-ga operate.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260907-qga-v1-16-86456ad356e2@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 52 ++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index d36a90c17d..1b0155c691 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -17,6 +17,7 @@
 #include "install.h"
 #include <vswriter.h>
 #include <vsbackup.h>
+#include <aclapi.h>
 
 /* Max wait time for frozen event (VSS can only hold writes for 10 seconds) */
 #define VSS_TIMEOUT_FREEZE_MSEC 60000
@@ -298,10 +299,14 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     HRESULT hr;
     LONG ctx;
     GUID guidSnapshotSet = GUID_NULL;
+    SID_IDENTIFIER_AUTHORITY sia_nt = SECURITY_NT_AUTHORITY;
+    PSID pSidSystem = NULL, pSidAdmins = NULL;
     SECURITY_DESCRIPTOR sd;
     SECURITY_ATTRIBUTES sa;
+    EXPLICIT_ACCESS ea[2];
+    PACL pAcl = NULL;
     WCHAR short_volume_name[64], *display_name = short_volume_name;
-    DWORD wait_status;
+    DWORD wait_status, aclResult;
     int num_fixed_drives = 0, i;
     int num_mount_points = 0;
     VSS_BACKUP_TYPE vss_bt = get_vss_backup_type();
@@ -313,9 +318,48 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         return;
     }
 
-    /* Allow unrestricted access to events */
+    /* Grant access to SYSTEM and Administrators only */
+    if (!AllocateAndInitializeSid(&sia_nt, 1,
+            SECURITY_LOCAL_SYSTEM_RID, 0, 0, 0, 0, 0, 0, 0,
+            &pSidSystem)) {
+        err_set(errset, GetLastError(), "failed to create SYSTEM SID");
+        goto out;
+    }
+    if (!AllocateAndInitializeSid(&sia_nt, 2,
+            SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,
+            0, 0, 0, 0, 0, 0, &pSidAdmins)) {
+        DWORD err = GetLastError();
+        FreeSid(pSidSystem);
+        err_set(errset, err, "failed to create Administrators SID");
+        goto out;
+    }
+
+    ZeroMemory(&ea, sizeof(ea));
+    ea[0].grfAccessPermissions = EVENT_ALL_ACCESS;
+    ea[0].grfAccessMode = SET_ACCESS;
+    ea[0].grfInheritance = NO_INHERITANCE;
+    ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    ea[0].Trustee.TrusteeType = TRUSTEE_IS_WELL_KNOWN_GROUP;
+    ea[0].Trustee.ptstrName = (LPTSTR)pSidSystem;
+    ea[1].grfAccessPermissions = EVENT_ALL_ACCESS;
+    ea[1].grfAccessMode = SET_ACCESS;
+    ea[1].grfInheritance = NO_INHERITANCE;
+    ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    ea[1].Trustee.TrusteeType = TRUSTEE_IS_WELL_KNOWN_GROUP;
+    ea[1].Trustee.ptstrName = (LPTSTR)pSidAdmins;
+
+    aclResult = SetEntriesInAcl(2, ea, NULL, &pAcl);
+    if (aclResult != ERROR_SUCCESS) {
+        FreeSid(pSidSystem);
+        FreeSid(pSidAdmins);
+        err_set(errset, aclResult, "failed to create ACL for events");
+        goto out;
+    }
+    FreeSid(pSidSystem);
+    FreeSid(pSidAdmins);
+
     InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
-    SetSecurityDescriptorDacl(&sd, TRUE, NULL, FALSE);
+    SetSecurityDescriptorDacl(&sd, TRUE, pAcl, FALSE);
     sa.nLength = sizeof(sa);
     sa.lpSecurityDescriptor = &sd;
     sa.bInheritHandle = FALSE;
@@ -551,6 +595,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     }
 
     qga_debug("end successful");
+    LocalFree(pAcl);
     return;
 
 out:
@@ -559,6 +604,7 @@ out:
     }
 
 out1:
+    LocalFree(pAcl);
     requester_cleanup();
 
     qga_debug_end;
-- 
2.55.0


