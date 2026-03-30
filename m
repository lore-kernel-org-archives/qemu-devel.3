Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9059AFB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78dR-0005Q4-1X; Mon, 30 Mar 2026 05:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dN-0005PE-Po
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dL-0000N9-OC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARJckNFV7lxLiDyqSx4CiZiaQcGSW8eGYbJQBu9N1Fw=;
 b=WFtqLohAyRSw1MRdaXW3sA5bFWBrL3fqr6tA7PaT06BcEfindsOnJqJa2Lhtc4QEIuddcN
 /rqcN5TuuGDns0bB/oRgbNt2kB3FYiPAybx9qSeiGEh38VfHcaPJku600f37YLsrfLmLRU
 IfAb4pTyw2Je5CLNe2uCechFo5wJcUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-3Q9rNd8yO52787MW6BFHNg-1; Mon,
 30 Mar 2026 05:10:02 -0400
X-MC-Unique: 3Q9rNd8yO52787MW6BFHNg-1
X-Mimecast-MFC-AGG-ID: 3Q9rNd8yO52787MW6BFHNg_1774861802
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE1341955E80; Mon, 30 Mar 2026 09:10:01 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9713C30001A1; Mon, 30 Mar 2026 09:09:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 2/7] virtio-net: keep tap read polling disabled while vhost
 owns RX
Date: Mon, 30 Mar 2026 16:58:10 +0800
Message-ID: <20260330090944.1008027-3-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
References: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

virtio_net_backend_read_poll_set() re-enables TAP read polling on
vmstart even when kernel vhost has already taken over RX.

That lets QEMU userspace and vhost race on the same tap fd and can
corrupt the restored virtqueue state during migration switchover.

Keep read_poll disabled for TAP backends with a started vhost_net, while
leaving pure userspace backends unchanged.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d6d2188863..616590fb82 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1322,9 +1322,19 @@ static void virtio_net_backend_read_poll_set(VirtIONet *n, bool enable)
     for (i = 0; i < (int)n->max_ncs; i++) {
         NetClientState *frontend = qemu_get_subqueue(n->nic, i);
         NetClientState *backend = frontend ? frontend->peer : NULL;
+        bool backend_enable = enable;
 
         if (backend && backend->info && backend->info->read_poll) {
-            backend->info->read_poll(backend, enable);
+            /*
+             * When vhost is active, the kernel backend owns the tap RX path.
+             * Re-enabling QEMU read_poll on vmstart makes userspace and vhost
+             * race on the same tap fd, which can corrupt the restored RX ring
+             * during migration switchover replay.
+             */
+            if (enable && get_vhost_net(backend) && n->vhost_started) {
+                backend_enable = false;
+            }
+            backend->info->read_poll(backend, backend_enable);
         }
     }
 }
-- 
2.52.0


