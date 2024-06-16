Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892B5C3DA41
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 01:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIeJs-0005FN-W0; Sat, 15 Jun 2024 21:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeJr-0005En-BE
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:31 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeJp-0002zY-JC
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718499868;
 bh=/DJikY8jCT7wV6orn+ih9VeYfQdaF2LyqGeoARa2lkk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uzYlijeLvBPPbDaDabw+pBnw52bt38MT/smllB7SlM/ZsCvRtadrFQqAJUDIBrRB9
 6FnYtZ+IDI6u5iVD7aPaVUHxhn88goXaioeSuZDDtLMUBpH2SqeG4yVtxBZJ7qLBWM
 v5h8+viAhwvJAHdWnZDJLD01EOhPknjsZRbPCzoa8zLFKnihjlWZvTjbNaVb4zcoo/
 SBqKKMOljewOgnuwv0ntzSSGWen0u4GS5XMtiAfcaxkLE46Cdn4iRlYPsUMHE1jqHM
 7mW0E78p1WivPPH4FFLl7OellLCsnLSHCOhECWsQNQTr8C/mCYqeL+0rg9jN8HiVVS
 t6LbyyDSJSW7Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 03B3D378213C;
 Sun, 16 Jun 2024 01:04:25 +0000 (UTC)
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
Subject: [PATCH v14 01/14] virtio-gpu: Use trace events for tracking number of
 in-flight fences
Date: Sun, 16 Jun 2024 04:03:44 +0300
Message-ID: <20240616010357.2874662-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index d60b1b2973af..602952a7041b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1066,7 +1066,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
                 if (g->stats.max_inflight < g->inflight) {
                     g->stats.max_inflight = g->inflight;
                 }
-                fprintf(stderr, "inflight: %3d (+)\r", g->inflight);
+                trace_virtio_gpu_inc_inflight_fences(g->inflight);
             }
         } else {
             g_free(cmd);
@@ -1086,7 +1086,7 @@ static void virtio_gpu_process_fenceq(VirtIOGPU *g)
         g_free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-            fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
 }
-- 
2.44.0


