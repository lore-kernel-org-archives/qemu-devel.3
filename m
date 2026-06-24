Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D8CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlQ-00069B-Jr; Wed, 24 Jun 2026 03:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHk9-0005J1-Jf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:57 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHk7-00036T-Mr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:52 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c897468a244so218767a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284989; x=1782889789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=UTVmrlz1sSo0mV75uwLwYq2GmAUI5ay1Rtr1r7Qmp67HQpOI4irkzMpA6GlxB8OcCE
 jPxUZT9Tk/c2mak+y9HARYFnzEZsl0WlUPCVNlRDlY2PvpHPkX6coU6GvB5z0pfKpSNq
 NhtM1osPq5j3RKvAt7FNvT5yOiqZHi+vxpHcWxdckno5X4CX55UiAkURpZoIIsKQJxia
 kARu5at/uLIwTOnoy9ETvo889R/6f5UWsctCvh/7/rB1lnJniHdiS2M4Vx12YgdZmBd8
 vqX8SS7i9oWcoTS/HoZGaAbRYV4HqxEkVlsWRvbvS4fjh96x03SUhL3tMfmJ24i9ruq1
 Sc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284989; x=1782889789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TMWKjSKfCkLdRLDphuftQNsCyWQFXmHbwlzRM8NRv8w=;
 b=X4MqcCmY6aSIt15U1LgOPvAhNVeJ3OgW6WFK+vFkvWAinlzcQH9CncMZTCS/KI/79B
 PXJQfeD9XFj4TDcMZ4p7VL3q64/KE1OBHbMwv84aT+AjAL71IsJhpkZWqM0jKgWfdmgV
 rBYzsWALp7K42DPXtldsUrVndVZHXJK+vs8lHO4YldNVf0wX3IOjOJOqXSkYEQdsxdH3
 9NHwyRuV7xUI7JU9Sxk0PZ4iMHiyPdRk/Ts47kW8YgovV1s/bcK5xaBbcJpLDlEBhVeW
 PxzleExjJMOvL0UouO5BvoxzHTK1RFAcQRO7SGoQVm9ASpRzSfQNo+yQFQTti7MDcOGd
 OeLA==
X-Gm-Message-State: AOJu0Yw0KBCfTFpd8ilWOoFK5bCoxhZ1U/92Y4ULFfABALWFPXXX+4BS
 og5ObqtkZiaTLPaLkkqZgr2BfEvIiYcO3ZW91PK8R9D4V351/U3ayqqcwpINy3zib6E=
X-Gm-Gg: AfdE7ckbbBwGkdTguzKCi3mGzU66lgxYFLooCA1FO2/NNjPasrGzKo4J+SVgzR93wQt
 ofzFEAHyOjj/U7bDRUvie0RzMABUYfCgBBVUygGjIVI8uDpuCtD0WF34QX2YzQ9/aex68B1p1CD
 L2r56/Rg7sRfUhHAxKbgF2aWSM+BJ8zbjt9JMQBkm81evM/ma++PegPRe+u2K9XnDM97bTg8kzr
 sthtTu+25s0xAYDS9hRugwDR3nAoI1sgAZCdFLarkqu7Kd52yk8frtZjwO3dyEvwnt+GjpI0IqG
 BiBnCLTTYcfzqXpMtvKBEnXHFTWdCHIyOOHcSSklGCqzyR+ZzJpfgUdimzk4gWRDekDXsbZMXV7
 pWWTIjgkYcKuLipO8he+XghefE5cahulvq0ZRim1z6m8sMe5UU7Ef8KNrzbqQvzStzfSZ8tVRP5
 tA5LyeLuVCBqJOI/Lb98F4Cs5HFzpgSEJzHyVULYjfY7DRCk6zzgMS
X-Received: by 2002:a05:6a20:6a24:b0:3b4:895f:6ac8 with SMTP id
 adf61e73a8af0-3bd2cfe0277mr2595596637.3.1782284989105; 
 Wed, 24 Jun 2026 00:09:49 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:48 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 12/17] virtio-balloon: Update tracking iothread users with
 holder
Date: Wed, 24 Jun 2026 15:08:46 +0800
Message-ID: <20260624070851.13342-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52e.google.com
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


