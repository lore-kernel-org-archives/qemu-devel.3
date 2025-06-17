Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A634FC71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5i-0002rP-J6; Tue, 17 Jun 2025 00:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5f-0002pk-D8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:31 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5d-0007ja-OY
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135110; x=1781671110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N/hxLA1NKl77VClmHWfKHM7UOdeBh5dCwhVlxw8bnz8=;
 b=TP7l1LVvu4P60yV4il8zRaPRJhHSGoKue/qQSQ7u6P34+XM/q6CFnIEx
 Aav+IWtN/XTFUAXAMdpQB9u0ojenbi7/fBrUM0rkIGGwf2d9SI9DyJCgW
 0HUHchNzg2fMPPiu6OwkQHfy9P8Tr9cG68+Hwa2xtdZPZgR6r/aEaQRLk
 vQhnVjnrlw/LUicroCPKT5jiWomq6TGzWSsLaW8m+Lzpa/Yoz6L7DtI2/
 Mczw5MkGtVnLdIYTGEufXZmeOY7fCz1ahUTyfqp3MGaUkvjmXBzOSRLo/
 VIgvZrbvy0cPg0+BbeVBdfypVrSkVoyZsNr016LKF4j0DM8INhkrWjSH1 g==;
X-CSE-ConnectionGUID: ZzrJEi4KSpCoXeGhvYdMdw==
X-CSE-MsgGUID: 8//Wg5JSSv6iec2je+oruw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432300"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432300"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:24 -0700
X-CSE-ConnectionGUID: YiGgnWO2SkW8bkYovLf+eQ==
X-CSE-MsgGUID: fn5azfjfSl6lWpBzyABr7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551044"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:23 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 3/7] ui/spice: Add an option for users to provide a
 preferred video codec
Date: Mon, 16 Jun 2025 21:32:27 -0700
Message-ID: <20250617043546.1022779-4-vivek.kasireddy@intel.com>
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

Giving users an option to choose a particular codec will enable
them to make an appropriate decision based on their hardware and
use-case. Note that, the Spice server would use this codec with
Gstreamer encoder and only when gl=on is specified.

If no codec is provided, then the codec gstreamer:h264 would be used
as default. And, for the case where gl=off, the default codec to be
used is determined by the Spice server.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 qemu-options.hx |  8 ++++++++
 ui/spice-core.c | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b..124c87311c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
+    "       [,video-codec=<codec>\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2369,6 +2370,13 @@ SRST
     ``seamless-migration=[on|off]``
         Enable/disable spice seamless migration. Default is off.
 
+    ``video-codec=<codec>``
+        Provide the preferred codec the Spice server should use with the
+        Gstreamer encoder. This option is only relevant when gl=on is
+        specified. If no codec is provided, then the codec gstreamer:h264
+        would be used as default. And, for the case where gl=off, the
+        default codec to be used is determined by the Spice server.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5acbdd3955..5e585ed958 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -488,6 +488,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "streaming-video",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "video-codec",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -662,6 +665,8 @@ static void qemu_spice_init(void)
     char *x509_key_file = NULL,
         *x509_cert_file = NULL,
         *x509_cacert_file = NULL;
+    const char *video_codec = NULL;
+    g_autofree char *enc_codec = NULL;
     int port, tls_port, addr_flags;
     spice_image_compression_t compression;
     spice_wan_compression_t wan_compr;
@@ -838,6 +843,16 @@ static void qemu_spice_init(void)
         if ((port != 0) || (tls_port != 0)) {
 #if SPICE_SERVER_VERSION >= 0x000f03 /* release 0.15.3 */
             spice_remote_client = 1;
+
+            video_codec = qemu_opt_get(opts, "video-codec");
+            if (video_codec) {
+                enc_codec = g_strconcat("gstreamer:", video_codec, NULL);
+            }
+            if (spice_server_set_video_codecs(spice_server,
+                                              enc_codec ?: "gstreamer:h264")) {
+                error_report("invalid video codec");
+                exit(1);
+            }
 #else
             error_report("SPICE GL support is local-only for now and "
                          "incompatible with -spice port/tls-port");
-- 
2.49.0


