Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A55C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0Zt-0002IK-5I; Mon, 08 Jul 2024 22:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR0Zr-0002Hp-Tj
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sR0Zq-0000Ra-7S
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720492051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gvi+Fzbmkqp0o66XfH2AQrFZSd8YQeaB51jk5qbux7E=;
 b=FCU5B/CfbjacfGqfdgFAaZMotTIsbvVROsaR+f+r4MoqZ+g1G1O5+okSJjSPFzwF6/A5ul
 LPquTkSewEM77A0nm16FTle0A1jOZitdM90KrL+KeV3JZnaU/0gQ0QnSWs5Y3HzdjS7hk3
 kpDbUv0OatYEMgKZn18OKd9b0Haf1c4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-CE5yISMYPlK3Ks91fPvP3A-1; Mon,
 08 Jul 2024 22:27:30 -0400
X-MC-Unique: CE5yISMYPlK3Ks91fPvP3A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF3031955F3B; Tue,  9 Jul 2024 02:27:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B8731955F66; Tue,  9 Jul 2024 02:27:19 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com, qemu-devel@nongnu.org
Subject: [RFC] virtio-net: check the mac address for vdpa device
Date: Tue,  9 Jul 2024 10:27:07 +0800
Message-ID: <20240709022707.579474-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When using VDPA device, we should verify whether the MAC address in the
hardware matches the MAC address from the QEMU command line. If not,
we will need to update the related information.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..db04331b82 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc->rxfilter_notify_enabled = 1;
 
    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        struct virtio_net_config netcfg = {};
-        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
-        vhost_net_set_config(get_vhost_net(nc->peer),
-            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
+     struct virtio_net_config netcfg = {};
+     static const MACAddr zero = {.a = {0, 0, 0, 0, 0, 0}};
+     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
+                          ETH_ALEN);
+     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAddr)) != 0) &&
+         memcmp(&netcfg.mac, &zero, sizeof(zero) != 0)) {
+       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
+       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
+     }
+     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg, 0,
+                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
     }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
-- 
2.45.0


