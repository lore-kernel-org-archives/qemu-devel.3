Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E86C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tz7-0003NV-0w; Mon, 06 May 2024 04:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tyy-0003Fi-NS
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:46:01 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s3tyt-0003RW-0F
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714985155; x=1746521155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ChOe8gjwm6ew8GfRN6Ns/k8C5Fe3UICSPcgTGcJ/ZK0=;
 b=dCSHntw6z3mDG7zHfFCKO8mGPEFwWrYg9RUUX5MYpf7NonblATPLtbDp
 nX7NLaU6Xjnf+Onp0LVFCW41eYDxRmNqOkxzWQ0slox/DYgKThvTKklY5
 UW1cEtPqfCE273lfzBK/8z3Tc9C8QDftj3qIGRVxsEV98cUuxirA/O5hJ
 E/TpztvQ6TraE8o4G1kTd5Ukyj14ZmoFxk5q5O8kIfGf0K/Zp4oB5L/ea
 GXY+EB0Da/0M6snq/euyh37RZ79mU110dg5v1CIrsvrwV+CnHRYMX8Zll
 aZVH+O3LpJkruyyUoh/DF95ObNr6N6GYELENDy6AOmV/+Iw5OIPA72oUW w==;
X-CSE-ConnectionGUID: OAj+tArGQRSbTHNKW1ipKQ==
X-CSE-MsgGUID: 1gI0Bf4zS5CV8GDXQvmCaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21875803"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="21875803"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:45:53 -0700
X-CSE-ConnectionGUID: 3p9RtNymRAOCRKH8dP8AGQ==
X-CSE-MsgGUID: i4RGAygPTxW9ch5ucnmpyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28203245"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa006.fm.intel.com with ESMTP; 06 May 2024 01:45:51 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v6 3/7] configure: add --enable-qpl build option
Date: Mon,  6 May 2024 00:57:47 +0800
Message-Id: <20240505165751.2392198-4-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240505165751.2392198-1-yuan1.liu@intel.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.431, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
index 5db2dbc12e..2a8d8385fe 100644
--- a/meson.build
+++ b/meson.build
@@ -1204,6 +1204,12 @@ if not get_option('zstd').auto() or have_block
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
@@ -2309,6 +2315,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4436,6 +4443,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'Query Processing Library support': qpl}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index adc77bae0c..562db29ab4 100644
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
index 0a29d35fdb..26bf9e21fd 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -222,6 +222,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  qpl             Query Processing Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -562,6 +563,8 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.39.3


