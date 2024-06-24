Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06238C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCp-00051p-5V; Mon, 24 Jun 2024 17:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCm-0004ma-W2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCl-0006qg-DH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYT4dOrN3Vp2k1iABVro0ON5vu1Q2muFTg3+MAFO9sg=;
 b=i4u+U/5q8qzLQPx3FNleWoIJs4PPnI9ntnCQH/DkNLJNkEnOWAnCwWvus2V4g9n9GEYlsM
 4m3uqZsF48s2JeRQQNgD2fYM7CxRf1cAjLOQbwau2U2JbmTCKy8AnR0FUTXnEiTU6Sbfk8
 vSkPC1zZ/6FWHbk7FOMXtkbhWRhuK8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-qAUihu_eMnigFkv8Wq56sA-1; Mon,
 24 Jun 2024 17:26:24 -0400
X-MC-Unique: qAUihu_eMnigFkv8Wq56sA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0262219560AB; Mon, 24 Jun 2024 21:26:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0D261956051; Mon, 24 Jun 2024 21:26:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 33/42] vfio/container: Introduce vfio_get_iommu_class_name()
Date: Mon, 24 Jun 2024 23:24:47 +0200
Message-ID: <20240624212456.350919-34-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rework vfio_get_iommu_class() to return a literal class name instead
of a class object. We will need this name to instantiate the object
later on. Since the default case asserts, remove the error report as
QEMU will simply abort before.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 589f37bc6d68dae18f9e46371f14d6952b2240c0..bb6abe60ee29d5b69b494523c9002f53e1b2a3c8 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -373,24 +373,20 @@ static int vfio_get_iommu_type(int container_fd,
 /*
  * vfio_get_iommu_ops - get a VFIOIOMMUClass associated with a type
  */
-static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
+static const char *vfio_get_iommu_class_name(int iommu_type)
 {
-    ObjectClass *klass = NULL;
-
     switch (iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
-        klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
+        return TYPE_VFIO_IOMMU_LEGACY;
         break;
     case VFIO_SPAPR_TCE_v2_IOMMU:
     case VFIO_SPAPR_TCE_IOMMU:
-        klass = object_class_by_name(TYPE_VFIO_IOMMU_SPAPR);
+        return TYPE_VFIO_IOMMU_SPAPR;
         break;
     default:
         g_assert_not_reached();
     };
-
-    return VFIO_IOMMU_CLASS(klass);
 }
 
 static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
@@ -398,6 +394,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
 {
     int iommu_type;
     const VFIOIOMMUClass *vioc;
+    const char *vioc_name;
 
     iommu_type = vfio_get_iommu_type(container->fd, errp);
     if (iommu_type < 0) {
@@ -426,11 +423,8 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
 
     container->iommu_type = iommu_type;
 
-    vioc = vfio_get_iommu_class(iommu_type, errp);
-    if (!vioc) {
-        error_setg(errp, "No available IOMMU models");
-        return false;
-    }
+    vioc_name = vfio_get_iommu_class_name(iommu_type);
+    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
 
     vfio_container_init(&container->bcontainer, vioc);
     return true;
-- 
2.45.2


