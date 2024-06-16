Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0045C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 01:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIeKE-0005N9-Lc; Sat, 15 Jun 2024 21:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeKD-0005Mg-LT
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:53 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeKB-00031q-Es
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718499890;
 bh=cljWl6yUS/4+umzlXUqpiBsI3v54wRaKONCpK5QFyx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=um99mmYKGcmmOiVHtDiKV7WZMLwD3TDqt/hrgqModQsqQRUHh3m4vv42XNFMob4+P
 bKm056OCnO8SaKzt5q1S+HULMC8M7f/56HDuzs3LTGeYmTyF/RwoZZZFabai/qkSP7
 ZuQYEGIwZaX5bbTD9OgIgHN2WVvcoZZdK3SAKIr+CF28pToOxMescmcWV34Y/cfm4z
 Oz/yAPC1aUS35DJdC87NKU7PB0Q1yn93xUsK5TbIYx4Gb+izQ7YX+QjkOPqENwSbJF
 UUIRm+HOjFW+cQ5misS1+cFB00YTRKxsGkUoSvVmr8P28pboTuTavOK+onLIZB7qDC
 1tKhH4OPDPfeg==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B9123782163;
 Sun, 16 Jun 2024 01:04:48 +0000 (UTC)
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
Subject: [PATCH v14 11/14] virtio-gpu: Support suspension of commands
 processing
Date: Sun, 16 Jun 2024 04:03:54 +0300
Message-ID: <20240616010357.2874662-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
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

Check whether command processing has been finished; otherwise, stop
processing commands and retry the command again next time. This allows
us to support asynchronous execution of non-fenced commands needed for
unmapping host blobs safely.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/trace-events | 1 +
 hw/display/virtio-gpu.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index e212710284ae..d26d663f9638 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -55,6 +55,7 @@ virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type
 virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
 virtio_gpu_inc_inflight_fences(uint32_t inflight) "in-flight+ %u"
 virtio_gpu_dec_inflight_fences(uint32_t inflight) "in-flight- %u"
+virtio_gpu_cmd_suspended(uint32_t cmd) "cmd 0x%x"
 
 # qxl.c
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 95091c4b7924..1c6e97fb6931 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1054,6 +1054,12 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
         /* process command */
         vgc->process_cmd(g, cmd);
 
+        /* command suspended */
+        if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
+            trace_virtio_gpu_cmd_suspended(cmd->cmd_hdr.type);
+            break;
+        }
+
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             g->stats.requests++;
-- 
2.44.0


