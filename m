Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EB3C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 04:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry2XU-0005jo-Of; Sat, 20 Apr 2024 00:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1ry2XJ-0005iH-M2
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 00:41:16 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1ry2XI-0005Yl-33
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 00:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713588072; x=1745124072;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=67NgeQ/kFsPNIg8m3af1zHaTrIuCCnTfBkPGdpoYPQc=;
 b=Faa4X3lXmysrfpgqXiBSXlLp05oDQj2qoXVLgnpgnLDgaC1sn2pJIjGB
 npxuJ9jT7AB0rNNRdwspkJi3oojdf1GZIxGoa9ZBBfjJhAY+UgbIr3QbY
 pTp1M9j4jA+5+y6KsZ/ppvrlZ87jXhP3AsOO2Nu8cVGUN3z+fGv48v5dL
 mYZbVm5AMoNGwx+7Ukzw+yQQS8STfxv9+ddz0t3OZWLerzEW70XRpEdlk
 9p2P2mQkjJCzvi8HRc+dXo2S0EYC9ASQjvHtNAzt+aWbomnjj8Au1AyFw
 ZNslii4UQLI6zFvG9I/KjjasS4LvGaYh9X0gtZ9eK+HZ845tLRpYnx6ky w==;
X-CSE-ConnectionGUID: TVjmBPDIR3+4fgP+ZYJBtQ==
X-CSE-MsgGUID: 6Gsf8xXGRLaTpt1a/tAc+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12143205"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; d="scan'208";a="12143205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 21:41:05 -0700
X-CSE-ConnectionGUID: XDLw+mEVREWhbwKSXAEsSg==
X-CSE-MsgGUID: PYvRWs/NRVGyjnz/PQLaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; d="scan'208";a="23579228"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 21:41:05 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v9 1/6] ui/gtk: Check if fence_fd is equal to or greater than 0
Date: Fri, 19 Apr 2024 21:36:44 -0700
Message-Id: <20240420043649.995462-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420043649.995462-1-dongwon.kim@intel.com>
References: <20240420043649.995462-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

'fence_fd' needs to be validated always before being referenced
And the passing condition should include '== 0' as 0 is a valid
value for the file descriptor.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     |  2 +-
 ui/gtk-gl-area.c |  2 +-
 ui/gtk.c         | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3af5ac5bcf..955234429d 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -99,7 +99,7 @@ void gd_egl_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
         if (dmabuf) {
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            if (dmabuf->fence_fd >= 0) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 52dcac161e..7fffd0544e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -86,7 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
         if (dmabuf) {
             egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            if (dmabuf->fence_fd >= 0) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..7819a86321 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,10 +597,12 @@ void gd_hw_gl_flushed(void *vcon)
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 
-    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-    close(dmabuf->fence_fd);
-    dmabuf->fence_fd = -1;
-    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    if (dmabuf->fence_fd >= 0) {
+        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
+        close(dmabuf->fence_fd);
+        dmabuf->fence_fd = -1;
+        graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    }
 }
 
 /** DisplayState Callbacks (opengl version) **/
-- 
2.34.1


