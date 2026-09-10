Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4298FC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zz4-0003Hm-Ex; Thu, 10 Sep 2026 04:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zz3-0003HS-MB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zz2-0004st-9B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjrug66JF7sj2Em1iOXDLtWW+CYxXnfe2H2hXOKSaUU=;
 b=UGw7XIhxeEti6xC/AKL66NkkBUVvKG7rQ5schTA4myzTBqtBVffQX2EEYRZiEYXhBfbZSq
 MjY9Uf+DvEmOrXjjniPAlzjWUjvrt0XBj9HavHv95Q2aYAq8srfq8rGZC33BZ/6PPrzEPi
 boq+Ao7bN++D25tAZhm/gc6NrXtJoa8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-WlaPyVFTN5eYNNKJg2lQsQ-1; Thu,
 10 Sep 2026 04:18:08 -0400
X-MC-Unique: WlaPyVFTN5eYNNKJg2lQsQ-1
X-Mimecast-MFC-AGG-ID: WlaPyVFTN5eYNNKJg2lQsQ_1789028287
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8199B18007F2; Thu, 10 Sep 2026 08:18:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A36421956040; Thu, 10 Sep 2026 08:18:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:32 +0400
Subject: [PATCH v4 04/24] virtio-gpu/virgl: free BHs and timers on renderer
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-4-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pjazvMH3OTm4G/gkcv4HVSFx91Q4hZxlcUF0x0N0LS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeon7tDdj2cH+bctXAv5EPSveKgragpfnbXq
 +Q/X45nAiyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5aUnD/9JBOBkvkB05xWA6a0IsdxvIyCQBeegUDrf6nc5fJDV2359QzqGZy1OLadkCZaaZE7/YqL
 8q4EaShlDAXmGFJdclTV7AMevH853tO5cC35+oEQ20TH24DDADZF1aQHm8Om5DoPgnscPtftsZm
 t8o7FTz0Vy4zlL89aCzMfFRbsI+y73ixPWis+1A/uBMu7bDdZQay5cWmb4Mp3PBt4O9gY4K0nPO
 q6pJANbTjIJmh5htCFxRopQBpg7HlMph2ccBQgO9pPO9zvS+Hj+h6lFlTzcstNSX6Tycw/bMNiL
 Ro7EZLjAaBCso5Yqiv+nGyCKqE7zDCH4w1sbmPbXs/zAObIhXMl94mw0hH05OwJpqqqe8a9oI5e
 XC0oY5cLjW61sm52w4gZ3/6eNd+2DmfHL9kmhU/qMsQ5bnIdijx2s5ohEb+vNL/40WExopJ7HBO
 KMWgmJmfRdjW5bkJfMtb1yurXldH4oxANZU8oCnz0MjcK6hWL01XBVWonlTi3sU+YxDnzj1bSW+
 xaVTM5qYPnis3TlaY3qjvqjd/GxdChGd5u1QThGcR5rL27UleXw4EQVU+/0hP6hY0neeos7OBjq
 538VokIh63wTpOM3/WBKeIe1d0kCTKAcbBSnooqumKAkKjmcf+/QSU2tZ3vFU8sQQaY0s6CqmZG
 IP52lqCJOmZPxFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio_gpu_virgl_reset() does not free the bottom halves or timers
allocated by the previous virtio_gpu_virgl_init() call. A subsequent
virtio_gpu_virgl_init() overwrites the old pointers, leaking the
previous allocations.

Fixes: 7e688d1bf515 ("virtio-gpu: Handle virtio_gpu_virgl_init() failure")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 742d9dde4a32..7f1d1e0c3276 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1430,6 +1430,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 
 static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     struct virtio_gpu_simple_resource *res, *tmp;
 
     /*
@@ -1448,6 +1449,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
 
     virtio_gpu_virgl_reset_async_fences(g);
 
+    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
+    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
+    g_clear_pointer(&gl->print_stats, timer_free);
+    g_clear_pointer(&gl->fence_poll, timer_free);
+
     return true;
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


