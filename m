Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6245C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEYW-0007wp-N6; Fri, 24 Jul 2026 07:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEYU-0007wB-FB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEYS-0007l8-Rz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784894344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=DmpfcPiIrhE76GV7R/mMBq371aKcBTNG29MZbIMhF4U=;
 b=DWRMxDk2fzW33dV2I/sCqe8hF4d/XF2yHhluhLt5lePQWs9DVR/Dl5NC05LsSdcTExKT7w
 QY9mkwJbj9wZ2zO1TgqrLat11Pw2AI+ZqiQd36aU+zsjDmnp2F6SM0OrUt9+TosYdTz0Lj
 soQm/gy6Fwmp4heXmyP0c1+IAo2JGig=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-lprPVHuYPbe4QNN6hGX4UA-1; Fri, 24 Jul 2026 07:59:00 -0400
X-MC-Unique: lprPVHuYPbe4QNN6hGX4UA-1
X-Mimecast-MFC-AGG-ID: lprPVHuYPbe4QNN6hGX4UA_1784894339
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f8f8fde2dso294851f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784894339; x=1785499139; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DmpfcPiIrhE76GV7R/mMBq371aKcBTNG29MZbIMhF4U=;
 b=JjVR3N3uzmVi1Fk70YYbVmNd4oYy2JOfuiSGyURq3IW0m+M1ZCt3sx9VqP8ajVNk3g
 yXaZoXlCxCbJwmMWKUwg/iQxmywsj5IXYA0FhNbWG6dNZLvUEtB2luJEzXlT5MkmlH9i
 uY0U80nQVziSjNa5lNVAKnuyyOd2t2ziQTQHRn7ucC0pjsaELQeDvaZxGRfOilWcyCRT
 v0NumK70eSldzVSo0MolMxlB3Krtn65iQiBfF4yQjQ+tV6DmD5V4aFtuTXlcDzgp88DX
 PH4J1spyb1WaPfP70M4XppWwfc/Xu6yDTzHE/PgWw+y1qmJk6g03zY9bmi8zjlMmoukd
 N4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784894339; x=1785499139;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DmpfcPiIrhE76GV7R/mMBq371aKcBTNG29MZbIMhF4U=;
 b=SCdCeDMgS0tyk5Xb04hZ9/5bR9DIFsUqDqcuvSw69cfuqXpAEUvFWgzHfSzYR441k6
 KFXN47Tqa+8paFjZHCowgL2ko9qr8rx+dG9boZ5QnIr8YoCuAESwjxlNu8Ey7EJn+/Kg
 kxdj/1U9gMbVA0R1zyJFrQ3ZWOz6gBYRG6rsb3ww+BRHqy8UqbcYhJ2sTfGphOG37ALF
 GvriBAzdpBWx6F6/cRahplClljBbTEmBEzADiRMk+AvMus4ytx9GzXQFIkWmgP5nHclI
 4a1OtnBXUEUzxU63l6PZsnrCHZQU34SM+1nh64im3P6tSad3L9Q8L+uXFnPUmgo/ADH6
 QAtA==
X-Gm-Message-State: AOJu0YxXd5BMLa1+mxXvTd8/2H0/Jkn1Q9By14P7RjVvSb1b1bfJEVPt
 A151eEDdMt9eZ2mlDs+AfHsEfMayW/02rE4I13myiPQtGuT2cpl4b210KnWPc0HBVhlcbi7fNwq
 V7y2++05Sd1EtWhCRYO7ClbHoQVs3Hryg4wJTCDliqWYRULBFPRW4j84X48ra+5cQCEXqi8vYyL
 t/e5mZICtenYG84UTmdadZRi1JAOZbTq2RWg==
X-Gm-Gg: AR+sD13r/9yWT/3WsJzeI050iXT6wJ81wqsaok2FKt8ytsY9gcczqRFenl1UH9LT/JA
 +udQgh8EtX/VEYVVZJcPWoxTDzO5yRJNcsZrX7owSQMCpwY9HV1R/UXUVeyEk+Vgkc3JMG1X79C
 rUTeTw+ocWEPQAIEzKDinwK9dvvam4IKWr883KKrkGuXIkJAHEjjQCfRuzKcZW6S+nabiTWy8gl
 Zyk519Gg8p7yX0u6dwsD14SZl4NRKq7EEI2RKSrOBITLSjFQJFsPIDix5if4LEB6rm7fBRJMX5+
 gKiCAYrR+jUrfNEc7VTRlbOy9NpBoFCxRILRK5uF7io3W0rimQjRnlrlQSbx7YuCel01EXf6IC4
 WicCaoptDFFYOA5KFYL89+g==
X-Received: by 2002:a05:600c:c492:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-49573ce95b2mr94039085e9.32.1784894339185; 
 Fri, 24 Jul 2026 04:58:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c492:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-49573ce95b2mr94038735e9.32.1784894338677; 
 Fri, 24 Jul 2026 04:58:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6ad58sm75977175e9.4.2026.07.24.04.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:58:57 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] virtio: stop migrating num_default, validate vring.num on load
Message-ID: <3e6a7c403f93acc37af6a6332fdc65049ae218fb.1784894327.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

num_default tracks the allocation size of used_elems, set by
virtio_add_queue(). Migrating it via the ringsize subsection is
wrong: a migration stream (malicious or simply from a different
configuration) can inflate num_default so that
virtio_queue_set_num() accepts oversized values, leading to OOB
access on the used_elems array.

It is not even migrated consistently: a configuration with a
smaller num_default could thinkably migrate and work but in the
common case of num == num_default the value is not actually sent.

Stop migrating num_default: make virtio_ringsize_needed() return
false so the subsection is never sent, and use VMSTATE_UNUSED to
consume the field from old streams without applying it. The
destination keeps its local num_default from virtio_add_queue(),
which matches the actual allocation.

Also validate vring.num against num_default when loading the core
virtio state, rejecting streams that supply a queue size larger
than the locally allocated maximum.

Fixes: 46c5d0823d ("virtio: ring sizes vs. reset")
Fixes: 50e5ae4dc3 ("migration/virtio: Remove simple .get/.put use")
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 94ddbfd09f..437c001a04 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2817,14 +2817,6 @@ static bool virtio_packed_virtqueue_needed(void *opaque)
 
 static bool virtio_ringsize_needed(void *opaque)
 {
-    VirtIODevice *vdev = opaque;
-    int i;
-
-    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        if (vdev->vq[i].vring.num != vdev->vq[i].vring.num_default) {
-            return true;
-        }
-    }
     return false;
 }
 
@@ -2913,7 +2905,7 @@ static const VMStateDescription vmstate_ringsize = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(vring.num_default, struct VirtQueue),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -3593,6 +3585,12 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 
     for (i = 0; i < num; i++) {
         vdev->vq[i].vring.num = qemu_get_be32(f);
+        if (vdev->vq[i].vring.num > vdev->vq[i].vring.num_default) {
+            error_report("VQ %d vring.num %u exceeds allocated max %u",
+                         i, vdev->vq[i].vring.num,
+                         vdev->vq[i].vring.num_default);
+            return -1;
+        }
         if (k->has_variable_vring_alignment) {
             vdev->vq[i].vring.align = qemu_get_be32(f);
         }
-- 
MST


