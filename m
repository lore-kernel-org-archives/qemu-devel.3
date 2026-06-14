Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7D8CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBd-0003gc-GL; Sun, 14 Jun 2026 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBX-0003Pn-Te
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBV-000239-OB
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OjcO48NagB8ylMATDfiV8LNmkAYdZ8jEtUGpdBfZuKw=;
 b=eMXcliXRhFr6SOIa9bHtKgkV79vC3zR/TQlk3zUIJrCTcJkokY70qQQZ/cO7nu3ModIstk
 zkFcpj+tAXDveXskCg4k0p5GOJQf4dKdYtTaIDRrLzIviamtuRcDXL+jIWm6luYMPbkYG4
 ftYXz/1+76MAFcAE6RCOvks0WX1pOk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-QwM8_GdPMmumkfqlx4TYcA-1; Sun, 14 Jun 2026 15:07:51 -0400
X-MC-Unique: QwM8_GdPMmumkfqlx4TYcA-1
X-Mimecast-MFC-AGG-ID: QwM8_GdPMmumkfqlx4TYcA_1781464070
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46016bedbaaso1799829f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464070; x=1782068870; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjcO48NagB8ylMATDfiV8LNmkAYdZ8jEtUGpdBfZuKw=;
 b=JeW/S8G5ZWeJgH59+l8DPEO+aOIc/sLBIObY5xPrWeYqlIDw/RgXoQkINJLeTQM7bs
 NADJwTevCvRpeSsVtVAMwgU3NyVQpoB5nX8eekTsGR1e+KpQq3zoI7dfKvMiXXfkyUQR
 i2lftQh446cUyTJVg46H1Ywl32XUt+Bbh/Rq+04iXqhZMLlXhXGumqZ0lsbrTk34EPEy
 loLzgwFSdQe3oF95jVgD6+AsRsQeTHytsS1DgdE/jeYF3LrQzenymvXAVAYN1ZufLRtE
 IbAK9yqsiStsF0navW0zfxiQmo1wnfeD4Zro7nQcDlnd5QRtD2vet5QY/32cKsKWtbYu
 XD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464070; x=1782068870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjcO48NagB8ylMATDfiV8LNmkAYdZ8jEtUGpdBfZuKw=;
 b=F2qpl2nwI8FBqZCvoF4EnIsSTfF1/YPg0MYRCYnNZWoI7UMhVxAM/K1OzY2YBLX1+J
 jAQzYtt1B4ENSOYw15lKm/JbDOmHk2OWtS8kn5hpUaImIUhjFnOrqMqF5pcWWP1SFRvY
 cp9o+oVQZJcGDpHkN7KOFRMtVGQGiD6CFRrHOzzCd+T6BUQ8Mf2TrnaZf+5aD7CHLuVm
 k85sIs7ReqJoIl7RkF7B/dVAGIzyfNrYJpZNZFdIillOxAmD3e5iz4wllsGWFYCNoIGu
 9Lvp25inzwY8N3JgvaiqmtbttqoZovc+zrxcuJd3I0yrmz9VIRPQ3qN3R98IY+KbMvqF
 gOBA==
X-Gm-Message-State: AOJu0Yzu8BHQG9ov3tVy+qQKYGI1unXSAnMvyJR/h7MZAG0h76pH5p8M
 GNTFhNZW5MAfzoJAWfwJRgicZF2AiojaCsx9xgF3ZKPCQvD4ffZlkaNNDdc4lHIiCCYhQ2EREBh
 b+8VeWwYvq93gMVS9OWfD8O3goKj153VnGVPz5GAj5YLKO2AS0rjbXxjoWvg9ckKmz+WIjT3YlF
 y0tfBfF9ODfBZIPCko8ujN9KuQIUzB/olv4g==
X-Gm-Gg: Acq92OHa4cqcMSSaa4wxV8lF9uIxhJ3vgc0VtdU53O8SJIPIjq+pg+D8YJzKEbXH9iu
 MkQqhlOzaxBDuRr704n/oW/bXhlb68R+Cxhi+2XM9j3Asb5uDg0YKD+zF23EbWnzH2L51ZtNKQk
 BhPGLUaiAcxYgafrWS77F7CvYUNkZzUCzJFxBP1lDxb6PV48mg+Zy3NmViwZ94lf0Dc+zpIXm9S
 zoZN84wjzZamQRbPM58jt8ZbCmk6xr/vSsCOdVf3MB99kqkwe/GzkF542k5CECj4C07WBHBiL56
 6JkT5n0fLXwPgy0tetxcPs9qPn2vadjVdyPmfNov1zbiseFKxskws1AaU+mZgu12C8qy6vPfnHO
 Ijmfr+s9iaujWqDyKhL/lJLpO+qQvPmi8CUKHby1KtHM=
X-Received: by 2002:a05:6000:25f7:b0:43d:7868:21f0 with SMTP id
 ffacd0b85a97d-4606da57dd1mr14907205f8f.9.1781464070236; 
 Sun, 14 Jun 2026 12:07:50 -0700 (PDT)
X-Received: by 2002:a05:6000:25f7:b0:43d:7868:21f0 with SMTP id
 ffacd0b85a97d-4606da57dd1mr14907152f8f.9.1781464069686; 
 Sun, 14 Jun 2026 12:07:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm29134766f8f.16.2026.06.14.12.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Lei Yang <leiyang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, qemu-block@nongnu.org
Subject: [PULL 047/106] vhost-user-blk: add some useful trace-points
Message-ID: <587c9d91cd9cb2ee09813afa60e952a1d47a9932.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-22-vsementsov@yandex-team.ru>
---
 hw/block/trace-events     | 10 ++++++++++
 hw/block/vhost-user-blk.c | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index cc9a9f2460..dbaa5ca6cb 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -58,6 +58,16 @@ virtio_blk_handle_zone_mgmt(void *vdev, void *req, uint8_t op, int64_t sector, i
 virtio_blk_handle_zone_reset_all(void *vdev, void *req, int64_t sector, int64_t len) "vdev %p req %p sector 0x%" PRIx64 " cap 0x%" PRIx64 ""
 virtio_blk_handle_zone_append(void *vdev, void *req, int64_t sector) "vdev %p req %p, append sector 0x%" PRIx64 ""
 
+# vhost-user-blk.c
+vhost_user_blk_start_in(void *vdev) "vdev %p"
+vhost_user_blk_start_out(void *vdev) "vdev %p"
+vhost_user_blk_stop_in(void *vdev) "vdev %p"
+vhost_user_blk_stop_out(void *vdev) "vdev %p"
+vhost_user_blk_connect_in(void *vdev) "vdev %p"
+vhost_user_blk_connect_out(void *vdev) "vdev %p"
+vhost_user_blk_device_realize_in(void *vdev) "vdev %p"
+vhost_user_blk_device_realize_out(void *vdev) "vdev %p"
+
 # hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2831f3c053..530f44ab52 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -31,6 +31,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "trace.h"
 
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
@@ -137,6 +138,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int i, ret;
 
+    trace_vhost_user_blk_start_in(vdev);
+
     if (!k->set_guest_notifiers) {
         error_setg(errp, "binding does not support guest notifiers");
         return -ENOSYS;
@@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
     }
     s->started_vu = true;
 
+    trace_vhost_user_blk_start_out(vdev);
+
     return ret;
 
 err_guest_notifiers:
@@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     int ret;
     bool force_stop = false;
 
+    trace_vhost_user_blk_stop_in(vdev);
+
     if (!s->started_vu) {
         return 0;
     }
@@ -233,6 +240,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
+
+    trace_vhost_user_blk_stop_out(vdev);
+
     return ret;
 }
 
@@ -340,6 +350,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     int ret = 0;
 
+    trace_vhost_user_blk_connect_in(vdev);
+
     if (s->connected) {
         return 0;
     }
@@ -366,6 +378,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
         ret = vhost_user_blk_start(vdev, errp);
     }
 
+    trace_vhost_user_blk_connect_out(vdev);
+
     return ret;
 }
 
@@ -456,6 +470,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     int retries;
     int i, ret;
 
+    trace_vhost_user_blk_device_realize_in(vdev);
+
     if (!s->chardev.chr) {
         error_setg(errp, "chardev is mandatory");
         return;
@@ -515,6 +531,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
                              vhost_user_blk_event, NULL, (void *)dev,
                              NULL, true);
+
+    trace_vhost_user_blk_device_realize_out(vdev);
+
     return;
 
 virtio_err:
-- 
MST


