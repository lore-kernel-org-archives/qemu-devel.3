Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8974FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obr-0005qY-Lw; Mon, 22 Sep 2025 18:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obo-0005mR-Ge
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obm-0001tj-7Y
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOkyRXBewUgAC0oUKh3r+fGvQty4Mx2Cj2IYFAhox1c=;
 b=O1WUkDcZ47i3r2mufRkYiXFQPJ0U1DCydT9hLD9fsXrN3oOTtjoS9HH4nhuqomvWkw/nyh
 5YFrzWDqC1iOfUhArFIfon7Z4sAPwmDUfGd/4tcnFBizj2RRm/dy7h2QIrF6tzQLaViayd
 EqgMt8TPNmHvZqM7kfPDxPZ6o+POu+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-DdMBUD2iOkes0pMCUY64cg-1; Mon,
 22 Sep 2025 18:02:01 -0400
X-MC-Unique: DdMBUD2iOkes0pMCUY64cg-1
X-Mimecast-MFC-AGG-ID: DdMBUD2iOkes0pMCUY64cg_1758578520
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A347D19560A7; Mon, 22 Sep 2025 22:02:00 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF08E1955F21; Mon, 22 Sep 2025 22:01:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/5] virtio: support irqfd in virtio_notify_config()
Date: Mon, 22 Sep 2025 18:01:47 -0400
Message-ID: <20250922220149.498967-4-stefanha@redhat.com>
In-Reply-To: <20250922220149.498967-1-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio_error() calls virtio_notify_config() to inject a VIRTIO
Configuration Change Notification. This doesn't work from IOThreads
because the BQL is not held and the interrupt code path requires the
BQL.

Follow the same approach as virtio_notify() and use ->config_notifier
(an irqfd) when called from the IOThread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 13830debfd..ced0fea4fc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2706,7 +2706,12 @@ void virtio_notify_config(VirtIODevice *vdev)
 
     virtio_set_isr(vdev, 0x3);
     vdev->generation++;
-    virtio_notify_vector(vdev, vdev->config_vector);
+
+    if (qemu_in_iothread()) {
+        defer_call(virtio_notify_irqfd_deferred_fn, &vdev->config_notifier);
+    } else {
+        virtio_notify_vector(vdev, vdev->config_vector);
+    }
 }
 
 static bool virtio_device_endian_needed(void *opaque)
-- 
2.51.0


