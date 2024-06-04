Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A506C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWg-0001qT-W9; Tue, 04 Jun 2024 15:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWf-0001de-3L
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWc-00014K-8O
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5ZK85DrY7E/kWQuvTt0uyTur3Js4Sbrs2c23IwHRBA=;
 b=iCzcqWCelyrR5AZdECSQK06SnfXiUD3hC32Vz0jJE+PbwtrL7T+ci8v64ggQOUoNJijZNj
 U3pdTWX0l8aRQmvAk3Wqhcyc0Za/HMU5yezBhTzYD3C9yfZkXgLCzHLDJIeVM7STBsDcjD
 c8nkd8CEf6CWHcUiW7wwozhhc0q8Gyw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-LU11aHEcPCKS8s3NJdhBRw-1; Tue, 04 Jun 2024 15:08:47 -0400
X-MC-Unique: LU11aHEcPCKS8s3NJdhBRw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35e83bf3294so109550f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528126; x=1718132926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5ZK85DrY7E/kWQuvTt0uyTur3Js4Sbrs2c23IwHRBA=;
 b=EG+vIWrT+dukY6JnAi7BpksXfCmtLqoAYNsFieuOg/TcoY0O2UPz3aZWhC38dAHRII
 E/yRbIYJNqKIK3sLjAA2fzOjY0v9Bjxic988zYMlKHI0sNd+vIA2f90IvCxW5CxVc3Pr
 rQ7R+PoZtvtB7zsXyDl5kWZMs+w9g5h97AAX9LsqEg6BQ2nGbHt4iTUs7MxDCnOPTMEl
 PKWcJpN/yBJjvaykQupAl34D7l9nocrhpF3zTlHoF8CxuccxfMO0xnbyt0xGCZALOHoR
 anRMweHbiGyX12e4Yp08swBIO0/zL167hWv2ZqA26EYKwExDHkXeucvmEE5YUuUlhQU6
 nkKw==
X-Gm-Message-State: AOJu0YzMUKMZD7ddZOD9oxlBy0gJ7v7BXq82gMtrzYW4JOnXR6uwfVR5
 x/T2R0gkWrhOiuk6Py3BFQzpeAvlRF29eFH9MChNGoaYXFG3Z2HkZ2LxyrNm9pYpLnDxeVLbpzo
 cSN94n2wgrpKbYDol7+cqqThp0w4i7WN2esXhHs7jJv/NY7ldaJS/cLAJIXrln6gqtnexAZnwXs
 ZHOTfsML61LGWKrYOzTV5LAcQ4lPnAVA==
X-Received: by 2002:a05:6000:ac1:b0:357:ac48:9676 with SMTP id
 ffacd0b85a97d-35e8ef8fe7bmr215576f8f.51.1717528125703; 
 Tue, 04 Jun 2024 12:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ2Bws9bhvSZVUDSxK2VewV7oWsb2mOYqXEIHq30jnoguOWmRVGsHetSQ/kV8PCk8v1uUogA==
X-Received: by 2002:a05:6000:ac1:b0:357:ac48:9676 with SMTP id
 ffacd0b85a97d-35e8ef8fe7bmr215557f8f.51.1717528125261; 
 Tue, 04 Jun 2024 12:08:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066ff17sm12305649f8f.116.2024.06.04.12.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:44 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 45/46] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Message-ID: <d3e9c9777a6533efbc68bea718ef98048d1afb4f.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Cindy Lu <lulu@redhat.com>

In function kvm_virtio_pci_vector_use_one(), the function will only use
the irqfd/vector for itself. Therefore, in the undo label, the failing
process is incorrect.
To fix this, we can just remove this label.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20240528084840.194538-1-lulu@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b6757ffce2..349619f57a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -898,7 +898,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
     }
     ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
     if (ret < 0) {
-        goto undo;
+        return ret;
     }
     /*
      * If guest supports masking, set up irqfd now.
@@ -908,25 +908,11 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
         ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
         if (ret < 0) {
             kvm_virtio_pci_vq_vector_release(proxy, vector);
-            goto undo;
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
MST


