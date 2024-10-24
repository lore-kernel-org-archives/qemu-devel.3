Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA51DD10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t44zy-0000vK-Fw; Thu, 24 Oct 2024 17:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t44zv-0000uq-Qt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:04:00 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t44zu-0002Av-6F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:03:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729803824; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HtnTjKSjEHA5Vh3vsJVAv10mvY/3qq4d9Cru+aHGT3BhMb9Li4JgpHR724/tAekLSmEmNSvJdOGlcQoMWy+MnJf9V5559gWUFR4Rt9WsdXLATB1G+6nL9zO+kq/wGr0O4fKUMCGonXE2xRpnV/4jPEjGyUah6ktzrzN5sqqVygA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729803824;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qsto3lML5XLcU8iEkzmujIrFEnuK5fHb3J+USi9bNrc=; 
 b=Fl68muEUCQ6sZM898RJgv5+zFxvr+mcYCSA/3mAmH9vn/KbdEN17YmRkWFmX4lVjfa37GWCNIopGniYd13L1s/38fNe2a12re2PhDoR7tBpNWxOk3S2GBsADwqBa7dD7y4NSalvO+mZCMhTOZHcjewMbyA2W9kIVgnPxGttmQxs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729803824; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qsto3lML5XLcU8iEkzmujIrFEnuK5fHb3J+USi9bNrc=;
 b=gXBqOBVu5Aw3MXgzeoLybayyeRwXjuofIi5YtJV46vd4zspQz+HBAvITl7qmgjzd
 r0WcYvj1IBBA2y1o7nTfToiASGSaCWeTELIhnW26WHbsY/+DHsiZcqIB6RiNgEusc+8
 QFOTwSlK3PK90BP9PQozl8IyBrk6fVn7X3Q65GuY=
Received: by mx.zohomail.com with SMTPS id 1729803822545959.3730091957152;
 Thu, 24 Oct 2024 14:03:42 -0700 (PDT)
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
Subject: [PATCH v18 02/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
Date: Fri, 25 Oct 2024 00:03:00 +0300
Message-ID: <20241024210311.118220-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
that are used only by GL device.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 8 +++++---
 include/hw/virtio/virtio-gpu.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 14091b191ec0..91dce90f9176 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -594,11 +594,12 @@ static void virtio_gpu_print_stats(void *opaque)
 static void virtio_gpu_fence_poll(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
-        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
+        timer_mod(gl->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
     }
 }
 
@@ -626,6 +627,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
     uint32_t flags = 0;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
@@ -645,8 +647,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         return ret;
     }
 
-    g->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                 virtio_gpu_fence_poll, g);
+    gl->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                  virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index e343110e23db..48a67d662d7f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -194,7 +194,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
 
     uint32_t inflight;
@@ -229,6 +228,8 @@ struct VirtIOGPUGL {
 
     bool renderer_inited;
     bool renderer_reset;
+
+    QEMUTimer *fence_poll;
 };
 
 struct VhostUserGPU {
-- 
2.47.0


