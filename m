Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDF6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 22:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCS1F-0000qT-3D; Wed, 29 May 2024 18:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sCS1D-0000q6-74
 for qemu-devel@nongnu.org; Wed, 29 May 2024 18:43:39 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sCS1A-0003RR-CE
 for qemu-devel@nongnu.org; Wed, 29 May 2024 18:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717022617; x=1748558617;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o6eJoGEQ4cHDf0gdjpwQZU0x3c/RoKpA2c+dWeUMxvQ=;
 b=TsRNcMLKhsR7aBB82Hra8lOoTipS8lCX1uAOprQwx6rM7nJZxXW3Gkpz
 doPbyvNRyXO3h6OEWFeUpl4wtkTDza/rXIcmxrroBn9uBfua2iaHEA0ug
 Q9JUYq5dM3Aum/xgYn9cC/hlVol7/H+CoFaOGqvYIfwyH4R2lPLbwPhGq
 3xvQ8xHR+7L1YDPUNgdoO6dLSner8p1LYGdXfz0iqNBxBfRlKKma7CU7r
 rEHgaZCGcP8TdHxYa/pjwS74oJlulHYwCWTRQK/dA+y0aUzxB/e1FEfoC
 WoRidFr9agEEtPSnytw6XRLEN65fIzG/bwOP8r4dyPLGdxLeVyRf17leW Q==;
X-CSE-ConnectionGUID: I2tTRlT+RSy734jOQj2njQ==
X-CSE-MsgGUID: MZyXvLcXQAizTgVFV8jf5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17254099"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="17254099"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 15:43:31 -0700
X-CSE-ConnectionGUID: GzZu+FxqRzi694/eW8w2oA==
X-CSE-MsgGUID: LlyM9BTJT3WGHu8/oL+ZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="35633795"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa006.fm.intel.com with ESMTP; 29 May 2024 15:43:30 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Wait until the current guest frame is rendered before
 switching to RUN_STATE_SAVE_VM
Date: Wed, 29 May 2024 15:42:52 -0700
Message-Id: <20240529224252.80395-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Dongwon <dongwon.kim@intel.com>

Make sure rendering of the current frame is finished before switching
the run state to RUN_STATE_SAVE_VM by waiting for egl-sync object to be
signaled.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/egl-helpers.c |  2 --
 ui/gtk.c         | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 99b2ebbe23..dafeb36074 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -396,8 +396,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
         fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
                                               sync);
         qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
-        eglDestroySyncKHR(qemu_egl_display, sync);
-        qemu_dmabuf_set_sync(dmabuf, NULL);
     }
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 93b13b7a30..cf0dd6abed 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -600,9 +600,12 @@ void gd_hw_gl_flushed(void *vcon)
 
     fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
     if (fence_fd >= 0) {
+        void *sync = qemu_dmabuf_get_sync(dmabuf);
         qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
         close(fence_fd);
         qemu_dmabuf_set_fence_fd(dmabuf, -1);
+        eglDestroySyncKHR(qemu_egl_display, sync);
+        qemu_dmabuf_set_sync(dmabuf, NULL);
         graphic_hw_gl_block(vc->gfx.dcl.con, false);
     }
 }
@@ -682,6 +685,22 @@ static const DisplayGLCtxOps egl_ctx_ops = {
 static void gd_change_runstate(void *opaque, bool running, RunState state)
 {
     GtkDisplayState *s = opaque;
+    QemuDmaBuf *dmabuf;
+    int i;
+
+    if (state == RUN_STATE_SAVE_VM) {
+        for (i = 0; i < s->nb_vcs; i++) {
+            VirtualConsole *vc = &s->vc[i];
+            dmabuf = vc->gfx.guest_fb.dmabuf;
+            if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) >= 0) {
+                /* wait for the rendering to be completed */
+                eglClientWaitSync(qemu_egl_display,
+                                  qemu_dmabuf_get_sync(dmabuf),
+                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
+                                  1000000000);
+            }
+        }
+    }
 
     gd_update_caption(s);
 }
-- 
2.34.1


