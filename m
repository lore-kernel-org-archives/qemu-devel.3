Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A7D64075
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f1t-0007YX-8T; Sat, 09 Nov 2024 01:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1r-0007Xe-Ty
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1q-0001TX-BR
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731133980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8z9wo9GjSCi2vpRA4wJX7bcmkka5LZmLGi5vdzojx0=;
 b=bOtb/O4yItMmOwKNnrzRRl/DhGxds0127NqnoY0e2w+hhK5gGI7oXIFZHzPNHINZVpf3rk
 PIvSPjIj7ZUrsIYFHQoNy5tPfnxkJfSce3oX+sfbaDoApYR3zLiiKh//OOUQI3FAUygqlr
 C3JQD8wm2Xa8Ns0U8Vh5SubmycfmQ3k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-bLe7SrhCMWKHmFaF7siUfw-1; Sat,
 09 Nov 2024 01:32:59 -0500
X-MC-Unique: bLe7SrhCMWKHmFaF7siUfw-1
X-Mimecast-MFC-AGG-ID: bLe7SrhCMWKHmFaF7siUfw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E3F1956096
 for <qemu-devel@nongnu.org>; Sat,  9 Nov 2024 06:32:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23A47195E480; Sat,  9 Nov 2024 06:32:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] virtio_net: Add the check for vdpa's mac address
Date: Sat,  9 Nov 2024 14:31:24 +0800
Message-ID: <20241109063241.1039433-3-lulu@redhat.com>
In-Reply-To: <20241109063241.1039433-1-lulu@redhat.com>
References: <20241109063241.1039433-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
index f2104ed364..01cac20d92 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3594,12 +3594,43 @@ static bool failover_hide_primary_device(DeviceListener *listener,
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
@@ -3707,6 +3738,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -3753,7 +3785,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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


