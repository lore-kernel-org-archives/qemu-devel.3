Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE7CCD19A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xk-0007n6-59; Wed, 15 Oct 2025 10:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xg-0007m2-Ki; Wed, 15 Oct 2025 10:58:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xX-0000fV-5D; Wed, 15 Oct 2025 10:58:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 14900C0697;
 Wed, 15 Oct 2025 17:58:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-XKLzqHqu; Wed, 15 Oct 2025 17:58:29 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540309;
 bh=wNwdu8SceSxrcW0rk9s55+OjbMtBeK9dCvm3vEfhvUE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NIiBvSgtUo6N8DQ0A35y21ATV+e46h9/ZBA/mzikqghhCzc+pEk9bs2v7J+Lson8B
 jFwGlzFHnmfnne/VtpVri8n/O1aaSSrYKZGqxGVNR+01ZQkqv/Xztn72C94TXZnXe5
 YRvfxWGnb/J+HfKom46XvC7yC2UoD9NPAmqeS8C4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 22/23] vhost-user-blk: add some useful trace-points
Date: Wed, 15 Oct 2025 17:58:06 +0300
Message-ID: <20251015145808.1112843-23-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
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
index de7a810c93..a5daed4346 100644
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
@@ -365,6 +377,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
         ret = vhost_user_blk_start(vdev, errp);
     }
 
+    trace_vhost_user_blk_connect_out(vdev);
+
     return ret;
 }
 
@@ -455,6 +469,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     int retries;
     int i, ret;
 
+    trace_vhost_user_blk_device_realize_in(vdev);
+
     if (!s->chardev.chr) {
         error_setg(errp, "chardev is mandatory");
         return;
@@ -514,6 +530,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
                              vhost_user_blk_event, NULL, (void *)dev,
                              NULL, true);
+
+    trace_vhost_user_blk_device_realize_out(vdev);
+
     return;
 
 virtio_err:
-- 
2.48.1


