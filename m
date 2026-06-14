Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045FECD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCl-0007Fe-DE; Sun, 14 Jun 2026 15:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCa-00077J-6h
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCX-0002NE-TJ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/ys6ZssApw29Zt0fL+bJEbJHwULzWoQ7y5saFW1/Yw=;
 b=Xy5GilMNFnmGFvRq35iFVBo26chMkeogA+QSGH8khxEpdQHxphAKu7Wjpq8dEuo2X+Fhc+
 gGZ6S8FWCOil0ToyJMCqxwk2miCtVNn8x4Eg5bBUyC0qp+UPHtgmiohX54W67RZ5eWUsQe
 1BeFkTwQFS/q30K3mp9e27ri5XdIE/8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-euSA0pIINPau7FrON-f-Gg-1; Sun, 14 Jun 2026 15:08:56 -0400
X-MC-Unique: euSA0pIINPau7FrON-f-Gg-1
X-Mimecast-MFC-AGG-ID: euSA0pIINPau7FrON-f-Gg_1781464135
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef63d1214so1614963f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464135; x=1782068935; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I/ys6ZssApw29Zt0fL+bJEbJHwULzWoQ7y5saFW1/Yw=;
 b=AvhHpQiSD8/kky/fiPgby8ksgpgJI1heWw3ll2NPmpN0AsoiMWlI5y/lw0ieGcLDGk
 B1/pqd5LNI8VohPKuZFxoh9LzT/bMg4aWHvTkzBI6vWF78fv+I2nPNaZJtmJ7sYkrmQ/
 66h3DL/bXDlAgn6Z59S2u3NdtoX/4X27jSrPbXD8S839Uy8jRMKWgJ+kdDgLDoO3hFQF
 o2TUYkta8q2eTQYBpru29zQ4E+XzWLZaund4SWx1ZlSX02lYTh0h6EDFxFQS12YigbTH
 HvfpeE0I/FmizwH6/6rU4EAn5swERSCnEoSTtUYFfRTzB8fGOr6tnSkndENNU9bTjaF+
 S+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464135; x=1782068935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/ys6ZssApw29Zt0fL+bJEbJHwULzWoQ7y5saFW1/Yw=;
 b=R2LtnN4SrxRGqFhvpKlM4L8bH8xeg+YzCg5m4txLNfCVZqohI4EU5sJl2zswQJyTjV
 4rx9HTX5VQoHubioBXg7EMxZCltiIT15uVHsl5dC0yk+7pl7wjdx738WP3Y5OvtryNWH
 CwIQ1Bus0lESUJ3OBEffjr1hnxsRKcFKzSb0Db4xwwiN4beSplj46WTHxYQF9kPIj9zn
 M6lD+WsX4PL0RVu9EEVYpwyeJwkUI5odyh0/GnhAr8luNFm1whF/VPmBEivxjG3RitoD
 bPq7ifHVfrHiZO7zOx8cKr7GOstLzZzzOHwIftss0SstK4/aL/NXFXvuaNpdz32MqPCq
 3X9g==
X-Gm-Message-State: AOJu0YzWQJ6T39gM4fO0j4rPycARbLYm/dqtoEhnv7aKxqhNxvXi9bge
 zwSQLgby623ZFeLTGb9HGWtyoatOox4f4QBLFGHzDD7LV0val3i1gZiIy7Zk9xcR6X85utm4tA/
 szwKwVa831wLjN0W+hduQQ1mBs/Gv6TQRIlAxNFdNYcZIVdN3TpdYEAwlpHBKLxRmtTjHfqV/1v
 AjfHDMECDiCHTY6KVwbUAd2SWuCKQDu47fGQ==
X-Gm-Gg: Acq92OEsdsObFC7eiGNEutphMJTF9epdn6nl59/GRDrib3MIv0/AoJl8i+G3VFIzZ2V
 qt9G01OI7LhhkR+nKioleryZ6AVzVfqgzWSjtXSPCVB5oNa4eJtypyaPOysNFhFM3z1rCJxp23R
 0SKeQw7ki4AN0UJeml+4KyVny3IzW42MlyI7BvZLsbRvTz4nVf+unNMY/Iu2+kkKNB0dDzUk47i
 9ld0Po1DSov5WWcEjTXCKL6oM3S2M1WiEFXrjgbSKWuYse57lNJa9qEjj32ljeawqyNR1h7m248
 FEZLwb1TxIwT3unICTL+sfYCmQ44CBTrVKJqcsUTADy3PygXyDJbPbaYzZy/F3BpBTgMQkVG7JQ
 D1KV7xwk11Gmd61yi6HKcwbPE8QJyfDPk7opYx9G2jVU=
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-4606dbe5c41mr14333606f8f.40.1781464134726; 
 Sun, 14 Jun 2026 12:08:54 -0700 (PDT)
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-4606dbe5c41mr14333578f8f.40.1781464134248; 
 Sun, 14 Jun 2026 12:08:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cf5d9sm23854470f8f.32.2026.06.14.12.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:53 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 074/106] vhost: factor out the descriptor next fetching
Message-ID: <00373aa05e683e4d4f72f534a8b9179cd4065149.1781463125.git.mst@redhat.com>
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

The next field will not be used if IN_ORDER is enabled.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173535.2702587-4-eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 901253d06e..7adacd4f54 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -139,6 +139,20 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
     return true;
 }
 
+/**
+ * Get the next descriptor in the chain in SVQ vring from a descriptor id
+ *
+ * @svq Shadow Virtqueue
+ * @id ID of the descriptor
+ *
+ * Return the id of the next descriptor.
+ */
+static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
+                                    uint16_t id)
+{
+    return svq->desc_state[id].next;
+}
+
 /**
  * Write descriptors to SVQ vring
  *
@@ -173,9 +187,11 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     }
 
     for (n = 0; n < num; n++) {
+        uint16_t next = vhost_svq_next_desc(svq, i);
+
         if (more_descs || (n + 1 < num)) {
             descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
-            descs[i].next = cpu_to_le16(svq->desc_state[i].next);
+            descs[i].next = cpu_to_le16(next);
         } else {
             descs[i].flags = flags;
         }
@@ -183,10 +199,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = svq->desc_state[i].next;
+        i = next;
     }
 
-    svq->free_head = svq->desc_state[last].next;
+    svq->free_head = vhost_svq_next_desc(svq, last);
     return true;
 }
 
@@ -432,7 +448,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = svq->desc_state[i].next;
+        i = vhost_svq_next_desc(svq, i);
     }
 
     return i;
-- 
MST


