Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93247CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoD-00012A-Jk; Wed, 22 Oct 2025 08:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoC-00011e-0F
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXo9-000737-Uy
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYk2A4wVmkBhIJRz+4s4bB8w/6H5fxKaUobwydL0CgU=;
 b=DHbVhc6R/vVZctxeliqsw+hcHdGxldO2D4gyyj1/WnjvL0DlYlc+VFM0f6MwyIL8pSxltT
 0X9s1OWyKhanYmLpu45RoRUx/wNTo/eAisWs28598NuKIHmcFKwVOESqhcUak5/yeAXy0I
 tFKYQzti0p4thF7cPX68iFrmqObUc90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-xsQ_4BYwN_ypD3DGopRlUQ-1; Wed,
 22 Oct 2025 08:19:09 -0400
X-MC-Unique: xsQ_4BYwN_ypD3DGopRlUQ-1
X-Mimecast-MFC-AGG-ID: xsQ_4BYwN_ypD3DGopRlUQ_1761135549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041F41800637; Wed, 22 Oct 2025 12:19:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 417C11800451; Wed, 22 Oct 2025 12:19:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/12] vfio/iommufd: Support unmap all in one ioctl()
Date: Wed, 22 Oct 2025 14:18:41 +0200
Message-ID: <20251022121846.874152-8-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

IOMMUFD kernel uAPI supports unmapping whole address space in one call with
[iova, size] set to [0, UINT64_MAX], this can simplify iommufd_cdev_unmap()
a bit. See iommufd_ioas_unmap() in kernel for details.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251009040134.334251-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 24a99efa87f4df268d0df7198f26bba37976874b..fc9cd9d22ff2d6f126d3c0964d7033eee33ed9f2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -62,21 +62,8 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
-    /* unmap in halves */
     if (unmap_all) {
-        Int128 llsize = int128_rshift(int128_2_64(), 1);
-        int ret;
-
-        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                        0, int128_get64(llsize));
-
-        if (ret == 0) {
-            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                            int128_get64(llsize),
-                                            int128_get64(llsize));
-        }
-
-        return ret;
+        size = UINT64_MAX;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-- 
2.51.0


