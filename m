Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A77D6ACD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYV-0003kQ-Ay; Wed, 27 Nov 2024 08:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYT-0003k1-KE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYS-0007lZ-69
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYnMOw7bKRrTuXSKTx/j7+jLrUGgRw/r9cXH2IkbZbo=;
 b=c9kJfgha7eSb6zFqfkG9i+UIANH1+6sFOzwK9DxQfbZ8oB3U4/1rTwkKeoCUxSkgH5u+b1
 0VGVSS8h2ZC8e75UdVnLeR/n0gXKQP+f9OnWdLa4OyXjxb77Nx1PvU3I76Cv8EbIQNB535
 6xSzxeTgUrWOAXS3P64mNfD2hPTzO6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-APhiqstKOcqrHC0OTa2yqw-1; Wed, 27 Nov 2024 08:58:06 -0500
X-MC-Unique: APhiqstKOcqrHC0OTa2yqw-1
X-Mimecast-MFC-AGG-ID: APhiqstKOcqrHC0OTa2yqw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349df2d87dso34711365e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715885; x=1733320685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYnMOw7bKRrTuXSKTx/j7+jLrUGgRw/r9cXH2IkbZbo=;
 b=VFc89fpFgIqL4+Wlk/K6zxJ+fK2IXgnTUvipK0wbidxgZBobkWWuQpB0IXqMzdvcGY
 3VzRWAZkh80Xty+ItCPrjuPSTH/U2OTfn8E/xdCr/LfVSR42WYqeBVeXBBhVcllvwnD4
 eVtVQNJ5tXBZjJxadEojH4PTSLFqVHZpGRcqvYba4ZmKFRmN4tstop0IFg95MzV9DR0G
 gJOBiZJKPVzi/JO7jD+AVI8xPNE3nAyM3B7kTOuQbcgQ+IHJwCqFZRcJ44Yf3QQfhVHP
 wx+7eCpXva16bnT+tLxlmNxFy02AZ6NUQBOQITdod3eZAT8jW2PNyekeXVCfYSKGAMOX
 jZJw==
X-Gm-Message-State: AOJu0YylNhZI3CxQtN7INu2+maaUd4MzkAHzUudLJitjXk4FmqQxhw9Z
 nofrxtHNk4/AKnpQ2JEaeN6E5wLXy7szpMp/zPuFVG1YGftRCO7q9hLOPxIVfm7Jk7rll/+OAEs
 7gYQpwHgcGM0vIEo8+ASCGDd+SPsZp7m7ksJSU2m/rKrIFWCONBURZl3kf+18cq8DRe2X8Q4Rjp
 a+xNDMFYlfhsSzGx5+EylatbnvqHqya6cP
X-Gm-Gg: ASbGncsBiN3tg/4EpnTG+NzfOLjn0NJOkZNKxwA56haWQSY/phncB1GAgR+NWT/di8t
 Cdx/d+OnFKSR/JznQV32Wj+79Sofy8KeTyatLS80+69YkgOMPHrEQtiUEFACMgG5EFntPDshaTx
 V/2M0ZifWOY4c827L4c17oh/0mmbudP968piGg+Sq1W43BRHRsSy8OccdDsmyrhCp2/tRI/8quR
 VZWUMrn8Wi/2Rq0T90E62BQo4Mx4vk+h+nVKgBaFCdB
X-Received: by 2002:a05:600c:1d20:b0:434:a5c2:53c1 with SMTP id
 5b1f17b1804b1-434a9de8bd4mr27435765e9.23.1732715884997; 
 Wed, 27 Nov 2024 05:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ7zdAiUKzcmAmlMRToDZqxbL1+MAKAJicumhr7HFMIF0eXutGc3lu9Vrwr79QzQjsa/hh7g==
X-Received: by 2002:a05:600c:1d20:b0:434:a5c2:53c1 with SMTP id
 5b1f17b1804b1-434a9de8bd4mr27435575e9.23.1732715884659; 
 Wed, 27 Nov 2024 05:58:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7f79c8sm21870955e9.40.2024.11.27.05.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:58:04 -0800 (PST)
Date: Wed, 27 Nov 2024 08:58:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 13/13] vhost: fail device start if iotlb update fails
Message-ID: <571bdc97b83646dfd3746ec56fb2f70bca55b9a2.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

While starting a vhost device, updating iotlb entries
via 'vhost_device_iotlb_miss' may return an error.

  qemu-kvm: vhost_device_iotlb_miss:
    700871,700871: Fail to update device iotlb

Fail device start when such an error occurs.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-Id: <20241107113247.46532-1-ppandit@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 76f9b2aaad..c40f48ac4d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2095,11 +2095,22 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
          * vhost-kernel code requires for this.*/
         for (i = 0; i < hdev->nvqs; ++i) {
             struct vhost_virtqueue *vq = hdev->vqs + i;
-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            if (r) {
+                goto fail_iotlb;
+            }
         }
     }
     vhost_start_config_intr(hdev);
     return 0;
+fail_iotlb:
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+    }
+    if (hdev->vhost_ops->vhost_dev_start) {
+        hdev->vhost_ops->vhost_dev_start(hdev, false);
+    }
 fail_start:
     if (vrings) {
         vhost_dev_set_vring_enable(hdev, false);
-- 
MST


