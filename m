Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A4FD6DDEC
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 08:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBrnF-0002hs-3Q; Fri, 15 Nov 2024 03:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tBrn3-0002hE-Bj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:34:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tBrn2-0002Ms-0e
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731659690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QQWo/ovWUNf1DBc4aVbXvUIlv7YaVLAACo7w+whX02M=;
 b=ewctZo8eX45JHPwD+k6aANrHnNdOvYBwXQo5TRCeJpPr1D78jWYYUnjkCwxRl3TjFLDzBQ
 c+sU4saK5vDbCqAdEIyfNGNr/t2Ew26rgoTm1lGDxpa06E/9+g0ExpQfyujT1CQndDoy5t
 YYhRYMiyBw/2b3AwTPQKSFakquTWKpg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-3jB_NRTWNSe4Cp0qZsFnNw-1; Fri,
 15 Nov 2024 03:34:47 -0500
X-MC-Unique: 3jB_NRTWNSe4Cp0qZsFnNw-1
X-Mimecast-MFC-AGG-ID: 3jB_NRTWNSe4Cp0qZsFnNw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DDDB1955EEA; Fri, 15 Nov 2024 08:34:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.159])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B9D0195DF81; Fri, 15 Nov 2024 08:34:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2] vfio/container: Fix container object destruction
Date: Fri, 15 Nov 2024 09:34:40 +0100
Message-ID: <20241115083440.2236669-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When commit 96b7af4388b3 intoduced a .instance_finalize() handler,
it did not take into account that the container was not necessarily
inserted into the container list of the address space. Hence, if
the container object is destroyed, by calling object_unref() for
example, before vfio_address_space_insert() is called, QEMU may
crash when removing the container from the list as done in
vfio_container_instance_finalize(). This was seen with an SEV-SNP
guest for which discarding of RAM fails.

To resolve this issue, use the safe version of QLIST_REMOVE().

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>
Fixes: 96b7af4388b3 ("vfio/container: Move vfio_container_destroy() to an instance_finalize() handler")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v2:

 - use the safe version of QLIST_REMOVE() instead of calling
   vfio_address_space_insert() earlier.

 hw/vfio/container-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 809b15767425a48f2404b08fc409ee5684af2094..6f86c37d971ec38426dacd471bca837c0d0df806 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -103,7 +103,7 @@ static void vfio_container_instance_finalize(Object *obj)
     VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
     VFIOGuestIOMMU *giommu, *tmp;
 
-    QLIST_REMOVE(bcontainer, next);
+    QLIST_SAFE_REMOVE(bcontainer, next);
 
     QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
         memory_region_unregister_iommu_notifier(
-- 
2.47.0


