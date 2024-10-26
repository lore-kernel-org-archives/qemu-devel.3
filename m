Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F6AD10BE8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 08:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bk1-0003ub-Vg; Sat, 26 Oct 2024 04:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjx-0003tK-AD
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjv-0000ir-RO
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729929698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/2ZqJB5iSeur9t5e5e22DREcGHAeMkvdV511PkZJ7s=;
 b=NBNCwqgsaymI6mrbE10C2aRveqIrVh6JLXS9KGVbuxcildx/NCxZ1dxN+y/oleo2ZaDhrn
 p+avKDU3x9tpCyhWP8TFWDJmM+yUkU8N4Mfccjj9BcGpWqu//fronX+z2k1Qe6xZOtPkzZ
 EwmcpqUvBLqWWgHtTnjQRkMUOE14C6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-fOOePJIWM7O3MDutQFKY4w-1; Sat,
 26 Oct 2024 04:01:35 -0400
X-MC-Unique: fOOePJIWM7O3MDutQFKY4w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92665195608B
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:01:34 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A5FF1956056; Sat, 26 Oct 2024 08:01:31 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] virtio_net: Add the check for vdpa's mac address
Date: Sat, 26 Oct 2024 16:00:00 +0800
Message-ID: <20241026080121.461781-3-lulu@redhat.com>
In-Reply-To: <20241026080121.461781-1-lulu@redhat.com>
References: <20241026080121.461781-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When using a VDPA device, it is important to ensure that the MAC
address is correctly set. The MAC address in the hardware should
match the MAC address from the QEMU command line. This is a recommended
configuration and will allow the system to boot.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index fb84d142ee..0b342d0cc2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3589,12 +3589,43 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     /* failover_primary_hidden is set during feature negotiation */
     return qatomic_read(&n->failover_primary_hidden);
 }
+static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
+                                      MACAddr *cmdline_mac, Error **errp)
+{
+    struct virtio_net_config hwcfg = {};
+    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
+
+    vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_ALEN);
+
+    /*For VDPA device following situations are acceptable:*/
+
+    if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) != 0) {
+        /*
+         * 1.The hardware MAC address is the same as the QEMU command line MAC
+         *   address, and both of them are not 0.
+         */
+        if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
+            return true;
+        }
+    }
 
+    error_setg(errp,
+               "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
+               "not same with the cmdline's mac %02x:%02x:%02x:%02x:%02x:%02x,"
+               "Please check.",
+               hwcfg.mac[0], hwcfg.mac[1], hwcfg.mac[2], hwcfg.mac[3],
+               hwcfg.mac[4], hwcfg.mac[5], cmdline_mac->a[0], cmdline_mac->a[1],
+               cmdline_mac->a[2], cmdline_mac->a[3], cmdline_mac->a[4],
+               cmdline_mac->a[5]);
+
+    return false;
+}
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     NetClientState *nc;
+    MACAddr macaddr_cmdline;
     int i;
 
     if (n->net_conf.mtu) {
@@ -3702,6 +3733,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -3748,7 +3780,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
-   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+    if (nc->peer && (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA)) {
+        if (nc->peer->check_mac) {
+            if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
+                virtio_cleanup(vdev);
+                return;
+            }
+        }
         struct virtio_net_config netcfg = {};
         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
         vhost_net_set_config(get_vhost_net(nc->peer),
-- 
2.45.0


