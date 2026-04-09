Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F80EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAnnA-0004BW-W0; Thu, 09 Apr 2026 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAnn9-0004BO-EX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAnn7-00056X-Ee
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775735000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aEZhY1E5eo7lYxSjD0EwAhHg/UAubLjLjd8ZdBwDe8w=;
 b=b13T5D8FLuN8GZbxbSeq2JcT+e8KEklCrumrCubHjvLir3u6UHbjcKnlwmIV2OmyKFaG1n
 ZXBzS8c6DYvcEJxSsZ+yl26Z6wZj7BkO/yFGbz2qC6AOZKOw3wtJXFAHYgPwSWlP8GCQ6C
 FzrgzDgfaaXyB2fwCK27pZ3fwCUJrqg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-dccb79HSMQyTRS7AZAwb4A-1; Thu,
 09 Apr 2026 07:43:18 -0400
X-MC-Unique: dccb79HSMQyTRS7AZAwb4A-1
X-Mimecast-MFC-AGG-ID: dccb79HSMQyTRS7AZAwb4A_1775734997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3996119560A3; Thu,  9 Apr 2026 11:43:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F81E180036E; Thu,  9 Apr 2026 11:43:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: Add VFIO I/O backend capability flags for feature
 support
Date: Thu,  9 Apr 2026 13:43:12 +0200
Message-ID: <20260409114312.1704062-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Different VFIO I/O backends support different features. For example,
the kernel VFIO backend supports DMA-BUF creation, while vfio-user
does not. Currently, this is handled by attempting the operation and
checking for -ENOTTY, which can lead to misleading warnings when a
feature is simply not supported by a particular backend.

Introduce a capability flags mechanism in VFIODeviceIOOps that allows
backends to explicitly advertise which features they support. Callers
can check these capabilities before attempting operations, avoiding
spurious errors and warnings.

Cc: John Levon <john.levon@nutanix.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 13 +++++++++++++
 hw/vfio/device.c              |  2 ++
 hw/vfio/region.c              |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index a95c5bf50302a7394582dcc493d96aef00b47dc8..380a55d6e5ea280c8f44016c7a8a1dcb8f4c00fe 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -172,12 +172,25 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+/*
+ * VFIO backend I/O operation capabilities
+ */
+#define VFIO_IO_CAP_DMA_BUF        (1ULL << 0)
+
 /*
  * How devices communicate with the server.  The default option is through
  * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
  * process.
  */
 struct VFIODeviceIOOps {
+    /**
+     * @capabilities
+     *
+     * Bitmask of VFIO_IO_CAP_* flags indicating which features this
+     * backend supports.
+     */
+    uint64_t capabilities;
+
     /**
      * @device_feature
      *
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 8f7ae919a55dd9e08bdd072eee33f5b46a91aa2a..3ffd69a579b8ac135ef729d3d836c8545e36786b 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -648,6 +648,8 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
 }
 
 static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
+    .capabilities = VFIO_IO_CAP_DMA_BUF,
+
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
     .get_irq_info = vfio_device_io_get_irq_info,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 47fdc2df349b65c6be6c9605b7a38a4e367f0475..0342ca712acd0ad846685115c29432c15aa966a0 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -293,6 +293,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
     size_t total_size;
     int i, ret;
 
+    /* Check if backend supports DMA-BUF creation */
+    if (!(vbasedev->io_ops->capabilities & VFIO_IO_CAP_DMA_BUF)) {
+        return true;
+    }
+
     total_size = sizeof(*feature) + sizeof(*dma_buf) +
                  sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
     feature = g_malloc0(total_size);
-- 
2.53.0


