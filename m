Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6145F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE5E-00058q-Uo; Tue, 21 Apr 2026 12:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE4N-0004mJ-Aa
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE4B-0007Ra-KX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WyHtqI2Ue/MKNZUMYUPQJtTao0sjJcCWoBG4JpXT4Eo=;
 b=cr48ujhSyacv+ZcS8xOeirtD096/W2rfj6hio3VnyacH45u/80pl0agaSTm/WLY/+g7ZDb
 XZPzWMHyME3NHo/yycnTpoX2dx/FSCd3avZ6TqiSoT1uzMA384X0M71uTGjkfMMqDl24QZ
 dBDBZbxaoiqI/0go1HHc5a80L7hssjw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-cvLt6BlhMzydZj7DCD-t6w-1; Tue,
 21 Apr 2026 12:35:09 -0400
X-MC-Unique: cvLt6BlhMzydZj7DCD-t6w-1
X-Mimecast-MFC-AGG-ID: cvLt6BlhMzydZj7DCD-t6w_1776789308
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D81651956088; Tue, 21 Apr 2026 16:35:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67F731956095; Tue, 21 Apr 2026 16:35:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/14] vfio-user: support VFIO_USER_DEVICE_FEATURE
Date: Tue, 21 Apr 2026 18:34:36 +0200
Message-ID: <20260421163438.3447280-13-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Plumb through vfio_device_get_feature to the vfio-user server. Note that
we translate EINVAL into ENOTTY, as the existing generic vfio code is
expecting the latter to mean "unsupported".

As part of adding a trace point, clean up the trace file.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260410085716.877185-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++++++
 hw/vfio-user/device.c     | 42 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events | 23 +++++++++++----------
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 3249a4a6b62af95e3718ed5053bbf310cd08c024..2a0c31e7c57f8ed86681ebd96b20df3e32792dec 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -40,6 +40,7 @@ enum vfio_user_command {
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
     VFIO_USER_REGION_WRITE_MULTI        = 15,
+    VFIO_USER_DEVICE_FEATURE            = 16,
     VFIO_USER_MAX,
 };
 
@@ -239,4 +240,15 @@ typedef struct {
     VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
 } VFIOUserWRMulti;
 
+/*
+ * VFIO_USER_DEVICE_FEATURE
+ * imported from struct vfio_device_feature
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    char data[];
+} VFIOUserDeviceFeature;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 64ef35b3209429f7158d4ea79f095a5f16950d77..b8d2b7c1a84bb1914a71fdccbbdff675373cef3b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -74,6 +74,47 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
     }
 }
 
+static int
+vfio_user_device_io_device_feature(VFIODevice *vbasedev,
+                                   struct vfio_device_feature *feature)
+{
+    g_autofree VFIOUserDeviceFeature *msgp = NULL;
+    int size = sizeof(VFIOUserHdr) + feature->argsz;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    Error *local_err = NULL;
+
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
+
+    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        /*
+         * Client expects ENOTTY for "not supported", but the protocol may
+         * return EINVAL (which should only occur in the case the feature isn't
+         * actually supported on the server).
+         */
+        if (msgp->hdr.error_reply == EINVAL) {
+            return -ENOTTY;
+        }
+
+        return -msgp->hdr.error_reply;
+    }
+
+    memcpy(feature, &msgp->argsz, feature->argsz);
+
+    trace_vfio_user_device_io_device_feature(msgp->argsz, msgp->flags);
+
+    return 0;
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
@@ -432,6 +473,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index abb67f4c119af533a77ad04e383fa027e5aaa684..503e1c82d43a7d9361b1e5d487929ecc5a8a83da 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -2,19 +2,22 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-# common.c
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
+
+# device.c
+vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags) " argsz 0x%x flags 0x%x"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+
+# proxy.c
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
-vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
 vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
-
-# container.c
-vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.53.0


