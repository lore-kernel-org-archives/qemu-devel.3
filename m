Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C851CEED617
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1son5S-0002CO-KV; Thu, 12 Sep 2024 12:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1son5R-00028g-C7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1son5O-0000SI-Ta
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726160066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZe+UehkXInQeYfUIUDCFi4K70VJXwZncxmOWj+FKHw=;
 b=AZKA8kwo2VEcWEQhswsM5OMmO0R1D5S/7rvr+ryHyUfzeSMXbM2jXWcKLBHjXA/567M5qW
 +jsvQyO+GWjyyXCEylLHlD6eikBI8ZyaCroD9yZMmktjJR6GfI/yiVMFLItL+OBy4ma57Q
 xzK1kAtcnR41sHjs7bBEL3++G9xF17Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-zUAmFd6hPEirv5jAmu7a-A-1; Thu,
 12 Sep 2024 12:54:21 -0400
X-MC-Unique: zUAmFd6hPEirv5jAmu7a-A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AADDF1953954; Thu, 12 Sep 2024 16:54:19 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.146])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE5471956053; Thu, 12 Sep 2024 16:54:15 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Cc: dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, leiyang@redhat.com,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 1/2] net: parameterize the removing client from nc list
Date: Thu, 12 Sep 2024 18:54:07 +0200
Message-ID: <20240912165408.234447-2-eperezma@redhat.com>
In-Reply-To: <20240912165408.234447-1-eperezma@redhat.com>
References: <20240912165408.234447-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This change is used in later commits so we can avoid the removal of the
netclient if it is delayed.

No functional change intended.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index fc1125111c..9f96509b2a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -381,9 +381,12 @@ NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
     return ncs->peer;
 }
 
-static void qemu_cleanup_net_client(NetClientState *nc)
+static void qemu_cleanup_net_client(NetClientState *nc,
+                                    bool remove_from_net_clients)
 {
-    QTAILQ_REMOVE(&net_clients, nc, next);
+    if (remove_from_net_clients) {
+        QTAILQ_REMOVE(&net_clients, nc, next);
+    }
 
     if (nc->info->cleanup) {
         nc->info->cleanup(nc);
@@ -442,14 +445,14 @@ void qemu_del_net_client(NetClientState *nc)
         }
 
         for (i = 0; i < queues; i++) {
-            qemu_cleanup_net_client(ncs[i]);
+            qemu_cleanup_net_client(ncs[i], true);
         }
 
         return;
     }
 
     for (i = 0; i < queues; i++) {
-        qemu_cleanup_net_client(ncs[i]);
+        qemu_cleanup_net_client(ncs[i], true);
         qemu_free_net_client(ncs[i]);
     }
 }
@@ -474,7 +477,7 @@ void qemu_del_nic(NICState *nic)
     for (i = queues - 1; i >= 0; i--) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
 
-        qemu_cleanup_net_client(nc);
+        qemu_cleanup_net_client(nc, true);
         qemu_free_net_client(nc);
     }
 
-- 
2.46.0


