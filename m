Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B826C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAj-0004dQ-Ma; Fri, 11 Sep 2026 05:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xA0-0003mP-1M
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9y-0008GE-Bp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=aoTEZbCEia59GpqH5Vrz5e/i9mVUBSb+ULGgKyb3Y37chl6wH3cLAVYTretsxv+cdT52AB
 Fm1ym6w5AMu8SMw/i0fjQZofwanMnptDbiQjtt+Rt7PSFM84v/nLevXST8jWSH5n+TZhXo
 f7EEmMx2SnEiPSw+TqZTXmLmybcCX/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-MrITJfMVOc-YS5ajGiUTFw-1; Fri, 11 Sep 2026 05:03:00 -0400
X-MC-Unique: MrITJfMVOc-YS5ajGiUTFw-1
X-Mimecast-MFC-AGG-ID: MrITJfMVOc-YS5ajGiUTFw_1789117379
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso4208935e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117379; x=1789722179; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=kE2ixUsZOKjG9CaYWa7IopTqjZCGnvHvMV1nwU+iMOLSyLo3JxUgeUw8v4QInBBOLg
 5nLrFaIAx3iBfejg0cUyLyHmqbhepj3UBFunOZO7Zcyg5cpejOKOfprKmSI6cE6ewm4Z
 obz3EcLBX2A+uIcIzMleFYc+jc9f2dSx0uE5yk+2jB+uDlg827lT7+9O/ZIF8lsiNqSd
 7vEknaPRrp/DnWZWC3n75FsKZlwLVt7GCynC/CJC83nnlXZ07HmHBVCAJpd5fNa8KO0L
 oOG6oVjwVFaJBqv/2NumrCLsvPeefpklP4qNC/Q4j9zF4f0IRuXXV2U1PaUR+eE00tqz
 wjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117379; x=1789722179;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=dVbUFtLKwAb/SfAQ4i5XqI32nhxBwMjmlG6Y7Jo6cyIl9UIenW0rtkJc/e3LrBBSyw
 ji07ukdnhPPL6Cc2ZFeBTeukF+BlYtzBMJjFKYweWowou57YMqb+b3e+7q0pjv8Mmb6v
 lUEFsBNDlh37w5AyjnyfQJdOaEvQUVrgMSjnUczaYGX3zWWkatTFI6UHdL3yD09ZDOyS
 aE8nN1Zab2+WS4rDNOq+J+lrgMlf6wg9xpYPFs/FV2URWkb3CFR+7h3ZcBYL5xSeDxGw
 W8Iu58TfFilFg1eRxt3gRQ/+cDp1L/wRxDV5vx6/dROAC6hUZQRofdNHK2tIsvWwnYo1
 P+8g==
X-Gm-Message-State: AFuF++nyY0yy6z5c8atwmlRABNUyey++NBko9JQW0MLLrgCYBobSwuXT
 zLSL6r8Zvc2b7/jZT9H5ySnm5E+dTVPIzWdUV+QRSN5g8mAbgYW3pcoGIHKvJMDD9LJwEaQB+za
 eX2Tt+rk3jslIW8OLdbK86ey6AN3oew4fUkwEL3gYVBOa0gQEu6vrsT5V5zDIvxv44RG7hX11xT
 Qy+LsXTYhyj7c/ZpjQKNvnHDi6GRzg8dq/Jg==
X-Gm-Gg: AYBFou0cNovtl8xtv3Bd13RFuLF69FbjUB7tahq1glGTU4pu1IQOlpC/kpBX+5qfwrG
 dVzE1/cKObwWEmB0xyaB9rmopowFAmDPyo/dTUaZ9ZvZBmPs3sxn21yhZY8SeV+zOqUDz6qbZgf
 ZOJQafWcoppakLHJfalOnrnA04OHdRpc7WeRwf69DRP4GZxtBLcqIjNE2rEq35UCXhNIQ4wR6TP
 oUd3RAN93E7jsvuzzwKwt3KaNQLFHJlPN5DgFi3Cr6r+Gc+D777v1U777EoCm9/Mxoec48799qr
 bYQuMfJr/FHnFcgkFQtRHR1wxJ55ZahzXWXFXzdEkYvEENliQakZgvPbtmKlmvp+52EwYWr66wI
 avybQpf33MPCuj1Ehi/XghCk=
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49e619831a9mr34888475e9.7.1789117378642; 
 Fri, 11 Sep 2026 02:02:58 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49e619831a9mr34887615e9.7.1789117377872; 
 Fri, 11 Sep 2026 02:02:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaeefsm58754815e9.12.2026.09.11.02.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:57 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, mhun512 <mhun512@gmail.com>
Subject: [PULL v2 41/75] virtio-balloon: fix free-page BH teardown on unrealize
Message-ID: <fae2fdd161178eb78ea02c0e486c8e7eb9fb46ad.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


