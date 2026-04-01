Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6CD1112242
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w84dT-00051q-Hm; Wed, 01 Apr 2026 19:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w84dK-000507-MC; Wed, 01 Apr 2026 19:05:59 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w84dH-0005sF-MK; Wed, 01 Apr 2026 19:05:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 24F65C0244;
 Thu, 02 Apr 2026 02:05:50 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:42a::1:b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id m5leq60LKeA0-kh0M1gk8; Thu, 02 Apr 2026 02:05:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775084749;
 bh=EoQSq2o+KRu3QhGbTHj5+iJSlNcBzF4BfhoQLpT5Iic=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=JKYq7OapdLJO3fmXDskzRWFeZETOE9sSofP0kQwuWe46imlZPqxvPFOgCPUsOiyiT
 0mSs2+TwT3EEkkJtjP6rjQmhxHu9xPYbnHn44VRFAj6WLd5BOKpWhT8CAujZC45PG/
 meRasxjMao179d8Htv7RbRIuvULynA7xBDr6wlZo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH] vhost-user-blk: add seg-max-adjust flag
Date: Thu,  2 Apr 2026 04:05:48 +0500
Message-ID: <20260401230548.136541-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The virtio specification is not completely clear about seg_max and its
relationship with queue_size. Some drivers (for example, the modern
Linux kernel driver) rely on seg_max to set the maximum number of
segments used in a request. If seg_max is set larger than queue_size,
such a driver might overwhelm a virtqueue by trying to send more
segments than it can handle. As a result, it either hangs or faults.

One might argue that it is the vhost-user server's responsibility to set
a valid seg_max value. However, due to the issue described in the
previous paragraph, this value should generally depend on queue_size.
That's why it may be necessary to control it on QEMU's side.

This patch adds the seg-max-adjust flag. A flag with the same name
already exists for virtio-blk (and it exists to solve the same problem,
except that here we have a vhost-user server to consult).

If seg-max-adjust is set, the final seg_max is the minimum of the value
provided by the vhost-user server and (queue_size - 2). It is not
enabled by default.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 hw/block/vhost-user-blk.c          | 11 +++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e836770..23f910d9fe3 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -65,6 +65,11 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     /* Our num_queues overrides the device backend */
     virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
 
+    if (s->seg_max_adjust) {
+        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);
+        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
+    }
+
     memcpy(config, &s->blkcfg, vdev->config_len);
 }
 
@@ -474,6 +479,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "queue size must be non-zero");
         return;
     }
+    if (s->queue_size < 4 && s->seg_max_adjust) {
+        error_setg(errp, "queue size must be >= 4 when seg-max-adjust is set");
+        return;
+    }
     if (s->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "queue size must not exceed %d",
                    VIRTQUEUE_MAX_SIZE);
@@ -608,6 +617,8 @@ static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
+    DEFINE_PROP_BOOL("seg-max-adjust", VHostUserBlk, seg_max_adjust,
+                      false),
     DEFINE_PROP_BIT64("config-wce", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_CONFIG_WCE, true),
     DEFINE_PROP_BIT64("discard", VHostUserBlk, parent_obj.host_features,
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 1e41a2bcdf6..dee848cfd81 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -34,6 +34,7 @@ struct VHostUserBlk {
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
     uint32_t queue_size;
+    bool seg_max_adjust;
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
-- 
2.53.0


