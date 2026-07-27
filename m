Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB5C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQs0-0000BX-SK; Mon, 27 Jul 2026 15:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrw-0000AS-3c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQru-0000Oo-Hl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=ThDhtQTlxphtwcxBpDdNEVkyHgZoMuNHLP5AjLAuD+rSoRU3D1/8EN3JJAVMqdAAKcoEgH
 EHePLn6Y6p0s64JNl3nIKS1d/m+mTrVHJpI9AmpDNfvEL3ecRBQdmuwhuVJBJZAXCcaZki
 yRLJIDxJNtnWif2JH4z5or3sW9odC8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-v2anLifKNqKaE-_oxGzEHg-1; Mon, 27 Jul 2026 15:20:04 -0400
X-MC-Unique: v2anLifKNqKaE-_oxGzEHg-1
X-Mimecast-MFC-AGG-ID: v2anLifKNqKaE-_oxGzEHg_1785180003
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f6db77430so2110896f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180003; x=1785784803; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=Nb2fizN+K5HiYjXEiy/vu/paOukp+mBIwmDmA+qtWA1ph1nQGgmPOJkYc+HDwlrrLT
 e/fwXRcvEBsJbQVNmRgHk17f1mxQI6hmw/eNqk14vBNaSdZVLxOv5k95DYhP4XlaWFBp
 6Uv1gGhL7w0mJft1cXZB/EN9ItYhS9ir9u49Lyw3ohBDTlTXmjogUzdDC2WSxFqfRqAe
 MRFPd6ZiH6Ww53/cuc0WAGdevJER1xGw9jSLawO8afviZ65/2fXciZ1gg/Zl7gLhUWmM
 xoTbKr0Dfdyd9+hTQC1B5XYasYsC8IR2GbJ3QnDB+hC7JYHASaAp5Kr7Mbp1CZ+FJ+it
 O55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180003; x=1785784803;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkXR+qyvrRlYakP6hofO/xvu4cSKGYwGmHafizZSjXg=;
 b=fzJh3Dv03TvvZL7ulJ1tOo9mt4BphYCl4ENQqL0ykQOjrNGViLLWziVRBDmykSL6sG
 JySO8v6Fq9ua2Azyjty1skBfI153cr+9g3HqJcN1KUIJPIHAm/mKoAH9Ps2NTQJBn5jA
 jPAEzt40kZnvlhj98IoqNsmp4QLg2t35JRJ2lrBB1L20JVZj/PUh2k/CaqZLmQ9DM7V6
 cPBY3FRCDaFFeTZ9biidpr6rtNyGWG7ZvtYZsrdCbhx5n4ipoGLZcR7KeJ1kNqXI+4SY
 fW6C4aAxrx/3IO3IJ4oHL2oHA+DhiRuLwQgIpNiCZlKSfAN6u/jBJzeExcnNYYGkgPWc
 ZRxA==
X-Gm-Message-State: AOJu0YxCoD7uGXTmh9Kz6Bn8QTxnet8NOtOTmeqIG2R3bD9UjFDWORS1
 8CUDJNAYyuaT3p+NCQbhbiGbCNDDc9hUbmtAIVKKqtgryS4EzuDR1O/llkfeDVV6g00CsW0MGiy
 7eZs+JfWkKhrGGl193CTjJE2ck1xj+c0uhcIkmYZKLkz8xs/Sufk1RatHiCFl6Y/8+cIa6hrpNt
 zYOSQa+ROLRd9W70lH/5VtBXKAQzvP9Fi36A==
X-Gm-Gg: AR+sD12lD1EmtwXBHFI/0MerXvQ3cAt5O2ztq7PTfywlJcVBuDUCnR7xYPJHiLdjr51
 MkO7m18TGOprSGCOiXgZBulQa8Guxenk76Yw/FdMWZuU5rd2wCZ0697a7uEWnDSbHsREcyeW2mc
 LU8fzhx6lyOQjjeOuCwJs+fHYcGw1M66sg3PIbGn09lGxImi0GvFwGNhzx4173DKIh1upBi9rBl
 EiGFByeNpi7H4J2hPjAihWHIeSZsfyYtw2YUyWoet0X3GpqTyO+I7xXFY4zBLMou987A++UVOG9
 HZ1CpUnsj7OP49/TOK9sNdh34g4TbeS/51TZnm3XF96EnvhrnQe1Ak3SNXJAiigUVIyaHqf4fye
 /R4NXxTRwjxOsA0gXhcb0QA==
X-Received: by 2002:a05:6000:26d3:b0:47f:920b:7fad with SMTP id
 ffacd0b85a97d-47fafa9ead1mr459578f8f.51.1785180002918; 
 Mon, 27 Jul 2026 12:20:02 -0700 (PDT)
X-Received: by 2002:a05:6000:26d3:b0:47f:920b:7fad with SMTP id
 ffacd0b85a97d-47fafa9ead1mr459543f8f.51.1785180002351; 
 Mon, 27 Jul 2026 12:20:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a6d7sm50768176f8f.2.2026.07.27.12.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:01 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 11/30] virtio: stop migrating num_default, validate
 vring.num on load
Message-ID: <d6384ad1c15962092c2281efedc118152de6a794.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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


