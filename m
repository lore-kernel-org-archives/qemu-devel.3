Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2EC54E5E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSK-0000Xg-Dq; Fri, 08 Mar 2024 10:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSH-0000X9-Vd
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:18 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSF-0003yA-G8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912896; x=1741448896;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SlAS9yX5j5dP2elx0rVWW8Uz1U3RxAWhNkK3q/6NEz4=;
 b=bROjxydHN9kmhJ77ERqUmrwMSunVMWPdVD6/eVSLYai98r+uLHwDc8N2
 hPFFwHEKXyOCmP49tJgMBoRxxmcVW7a+vkbXXbtNiNgw+hdYGUJMWrujJ
 9Ub3sffxbk3h2vP2Cf3KA3F9dNATPW/PbX8EXrIp806tqEhB96DTSh67D
 XtArAiK19B2+LnbulpkP0QBxbg2EPDbEVyJ2pmvy+w/HkhEqQZseHiHlT
 809yiRWedMZqrRKkxc8h/l/uryZZftJt8/0RX6TLfjGP2wuALOE82cbX1
 MVB3DSHCDaxJ1V/qDDxjkLRZw7RXpO3kbuglRxwaUdMBA/PV1PIGDudHp Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4560993"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4560993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400311"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:10 -0800
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
Subject: [PATCH v2 00/13] Cleanup on SMP and its test
Date: Sat,  9 Mar 2024 00:01:35 +0800
Message-Id: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

This is v2 to cleanup SMP and its test cases.

Compared with v1, v2 have these changes:
 * Dropped the patch [2] about making default initialization based on
   SMPConfiguration members. (Thomas)
 * Fixed typos. (Thomas)

This series includes:
 * [Patch 1] Remove deprecated "parameter=0" SMP configurations, which
             is marked as deprecated in v6.2.
 * [Patch 2] Deprecate unsupported "parameter=1" SMP configurations.
 * [Patch 3] Minor code cleanup for machine_parse_smp_config().
 * [Patch 4 ~ 13] Test case enhancements to cover more SMP API changes.

[1]: https://lore.kernel.org/qemu-devel/20240306095407.3058909-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240306095407.3058909-4-zhao1.liu@linux.intel.com/

Thanks for your review!

Best Regards,
Zhao
---
Zhao Liu (13):
  hw/core/machine-smp: Remove deprecated "parameter=0" SMP
    configurations
  hw/core/machine-smp: Deprecate unsupported "parameter=1" SMP
    configurations
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
 hw/core/machine-smp.c           |  76 ++--
 tests/unit/test-smp-parse.c     | 612 ++++++++++++++++++++++++++++++--
 4 files changed, 669 insertions(+), 64 deletions(-)

-- 
2.34.1


