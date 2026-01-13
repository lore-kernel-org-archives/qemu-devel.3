Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA625D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqS-0000QV-GD; Tue, 13 Jan 2026 04:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqM-00006Q-9q
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqK-0003NE-IZ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijvRIbxbJxqy9YnkNJldAGrcnYh/shSF6YKQCTZZNhY=;
 b=C0//3nfiWOuz7jmMC+x5hWFBjg1t0oXnYPegoc/OtPa+PQFNaDELWm31QN0smFGYUSkS0E
 A5kCrrFg2L08rL82komQ2doPqvaJLPZJEfw+g+xEixcnvuNkkHLd/e22RGczsV3acOMqwr
 NJRBa7lqWqx5M6Yh0my/RKazqF2cpK0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-YKW7wA9-MLmBqvbVp8zSYQ-1; Tue,
 13 Jan 2026 04:37:36 -0500
X-MC-Unique: YKW7wA9-MLmBqvbVp8zSYQ-1
X-Mimecast-MFC-AGG-ID: YKW7wA9-MLmBqvbVp8zSYQ_1768297055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B6FA18005A7; Tue, 13 Jan 2026 09:37:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2DC630001A2; Tue, 13 Jan 2026 09:37:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/41] intel_iommu: Replay pasid bindings after context cache
 invalidation
Date: Tue, 13 Jan 2026 10:36:14 +0100
Message-ID: <20260113093637.1549214-19-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

This replays guest pasid bindings after context cache invalidation.
Actually, programmer should issue pasid cache invalidation with proper
granularity after issuing context cache invalidation.

We see old linux such as 6.7.0-rc2 not following the spec, it sends
pasid cache invalidation before context cache invalidation, then QEMU
depends on context cache invalidation to get pasid entry and setup
binding.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-17-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/trace-events  |  1 +
 2 files changed, 43 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3241af811c4313e22864a0c2fbb2d83b89208541..08236b85ee67bdb41fb6a9ccbd60ac164e825064 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -77,6 +77,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
+static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
+                                        gpointer user_data);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
 {
@@ -2322,6 +2324,37 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+    /*
+     * Same for pasid cache invalidation, per VT-d spec 6.5.2.1, a global
+     * context cache invalidation should be followed by global PASID cache
+     * invalidation. In order to work with guest not following spec,
+     * handle global PASID cache invalidation here.
+     */
+    vtd_replay_pasid_bindings_all(s);
+}
+
+static void vtd_pasid_cache_devsi(VTDAddressSpace *vtd_as)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    PCIBus *bus = vtd_as->bus;
+    uint8_t devfn = vtd_as->devfn;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+        .pasid = vtd_as->pasid,
+    };
+    VTDPASIDCacheInfo pc_info;
+
+    if (!s->fsts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    trace_vtd_pasid_cache_devsi(pci_bus_num(bus),
+                                VTD_PCI_SLOT(devfn), VTD_PCI_FUNC(devfn));
+
+    /* We fake to be global invalidation just to bypass all checks */
+    pc_info.type = VTD_INV_DESC_PASIDC_G_GLOBAL;
+    vtd_pasid_cache_sync_locked(&key, vtd_as, &pc_info);
 }
 
 /* Do a context-cache device-selective invalidation.
@@ -2382,6 +2415,15 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
              * happened.
              */
             vtd_address_space_sync(vtd_as);
+            /*
+             * Per spec 6.5.2.1, context flush should be followed by PASID
+             * cache and iotlb flush. In order to work with a guest which does
+             * not follow spec and missed PASID cache flush, e.g., linux
+             * 6.7.0-rc2, we have vtd_pasid_cache_devsi() to invalidate PASID
+             * cache of passthrough device. Host iommu driver would flush
+             * piotlb when a pasid unbind is passed down to it.
+             */
+            vtd_pasid_cache_devsi(vtd_as);
         }
     }
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5a3ee1cf6418ba0713a716266e662ced2e3027f0..5fa5e93b68dcdeed823f99f07fb5d55810d3e3a5 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
 vtd_inv_desc_pasid_cache_gsi(void) ""
 vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
+vtd_pasid_cache_devsi(uint8_t bus, uint8_t dev, uint8_t fn) "Dev selective PC invalidation dev: %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.52.0


