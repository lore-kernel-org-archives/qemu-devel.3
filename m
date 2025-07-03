Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C429AC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJMV-0006wc-9y; Thu, 03 Jul 2025 08:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLk-0005eO-4z; Thu, 03 Jul 2025 08:47:36 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLc-0006oa-KY; Thu, 03 Jul 2025 08:47:34 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a1:0:640:2691:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CA9E560C88;
 Thu,  3 Jul 2025 15:47:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:73d::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HlbMgQ0FgSw0-6ElfXpBj; Thu, 03 Jul 2025 15:47:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751546841;
 bh=5bC95VXV5236FRUQzBWj4uboAIkxgDmBkiRLwpbUVcM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vSq4yMnJCH4Z+3npji4HTDunBMV+STb/geUoV7g3IKtARGEjN+ctq+/FJkRgJ1RPr
 /Kw6QU5GBFCeS81t67EdvcL9AMISAlYyYYrARwPPsU4I11CVFe4/vOyjf220StdZRR
 VINz2oow8YYu0ZwuR8R6dyHtbO+LSu7QbPpsswPA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: qemu-block@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 jasowang@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, raphael@enfabrica.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 4/4] hw/vhost: finally drop vhost_dev.backend_features field
Date: Thu,  3 Jul 2025 15:47:12 +0300
Message-ID: <20250703124713.2530079-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It's unused now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 1 -
 hw/scsi/vhost-scsi.c      | 1 -
 hw/scsi/vhost-user-scsi.c | 1 -
 hw/virtio/vdpa-dev.c      | 1 -
 hw/virtio/virtio-qmp.c    | 2 --
 include/hw/virtio/vhost.h | 7 -------
 6 files changed, 13 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 0eebbcd80d8..079a6492355 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -343,7 +343,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
 
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cdf405b0f86..d694a25fe2d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -276,7 +276,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vqs = vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
                          VHOST_BACKEND_TYPE_KERNEL, 0, errp);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 25f2d894e7c..0c80a271d8b 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -159,7 +159,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
     vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
     vsc->dev.vqs = s->vhost_vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index d1da40afc80..3c0eed3e8e1 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -104,7 +104,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     v->dev.vqs = vqs;
     v->dev.vq_index = 0;
     v->dev.vq_index_end = v->dev.nvqs;
-    v->dev.backend_features = 0;
     v->started = false;
 
     ret = vhost_vdpa_get_iova_range(v->vhostfd, &iova_range);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d2..e514a4797e3 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -788,8 +788,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
             qmp_decode_features(vdev->device_id, hdev->features);
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features);
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 38800a7156b..d6afde8b5dd 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -99,16 +99,9 @@ struct vhost_dev {
      *
      * @features: available features provided by the backend
      * @acked_features: final negotiated features with front-end driver
-     *
-     * @backend_features: this is used in a couple of places to either
-     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
-     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
-     * future use should be discouraged and the variable retired as
-     * its easy to confuse with the VirtIO backend_features.
      */
     uint64_t features;
     uint64_t acked_features;
-    uint64_t backend_features;
 
     /**
      * @protocol_features: is the vhost-user only feature set by
-- 
2.48.1


