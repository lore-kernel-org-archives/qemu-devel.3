Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B72C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhwR-0007KW-D0; Tue, 16 Apr 2024 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwhwP-0007Jy-LP
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwhwN-0001Fs-R3
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713270574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5FGSVOy9GpeejpF76DVRPlN6ZRVwZxe/OLcSsCeLnUU=;
 b=NTYSIrrg3XloU5NlbL4cPJibIjQrZQnSyWW9NQYDKC4p9+iPjcXp6l9CtzOYZt6bSEfwOV
 CJL2uMnpUPjXIo+wBBF7+/gVrSFn/ZIpuVYP1JGXH6Y+scdkZ79YiIQXlXG7nZndNRjXXh
 LJerPK/RB9+r2dea9s/RYPLoxF0bjrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-PRS_bl0SPHq2XptfbQwLMA-1; Tue, 16 Apr 2024 08:29:30 -0400
X-MC-Unique: PRS_bl0SPHq2XptfbQwLMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4ED880171E;
 Tue, 16 Apr 2024 12:29:29 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D9D492BC8;
 Tue, 16 Apr 2024 12:29:26 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Date: Tue, 16 Apr 2024 20:29:10 +0800
Message-ID: <20240416122919.597819-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In function kvm_virtio_pci_vector_use_one(), in the undo label,
the function will get the vector incorrectly while using
VIRTIO_CONFIG_IRQ_IDX
To fix this, we remove this label and simplify the failure process

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b138fa127a..565bdb0897 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
     }
     ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
     if (ret < 0) {
-        goto undo;
+        return ret;
     }
     /*
      * If guest supports masking, set up irqfd now.
@@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
         ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
         if (ret < 0) {
             kvm_virtio_pci_vq_vector_release(proxy, vector);
-            goto undo;
+            kvm_virtio_pci_irqfd_release(proxy, n, vector);
+            return ret;
         }
     }
 
     return 0;
-undo:
-
-    vector = virtio_queue_vector(vdev, queue_no);
-    if (vector >= msix_nr_vectors_allocated(dev)) {
-        return ret;
-    }
-    if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
-        ret = virtio_pci_get_notifier(proxy, queue_no, &n, &vector);
-        if (ret < 0) {
-            return ret;
-        }
-        kvm_virtio_pci_irqfd_release(proxy, n, vector);
-    }
-    return ret;
 }
 static int kvm_virtio_pci_vector_vq_use(VirtIOPCIProxy *proxy, int nvqs)
 {
-- 
2.43.0


