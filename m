Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09204CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iwn-0006BW-9y; Sat, 11 Oct 2025 19:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwj-000692-M7
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:17 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwf-0000rP-Ea
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A52C6C01DC;
 Sun, 12 Oct 2025 02:24:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-GCqLuvXD; Sun, 12 Oct 2025 02:24:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225050;
 bh=SqTlVhcGJ9EyDpmXzlOfNMeg33suPq7N0MPAybFtRIE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=barHOGJJFGJqOiyZgGZ8Zep2/1wbfmmQ0JYbalx066vje+7iuBipT3svxmmK1QnNS
 oS6KYL/2j2M5aM0ghwP3ccichzqG/rpwdboM+ts2YzCQ6t67ZFXQkFbms4oomf3VX/
 Z7xsloiLSCHqXFYz3fh720Wc8I1GALczzNZmxoJE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 03/23] vhost-user: introduce
 vhost_user_has_protocol_feature() helper
Date: Sun, 12 Oct 2025 02:23:42 +0300
Message-ID: <20251011232404.561024-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Make all protocol feature checks in the same way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 120 +++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b80174f489..b8231dcbcf 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -272,6 +272,12 @@ struct scrub_regions {
     int fd_idx;
 };
 
+static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
+                                            uint64_t feature)
+{
+    return virtio_has_feature(dev->protocol_features, feature);
+}
+
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -435,8 +441,8 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
 {
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
-    bool shmfd = virtio_has_feature(dev->protocol_features,
-                                    VHOST_USER_PROTOCOL_F_LOG_SHMFD);
+    bool shmfd =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
     int ret;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_LOG_BASE,
@@ -1006,11 +1012,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     bool config_mem_slots =
-        virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
     int ret;
 
     if (do_postcopy) {
@@ -1058,8 +1064,9 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
 static int vhost_user_set_vring_endian(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
-    bool cross_endian = virtio_has_feature(dev->protocol_features,
-                                           VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
+    bool cross_endian =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_VRING_ENDIAN,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1129,8 +1136,9 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
     int ret;
 
     if (wait_for_reply) {
-        bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
+        bool reply_supported =
+            vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
         if (reply_supported) {
             msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
         }
@@ -1458,8 +1466,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
     ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
                              log_enabled);
 
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         if (!ret) {
             return vhost_user_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
         }
@@ -1513,8 +1520,8 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
      * Historically, reset was not implemented so only reset devices
      * that are expecting it.
      */
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
         return -ENOSYS;
     }
 
@@ -1571,8 +1578,8 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
     void *addr;
     char *name;
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
         vdev == NULL || queue_idx >= virtio_get_num_queues(vdev)) {
         return -EINVAL;
     }
@@ -1884,13 +1891,13 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     };
     struct vhost_user *u = dev->opaque;
     int sv[2], ret = 0;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     Error *local_err = NULL;
     QIOChannel *ioc;
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
         return 0;
     }
 
@@ -2138,8 +2145,8 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
 
     switch (pnd->reason) {
     case POSTCOPY_NOTIFY_PROBE:
-        if (!virtio_has_feature(dev->protocol_features,
-                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
+        if (!vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
             error_setg(errp,
                        "vhost-user backend not capable of postcopy");
@@ -2230,7 +2237,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* query the max queues we support if backend supports Multiple Queue */
-        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ)) {
+        if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_MQ)) {
             err = vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
                                      &dev->max_queues);
             if (err < 0) {
@@ -2248,18 +2255,18 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         if (virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM) &&
-                !(virtio_has_feature(dev->protocol_features,
-                    VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
-                 virtio_has_feature(dev->protocol_features,
-                    VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
+            !(vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
+            vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
             error_setg(errp, "IOMMU support requires reply-ack and "
                        "backend-req protocol features.");
             return -EINVAL;
         }
 
         /* get max memory regions if backend supports configurable RAM slots */
-        if (!virtio_has_feature(dev->protocol_features,
-                                VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
+        if (!vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
             u->user->memory_slots = VHOST_MEMORY_BASELINE_NREGIONS;
         } else {
             err = vhost_user_get_max_memslots(dev, &ram_slots);
@@ -2281,8 +2288,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     }
 
     if (dev->migration_blocker == NULL &&
-        !virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
+        !vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
         error_setg(&dev->migration_blocker,
                    "Migration disabled: vhost-user backend lacks "
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
@@ -2351,8 +2358,8 @@ static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
 {
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
-    return virtio_has_feature(dev->protocol_features,
-                              VHOST_USER_PROTOCOL_F_LOG_SHMFD);
+    return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
 }
 
 static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
@@ -2367,8 +2374,7 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
     }
 
     /* if backend supports VHOST_USER_PROTOCOL_F_RARP ask it to send the RARP */
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_RARP)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_RARP)) {
         msg.hdr.request = VHOST_USER_SEND_RARP;
         msg.hdr.flags = VHOST_USER_VERSION;
         memcpy((char *)&msg.payload.u64, mac_addr, 6);
@@ -2382,11 +2388,11 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
 static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 {
     VhostUserMsg msg;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     int ret;
 
-    if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MTU))) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_NET_MTU)) {
         return 0;
     }
 
@@ -2446,8 +2452,7 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
         .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + config_len,
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                VHOST_USER_PROTOCOL_F_CONFIG)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
         error_setg(errp, "VHOST_USER_PROTOCOL_F_CONFIG not supported");
         return -EINVAL;
     }
@@ -2490,8 +2495,8 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
 {
     int ret;
     uint8_t *p;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_CONFIG,
@@ -2499,8 +2504,7 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
         .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + size,
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                VHOST_USER_PROTOCOL_F_CONFIG)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
         return -ENOTSUP;
     }
 
@@ -2535,8 +2539,9 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
                                             uint64_t *session_id)
 {
     int ret;
-    bool crypto_session = virtio_has_feature(dev->protocol_features,
-                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    bool crypto_session =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
     CryptoDevBackendSessionInfo *backend_info = session_info;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
@@ -2637,8 +2642,9 @@ static int
 vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
 {
     int ret;
-    bool crypto_session = virtio_has_feature(dev->protocol_features,
-                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    bool crypto_session =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CLOSE_CRYPTO_SESSION,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2683,8 +2689,8 @@ static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.inflight),
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2751,8 +2757,8 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.inflight),
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2851,8 +2857,7 @@ void vhost_user_async_close(DeviceState *d,
 
 static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
 {
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         return 0;
     }
 
@@ -2877,16 +2882,15 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
         return;
     }
 
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         vhost_user_set_status(dev, 0);
     }
 }
 
 static bool vhost_user_supports_device_state(struct vhost_dev *dev)
 {
-    return virtio_has_feature(dev->protocol_features,
-                              VHOST_USER_PROTOCOL_F_DEVICE_STATE);
+    return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_DEVICE_STATE);
 }
 
 static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
-- 
2.48.1


