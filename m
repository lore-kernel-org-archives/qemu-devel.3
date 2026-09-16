Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F054C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMQ-0001jj-Hb; Wed, 16 Sep 2026 03:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMA-0000Za-8y; Wed, 16 Sep 2026 03:47:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kM8-0005Nk-9v; Wed, 16 Sep 2026 03:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544619; bh=mbx1ZejOjNqWJgdD3pPXYetrHgUMnHWMw9k4KuPuIas=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iDpQ3HMIr5CAlTUmgXXix4S4MZuEVNEyG6BG1g+gWGwcWo9WG77J7Bly/yVnomF9D
 Bd7GMTEPvP0i+iU5xezzE0uM6SAdXi1zWsdGleG9eqT1LOSCQl5Xk3o6K+9/inTuNB
 pohCL27BKCJ+1wxZfMLbelhJuBp75Zl8m3w9fAIWykPfp7LRJQmbM+p4s3jRetYgzc
 L772F485w4bqHcJOPqSndqvgnHYZM31QjBdBqv1UK/xBXLRoaIXzxh8ameRmwMlR8s
 F+kcfSfOWoEBOPFQNhMUTvbrFVh6w9K+QIbuofofCOz6V/unDGShZCsRH7VY7sc0ua
 fJ6dTYLD5R5IQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A7AB1D55B8;
 Wed, 16 Sep 2026 10:43:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E481429B71;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4FC995A715; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, mhun512 <mhun512@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 42/49] virtio-balloon: fix free-page BH teardown on
 unrealize
Date: Wed, 16 Sep 2026 10:43:00 +0300
Message-ID: <20260916074346.671467-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: "Michael S. Tsirkin" <mst@redhat.com>

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
Reviewed-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <0967d574d9ffe469edf5fc16da86237e54a69c34.1785327742.git.mst@redhat.com>
(cherry picked from commit fdc3f9a83ddf6f9b32f978ee2fee466816a3b9ce)
(Mjt: fix aio-wait.h include path across v10.2.0-154-g12e50722e444
 "block: rename block/aio-wait.h to qemu/aio-wait.h")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 2eb5a14fa2c..1ee679c33fa 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -34,6 +34,7 @@
 #include "system/reset.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "block/aio-wait.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
@@ -518,6 +519,9 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
     int i;
 
     while (dev->block_iothread) {
+        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_UNREALIZE) {
+            return false;
+        }
         qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
     }
 
@@ -914,6 +918,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
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
@@ -921,9 +930,17 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
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
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 0456c211c6e..dc3de998a25 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -39,6 +39,7 @@ enum virtio_balloon_free_page_hint_status {
     FREE_PAGE_HINT_S_REQUESTED = 1,
     FREE_PAGE_HINT_S_START = 2,
     FREE_PAGE_HINT_S_DONE = 3,
+    FREE_PAGE_HINT_S_UNREALIZE = 4,
 };
 
 struct VirtIOBalloon {
-- 
2.47.3


