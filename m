Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F14BC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJT-0004jl-VV; Thu, 26 Jun 2025 03:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJI-0004Yy-1S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJF-0001xz-UW
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zo5xwy24PzhkdmLZji8s8LCN5YV4P1Qb4+NP0OylSMY=;
 b=fmdOMRmvqtVOsuEy9wRYPG8061GjrsXA3ub/OGFJnpR1h6ADP7KRxq7K+/JGww3KiMYhLu
 X7e5QL3C7YZ9XBCXnX+MLLmHBFpu0e7xoKnTRxzS21U4eJFXeXGt4/KtVJlu/KOkk1xbDT
 Co5TnMflZ7+oUnWxWYUuFsj/SjusAEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-ObDLe1bVOSCYo0yf-XNJ4g-1; Thu,
 26 Jun 2025 03:46:09 -0400
X-MC-Unique: ObDLe1bVOSCYo0yf-XNJ4g-1
X-Mimecast-MFC-AGG-ID: ObDLe1bVOSCYo0yf-XNJ4g_1750923968
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59F1E1808993; Thu, 26 Jun 2025 07:46:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE3BB180045B; Thu, 26 Jun 2025 07:46:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/25] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Thu, 26 Jun 2025 09:45:16 +0200
Message-ID: <20250626074529.1384114-13-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Levon <john.levon@nutanix.com>

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-7-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 74 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 ++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 103 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index ef3f71ee697da301baf6d556796850524ac4ef34..619c0f3140650599f930eddeb6d8a4a9ebf10b97 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,4 +17,6 @@
 bool vfio_user_get_device_info(VFIOUserProxy *proxy,
                                struct vfio_device_info *info, Error **errp);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index e0bba68739d05ee21282108946620e75dd11163d..db88f5fcb17647613151684894f72b2cc77a3c44 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -124,4 +124,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 837b02a8c486e9bf71d63b442a362a9a9610ff18..ba1c33aba8d08083c9afd2f203ed0a04a56cf70f 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 4212fefd44d7f8a5c1b9156765619047e54d7b1b..d90232a08f4b0d8320028796935b8c59506da69d 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -53,3 +53,77 @@ bool vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return true;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    Error *local_err = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, fds, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 61f525cf4a77f0dd0204d1cf28d213ef13824164..d704e3d390c71444c9d913e38c4dc064ff1c6625 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -12,6 +12,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -103,11 +104,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index b7312d6d5928dc7d1d984fdb501b7146e2011a79..ef3f14c74dd5a6a3c0870795e9ab9291d26dc925 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.49.0


