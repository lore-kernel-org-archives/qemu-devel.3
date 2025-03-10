Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA877C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcA2-0005iH-9J; Mon, 10 Mar 2025 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9r-0005eV-2C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9o-0004wt-IC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741609374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWpLQ5UffopEreR+h80b09wvJlbh0Nvw29HAc/Y4daY=;
 b=FviXPVdw87EirkBrm57WBXM4YdeDZZnlbSDqqjx0FmOWzZ+r5g9VXTdd8h7x7QdiG1AKSK
 arSsL4n2vafjXrt/J7VngfG/9QV3ZhMyme1vZNPfwMJvhS78uxK3R/pkKgrpjlfi679HU2
 QC3HlpA0cV1pJ39JAGHlz/6Y3k/MJlc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-CJpEny4QOQmhWo1hZvRRRg-1; Mon,
 10 Mar 2025 08:22:53 -0400
X-MC-Unique: CJpEny4QOQmhWo1hZvRRRg-1
X-Mimecast-MFC-AGG-ID: CJpEny4QOQmhWo1hZvRRRg_1741609372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7D7219560AD; Mon, 10 Mar 2025 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E7411800370; Mon, 10 Mar 2025 12:22:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/5] net: parameterize the removing client from nc list
Date: Mon, 10 Mar 2025 20:22:36 +0800
Message-ID: <20250310122240.2908-2-jasowang@redhat.com>
In-Reply-To: <20250310122240.2908-1-jasowang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

This change is used in later commits so we can avoid the removal of the
netclient if it is delayed.

No functional change intended.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index a3996d5c62..4eb78a1299 100644
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
2.42.0


