Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76FC71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5g-0002qC-4n; Tue, 17 Jun 2025 00:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5e-0002pW-Qb
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:30 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5b-0007je-EI
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135108; x=1781671108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IglXtui1Vatd43jD84nQ+rb4ziwGuJrvIl5/7WfV7Ng=;
 b=n52J+Q9FwaKD7n/lQD50S6uFlWczb8vG7c5tVa4I0zcQrb8hBe0U8R9E
 W9/s2O0O4r0388f7TiaDZD7u033DOgZi8dyXgcRtZXmjkoDJwdBTbL9JY
 g3VObYf143qpG9i6Jj/0OuwvfFi4Elf/YaU+WraYenrzr5kprG2442BsB
 KtouJqR2PIVr4/N5/e8VndnSaEnI7ngvC/7UKwR33SVnTNmmJw92RnvEE
 D/baVOAwLWoWBuIh7Hskelxf87oKCzCMJ+r907VTr5qtTVl/uwFsIZM2t
 a4Cuc7edyBxVZrQ8MVBLtU4RX81mWxj8Bx3JB3PMLpnznm+k00GgTvmma Q==;
X-CSE-ConnectionGUID: G5+f97wZRfKxTvk3TKIABw==
X-CSE-MsgGUID: cZgrbfGiSIGGJcaP8esFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432292"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432292"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:24 -0700
X-CSE-ConnectionGUID: fEi7vHC9QH60ohAHmC5TQQ==
X-CSE-MsgGUID: YYAS85NHQSmP8yDIC+/SZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551038"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:22 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v6 2/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Mon, 16 Jun 2025 21:32:26 -0700
Message-ID: <20250617043546.1022779-3-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h | 1 +
 ui/spice-core.c            | 4 ++++
 ui/spice-display.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index e1a9b36185..6c55f38c8b 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -151,6 +151,7 @@ struct SimpleSpiceCursor {
 };
 
 extern bool spice_opengl;
+extern bool spice_remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0326c63bec..5acbdd3955 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -836,9 +836,13 @@ static void qemu_spice_init(void)
 #ifdef HAVE_SPICE_GL
     if (qemu_opt_get_bool(opts, "gl", 0)) {
         if ((port != 0) || (tls_port != 0)) {
+#if SPICE_SERVER_VERSION >= 0x000f03 /* release 0.15.3 */
+            spice_remote_client = 1;
+#else
             error_report("SPICE GL support is local-only for now and "
                          "incompatible with -spice port/tls-port");
             exit(1);
+#endif
         }
         egl_init(qemu_opt_get(opts, "rendernode"), DISPLAY_GL_MODE_ON, &error_fatal);
         spice_opengl = 1;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 9c39d2c5c8..0fb72f6d6f 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -31,6 +31,7 @@
 #include "standard-headers/drm/drm_fourcc.h"
 
 bool spice_opengl;
+bool spice_remote_client;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
-- 
2.49.0


