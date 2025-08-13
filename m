Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4408BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfy-00031P-B8; Wed, 13 Aug 2025 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfX-0002ht-Bz; Wed, 13 Aug 2025 12:49:44 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfG-0007r7-B2; Wed, 13 Aug 2025 12:49:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 35BDA8126C;
 Wed, 13 Aug 2025 19:49:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-pC4CY3Sq; Wed, 13 Aug 2025 19:49:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103756;
 bh=6mQD+E56AliUFR85mWNTx1RcVkaifnsIXZcOryL08do=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QMU/bscdy7Wbc4jjTwkYSVHiah6+xtqFIJxlFwAwrmsKpZwztpygzQvhKq6e5EofY
 YyS8ss3aF+zVmZNCX2SFfIP5N+VE94ADKGV9LXL2lYTAvc3er4763Cv6skfd9Fj0Vg
 XSd63L9EzGdpJDfA8P/lQeHDthv0X7zjWHYg3h0w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 18/33] vhost: introduce check_memslots() helper
Date: Wed, 13 Aug 2025 19:48:39 +0300
Message-ID: <20250813164856.950363-19-vsementsov@yandex-team.ru>
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
 hw/virtio/vhost.c | 71 ++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a8f8b85012..f9163ba895 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1553,11 +1553,49 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
+static bool check_memslots(struct vhost_dev *hdev, Error **errp)
+{
+    unsigned int used, reserved, limit;
+
+    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
+        memory_devices_memslot_auto_decision_active()) {
+        error_setg(errp, "some memory device (like virtio-mem)"
+            " decided how many memory slots to use based on the overall"
+            " number of memory slots; this vhost backend would further"
+            " restricts the overall number of memory slots");
+        error_append_hint(errp, "Try plugging this vhost backend before"
+            " plugging such memory devices.\n");
+        return false;
+    }
+
+    /*
+     * The listener we registered properly setup the number of required
+     * memslots in vhost_commit().
+     */
+    used = hdev->mem->nregions;
+
+    /*
+     * We assume that all reserved memslots actually require a real memslot
+     * in our vhost backend. This might not be true, for example, if the
+     * memslot would be ROM. If ever relevant, we can optimize for that --
+     * but we'll need additional information about the reservations.
+     */
+    reserved = memory_devices_get_reserved_memslots();
+    if (used + reserved > limit) {
+        error_setg(errp, "vhost backend memory slots limit (%d) is less"
+                   " than current number of used (%d) and reserved (%d)"
+                   " memory slots for memory devices.", limit, used, reserved);
+        return false;
+    }
+
+    return true;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    unsigned int used, reserved, limit;
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
 
@@ -1584,19 +1622,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
-        memory_devices_memslot_auto_decision_active()) {
-        error_setg(errp, "some memory device (like virtio-mem)"
-            " decided how many memory slots to use based on the overall"
-            " number of memory slots; this vhost backend would further"
-            " restricts the overall number of memory slots");
-        error_append_hint(errp, "Try plugging this vhost backend before"
-            " plugging such memory devices.\n");
-        r = -EINVAL;
-        goto fail;
-    }
-
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
         r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
                                  busyloop_timeout);
@@ -1655,23 +1680,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
-    /*
-     * The listener we registered properly setup the number of required
-     * memslots in vhost_commit().
-     */
-    used = hdev->mem->nregions;
-
-    /*
-     * We assume that all reserved memslots actually require a real memslot
-     * in our vhost backend. This might not be true, for example, if the
-     * memslot would be ROM. If ever relevant, we can optimize for that --
-     * but we'll need additional information about the reservations.
-     */
-    reserved = memory_devices_get_reserved_memslots();
-    if (used + reserved > limit) {
-        error_setg(errp, "vhost backend memory slots limit (%d) is less"
-                   " than current number of used (%d) and reserved (%d)"
-                   " memory slots for memory devices.", limit, used, reserved);
+    if (!check_memslots(hdev, errp)) {
         r = -EINVAL;
         goto fail;
     }
-- 
2.48.1


