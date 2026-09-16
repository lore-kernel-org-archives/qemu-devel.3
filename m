Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C8C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lf4-0000XN-3P; Wed, 16 Sep 2026 05:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leh-0000Ja-LO; Wed, 16 Sep 2026 05:10:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lef-0007Z3-PW; Wed, 16 Sep 2026 05:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=zP21KPPLFn+EAdBGu64D8yQs7jiDDW8hNhLUFL/RqrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xAcIMjSwDkdjXZilOdGFVeiUFUymTPoZC4hNEzuf36qZUKUyG4RE6L/QmJ74+47rf
 RbbrMfP2jhTeAHSK19cEy5Xb6xC6X9VLlGBCdOm0VPtdf2FgZHhcFmqMAdR6398VcU
 fPOlG9zhGCXClF1zQr6utNt3OoEz5bMrlqFoEk6n36Na49GEFCgaJRlUmovmDnlnv3
 NS75XywRIoxlafhqo8r8G05bI/iPMJDeWQlawuP+sn3I5m6B5GdfNIXws52K0XQREW
 tKBNRjLD83gLJt8Sti0AlP/K7ALfvsv8qF4h5Iw31S7g4mVjvIJGe+BChnYBp28sUM
 QMSGrfTDr/+2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45F471D56E4;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E5ADD429E40;
 Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D62485A7B7; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, mhun512 <mhun512@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 47/57] virtio-balloon: fix free-page BH teardown on
 unrealize
Date: Wed, 16 Sep 2026 12:04:11 +0300
Message-ID: <20260916090516.677749-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba23..07d519cf6d7 100644
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
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index abbf3397188..53bbaa4c9ad 100644
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


