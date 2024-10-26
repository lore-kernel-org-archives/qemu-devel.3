Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D47D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 08:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bju-0003t3-Mp; Sat, 26 Oct 2024 04:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjt-0003ss-9o
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjr-0000iG-Ug
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729929694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffucPo4rILqxVbsa3TwhxlnE5gtEFDYiQYy5A7qhXqw=;
 b=XmBO+sD0nKa2jWGhc/Cq2C35apF807I9paNWX6srq/n3AWx4pzHhhimRVYwm58cKzbN1s9
 cOKSge9yVth157gWhj8LGbIJOb9WBlvBcNLf5EESZyn5JFKcuyM4ACYhwAtCSoIzGFi0yz
 hNqOMC70CZAgosWkCsr68yQyu2ILtdA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-_4zbh9h6Op-jjDxf3tTyRw-1; Sat,
 26 Oct 2024 04:01:33 -0400
X-MC-Unique: _4zbh9h6Op-jjDxf3tTyRw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563E71955EE7
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:01:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7747319560A3; Sat, 26 Oct 2024 08:01:27 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] vhost_vdpa : Add a new parameter to enable check mac
 address
Date: Sat, 26 Oct 2024 15:59:59 +0800
Message-ID: <20241026080121.461781-2-lulu@redhat.com>
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

When using a VDPA device, it's important to ensure that the MAC
address is correctly set.
Add a new parameter in qemu cmdline to enable this check, default value
is false

The usage is:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,macstrickcheck=true\
-device virtio-net-pci,netdev=vhost-vdpa0\
....

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/net/net.h | 1 +
 net/vhost-vdpa.c  | 4 ++++
 qapi/net.json     | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index c8f679761b..e00651a97b 100644
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
index 46b02c50be..071c3ff065 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1860,6 +1860,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                                      iova_range, features, shared, errp);
         if (!ncs[i])
             goto err;
+
+        ncs[i]->check_mac = opts->macstrickcheck;
     }
 
     if (has_cvq) {
@@ -1872,6 +1874,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
                                  errp);
         if (!nc)
             goto err;
+
+        nc->check_mac = opts->macstrickcheck;
     }
 
     return 0;
diff --git a/qapi/net.json b/qapi/net.json
index 87fc0d0b28..7d75119858 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -510,6 +510,10 @@
 # @queues: number of queues to be created for multiqueue vhost-vdpa
 #     (default: 1)
 #
+# @macstrickcheck: Enable the check for whether the device's MAC address
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
+    '*macstrickcheck':    'bool',
     '*x-svq':        {'type': 'bool', 'features' : [ 'unstable'] } } }
 
 ##
-- 
2.45.0


