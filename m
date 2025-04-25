Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1EDC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ElV-0000t1-Qy; Fri, 25 Apr 2025 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkD-0006cG-JV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkB-0003M2-T0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+Pk0pEVpcphFt3MWViW47vqavSRO+1rXqbAxFBRldQ=;
 b=ND6fb0ZQmKutT0yaNb4q9UjMK4V4LK1rdFydfwo5HzaNiFEcBHqENM6lDvF55zgm71Abm0
 Otta8dJHuzAiT2LPvgGAywscAfxGA8WgbpLafDelWDd6/35kZ9t1sFAUl9lzoRMYOCPGJw
 3SeK4NgIxIYR8lrXBAqjNRXGantl6t8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-lkaO_CEiO_K_7cd0h-amBA-1; Fri,
 25 Apr 2025 04:49:09 -0400
X-MC-Unique: lkaO_CEiO_K_7cd0h-amBA-1
X-Mimecast-MFC-AGG-ID: lkaO_CEiO_K_7cd0h-amBA_1745570948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABAD519560A7; Fri, 25 Apr 2025 08:49:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81A330001A2; Fri, 25 Apr 2025 08:49:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 43/50] vfio/iommufd: Make a separate call to get IOMMU
 capabilities
Date: Fri, 25 Apr 2025 10:46:36 +0200
Message-ID: <20250425084644.102196-44-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Currently we depend on .realize() calling iommufd_backend_get_device_info()
to get IOMMU capabilities and check for dirty page tracking support.

By make a extra separate call, this dependency is removed. This happens
only during device attach, it's not a hot path.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250423072824.3647952-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48db10542269111804643713270199657145accc..2253778b3ae0738f0a48dca77f0b68180b7d1f71 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -287,7 +287,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
-    uint32_t flags = 0;
+    uint32_t type, flags = 0;
+    uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
     int ret;
@@ -324,7 +325,12 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * vfio_migration_realize() may decide to use VF dirty tracking
      * instead.
      */
-    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
+                                         &type, NULL, 0, &hw_caps, errp)) {
+        return false;
+    }
+
+    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
-- 
2.49.0


