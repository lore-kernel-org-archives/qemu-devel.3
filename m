Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCCFC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVca-0007w4-JE; Thu, 29 May 2025 01:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVcY-0007vr-SE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:02 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVcV-0008Dw-4a
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748495759; x=1780031759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yc17k8wpWISIogACctnSyw91kp14hKgKC9OUBV5WR2c=;
 b=eTFk40SWex2UR7GiyGn8FTyC6KR+i2HO6/uwDcemE0OQE0rC1q/KqAIj
 FXzA44oNX3QFuO2CzyoCM5qiCDeHr3IUFj1B9CfUA+7EmzW8qyVUpCaWh
 In6S4d8ydX1p3rI/Wbm0bI4ef+UGNZImZPILyX1hwW2NnNglQ5vLSZufn
 WjOCed0RqYEywBu28mKJK9kYSdS+xbI3z+e+Z+niWx5HZQw4ZF/D1gL7i
 OvesehMhjqma0lv3Ka+DFTx65bRq2AwDqst175mJrHkJ7Yt2K2nyWrnWJ
 15PedcYvor9geh+fHQHQ3fMbA6EuD7/vx6ze63UB1MImr09BWiZHRMX4U g==;
X-CSE-ConnectionGUID: RkNQ1a+ySzSeJTlET5mExg==
X-CSE-MsgGUID: l3B4MD63TEuDoxueYouOlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50241883"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50241883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:26 -0700
X-CSE-ConnectionGUID: xKV80PK/Q6WqCD5NfZBdLg==
X-CSE-MsgGUID: 64KBo6hqSOKbyEkG1YOJbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174455333"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:26 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v5 1/7] ui/egl-helpers: Error check the fds in
 egl_dmabuf_export_texture()
Date: Wed, 28 May 2025 22:11:12 -0700
Message-ID: <20250529051352.1409904-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

While trying to export and obtain fds associated with a texture, it
is possible that the fds returned after eglExportDMABUFImageMESA()
call have error values. Therefore, we need to evaluate the value of
all fds and return false if any of them are negative.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/egl-helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 5503a795e4..e3f2872cc1 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -295,6 +295,7 @@ bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
 {
     EGLImageKHR image;
     EGLuint64KHR modifiers[DMABUF_MAX_PLANES];
+    int i;
 
     image = eglCreateImageKHR(qemu_egl_display, eglGetCurrentContext(),
                               EGL_GL_TEXTURE_2D_KHR,
@@ -314,6 +315,11 @@ bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
         *modifier = modifiers[0];
     }
 
+    for (i = 0; i < *num_planes; i++) {
+        if (fd[i] < 0) {
+            return false;
+        }
+    }
     return true;
 }
 
-- 
2.49.0


