Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F9C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ngN-0004l3-Gd; Thu, 10 Sep 2026 18:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lMD-00037d-CA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lM2-0000SX-Bf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=QB1JfPVbj6xkusTXi94NBzLh6ONztUZcFOPWgJYKN4uYUITlgdqMJ7Ic41q6M+qKsFwRkJ
 04fMu4Ifs6iJwVlVHr2Z3oRjFXaKksG45/3k2MMt9stdxkAp+8pays18s5CfzNcYMEKbRB
 ij7itHdT63t4c63HKFIpGl40SZqPra4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-2U1ANRveO4-xnfPjwOsFbA-1; Thu, 10 Sep 2026 16:12:08 -0400
X-MC-Unique: 2U1ANRveO4-xnfPjwOsFbA-1
X-Mimecast-MFC-AGG-ID: 2U1ANRveO4-xnfPjwOsFbA_1789071128
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-485866e0066so41758f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071127; x=1789675927; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=sB7WJBAHm95m5T3A71gOTjFojMwDXEHYailmOnJfcZbVtBIyZ0Cfe+eRnRKopNo7rs
 x2/9J4dBdf2KtgldBZMfzQVayvX2wi3F37ZSACnr7rKIOl/xxmhtud//ZEVoQBqM5j7n
 vbZkjxfdTX6wHh4WEVGsGTKK57v+7tHqSQsWYOLFYmFv/z7QX7GdIIanh0g6rt5mnSKq
 zCU1ygQ6ocwC2EpSEkPrKM4QFDt+WnzcNHRGVH6dE/C89v0w5n27cd6nQTmpVWOReJh+
 6RGUqAjMUkcxd/CNwgoU1Fc6L4lRZDgm3w/tOaLGsVWbSNKEmfcglkFbOSaKBhV4Llqh
 I+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071127; x=1789675927;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UIh1PwEycfZASKTI05iblD1tmogo/rlgL3ovx7Py+Kg=;
 b=O/Q45B++RXGppvs3Mbb88cJxVTaij2WXevK/owpvelD7VlaATMHD6Ndh3I9taJJgJI
 X+WnKS38lP7OV3JdHZNVQHtyfMk0pg6ixIgla4yjPS0ydJktmk6fwwBf60YGT3YmteLu
 4AIxrlvqDJOr0by4JNIO/f++ka1sU4I2KeZS76aqS6lR3CkuMOxN6l1sDw6aj1l+X7uT
 bMO+yce4w4YhGpoaicVPm8Ahh/WL7Uy0cUArLpVLKMZPbnWf6bEjAZOrLyh/FdDpHFHC
 5rWIq70nCiVX/eF73a9nOnSB5qKj2sh7DDcdq/MvQi73WBNZ1eMx+rmF33mS/0otK4Vi
 8Mog==
X-Gm-Message-State: AFuF++lPD+4eRRRYOYWABPjI24hUF2RSZldbqL4iK6qlhBsn/B7BiMPJ
 td+2FPVs14FnylNVZzaKvvliNciA1CoI7MORkizss1ZH0Qqa0CU9OmljoSwTIgJTswjlmNw+Xd/
 XkLLHtbXYLWWqtrnaFUJvUHNI0p6Wc/1DRTeaUFDyXOd9k5OL8aaG3ucyXOYlcS54mIkij83fiw
 JeltFPJqV40C0i7qyJrrqrckc7QRMatRYG8g==
X-Gm-Gg: AYBFou3XKqX5t+pENzeHgJ21OeUZZng8Y7yo7kjtiliE2/125+zt88TJmMKsPYvh2vt
 URDWl21yOLMvn+CBUq9GZfgXD9Kr74VOIJwJmZ5rFJTLZiUk9caShC3Zn7ce3yTQdHwYrrxkk9O
 bpEnzz0L5UpkwQujpPT3yxoONAaWa+iG5/xqqUoAMRHSMK95IEfEyvrGji0DbSbF2jit5rXbTwy
 ne0FSx6o/kuSaUVY+WbhsGWWrHulKntaHiqDZGtIDa1s4qXLq9UvX9RImtwYV2G6Zgq1jrOyDxY
 nfnUwqPqzLhREYOSPD9p9Ez8P6UDijly4jI7hVFATDRLnG1lNXhir8hvMDhNkP1m/QMyl4TU1wk
 wZj72EUkOJNrO0p0pdfykPCc=
X-Received: by 2002:a05:600c:540e:b0:49c:e1b5:b2bf with SMTP id
 5b1f17b1804b1-49e61645616mr8756885e9.0.1789071127477; 
 Thu, 10 Sep 2026 13:12:07 -0700 (PDT)
X-Received: by 2002:a05:600c:540e:b0:49c:e1b5:b2bf with SMTP id
 5b1f17b1804b1-49e61645616mr8756405e9.0.1789071126559; 
 Thu, 10 Sep 2026 13:12:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62217965sm1078175e9.2.2026.09.10.13.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>
Subject: [PULL 18/90] virtio: reduce code duplication for split ring
Message-ID: <47c8210827a7ba1b85c3779c252b0260312dab0d.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jia Jia <physicalmtea@gmail.com>

virtio_queue_empty_rcu duplicates virtqueue_num_heads
for no good reason, let's not do it. As a nice side effect,
we gain better handling for misbehaving guests.

The virtio_device_disabled() check in virtio_queue_empty_rcu
is redundant because virtqueue_split_pop() is only called through
virtqueue_pop(), which already performs the check.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260726012857.1580646-1-physicalmtea@gmail.com>
---
 hw/virtio/virtio.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0b2fbbed3f..c9f9e5b511 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -717,26 +717,6 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
     return (avail != used) && (avail == wrap_counter);
 }
 
-/* Fetch avail_idx from VQ memory only when we really need to know if
- * guest has added some buffers.
- * Called within rcu_read_lock().  */
-static int virtio_queue_empty_rcu(VirtQueue *vq)
-{
-    if (virtio_device_disabled(vq->vdev)) {
-        return 1;
-    }
-
-    if (unlikely(!vq->vring.avail)) {
-        return 1;
-    }
-
-    if (vq->shadow_avail_idx != vq->last_avail_idx) {
-        return 0;
-    }
-
-    return vring_avail_idx(vq) == vq->last_avail_idx;
-}
-
 static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
@@ -1773,12 +1753,14 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     address_space_cache_init_empty(&indirect_desc_cache);
 
     RCU_READ_LOCK_GUARD();
-    if (virtio_queue_empty_rcu(vq)) {
+    if (unlikely(!vq->vring.avail)) {
+        goto done;
+    }
+
+    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
+    if (rc <= 0) {
         goto done;
     }
-    /* Needed after virtio_queue_empty(), see comment in
-     * virtqueue_num_heads(). */
-    smp_rmb();
 
     /* When we start there are none of either input nor output. */
     out_num = in_num = elem_entries = 0;
-- 
MST


