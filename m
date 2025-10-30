Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE9CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESSg-0002q3-8K; Thu, 30 Oct 2025 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSY-0002oa-Qj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSS-000427-DU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761829969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkoA3YsVieJ39X7yH0tf5BNJWyWdw4oJTh4BHGL0NJI=;
 b=hrSW1zq4c68MO+n1mmGCweMWd4HqOu3x807Js//vzNpoRq+Z7z+Tnxu0/a1H3CNEne5C0n
 fx2KS5kGP9i7HNCHA38icMaaAcfpcftRvdGZlR1DTMZtiFivCBq+dKgPPNPVs1Q4Qc07Kv
 EHTlfjcSkXSZkg8vuMg8EjQ7127h8GA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-k8Owl24oPiqoXgovV0y3fA-1; Thu,
 30 Oct 2025 09:12:47 -0400
X-MC-Unique: k8Owl24oPiqoXgovV0y3fA-1
X-Mimecast-MFC-AGG-ID: k8Owl24oPiqoXgovV0y3fA_1761829966
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 830A71954B17; Thu, 30 Oct 2025 13:12:46 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21BA219560A2; Thu, 30 Oct 2025 13:12:44 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/3] qga: Improve Windows filesystem space info retrieval logic
Date: Thu, 30 Oct 2025 15:12:36 +0200
Message-ID: <20251030131237.181588-3-kkostiuk@redhat.com>
In-Reply-To: <20251030131237.181588-1-kkostiuk@redhat.com>
References: <20251030131237.181588-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "minglei.liu" <minglei.liu@smartx.com>

Previously, disk space reporting only worked for volumes with drive letters,
skipping those without (e.g. System Reserved).

This change always calls GetDiskFreeSpaceEx with fs->name, which is a
volume GUID path. Windows APIs accept both drive letters (e.g. "C:\")
and volume GUIDs (e.g. "\\?\Volume{GUID}\") as valid lpDirectoryName
parameters, so space reporting is now consistent across all volumes.

Reference:
https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file

Signed-off-by: minglei.liu <minglei.liu@smartx.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250923113243.78244-1-minglei.liu@smartx.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 8227480810..acc2c11589 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1164,15 +1164,15 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
         fs->mountpoint = g_strdup("System Reserved");
     } else {
         fs->mountpoint = g_strndup(mnt_point, len);
-        if (GetDiskFreeSpaceEx(fs->mountpoint,
-                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
-                               (PULARGE_INTEGER) & i64TotalBytes,
-                               (PULARGE_INTEGER) & i64FreeBytes)) {
-            fs->used_bytes = i64TotalBytes - i64FreeBytes;
-            fs->total_bytes = i64TotalBytes;
-            fs->has_total_bytes = true;
-            fs->has_used_bytes = true;
-        }
+    }
+    if (GetDiskFreeSpaceEx(fs->name,
+                            (PULARGE_INTEGER) & i64FreeBytesToCaller,
+                            (PULARGE_INTEGER) & i64TotalBytes,
+                            (PULARGE_INTEGER) & i64FreeBytes)) {
+        fs->used_bytes = i64TotalBytes - i64FreeBytes;
+        fs->total_bytes = i64TotalBytes;
+        fs->has_total_bytes = true;
+        fs->has_used_bytes = true;
     }
     wcstombs(fs_name, wfs_name, sizeof(wfs_name));
     fs->type = g_strdup(fs_name);
-- 
2.51.1.dirty


