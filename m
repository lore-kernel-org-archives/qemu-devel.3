Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17860C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDvd-0000Of-LP; Tue, 25 Mar 2025 19:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDvc-0000OF-1i
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:28 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDva-0005HG-Fw
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742946207; x=1774482207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/yhzdTVtbjLDOfbBVYK0yLq4kmiWJb3G6zaE5uCqEKw=;
 b=Vz5EenhxZ4h+9j3+xEv12n6l+9uLq6H3GJO+SOsEx4IzEuW987Jt0bxq
 zh2JYLk4nKR+EfhQyQ5AdoSoyMVyzxaqqk3gOTDHNzYJbEXNPY+mzSGnO
 Crn2RMP4ByI6HebrNbQVbHa4LIMmGwQZ+nFUJv+NzOmTDkH5C34YlGnVC
 c78rjEtgZSrpTpmyWLvBwGdpVpXpcwwzzgeBvrwt1yOqEYICM1VkoK0ET
 3s9dL7IKC3Ur7bgGJWOtAAROwZVV27+G0yFjqMcry2YPz3nqSxCOLVNq2
 wVBaWxysn90nuC7cmifjoM1XEOmRTD90Da4uVcMPUQr0UG+bDdeH6ALvQ A==;
X-CSE-ConnectionGUID: xVUJX4O8SQWGWG20nXk40w==
X-CSE-MsgGUID: B+UmL4WzQ+C5Vaz2qEO8aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55582837"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="55582837"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:19 -0700
X-CSE-ConnectionGUID: 7B5tVD4QQqSZHeDTxpjtOg==
X-CSE-MsgGUID: /KkoT80HQdiAappEy1/H/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="124332499"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:18 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v2 2/6] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Tue, 25 Mar 2025 16:39:32 -0700
Message-ID: <20250325234115.1332883-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
2.48.1


