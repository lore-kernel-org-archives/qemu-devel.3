Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD88CCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCp-0007LF-Im; Sun, 14 Jun 2026 15:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCb-00077Z-Pc
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCa-0002Nc-5J
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok0lvba2stfaZNgrdWga/lmddPgOemeWMEkvpGK7Gy8=;
 b=S050wSoLqGNRGN4Vi+80BtqDzP86RhgfyKJKgEsBlHzhRnL9b0rXLTrzQB+7mVqBOoKuxw
 gqim1X2XkDlohSHm+h+3iX8/KEAyUPpipglk65CRQPcMTJxQyL/lyv8VsFtOQt7GYHB8K5
 GHKkZm6XuCO3vMsH7P8NKksgVpzYlGk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-BsJLz5WjMz69G7P9ioc4hw-1; Sun, 14 Jun 2026 15:08:58 -0400
X-MC-Unique: BsJLz5WjMz69G7P9ioc4hw-1
X-Mimecast-MFC-AGG-ID: BsJLz5WjMz69G7P9ioc4hw_1781464137
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so1596509f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464137; x=1782068937; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ok0lvba2stfaZNgrdWga/lmddPgOemeWMEkvpGK7Gy8=;
 b=N/In6g4XO91uj9oBKQ3YdREolimVnBNk6ZkI00X1q8O6znwPKQsURaUkXtdDh7ZVcv
 sLeGFhHhgRqVU9c9gyzAJjlFAGkJiu830e2TGreeykmygZmhJ/jyMLbvceqlZK8yy419
 5KslXocnCiVR3H4jRaH+NHEBYWWQ5S7WMUgpQVY7pHwBQUH1hD55cRrGBqB9fRRBEDxb
 9g54BdmjCCFJLrILSSFRW/BLW9tgQ4e6/ElbrKY3epLonHpeekeazZIr6ykB5Er0Wd4d
 jO8igQ3aZJNvdBSGmW8y3k6CZ1lW+NAD58hAnM8LljMpioiRMJH/BJTVsdzjIQrzGQ7T
 ma1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464137; x=1782068937;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ok0lvba2stfaZNgrdWga/lmddPgOemeWMEkvpGK7Gy8=;
 b=Cbe6nQyHoxA7alM6J0BTs5PqPL9rXiB0JuhjI1q9NgQs0EATUQaI7rUjUsAO72+Wvr
 uQLPAaAcmHXHofqO3D8r7J0Zk3wMqzWODOwlWR4myeSPBX877a6zxGKPZe3UVkbTW6uc
 vP4fIaZclJyq2cRSKu2Vz/Q5BI0qmosFnhlwoUn8nLtSTdU84USEsJ3LyPU3mk/AEWZV
 eNPshWZo5taI7jezrKUQW2hBzSVQhAw1cgirXw6f3yeH4fuaRy+LU2GBqgB1+L6vbm35
 oxKWiimjklYfMFaArSXf1gMmhDRRLQqvY1b3zwaFE4hi3aLcFB6PemTLscSAAvT+5/A3
 U2vw==
X-Gm-Message-State: AOJu0Yzzsd6BdhCy+t9LkfemAeKRYBEPxxE2f1h7eXoyxrVPA3xMJ39h
 I6kKSpBskuQ2HorYMHum7YYCcLH8P2v3JTOycZQjJUbYVe9GU1pkz8smeCckaBvsv8WRuGglsoW
 w6S3E4vCwV6wgkK3e6loHBoqIXYAIaVIENSnFvI89J5TMhOqiyw+wQ0vAH3nXaNYPaSm/T5s2O7
 Ytvddw53L1nlys0jfBKJQS143t0q3jHEksiw==
X-Gm-Gg: Acq92OELt5ARqAyzX+MheM4P6eifR7w7BHakWm3f4pbw3AoYBcKlBFUNTXqGX4yD1ZF
 4jKcqSVvS7YP62T2+pZbwVXIPcYUqn003QFRo2rBzbzeAZ7oGmOuIY/CTd3X26xsPcLQNjoZGun
 U1BSAjQUOCeXS71f3VUzE80BJH6+KS1XDKxEC+8NeuOmRCEKFdyCmsAHREZtEhgVlAiaRhbP4c6
 tzsR9209JEvNLe1DfQpZDr7Pc59ctDUGBZCXMl6kp2CzH/pDgE+8tSeUc+sfscp0njBfflNvtga
 CwSIXCMK1kdYUXUyrebMR7slJBNuaTYazcPKCKKB4JUOy+StByhBDLryquXIy3WtNnN940ge5Iq
 /v4f1T5Jt55bOj6LJd6tGeaGPZHuEWVR7DamImrnnJmc=
X-Received: by 2002:a05:600c:46c4:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-490ec4fbcb7mr152436305e9.23.1781464136820; 
 Sun, 14 Jun 2026 12:08:56 -0700 (PDT)
X-Received: by 2002:a05:600c:46c4:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-490ec4fbcb7mr152436045e9.23.1781464136320; 
 Sun, 14 Jun 2026 12:08:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm28698969f8f.24.2026.06.14.12.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:56 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 075/106] vhost: factor out the get of last used desc in SVQ
Message-ID: <90369a1165c4ffc5a22c9e0fb1743bc0ff896861.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

This code path is modified to handle in order devices.  Abstract here so
we can generalize on the caller.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-5-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 45 +++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 7adacd4f54..e7e3c9155c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -444,6 +444,25 @@ static void vhost_svq_disable_notification(VhostShadowVirtqueue *svq)
     }
 }
 
+/*
+ * Gets the next buffer id and moves forward the used idx, so the next time
+ * SVQ calls this function will get the next one.
+ *
+ * @svq: Shadow VirtQueue
+ * @len: Consumed length by the device.
+ *
+ * Return the next descriptor consumed by the device.
+ */
+static uint16_t vhost_svq_get_last_used_split(VhostShadowVirtqueue *svq,
+                                              uint32_t *len)
+{
+    const vring_used_t *used = svq->vring.used;
+    uint16_t last_used = svq->last_used_idx++ & (svq->vring.num - 1);
+
+    *len = le32_to_cpu(used->ring[last_used].len);
+    return le32_to_cpu(used->ring[last_used].id);
+}
+
 static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
@@ -458,8 +477,6 @@ G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
 {
-    const vring_used_t *used = svq->vring.used;
-    vring_used_elem_t used_elem;
     uint16_t last_used, last_used_chain, num;
 
     if (!vhost_svq_more_used(svq)) {
@@ -468,33 +485,29 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
 
     /* Only get used array entries after they have been exposed by dev */
     smp_rmb();
-    last_used = svq->last_used_idx & (svq->vring.num - 1);
-    used_elem.id = le32_to_cpu(used->ring[last_used].id);
-    used_elem.len = le32_to_cpu(used->ring[last_used].len);
+    last_used = vhost_svq_get_last_used_split(svq, len);
 
-    svq->last_used_idx++;
-    if (unlikely(used_elem.id >= svq->vring.num)) {
+    if (unlikely(last_used >= svq->vring.num)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
-                      svq->vdev->name, used_elem.id);
+                      svq->vdev->name, last_used);
         return NULL;
     }
 
-    if (unlikely(!svq->desc_state[used_elem.id].ndescs)) {
+    if (unlikely(!svq->desc_state[last_used].ndescs)) {
         qemu_log_mask(LOG_GUEST_ERROR,
             "Device %s says index %u is used, but it was not available",
-            svq->vdev->name, used_elem.id);
+            svq->vdev->name, last_used);
         return NULL;
     }
 
-    num = svq->desc_state[used_elem.id].ndescs;
-    svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+    num = svq->desc_state[last_used].ndescs;
+    svq->desc_state[last_used].ndescs = 0;
+    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, last_used);
     svq->desc_state[last_used_chain].next = svq->free_head;
-    svq->free_head = used_elem.id;
+    svq->free_head = last_used;
     svq->num_free += num;
 
-    *len = used_elem.len;
-    return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
+    return g_steal_pointer(&svq->desc_state[last_used].elem);
 }
 
 /**
-- 
MST


