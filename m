Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC28C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlSR-0006XB-LJ; Thu, 23 Jul 2026 00:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlSP-0006St-Qr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlSN-00056h-P2
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6kt5HzL/dcb4GOtdYVxgWwilYqwRVX6SLi3+dLQtEE=;
 b=O+BUXRiQWKxdfJpbgE4iEvDMVBC7oP0olSE9d2nQzmsZXjVHuE8yZ6tQC1NgC0LPGecbIB
 MwHKuMMOt/oF4HAryC3Xe2cag2PhP6Jhb6eI7sshd3IpbfQh8vxTEtWhrT8R23kkSe/lt6
 hhiOm5GxjSv4JPy3JclZxec9ZJU12gY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-LODP7NitOBe99UrCJyb4Mw-1; Thu,
 23 Jul 2026 00:54:45 -0400
X-MC-Unique: LODP7NitOBe99UrCJyb4Mw-1
X-Mimecast-MFC-AGG-ID: LODP7NitOBe99UrCJyb4Mw_1784782482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5754118E6A73; Thu, 23 Jul 2026 04:54:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87386180029D; Thu, 23 Jul 2026 04:54:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 39/44] qapi: convert trivial intro sections for net.json
Date: Thu, 23 Jul 2026 00:48:00 -0400
Message-ID: <20260723044805.527643-40-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/net.json | 101 ++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 64 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c5..7aabd8b9260 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -12,8 +12,7 @@
 
 ##
 # @set_link:
-#
-# Sets the link status of a virtual network adapter.
+#     Sets the link status of a virtual network adapter.
 #
 # @name: the device name of the virtual network adapter
 #
@@ -60,8 +59,7 @@
 
 ##
 # @netdev_del:
-#
-# Remove a network backend.
+#     Remove a network backend.
 #
 # @id: the name of the network backend to remove
 #
@@ -80,8 +78,7 @@
 
 ##
 # @NetLegacyNicOptions:
-#
-# Create a new Network Interface Card.
+#     Create a new Network Interface Card.
 #
 # @netdev: id of -netdev to connect to
 #
@@ -140,8 +137,7 @@
 
 ##
 # @NetdevPasstOptions:
-#
-# Unprivileged user-mode network connectivity using passt
+#     Unprivileged user-mode network connectivity using passt
 #
 # @path: Filename of the passt program to run (by default 'passt', and
 #     use PATH)
@@ -301,9 +297,8 @@
 
 ##
 # @NetdevUserOptions:
-#
-# Use the user mode network stack which requires no administrator
-# privilege to run.
+#     Use the user mode network stack which requires no administrator
+#     privilege to run.
 #
 # @hostname: client hostname reported by the builtin DHCP server
 #
@@ -389,8 +384,7 @@
 
 ##
 # @NetdevTapOptions:
-#
-# Used to configure a host TAP network interface backend.
+#     Used to configure a host TAP network interface backend.
 #
 # @ifname: interface name
 #
@@ -447,9 +441,8 @@
 
 ##
 # @NetdevSocketOptions:
-#
-# Socket netdevs are used to establish a network connection to another
-# QEMU virtual machine via a TCP socket.
+#     Socket netdevs are used to establish a network connection to
+#     another QEMU virtual machine via a TCP socket.
 #
 # @fd: file descriptor of an already opened socket
 #
@@ -476,8 +469,7 @@
 
 ##
 # @NetdevL2TPv3Options:
-#
-# Configure an Ethernet over L2TPv3 tunnel.
+#     Configure an Ethernet over L2TPv3 tunnel.
 #
 # @src: source address
 #
@@ -531,8 +523,7 @@
 
 ##
 # @NetdevVdeOptions:
-#
-# Connect to a vde switch running on the host.
+#     Connect to a vde switch running on the host.
 #
 # @sock: socket path
 #
@@ -553,8 +544,7 @@
 
 ##
 # @NetdevBridgeOptions:
-#
-# Connect a host TAP network interface to a host bridge device.
+#     Connect a host TAP network interface to a host bridge device.
 #
 # @br: bridge name
 #
@@ -569,8 +559,7 @@
 
 ##
 # @NetdevHubPortOptions:
-#
-# Connect two or more net clients through a software hub.
+#     Connect two or more net clients through a software hub.
 #
 # @hubid: hub identifier number
 #
@@ -586,8 +575,8 @@
 
 ##
 # @NetdevNetmapOptions:
-#
-# Connect a client to a netmap-enabled NIC or to a VALE switch port
+#     Connect a client to a netmap-enabled NIC or to a VALE switch
+#     port
 #
 # @ifname: Either the name of an existing network interface supported
 #     by netmap, or the name of a VALE port (created on the fly).  A
@@ -607,8 +596,7 @@
 
 ##
 # @AFXDPMode:
-#
-# Attach mode for a default XDP program
+#     Attach mode for a default XDP program
 #
 # @skb: generic mode, no driver support necessary
 #
@@ -623,8 +611,7 @@
 
 ##
 # @NetdevAFXDPOptions:
-#
-# AF_XDP network backend
+#     AF_XDP network backend
 #
 # @ifname: The name of an existing network interface.
 #
@@ -675,8 +662,7 @@
 
 ##
 # @NetdevVhostUserOptions:
-#
-# Vhost-user network backend
+#     Vhost-user network backend
 #
 # @chardev: name of a unix socket chardev
 #
@@ -836,8 +822,7 @@
 
 ##
 # @NetdevStreamOptions:
-#
-# Configuration info for stream socket netdev
+#     Configuration info for stream socket netdev
 #
 # @addr: socket address to listen on (server=true) or connect to
 #     (server=false)
@@ -861,8 +846,7 @@
 
 ##
 # @NetdevDgramOptions:
-#
-# Configuration info for datagram socket netdev.
+#     Configuration info for datagram socket netdev.
 #
 # @remote: remote address
 #
@@ -898,8 +882,7 @@
 
 ##
 # @NetClientDriver:
-#
-# Available netdev drivers.
+#     Available netdev drivers.
 #
 # @l2tpv3: since 2.1
 #
@@ -933,8 +916,7 @@
 
 ##
 # @Netdev:
-#
-# Captures the configuration of a network device.
+#     Captures the configuration of a network device.
 #
 # @id: identifier for monitor commands.
 #
@@ -972,8 +954,7 @@
 
 ##
 # @RxState:
-#
-# Packets receiving state
+#     Packets receiving state
 #
 # @normal: filter assigned packets according to the mac-table
 #
@@ -987,8 +968,7 @@
 
 ##
 # @RxFilterInfo:
-#
-# Rx-filter information for a NIC.
+#     Rx-filter information for a NIC.
 #
 # @name: net client name
 #
@@ -1033,8 +1013,8 @@
 
 ##
 # @query-rx-filter:
-#
-# Return rx-filter information for all NICs (or for the given NIC).
+#     Return rx-filter information for all NICs (or for the given
+#     NIC).
 #
 # @name: net client name
 #
@@ -1082,9 +1062,8 @@
 
 ##
 # @NIC_RX_FILTER_CHANGED:
-#
-# Emitted once until the `query-rx-filter` command is executed, the
-# first event will always be emitted
+#     Emitted once until the `query-rx-filter` command is executed,
+#     the first event will always be emitted
 #
 # @name: net client name
 #
@@ -1104,8 +1083,7 @@
 
 ##
 # @AnnounceParameters:
-#
-# Parameters for self-announce timers
+#     Parameters for self-announce timers
 #
 # @initial: Initial delay (in ms) before sending the first GARP/RARP
 #     announcement
@@ -1157,11 +1135,10 @@
 
 ##
 # @FAILOVER_NEGOTIATED:
-#
-# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature
-# negotiation.  Failover primary devices which were hidden (not
-# hotplugged when requested) before will now be hotplugged by the
-# virtio-net standby device.
+#     Emitted when VIRTIO_NET_F_STANDBY was enabled during feature
+#     negotiation.  Failover primary devices which were hidden (not
+#     hotplugged when requested) before will now be hotplugged by the
+#     virtio-net standby device.
 #
 # @device-id: QEMU device id of the unplugged device
 #
@@ -1178,8 +1155,7 @@
 
 ##
 # @NETDEV_STREAM_CONNECTED:
-#
-# Emitted when the netdev stream backend is connected
+#     Emitted when the netdev stream backend is connected
 #
 # @netdev-id: QEMU netdev id that is connected
 #
@@ -1208,8 +1184,7 @@
 
 ##
 # @NETDEV_STREAM_DISCONNECTED:
-#
-# Emitted when the netdev stream backend is disconnected
+#     Emitted when the netdev stream backend is disconnected
 #
 # @netdev-id: QEMU netdev id that is disconnected
 #
@@ -1226,8 +1201,7 @@
 
 ##
 # @NETDEV_VHOST_USER_CONNECTED:
-#
-# Emitted when the vhost-user chardev is connected
+#     Emitted when the vhost-user chardev is connected
 #
 # @netdev-id: QEMU netdev id that is connected
 #
@@ -1246,8 +1220,7 @@
 
 ##
 # @NETDEV_VHOST_USER_DISCONNECTED:
-#
-# Emitted when the vhost-user chardev is disconnected
+#     Emitted when the vhost-user chardev is disconnected
 #
 # @netdev-id: QEMU netdev id that is disconnected
 #
-- 
2.55.0


