Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1679C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOf9-0006lX-9b; Wed, 14 May 2025 22:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf6-0006kV-P6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:32 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf5-0005hp-0Y
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747277371; x=1778813371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NymX+OvNvqfitAD9MeVg+2BvNLTTzBo4mgjZyaMzdaU=;
 b=DWiAG5ly/OS7Hdb7WQSTJeXrp+AyJ6PUaGlNbDzvWiYW53s3mZik5deP
 wS1HWvKVrpQSaxTOid7GM21jMLs8B7mYPeOYITWIWlrJGu7xWMKXBmawz
 3JMnpIhPJVSQoNmkGXM/dn9pLAV5+s3Q2J6TwvaxNZBuQYMjqv3vdX4dc
 T1ZFEXiooKXdGdTVxNOxzSLyES6EWJ34m7aNljS8bAGRMeYw6riTSHd0e
 7tQjSX+UkkX87zcrOjAFMk+m8A9tQgOWyLuX+elYlGNNZITMMSGok8D76
 bIFJERQeU21CF5zAl150h2r8RGX0jYCsWrc6UIbFlPdikPaVvradDqfVC g==;
X-CSE-ConnectionGUID: P+XQwSbaQTG+9IM+DM+grQ==
X-CSE-MsgGUID: kJfLo1IHQnm8uZFptWbnEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36819293"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="36819293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
X-CSE-ConnectionGUID: aVYoyly7QK+aLVBry5qhbQ==
X-CSE-MsgGUID: 7Py3bt8WRLKNe0z/4vtLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="142246645"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v4 1/7] ui/egl-helpers: Error check the fds in
 egl_dmabuf_export_texture()
Date: Wed, 14 May 2025 19:45:39 -0700
Message-ID: <20250515024734.758335-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515024734.758335-1-vivek.kasireddy@intel.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
call are -1. Therefore, we need to evaluate the value of all fds
and return false if any of them are -1.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/egl-helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 9cda2bbbee..07d8edd3dc 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -289,6 +289,7 @@ bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
 {
     EGLImageKHR image;
     EGLuint64KHR modifiers[DMABUF_MAX_PLANES];
+    int i;
 
     image = eglCreateImageKHR(qemu_egl_display, eglGetCurrentContext(),
                               EGL_GL_TEXTURE_2D_KHR,
@@ -308,6 +309,11 @@ bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
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


