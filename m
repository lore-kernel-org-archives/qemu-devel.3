Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F999C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oqb-0000UC-AT; Thu, 10 Sep 2026 20:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUT-0006A0-2r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUB-0003Az-9S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=jJgBrmUNuBIBydAiXj0a0FzjDKA6L3GgWv/OOWghCmv3d54Q5fObeBrG4Yo7OHZv2MG8Jj
 BQTsQWE9SZ5OU3qVoMejcbwyVLUMQVsBUmj8cnjHHNNnUNdna6hYfwqrDkiO1lBABVosoj
 qn9CyerGk1wCrusAwzcmuAY2MKONm6c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-rBjKisxsMYmuclzm_a82Vw-1; Thu, 10 Sep 2026 16:13:49 -0400
X-MC-Unique: rBjKisxsMYmuclzm_a82Vw-1
X-Mimecast-MFC-AGG-ID: rBjKisxsMYmuclzm_a82Vw_1789071228
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48589603501so62830f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071228; x=1789676028; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=t4aFPdYx/8YcFO15ODzeYao+8wL+lpBaMnAb83yZrTMAsZaj21cwJomWPGiKp1fzRe
 kaNAn2G9GX+Q/tHI8UEdVsS49Oqmk6rsFI6Htqa3gl7+/4KW9GrPb3RHLZQz+fZ+RWk/
 XEuIZSSFE6r4iQtC/7j4ZCkK8AewuYVGU4nYRXvNbfuNtgz4Fbb6wrcy/lhG58OS9D4P
 5NGLpIp8x24NwEOTn9B5Ezxt3o61M4XVgtH5sCx3e/PC0M68GliOVRURDMa7MbNfvk0O
 bVO+63WxaXsdlRzBZbH9lIGaF/ouczSdquaXL71sTXzh7qqIZHvk7esQdj32C2vuyJe/
 9ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071228; x=1789676028;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DrlxSV2VF2oztmcd8kqn2wrqEBAsS1OzZaHE6hsiVqg=;
 b=ek2XNw0d+indKWsTJxZnjF3t7oi7gp/59hpKPGo2bWH1Oqu7dmM57DJ2CeI/tXBrbj
 eFPKychHEGChBOg1q6cTyqmIMYhGSiSY9YvH0pNzgTO28CNTNUxjoVRcvHVhDxAF3C74
 LGrCEFXdQLlECQ5o2htQTyIjampIBhq1LZj+lidSEOWW2M9XqSPndaANhxylL+1hHofu
 5PsFz2EwN6RwHx0phXh1EsWu3wOB3RvjwC2htQknFJG3ehm7Ypwxgop5yT19buz3iNZI
 NT2NbrvrNcfZ+WYxjYgAQr/3Sz5VzNVZZHrk7EWYvMM6ulxeVewvAniMFFv3NOB9Ae8G
 8ubQ==
X-Gm-Message-State: AFuF++klKU2i0uCryhFFBZn5QqkUgdv0ZQAZoKWFmD/VQhMeF6qPAzBQ
 j0IUJjBSW1CDFKlVYtaTzjWSnRRyVVxgVrsW42FW6xT6lICqNi9CWlxj6O5GdDI7h+MMBS0eid/
 m/uTUHLTrnESKuQ7pZOMyNmIXt33CWb1h7gbsiqPtGYL111Mjd27PNWPdrIcFOODmWUBQZ+vPmJ
 uNRohexWklj9nqsvcEU39ChSumg19LBqwtIQ==
X-Gm-Gg: AYBFou0aL3olNDnRjLJOZ4h7aU3tCqy8ZQs+/XHpJxAbrqqMFsSHlrkfWJipCeAVxIy
 PMhoE/bCALKbBd/zjMvBOR4nG3BNZFIl7SDnsWu2pxccOjtNlPPbMhtzaHounv/Uy3O2JjshoPW
 i76NsChFartpqs2cn8mU1nhyl2R29MSdM7DinuKXibVXbsAPa2YtoLuiOhjRuotnKzrzPOc2dFM
 KO33INvK8HnykA+AADLhGNWRzItMcyBU8n1UZxipKUaIn+yVnR/zDwvWecNQK75mn+LcxZiLU4B
 dszmiN9pUy7VU/oR3V83OMV+EqD1fCt52lLxmcdZ88/S22knKTBLSeoPZixdtWxtKibvMRMpV4o
 hJaSQxrJbBfQAwlQ3oxhczlg=
X-Received: by 2002:a05:6000:430a:b0:482:fb60:2f0 with SMTP id
 ffacd0b85a97d-486eb2ec2dfmr760630f8f.8.1789071227817; 
 Thu, 10 Sep 2026 13:13:47 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:482:fb60:2f0 with SMTP id
 ffacd0b85a97d-486eb2ec2dfmr760571f8f.8.1789071227260; 
 Thu, 10 Sep 2026 13:13:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34fdd2sm722491f8f.28.2026.09.10.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:46 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, mhun512 <mhun512@gmail.com>
Subject: [PULL 55/90] virtio-balloon: fix free-page BH teardown on unrealize
Message-ID: <ccdedf4de01a0d58556435e76eacc37ea9339c08.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


