Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E9C7115F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoM7-0005kM-Eo; Wed, 18 Jun 2025 04:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoM3-0005jq-Px
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoM0-0002a9-1E
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750236060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMSAIGjZQm7v/llfYTxAtUXEfhFeRyEzAV9SpCA0wyQ=;
 b=JbvNKcK9H49lQ9akJnfxyp+h324Eq+MRYHfRMB9qI59E4mh0uHmZAJazLlhUStnyoMr3fp
 ACvgEXLmm4VLqvlylGdJAKc3fRxtXrsQ+syg6oW19FqQvj9A77HNtcRjJR7jufzTCFAVqp
 T2Qwes9d8EIY166VNbMMl+ldscWV7Lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-On_cWLyoNsGYc7bPfmB5xw-1; Wed,
 18 Jun 2025 04:39:47 -0400
X-MC-Unique: On_cWLyoNsGYc7bPfmB5xw-1
X-Mimecast-MFC-AGG-ID: On_cWLyoNsGYc7bPfmB5xw_1750235986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DA7B18002ED; Wed, 18 Jun 2025 08:39:46 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6F9919560A3; Wed, 18 Jun 2025 08:39:41 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/8] net: Define net_client_set_link()
Date: Wed, 18 Jun 2025 10:39:24 +0200
Message-ID: <20250618083930.451313-3-lvivier@redhat.com>
In-Reply-To: <20250618083930.451313-1-lvivier@redhat.com>
References: <20250618083930.451313-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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


