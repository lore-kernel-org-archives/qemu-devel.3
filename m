Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEB5C19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 01:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzoNJ-0000Et-Jt; Wed, 24 Apr 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzoNI-0000EO-8W
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 21:58:12 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzoNF-0003SC-Sb
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 21:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714010290; x=1745546290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nM6lzy2LotgC5Bu0VnCCHRXLjwNoTw5whq2lSmAvlx4=;
 b=ALzVMZf3WAziWRlmuP9QFVY5FdPRQJFgVMSQ62UehgnPhQfsKfU6Aob8
 Ps73+jznyaUukF/2ks5DJ45N24LJxIZ3tNcBH/Hevam+fx/1zWwFwD8Tz
 70H2XmDV6ENaXyLOycG+qYQoCmPZM6yzc0/Pw3vefC53yQ7cJRimPJYNJ
 NvSYBGzM8g8GqcE/e+AbkTLYYwNz0BGFsUD9HY9gotYL3AjxjtkOlCOmP
 jWziX8lmH/YQzs/h+Op7Y3xPxYiGBBVwUCpVZ7ufuPgqkK33bsL0y14Rs
 A2VUFhKwMGjkMlUTQTKEyhbZW8Db9q80RBaNycgFsH8Bfakm2/2dPJoDS g==;
X-CSE-ConnectionGUID: Gg+V4KxLRAyB1kqiORMvyw==
X-CSE-MsgGUID: Qg05K8hDQH2tuLVcozARcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9890070"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9890070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 18:58:02 -0700
X-CSE-ConnectionGUID: rWFTi6cHSdW4tGd9UG1NXQ==
X-CSE-MsgGUID: 42LoOrWcSnGR9724Ba85hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; d="scan'208";a="24914184"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 18:58:03 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v12 1/6] ui/gtk: Check if fence_fd is equal to or greater than
 0
Date: Wed, 24 Apr 2024 18:53:37 -0700
Message-Id: <20240425015342.1033815-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425015342.1033815-1-dongwon.kim@intel.com>
References: <20240425015342.1033815-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


