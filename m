Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F3AC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Px-0007lt-US; Sun, 26 Jul 2026 17:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pv-0007kc-NF
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pu-0004KV-62
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=AKDjqBA8g/+QYgFWm5WkGEjMbmDVSzr6dbVqcQbttTVg03xY4smteKGn8nWmLFbyxIaNbV
 NG0JKGp3znUYubZE0knjaQlVQISLlOb9JGp6vW8ZDWtClcQGd1mQ9ZNjeA0iDvVlDtIYOP
 QRQSNhepzI/BQUlgDKihS750E0MUE24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-wvZQ-NH-N56SzaqGN9akQQ-1; Sun, 26 Jul 2026 17:29:48 -0400
X-MC-Unique: wvZQ-NH-N56SzaqGN9akQQ-1
X-Mimecast-MFC-AGG-ID: wvZQ-NH-N56SzaqGN9akQQ_1785101387
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so972903f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101387; x=1785706187; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=KA4LZPW8CaMKJXu2h8DmtOv9PR1J0xIPB1u+ICjM92BphNt8vTGdg3+Aezanv+qyRj
 +9ePsA5fLXRSyfFAIWLJrJjkTJN6/tzPorBM+Pagnw34/lGbOWXOmE0ZASH9TYjl8SO/
 fgbgqp8ZcMwgDBMdL2KzTPoaULB/F10T0UmA6dVPXH5SBY4FKmmdJweGGi5EHFUauJxG
 ntOhAGFnyMCrcb/k2alIH8zp7LQip/+RtRY9VzufUt1vaAxzR7cRTdpRpCiWrmP4TnP5
 i85e3EwC6f8MniBMyHDjArKwooiEdzV8LL70dSoT0qJMCMNKMh5r9P6/7ZhOBj7Fz9dq
 UbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101387; x=1785706187;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KIzOAIfM1reEGtLuVwKSJi5MtWyPECzNtg489klcaAk=;
 b=ElZw6gtvNw+RRscUdh1hx2JvxW9BifYBEoOHRyyT81DBZljp4BelFBo9V8DoUUUOxH
 he3PhW1FfDRIFdzw+hr9Wn2sKMs802ANkW0wEarBW6fz/t56JmfZk0FkPN5iSLCpZtDr
 171f4zwWSHwj95+FdIDYtPWpov422y/W19BvKMxz1Dia+d0VoUWNLCgvYlu+uCqXDfKK
 rTDmWhE8PHKK0wSiLTfCq7DsWbtrOMqA7LeFIpfXLDRBOk7hw7coMGkFz7mxmmNZ5ayW
 OIehVnIYUwgTi0NaIoIiGWvWdVhk/bUXYB7zJdp/lAMn/dN5Xy9FvTpy5N1PLfosmf6Q
 /OuQ==
X-Gm-Message-State: AOJu0YyarP3cjw7jaCoJNnGxILHeutAFL4bOtJDpOjnZvmHgGuLrAY1z
 zj6FE+qv1ZknoRZmvuPY46t3SbSkkxeuXaSREPmlJuqDHmiIPgrN3McN58yLiyJSW2HR6Z7N/3u
 GxyoXXrsWfxcPXMFyhfTtMw2ZItV6UxWqB4oUExTffrPUFrDo7G50ypEEP8Bu4rkktO2CIbX/wO
 1gukvQMqukwLJgEvC5Mz6nM6xoDigDuP/DDA==
X-Gm-Gg: AR+sD132xJugW0nrcQ2gR1cVjp+UB9yh6s1K+7ruSxwjm6/46Vb9sRZJc40TF0io4v5
 6ZTRRfoHtDcA7pIzxIO3Tq+i5Q8EQ3MJY3NZysE63PzKZyRx0PBOEtWEMlENDbHEYGYJgiZDyFp
 bHAZVN9L9X1jdH+HXry7Djjk3ihYFFOrqQiFFUGwZqw59ItK22W77jRoUh/DQaFeh6bZZ9DJi7n
 xZYeoLoeCewOaQT+m7DlV6DAVZz2uQHMnmSl+fTE2A1hJXVZdnwBTUZuG4meB1WB15gT/V17e0W
 nMyFoZ+G04Vc8jEHiS+9X+QZMKBN2bPuYLgw+A+ELMDoKKLxo72tJyMXfrpP5sgfXPWuARz3w8O
 yNCRaWhn5vdXDuDpZAilwqw==
X-Received: by 2002:a05:6000:2088:b0:47f:90f1:5dda with SMTP id
 ffacd0b85a97d-47f9fc8b40cmr8709369f8f.1.1785101386741; 
 Sun, 26 Jul 2026 14:29:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2088:b0:47f:90f1:5dda with SMTP id
 ffacd0b85a97d-47f9fc8b40cmr8709336f8f.1.1785101386289; 
 Sun, 26 Jul 2026 14:29:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm43655892f8f.37.2026.07.26.14.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:44 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>
Subject: [PULL 18/30] libvduse: validate vq size
Message-ID: <08edd13354e90ad760d5c2a2fc0c73e90836a486.1785101237.git.mst@redhat.com>
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


