Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9BEC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPZ-00088j-ED; Wed, 22 Jul 2026 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNz-000424-8x; Wed, 22 Jul 2026 08:49:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNw-0001up-2x; Wed, 22 Jul 2026 08:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=pQlmvh05+nKTY0hF0+TKy7QiDoandcqzhWUgTD9/tXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mnUUwrKOV4Pwh2BJ+rCKd6laqvNGs6s0oMKuvDyFrS33P//ZBu5d64ijnuRuTKg9G
 krRhR+LvEXgQV5CQvAcxWakn07nk+kd0C3uxeR3xRloKOTLrBOJJJF/33KfNKYDrPd
 tPhPFZ0+Uo2kdW5MCeG7Sy+C1ZwAr6bTBpUw7myZWZlhKLL3UfQhSHe4tfZQp8RCEi
 l6FNmB1yvCt72oGSJi1WqsDMI+G16J5XYe4ihd535TrRGr1nyK/TJ5hP+uSHBBQWFH
 wrRm5fr48g83DsGOXaZgobDIy765sOqJXNa9HoOuiS2o8R4lgGIsEj5zXoscQuODQK
 JlOw1xwoC8OmQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFA1F1C3B12;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 229143F376C;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7D33317F0D; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 admin@fluentlogic.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 105/122] hw/display/virtio-gpu: cap submit_3d
 command buffer allocation
Date: Wed, 22 Jul 2026 15:45:54 +0300
Message-ID: <20260722124622.31034-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Both virgl_cmd_submit_3d() and rutabaga_cmd_submit_3d() pass the
guest-controlled cs.size directly to malloc() without bounds checking. A
malicious guest can set cs.size to an arbitrarily large value, causing
an OOM abort that crashes the QEMU process.

Checking cs.size against the descriptor payload length (iov_size) is not
sufficient: indirect descriptor tables can repeat entries aliasing the
same guest-physical range, inflating iov_size() to nearly 4 GiB while
referring to only a small amount of unique memory.

Instead, cap cs.size at 4 MiB. With 4 KiB pages and QEMU's
VIRTQUEUE_MAX_SIZE (1024) mapped-iov limit, the Linux virtio driver
cannot carry more than ~4 MiB of inline command data, so legitimate
submissions are unaffected.

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 8720061c6d343c77b4f3a061cce631c05ecc0482)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 51da0e3667f..550fd03bf5c 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -202,6 +202,13 @@ virgl_cmd_submit_3d(VuGpu *g,
 
     VUGPU_FILL_CMD(cs);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        g_critical("%s: command buffer too large (%u)",
+                   __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_malloc(cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 654c392fbbf..2374eb90cb9 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -22,6 +22,7 @@
 #include "qemu/queue.h"
 #include "qemu/iov.h"
 #include "qemu/bswap.h"
+#include "qemu/units.h"
 #include "vugbm.h"
 
 typedef enum VhostUserGpuRequest {
@@ -163,6 +164,14 @@ struct virtio_gpu_ctrl_command {
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
 
+/*
+ * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
+ * limit, the largest inline command is ~4 MiB.  Cap submit_3d
+ * allocations to this value to prevent a malicious guest from
+ * triggering an OOM abort via an inflated cs.size field.
+ */
+#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * MiB)
+
 #define VUGPU_FILL_CMD(out) do {                                \
         size_t vugpufillcmd_s_ =                                \
             iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index f6eb29472e8..a61454aeb99 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -351,6 +351,14 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(cs);
     trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command buffer too large (%u)\n",
+                      __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_new0(uint8_t, cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 030b329d5ae..30bf5b5029e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -486,6 +486,14 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(cs);
     trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command buffer too large (%u)\n",
+                      __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_malloc(cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a42957c4e2c..156c7457e17 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -15,6 +15,7 @@
 #define HW_VIRTIO_GPU_H
 
 #include "qemu/queue.h"
+#include "qemu/units.h"
 #include "ui/qemu-pixman.h"
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
@@ -280,6 +281,14 @@ struct VirtIOGPURutabaga {
     struct rutabaga *rutabaga;
 };
 
+/*
+ * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
+ * limit, the largest inline command is ~4 MiB.  Cap submit_3d
+ * allocations to this value to prevent a malicious guest from
+ * triggering an OOM abort via an inflated cs.size field.
+ */
+#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * MiB)
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t virtiogpufillcmd_s_ =                                    \
             iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
-- 
2.47.3


