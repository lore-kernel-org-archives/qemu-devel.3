Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C96AFED2DF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aGX-0004uE-3d; Thu, 12 Mar 2026 03:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGV-0004tf-QH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGU-0000Lh-Bz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARJckNFV7lxLiDyqSx4CiZiaQcGSW8eGYbJQBu9N1Fw=;
 b=FDPUKGo4VChLAVxORfhlVj9ZvSakqvO5sLJrmqRvUOmR5x39MIbdi0n+PpxppMrE0mHL2t
 PU86/F2EceoMx6bnFT37gKPYv/TwPsq6+HAjK0xsVyqortsSzw/QGc0uNXYHCRJa/MS5Go
 mJ7fbAAubWNVtddtWzQ1rw+S52bI4Wg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-nn4R5ePHPOa05dMGp6264Q-1; Thu,
 12 Mar 2026 03:15:22 -0400
X-MC-Unique: nn4R5ePHPOa05dMGp6264Q-1
X-Mimecast-MFC-AGG-ID: nn4R5ePHPOa05dMGp6264Q_1773299721
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7962D180047F; Thu, 12 Mar 2026 07:15:21 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B7F819540C2; Thu, 12 Mar 2026 07:15:16 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 7/9] virtio-net: keep tap read polling disabled while vhost
 owns RX
Date: Thu, 12 Mar 2026 15:09:35 +0800
Message-ID: <20260312071415.1836655-8-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


