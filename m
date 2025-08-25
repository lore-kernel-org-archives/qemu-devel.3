Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD2ACA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYZH-0005Q4-D3; Mon, 25 Aug 2025 10:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYZ8-0005Np-Co
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYZ4-0003xl-SX
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756133573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3pRkdBvcNC3zsWAwF6HB0ZRCt9rNQ8ajBAcV51cFP0=;
 b=OqfoiuwRcQaOTou4BKiNh31C8aoh0xbOEkqC6tRDiBQi5k9oGqMhoQWH9wDPi4pO6bbYfB
 oHRiEIAt8luUxbp7vcZpIu2UJtWH80UxcFcNuC4jhbG5F/NUVJtCLzPb6UMS/sJ8qQjpTN
 pD5PK9gNPvW9dcImKwjD3U6pFINLQWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-qO2UC3OnMMiRawI-Gmlsvw-1; Mon,
 25 Aug 2025 10:52:49 -0400
X-MC-Unique: qO2UC3OnMMiRawI-Gmlsvw-1
X-Mimecast-MFC-AGG-ID: qO2UC3OnMMiRawI-Gmlsvw_1756133569
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC9BE19541AA; Mon, 25 Aug 2025 14:52:48 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49A5019560AB; Mon, 25 Aug 2025 14:52:46 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 1/2] qga-vss: Replace asserts with condition and report error
Date: Mon, 25 Aug 2025 17:52:40 +0300
Message-ID: <20250825145241.170717-2-kkostiuk@redhat.com>
In-Reply-To: <20250825145241.170717-1-kkostiuk@redhat.com>
References: <20250825145241.170717-1-kkostiuk@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 4401d55e3a..bc260abb96 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -347,7 +347,12 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         goto out;
     }
 
-    assert(pCreateVssBackupComponents != NULL);
+    if (!pCreateVssBackupComponents) {
+        err_set(errset, (HRESULT)ERROR_PROC_NOT_FOUND,
+                "CreateVssBackupComponents proc address absent. Did you call requester_init()?");
+        goto out;
+    }
+
     hr = pCreateVssBackupComponents(&vss_ctx.pVssbc);
     if (FAILED(hr)) {
         err_set(errset, hr, "failed to create VSS backup components");
@@ -579,8 +584,16 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
     /* Tell the provider that the snapshot is finished. */
     SetEvent(vss_ctx.hEventThaw);
 
-    assert(vss_ctx.pVssbc);
-    assert(vss_ctx.pAsyncSnapshot);
+    if (!vss_ctx.pVssbc) {
+        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
+                "CreateVssBackupComponents is missing. Did you freeze the volumes?");
+        return;
+    }
+    if (!vss_ctx.pAsyncSnapshot) {
+        err_set(errset, (HRESULT)VSS_E_BAD_STATE,
+                "AsyncSnapshot set is missing. Did you freeze the volumes?");
+        return;
+    }
 
     HRESULT hr = WaitForAsync(vss_ctx.pAsyncSnapshot);
     switch (hr) {
-- 
2.50.1


