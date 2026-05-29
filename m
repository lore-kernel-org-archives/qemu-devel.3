Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1BDCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rf-0004Cx-Ok; Fri, 29 May 2026 17:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qq-0003WT-5N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qi-000318-AT
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8422a92b6d6so34922b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090463; x=1780695263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=ppbG/Kyh3/XCI6rmDz0iST4lDckfEWgjM4g4u1qUagwLzSJ0dNMPUVrD88AMEwpxP1
 AF4kb+skfH9aS3s5tVlkdeOgKhjz/+FXvlgD7YOlEXD+j59gh/zyg0Jd8WzELk7w6rHD
 /ur0eW4d6jvphmGBcj4VfevEmGGkY6hZUFbOH/+rP9v2NCryoBVWsc95KNC76AHE+PVE
 cd60P3aV9jCBFJmYFplqdjto/gGWhqTqE8S4yWlUzYN0vjMP8g8kzhobLiMkJRo8lWcQ
 srQyrZ5FA8jf1N9zp62ljWemIu7wgoqTs8d5gNWQoVkZRu9p5rG/Jhz89yhFIPnUEdMo
 xc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090463; x=1780695263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=VaiuHeZTJo6Umcthu7CV3l/eejyhBjNYGdSoYSElIKAYuFKFj1tvwuVQRjbfQYNEzP
 uQYOvNFiIWo/9oMgTuqYlcuwlNN05B3q/PDn35FBkG1gzw8oi8y+XHiWfBaKATvS4Qxs
 mly5KY9uAOWzZYwtqUfoD3xmkIK9SPXc2yqSByblvmqXlnIjjnLtbhZlXF2R5iXUqLoH
 0NN/wBUgDst5KYSpX7jFPh6bl8A9tJu/1Hk1O9e5PFhww4Llkzk2RzZryVqjlM4Q0Ig5
 U9OB/i+fxQE+KC+3qBXqfSS6gKVGKp+lKPg9o9j+AiEbyS8d6lIyisoe0VQtybiHG8TD
 9Eiw==
X-Gm-Message-State: AOJu0YwJrHrvHvyvKF335pClYYicxOndq57DqpB06WIToS5eUyAMLEm/
 /AjB0oousW5XCNNISfjrsabdE3EmuOXecZtkt8c9NtGs+OMIJxGNha42RwVl3D+g014=
X-Gm-Gg: Acq92OFFOjz75MI7X0Ap61WRrg9JCyPTu7oszx8peZVKOu8EStmVxLnYu0tye9wzhzq
 2jsFTfKapZ1pXTj7Dbf29g2pQhyF7OURJFcIAgSymFJGLTDfo4av+Q2sTZnkz2NTiMsO5KTpxSK
 KaxQ4Vey7T51urKKE4Ftx6Wlv8m8F2TELjEe6geCdGFC08ZFZJVamsmvfywD7wvXRp3t4eWjoyX
 gUB1ITCiCZdgOdljc2/cfR4VkOXYOy80bNk53D72nTMYw31eFY/jBRHOIApBrMes9rUVc6cZeRg
 6IWthS3/ysjaNHmsRoJtRU1jpBYKCJKXmBRtG8y/92Cdpze5KGUhQOgOQC83+CEYq+KeyzqAMpc
 jnnOu1rHSK/0xy+tKUbbNLYXrqQ0lzNIT01RUtWTfeGFVl4FSYyCYL1dWOeSQF6SXO5PaU6OzPW
 Ia3NgQKvqqGNIMRCMLDaayXYTqGQYJPMVuS0kCdDXdziqkKmlfpdep7lIEsJsgfroPvrwnXiII6
 Q==
X-Received: by 2002:a05:6a00:e07:b0:82f:7762:3eb2 with SMTP id
 d2e1a72fcca58-84210b38e3bmr4025943b3a.17.1780090463257; 
 Fri, 29 May 2026 14:34:23 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:22 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 11/15] virtio-balloon: Update tracking iothread users with
 holder
Date: Sat, 30 May 2026 05:33:17 +0800
Message-ID: <20260529213321.96271-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/virtio/virtio-balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba2..e9d023b4ec 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,14 +892,20 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
-- 
2.49.0


