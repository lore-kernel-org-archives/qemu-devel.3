Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67337CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MMp-00077q-DZ; Thu, 16 Oct 2025 07:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMW-00074e-T6; Thu, 16 Oct 2025 07:41:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMO-0003T9-4R; Thu, 16 Oct 2025 07:41:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 577A9C00CF;
 Thu, 16 Oct 2025 14:41:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-qM11FZnG; Thu, 16 Oct 2025 14:41:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614884;
 bh=oUrqGQn8nA2eMNAmO6zdAoCyWwMbaYpJ91T595m/zmU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=COUKJ3TvjuN+AO0dq37aSPxwgnWuDHk4szXMPRYQuiLLeoatWXNjg3E1g7JVWOFQT
 dhHi5V+/oPYun/F/yQ89Nnht2Ul0Hx+6Ke+nqlGL2aFw9y7oOYzOrkgqkOi+kdvEBY
 NtbgvB6pBxOQ4GHbhWsVnBzmSMB+K2r59fMn5tKY=
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
Subject: [PATCH v2 03/25] vhost: rework vhost_virtqueue_init()
Date: Thu, 16 Oct 2025 14:40:40 +0300
Message-ID: <20251016114104.1384675-4-vsementsov@yandex-team.ru>
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

We are going to split vhost_dev_init() so that the first part will do
early initialization of QEMU structures, but don't communicate with
backend, and the second part will do backend communication. We need
this for future support for backend-transfer migration support for
vhost-user-blk (backend will not be available in the early
initialization point).

With this commit, let's split vhost_virtqueue_init(). The whole function
is mostly about configuring the backend, so this logic will be postponed
until backend become available. The only thing to keep in early
initialization is attaching vhost_dev structure. Let's simply move it to
vhost_dev_init().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 551d1687fc..1998663461 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1500,9 +1500,9 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
     }
 }
 
-static int vhost_virtqueue_init(struct vhost_dev *dev,
-                                struct vhost_virtqueue *vq, int n)
+static int vhost_virtqueue_connect(struct vhost_virtqueue *vq, int n)
 {
+    struct vhost_dev *dev = vq->dev;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, n);
     struct vhost_vring_file file = {
         .index = vhost_vq_index,
@@ -1519,8 +1519,6 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
         goto fail_call;
     }
 
-    vq->dev = dev;
-
     if (dev->vhost_ops->vhost_set_vring_err) {
         r = event_notifier_init(&vq->error_notifier, 0);
         if (r < 0) {
@@ -1629,6 +1627,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->migration_blocker = NULL;
     hdev->busyloop_timeout = busyloop_timeout;
 
+    for (i = 0; i < hdev->nvqs; ++i) {
+        hdev->vqs[i].dev = hdev;
+    }
+
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
 
@@ -1680,7 +1682,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
-        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
+        r = vhost_virtqueue_connect(hdev->vqs + i, hdev->vq_index + i);
         if (r < 0) {
             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
             goto fail;
-- 
2.48.1


