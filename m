Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B427C36011
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQgd-0008RR-4i; Wed, 26 Mar 2025 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQgb-0008Q6-Rw
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1txQga-00070C-9x
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742995246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GMDLKVArVG1fcUKB+sYhePHWyGMH2kXaND/YejbAJk=;
 b=NEkNQd2TypKyALkUuC3JHfhk4y2Gxm8Qrza/zL32WbS1f+tKxhvd3IKMqaf6GdZZ8aQp3t
 bMSrfOm4532DuLqrO43f8EMJ2gNZg+70fExd3cQDurHyWRhYOSkaHYZCP6hoaVPvTBCcug
 y4Ctb903d/KlaI0jw93et1FiB2E8+n8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-QOmdSMj9MRGnkoL5bA0uGg-1; Wed,
 26 Mar 2025 09:20:45 -0400
X-MC-Unique: QOmdSMj9MRGnkoL5bA0uGg-1
X-Mimecast-MFC-AGG-ID: QOmdSMj9MRGnkoL5bA0uGg_1742995244
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ECA71933B48
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:20:43 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAE041956095; Wed, 26 Mar 2025 13:20:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 2/4] virtio_net: Add the check for vdpa's mac address
Date: Wed, 26 Mar 2025 21:19:31 +0800
Message-ID: <20250326132021.1215568-3-lulu@redhat.com>
In-Reply-To: <20250326132021.1215568-1-lulu@redhat.com>
References: <20250326132021.1215568-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index de87cfadff..a3b431e000 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3749,12 +3749,43 @@ static bool failover_hide_primary_device(DeviceListener *listener,
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
@@ -3862,6 +3893,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -3908,7 +3940,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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


