Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA34C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4o02-0002Jr-B8; Thu, 10 Sep 2026 19:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lj3-0001RE-W1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4liq-0006Mn-2t
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqjojGjFi5nUGCc20Drm+8VeWMIFynXWAu4/zax0fR0=;
 b=B+m3FwUkbqUbBNwkgi1MYnb9uMUEd0Uso72wvrQeCU7kWe4KNxMBrAeOfWqJC84KVCKLWz
 sibjJOBBvUwp8AkqOqrGTIexeeVj5ipaTWy73crGsP397EqRNmKd1nXRwPNOQPn50+LsJF
 2CUO7tC5yN0qS9i6glaw8Qd1rFGYzOc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-vKMcYgSoPDqigSpRej5hDA-1; Thu, 10 Sep 2026 16:15:42 -0400
X-MC-Unique: vKMcYgSoPDqigSpRej5hDA-1
X-Mimecast-MFC-AGG-ID: vKMcYgSoPDqigSpRej5hDA_1789071341
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so94476f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071341; x=1789676141; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VqjojGjFi5nUGCc20Drm+8VeWMIFynXWAu4/zax0fR0=;
 b=lt33hhDKJiXTL6K8b/LpVUU1ybxtZYQJ7VkpV+yTtok5IYbpVit9iVShT41yGx4U31
 5h5zJwIV893MnwcTN+Tl1SHe1QKdXXfg7tVphlJDay+fu00q5qjTFC087r8iDOc0PZsX
 fkFBIACh6HnxxRZvF7L/90prf3atJNB3s0mJGbgLBaomM9Onr5UeBXRQHLQ5wZcpAWWZ
 3Rlt/t4ELWlvMakntzhJ4WNGZFj4cI5AVjG8fphEitdikDwd7lgasTeHXZMeYg5F/GaB
 SQpiDq9TMFtx+GYPzHWod7XwFiEMCrGi5NDfRmXWisoqTC9t7RN4Wd35cxlpibp8ajH/
 VucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071341; x=1789676141;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VqjojGjFi5nUGCc20Drm+8VeWMIFynXWAu4/zax0fR0=;
 b=qf14pwxWqNpIYNloNDeeQ9gDhq/4hIXDpJEF8wE0Wam/LDlC8bj49vOtuF6tdXep2I
 Ym2RLqgSj4xsXeAwjtCtNvzF8UKvDHaQ6RM4WUB/74HrQYCTvzp8DrEb8EdbeIyy8Wrg
 /cXKkSjpDN2j0djxG6bVMuHQzWkZ8AdaJ1qBmuaSBJ9tms8Yjo+sn06eAlYReiw5GP++
 G1+num6dsAVWubz7LIdNwoQIfKeDEGGWgIEthXwk9MbIrzT1sb6DxQ+FzFS40cJbyljB
 qH6Z7hthH5wDF8Hr/NS+OLBwZ5C9Xp1gTFaJ2SW1ac+hvOa9JcV8/uQzGcGjzkvUSYcu
 2dNw==
X-Gm-Message-State: AFuF++kXsG4RsiSBfzhcXDp4s6uECLHXo+1TBJRjuWKPByVEZxi/sr4U
 2LZvhxSmBMtdIt40IzTf/ntN/VxW/jcknvddHTu0tsHg3uph7bO4SEjMPmSjNYCPyOP6VpCN0/q
 ug6v8SuAsZSLuoPxPflXd53VMCL5v2D14nLZdsUwwi1hT+zmybpqhQ9eoIEHbinA5Fa0H47y8H2
 Mriyr3HrTQrenx2HQAjFQz25yPjMcDt8X29A==
X-Gm-Gg: AYBFou1JqrS/9cmPWEcymFgTY+kuVb1IMj57RKxpmBHTQMFQVPn+uSdqaTdzd5bckpe
 YOuKB6AZbwWKN7kjCukSozfEtffpb5j4ntCHzBJrWqmTvismGIDV7rJwtFSyx+GNugLnT2+MvjP
 Sx53Gu/SKxv418eVtDKQvWsHzxAsHoIVe4HXvIusFdGM5iw6bCZNQvjqUfyZ0jSTBqhA42Ps0pc
 Gk/2y30bBEyAuHk6eC0S4X3GQp0JyfgzfhQvAruJzspqiWwcaqCWe6cBV3wkPtQLhiS50tK9ils
 EW7Xb+xzys6D8trmvOm8eNH959wnzrSl50jFSVdpVTMP/L+tNSbGKkYYwPIFKoPGdY+vyn3zAAp
 A3MgUfyIfvXG7lSBLs2iCLd8=
X-Received: by 2002:adf:ec86:0:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-486eb325de3mr1103478f8f.17.1789071341089; 
 Thu, 10 Sep 2026 13:15:41 -0700 (PDT)
X-Received: by 2002:adf:ec86:0:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-486eb325de3mr1103352f8f.17.1789071340413; 
 Thu, 10 Sep 2026 13:15:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm821976f8f.6.2026.09.10.13.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL 84/90] vhost-user: add skip_drain param to
 do_vhost_virtqueue_stop
Message-ID: <e8e592c07cec60abce1c406913b8a65312b574e9.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Currently do_vhost_virtqueue_stop always sends GET_VRING_BASE to the
back-end, which requires the back-end to drain all in-flight I/O before
stopping the vring.

Add a skip_drain parameter to do_vhost_virtqueue_stop and propagate it
up through vhost_virtqueue_stop, vhost_dev_stop and their callers.
The parameter will be used in a follow-up commit to send a new protocol
message that instructs the back-end to suspend in-flight I/O immediately
instead of draining it.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-2-dtalexundeer@yandex-team.ru>
---
 include/hw/virtio/vhost.h      |  7 +++++--
 backends/cryptodev-vhost.c     |  2 +-
 backends/vhost-user.c          |  2 +-
 hw/block/vhost-user-blk.c      |  2 +-
 hw/display/vhost-user-media.c  |  2 +-
 hw/net/vhost_net.c             |  9 +++++----
 hw/scsi/vhost-scsi-common.c    |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user-fs.c      |  2 +-
 hw/virtio/vhost-user-scmi.c    |  2 +-
 hw/virtio/vhost-vsock-common.c |  2 +-
 hw/virtio/vhost.c              | 28 +++++++++++++++++++---------
 13 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index cd012b99a2..cd6e200538 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -277,6 +277,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  * @hdev: common vhost_dev structure
  * @vdev: the VirtIODevice structure
  * @vrings: true to have vrings disabled in this call
+ * @skip_drain: true to notice back-end to skip draining all in-flight requests
  *
  * Stop the vhost device. After the device is stopped the notifiers
  * can be disabled (@vhost_dev_disable_notifiers) and the device can
@@ -284,7 +285,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  *
  * Return: 0 on success, != 0 on error when stopping dev.
  */
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings,
+                   bool skip_drain);
 
 /**
  * vhost_dev_force_stop() - force stop the vhost device
@@ -445,7 +447,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
                           struct vhost_virtqueue *vq, unsigned idx);
 int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
-                         struct vhost_virtqueue *vq, unsigned idx);
+                         struct vhost_virtqueue *vq, unsigned idx,
+                         bool skip_drain);
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index c6069f4e5b..f1ca6bcd4e 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -109,7 +109,7 @@ static void
 cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
                                  VirtIODevice *dev)
 {
-    vhost_dev_stop(&crypto->dev, dev, false);
+    vhost_dev_stop(&crypto->dev, dev, false, false);
     vhost_dev_disable_notifiers(&crypto->dev, dev);
 }
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 46dadb7480..de6b1ba267 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -108,7 +108,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
         return 0;
     }
 
-    ret = vhost_dev_stop(&b->dev, b->vdev, true);
+    ret = vhost_dev_stop(&b->dev, b->vdev, true, false);
 
     if (k->set_guest_notifiers &&
         (err = k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false)) < 0) {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2e5b3ae1b1..c3e3c37f8c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -238,7 +238,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
                  qemu_force_shutdown_requested();
 
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
-                       vhost_dev_stop(&s->dev, vdev, true);
+                       vhost_dev_stop(&s->dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
index eaf99dc6a2..851af8ddc2 100644
--- a/hw/display/vhost-user-media.c
+++ b/hw/display/vhost-user-media.c
@@ -110,7 +110,7 @@ static void vu_media_stop(VirtIODevice *vdev)
         return;
     }
 
-    vhost_dev_stop(&media->vhost_dev, vdev, true);
+    vhost_dev_stop(&media->vhost_dev, vdev, true, false);
 
     ret = k->set_guest_notifiers(qbus->parent, media->vhost_dev.nvqs, false);
     if (ret < 0) {
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 323d117735..6e05c995f1 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -384,7 +384,7 @@ fail:
     if (net->nc->info->poll) {
         net->nc->info->poll(net->nc, true);
     }
-    vhost_dev_stop(&net->dev, dev, false);
+    vhost_dev_stop(&net->dev, dev, false, false);
 fail_start:
     return r;
 }
@@ -403,7 +403,7 @@ static void vhost_net_stop_one(struct vhost_net *net,
     if (net->nc->info->poll) {
         net->nc->info->poll(net->nc, true);
     }
-    vhost_dev_stop(&net->dev, dev, false);
+    vhost_dev_stop(&net->dev, dev, false, false);
     if (net->nc->info->stop) {
         net->nc->info->stop(net->nc);
     }
@@ -636,7 +636,8 @@ void vhost_net_virtqueue_reset(VirtIODevice *vdev, NetClientState *nc,
     vhost_virtqueue_stop(&net->dev,
                          vdev,
                          net->dev.vqs + idx,
-                         net->dev.vq_index + idx);
+                         net->dev.vq_index + idx,
+                         false);
 }
 
 int vhost_net_virtqueue_restart(VirtIODevice *vdev, NetClientState *nc,
@@ -686,7 +687,7 @@ err_start:
         assert(ret >= 0);
     }
 
-    vhost_dev_stop(&net->dev, vdev, false);
+    vhost_dev_stop(&net->dev, vdev, false, false);
 
     return r;
 }
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index e19800a0bc..e546a6dc75 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -108,7 +108,7 @@ int vhost_scsi_common_stop(VHostSCSICommon *vsc)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret = 0;
 
-    ret = vhost_dev_stop(&vsc->dev, vdev, true);
+    ret = vhost_dev_stop(&vsc->dev, vdev, true, false);
 
     if (k->set_guest_notifiers) {
         int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 6dc684ab09..7e5cc040e9 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -301,7 +301,7 @@ static void vhost_vdpa_device_stop(VirtIODevice *vdev)
         return;
     }
 
-    vhost_dev_stop(&s->dev, vdev, false);
+    vhost_dev_stop(&s->dev, vdev, false, false);
 
     ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (ret < 0) {
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 478ec68f09..1a377016e7 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -78,7 +78,7 @@ static int vub_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&vub->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vub->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vub->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 209993918a..0d8842817a 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -111,7 +111,7 @@ static int vuf_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&fs->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&fs->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 02dc088ea9..c4692bd6aa 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -101,7 +101,7 @@ static int vu_scmi_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(vhost_dev, vdev, true);
+    ret = vhost_dev_stop(vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vhost_dev->nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index b79f4c9ce6..4ef037627b 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -106,7 +106,7 @@ int vhost_vsock_common_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true);
+    ret = vhost_dev_stop(&vvc->vhost_dev, vdev, true, false);
 
     err = k->set_guest_notifiers(qbus->parent, vvc->vhost_dev.nvqs, false);
     if (err < 0) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6c2612a1dd..17b36366dc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
@@ -1509,8 +1510,13 @@ fail:
 static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                    struct VirtIODevice *vdev,
                                    struct vhost_virtqueue *vq,
-                                   unsigned idx, bool force)
+                                   unsigned idx, bool force,
+                                   bool skip_drain)
 {
+    if (skip_drain) {
+        assert(vhost_user_has_protocol_feature(dev,
+               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
+    }
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
@@ -1560,9 +1566,10 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
 int vhost_virtqueue_stop(struct vhost_dev *dev,
                          struct VirtIODevice *vdev,
                          struct vhost_virtqueue *vq,
-                         unsigned idx)
+                         unsigned idx,
+                         bool skip_drain)
 {
-    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false);
+    return do_vhost_virtqueue_stop(dev, vdev, vq, idx, false, skip_drain);
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
@@ -2350,7 +2357,8 @@ fail_vq:
         vhost_virtqueue_stop(hdev,
                              vdev,
                              hdev->vqs + i,
-                             hdev->vq_index + i);
+                             hdev->vq_index + i,
+                             false);
     }
 
 fail_mem:
@@ -2365,7 +2373,7 @@ fail_features:
 
 /* Host notifiers must be enabled at this point. */
 static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
-                             bool vrings, bool force)
+                             bool vrings, bool force, bool skip_drain)
 {
     int i;
     int rc = 0;
@@ -2392,7 +2400,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
                                       vdev,
                                       hdev->vqs + i,
                                       hdev->vq_index + i,
-                                      force);
+                                      force,
+                                      skip_drain);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2414,15 +2423,16 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     return rc;
 }
 
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings,
+                   bool skip_drain)
 {
-    return do_vhost_dev_stop(hdev, vdev, vrings, false);
+    return do_vhost_dev_stop(hdev, vdev, vrings, false, skip_drain);
 }
 
 int vhost_dev_force_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
                          bool vrings)
 {
-    return do_vhost_dev_stop(hdev, vdev, vrings, true);
+    return do_vhost_dev_stop(hdev, vdev, vrings, true, false);
 }
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
-- 
MST


