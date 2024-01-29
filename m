Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3206C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURd4-0008Nd-4S; Mon, 29 Jan 2024 08:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURd2-0008MW-6s
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURcz-0004dL-Gz
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706534656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqcWzWPVvk67G425Dven4TaY5cdIzJsDLAkkOQm29aM=;
 b=KLeew1WBui8yIvMqNFfDqbd5fwUEKZx4WtNflQiS+S07sWrr8xwtJ7J7rAu4PqEAuxJ85I
 HeXdHFaYprizKXQouukBImpguI6rHVWTdY9jeMsktnSRF0OygrQ2PCiWUTFPfP2+W6Mhlp
 qRTX12hZGTNKki2RVbRyhQ43GtDSCVY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-L365JoEfNBm6-C2lAaOWfA-1; Mon,
 29 Jan 2024 08:24:13 -0500
X-MC-Unique: L365JoEfNBm6-C2lAaOWfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27C7238562C0;
 Mon, 29 Jan 2024 13:24:13 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A612B488;
 Mon, 29 Jan 2024 13:24:11 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: si-wei.liu@oracle.com, leiyang@redhat.com, yajunw@nvidia.com,
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 dtatulea@nvidia.com, mcoqueli@redhat.com
Subject: [PATCH 1/2] net: parameterize the removing client from nc list
Date: Mon, 29 Jan 2024 14:24:06 +0100
Message-Id: <20240129132407.1474202-2-eperezma@redhat.com>
In-Reply-To: <20240129132407.1474202-1-eperezma@redhat.com>
References: <20240129132407.1474202-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index 0520bc1681..11e19d3bed 100644
--- a/net/net.c
+++ b/net/net.c
@@ -375,9 +375,12 @@ NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
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
@@ -436,14 +439,14 @@ void qemu_del_net_client(NetClientState *nc)
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
@@ -468,7 +471,7 @@ void qemu_del_nic(NICState *nic)
     for (i = queues - 1; i >= 0; i--) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
 
-        qemu_cleanup_net_client(nc);
+        qemu_cleanup_net_client(nc, true);
         qemu_free_net_client(nc);
     }
 
-- 
2.39.3


