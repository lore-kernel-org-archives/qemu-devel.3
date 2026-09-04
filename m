Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABBEC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbF-0001Cr-HV; Fri, 04 Sep 2026 00:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kn6-0004UD-UY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:40:36 -0400
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kn2-0003BY-Nu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 23:40:36 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c7fb7a3b;
 Fri, 4 Sep 2026 11:33:24 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Hongyan Xu <getshell@seu.edu.cn>
Subject: [RFC PATCH] virtio-gpu: guard BH scheduling against a late hostmem
 region finalize
Date: Fri,  4 Sep 2026 11:33:24 +0800
Message-ID: <20260904033324.1754-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a7a6de203a1kunmc8190e32241bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0tLVh0eSR5DGRpLSU1IS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
 5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=mHL8TOENSGooDIHHXUShT9dN9sEGAN9V8i+HIN2voRIrERQh+pQdIMAHLFI43a0hDyEHazRsnniZNK5wuzK7aV8kZeWaDKE5PLQmS1HMMOFR3PI6Lic/osAVVk4MPz7UWbQ1Z2eH/g5u8rKBYNDxsX0/m14aB+MtglLwcUffuJs=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=6pPjq38Rl1B06uwZRdHLtZfA+MlrG39TWGjcdYU28xg=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.254.49.198; envelope-from=getshell@seu.edu.cn;
 helo=mail-m49198.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

virtio_gpu_gl_device_unrealize() deletes gl->cmdq_resume_bh (and, when
present, gl->async_fence_bh).  As the comment in that function notes,
hostmem memory regions are not guaranteed to be finalized during
unrealize(): their finalize may be deferred (e.g. through an RCU /
object reference lifetime) until after unrealize() has returned.

virtio_gpu_virgl_hostmem_region_finalize() runs on that deferred path
and calls qemu_bh_schedule(gl->cmdq_resume_bh).  If the finalize lands
after unrealize() has deleted the BH, this schedules a deleted BH
(a use-after-free / use-after-delete window on the BH object).

NULL out both BHs after deleting them in unrealize(), and guard the two
schedule sites in virtio-gpu-virgl.c with a NULL check so a late
finalize (or a late async-fence callback) simply skips the wake-up
instead of touching a deleted BH.

This is an RFC: this area overlaps Akihiko Odaki's "Fix memory region
use-after-finalization" discussion series; if that series lands first
this patch should be reworked to fit its lifetime model.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 hw/display/virtio-gpu-gl.c    | 8 ++++++++
 hw/display/virtio-gpu-virgl.c | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c466..2fd3f84a91 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -180,10 +180,18 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     if (gl->renderer_state >= RS_INITED) {
 #if VIRGL_VERSION_MAJOR >= 1
         qemu_bh_delete(gl->cmdq_resume_bh);
+        /*
+         * hostmem memory regions can be finalized after unrealize()
+         * returns (see below); their finalize path schedules
+         * cmdq_resume_bh, so NULL it out to let them detect that the
+         * BH is gone instead of touching a deleted BH.
+         */
+        gl->cmdq_resume_bh = NULL;
 
         if (gl->async_fence_bh) {
             virtio_gpu_virgl_reset_async_fences(g);
             qemu_bh_delete(gl->async_fence_bh);
+            gl->async_fence_bh = NULL;
         }
 #endif
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9bda572426..d38d8fe995 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -134,7 +134,9 @@ static void virtio_gpu_virgl_hostmem_region_finalize(Object *obj)
      * context.
      */
     gl = VIRTIO_GPU_GL(vmr->g);
-    qemu_bh_schedule(gl->cmdq_resume_bh);
+    if (gl->cmdq_resume_bh) {
+        qemu_bh_schedule(gl->cmdq_resume_bh);
+    }
 }
 
 static const TypeInfo virtio_gpu_virgl_hostmem_region_info = {
@@ -1294,7 +1296,9 @@ virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
 
     QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
 
-    qemu_bh_schedule(gl->async_fence_bh);
+    if (gl->async_fence_bh) {
+        qemu_bh_schedule(gl->async_fence_bh);
+    }
 }
 
 static void virgl_write_async_fence(void *opaque, uint32_t fence)
-- 
2.50.1.windows.1


