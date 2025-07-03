Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9A4C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJOB-00085A-Nj; Thu, 03 Jul 2025 08:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLm-0005lQ-MG; Thu, 03 Jul 2025 08:47:39 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLf-0006np-4T; Thu, 03 Jul 2025 08:47:37 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a1:0:640:2691:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 17C5660CD1;
 Thu,  3 Jul 2025 15:47:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:73d::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HlbMgQ0FgSw0-B6MCEwG0; Thu, 03 Jul 2025 15:47:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751546839;
 bh=F84/vf+slKCAI1XpqnU8oxnofrZpTBeaYgujwpNDFAw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YvcDsdkL0SE1IibwRdN5G3Vd22hJYZi5aW/d32fkKqbuPI0yICK0yzZuFnj5AAk9b
 G34I1XhhPaeWmN9brSmsWWRnOBJ8JJf4QxiE+GRzl2W0e5hUTpEdVqpj+hAujecIvJ
 A401lN/zoJ7jmjyM0tTGJ8HYcAskdVn3fiMwaXwc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: qemu-block@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 jasowang@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, raphael@enfabrica.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/4] vhost-user: stop use backend_features
Date: Thu,  3 Jul 2025 15:47:10 +0300
Message-ID: <20250703124713.2530079-3-vsementsov@yandex-team.ru>
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

Simply use features instead, we have same flag here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1b2879a90cc..cf6f53801db 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1232,7 +1232,7 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
 
 static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
 {
-    return virtio_has_feature(dev->backend_features,
+    return virtio_has_feature(dev->features,
                               VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
@@ -1449,14 +1449,15 @@ static int vhost_user_set_features(struct vhost_dev *dev,
     int ret;
 
     /*
-     * We need to include any extra backend only feature bits that
-     * might be needed by our device. Currently this includes the
-     * VHOST_USER_F_PROTOCOL_FEATURES bit for enabling protocol
-     * features.
+     * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
+     * specific.
      */
-    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES,
-                              features | dev->backend_features,
-                              log_enabled);
+    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+        features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+    }
+
+    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
+                             log_enabled);
 
     if (virtio_has_feature(dev->protocol_features,
                            VHOST_USER_PROTOCOL_F_STATUS)) {
@@ -2187,8 +2188,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
         uint64_t protocol_features;
 
-        dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
-
         err = vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES,
                                  &protocol_features);
         if (err < 0) {
-- 
2.48.1


