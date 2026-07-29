Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786DC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3P1-00022q-8c; Wed, 29 Jul 2026 08:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp3Oz-00022d-Rn
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp3Oy-000655-5n
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785328127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=lZB+X5ob5wwqfh6ZynqtDSRQc0S1FnqCVYB/Ky5FKCI=;
 b=ce+oTgZ6lx23exLWwnSoE7aXgcfjZMZGWYW5Zk0G/G3fQ+hN2xkreZKyz7SKAbDte93XLa
 MjTTyCmpoGW7uJ/MNQurH/dVHaJYHnsOECGXDBX4t6OqC5i9yrDKQqsKKKUn8GHYd34hNA
 qntvhTbsqGFvWv5gX6X1tl31ER1Mb5w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-ha4ewESSOvS_vgOx5gDUyw-1; Wed, 29 Jul 2026 08:28:43 -0400
X-MC-Unique: ha4ewESSOvS_vgOx5gDUyw-1
X-Mimecast-MFC-AGG-ID: ha4ewESSOvS_vgOx5gDUyw_1785328123
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso666113f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785328122; x=1785932922; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lZB+X5ob5wwqfh6ZynqtDSRQc0S1FnqCVYB/Ky5FKCI=;
 b=MMxsz1c4Zz3C8I/7+FixnPW5UY1pq1cYyu2jyGgQhYd19895H6kpOl3c8ziji5UleE
 2yRzk4s0UK+xZ78ZpxFBsnAnGvcL2siZJVur91hD1xSjvxuq/7KM9zy4zYPIzM4AE2J6
 rJlex+L5e8rXGBgAlNY9EKwu+VnmAoTk/kBVOf6YrprQXOm2JK9ar4wtcshiLcr3s6n9
 hCIWem+Cm33iaVTr6lwMFfaoNLl2Mbawnh490TMrWr2F04WC8U3QEQ/XMvV7s3cXHnB7
 gZF/+LKRwcqiwsWbz9sOxaVJYY9T8Pey+q07xdFIEtqL+Qt3RQpJxjljmjuK0q+s4NDG
 /5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785328122; x=1785932922;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lZB+X5ob5wwqfh6ZynqtDSRQc0S1FnqCVYB/Ky5FKCI=;
 b=UEyeJBDnF98C3hYlQ2bKRo72KbA4zxKJPWdulh2k3WbKzkwygPiajQak4CJW+zVrpi
 b9koNChny+E6HYWNybG8821xhjtQWu2q8h+Ifd9jKmdwTCUTCcrP6hOZ14HuNSuXMhA7
 TxKm/MOcHzxeaYf5NdHZTHTyVG+mWGFBB2GkuN9C4OtpPP3giD6B5FvH1T5Nfyh+tQ8q
 zGj7GWtNdebTFrVkVW87v6bf1KD2O5nZ7O1pMkIcWw3/24qRJ0SaeVBjJ6N9EwgY+3HZ
 7Y05HPk8vxhYWvRtbDYir8LpYk2Uzj+5IvUGtpy8usttl4YKnwdXJzQ3KyC7D5uIrVvc
 ZaUA==
X-Gm-Message-State: AOJu0YwjHTz2aXKZFz9TmLXXkiCgnOQnKJgwPxr4nw+4/JmaeRg3ijJf
 ze5/4ARcpEKvSGcU7+8zb+kotn1ZRkBxyg4umqf94CCUtX/fFS64GGAiTlUVf7foyEAMLz460+t
 kXGnOa+SxHs8VQKB6PicsOXTv2SR4uiIX1euWWOMmc4CVRo+Fys+WRpKBe6sAKKS/g5zPVqNkyL
 DN/ieN5HN68+Q4blIW6WtoLdiWdp+xnfLJ7Q==
X-Gm-Gg: AR+sD11T/+WJT9adqtqDFdL2Z62PXGP4gXN42gGU2NR44VEBX2rfaL6Hh1ieygqHcC6
 PJuzMH0BpTU64bxHG+YUO6e/ESg6MCTv7Qlj5rht5UExkB9T9YSgVjIwX294Ce5YYagfYZ7VWEn
 CFY5f+QWz7mGEsfNtb062M/HTm9vhhPuUWTxXmOEpwZRtXfa3UgeMlmX2hB91mYnWEjNeWxWO+8
 kSrYtMhNNjNE+yl6OJBceJRqep5uNZOe6ju8C5PTAWo1s6bLVuPYQ01Plc1kzKWG9J6aAb61a06
 CchCtaVtEh+4HmuB31CdBcCNbawrwBUH32ZVljCQu/wBqtx0TfxxeKX5ewZX+/PYwBtDAwLnd3I
 +m8XyslXk4KZ+0pbRX+qpY0E=
X-Received: by 2002:a05:6000:18a3:b0:47f:9287:6356 with SMTP id
 ffacd0b85a97d-47fb1ea77bamr8286208f8f.32.1785328122447; 
 Wed, 29 Jul 2026 05:28:42 -0700 (PDT)
X-Received: by 2002:a05:6000:18a3:b0:47f:9287:6356 with SMTP id
 ffacd0b85a97d-47fb1ea77bamr8286148f8f.32.1785328121875; 
 Wed, 29 Jul 2026 05:28:41 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3a88sm6948030f8f.6.2026.07.29.05.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:28:41 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:28:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, mhun512 <mhun512@gmail.com>
Subject: [PATCH] virtio-balloon: fix free-page BH teardown on unrealize
Message-ID: <0967d574d9ffe469edf5fc16da86237e54a69c34.1785327742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

When a guest triggers PCIe hot-unplug while the free-page-hint BH
is running on an IOThread, the BH will keep accessing
vq->used_elems array when running it. Note that qemu_bh_delete
merely prevents new BHs from running, it does not wait
for already running ones to finish.

We need to wait for it to finish - do it like virtio scsi and
run a dummy oneshot AIO in the same context, and wait for it.

But there's a twist: BH could be blocked in qemu_cond_wait,
then AIO won't run.

Add a special reporting state FREE_PAGE_HINT_S_UNREALIZE to make BH exit
immediately.

Cc: David Hildenbrand <david@kernel.org>
Fixes: CVE-2026-66899
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4079
Reported-by: mhun512 <mhun512@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-balloon.h |  1 +
 hw/virtio/virtio-balloon.c         | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index abbf339718..53bbaa4c9a 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -39,6 +39,7 @@ enum virtio_balloon_free_page_hint_status {
     FREE_PAGE_HINT_S_REQUESTED = 1,
     FREE_PAGE_HINT_S_START = 2,
     FREE_PAGE_HINT_S_DONE = 3,
+    FREE_PAGE_HINT_S_UNREALIZE = 4,
 };
 
 struct VirtIOBalloon {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..07d519cf6d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -35,6 +35,7 @@
 #include "system/reset.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "qemu/aio-wait.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
@@ -519,6 +520,9 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
     int i;
 
     while (dev->block_iothread) {
+        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_UNREALIZE) {
+            return false;
+        }
         qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
     }
 
@@ -912,6 +916,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     qemu_register_resettable(OBJECT(dev));
 }
 
+static void dummy_bh(void *opaque)
+{
+    /* Do nothing */
+}
+
 static void virtio_balloon_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -919,9 +928,17 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        AioContext *ctx = iothread_get_aio_context(s->iothread);
+
         qemu_bh_delete(s->free_page_bh);
+
+        qemu_mutex_lock(&s->free_page_lock);
+        s->free_page_hint_status = FREE_PAGE_HINT_S_UNREALIZE;
+        qemu_cond_signal(&s->free_page_cond);
+        qemu_mutex_unlock(&s->free_page_lock);
+        aio_wait_bh_oneshot(ctx, dummy_bh, NULL);
+
         object_unref(OBJECT(s->iothread));
-        virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
MST


