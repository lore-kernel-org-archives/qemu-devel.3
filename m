Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61242F33A73
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eC-0004DU-0g; Thu, 05 Mar 2026 09:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e7-0004AU-Uo
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e6-0001oQ-ET
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:47 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a871daa98fso60893445ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720742; x=1773325542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aHj40MO09L5wft7G/V3QvqADmZQpukMj+vfDG5ALYs=;
 b=F9oi5hye5dvnC6U4mfavwSzru8xzikKHj1ShrlXq3Ut8V3HzieXyxg1ibxN1Y0QFjI
 DsEPYVv0/TYsbyfRxhJa9KwvEEYVdOyyfnTVfYWVlwM5htJTj75n9F1J5r2isyjx9KSD
 pYnhpyzIS8r3uCpcTfAmfutDCPGHn2mh9ny+mqjJQCcNRDC6/DlcqhYXv4p9Arg2pT4G
 wihcGAOX6sz0clCCueE2FxO+ur78+Ylslv69XfgNRKRlSS0rZgNDlw5CbqVGEcmQ+OAd
 GDudBBJK56dwiZkusQjnrQOFkxQ8tv8x8e2c+hsktFChGNi5bo4oWMa9Q0gZw9GPfOJL
 dRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720742; x=1773325542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4aHj40MO09L5wft7G/V3QvqADmZQpukMj+vfDG5ALYs=;
 b=MqAo9O3UR7mTvUywsIq2rac9Lq4aRHsKOpHdJObDvy7qEzcYcakZLRdxRaoKVJluoj
 pnlzXzneg//xma0lMiSW07xw5c7X/Le+QkuMGL+QDLYwGr5ql7rGL+/8JX7LsuCz9ELs
 nwVr0BY4ms0z/3FHr39Bt87NfygnJ4f5oDD/gGQe0zDnOzPcFBqVFabppwMxO8dyLQsF
 dWqhz7UYKeF3qqSnFFgGPyuyvoqO2sxvczI5hkvw26JLfx7p/azAR1l4i4yv0JXiHz3U
 PYym7boJFqg1S9B6/pGgvdOEbMiC0DsmYj+kkU4sMUq+ayi+WXfXfZH+motsGd6YkzQA
 UwDw==
X-Gm-Message-State: AOJu0YwRT+PJcCAm7qCCAQhLEGWsYRwD+ZbJ4CJ+2/Sk1cpgtkkAMvYr
 NHKTYIeW8kRc9kYQGIITM6XL529tpxoJfBf9rNyvAnWExZxhZaYNUwjDarlT0ZEU8kug2Q==
X-Gm-Gg: ATEYQzx6K3hSpb08Ech6LLgdmVfDhPOEvUIgN079qBkRF75MQf7kIGpJZ3j4ku+bVZ8
 l4gq9I9oqwxjmpE6tlZjDOp2oAYVOqRis34dMipNSHK+bRG/oXq9ygSoKo8oQ22Ynf68chkXrPL
 OR6YHyNIGgGAflsfTjn2LZngaTuOzRoIpKHlJ7z45D65yQjwE8SXmxpqf0ZdUae6JYWqCu0+vOU
 sRUYJGvFJ02kgJtV+HcDusIOmpB9TADC4DyvOEp339+qE9gZm2h7bIoC+peHahtd/G+yIFCXwrF
 LfRmsF5T7gxGf83Eg+7H9Y+m1Plof6zPvH62+4HuOBgHaqZzq42SsU4iSrjMySRq5vh1IBXP6Mr
 dM2sOcwof9KvP3bXjK4v2ACu2BzDQP3pmuq6DmeaHMZUDlu6I5d/Ad/vi8CTBVTzYOgV3W72RVp
 ggw4n4OApL6BAwJz366EV0gCh3SkXVXOi3EsxqFKcFKqcxKcj8iec2m8/ZuuO7HTJ/6Wg=
X-Received: by 2002:a17:902:db0f:b0:2ae:62c8:7728 with SMTP id
 d9443c01a7336-2ae6aa1950bmr56340155ad.16.1772720741664; 
 Thu, 05 Mar 2026 06:25:41 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:41 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 10/13] virtio-balloon: Update tracking iothread users with
 holder name
Date: Thu,  5 Mar 2026 22:24:56 +0800
Message-ID: <20260305142459.52559-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
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
 hw/virtio/virtio-balloon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 38bf1e84a1..4eeae48b50 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -895,14 +895,18 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        char *path = object_get_canonical_path(OBJECT(s));
+
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
         precopy_add_notifier(&s->free_page_hint_notify);
 
-        object_ref(OBJECT(s->iothread));
-        s->free_page_bh = aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
-                                             virtio_ballloon_get_free_page_hints, s,
-                                             &dev->mem_reentrancy_guard);
+        s->free_page_bh = aio_bh_new_guarded(
+                              iothread_get_aio_context(s->iothread, path),
+                              virtio_ballloon_get_free_page_hints, s,
+                              &dev->mem_reentrancy_guard);
+
+        g_free(path);
     }
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
@@ -922,10 +926,13 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
+        char *path = object_get_canonical_path(OBJECT(s));
+
         qemu_bh_delete(s->free_page_bh);
-        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
+        iothread_put_aio_context(s->iothread, path);
         precopy_remove_notifier(&s->free_page_hint_notify);
+        g_free(path);
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
-- 
2.49.0


