Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE7EC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yw9-0004Z7-9u; Fri, 11 Sep 2026 06:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yvx-0004WE-0O; Fri, 11 Sep 2026 06:56:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4yvu-0003CT-JV; Fri, 11 Sep 2026 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789124162; bh=WA+3nlkepq+aZOxTW85cJBlOrW3GGvA+ikUW6COdVzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PaL1GgG3QL6t4BXcv+0yL7h2rovPxS8zm7okWhXAij2d6DF89jyilZKclmzaIfDFO
 uyIlBD+AuYs5whVzhHmqmxDsYMwlghRM+Z2ihD+1ciAV9xZ0PUu1KuHark3xrUdKZj
 gl3jh770wwg87HOQo3wt0l04SwWElFneN1Lb4+pKEAYPG6NBHmDUtkleNY3eKk9IOt
 P+PMVgSqsfl0b3cSOdLfPU8V2K/ge2IJ0oxoJjdvdZLFP/fFNnbMuJjVqTQfuZeF+e
 P4tp7gUIVnMQSmfTfusnLoafUKWsmjG1Oovb8ufAk5QHiY0w8DKG+5qqXGLy017brm
 jmKxz6PKLCV7g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE1D81D3B83;
 Fri, 11 Sep 2026 13:56:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B73E9425DFA;
 Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A4EBE40F0B; Fri, 11 Sep 2026 13:56:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Rohitashv Kumar <roohiit@amazon.de>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/4] qapi/net: gate user/vde/netmap netdev backends behind
 their CONFIG symbols
Date: Fri, 11 Sep 2026 13:56:29 +0300
Message-ID: <20260911105635.955937-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911105635.955937-1-mjt@tls.msk.ru>
References: <20260911105635.955937-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

Their NetClientDriver enum members and Netdev union branches were
unconditional, so query-qmp-schema advertised them even when built without
CONFIG_SLIRP/CONFIG_VDE/CONFIG_NETMAP. Gate them, and guard the matching
NET_CLIENT_DRIVER_USER/_VDE case labels in net/hub.c.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/hub.c     |  4 ++++
 qapi/net.json | 19 +++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/hub.c b/net/hub.c
index b53a4cc872c..1d1710a198b 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -299,12 +299,16 @@ void net_hub_check_clients(void)
 #ifdef CONFIG_PASST
             case NET_CLIENT_DRIVER_PASST:
 #endif
+#ifdef CONFIG_SLIRP
             case NET_CLIENT_DRIVER_USER:
+#endif
             case NET_CLIENT_DRIVER_TAP:
             case NET_CLIENT_DRIVER_SOCKET:
             case NET_CLIENT_DRIVER_STREAM:
             case NET_CLIENT_DRIVER_DGRAM:
+#ifdef CONFIG_VDE
             case NET_CLIENT_DRIVER_VDE:
+#endif
             case NET_CLIENT_DRIVER_VHOST_USER:
                 has_host_dev = 1;
                 break;
diff --git a/qapi/net.json b/qapi/net.json
index 85c78710fe8..bb626005a82 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -922,9 +922,13 @@
 # Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
-  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
-            'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
-            'vhost-vdpa',
+  'data': [ 'none', 'nic',
+            { 'name': 'user', 'if': 'CONFIG_SLIRP' },
+            'tap', 'l2tpv3', 'socket', 'stream', 'dgram',
+            { 'name': 'vde', 'if': 'CONFIG_VDE' },
+            'bridge', 'hubport',
+            { 'name': 'netmap', 'if': 'CONFIG_NETMAP' },
+            'vhost-user', 'vhost-vdpa',
             { 'name': 'passt', 'if': 'CONFIG_PASST' },
             { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
             { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
@@ -949,16 +953,19 @@
     'nic':      'NetLegacyNicOptions',
     'passt':    { 'type': 'NetdevPasstOptions',
                   'if': 'CONFIG_PASST' },
-    'user':     'NetdevUserOptions',
+    'user':     { 'type': 'NetdevUserOptions',
+                  'if': 'CONFIG_SLIRP' },
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
     'socket':   'NetdevSocketOptions',
     'stream':   'NetdevStreamOptions',
     'dgram':    'NetdevDgramOptions',
-    'vde':      'NetdevVdeOptions',
+    'vde':      { 'type': 'NetdevVdeOptions',
+                  'if': 'CONFIG_VDE' },
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
-    'netmap':   'NetdevNetmapOptions',
+    'netmap':   { 'type': 'NetdevNetmapOptions',
+                  'if': 'CONFIG_NETMAP' },
     'af-xdp':   { 'type': 'NetdevAFXDPOptions',
                   'if': 'CONFIG_AF_XDP' },
     'vhost-user': 'NetdevVhostUserOptions',
-- 
2.47.3


