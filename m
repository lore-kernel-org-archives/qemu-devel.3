Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78233C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1x-0004Gy-OK; Fri, 14 Aug 2026 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1w-0004Gl-HC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1v-0007x6-4b
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:20 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso12817715ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729758; x=1787334558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hyx0MSmriiqZnzNWR+feT0XuJTWw3S3P95V3QuChHSA=;
 b=X1QQs3AfKlyLHZnM7FFqNp5A0hHAx1Lfv64RNtAYF4RRd/aZoou0cIAG7zfjhXJigd
 bEflTKDJ+zpxzuX2l2UJegDa6goM+xNNPr0q+9zXwxxFd5OV8GRriqpBJKIw6Sn8+oa9
 FQxwdkwq6nwrdQVgJT2Ki5Pqul8kfM6k6zOcSZNDzbsqWcS94lOP1CPDL/DJp0d1a2gQ
 0ay+sTdZMVsxnTJ/eWUVVh//hXM1YqvsdzOtmN6jrcm2jNyQzVedN1heAHL8U31sS6PR
 x0I6+R5zV/bOIYOC4rZcXEc3wIUzdCi+Re3mWs7JSOKvoR9zvYL4sXyjA3u6GYzhQhW7
 +14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729758; x=1787334558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hyx0MSmriiqZnzNWR+feT0XuJTWw3S3P95V3QuChHSA=;
 b=DFOf7JCvj3OtRIsMK+Kls1WDBXsSSwl7lBHtr0HakqDWQqOwGeWfwEhOKd+auxbCAi
 5qVCKZ83x/i3rMko9rrWLx1+sutkSaNJJfRWMYvcxtd3Udk7/2DhI9n9dcu/LJNfcXR2
 ZWtbwJWUIMoy0PdGQlRCglQpuGlMPjc7UUMgc/Uel8Yv+0IF3zG7nAAuydY52mXCr8ZY
 2Pc6wPnZDgc+QQ5iH9ebTpgLfeX+OHhB9qTCGuZSW0ThbxrmLvng0R8puVAB5mBsr1Se
 8chE8doJnVFPhm85gP5H/yd5mAZ7hsVG0J0Ix56JoN2ovXXW40s/ULD+1BXpNfOtHun8
 Jw8Q==
X-Gm-Message-State: AOJu0YwVXrWap+kC9qv+8AQH0vLIqtKIF+bhgBKMYgzDpk5oPr0tNhvu
 KBNsy9N8F3iTCPQl5dGgDWr13Y1+FgLk4mqk2pvRTPTPq6ENDAcgC/G0RIS+ibu8th+hpA==
X-Gm-Gg: AR+sD12jVn38HyY7/E8b++zKkUvKBDIM3ZQweCp5g+/A3bHElMyZYdPCrpLHdG2xBTc
 KGkaoepMJ0Nix6d1ATYu6/orFtLlqayXGZBcfteXw/hobmhhKK5mc0nVuyfwkz4pE0zFzcaw78s
 4KSvEzxNK2AEwpxiFduAzTQLjjtIo1NDaaySxY2x3ByDdMu2kPk3BObJiR4mMBB2YSgBdovPyAn
 wJtg6my/KRJ0Dj+0aX+cR31bENSahgnnzjTK2hj/xbqfWHjx7ewP4aPh+uhccqpx+ORgrtqjaK6
 dZrHhh6ht32BNsnuMncZ/Nwp4A8Es5poMsnLlNMJqVTnkZFuKf68jACQ/nV0G1SYmNizwwg6XBy
 PwdTQHmiHqg0+eLXADxBAPXgnv6iAtKBzmxJuA5RLUBC4RHtjWPA6XtQG9wpJwHUcyTC24j0pLV
 U6j3CAGgzPRNNg55UrY4ZZ75vKvMFodxkQ7m1JoiTffkA3gf2Cyht6Y07iSy+6/gStyEd2aRUEO
 ocqxiLrUTMfaiSptm4=
X-Received: by 2002:a17:903:9cf:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2d3b0d1302amr95401795ad.14.1786729757616; 
 Fri, 14 Aug 2026 10:49:17 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:17 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 10/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Sat, 15 Aug 2026 01:48:24 +0800
Message-ID: <20260814174830.1691540-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/virtio/virtio-balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..7c9c8d2a41 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,20 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
-                                             virtio_ballloon_get_free_page_hints, s,
-                                             &dev->mem_reentrancy_guard);
+        s->free_page_bh = aio_bh_new_guarded(
+                      iothread_ref_and_get_aio_context(s->iothread, &io_holder),
+                      virtio_ballloon_get_free_page_hints, s,
+                      &dev->mem_reentrancy_guard);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
@@ -919,9 +925,15 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.54.0


