Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E527ECAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216j-0008Po-16; Fri, 26 Sep 2025 01:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216c-0008Md-Hw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216Q-0000q6-Vb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGNYZrfWhSesxz0a2yRX7ofpdrxFXUQ/L0oIa38+Lms=;
 b=jIjIJS2sUkxR4KOwBgMSTXnj2T500jdNFrSSUmK8h9GzLcCqpLj4soOZAybb68QuCHLegL
 mlQiB4g8S4wsTPMBg8dIT11mNhq8Nu0sIPYN7eGODEZBO2Il0t7iTMLVzxShtvXFOfSWZ5
 Mx3QjBQ68DIZYz837TmuIc02pPqCAdY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-XtQwKdrCMgaORm8EzdhAKw-1; Fri,
 26 Sep 2025 01:34:33 -0400
X-MC-Unique: XtQwKdrCMgaORm8EzdhAKw-1
X-Mimecast-MFC-AGG-ID: XtQwKdrCMgaORm8EzdhAKw_1758864872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE2A19560B2; Fri, 26 Sep 2025 05:34:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FE4D1800452; Fri, 26 Sep 2025 05:34:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/29] vfio/spapr.c: use QOM casts where appropriate
Date: Fri, 26 Sep 2025 07:33:40 +0200
Message-ID: <20250926053358.308198-12-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use QOM casts to convert between VFIOSpaprContainer and VFIOLegacyContainer
instead of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-11-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index acaa9c141916f127a87440d239facf285f9e34e0..c883ba6da9e984f392a8d75adfb0fb8c74027d08 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -245,8 +245,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
 {
     int ret = 0;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(bcontainer);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
@@ -353,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
                                         Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -443,8 +441,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -464,8 +461,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
 static void vfio_spapr_container_release(VFIOContainer *bcontainer)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
@@ -482,8 +478,7 @@ static bool vfio_spapr_container_setup(VFIOContainer *bcontainer,
                                        Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
-- 
2.51.0


