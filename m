Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81502C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8l0-0004Pu-Ur; Wed, 03 Jul 2024 18:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kx-0004E6-OC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kv-0001a8-54
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=BLMtR6OT0BqKhiN4AKbUYPVMLNMZEg3men9ovwthi8t7xnBh+BI5QLmmkCcus7arEgNUHx
 /4QPLsFUEDmlDHip3kQu0bZP1yA+e76gurM9nMWn1SNz+0iM4HQ/YwDWx1YzgwKY84NfQW
 luPdl1IX2L5qP1P4yiEKJqvdizjcxeQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-1-j-HpKBOv6sbQvbDD60Aw-1; Wed, 03 Jul 2024 18:47:15 -0400
X-MC-Unique: 1-j-HpKBOv6sbQvbDD60Aw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e98c1a9d2so1207817e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046833; x=1720651633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=rTGu24lDELN7XIscv2vdecvr5icMfXB01mztW+hc0cGk9Moxt0kvic72mEa0okLJty
 /I+6cKbOToMpJncx7fCU2aPuWMvjb8U/9+wWsr9lh5qD8HdV46Kvb7mHRxO/nt8zj24P
 dhPrt/Ggznf5xLCbgp4XYTZIMbdGo42oB0Pin+E/yOH8gYFTacoGYg2OI8DE4OD76SPh
 AaAPjLK3g+ImFlzigVGBNt4R18xD7dJs0uYLEo6i/YOz8AePQlgRUHUM6y0+jLHEa9Uu
 gEIm9nVp0kLhGisGCBA1t0Qj4wFydmXf0XtCJAO+mZSRM4O7QsuqwPdGeQF1r8V3eLrw
 W64Q==
X-Gm-Message-State: AOJu0YxB3tbuojGShu6HBCfnySyTx2foShwCtdCGaCUDNbK7W9LFWdyd
 qBgZ08pUNCHEhniF1mbj8+wiUPzIIlpDAGDe6I2EgqhW8eM5SRPhANvpzoq9TpIfRwfkS237Qk8
 UcBXHxZTg+EaZ6Nta8mVN+U3IMAGBf7EI5Ugx9Tri0ldT4/xropX2awzmGsRIoqdHDGyty6KWoY
 et8SNZqEiNlmylAARKYn3j+NiZomzfPQ==
X-Received: by 2002:a05:6512:3610:b0:52c:825e:3b1c with SMTP id
 2adb3069b0e04-52e8266f836mr6460157e87.26.1720046833227; 
 Wed, 03 Jul 2024 15:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHujyPKjr2Wl8Siz3B5hB6YJWFLDZ7BWmFStpBTX1i51rqT+3LekGS1RtyKu8QCGwGvE2bmNQ==
X-Received: by 2002:a05:6512:3610:b0:52c:825e:3b1c with SMTP id
 2adb3069b0e04-52e8266f836mr6460142e87.26.1720046832220; 
 Wed, 03 Jul 2024 15:47:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18b15sm551172866b.19.2024.07.03.15.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:11 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL v3 37/85] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Message-ID: <a113d041e8d0b152d72a7c2bf47dd09aabf9ade2.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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
index 7d62e92365..5941f1a94d 100644
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


