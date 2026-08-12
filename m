Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840B9C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8hF-00058b-T7; Wed, 12 Aug 2026 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hA-0004x7-Kt; Wed, 12 Aug 2026 09:08:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8h8-0005SU-Va; Wed, 12 Aug 2026 09:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=OD+xwUOWWtdfFuSq4eqEPjDzX9m2uBdGuPNgQj9dZkw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AaAibgAKp2Jxy1C0TynatRVXzfgYEm9SrwBd1JL2VAPK3RftzMZmj4MkAfKriZa63
 JmK32YewRec5VSwOTFBLE/C+QZrXCmBi5PFjPOr+Ex8gqtktqlqCGD0r3smicGR6DA
 MuoYa8DPLPExEe6Mtm74eBs53lIEOAMnC56hfulhH8+UhBGE0sleSsz7z7b8AEFPTb
 MNHRvN6uowOPgUBTtIszn6Qct5N2w2bmRu209p5J0HmJQcwGtL7jGfMoaPKTAi6JO5
 Yg9sS3HHubsHbcqN7sACNR0Ch6x6bxaN2pMi908RUZMqtOue/+LZYPwSGeo6FVhWT0
 feM0xZC7ZlXbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2232B1CA4B8;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57839409B9B;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 600C52F906; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Jia Jia <physicalmtea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 057/102] hw/virtio-rng: Fix host use-after-free
 (CVE-2026-50624)
Date: Wed, 12 Aug 2026 16:01:32 +0300
Message-ID: <20260812130233.621965-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

Fix a heap-use-after-free in the virtio-rng frontend when a delayed
rng-random backend completion arrives after the virtio-rng device has been
hot-unplugged.

Fixes: CVE-2026-50624
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3917
Reported-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724094931.3005968-1-lvivier@redhat.com>
(cherry picked from commit 0be94d8d9c28e6b7235b34133d057090fe93be6c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/rng.c b/backends/rng.c
index 1f6fb106aea..350cb0f8ff5 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -68,6 +68,22 @@ static void rng_backend_free_request(RngRequest *req)
     g_free(req);
 }
 
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque)
+{
+    RngRequest *req, *next;
+
+    QSIMPLEQ_FOREACH_SAFE(req, &s->requests, next, next) {
+        if (req->receive_entropy != receive_entropy ||
+            req->opaque != opaque) {
+            continue;
+        }
+        QSIMPLEQ_REMOVE(&s->requests, req, RngRequest, next);
+        rng_backend_free_request(req);
+    }
+}
+
 static void rng_backend_free_requests(RngBackend *s)
 {
     RngRequest *req, *next;
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a515fc5cd9b..d26a24ff85b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -233,6 +233,8 @@ static void virtio_rng_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
 
+    rng_backend_cancel_requests(vrng->rng, chr_read, vrng);
+
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_free(vrng->rate_limit_timer);
     virtio_del_queue(vdev, 0);
diff --git a/include/system/rng.h b/include/system/rng.h
index e383f87d20b..a2667d75efd 100644
--- a/include/system/rng.h
+++ b/include/system/rng.h
@@ -86,4 +86,18 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
  * deleted.
  */
 void rng_backend_finalize_request(RngBackend *s, RngRequest *req);
+
+/**
+ * rng_backend_cancel_requests:
+ * @s: the backend that created the request
+ * @receive_entropy: the function invoked when entropy is available
+ * @opaque: data passed to @receive_entropy
+ *
+ * This function is used by the front-end to cancel all requests to a
+ * given backend. Requests to cancel are identified by the receive_entropy
+ * function and the data passed to the function.
+ */
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque);
 #endif
-- 
2.47.3


