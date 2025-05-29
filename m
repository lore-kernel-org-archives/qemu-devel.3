Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E047C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVcu-0007zx-Q7; Thu, 29 May 2025 01:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVce-0007wk-QL
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:09 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVcX-0008Fu-0W
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748495761; x=1780031761;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4X+tc/ZfuwXxOMlHJnBOXl0SCmRCGqp36mjmnOyLU04=;
 b=UHlTTEVHEnugNtoryBG/XsQ4ZsaVWCIm/lOEFNV1bCS9Q1ln6nu+HjJI
 orvY0CrspW/LtdzJcoOyKHr9KVxQ3DOUQSLWV60qus62VaOOM7ADQrLtX
 DFcyn5Z/WKcp+HBXsDFB9eoyIsqfLqfXyg8UJgw78DtwLppnPQ9N7iQb9
 Tv7SisekFFpAjppaY9WH0JjIdRrHwvxnp1uUV8ec7ajuHG/rGeaOiWe4v
 ekr0pgccdc4qgIcdpgYZsdlWHnjh9wmzg3mwHQJh6a5QEG3IQJ6ui7Nrp
 8l73wYS6EACc2m9LOmlNpAfV4MSEXCR9hrVWZOr+2pDooFuzWOZrzVSqh Q==;
X-CSE-ConnectionGUID: FELxNTD7S7mx9lR2/7H4QQ==
X-CSE-MsgGUID: moX06uvPQ5KV71ZWC9eqkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50241888"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50241888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:26 -0700
X-CSE-ConnectionGUID: JsMBluJcQvmaq7hYFWigHg==
X-CSE-MsgGUID: diIZT5E2SJu+XcNWYvr75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174455336"
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
Subject: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Date: Wed, 28 May 2025 22:11:13 -0700
Message-ID: <20250529051352.1409904-3-vivek.kasireddy@intel.com>
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

Giving users an option to choose a particular codec will enable
them to make an appropriate decision based on their hardware and
use-case.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 qemu-options.hx |  5 +++++
 ui/spice-core.c | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..fcddb583c9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
+    "       [,video-codecs=<encoder>:<codec>\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2369,6 +2370,10 @@ SRST
     ``seamless-migration=[on|off]``
         Enable/disable spice seamless migration. Default is off.
 
+    ``video-codecs=<encoder>:<codec>``
+        Provide the preferred codec the Spice server should use.
+        Default would be spice:mjpeg.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0326c63bec..907b0e9a81 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -488,6 +488,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "streaming-video",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "video-codecs",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -662,6 +665,7 @@ static void qemu_spice_init(void)
     char *x509_key_file = NULL,
         *x509_cert_file = NULL,
         *x509_cacert_file = NULL;
+    const char *video_codecs = NULL;
     int port, tls_port, addr_flags;
     spice_image_compression_t compression;
     spice_wan_compression_t wan_compr;
@@ -801,6 +805,14 @@ static void qemu_spice_init(void)
         spice_server_set_streaming_video(spice_server, SPICE_STREAM_VIDEO_OFF);
     }
 
+    video_codecs = qemu_opt_get(opts, "video-codecs");
+    if (video_codecs) {
+        if (spice_server_set_video_codecs(spice_server, video_codecs)) {
+            error_report("invalid video codecs");
+            exit(1);
+        }
+    }
+
     spice_server_set_agent_mouse
         (spice_server, qemu_opt_get_bool(opts, "agent-mouse", 1));
     spice_server_set_playback_compression
-- 
2.49.0


