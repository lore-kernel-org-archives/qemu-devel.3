Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B87C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mx-0005U4-Ew; Tue, 09 Jul 2024 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mq-00052u-Ib
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mn-0006Kb-Od
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFAEbYh2IP7uDwVAqftyEzcQGL/hKJ4hjaHbXjW+V1A=;
 b=KglW7YEXmzUiY2jZZSzimUr1BVCWNjpXB/cGywufOHX+2PRN8gsBEk3y0c5U+nb8Msk7uO
 lcURpe3iBjuER2Quc33/mhIFQplopXTYEYzWLDjhWEmROWM24vx4ul14Eq7h1kb/Fvb31b
 VYt+AD7cTKr7HI/mwg5xqoarJuAFAgQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416--MQ_ZrhAMV-TbegH6SlVxw-1; Tue,
 09 Jul 2024 07:50:38 -0400
X-MC-Unique: -MQ_ZrhAMV-TbegH6SlVxw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B44E1955F0D; Tue,  9 Jul 2024 11:50:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 355F63000181; Tue,  9 Jul 2024 11:50:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 7/9] virtio-iommu: Revert transient enablement of IOMMU MR in
 bypass mode
Date: Tue,  9 Jul 2024 13:50:15 +0200
Message-ID: <20240709115017.798043-8-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

In 94df5b2180d6 ("virtio-iommu: Fix 64kB host page size VFIO device
assignment"), in case of bypass mode, we transiently enabled the
IOMMU MR to allow the set_page_size_mask() to be called and pass
information about the page size mask constraint of cold plugged
VFIO devices. Now we do not use the IOMMU MR callback anymore, we
can just get rid of this hack.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 76f34ea6b32f06c73fda51b19db83122812b86dc..33ae61c4a6ae47d7799a32c9091af3afbc0704d6 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1430,18 +1430,6 @@ static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
     VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
     int granule;
 
-    if (likely(s->config.bypass)) {
-        /*
-         * Transient IOMMU MR enable to collect page_size_mask requirements
-         * through memory_region_iommu_set_page_size_mask() called by
-         * VFIO region_add() callback
-         */
-         s->config.bypass = false;
-         virtio_iommu_switch_address_space_all(s);
-         /* restore default */
-         s->config.bypass = true;
-         virtio_iommu_switch_address_space_all(s);
-    }
     s->granule_frozen = true;
     granule = ctz64(s->config.page_size_mask);
     trace_virtio_iommu_freeze_granule(BIT_ULL(granule));
-- 
2.45.2


