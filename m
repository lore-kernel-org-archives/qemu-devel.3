Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE6C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M14-0007SU-Be; Sat, 04 May 2024 16:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0z-0007Q6-5n
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:49 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0x-0005Wz-Ix
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854585;
 bh=1ptEik5fipIhqT02OLKiYqBPj191E1/Idbn7Da3INkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fQxPfR5li7oAg4riNHJwk6Agc/Y2O4YRII3W4HoDj0jjAOmQVWz8c3uT/vt/eVJhx
 0N1SUl2vsXTEgg6OhfiNAKklHWG+NCQ2LMwzVLQToYzn+GwuvqAKG62Zf827BM680k
 8NM2lj91MoU9GaL381yeARom7OXGVVbMzWaVMLKZEq3ldyITC9TFEQ2a9Hz+h7ktpb
 7YZd5ICVRk3HhelbCVhLN9LrBzZyYiLCGeLzg8jjlN1afZERHBz4lGFPTnefeVCdZo
 lIUsw5uDB2OWRFk5JMbsfc0SGsgO+lubFCeoAUI9tGyKsXFX8racffHWAVkYbS01bh
 E1HWuGp4qaxPA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 615CA378215C;
 Sat,  4 May 2024 20:29:43 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
Subject: [PATCH v10 07/10] virtio-gpu: Support suspension of commands
 processing
Date: Sat,  4 May 2024 23:28:31 +0300
Message-ID: <20240504202834.399780-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add new "suspended" flag to virtio_gpu_ctrl_command telling cmd
processor that it should stop processing commands and retry again
next time until flag is unset.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c       | 1 +
 hw/display/virtio-gpu-rutabaga.c | 1 +
 hw/display/virtio-gpu-virgl.c    | 3 +++
 hw/display/virtio-gpu.c          | 5 +++++
 include/hw/virtio/virtio-gpu.h   | 1 +
 5 files changed, 11 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 95806999189e..2a9e549ad2e9 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -79,6 +79,7 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->vq = vq;
         cmd->error = 0;
         cmd->finished = false;
+        cmd->suspended = false;
         QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
         cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
     }
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 17bf701a2163..b6e84d436fb2 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1061,6 +1061,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->vq = vq;
         cmd->error = 0;
         cmd->finished = false;
+        cmd->suspended = false;
         QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
         cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
     }
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 2fedccb1fc8d..dc2b5a496630 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -687,6 +687,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     }
 
+    if (cmd->suspended) {
+        return;
+    }
     if (cmd->finished) {
         return;
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1e57a53d346c..a1bd4d6914c4 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1054,6 +1054,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
         /* process command */
         vgc->process_cmd(g, cmd);
 
+        if (cmd->suspended) {
+            break;
+        }
+
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             g->stats.requests++;
@@ -1113,6 +1117,7 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->vq = vq;
         cmd->error = 0;
         cmd->finished = false;
+        cmd->suspended = false;
         QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
         cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
     }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ba36497c477f..0c00c303f41b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -132,6 +132,7 @@ struct virtio_gpu_ctrl_command {
     struct virtio_gpu_ctrl_hdr cmd_hdr;
     uint32_t error;
     bool finished;
+    bool suspended;
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
 
-- 
2.44.0


