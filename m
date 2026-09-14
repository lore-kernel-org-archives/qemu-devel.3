Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B3AC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ass-0004wd-2P; Mon, 14 Sep 2026 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6Asf-0004vA-0e
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6AsX-0000Im-Gi
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1d16:0:640:f28c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 5F922C0AD5;
 Mon, 14 Sep 2026 20:53:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:a2b::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rrX9s30iEKo0-ywIJsNmr; Mon, 14 Sep 2026 20:53:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789408437;
 bh=6go+1Xcg8Pl3hrmsUD3GeF4Vmhuk1XeJThFFcM2XAOA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NdVPFl1PFy3vnHOR3sY7fw0UZimyIs6A10JF6/raOjkvJqveD2fYoYIiW/T7hMQSO
 /AlvyyO5MvX+PnLIatW0UAW0snwu8JixBUUDC3BCYfXpmzsBu4pkKvyVGOUyVgGJRE
 q1nXsh3OCx5xsWAhx4pOJmKZbJqlpUjOCtqI8jRE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 3/5] hw/net: finish backend initialization earler for local
 migration
Date: Mon, 14 Sep 2026 20:53:49 +0300
Message-ID: <20260914175351.393680-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914175351.393680-1-vsementsov@yandex-team.ru>
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Thanks to pririty, backend is migrated before the virtio-net itself.
So we can finish the releate initialization already in .pre_load,
not postponing it to .post_load.

Fixes: bb71b1bffe58df "virtio-net: support local migration of backend"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 19f453fb7df..4794496b964 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3250,13 +3250,28 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
+static bool virtio_net_pre_load_device(void *opaque, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    if (n->peers_wait_incoming) {
+        /* MIG_PRI_BACKEND ensures the peers have already been loaded. */
+        n->peers_wait_incoming = false;
+        peer_test_vnet_hdr(n);
+        virtio_net_get_features(vdev, vdev->host_features_ex, errp);
+    }
+
+    return !*errp;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
     bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
-    Error *local_err = NULL;
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
@@ -3314,20 +3329,6 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
-
-    /*
-     * If live-migration is enabled for some backend, than backend
-     * has already been migrated at higher priority (MIG_PRI_BACKEND)
-     * and virtio_net_vnet_post_load() has already called
-     * peer_test_vnet_hdr().  Recompute host_features so that virtio-net
-     * reflects the capabilities of the restored backend.
-     */
-    virtio_net_get_features(vdev, &vdev->host_features, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -EINVAL;
-    }
-
     return 0;
 }
 
@@ -3478,14 +3479,6 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
-    /*
-     * If live-migration is enabled for some backend, than backend
-     * has already been migrated at higher priority (MIG_PRI_BACKEND),
-     * so n->has_vnet_hdr can be refreshed from the live backend right
-     * here.
-     */
-    peer_test_vnet_hdr(tmp->parent);
-
     if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
         error_report("virtio-net: saved image requires vnet_hdr=on");
         return -EINVAL;
@@ -3674,6 +3667,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .pre_load_errp = virtio_net_pre_load_device,
     .post_load = virtio_net_post_load_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
-- 
2.43.0


