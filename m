Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF676CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGb1-0001vE-ML; Wed, 24 Jun 2026 01:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGay-0001gb-Tc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:21 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGav-0007Ia-DR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782280561; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=T4uWiRcqmfp/zJHVubCWRZy63xO5YRIuhLOjvS7bc+k=;
 b=HFhLX5kDX2pWd6MogC+FViAnxPLhzBATCeuDt33Uu2zNWrsOt4YuqVfzvmbW9C5JAiy0HythfeoxR9epaAaRct9Z9EUM58xiNsgf8FZTzXlPihH2kr733Y8qIWdj/zi9N/AlzUzO8x4pkneQhIwnFQ81mXA4cQNBA6SaBMTu0DA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X5X3L9G_1782280560; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X5X3L9G_1782280560 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 24 Jun 2026 13:56:00 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: alex.bennee@linaro.org
Cc: mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
Subject: [PATCH 2/3] virtio-gpu-virgl: replace fprintf(stderr) with
 qemu_log_mask and trace events
Date: Wed, 24 Jun 2026 13:55:56 +0800
Message-ID: <c6641369b55274965251a16bb420f9744445cfa2.1782270919.git.guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1782270919.git.guobin@linux.alibaba.com>
References: <cover.1782270919.git.guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=guobin@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Three places in virtio-gpu-virgl.c used fprintf(stderr) directly,
bypassing QEMU's logging and tracing infrastructure:

  1. Command error reporting in virgl_cmd_process() — replace with
     qemu_log_mask(LOG_GUEST_ERROR, ...) so the message is filtered
     via -d guest_errors, consistent with virtio-gpu.c.

  2. Statistics output in virtio_gpu_print_stats() — replace with
     trace_virtio_gpu_virgl_stats() so the data is captured by the
     tracing subsystem instead of unconditionally hitting stderr.

  3. Idle statistics message — replace with
     trace_virtio_gpu_virgl_stats_idle() to preserve the existing
     "idle" indication without stderr pollution.

Add the two new trace events to hw/display/trace-events.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/display/trace-events       |  2 ++
 hw/display/virtio-gpu-virgl.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fba..cf1e852b45 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -58,6 +58,8 @@ virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
 virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
 virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
 virtio_gpu_cmd_suspended(uint32_t cmd) "cmd 0x%x"
+virtio_gpu_virgl_stats(int requests, int max_inflight, int req_3d, int bytes_3d) "stats: vq req %d, max_inflight %d -- 3D %d (%d bytes)"
+virtio_gpu_virgl_stats_idle(void) "stats: idle"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b992ffc44e..afb0d0984a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1129,8 +1129,8 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         return;
     }
     if (cmd->error) {
-        fprintf(stderr, "%s: ctrl 0x%x, error 0x%x\n", __func__,
-                cmd->cmd_hdr.type, cmd->error);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: ctrl 0x%x, error 0x%x\n",
+                      __func__, cmd->cmd_hdr.type, cmd->error);
         virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
         return;
     }
@@ -1370,17 +1370,16 @@ static void virtio_gpu_print_stats(void *opaque)
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     if (g->stats.requests) {
-        fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
-                g->stats.requests,
-                g->stats.max_inflight,
-                g->stats.req_3d,
-                g->stats.bytes_3d);
+        trace_virtio_gpu_virgl_stats(g->stats.requests,
+                                     g->stats.max_inflight,
+                                     g->stats.req_3d,
+                                     g->stats.bytes_3d);
         g->stats.requests     = 0;
         g->stats.max_inflight = 0;
         g->stats.req_3d       = 0;
         g->stats.bytes_3d     = 0;
     } else {
-        fprintf(stderr, "stats: idle\r");
+        trace_virtio_gpu_virgl_stats_idle();
     }
     timer_mod(gl->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
 }
-- 
2.50.1 (Apple Git-155)


