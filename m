Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048CCAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8q-00073N-AK; Mon, 08 Sep 2025 12:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8h-0006hw-EU
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8e-0001cc-Tl
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HV3S2WsxXDMXfyZlW1cb2Az/K8L2YoJTRcc6ZcbtKQ=;
 b=VxNq73uDJhOJiHlqhZPNtcPgRpXCQ+m2Ap1ulJJiOxUAZ+ci09OipdC2N+SCLehpWC1AIu
 pwOhcwIhrTQzU9DbZwq/ivbOV5e8cE5pKsimYzWBtQDnE9E0JCYR34OEv55SsULUn9Xt6D
 13U/DmlOXhPD7Ww2DzBVYIcO+YCOjZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-B1jLQRY3Ot2J-BDaNPtFEQ-1; Mon,
 08 Sep 2025 12:54:39 -0400
X-MC-Unique: B1jLQRY3Ot2J-BDaNPtFEQ-1
X-Mimecast-MFC-AGG-ID: B1jLQRY3Ot2J-BDaNPtFEQ_1757350475
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11AFB18004D4; Mon,  8 Sep 2025 16:54:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF469300018D; Mon,  8 Sep 2025 16:54:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 13/31] hw/vfio/cpr-legacy.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:36 +0200
Message-ID: <20250908165354.1731444-14-clg@redhat.com>
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-4-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-legacy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 553b203e9b60b3a08159e2224a887b4d76162428..8f437194fae035b37de3f7c3f88e332c4ef88302 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -41,8 +41,8 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_VADDR,
@@ -65,7 +65,7 @@ static void vfio_region_remap(MemoryListener *listener,
 {
     VFIOContainer *container = container_of(listener, VFIOContainer,
                                             cpr.remap_listener);
-    vfio_container_region_add(&container->bcontainer, section, true);
+    vfio_container_region_add(VFIO_IOMMU(container), section, true);
 }
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
@@ -98,7 +98,7 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
@@ -135,7 +135,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 {
     VFIOContainer *container =
         container_of(notifier, VFIOContainer, cpr.transfer_notifier);
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
         return 0;
@@ -167,7 +167,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
 
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
 
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
@@ -191,7 +191,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
 void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
-- 
2.51.0


