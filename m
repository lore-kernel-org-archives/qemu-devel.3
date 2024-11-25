Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B93D3B7DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 06:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFSHH-0007Mq-1T; Mon, 25 Nov 2024 01:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSHD-0007MQ-V3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSHB-0000RN-Eg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732514928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOEJDjNDOkiYEFqpDmf+K1tsu4f4hEtFrS86tdZmOYA=;
 b=OxRmYBn0WNsUfcprbTVk9lanRiZIKoYh8UC9mS46sC1jovO1gbVhYbXE79WU7apxJg/9GX
 UvHyhxqMRU0cyqtU6zP+wAtTiAZR6LXMd2vmnmHN/oXVRng179NlkNsfYYSO6j1/Ga47g2
 wUxZ++44qOtKvba+Hy+Zx4Smujb2Nm4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-DKlXqG5iNVqlR0yQRQjf1w-1; Mon,
 25 Nov 2024 01:08:44 -0500
X-MC-Unique: DKlXqG5iNVqlR0yQRQjf1w-1
X-Mimecast-MFC-AGG-ID: DKlXqG5iNVqlR0yQRQjf1w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E6F19560AD; Mon, 25 Nov 2024 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.241])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3905B300019E; Mon, 25 Nov 2024 06:08:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 4/6] virtio-net: Fix hash reporting when the queue changes
Date: Mon, 25 Nov 2024 14:08:07 +0800
Message-ID: <20241125060809.15543-5-jasowang@redhat.com>
In-Reply-To: <20241125060809.15543-1-jasowang@redhat.com>
References: <20241125060809.15543-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

virtio_net_process_rss() fills the values used for hash reporting, but
the values used to be thrown away with a recursive function call if
the queue changes after RSS. Avoid the function call to keep the values.

Fixes: a4c960eedcd2 ("virtio-net: Do not write hashes to peer buffer")
Buglink: https://issues.redhat.com/browse/RHEL-59572
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d4aaf362b7..b544d2e91a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1898,10 +1898,10 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
 }
 
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
-                                      size_t size, bool no_rss)
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
+    VirtIONetQueue *q;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
@@ -1911,12 +1911,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
+    if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
-            NetClientState *nc2 =
-                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
-            return virtio_net_receive_rcu(nc2, buf, size, true);
+            nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
     }
 
@@ -1924,6 +1922,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
+    q = virtio_net_get_subqueue(nc);
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
@@ -2049,7 +2049,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size, false);
+    return virtio_net_receive_rcu(nc, buf, size);
 }
 
 /*
-- 
2.42.0


