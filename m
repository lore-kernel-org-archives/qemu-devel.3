Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6978C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJt1-0008Ci-LD; Mon, 27 Jul 2026 07:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsz-0007yr-Oa
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsy-0003nJ-7H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClKqZ8SQB9pmyx4+E3qqqZkmRVLZI5VxkGmfMXWPSu8=;
 b=J0jRtctCapbPYzqIe6PRP31P7F2uCGJ67PffU7UqDdjacjXFN+DKn4zk1uJGJPzUT2dQnh
 XiO8G0i33BIyw9hJC2PT4BYSuc65ucp2udPxmmME7HL7mSK9hHU9phr7cV0XfoCsZLGQSd
 v1rHdVvWscfPNXU1O7aoKhTIIc99JRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-uwMxzboZPVO2NzftGG5z5A-1; Mon,
 27 Jul 2026 07:52:41 -0400
X-MC-Unique: uwMxzboZPVO2NzftGG5z5A-1
X-Mimecast-MFC-AGG-ID: uwMxzboZPVO2NzftGG5z5A_1785153160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371E71800676; Mon, 27 Jul 2026 11:52:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A12118001DD; Mon, 27 Jul 2026 11:52:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:21 +0400
Subject: [GIT PULL 12/23] hw/display/virtio-gpu: Block Rutabaga migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-12-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8H7aHF564PPSdrDCHsEIUSfW9MwvqwYs25NvNKnd2fo=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/5GyRXJ0EfoXta5E19NRH8dAZZQpDVX8Hk
 Je2CwubU+KJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5afND/iBN7b9owmJspL8bDyBI4MrBQvW4Zn4KlTPKdpTIpGKG6oU+416kpLSSDgLRlkg3DIdQFJ
 KaW3vJNh4iEteqSragCowZUfji4n6LHDs16oXKK6Rnw2fN9pTMIn0k+mKwrlFAu8GvhdcFddzCx
 1isNu6lhcATAOfy/dAxR7GDEioK4lTT5NnBOjMkeLyGnc+NFsbDKrz+nfdHvG1MjOpBtzueqNQW
 gZZIb0OW1cNntbfoAR15N8nbj78LeRAKTLV/0a/X8xCoEf0onbWFpQblGOZ7xSDkDfYFsLPjA2Q
 KXUQhoyGCPHXz0XiI2kq0DE2V2TR10cg8hnboYLZbefWv74qNS4l2WVkB/AFcUnvvOROZR/MHti
 dAZyrFcYgQ4OYW7aR8/yusDEsDAKw+tzR9R2PPPPIDdRJs9cbcZZ3NZ4trMZoX4li/Do2faeWtp
 chfjPXimy9LLe1o0UCEmv7MetbzTHZFNv/e+xYfM8+fYemL/KsaLzcXgzCk2oPitSiy33V07M/F
 GGNN9wi7ot9YVuKo6wgDurrHSi39udjvSjYcoe+/MZh+4vA31ledpAaaq3yEhVVi32RADG4X7xt
 /R9prSRc/4T/EbNWH+7/h999KpNSh+8czIr9uKP1EPY8YvoYRjWgeU8n1EEhGtl4Ap9EJEyhgU1
 dEwPS4ZxeoY4g
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The migration stream encoding is not defined for Rutabaga yet.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-rutabaga-v1-1-4832b56e679d@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-rutabaga.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 6af5c2514d23..8e6c7a0d5ddc 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -9,6 +9,7 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "migration/blocker.h"
 
 #include <glib/gmem.h>
 #include <rutabaga_gfx/rutabaga_gfx_ffi.h>
@@ -1078,6 +1079,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 {
+    ERRP_GUARD();
     uint32_t num_capsets;
     VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
@@ -1087,12 +1089,17 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
     return;
 #endif
 
-    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+    error_setg(&bdev->migration_blocker, "rutabaga is not yet migratable");
+    if (migrate_add_blocker(&bdev->migration_blocker, errp) < 0) {
         return;
     }
 
+    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
+        goto fail;
+    }
+
     if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)) {
-        return;
+        goto fail;
     }
 
     bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
@@ -1101,6 +1108,12 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 
     bdev->virtio_config.num_capsets = num_capsets;
     virtio_gpu_device_realize(qdev, errp);
+    if (!*errp) {
+        return;
+    }
+
+fail:
+    migrate_del_blocker(&bdev->migration_blocker);
 }
 
 static const Property virtio_gpu_rutabaga_properties[] = {

-- 
2.55.0


