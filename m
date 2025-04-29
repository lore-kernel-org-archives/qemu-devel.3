Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58276C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eCd-0000ZS-P0; Tue, 29 Apr 2025 02:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCX-0000W3-Om
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:18 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCU-0005MH-Uz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907135; x=1777443135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FwoHFOGEmvR//f0X656oVgm6BG9908c723pjOWvbflw=;
 b=B7W2OXYIQvgwnELkQX6gxKB+/hGeoLGoQq6xkoVN4y9fRq3n62uI8d/O
 YdrLMsdxpDjTOotdU62bEs1b1nOwlkeV7LgE6wMShaGLk0pTVVtV1W0SA
 1gm1GVfuja7sj6GsGQgt59yhVXUy3Vb9/T+nhM0hDLvFYv6+xj2imhkuP
 JZEQ1YyaReaPLYgta1bKDip2cAawvbOMZFUbAR18ZulaOuJcvZATbj9HO
 CWlD4IGdiChERmw7fQ7c9VE6RpYlWFRZsnz9mzX6DBsIghx6Fp27QvtfS
 Xbfx2aePSuxomDI9Wr/gZENBAFmUVXKX2iursvjn+03csm3Z/vKDaQFeq w==;
X-CSE-ConnectionGUID: aAaLEfQ1QASln7bLFzoi+w==
X-CSE-MsgGUID: zK3cFua5RmC5QEDDYK2/CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58169821"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58169821"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:10 -0700
X-CSE-ConnectionGUID: uhaGMmQBSzW8wRcZpjak6w==
X-CSE-MsgGUID: 7mP4r32qQsSxKzpEiKZbKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133687168"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:05 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v3 2/6] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Mon, 28 Apr 2025 23:08:26 -0700
Message-ID: <20250429060952.59508-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429060952.59508-1-vivek.kasireddy@intel.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

Newer versions of Spice server should be able to accept dmabuf
fds from Qemu for clients that are connected via the network.
In other words, when this option is enabled, Qemu would share
a dmabuf fd with Spice which would encode and send the data
associated with the fd to a client that could be located on
a different machine.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h | 1 +
 ui/spice-core.c            | 4 ++++
 ui/spice-display.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index e1a9b36185..f4922dd74b 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -151,6 +151,7 @@ struct SimpleSpiceCursor {
 };
 
 extern bool spice_opengl;
+extern bool remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 907b0e9a81..6c3bfe1d0f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -848,9 +848,13 @@ static void qemu_spice_init(void)
 #ifdef HAVE_SPICE_GL
     if (qemu_opt_get_bool(opts, "gl", 0)) {
         if ((port != 0) || (tls_port != 0)) {
+#if SPICE_SERVER_VERSION >= 0x000f03 /* release 0.15.3 */
+            remote_client = 1;
+#else
             error_report("SPICE GL support is local-only for now and "
                          "incompatible with -spice port/tls-port");
             exit(1);
+#endif
         }
         egl_init(qemu_opt_get(opts, "rendernode"), DISPLAY_GL_MODE_ON, &error_fatal);
         spice_opengl = 1;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index c794ae0649..bf4caf0d1b 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -29,6 +29,7 @@
 #include "ui/spice-display.h"
 
 bool spice_opengl;
+bool remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
-- 
2.49.0


