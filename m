Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9839DC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwR-0008DL-39; Mon, 07 Sep 2026 06:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwP-00086H-G0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwN-000874-LE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+SRw7UcH1546WE65q0XEC2VXWIMBqYaxAJQkKqKw50=;
 b=E2YTxQP60hS4yYxZYOT6lq1O6DwpbWBRKveuSgASNMY37bdq8i6Tk6B0+FFQeBDSy204gm
 j1Lhrk9Q1ZlDyfHFLnaqAkJdt5tDFqwxrCY6/pJdHpFJRUrp/JpQsMk882ft8+8sTWUSFW
 j85kWMWmw59UJIVLksSZEx1l/ZHKLJc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-NSVi0bMSNTS52z-tGwJlKQ-1; Mon,
 07 Sep 2026 06:51:05 -0400
X-MC-Unique: NSVi0bMSNTS52z-tGwJlKQ-1
X-Mimecast-MFC-AGG-ID: NSVi0bMSNTS52z-tGwJlKQ_1788778264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C50501944B3D; Mon,  7 Sep 2026 10:51:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E42901955F0E; Mon,  7 Sep 2026 10:51:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:14 +0400
Subject: [PATCH 16/17] qga/vss-win32: restrict access to freeze/thaw
 synchronisation events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-16-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4106;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LRDuI5i1nUeueI+PO1nmHqnehsgVgtFuyXYJTZ0rMgc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjX/Xi0tKat+ZjPXuo+r1bcTKyY2nauWPiL
 /jpIw+RpP+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5X/YD/0V7+AtWgaQ1zJEXAHH7Xu0nAlPX3Qt6qosYnUvgTk8SKbieA+qn/Kf7gcxWFe0lMFyKT3
 u2CYgpzYJY32teFgtsGTxC69BOt1MIKujn8uMyh1k4tUuDPDyeetwb7wMKpR8uxezuWGl1u4k9b
 eIzs6L01I50bw8N3rv/PA0VI1YS+dCpbTl894qrsCZ1SdgQ0NCbXU9lhGChKsKx3jmS56SV6HdE
 Xw7PEE9bEYC2lHQSH4LPXbdMsgWZ8NkONuUnwQBM25iA8MEVeUHMMU6E6z2CEpRUHkN/i754Sw2
 ncTGjmo8THGd1+JUtICarUBaoV4E4CYfZ1pNyxh6ix1K3B7Z3TulONI1Nd8W3bB9nQapB1gHiNY
 d8jsBhwP6pwuX8VO4tTRJOXnzCm1NtUegqJtFUtBWedP/Gz/B+cIQLye5eAy4iDOvX9P6rMK+o8
 J6M1qWDTV/RZiqA2nD39MWsEEhj87DlTQ4c2uHJ/VhjFfvSeVEXTkHbWMOtM7h3dlYTiRdh30OX
 3acfMwXiOO8GvH7N/sc1QJa890FgApb5JssDgtgWTktZ/4+/KTxUouJ1I4CP4doZDbSysxhBm5h
 oO2VbkvMKBoZHLvdJREpkDj8brlWNhEdHXnW4u3856quuJJN3wS6466yhFFevw+bnkFXvBKJBC6
 lM+Kve8836621jA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The freeze, thaw and timeout events were created with a NULL DACL,
granting unrestricted access. Any local process could open and signal
them, allowing an unprivileged guest process to trigger a filesystem
freeze or premature thaw.

Replace the NULL DACL with an explicit ACL that grants EVENT_ALL_ACCESS
only to SYSTEM and the built-in Administrators group, which are the
accounts under which the VSS service and qemu-ga operate.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index d36a90c17d1d..1b0155c691ef 100644
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
2.55.0.543.g5ebe2ebe4ea8


