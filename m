Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B781C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNy3-0000tY-0O; Sun, 05 Jul 2026 10:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxO-0000E1-OT
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxN-0001cP-5H
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ek7GM06dWpHYxFJTmynh6J3zwTJAgY0ZExyx9NjFZSw=;
 b=FWhSaibc4olAnev80r2FPuDXAoCfpONdL6QY1j8ZG4BZ5uUR+fiaZ3eFJqQmy3RCDkpa0R
 bq73K/ICnMNvnUPxyBcp1O+FBInU8oUb6bf/jJAyrWpTQNudKtXG3pDZczLY7ZrQl8PbBn
 4UDIq2Lkcliz+3GhABvG71AD/z0NxRc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-DE5TqZ_CO9qACzWMd5bZEg-1; Sun, 05 Jul 2026 10:36:27 -0400
X-MC-Unique: DE5TqZ_CO9qACzWMd5bZEg-1
X-Mimecast-MFC-AGG-ID: DE5TqZ_CO9qACzWMd5bZEg_1783262186
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493ae2a6a72so17285285e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262186; x=1783866986; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ek7GM06dWpHYxFJTmynh6J3zwTJAgY0ZExyx9NjFZSw=;
 b=ONtOCkqVVZB5Sfa35RKEHwKF5djDYZbJ11DJeDv0fk9y8IZXPuDYPGSS5WZNqxSgVC
 g/qgVG0YAoNXdFl88AiJPYTRsOSqGBtVCq2n/pska8zoQnENPxIiyf03ngbx9gZFZFeT
 QHACLgzKOVp4xtB4j0/ZwWk/E+h2aWrvP6dfbIfbQuAgD382hiscPNLh5Ta7m1FJfu6w
 utWQbkxirCffOM+qOQ5DQoSkDi9zwmQrsUut0WpA57e/4zbou5ALhhfaQNhxVndhNpfQ
 ST9ocjpD/f4Uf/h+dLhdzlSUeTexDF5uvbVBd3OgM4DcC5/hu37HR0FoHutt4yTRK0Y0
 dANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262186; x=1783866986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ek7GM06dWpHYxFJTmynh6J3zwTJAgY0ZExyx9NjFZSw=;
 b=Ga6E0T5fyuQuL77ng19VPhMqjH3qvNYaF7R4g27hy8gBRUlQDSLD23aheOMypHBsvt
 yLVh9HLyJbIVROEuw9lHBT9JQ4581I+3ClF6CXUg2MfQtkW2Q8IS16hEe6Tfwz+xnr13
 gQGJImD609KUrtLx1v+SfMARpNXly2ahfLdNT1UWGORHW8jfzImpGEXKRI3tMksgH/En
 9Rx06cm/0IRlq4sXFr7CgJldRW+2YFukklEBC1oA5RfzlyS+L1Q66+Qm+a73tyAOkC/1
 fkD+KvE2uJO+Vt1OWJd7jh0JVE0sdv6Uwo6FuDU1yEg+YZzUka9Gm4e70VuBJ0oQHX/k
 9i9w==
X-Gm-Message-State: AOJu0YzN6uW0sRp9bCcP2tmvsuY61fyEaebB9MPDi/gfj69ssZ940znl
 465iitQJ1Xj1pgaBEbsjWJpY7/an5nuEpTo+hLnHyU/5fZvL4zpf0YX8lXQKk1TluohhiwCFT+8
 x8jpsgvlYVCZXKtK0sajZFuNS4+R1m+TtdEmr5xNwohcrD2JHDu9IA1cOcfLkik2rauVe+aWKmB
 Hp3sjqDvcyLSXDPhyFxf5qRxbG7Nj9AWGEjA==
X-Gm-Gg: AfdE7clgoCF65dsEPfBHLqUJDKWVVgt5y3DqRCPTyLlhdq5XMBvxpzuAt3YcrtB+mKB
 EXW6VJN/ISeMTIXyDK5CoLuNZSn2O23H9LGUPS6tDztXBueoBfP5AUW04oHv4dY80WEIqgL82Ji
 FkkHWCc4Vgam9qFne+XsbXfIMrPbkFs03b4Igmcw8/e5pNxOV9LsIWFfq35p1LtMGoqxtOp/7dP
 EOgin2F8ojvggoCJ130ga/4Kvu5YW11GKqMmQ36WgOGvgDcHQ0JCMBEfTUbujESZwX0dwZJRKs3
 dz2mcWyssJHs+BOpOtZoe2tfjwCkNJEW7Dbm0ndKYgw241ZLtlVeTTjlJ398CsRgafu9HDcJkOg
 UgKjBAyyyy1BmWJ9SudqpMF+b3rnbPupN
X-Received: by 2002:a05:600c:3e18:b0:493:ad8a:e7fd with SMTP id
 5b1f17b1804b1-493d11d7fd6mr73655755e9.14.1783262185727; 
 Sun, 05 Jul 2026 07:36:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3e18:b0:493:ad8a:e7fd with SMTP id
 5b1f17b1804b1-493d11d7fd6mr73655325e9.14.1783262185120; 
 Sun, 05 Jul 2026 07:36:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636e9e9sm282059215e9.2.2026.07.05.07.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:24 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sergei Heifetz <heifetz@yandex-team.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 43/44] vhost-user-blk: add seg-max-adjust flag
Message-ID: <5d4d0f552bcbe784d74c405d205749384be16822.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sergei Heifetz <heifetz@yandex-team.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260401230548.136541-1-heifetz@yandex-team.com>
---
 include/hw/virtio/vhost-user-blk.h |  1 +
 hw/block/vhost-user-blk.c          | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 1e41a2bcdf..dee848cfd8 100644
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
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index b2e46eb3f9..2e5b3ae1b1 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -66,6 +66,12 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     /* Our num_queues overrides the device backend */
     virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
 
+    if (s->seg_max_adjust) {
+        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);
+
+        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
+    }
+
     memcpy(config, &s->blkcfg, vdev->config_len);
 }
 
@@ -489,6 +495,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
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
@@ -624,6 +634,8 @@ static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
+    DEFINE_PROP_BOOL("seg-max-adjust", VHostUserBlk, seg_max_adjust,
+                      false),
     DEFINE_PROP_BIT64("config-wce", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_CONFIG_WCE, true),
     DEFINE_PROP_BIT64("discard", VHostUserBlk, parent_obj.host_features,
-- 
MST


