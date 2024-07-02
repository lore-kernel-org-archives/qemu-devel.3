Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F03C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 02:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOSpc-0004Al-Ox; Mon, 01 Jul 2024 22:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sOSpR-000472-Fx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sOSpB-0007lm-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719885652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yphERN2r17TQl+vLHSgeK8LT0h3+mqr/b6qdRq0b9EM=;
 b=OYplecj3i2XTRzcBmDW9IsRY/H4Nc44GDaJxZgsA9BEnJmSzYGF56VsC2+AV9sqmqzmvGf
 WdKo3TqjwBB+/dzKsdDgzNWoUKXX2IKrVsTcMK9nZr1DA3+BHsJnVIiJLszqR9ZcSNNfjy
 cPoHyt6WpE+s3DOcvB0CB3tHgVcGBc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-F2HAtMphPiGHxGNOAfcXQg-1; Mon,
 01 Jul 2024 22:00:50 -0400
X-MC-Unique: F2HAtMphPiGHxGNOAfcXQg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4C4E1956083; Tue,  2 Jul 2024 02:00:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81FA1956048; Tue,  2 Jul 2024 02:00:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v4 2/2] virtio-pci: Add check the return of
 kvm_virtio_pci_vector_use_one
Date: Tue,  2 Jul 2024 09:59:37 +0800
Message-ID: <20240702020033.139261-3-lulu@redhat.com>
In-Reply-To: <20240702020033.139261-1-lulu@redhat.com>
References: <20240702020033.139261-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the return value check for kvm_virtio_pci_vector_use_one().
Since the return value of function virtio_pci_set_vector() is void,
we can do nothing here. So just add the error message here.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6b62165ef6..dc31a37ec0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1455,7 +1455,9 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
     }
     /* If the new vector changed need to set it up. */
     if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
-        kvm_virtio_pci_vector_use_one(proxy, queue_no);
+        if (kvm_virtio_pci_vector_use_one(proxy, queue_no)) {
+            virtio_error(vdev, "fail to set the vector %d", new_vector);
+        }
     }
 }
 
-- 
2.45.0


