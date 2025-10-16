Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF2CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MMi-00076J-GR; Thu, 16 Oct 2025 07:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMU-00074M-5Q; Thu, 16 Oct 2025 07:41:38 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMP-0003T5-3e; Thu, 16 Oct 2025 07:41:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A7E4CC01BE;
 Thu, 16 Oct 2025 14:41:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-BlswLnpY; Thu, 16 Oct 2025 14:41:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614884;
 bh=/c9vHUY6t9wfX6BiEAXJfYRSmsDMfiIQQ+vKZjiVzb0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=MafyoRUcLEbYcdoJ+sEz3cvhWuIXSu+2B6TXBp1MEhbJBG4eiapp4lN1KGFgoNsxo
 4LT5CrmsXyJ02ntsF1j6o/pEJd5VbnFpUMm6+2kvrCUZskSlnumNwLD3mibuQM4jTm
 J1heqg+91rRWAn61Xw5ilmB5TxQ/EEOetpeWVZl4=
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
Subject: [PATCH v2 02/25] vhost: reorder logic in vhost_dev_init()
Date: Thu, 16 Oct 2025 14:40:39 +0300
Message-ID: <20251016114104.1384675-3-vsementsov@yandex-team.ru>
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

With this commit, we simply reorder the logic in vhost_dev_init()
in accordance with idea of further split.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9fc6e7ba65..551d1687fc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1637,26 +1637,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_set_owner failed");
-        goto fail;
-    }
-
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
-    for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
-        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
-        if (r < 0) {
-            error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
-            goto fail;
-        }
-    }
-
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
         .begin = vhost_begin,
@@ -1677,6 +1657,36 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .region_del = vhost_iommu_region_del,
     };
 
+    hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
+    hdev->n_mem_sections = 0;
+    hdev->mem_sections = NULL;
+    hdev->log = NULL;
+    hdev->log_size = 0;
+    hdev->log_enabled = false;
+    hdev->started = false;
+    memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
+
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_set_owner failed");
+        goto fail;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        goto fail;
+    }
+
+    for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
+        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
+        if (r < 0) {
+            error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
+            goto fail;
+        }
+    }
+
     if (hdev->migration_blocker == NULL) {
         if (!vhost_dev_has_feature_ex(hdev, VHOST_F_LOG_ALL)) {
             error_setg(&hdev->migration_blocker,
@@ -1694,16 +1704,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
-    hdev->n_mem_sections = 0;
-    hdev->mem_sections = NULL;
-    hdev->log = NULL;
-    hdev->log_size = 0;
-    hdev->log_enabled = false;
-    hdev->started = false;
-    memory_listener_register(&hdev->memory_listener, &address_space_memory);
-    QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
-
     if (!check_memslots(hdev, errp)) {
         r = -EINVAL;
         goto fail;
-- 
2.48.1


