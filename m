Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D0DD5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f1s-0007Xv-45; Sat, 09 Nov 2024 01:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1q-0007XI-5Q
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1o-0001TS-Nd
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731133979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C23bQJG+w7eBnG9DkbQIapfoPSgTaqpmSilfkoSHNVQ=;
 b=LvclEtJTpcIrh+50kU2frE2Vb1J7EV8ePD/Hs5Gje2tWaOTGlKfbXu8kpfA4e+8oxRaZaW
 baZWvM6glLNaw9yJA+SG8vfABGAEayzEs0K3/sYyHqZZBRuoE30XH61jrIDVeHnWItARRP
 pA9gypkcaE23xy4NbfLetVEcYV788tA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Qi-9dOElNFKC7gi3VZ44Xg-1; Sat,
 09 Nov 2024 01:32:55 -0500
X-MC-Unique: Qi-9dOElNFKC7gi3VZ44Xg-1
X-Mimecast-MFC-AGG-ID: Qi-9dOElNFKC7gi3VZ44Xg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BDE119560AE
 for <qemu-devel@nongnu.org>; Sat,  9 Nov 2024 06:32:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85291195E480; Sat,  9 Nov 2024 06:32:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] vhost_vdpa : Add a new parameter to enable check mac
 address
Date: Sat,  9 Nov 2024 14:31:23 +0800
Message-ID: <20241109063241.1039433-2-lulu@redhat.com>
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

When using a VDPA device, it's important to ensure that the MAC
address is correctly set.
Add a new parameter in qemu cmdline to enable this check, default value
is false

The usage is:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,check-mac=true\
-device virtio-net-pci,netdev=vhost-vdpa0\
....

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h | 1 +
 net/vhost-vdpa.c  | 4 ++++
 qapi/net.json     | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0..fac1951b6e 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -112,6 +112,7 @@ struct NetClientState {
     bool is_netdev;
     bool do_not_pad; /* do not pad to the minimum ethernet frame length */
     bool is_datapath;
+    bool check_mac;
     QTAILQ_HEAD(, NetFilterState) filters;
 };
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 231b45246c..4826b2da97 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1859,6 +1859,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                                      iova_range, features, shared, errp);
         if (!ncs[i])
             goto err;
+
+        ncs[i]->check_mac = opts->check_mac;
     }
 
     if (has_cvq) {
@@ -1871,6 +1873,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                                  errp);
         if (!nc)
             goto err;
+
+        nc->check_mac = opts->check_mac;
     }
 
     return 0;
diff --git a/qapi/net.json b/qapi/net.json
index 2739a2f423..9a46aa61bd 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -510,6 +510,10 @@
 # @queues: number of queues to be created for multiqueue vhost-vdpa
 #     (default: 1)
 #
+# @check-mac: Enable the check for whether the device's MAC address
+#     and the MAC in QEMU command line are acceptable for booting.
+#     (default: false)
+#
 # @x-svq: Start device with (experimental) shadow virtqueue.  (Since
 #     7.1) (default: false)
 #
@@ -524,6 +528,7 @@
     '*vhostdev':     'str',
     '*vhostfd':      'str',
     '*queues':       'int',
+    '*check-mac':    'bool',
     '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
 
 ##
-- 
2.45.0


