Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D0C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEo-0003Nq-Fc; Tue, 15 Sep 2026 06:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEk-0003N2-4u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:18:02 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEO-00035V-KU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:58 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso3045202a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467458; x=1790072258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aMpJO296pImnzMQ4cy37vlFU1XekjtBMhU2RmUAJ+r0=;
 b=neLwXr5IMOHGwvokoOXbHkNHyqc4AQQwqN24es79O0RJi32zFewFSpn1iuyd7bgSy+
 7KR/4+IJCZVLjAgVzCU48BN+frVQpNALnhfMHqhAOfTujsOCYhMHptFLgyKaxPGorFMt
 HiTn4yfWFV+bsKOjQEnrsWopmJScVfmu3eOJN3ndxoJBGO0hINmZg1SMbsu70NyM3Gsf
 6pApJq09iRFJU2IZNnEca12swqsubkz/txwRfFcDQP+7PbogDYt0vOnqazm4RlckIvhC
 bcFW17geBr01FCxTDATme6GihntH5ah9ZluxeIy4jj0ucCjtFdAFRkJyJoWubAxoEcJR
 grOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467458; x=1790072258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aMpJO296pImnzMQ4cy37vlFU1XekjtBMhU2RmUAJ+r0=;
 b=Semx9sM5jDb4+OqSc8S52I496XHd0zVSIyxwaRB2w7Wm7Ohplqfkqmo+9+qmDMN5/Y
 +7Sm1JVrfPS825pje2in6WUyRH+6mppgO3Zhb7YW/KbmHBTGVsrmrmxfbOz7WBdzWWqQ
 EOo9vCJvf29iMeUCGisolcN4N+we14nd6dl+e1XZyBOsKRgUXl7Zw4yvMG2GABApmTP3
 mdN+LtgTajIzi/WAhVcEyysXgPz9HlCky5Cp1JsTbPEQtmd/pEyiu0yBVVrNzgKaLfn4
 6ZPOSe3+6xxoWEsqcIQwbTt+RqojLU1fQOq52Ccsbsn/y+EsLZtHoO5leZwB4jPwjU2U
 W/KQ==
X-Gm-Message-State: AFuF++nB2kBJopjI+WcCReKBWW69SUTFOljTcn9PKgfI9A7n4WjtOzsy
 ymYhkPwR/4HmY1QrI+/TbZImg+DeDFSwjA62b2UG8YHejl+bO3zedMwZcjUZAhuglqE=
X-Gm-Gg: AYBFou0hiH9vm59JjgbgG/nlRHzCXOp6c6pNX8JzE6geQPF3Q16c1zXGz4hlwv66pqY
 TugBumqRRiPHTMLXZ9ZBT2ingWhNTZY8zpODI0q0KxoTPPfdGdc+xhcmltOMJ8hEZnFTzkKNgaI
 SZIvjN09evMl1jH6geZpLL8IfB0CJwZDyKwaUPODTSGoCA1/o6KoTDwETlCadzJVvH70ZntM5VA
 YXq8jN0pPnqSq9DfQ5oBAECKsI9h4rU8iexM2U0E2VifLcMtzx1LC6QSUqofILeyNL5wjZ83jYU
 Q41x0nWHZZ56UiJwlGaWLuYoPhPVc5ycOE/EBxcLiFX/aJteYGOI68fXraPNGs7LvfWYGAh4KeH
 x13cC3tXZj+H4rQ1g/XiO3Mai+vHnC5MLmBTVa1OmAte9XpnBsoQluq9fq5eouv3mAxwEbXDDTs
 N9eQ5tHhbf31yV6UXMm3jQnOjqPQ7kitAHVdDgZkiFWEZ/4NJ5f5g3esYkv13WWe19bRkvxBBdZ
 4uIeDQXeNMDZt8O/gO66Mj3uuM=
X-Received: by 2002:a17:90b:1c83:b0:39e:27e:21b3 with SMTP id
 98e67ed59e1d1-39e027e229fmr5043656a91.9.1789467458389; 
 Tue, 15 Sep 2026 03:17:38 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:37 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 08/13] virtio-balloon: Update tracking iothread users with
 holder
Date: Tue, 15 Sep 2026 18:16:50 +0800
Message-ID: <20260915101655.3216101-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/virtio/virtio-balloon.c         | 21 ++++++++++++++++-----
 include/hw/virtio/virtio-balloon.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 07d519cf6d..cfc581940e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -896,12 +896,19 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
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
+        s->free_page_ctx = iothread_ref_and_get_aio_context(s->iothread,
+                                                          &io_holder);
+        s->free_page_bh = aio_bh_new_guarded(s->free_page_ctx,
                                              virtio_ballloon_get_free_page_hints, s,
                                              &dev->mem_reentrancy_guard);
     }
@@ -928,7 +935,11 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
-        AioContext *ctx = iothread_get_aio_context(s->iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
 
         qemu_bh_delete(s->free_page_bh);
 
@@ -936,9 +947,9 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
         s->free_page_hint_status = FREE_PAGE_HINT_S_UNREALIZE;
         qemu_cond_signal(&s->free_page_cond);
         qemu_mutex_unlock(&s->free_page_lock);
-        aio_wait_bh_oneshot(ctx, dummy_bh, NULL);
+        aio_wait_bh_oneshot(s->free_page_ctx, dummy_bh, NULL);
 
-        object_unref(OBJECT(s->iothread));
+        iothread_unref_and_put_aio_context(s->iothread, &io_holder);
         precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 53bbaa4c9a..5c3731b3e9 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -54,6 +54,7 @@ struct VirtIOBalloon {
     size_t stats_vq_offset;
     QEMUTimer *stats_timer;
     IOThread *iothread;
+    AioContext *free_page_ctx;
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-- 
2.43.0


