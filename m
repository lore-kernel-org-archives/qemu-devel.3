Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3612CC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCwM-00066d-9P; Thu, 22 Aug 2024 14:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwH-000627-Vo
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:42 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwE-00047H-Mk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352801; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hmxsQMURfaXgQcXNJY1U4Y2TNWY9oKJ6KOtkq9GaJDCDGhI3lnKuuTAEASWBRVXCkp/19ZntVJPS/ST2iUzwS16u193IT3ePGXVPa/l33MAE3X99xJiJkp4xxSTsWG3Au6Ed/OKDO6DrZEQ3225l4cl+wlGrnuM2uJIKbDlxAWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352801;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b76gkPgz5oedm1abXkLrlAyeoyH3Xe6W7rzyvKqhrxY=; 
 b=Cs54HoCzMiDI3uIikOr6qLRNgPwybQ7jKSGk6LZ4ky7jArCr++HMuQZU9L55Su99jsACi2cBbz9+HrBvJl2DVwgYsqh6JIV+QLBuR5RYTctAzGtIM5TMLfosesM44DXgFVEswS7S2NXF+1sUJO91eZySDG/KKOoFMPlcMvl0+7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352801; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=b76gkPgz5oedm1abXkLrlAyeoyH3Xe6W7rzyvKqhrxY=;
 b=NqfO9Upctm3cwzGZzBHu8yYq4aytOor42v211B81U51xaU0BuCDqzpBrQFVuljwc
 ZYAKBm8GqPRGxD++ajtZwexOxKAd3PvKt4U96oZEDxutmX7rhRB3rklnw6Cx0XvTXGF
 r+KEuFddaPqFPg1OiytOsjL23yDuf78NHiMVgj28=
Received: by mx.zohomail.com with SMTPS id 1724352800731249.56964211128422;
 Thu, 22 Aug 2024 11:53:20 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v17 03/13] virtio-gpu: Move print_stats timer to VirtIOGPUGL
Date: Thu, 22 Aug 2024 21:50:59 +0300
Message-ID: <20240822185110.1757429-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move print_stats timer to VirtIOGPUGL for consistency with
cmdq_resume_bh and fence_poll that are used only by GL device.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 10 ++++++----
 include/hw/virtio/virtio-gpu.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 91dce90f9176..a63d1f540f04 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -574,6 +574,7 @@ static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
 static void virtio_gpu_print_stats(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     if (g->stats.requests) {
         fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
@@ -588,7 +589,7 @@ static void virtio_gpu_print_stats(void *opaque)
     } else {
         fprintf(stderr, "stats: idle\r");
     }
-    timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+    timer_mod(gl->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
 }
 
 static void virtio_gpu_fence_poll(void *opaque)
@@ -651,9 +652,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
                                   virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-        g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                      virtio_gpu_print_stats, g);
-        timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+        gl->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                       virtio_gpu_print_stats, g);
+        timer_mod(gl->print_stats,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
     return 0;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index bc69fd78a440..7ff989a45a5c 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -196,7 +196,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *print_stats;
 
     uint32_t inflight;
     struct {
@@ -232,6 +231,7 @@ struct VirtIOGPUGL {
     bool renderer_reset;
 
     QEMUTimer *fence_poll;
+    QEMUTimer *print_stats;
 };
 
 struct VhostUserGPU {
-- 
2.45.2


