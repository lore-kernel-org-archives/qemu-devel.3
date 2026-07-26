Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F196C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Ph-0007WN-Kr; Sun, 26 Jul 2026 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pf-0007VM-A0
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pd-0004Gu-NV
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=HHptCAg85ZhebyrD+cwkGeX0b5NRkS7Xp61zMCbeer+t9MSXgGGLiY2p+NCxQacRbPdOzc
 j/dTyM8nAyo1QO/HYjBG/l01ne4M6oGNcMqOFyuIrZfLUAXDFWA9LsS6A8datrvV2k/CYT
 K+4015f6h+lhTU5vZSBCiJ/XXEj6rJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-UGwZdNaWMBCg5cHtm3pXHw-1; Sun, 26 Jul 2026 17:29:31 -0400
X-MC-Unique: UGwZdNaWMBCg5cHtm3pXHw-1
X-Mimecast-MFC-AGG-ID: UGwZdNaWMBCg5cHtm3pXHw_1785101370
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so1358585f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101370; x=1785706170; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=fpJiHBci3dWFTtZc4rM+sCtFStAxyY47YlpjMP+5Of99yExvwLSi0mdX4gkwgGIsYe
 VOHQvlu8mQtLsmUriouINWI17EkEwsNul5ZcyaI4U1qBfQ/1TPcn9HlWvMEDsmJskIxP
 fRLF8W7b147RK40/891+cUMVRu1IuW4HWQb3EjMaB3tD8EbRbxD5hXvA1aod5Nmhe+9i
 rydB7pjqPLgyBXaxQ2tbdVk5xTww/cXzqIWTBCPfOreLI4uTIPvBgJJl0UatlHW+/rHO
 qehbEi8nBLVLClhQ2IZ2wsa9tKP3qZmLah4v25TpL8nrRKs/GX3oKyctzzxCH3tzg6Z+
 h4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101370; x=1785706170;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=OMkccYNpkDKSTHw98pzko3QM1AQNIg1sL9KgE1/v6ExMuSbppzuNYbFdPmub6pgc0M
 CmdsjB94zyF4XLYvxsAy2YT0OnabBpEqCUq82kZaobiIHwBbUo+vsd4yXrnzW/myLaBK
 ESIVeWp5i6VIcLmWJXVWfLuDLktbwzdQhEtEwtjguo6+GOU6vVWUBHaC6ozaGoNY7J0u
 YSP69DXCr0lQPJdRB+znpmspHKLCOFlv78nTm2XayJD2SICVJzMeQBVcJD9gDIcoeJ1k
 1MKvcEiIQUp2muj3iuDjq7HYSIPLAC8qroRK1ULIz+EgFwJRBNsn6SJDGimNtS2rxZYE
 s+5w==
X-Gm-Message-State: AOJu0YxFRIfIKpQRxAiR84KV88tYm7TYtkLZAhuQI2q5VMuiQaQDM508
 aK4vnHAVT251+va7r48ZmyNVR2vkCxve/mdwGSyKovf2ftOYQ0YmkWLlnhSHzKohSv9lavCggFD
 fI1iWN/M9MSoFp3Re5P0e94pOh08bcxbZe9F6FDYJ8/Ml8XMUc99hCVsSZH6NUvDpS9rxs609q7
 fI6XXrdCwjuGLJB4doN6LttdNOm4/vVU37cg==
X-Gm-Gg: AR+sD10wPKdPvnsda98U3mEQA8C5t3pR1DPI1IS0pvHAuWHFHPF4A46CuLuiCyycRgr
 5daX34e+uprZTiSspMUiTACOCtgymfjONYJbmm80+4tzohQVPuXlth3aHEtoUHweriqsAeAU+hz
 gVwRvUG3F+6Ft0/EOE733v/Bg9zkJ9HmZO14oZBVkKNRmQXfN4+mJARd3ImHqSm8P9k8gTZ1CtC
 gF3njuFKk7CgSpbWeaLWw0ARX5tG1DV643nLsXrgsW+XrRlre4PEK1zs6ZvhTBFMPfzrGz+Kg49
 1uJP6h8Pj3vYqikzofUskDb3Z5b/IoWT+9wg94jGXOb763B1i2WnMqm4KSNlx1SSbh/HAuSP6AB
 zGqwgN21BJhCWtc5y76Z1qQ==
X-Received: by 2002:a05:600c:35d6:b0:496:bbce:fd with SMTP id
 5b1f17b1804b1-496bc0500bemr45287445e9.6.1785101370180; 
 Sun, 26 Jul 2026 14:29:30 -0700 (PDT)
X-Received: by 2002:a05:600c:35d6:b0:496:bbce:fd with SMTP id
 5b1f17b1804b1-496bc0500bemr45287285e9.6.1785101369658; 
 Sun, 26 Jul 2026 14:29:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfb20ddsm174110535e9.3.2026.07.26.14.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:28 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 11/30] virtio: stop migrating num_default, validate vring.num
 on load
Message-ID: <3d7d4d9bf54d45da554c2800b039371d018d263e.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <3e6a7c403f93acc37af6a6332fdc65049ae218fb.1784894327.git.mst@redhat.com>
---
 hw/virtio/virtio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4a6430c31c..2766217ddd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2805,14 +2805,6 @@ static bool virtio_packed_virtqueue_needed(void *opaque)
 
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
 
@@ -2901,7 +2893,7 @@ static const VMStateDescription vmstate_ringsize = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(vring.num_default, struct VirtQueue),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -3581,6 +3573,12 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 
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


