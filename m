Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF07FB3CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79Ip-0005P8-2Z; Mon, 30 Mar 2026 05:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w79Id-0005N7-3f; Mon, 30 Mar 2026 05:52:48 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1w79IZ-00064W-3x; Mon, 30 Mar 2026 05:52:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9989EC0203;
 Mon, 30 Mar 2026 12:52:41 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:78d::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QqVNFG1Af4Y0-5AOJ86sv; Mon, 30 Mar 2026 12:52:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774864360;
 bh=Hh5LG4Doo1WyRSeiFJBSkiaSBS0yCBvqInUEe434a44=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LRYxjwiMbBzC7+zDw44jqlEVvTVB+c0ttr229s8mU327X7ixmhIVuTrqLEJCWBxNz
 yy9sUmLKw/Q2lo8DBvyfs5owDPIiq1Ehbm8m/6MWqLYuvhz15/FYnpp1Jrno1mEr+z
 /Y3jybaki2fs06GZ1lg1SEmWrkIh6RYT+4tRBWdY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>,
 virtio-fs@lists.linux.dev, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3 5/5] vhost-user: add skip_drain param to GET_VRING_BASE
Date: Mon, 30 Mar 2026 14:52:26 +0500
Message-Id: <20260330095226.158386-6-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
References: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

In case of migration of QEMU from the new version (where the
inllight-migration parameter is present), to the old one (where it is
absent) there is no way to disable this feature on the backend during
runtime.

This commit slightly changes the semantics of the protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature
adds a new parameter for GET_VRING_BASE, which allows to control the
drain in-flight requests on the backend.
Thus, QEMU will be able to turn this feature on GET_VRING_BASE off and
on anytime.

In vhost-user-blk use inflight_migration param to enable skip_drain to
suspend in-flight I/O requests, and then migrate them throught inflight
subsection.

Also now QEMU will always try to setup
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT protocol featrue with
backend. This will allow to use skip_drain parameter on GET_VRING_BASE
message.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 docs/interop/vhost-user.rst    |  6 ++----
 hw/block/vhost-user-blk.c      | 30 ++++++++++++++++++++++++------
 hw/virtio/vhost-user.c         |  3 +--
 hw/virtio/vhost.c              |  1 +
 include/hw/virtio/vhost-user.h |  1 -
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index bfa75ff9a3..63efc87264 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1255,14 +1255,12 @@ Front-end message types
   *suspended*, see :ref:`Suspended device state
   <suspended_device_state>`.
 
-  The request payload's *num* field is currently reserved and must be
-  set to 0.
-
   By default, the back-end must complete all inflight I/O requests for the
   specified vring before stopping it.
 
   If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
-  feature has been negotiated, the back-end may suspend in-flight I/O
+  feature has been negotiated, using request payload's *num* field,
+  when *num* is set to 1, QEMU can tell the back-end to suspend in-flight I/O
   requests and record them as described in :ref:`Inflight I/O tracking
   <inflight_io_tracking>` instead of completing them before stopping the vring.
   How to suspend an in-flight request depends on the implementation of the back-end
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a3ecd83f54..522e9d34b5 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -134,10 +134,7 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
 {
     struct VHostUserBlk *s = opaque;
 
-    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
-                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-
-    return inflight_migration;
+    return s->inflight_migration;
 }
 
 
@@ -232,11 +229,14 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }
 
+    bool skip_drain = vhost_user_blk_inflight_needed(s) &&
+                      runstate_check(RUN_STATE_FINISH_MIGRATE);
+
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
-                       vhost_dev_stop(&s->dev, vdev, true, false);
+                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
 
     if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
@@ -364,7 +364,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
     s->vhost_user.supports_config = true;
-    s->vhost_user.supports_inflight_migration = s->inflight_migration;
     ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret < 0) {
@@ -580,10 +579,29 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static bool vhost_user_blk_pre_save(void *opaque, Error **errp)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(opaque);
+
+    bool inflight_migration_enabled = virtio_has_feature(
+        s->dev.protocol_features,
+        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
+    if (vhost_user_blk_inflight_needed(s) && !inflight_migration_enabled) {
+        error_setg(errp, "can't migrate vhost-user-blk device: "
+                         "backend doesn't support "
+                         "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT "
+                         "protocol feature");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
     .name = "vhost-user-blk/inflight",
     .version_id = 1,
     .needed = vhost_user_blk_inflight_needed,
+    .pre_save_errp = vhost_user_blk_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
         VMSTATE_END_OF_LIST()
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index bb8f8eab77..ed95ec7523 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2225,8 +2225,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             }
         }
 
-        if (!u->user->supports_inflight_migration ||
-            !virtio_has_feature(protocol_features,
+        if (!virtio_has_feature(protocol_features,
                                 VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
             protocol_features &= ~(1ULL <<
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ac4d6fca73..54e4ce2660 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1398,6 +1398,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
+        .num = skip_drain,
     };
     int r = 0;
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 53fe996686..c95bad5ddc 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -69,7 +69,6 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
-    bool supports_inflight_migration;
 } VhostUserState;
 
 /**
-- 
2.34.1


