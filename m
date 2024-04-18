Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C8C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxZxF-0001OU-U1; Thu, 18 Apr 2024 18:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZxD-0001Nm-IB
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:03 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZxB-0001zY-QG
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713478202; x=1745014202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=67NgeQ/kFsPNIg8m3af1zHaTrIuCCnTfBkPGdpoYPQc=;
 b=R5hTCJPb4A65C/V1dvyV0H3A7fBTX4ZZeAzRIYZyBcg3PBDySCsEzp8X
 P0vnlnWNDzzRl3uvcIjkhjdiX0941M4W4uByXB7ga2bFqmbLmhsQRZo6f
 TdTz0cw/uPz8zuxbP/QX7U/uhuvZ2ap4Cl4yvnVVe0VPCgoru2/JFK2eI
 HliqKQPT3gu/J6EAMLduKICfTSFPPpqx/7AYb6I+qXLMvK2CY7qnAJn32
 Upd+V5q+bBNtDdBgt2OVJ5Hps2DVmiBt/BY4IHeI56Nn3AMUcy4g8+NfJ
 wF4U51G2jMlv/Oq3CrsfJzA4eLpDBZbZWOJl34jjVD2VbJ9PF7P57B0ls w==;
X-CSE-ConnectionGUID: N6034nuITiGAUdL4evwlog==
X-CSE-MsgGUID: hFI9KHY6QWaqmJBL9d+pqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12002026"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="12002026"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 15:09:55 -0700
X-CSE-ConnectionGUID: Yfuym83mTTCq/NaseYFgOw==
X-CSE-MsgGUID: LM1fzT6jQ0K8rzjO2CU2Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="60559328"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 15:09:55 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com
Subject: [PATCH v7 1/5] ui/gtk: Check if fence_fd is equal to or greater than 0
Date: Thu, 18 Apr 2024 15:05:37 -0700
Message-Id: <20240418220541.931134-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418220541.931134-1-dongwon.kim@intel.com>
References: <20240418220541.931134-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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


