Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97ABC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh0k-0008UK-PH; Mon, 07 Jul 2025 04:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0d-0008RH-Ij
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0a-0007La-SS
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMSAIGjZQm7v/llfYTxAtUXEfhFeRyEzAV9SpCA0wyQ=;
 b=OXcey8QsVWnV/O/a1ozL1RDzUNawi0NCm0m6Ampp8WxSoZoENDZIXZyHLNC1j1/se0pO4L
 ZYIz7jYUEhEszhGMcPHlMT7K2Gqk8DI8uE3j8JBCtF1ja8a+P5J+f+jTFrbDmzoqlEpExO
 G3ecqibNqoFu/NHP0p2pcJyKUdJ9P7k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-uJ3lxr35MV-UtoZQS4oKsg-1; Mon,
 07 Jul 2025 04:15:24 -0400
X-MC-Unique: uJ3lxr35MV-UtoZQS4oKsg-1
X-Mimecast-MFC-AGG-ID: uJ3lxr35MV-UtoZQS4oKsg_1751876123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26AF2190FBCC; Mon,  7 Jul 2025 08:15:23 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40D071803AFF; Mon,  7 Jul 2025 08:15:18 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 02/11] net: Define net_client_set_link()
Date: Mon,  7 Jul 2025 10:14:56 +0200
Message-ID: <20250707081505.127519-3-lvivier@redhat.com>
In-Reply-To: <20250707081505.127519-1-lvivier@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The code to set the link status is currently located in
qmp_set_link(). This function identifies the device by name,
searches for the corresponding NetClientState, and then updates
the link status.

In some parts of the code, such as vhost-user.c, the
NetClientState are already available. Calling qmp_set_link()
from these locations leads to a redundant search for the clients.

This patch refactors the logic by introducing a new function,
net_client_set_link(), which accepts a NetClientState array
directly. qmp_set_link() is simplified to be a wrapper that
performs the client search and then calls the new function.
The vhost-user implementation is updated to use net_client_set_link()
directly, thereby eliminating the unnecessary client lookup.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/net/net.h |  1 +
 net/net.c         | 32 ++++++++++++++++++++------------
 net/vhost-user.c  |  4 ++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0d2..ac59b593ba48 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -298,6 +298,7 @@ void net_client_parse(QemuOptsList *opts_list, const char *optstr);
 void show_netdevs(void);
 void net_init_clients(void);
 void net_check_clients(void);
+void net_client_set_link(NetClientState **ncs, int queues, bool up);
 void net_cleanup(void);
 void hmp_host_net_add(Monitor *mon, const QDict *qdict);
 void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
diff --git a/net/net.c b/net/net.c
index 39d6f28158a3..cfa2d8e95827 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1601,21 +1601,11 @@ void colo_notify_filters_event(int event, Error **errp)
     }
 }
 
-void qmp_set_link(const char *name, bool up, Error **errp)
+void net_client_set_link(NetClientState **ncs, int queues, bool up)
 {
-    NetClientState *ncs[MAX_QUEUE_NUM];
     NetClientState *nc;
-    int queues, i;
-
-    queues = qemu_find_net_clients_except(name, ncs,
-                                          NET_CLIENT_DRIVER__MAX,
-                                          MAX_QUEUE_NUM);
+    int i;
 
-    if (queues == 0) {
-        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-                  "Device '%s' not found", name);
-        return;
-    }
     nc = ncs[0];
 
     for (i = 0; i < queues; i++) {
@@ -1646,6 +1636,24 @@ void qmp_set_link(const char *name, bool up, Error **errp)
     }
 }
 
+void qmp_set_link(const char *name, bool up, Error **errp)
+{
+    NetClientState *ncs[MAX_QUEUE_NUM];
+    int queues;
+
+    queues = qemu_find_net_clients_except(name, ncs,
+                                          NET_CLIENT_DRIVER__MAX,
+                                          MAX_QUEUE_NUM);
+
+    if (queues == 0) {
+        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                  "Device '%s' not found", name);
+        return;
+    }
+
+    net_client_set_link(ncs, queues, up);
+}
+
 static void net_vm_change_state_handler(void *opaque, bool running,
                                         RunState state)
 {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 0b235e50c650..10ac8dc0b3d7 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -264,7 +264,7 @@ static void chr_closed_bh(void *opaque)
         vhost_user_save_acked_features(ncs[i]);
     }
 
-    qmp_set_link(name, false, &err);
+    net_client_set_link(ncs, queues, false);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
                              NULL, opaque, NULL, true);
@@ -300,7 +300,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
         }
         s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
                                          net_vhost_user_watch, s);
-        qmp_set_link(name, true, &err);
+        net_client_set_link(ncs, queues, true);
         s->started = true;
         qapi_event_send_netdev_vhost_user_connected(name, chr->label);
         break;
-- 
2.49.0


