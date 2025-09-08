Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F96CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf95-0007FU-Mu; Mon, 08 Sep 2025 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8s-00077v-9B
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8i-0001d2-NF
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBAHUg/1deAc9H+jWQlEafaj8TcIBlfqvPlCYJuG8ok=;
 b=Fotjs8g8H6SLZWRg+7nnJGQVXrOHMqTkipcSs+cItfe4QUfRqVtgvizEDPhAkaLsIezuG+
 ioz8jun/WuQgI6Y0EIHvYbaHkQM2tVjjg8NQFTiRT4jIa8Ve4uxTZsl2iVVdCMBZ41Ul6w
 7XkX9B/DnSPiEHr940nIv/cPeUyoFKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-In6bElq2MiSwkOBc4ah4zA-1; Mon,
 08 Sep 2025 12:54:42 -0400
X-MC-Unique: In6bElq2MiSwkOBc4ah4zA-1
X-Mimecast-MFC-AGG-ID: In6bElq2MiSwkOBc4ah4zA_1757350482
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F091A1800366; Mon,  8 Sep 2025 16:54:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B905300018D; Mon,  8 Sep 2025 16:54:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 16/31] vfio/spapr.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:39 +0200
Message-ID: <20250908165354.1731444-17-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-7-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 564b70ef97fb8465af6160ec08fdd203d35cb7ab..c41e4588d6f2f0532f80720c1a32079d1ccfdef4 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -62,7 +62,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
     VFIOContainer *container = &scontainer->container;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -244,7 +244,7 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
                                     hwaddr *pgsize, Error **errp)
 {
     int ret = 0;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -352,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
@@ -443,8 +442,7 @@ static void
 vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
 
@@ -465,8 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
 static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin, *next;
@@ -484,8 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                                        Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
-- 
2.51.0


