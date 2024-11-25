Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5ABD3B7DC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 06:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFSH2-0007L2-Aa; Mon, 25 Nov 2024 01:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSH0-0007Kt-Ot
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSGz-0000QR-E7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732514916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8rD46jMPjY6PaeKxsMaGQ7NczSd9WnCbnNOXfr6x3I=;
 b=RJ/bfpb2tOoHFaqNPpwCK21vn1fruyjCxMyWjwPA/l/mQuxT9xda1XZfNHzEmxjHj0CCNj
 H1rIAPQigUH8ZqnOXnWyF2FSp1Gglq7eh7CdhTlAYqvxYCNmlTW3hOUXUVjdzjG+GdQgP7
 agPL/1h+A2dYu+a2suZXacggvp9l714=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-b_6DWmoYPcOezChL2CqiBw-1; Mon,
 25 Nov 2024 01:08:34 -0500
X-MC-Unique: b_6DWmoYPcOezChL2CqiBw-1
X-Mimecast-MFC-AGG-ID: b_6DWmoYPcOezChL2CqiBw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6454B1953951; Mon, 25 Nov 2024 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.241])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43011300019F; Mon, 25 Nov 2024 06:08:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/6] virtio-net: Do not check for the queue before RSS
Date: Mon, 25 Nov 2024 14:08:06 +0800
Message-ID: <20241125060809.15543-4-jasowang@redhat.com>
In-Reply-To: <20241125060809.15543-1-jasowang@redhat.com>
References: <20241125060809.15543-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

virtio_net_can_receive() checks if the queue is ready, but RSS will
change the queue to use so, strictly speaking, we may still be able to
receive the packet even if the queue initially provided is not ready.
Perform RSS before virtio_net_can_receive() to cover such a case.

Fixes: 4474e37a5b3a ("virtio-net: implement RX RSS processing")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a2a8d6b07b..d4aaf362b7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1911,10 +1911,6 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!virtio_net_can_receive(nc)) {
-        return -1;
-    }
-
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
@@ -1924,6 +1920,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         }
     }
 
+    if (!virtio_net_can_receive(nc)) {
+        return -1;
+    }
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
-- 
2.42.0


