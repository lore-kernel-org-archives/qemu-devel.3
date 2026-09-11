Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD8C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBR-0008Hn-Um; Fri, 11 Sep 2026 05:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBA-00078g-DH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB8-0008TT-36
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1olWRoVJuPWwSBJbdW2ynlLoWLMs3mS5pnDLdXpZdk=;
 b=Jj8RQkCwtzOcaAgYrNj5ae+iaypixPB5ly8Mw11tS7NFPnnVU0qQdOeJyhgHl9GT5W8CHA
 MfMRwMVpfyv+ZScSj6dhkSy14V/MCr9yRAt0G44j405cV2121CGuNoYaSy2KdyRHMJcLvt
 gXw1nG6YcEa8sqfcXW0VSjlGGFYwxcY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Gl-pElc3OMuKZvVwB54ehw-1; Fri, 11 Sep 2026 05:04:12 -0400
X-MC-Unique: Gl-pElc3OMuKZvVwB54ehw-1
X-Mimecast-MFC-AGG-ID: Gl-pElc3OMuKZvVwB54ehw_1789117451
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f1eee015so122754f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117451; x=1789722251; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v1olWRoVJuPWwSBJbdW2ynlLoWLMs3mS5pnDLdXpZdk=;
 b=WnTh/7e18O96NjvIeY0+PdqcputxsTWRYhwvjuOKxSdlW3VvPSD3XmwnltwIGb7e/m
 ksen+jvQWaNfuDkl8SBlET+z/kYqWrPqb80QeEFAsfei2qhD4pwJwdYyaCBfncz+5FZu
 t8mj9MICybAgbON12wRBhh8xY+hK44SzwGGNsqN6ces+hXZoydQp9onkcwoo4tSMg8Rh
 yZp/FVfsDbr2ZvlKJS7lH7IP4H8U1EsaS/qwbeAqvkcEa+KPyCnSNa07D+ar9d6X9oOl
 Z3v3D1HdWo0xhoiJ0gBHqG1O1UvRs+VbgDd5CJj6rtxLsuvSLBkrRFL4e72QkRwRcsvo
 kiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117451; x=1789722251;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1olWRoVJuPWwSBJbdW2ynlLoWLMs3mS5pnDLdXpZdk=;
 b=MUl/gzLGoB85lZdFvzjTva7FJXOaHDRl48KRLmBrc4B6xFcboWPtxLnBasVUKJSvNu
 ce8HA0p9dJ+w8Uqe9U2Td1gC7ecBHEAtbixyHQtJ+l9aAAT2jOUAfkwUhBtoEbLroyki
 yHGeFcvc5bsISOg6vXR0u7WCZTeagYfsZ+92rFrdgFKQRm62TCEzVGdChyynzZpygySy
 zqf+RMCWlLprWdoWudkHNTdRTamWllA/GSoXOLh9VoE92OB/m31Y4J0dT4/2DF6wMYuv
 wgqziO5weVD+55wF++4L284ie6QumDAmMrlRAjbTGYVPzgHGuHjpsmw9v9YtJVWo9Qwt
 MQ2g==
X-Gm-Message-State: AFuF++kSgCKpmaQLFTmrAzIYnjUlADM0xPw/KvUzT8HgT5RIbERJQRDP
 8bHmcMZmKD/OmoPfJzVfrj1IfGkSqAbAOn8M0HGKJ78bnOUYYaSJiEDFnPPUlB34AJipHDUrD/2
 d70RRzwknnpGC73R3AK9REPOA4X2bJxXSBicU8sSvWoQkhexkH/f+rL5bbXgaO0GeVTPdHadHHV
 zJWcLsb1DfZtBJazNEiEoiZ5LgQYo7NX3iaQ==
X-Gm-Gg: AYBFou0M9E0KYS5wqgFjjNlOBs1QJae2P9zKKZxmlJcihFKI7TsiWLCmpH2D+2B7hb5
 dbNAsNMBmCvT+3/7gJo1wqLLXrR4DuqF0zfkZXSyOrPS8HuPfznuMTxe0EMcvPeOe/bZ16UShd8
 WiHugKqdHlnima3wytqmKtxT2IyGGMzBvZADaSyg0YbDFU2GSeDpZphDMesep2yWmYBeOcjpZMS
 vjDZS7186QN4axsMRkqt8OrskPIRBnPEgg7erC7I1UmHcrZV0sOVNQEVDIXROQg7omrGncns+cH
 c6ipTbm7/0eiVATWMhSz4CJB/MMiYnwPgO7PFmG9UR4PZcJcheXeoNtk5pLzNMOpCklK/ZGzYj0
 E99VoN+1uH8qZqXy0nWTAuQI=
X-Received: by 2002:adf:e00b:0:10b0:484:3310:710c with SMTP id
 ffacd0b85a97d-486eb351000mr4953734f8f.24.1789117450515; 
 Fri, 11 Sep 2026 02:04:10 -0700 (PDT)
X-Received: by 2002:adf:e00b:0:10b0:484:3310:710c with SMTP id
 ffacd0b85a97d-486eb351000mr4953596f8f.24.1789117449920; 
 Fri, 11 Sep 2026 02:04:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm4420473f8f.32.2026.09.11.02.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:09 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:06 -0400
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
Subject: [PULL v2 69/75] vhost-user: add skip_drain param to
 do_vhost_virtqueue_stop
Message-ID: <2e6881e1198dcb0c9ec0fe2dbbc04ac5d13ea696.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 3db56433b6..0a322efec1 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -228,6 +228,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  * @hdev: common vhost_dev structure
  * @vdev: the VirtIODevice structure
  * @vrings: true to have vrings disabled in this call
+ * @skip_drain: true to notice back-end to skip draining all in-flight requests
  *
  * Stop the vhost device. After the device is stopped the notifiers
  * can be disabled (@vhost_dev_disable_notifiers) and the device can
@@ -235,7 +236,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
  *
  * Return: 0 on success, != 0 on error when stopping dev.
  */
-int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings);
+int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings,
+                   bool skip_drain);
 
 /**
  * vhost_dev_force_stop() - force stop the vhost device
@@ -396,7 +398,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
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
index 52ea142bd4..48fe1805bb 100644
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
@@ -1499,8 +1500,13 @@ fail:
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
@@ -1550,9 +1556,10 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
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
@@ -2307,7 +2314,8 @@ fail_vq:
         vhost_virtqueue_stop(hdev,
                              vdev,
                              hdev->vqs + i,
-                             hdev->vq_index + i);
+                             hdev->vq_index + i,
+                             false);
     }
 
 fail_mem:
@@ -2322,7 +2330,7 @@ fail_features:
 
 /* Host notifiers must be enabled at this point. */
 static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
-                             bool vrings, bool force)
+                             bool vrings, bool force, bool skip_drain)
 {
     int i;
     int rc = 0;
@@ -2349,7 +2357,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
                                       vdev,
                                       hdev->vqs + i,
                                       hdev->vq_index + i,
-                                      force);
+                                      force,
+                                      skip_drain);
     }
     if (hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
@@ -2371,15 +2380,16 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
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


