Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8241FC30658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCo-0004x4-80; Mon, 24 Jun 2024 17:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCl-0004kP-2j
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCi-0006oL-NO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peyi9jmOQ5WCVgGh7unf4Rw+BExKlAyAzh7RvG3O52c=;
 b=BOhehY3kMqib6wDuV2wR1SGeXRuiqJoMFuxOcv/rmjyW5Y38NucuaGn2uTfuH3UHLFFfrt
 J0JiQGbbSBWMJWFcD5SVzh5qvqQ+E61xoqLy9SRMkVkfac15FB7h6OLGOH9CMq3Cz9DEU2
 n58KzGwgPZ8wZ2W/mWr0nwJDlckzzCw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-SOzH6yx4MqCw6Sss8I25Lg-1; Mon,
 24 Jun 2024 17:26:22 -0400
X-MC-Unique: SOzH6yx4MqCw6Sss8I25Lg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9349019560B3; Mon, 24 Jun 2024 21:26:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1EB41956053; Mon, 24 Jun 2024 21:26:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 32/42] vfio/container: Modify vfio_get_iommu_type() to use a
 container fd
Date: Mon, 24 Jun 2024 23:24:46 +0200
Message-ID: <20240624212456.350919-33-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

The 'container' pointer has no other use than its 'fd' attribute.
Simplify the prototype to ease future changes.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index dc85a79cb9e62b72312f79da994c53608b6cef48..589f37bc6d68dae18f9e46371f14d6952b2240c0 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -354,7 +354,7 @@ static void vfio_kvm_device_del_group(VFIOGroup *group)
 /*
  * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
  */
-static int vfio_get_iommu_type(VFIOContainer *container,
+static int vfio_get_iommu_type(int container_fd,
                                Error **errp)
 {
     int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
@@ -362,7 +362,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
-        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
+        if (ioctl(container_fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
             return iommu_types[i];
         }
     }
@@ -399,7 +399,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
     int iommu_type;
     const VFIOIOMMUClass *vioc;
 
-    iommu_type = vfio_get_iommu_type(container, errp);
+    iommu_type = vfio_get_iommu_type(container->fd, errp);
     if (iommu_type < 0) {
         return false;
     }
-- 
2.45.2


