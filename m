Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BCDC27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU5l-0001dQ-QS; Tue, 04 Jun 2024 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5k-0001cw-EE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:44 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sEU5h-0000YV-9w
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717507242; x=1749043242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QeNJeWdE0R04okVzq62lqGjYK18oTmbvamM3+nZelPU=;
 b=XDR3dB5CUauDVQGg601+X9+talFE4nUayVbbF/DlgZlG+zAgajbwVFW9
 ttGESWf1uUyv4yfkpjF6fShzthYuvK1kydz8Udcdu7odqq0mT+Xx/yMKQ
 ZKs74/dZma0mg232SKH4m6qWjgIJqxp5eLDd+p3ZdMOVAsFFRei7LHAZm
 QmsODS8UhygYOMLta5Nm0GCiZ++caRJZbL14vCv+T68DbFtHVjbBNIX2J
 56e+8KPJ3vohAOJwmMJQKv6pPxgYAP1ilN4YSJGe2puU5uLxehGV/5fot
 S0dqGs/SFheRxSaTleJk49f4Tg+Wh03F3uv4IMuCT5S4Lyj0iApzRi8jT Q==;
X-CSE-ConnectionGUID: 2grhhWKeTb6cajfMxxpvOg==
X-CSE-MsgGUID: SV42ItJdSI2RaGoPGAsQCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24628652"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24628652"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 06:20:39 -0700
X-CSE-ConnectionGUID: m/VjTPeBSVKlWRNATjD8cA==
X-CSE-MsgGUID: HrNSqwJsS4WiqW7VVKk7lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37246897"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2024 06:20:36 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v7 3/7] configure: add --enable-qpl build option
Date: Mon,  3 Jun 2024 23:41:02 +0800
Message-ID: <20240603154106.764378-4-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603154106.764378-1-yuan1.liu@intel.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

add --enable-qpl and --disable-qpl options to enable and disable
the QPL compression method for multifd migration.

The Query Processing Library (QPL) is an open-source library
that supports data compression and decompression features. It
is based on the deflate compression algorithm and use Intel
In-Memory Analytics Accelerator(IAA) hardware for compression
and decompression acceleration.

For more live migration with IAA, please refer to the document
docs/devel/migration/qpl-compression.rst

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 meson.build                   | 8 ++++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/meson.build b/meson.build
index 6386607144..d97f312a42 100644
--- a/meson.build
+++ b/meson.build
@@ -1197,6 +1197,12 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+qpl = not_found
+if not get_option('qpl').auto() or have_system
+  qpl = dependency('qpl', version: '>=1.5.0',
+                    required: get_option('qpl'),
+                    method: 'pkg-config')
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2331,6 +2337,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4439,6 +4446,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'Query Processing Library support': qpl}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 4c1583eb40..dd680a5faf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qpl', type : 'feature', value : 'auto',
+       description: 'Query Processing Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6ce5a8b72a..73ae8cedfc 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -220,6 +220,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  qpl             Query Processing Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -558,6 +559,8 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.43.0


