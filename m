Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B153AEA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq68t-0007hE-Th; Wed, 11 Feb 2026 04:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq68j-0007gM-MQ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vq68i-0007un-7w
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770800643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwSqJgjakuFPFvoVBwlv+VF408VQU0e49C66m+uXNd0=;
 b=A1I22vFW8xYGruA6p4jmNChUj4JxmIEkpO/5ZPV0UGvk/4228uAXE9xi0jx3BOu5GfmtzJ
 D3kt237I8BUMrOVNvoQhnB8Sc3R/pYDx/PgzpSZzr1jQcRuNQs/h5RgUwtVnPBlq93VRUt
 un2Cwb5sw3M9WRxmt1b1PSgoAOi/FHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-S9aRfpOYMbKJHLYOiJ0WJw-1; Wed,
 11 Feb 2026 04:02:39 -0500
X-MC-Unique: S9aRfpOYMbKJHLYOiJ0WJw-1
X-Mimecast-MFC-AGG-ID: S9aRfpOYMbKJHLYOiJ0WJw_1770800558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42DDD1956096; Wed, 11 Feb 2026 09:02:38 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.47.238.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3C031956053; Wed, 11 Feb 2026 09:02:36 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: konstantin.kostiuk@gmail.com,
	Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH 2/2] qga: Fix VSS provider GetSnapshotProperties return value
Date: Wed, 11 Feb 2026 11:01:50 +0200
Message-ID: <20260211090151.747926-5-eashurov@redhat.com>
In-Reply-To: <20260211090151.747926-3-eashurov@redhat.com>
References: <20260211090151.747926-3-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GetSnapshotProperties() returned VSS_E_OBJECT_NOT_FOUND causing
"Snapshot id not found" errors during VSS operations.

Return S_OK instead to allow VSS operations to complete successfully.

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
---
 qga/vss-win32/provider.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index a102a23fbf..2b5c6f8e8e 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -263,7 +263,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)
 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
     VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
 {
-    return VSS_E_OBJECT_NOT_FOUND;
+    return S_OK;
 }
 
 STDMETHODIMP CQGAVssProvider::Query(
-- 
2.51.0


