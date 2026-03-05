Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCBBF3D32A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBkA-00069W-DC; Thu, 05 Mar 2026 11:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBk4-00067m-E9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBk2-0000an-RC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH6mnFWB6m5+vxF8G5zIxihji/TxBSSXQlDS/pzqIro=;
 b=EsBGL2AM2D/QZP+zvlxyR1jynUfh169bU55pD3ofiI7ng4G7Uu7ban8XEUL45PWi4lWqg0
 rdAhyFpq3cddB8tVAzYdSWZ4WBQhE7/zMn0r3licDeSppDZyUBhJthMl+nsk5fly3SQMlK
 dwr5krsYRihCAoH2yh6wPrqPdLjRfGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-GRaX9_MHP0aiKvh-zJdH5g-1; Thu,
 05 Mar 2026 11:39:58 -0500
X-MC-Unique: GRaX9_MHP0aiKvh-zJdH5g-1
X-Mimecast-MFC-AGG-ID: GRaX9_MHP0aiKvh-zJdH5g_1772728798
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02C341800365; Thu,  5 Mar 2026 16:39:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D15941958DC5; Thu,  5 Mar 2026 16:39:54 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 4/8] tests: vhost-vdpa: test SVQ cleanup of pending buffers
Date: Thu,  5 Mar 2026 17:39:34 +0100
Message-ID: <20260305163938.3200787-5-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add RX buffers to the receive queue before terminating QEMU to verify
that shadow virtqueue properly cleans up unused descriptors during
shutdown.

This tests the SVQ teardown path when descriptors remain in the
available ring but were never used by the device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 7b1c34aa415e..8dde7d95b167 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -40,10 +40,15 @@
 #define QEMU_CMD_VDPA   " -netdev type=vhost-vdpa,x-svq=on,vhostdev=%s,id=hs0"
 #define VDUSE_RECONNECT_LOG "vduse_reconnect.log"
 
+static int NUM_RX_BUFS = 2;
+
 typedef struct VdpaThread {
     GThread *thread;
     GMainLoop *loop;
     GMainContext *context;
+
+    /* Guest memory that must be free at the end of the test */
+    uint64_t qemu_mem_to_free;
 } VdpaThread;
 
 static void *vhost_vdpa_thread_function(void *data)
@@ -82,6 +87,21 @@ static void vhost_vdpa_thread_add_source_fd(VdpaThread *t, int fd,
     g_source_unref(src);
 }
 
+static void vhost_vdpa_add_rx_pkts(QGuestAllocator *alloc, QVirtioNet *net,
+                                   VdpaThread *t)
+{
+    QTestState *qts = global_qtest;
+
+    t->qemu_mem_to_free = guest_alloc(alloc, 64);
+
+    for (int i = 0; i < NUM_RX_BUFS; i++) {
+        uint32_t head = qvirtqueue_add(qts, net->queues[0],
+                                       t->qemu_mem_to_free, 64,
+                                       /* write */ false, /* next */ false);
+        qvirtqueue_kick(qts, net->vdev, net->queues[0], head);
+    }
+}
+
 /**
  * Send a descriptor or a chain of descriptors to the device, and optionally
  * and / or update the avail ring and avail_idx of the driver ring.
@@ -523,6 +543,9 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     QVirtioNet *net = obj;
     uint32_t free_head;
 
+    /* Add some rx packets so SVQ must clean them at the end of QEMU run */
+    vhost_vdpa_add_rx_pkts(alloc, net, &server->vdpa_thread);
+
     free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread);
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head);
     vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
-- 
2.53.0


