Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1B7D29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfar6-0003Md-5X; Tue, 13 Jan 2026 04:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqp-0002vN-7P
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqn-0003Sm-JP
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPjvIaCByeMYDaDwIf1njVRZ5RPCKF+r/m19wytI9As=;
 b=HiPbwMf6tSdNXmJWW2dbb1AngN7Zk1/roMsXD2gkY+90mnE33yfgZYhYl+hkPCM0Wl/BY1
 PELdmFcHkuU79Lxts7lSfMmTSkuD8ZPaHcTwC2eznU1V7zqYkQ6rR+oFKXuyfi4CHa5KUS
 ZVy4aAy37clVxtwEBAKMdQzeteWaEf8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-GH91WyNRP4Wy3S0to5W4MQ-1; Tue,
 13 Jan 2026 04:38:05 -0500
X-MC-Unique: GH91WyNRP4Wy3S0to5W4MQ-1
X-Mimecast-MFC-AGG-ID: GH91WyNRP4Wy3S0to5W4MQ_1768297084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F5EA19560A3; Tue, 13 Jan 2026 09:38:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75C7330001A8; Tue, 13 Jan 2026 09:38:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/41] vfio/listener: Add missing dirty tracking in region_del
Date: Tue, 13 Jan 2026 10:36:24 +0100
Message-ID: <20260113093637.1549214-29-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

If a VFIO device in guest switches from passthrough(PT) domain to block
domain, the whole memory address space is unmapped, but we passed a NULL
iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
dirty pages.

By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
set dirty bits correctly.

For IOMMU address space, we still send NULL iotlb because VFIO don't know
the actual mappings in guest. It's vIOMMU's responsibility to send actual
unmapping notifications, e.g., vtd_address_space_unmap_in_dirty_tracking().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-8-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 62699cb772d786c1510318dff73973ef4d297177..813621f22f8b5ec284388f9c5f719525ec5f282c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -713,14 +713,34 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     if (try_unmap) {
         bool unmap_all = false;
+        IOMMUTLBEntry entry = {}, *iotlb = NULL;
 
         if (int128_eq(llsize, int128_2_64())) {
             assert(!iova);
             unmap_all = true;
             llsize = int128_zero();
         }
+
+        /*
+         * Fake an IOTLB entry for identity mapping which is needed by dirty
+         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
+         * only translated_addr field is used to set dirty bitmap.
+         *
+         * Note: When switch into PT domain from DMA domain, the whole IOMMU
+         * MR is deleted without iotlb, before that happen, we depend on
+         * vIOMMU to send unmap notification with accurate iotlb entry to
+         * VFIO. See vtd_address_space_unmap_in_dirty_tracking() for example,
+         * it is triggered during switching to block domain because vtd does
+         * not support direct switching from DMA to PT domain.
+         */
+        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
+            entry.iova = iova;
+            entry.translated_addr = iova;
+            iotlb = &entry;
+        }
+
         ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
-                                       NULL, unmap_all);
+                                       iotlb, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.52.0


