Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82F4C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOf5-0006io-Bz; Wed, 14 May 2025 22:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf2-0006Z3-9V
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:28 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf0-0005hp-I0
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747277366; x=1778813366;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iJKqygNxurlqQkKd26/VkSuPTwdrNmwQkHQcW/WPHpQ=;
 b=Y3N8NLhSPM7SMNylcrn1G58fT2Ua7LtbyQh+dCURWwa+EKIMWPyOU5C0
 Lw47Ab+zCMgvL4jg1wfiUXFkmqptaoGU3pyOrznmKfR8atIzdxXP1n4SU
 /wtb2AXH0s6ooCp2qWBCR709ItWUBIrLNA0LnXHDKzmcGN1uei3zHA6xA
 UA7JmGrp/81rs8aNZmpfLOfSCDW0t6CPuGyJEpzb3zzkSzFWrSFqI+EAN
 mrVgiJ2jw7FcBxLGAQWIaRu8BVVB1M/7EftWsc3TxFN8/UOYaN8BKLajV
 2VDOlw9j6GNe4WZdO9GGA0OqOjBcF2uf+3NHSj9HVtbJCffLY9Yh7l+Ft w==;
X-CSE-ConnectionGUID: s6BCVNXQR2qVtALzCE9e0w==
X-CSE-MsgGUID: H9U0kRBbRN6qrhkNep/MEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36819301"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="36819301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
X-CSE-ConnectionGUID: 72h0258bRS6gQKhKqBUVIQ==
X-CSE-MsgGUID: MyxSDypIRYW29a3qtoming==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="142246651"
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
Subject: [PATCH v4 3/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Wed, 14 May 2025 19:45:41 -0700
Message-ID: <20250515024734.758335-4-vivek.kasireddy@intel.com>
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
index 9c39d2c5c8..9140169015 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -31,6 +31,7 @@
 #include "standard-headers/drm/drm_fourcc.h"
 
 bool spice_opengl;
+bool remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
-- 
2.49.0


