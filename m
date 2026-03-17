Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C81CFED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y5F-0001yY-Vo; Tue, 17 Mar 2026 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y53-0001wd-03
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y51-0005KL-DN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773767982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsMnLGi/PISBgtSi+2udu6nlOMSdXWd4W1sADkglRYo=;
 b=QVnmkz2xJ0B13Z1cuXMb/EBYXzm6yd3RV+mYA/8NzQwi0eu21yATbQoP2jvIzgfFN+v0w/
 Px+74nrHHWnjlCz+bUDRSPr5M0SDDk2UvSgBhr1PZ7k4sX7r17Ei7iu6xtSXxtQqctc0Ly
 kmnouXjKbGd0qxM/ahfeDG7RkEy9AhY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-_bpdVQ03PSiFgY2hUR5mAA-1; Tue,
 17 Mar 2026 13:19:39 -0400
X-MC-Unique: _bpdVQ03PSiFgY2hUR5mAA-1
X-Mimecast-MFC-AGG-ID: _bpdVQ03PSiFgY2hUR5mAA_1773767977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E4FB19560B4; Tue, 17 Mar 2026 17:19:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8829180075B; Tue, 17 Mar 2026 17:19:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 02/16] rutabaga: improve error handling,
 fix potential crash during init
Date: Tue, 17 Mar 2026 21:19:02 +0400
Message-ID: <20260317171916.438575-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When virtio_gpu_rutabaga_get_num_capsets() returns 0, virtio_init()
isn't called and the device later crashes during realize.
==72545==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x556ad6f7ba9e bp 0x7ffe6958f810 sp 0x7ffe6958f7e0 T0)
==72545==The signal is caused by a READ memory access.
==72545==Hint: address points to the zero page.
#0 0x556ad6f7ba9e in virtio_memory_listener_commit ../hw/virtio/virtio.c:4034
#1 0x556ad6a24c96 in listener_add_address_space ../system/memory.c:3128
#2 0x556ad6a25d15 in memory_listener_register ../system/memory.c:3216
#3 0x556ad6f7bf11 in virtio_device_realize ../hw/virtio/virtio.c:4075

Rework error handling of the function to set Error appropriately. 0
capset may be ok now.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ed5ae52acbe..ebb6c783fb0 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1032,19 +1032,19 @@ static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
     return true;
 }
 
-static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
+static bool
+virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g, uint32_t *num_capsets, Error **errp)
 {
     int result;
-    uint32_t num_capsets;
     VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
 
-    result = rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
+    result = rutabaga_get_num_capsets(vr->rutabaga, num_capsets);
     if (result) {
-        error_report("Failed to get capsets");
-        return 0;
+        error_setg_errno(errp, -result, "Failed to get num_capsets");
+        return false;
     }
-    vr->num_capsets = num_capsets;
-    return num_capsets;
+    vr->num_capsets = *num_capsets;
+    return true;
 }
 
 static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
@@ -1070,7 +1070,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 {
-    int num_capsets;
+    uint32_t num_capsets;
     VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
 
@@ -1083,8 +1083,7 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    num_capsets = virtio_gpu_rutabaga_get_num_capsets(gpudev);
-    if (!num_capsets) {
+    if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)) {
         return;
     }
 
-- 
2.53.0


