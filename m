Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2420EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsC-0000Et-IC; Mon, 27 Jul 2026 15:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsA-0000E6-Hw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs8-0000bh-U7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=YmU59zWgqS8VrLZEgHvG4qp6tbsIQ+Ieh2zCKMcs5mmB/LDa89hBbMNTuWAsDYpuSYVkwA
 JUVRxrfCE1WPex70dowlmgpF6l7jGNF1mUN22CREFAyn6IIVbgBR4mMdF587J5OTNXSvZn
 /K4HCQ0nZTQbUF/tONfuDzpgCbKqEA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ByBTP5jnOHqcW_uO1JPJCw-1; Mon, 27 Jul 2026 15:20:16 -0400
X-MC-Unique: ByBTP5jnOHqcW_uO1JPJCw-1
X-Mimecast-MFC-AGG-ID: ByBTP5jnOHqcW_uO1JPJCw_1785180016
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47407691804so2231215f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180016; x=1785784816; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=GeWCE+03ESFMJmjYBU0V9jtz4xViYmqwe5WQA6B/COtEihdh8WD3admAxQbCLTnTGl
 aRFs3gL/GvfthtC3Yo6avw5MeTePgObSsilovzLL4Dk27BDTndLxDtRuJa8C+W08ZXrj
 bclRaGdb0yBHevLytUTYHjih7C3aXtI0nwh/qRuMYk0RifWsmbzSuA+pQNA9F1uwA1Hx
 yBIlemD4IljwObVbilRwVN3VdOxYm8MfKDMP12cIzhqWjTobQuc+iNZ105wG7Ab0wKqO
 drRF6PKhEyVaMXoziPk3FMCZcwt0FCVCqk8VWN/Tyxnbm9KWzKwRMPfDPLcuxkSBxLHk
 R8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180016; x=1785784816;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=ZYq3xmWtCqpWN3/fYkaO6lYnXNtiPEKqOp90uy073lJgrTXp8+vfWWpSmQX5opeuw1
 5uN0ggWLQ+9hY4yeJ9uravIE0NkO6EZtFZSFC6kq8sqbUKwdeohcVOwFSUqohGV5jg5T
 xBdRv6jGnzkfyZ40UBlIO5N40GPeN9Dl97sw4jzgnwz+jW8bctXiYywnDYnx6iPOVurk
 fIGOlKokVKBvGgoEr7uW09FAIjvi7TSfYvoyyA2VNAROymxsdLwJMi3/BwChAVKcFoLl
 a5nK4GQbTZGmeE0MnhxOcHtpGhbXgGQcgx3N63wOWd9eSZ6/gPNHEZUIQO0+LhdNVWU9
 zXbQ==
X-Gm-Message-State: AOJu0YwLS1jM0FYyFSn9FqTVz2Pvps7hMRSYhB2MBN+NeuX0IX0exZds
 OdLeewlqRZqYOJyREakmdQD/gOshz0G802RNuoqVMWrrmFyR5BNEbJCV5wO7yIdWwUEb8plTH+J
 TfzX8On8jbcDfNlKLzIexKJ9FItNYbcrFv2s+O19nVypS2qAXy5ifYaoOwSszf7+0Zmd2tAZpD5
 nc+dSmjsivlGb2e4LHxpKjekCAF0BXeu4aUA==
X-Gm-Gg: AR+sD13tCny7KhmCfM/iqouvWAMCuw78BpzaIUw7cAf95djEBtPz4/Tv+pIKEnd/UH9
 smnAfKDFfFr/1fYcr6ceEjtfDJAlZkOUtoMkWQRvU/2AepqwTps39oQSbvDg62Lm9loRm71uac6
 +doIu3h/rYXMdksjf6jIfT4J23CPmS2y0PVv2dzXkGR8iWzNhlu5iTAPZ5PgEw9hMrI2eusPYTT
 d++Wk/Gj3NR4eS2YHiJJ/XJp3+8rWZK/b4mxn8GUtbo4rrjrWypELIB0lwqqRTTvq1/L0GJlILX
 mQuryDhRjabtvhFr6H7LAL7RiEKC5P9QoqtX3Qk22VlQ5HXQ/IXyZspfnTu3cI7KlLY0HPqv1uD
 wlPNKoq8HlszXvi9B+l9Liw==
X-Received: by 2002:a05:6000:220e:b0:47a:e342:373e with SMTP id
 ffacd0b85a97d-47fafa8d34fmr441021f8f.58.1785180015479; 
 Mon, 27 Jul 2026 12:20:15 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:47a:e342:373e with SMTP id
 ffacd0b85a97d-47fafa8d34fmr440972f8f.58.1785180014837; 
 Mon, 27 Jul 2026 12:20:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm50322446f8f.17.2026.07.27.12.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:14 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>
Subject: [PULL v2 17/30] libvduse: validate vq size
Message-ID: <733a98a552e4bd68932de1f58bd6ea39b57b261c.1785179875.git.mst@redhat.com>
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

libvduse assumes that vq size (aka vq num) is below VIRTQUEUE_MAX_SIZE
and maps logs large enough based on this assumption.

However, vduse_queue_enable() accepts the vq size returned through
VDUSE_VQ_GET_INFO without validation, so a value above
VIRTQUEUE_MAX_SIZE (1024) overruns the inflight log and causes
out-of-bounds writes in vduse_queue_inflight_get().

According to the virtio spec, vq size can only be reduced, not
increased, so vq size must not exceed the previously configured
max_size, but the kernel vduse module does not validate this for us, and
we should not trust another process to follow the spec.

Validate and reject vq size values above VIRTQUEUE_MAX_SIZE.

Fixes: CVE-2026-61402
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3652
Reported-by: Jia Jia <physicalmtea@gmail.com>
Message-ID: <bf7e71b3139875e5e00fd53970c772d6c90dc2a1.1784888961.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvduse/libvduse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index df9ca5e56f..712b97b4c3 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -902,6 +902,11 @@ static void vduse_queue_enable(VduseVirtq *vq)
         return;
     }
 
+    if (vq_info.num > VIRTQUEUE_MAX_SIZE) {
+        fprintf(stderr, "vq[%d] vring num %u exceeds max %u\n",
+                vq->index, vq_info.num, VIRTQUEUE_MAX_SIZE);
+        return;
+    }
     vq->vring.num = vq_info.num;
     vq->vring.desc_addr = vq_info.desc_addr;
     vq->vring.avail_addr = vq_info.driver_addr;
-- 
MST


