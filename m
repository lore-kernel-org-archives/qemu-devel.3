Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F8CDB481
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJknW-00043b-Du; Thu, 13 Nov 2025 22:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknU-0003vD-6h
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknQ-0002qF-FN
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0uEG2fJ/4Vjdgv1iPVa6yZo48Mgt4U2ZJJ7PuUWSIU=;
 b=jFOJuF4CZLV3MXRyJZidr7WZDMtCNey5X76qX6OpDNN1BODOyKjdPaRMd4MxCkUs81Xmyu
 Gz3L4P8n3cGkLXQPnQ9DHvDvBS7oim6iGS+4aYtUofpMssb2d8RgtvoRtlUy5GffuOu3Rq
 kgho3k/ZGKViXHbqG3kMLao1k8nTGUw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-aP8pUp9uOT6NH7BzXOWMgg-1; Thu,
 13 Nov 2025 22:48:21 -0500
X-MC-Unique: aP8pUp9uOT6NH7BzXOWMgg-1
X-Mimecast-MFC-AGG-ID: aP8pUp9uOT6NH7BzXOWMgg_1763092100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9550D19373D8; Fri, 14 Nov 2025 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4330A1800451; Fri, 14 Nov 2025 03:48:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jonah Palmer <jonah.palmer@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/5] net/hub: make net_hub_port_cleanup idempotent
Date: Fri, 14 Nov 2025 11:48:02 +0800
Message-ID: <20251114034806.2440-2-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
References: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Makes the net_hub_port_cleanup function idempotent to avoid double
removals by guarding its QLIST_REMOVE with a flag.

When using a Xen networking device with hubport backends, e.g.:

-accel kvm,xen-version=0x40011
-netdev hubport,...
-device xen-net-device,...

the shutdown order starts with net_cleanup, which walks the list and
deletes netdevs (including hubports). Then Xen's xen_device_unrealize is
called, which eventually leads to a second net_hub_port_cleanup call,
resulting in a segfault.

Fixes: e7891c57 ("net: move backend cleanup to NIC cleanup")
Reported-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/hub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/hub.c b/net/hub.c
index e3b58b1c4f..ee5881f6d5 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -34,6 +34,7 @@ typedef struct NetHubPort {
     QLIST_ENTRY(NetHubPort) next;
     NetHub *hub;
     int id;
+    bool listed;
 } NetHubPort;
 
 struct NetHub {
@@ -129,7 +130,10 @@ static void net_hub_port_cleanup(NetClientState *nc)
 {
     NetHubPort *port = DO_UPCAST(NetHubPort, nc, nc);
 
-    QLIST_REMOVE(port, next);
+    if (port->listed) {
+        QLIST_REMOVE(port, next);
+        port->listed = false;
+    }
 }
 
 static NetClientInfo net_hub_port_info = {
@@ -159,8 +163,10 @@ static NetHubPort *net_hub_port_new(NetHub *hub, const char *name,
     port = DO_UPCAST(NetHubPort, nc, nc);
     port->id = id;
     port->hub = hub;
+    port->listed = false;
 
     QLIST_INSERT_HEAD(&hub->ports, port, next);
+    port->listed = true;
 
     return port;
 }
-- 
2.42.0


