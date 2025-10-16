Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DE7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MMr-00078Q-MW; Thu, 16 Oct 2025 07:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMX-00074f-OK; Thu, 16 Oct 2025 07:41:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMQ-0003Ta-16; Thu, 16 Oct 2025 07:41:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E6E48C01C7;
 Thu, 16 Oct 2025 14:41:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-ehkGRQYn; Thu, 16 Oct 2025 14:41:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614888;
 bh=4rS5GwKjIvlDX1eshLc4ZTaaWpM9BPePyTr5g8fR2nE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZxvaYQe2l/ECS6bCdiFwdBkT1icqfbUOvLZwVEcEU6vm/SJx/gkhP6jwRW1R3fmpl
 wy5/3mn/UKNBgILAGNDD40PvPZ7JX5vcrOtoSx8Cu6RsPBfFgVZPPd4+QKWJAhrc1X
 Cj3UYvBKncrxqW2jWUrbqABgM24rp+Wk1FGXMuQU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 06/25] vhost-user: support connect api
Date: Thu, 16 Oct 2025 14:40:43 +0300
Message-ID: <20251016114104.1384675-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
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

Memory allocation and connecting of structures remain ins _init(),
communication with backend goes to _connect().

We need this for further support of backend-transfer migration of
vhost-user-blk, as we'll need to postpone (or not do) initial
communication to backend.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e45b74eddd..c5cb5ed528 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2270,21 +2270,12 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
-                                   Error **errp)
+static int vhost_user_backend_connect(struct vhost_dev *dev, Error **errp)
 {
     uint64_t features, ram_slots;
-    struct vhost_user *u;
-    VhostUserState *vus = (VhostUserState *) opaque;
+    struct vhost_user *u = dev->opaque;
     int err;
 
-    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
-
-    u = g_new0(struct vhost_user, 1);
-    u->user = vus;
-    u->dev = dev;
-    dev->opaque = u;
-
     err = vhost_user_get_features(dev, &features);
     if (err < 0) {
         error_setg_errno(errp, -err, "vhost_backend_init failed");
@@ -2292,7 +2283,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     }
 
     if (virtio_has_feature(features, VHOST_USER_F_PROTOCOL_FEATURES)) {
-        bool supports_f_config = vus->supports_config ||
+        bool supports_f_config = u->user->supports_config ||
             (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
         uint64_t protocol_features;
 
@@ -2408,6 +2399,22 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     return 0;
 }
 
+static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
+                                   Error **errp)
+{
+    struct vhost_user *u;
+    VhostUserState *vus = (VhostUserState *) opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    u = g_new0(struct vhost_user, 1);
+    u->user = vus;
+    u->dev = dev;
+    dev->opaque = u;
+
+    return 0;
+}
+
 static int vhost_user_backend_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
@@ -3133,6 +3140,7 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
+        .vhost_backend_connect = vhost_user_backend_connect,
         .vhost_backend_cleanup = vhost_user_backend_cleanup,
         .vhost_backend_memslots_limit = vhost_user_memslots_limit,
         .vhost_backend_no_private_memslots = vhost_user_no_private_memslots,
-- 
2.48.1


