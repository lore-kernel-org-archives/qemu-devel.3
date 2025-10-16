Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D77CCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MMx-0007A7-Ax; Thu, 16 Oct 2025 07:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMb-00075S-Qi; Thu, 16 Oct 2025 07:41:46 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMQ-0003TM-DP; Thu, 16 Oct 2025 07:41:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2093FC01C6;
 Thu, 16 Oct 2025 14:41:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-tJ9HppKJ; Thu, 16 Oct 2025 14:41:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614887;
 bh=NCBQBj1KLYl9rxemiXXzJo8O03ptUskg5oqIPqd6fMU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Gm2tYnLEYpgakuaZolY3N0OZpoTs2w0M/6wY6x3J5iIfQCOetsskp7V7cil59D4yn
 8jtLr5v7oO6E05J8MOsAt32f5t8RcZv9TnpjJl4JqUIq0P/PpPwqoLAUhFzCJaolDU
 KBGFI1aAss3Am78ApraFMhS+xqMpo+e4WX3wkjI4=
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
Subject: [PATCH v2 05/25] vhost: split vhost_dev_connect() out of
 vhost_dev_init()
Date: Thu, 16 Oct 2025 14:40:42 +0300
Message-ID: <20251016114104.1384675-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Split vhost_dev_init() so that the first part will do early
initialization of QEMU structures, but don't communicate with backend,
and the second part will do backend communication.

We need this for future support for backend-transfer migration support
for vhost-user-blk (backend will not be available in the early
initialization point).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c         | 27 +++++++++++++++++++++------
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f733e98b4a..09d00e4d98 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1619,7 +1619,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    bool connect, Error **errp)
 {
-    int i, r, n_initialized_vqs = 0;
+    int i, r;
 
     trace_vhost_dev_init_in(hdev);
 
@@ -1640,9 +1640,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
      */
     assert(connect || hdev->vhost_ops->vhost_backend_connect);
 
-    /* TDDO: support connect=false */
-    assert(connect);
-
     r = hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
     if (r < 0) {
         goto fail;
@@ -1678,6 +1675,26 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
+    trace_vhost_dev_init_out(hdev);
+
+    return connect ? vhost_dev_connect(hdev, errp) : 0;
+
+fail:
+    vhost_dev_cleanup(hdev);
+    return r;
+}
+
+int vhost_dev_connect(struct vhost_dev *hdev, Error **errp)
+{
+    int i, r, n_initialized_vqs = 0;
+
+    if (hdev->vhost_ops->vhost_backend_connect) {
+        r = hdev->vhost_ops->vhost_backend_connect(hdev, errp);
+        if (r < 0) {
+            goto fail;
+        }
+    }
+
     r = hdev->vhost_ops->vhost_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
@@ -1720,8 +1737,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    trace_vhost_dev_init_out(hdev);
-
     return 0;
 
 fail:
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 74ed24232e..af46d4b5f2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -158,6 +158,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    uint32_t busyloop_timeout,
                    bool connect, Error **errp);
 
+int vhost_dev_connect(struct vhost_dev *hdev, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
-- 
2.48.1


