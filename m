Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E572C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCw3-0005jG-Sa; Thu, 22 Aug 2024 14:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCvz-0005fe-UR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:23 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCvy-00046h-9O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352787; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TiU75NFvAWFcdOhMt+r1oZoC8+ij7kss4k4+EWVfDyIlweCZZjotCPj1bEAoLmCQ8kxPZ8D+6GRDtIZGnCBQl8nMBMDsC15tYUzlhcx6j1coBWTZjjxIan8yPGI1TK/mAzSpfrKtO5CSbN5VZCvzWJQblSeD2DRsGTWZ7wRLMUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352787;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/m+1oSy0HCh/bFlAl01E/YgcpLBQC+f144OWU8VIJfQ=; 
 b=ZnqKf+pG+12DKiEIgMSnE42Rz+HzRE0B7g2zv9JRftpZqGYVhwPZi22qte/yrttfhFuWjFhWKCMEd5jwUhA6YvFZ+bbr7h2mfQRdZJ6TNHYnFqD1BE7PUJge3t+ZcPu1o/BLFePHPFo5nFfVYKLK0jcWgHmt75EdwRGEb6RzoZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352787; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=/m+1oSy0HCh/bFlAl01E/YgcpLBQC+f144OWU8VIJfQ=;
 b=eznebyeKidaLnrUCBxzGYgvFFlrG3dnYecyXenDdWbCxO+yK8JNw/riXoVGgMzka
 R4XA37+c8iomyyo1MQuUil1Q3tyGpebzn4VALyhE7/61K8MhoYND/mB+bWvxX/DQM/O
 JabbFs1LnazysZ1gs2dU0uZMibhNTvBvQNPxFqFg=
Received: by mx.zohomail.com with SMTPS id 1724352785968982.6644425891327;
 Thu, 22 Aug 2024 11:53:05 -0700 (PDT)
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
Subject: [PATCH v17 01/13] virtio-gpu: Use trace events for tracking number of
 in-flight fences
Date: Thu, 22 Aug 2024 21:50:57 +0300
Message-ID: <20240822185110.1757429-2-dmitry.osipenko@collabora.com>
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

Replace printf's used for tracking of in-flight fence inc/dec events
with tracing, for consistency with the rest of virtio-gpu code that
uses tracing.

Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/trace-events       | 2 ++
 hw/display/virtio-gpu-virgl.c | 2 +-
 hw/display/virtio-gpu.c       | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index 781f8a33203b..e212710284ae 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -53,6 +53,8 @@ virtio_gpu_cmd_ctx_submit(uint32_t ctx, uint32_t size) "ctx 0x%x, size %d"
 virtio_gpu_update_cursor(uint32_t scanout, uint32_t x, uint32_t y, const char *type, uint32_t res) "scanout %d, x %d, y %d, %s, res 0x%x"
 virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type 0x%x"
 virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
+virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
+virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9f34d0e6619c..14091b191ec0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -525,7 +525,7 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
         g_free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3281842bfe1b..60dfed87765b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1065,7 +1065,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
                 if (g->stats.max_inflight < g->inflight) {
                     g->stats.max_inflight = g->inflight;
                 }
-                fprintf(stderr, "inflight: %3d (+)\r", g->inflight);
+                trace_virtio_gpu_inc_inflight_fences(g->inflight);
             }
         } else {
             g_free(cmd);
@@ -1085,7 +1085,7 @@ static void virtio_gpu_process_fenceq(VirtIOGPU *g)
         g_free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
 }
-- 
2.45.2


