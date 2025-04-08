Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BCCC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23BW-0004WG-85; Tue, 08 Apr 2025 03:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u23BR-0004Vl-2Y
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:15:46 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u23BK-0000x7-NX
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:15:42 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id DBB701C1582; Tue,  8 Apr 2025 09:15:35 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH 1/3] new configure option to enable gstreamer
Date: Tue,  8 Apr 2025 09:15:30 +0200
Message-Id: <20250408071532.2417316-2-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408071532.2417316-1-dietmar@proxmox.com>
References: <20250408071532.2417316-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

GStreamer is required to implement H264 encoding for VNC. Please note
that QEMU already depends on this library when you enable Spice.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  5 ++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 41f68d3806..28ca37855a 100644
--- a/meson.build
+++ b/meson.build
@@ -1348,6 +1348,14 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+
+gstreamer = not_found
+if not get_option('gstreamer').auto() or have_block
+  gstreamer = dependency('gstreamer-1.0 gstreamer-base-1.0', version: '>=1.22.0',
+                          required: get_option('gstreamer'),
+                          method: 'pkg-config')
+endif
+
 qpl = not_found
 if not get_option('qpl').auto() or have_system
   qpl = dependency('qpl', version: '>=1.5.0',
@@ -2563,6 +2571,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_GSTREAMER', gstreamer.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
 config_host_data.set('CONFIG_QATZIP', qatzip.found())
@@ -4836,6 +4845,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'gstreamer support': gstreamer}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
 summary_info += {'qatzip support':    qatzip}
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..11cd132be5 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -254,6 +254,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
        description: 'SASL authentication for VNC server')
 option('vte', type : 'feature', value : 'auto',
        description: 'vte support for the gtk UI')
+option('gstreamer', type : 'feature', value : 'auto',
+       description: 'for VNC H.264 encoding with gstreamer')
 
 # GTK Clipboard implementation is disabled by default, since it may cause hangs
 # of the guest VCPUs. See gitlab issue 1150:
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..b0c273d61e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -229,6 +229,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  gstreamer       gstreamer support (H264 for VNC)'
 }
 _meson_option_parse() {
   case $1 in
@@ -581,6 +582,8 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
-    *) return 1 ;;
+    --enable-gstreamer) printf "%s" -Dgstreamer=enabled ;;
+    --disable-gstreamer) printf "%s" -Dgstreamer=disabled ;;
+   *) return 1 ;;
   esac
 }
-- 
2.39.5


