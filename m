Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FEF3D32A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBkn-0006KV-Ie; Thu, 05 Mar 2026 11:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkP-0006Au-E1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkE-0000mZ-9X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=top2HucBo65GyFiJ/jhx2kRq7jk2sQkisYHYNcLCT/g=;
 b=P3ycasGT/d38y6csAhWGkwhqWLcQQ6wDL9mEUOYmAS4R0WS7q3nbhsyvJNRQw3VWZnFJ4N
 l1ZequSWbKMFSiKbuJRBCYXWfmd2qzCRhBzp3SlpYsmC0+5pOaWHti1xmvntHbj1OmmeND
 ZZ9WezLLdzdqz7W8lg3/fkvCZ56B9FA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-2EkXJe5zPLC9L3zc7-ofmw-1; Thu,
 05 Mar 2026 11:40:08 -0500
X-MC-Unique: 2EkXJe5zPLC9L3zc7-ofmw-1
X-Mimecast-MFC-AGG-ID: 2EkXJe5zPLC9L3zc7-ofmw_1772728805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 816BB1800610; Thu,  5 Mar 2026 16:40:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B72E1958DC7; Thu,  5 Mar 2026 16:40:02 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 6/8] tests: vhost-vdpa: test out-of-order descriptor
 completion
Date: Thu,  5 Mar 2026 17:39:36 +0100
Message-ID: <20260305163938.3200787-7-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add tests that submit descriptors in one order but complete them in
a different order:
- Submit desc1 then desc2, complete desc2 then desc1
- Same pattern with 2-descriptor chains

This verifies SVQ correctly handles devices that don't preserve
submission order in completions.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 433e5d71ca7a..5efe688673cb 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -571,7 +571,7 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
     QVirtioNet *net = obj;
-    uint32_t free_head;
+    uint32_t free_head, free_head2;
 
     /* Add some rx packets so SVQ must clean them at the end of QEMU run */
     vhost_vdpa_add_rx_pkts(alloc, net, &server->vdpa_thread);
@@ -588,6 +588,24 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 2);
     vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
 
+    /* Out of order descriptors */
+    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                            1);
+    free_head2 = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                             1);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head2, 1);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 1);
+
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head2, &server->vdpa_thread);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+
+    /* Out of order chains */
+    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                            2);
+    free_head2 = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                             2);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head2, 2);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 2);
 }
 
 static void register_vhost_vdpa_test(void)
-- 
2.53.0


