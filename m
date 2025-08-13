Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55897CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg5-00038w-4I; Wed, 13 Aug 2025 12:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfo-0002pt-7x; Wed, 13 Aug 2025 12:50:00 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfg-0007sW-0x; Wed, 13 Aug 2025 12:49:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 040F681120;
 Wed, 13 Aug 2025 19:49:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-r37fMOkh; Wed, 13 Aug 2025 19:49:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103759;
 bh=RVMjTVzFKCrR8tcU9nJeNLV2M5Rh2vtB7v608WCFWz8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mv/YQw7zHXyLg8O9kapWcCGLgHZUnr59AWTb9LtZg+QDjuX9Q8dk/vKFxeOJrIAEF
 ZYqX0MNVZJbwlNWtXWf6TRyZZ4lDJyWcMEw3QHsdA/4pxmT22AOm7KC3aP8Bryivzu
 ryfSqfED1jc3vhL0ev2i85cbxcu4EtcTYAcE7TKo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 22/33] vhost-user-blk: add some useful trace-points
Date: Wed, 13 Aug 2025 19:48:43 +0300
Message-ID: <20250813164856.950363-23-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/trace-events     | 10 ++++++++++
 hw/block/vhost-user-blk.c | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index cc9a9f2460..3b5fd2a599 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -58,6 +58,16 @@ virtio_blk_handle_zone_mgmt(void *vdev, void *req, uint8_t op, int64_t sector, i
 virtio_blk_handle_zone_reset_all(void *vdev, void *req, int64_t sector, int64_t len) "vdev %p req %p sector 0x%" PRIx64 " cap 0x%" PRIx64 ""
 virtio_blk_handle_zone_append(void *vdev, void *req, int64_t sector) "vdev %p req %p, append sector 0x%" PRIx64 ""
 
+# vhost-user-blk.c
+vhost_user_blk_start(void) ""
+vhost_user_blk_start_finish(void) ""
+vhost_user_blk_stop(void) ""
+vhost_user_blk_stop_finish(void) ""
+vhost_user_blk_connect(void) ""
+vhost_user_blk_connect_finish(void) ""
+vhost_user_blk_device_realize(void) ""
+vhost_user_blk_device_realize_finish(void) ""
+
 # hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index de7a810c93..c8bc2c78e6 100644
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
 
+    trace_vhost_user_blk_start();
+
     if (!k->set_guest_notifiers) {
         error_setg(errp, "binding does not support guest notifiers");
         return -ENOSYS;
@@ -192,6 +195,8 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
     }
     s->started_vu = true;
 
+    trace_vhost_user_blk_start_finish();
+
     return ret;
 
 err_guest_notifiers:
@@ -212,6 +217,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     int ret;
     bool force_stop = false;
 
+    trace_vhost_user_blk_stop();
+
     if (!s->started_vu) {
         return 0;
     }
@@ -233,6 +240,8 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
+
+    trace_vhost_user_blk_stop_finish();
     return ret;
 }
 
@@ -340,6 +349,8 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     int ret = 0;
 
+    trace_vhost_user_blk_connect();
+
     if (s->connected) {
         return 0;
     }
@@ -365,6 +376,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
         ret = vhost_user_blk_start(vdev, errp);
     }
 
+    trace_vhost_user_blk_connect_finish();
     return ret;
 }
 
@@ -455,6 +467,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     int retries;
     int i, ret;
 
+    trace_vhost_user_blk_device_realize();
+
     if (!s->chardev.chr) {
         error_setg(errp, "chardev is mandatory");
         return;
@@ -514,6 +528,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
                              vhost_user_blk_event, NULL, (void *)dev,
                              NULL, true);
+    trace_vhost_user_blk_device_realize_finish();
     return;
 
 virtio_err:
-- 
2.48.1


