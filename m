Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148FBC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvev-0001mp-Ps; Mon, 20 Jan 2025 12:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tZveu-0001mM-S5
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tZves-0007u0-UQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737394431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LI69RojN9MS6X67G+6PFICT4TXr7Kpr6ojIMw/CF1Rs=;
 b=SS56Ut3PWIjZY06cfnHbi+HvVb2U8R5AAP71dwwX5CZwS5LG5XF8OgyRlRFec2PknT6CSI
 eMeBI80ZFyamEOVFLMdLTUP1rZ/61Q5Zf1GvTwJITct3WXKipWV8OYnfW83/1BUa37JgYR
 YLWP4olAdx48+Vud0JzHf3uOX2T7UH4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-7HuKB7TTNH2uPS1_un0EcQ-1; Mon,
 20 Jan 2025 12:33:47 -0500
X-MC-Unique: 7HuKB7TTNH2uPS1_un0EcQ-1
X-Mimecast-MFC-AGG-ID: 7HuKB7TTNH2uPS1_un0EcQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2C4219560AA; Mon, 20 Jan 2025 17:33:45 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDDD019560A3; Mon, 20 Jan 2025 17:33:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, sgarzare@redhat.com,
 lvivier@redhat.com
Cc: zhenzhong.duan@intel.com
Subject: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Date: Mon, 20 Jan 2025 18:33:39 +0100
Message-ID: <20250120173339.865681-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When a guest exposed with a vhost device and protected by an
intel IOMMU gets rebooted, we sometimes observe a spurious warning:

Fail to lookup the translated address ffffe000

We observe that the IOMMU gets disabled through a write to the global
command register (CMAR_GCMD.TE) before the vhost device gets stopped.
When this warning happens it can be observed an inflight IOTLB
miss occurs after the IOMMU disable and before the vhost stop. In
that case a flat translation occurs and the check in
vhost_memory_region_lookup() fails.

Let's disable the IOTLB callbacks when all IOMMU MRs have been
unregistered.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..128c2ab094 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *listener,
             break;
         }
     }
+    if (QLIST_EMPTY(&dev->iommu_list) &&
+        dev->vhost_ops->vhost_set_iotlb_callback) {
+        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
+    }
 }
 
 void vhost_toggle_device_iotlb(VirtIODevice *vdev)
-- 
2.47.1


