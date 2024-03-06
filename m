Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3210C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlK-0007Ov-IO; Wed, 06 Mar 2024 04:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlJ-0007OR-6T
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:33 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlG-0001uh-M3
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718031; x=1741254031;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f6OTZoDEaml87HlcsQbLYoMKzzLqIqS8+uZTyLxl2Bg=;
 b=SrXcMYxWo+X6deEbLrNQxEUpvmXx0oaiIwdT9wgPiODm1UalAy+PWcf4
 t2+d0n1Ny8xbLkGmibkvYrvbKOQAAGO5fh8V9qX/g31RXlRHdd4zSQQP1
 4UhQijkSriZJ7j/HIbmCuMZ6KW+bYbmhJb9hAbpyUQ95pt98Q87FSxu+F
 2CBX/uZNx7TkmNBjAp406z/RMPUI3cRjyVyEfqJ6za/+BCJun0y3zwiKo
 BdXkGuGLDUC39xhWOLtQxMGRuWUiNQxGZ67PTw/+75o3Eggul5o6cB9X5
 nkbpXGpqQRwyMKUBMOFePDl44M8xJWwcfh4/7+mYwKpz8mw+b+Efjtu5o g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897797"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897797"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854121"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:24 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/14] Cleanup on SMP and its test
Date: Wed,  6 Mar 2024 17:53:53 +0800
Message-Id: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Hi all,

To make review easier, I've merged my previous single SMP patch [1] and
SMP test series [2] into this series as well.

So this series includes:
 * [Patch 1] Remove deprecated "parameter=0" SMP configurations, which
   is marked as deprecated in v6.2.
 * [Patch 2] Deprecate unsupported "parameter=1" SMP configurations.
 * [Patch 3 & 4] Minor code cleanup for machine_parse_smp_config().
 * [Patch 5 ~ 14] Test case enhancements to cover more SMP API changes.

[1]: https://lore.kernel.org/qemu-devel/20240304044510.2305849-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240118144857.2124034-1-zhao1.liu@linux.intel.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (14):
  hw/core/machine-smp: Remove deprecated "parameter=0" SMP
    configurations
  hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
    configurations
  hw/core/machine-smp: Simplify variables' initialization in
    machine_parse_smp_config()
  hw/core/machine-smp: Calculate total CPUs once in
    machine_parse_smp_config()
  tests/unit/test-smp-parse: Drop the unsupported "dies=1" case
  tests/unit/test-smp-parse: Use CPU number macros in invalid topology
    case
  tests/unit/test-smp-parse: Bump max_cpus to 4096
  tests/unit/test-smp-parse: Make test cases aware of the book/drawer
  tests/unit/test-smp-parse: Test "books" parameter in -smp
  tests/unit/test-smp-parse: Test "drawers" parameter in -smp
  tests/unit/test-smp-parse: Test "drawers" and "books" combination case
  tests/unit/test-smp-parse: Test the full 7-levels topology hierarchy
  tests/unit/test-smp-parse: Test smp_props.has_clusters
  tests/unit/test-smp-parse: Test "parameter=0" SMP configurations

 docs/about/deprecated.rst       |  30 +-
 docs/about/removed-features.rst |  15 +
 hw/core/machine-smp.c           |  94 +++--
 tests/unit/test-smp-parse.c     | 612 ++++++++++++++++++++++++++++++--
 4 files changed, 678 insertions(+), 73 deletions(-)

-- 
2.34.1


