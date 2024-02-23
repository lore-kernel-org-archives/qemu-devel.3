Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdR9Y-0003GI-Fr; Fri, 23 Feb 2024 03:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdR9V-0003Ew-U2; Fri, 23 Feb 2024 03:43:29 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rdR9T-000050-Lr; Fri, 23 Feb 2024 03:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708677808; x=1740213808;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GxcEpKUJhcD8tp/cNKnafhshJBtXmwMwR7V4Pnc77B4=;
 b=eu1nVhwa2mO53YNnul35/Zfwk21St744Aig2WH2n36BgXSdfyJkcWcsj
 cgnODusfgyFQXT4LwJW284cEQL4RoOtR17jgdKykRjLt41i+zW01GgEkz
 RHxItTR9roAHvaXTZuD6ioghMgGCdy8ws09sFqBJkwrUYgkWZ1jjharFm
 vLqmB4p1uTP1uJGLEkUQN706htr+ivG2mDS3syZBVLgQVebZ4fdx/hK84
 Y83V8G0vvXycyAEPP2HCPNLt/6Bmgbz2akl8mDdU7tQrsloboMuRophgS
 Y2TUlDEhKBgdWCW9Mgv2GVQhVZD7IBj3U8M6fjCHrICeg+Mwu3LgMw5e6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28413789"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="28413789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 00:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5731723"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 23 Feb 2024 00:43:19 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/7] Cleanup and fix @errp dereference
Date: Fri, 23 Feb 2024 16:56:46 +0800
Message-Id: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

This is my v2 series to clean and fix @errp dereference.

Introduction
============

The patches 1-6 fix the cases that deference @errp without
ERRP_GUARD(), and they are based on my previsous v1 [1].

The patch 7 is merged in this series from another single patch [2].

Based on v1, v2 mainly add more description about problematic codes to
make review easier (with Markus' suggestion) and avoid dereferencing
@errp in patch 3's special case.


Future Work
===========

Additionally, I realized that my journey to fix @errp with ERRP_GUARD()
is still not over, because @errp's second restriction said:

* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.

With this restrication, there're still many places need to add missing
ERRP_GUARD().

[1]: https://lore.kernel.org/qemu-devel/20240221094317.994454-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240221073948.768828-1-zhao1.liu@linux.intel.com/

Thanks and Best Regards,
Zhao

---
Zhao Liu (7):
  hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
    cxl_fixed_memory_window_config()
  hw/display/macfb: Fix missing ERRP_GUARD() in macfb_nubus_realize()
  hw/mem/cxl_type3: Fix missing ERRP_GUARD() in ct3_realize()
  hw/misc/xlnx-versal-trng: Check returned bool in
    trng_prop_fault_event_set()
  hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD() in
    cxl_usp_realize()
  hw/vfio/iommufd: Fix missing ERRP_GUARD() in iommufd_cdev_getfd()
  hw/intc: Check @errp to handle the error of
    IOAPICCommonClass.realize()

 hw/cxl/cxl-host.c            | 1 +
 hw/display/macfb.c           | 1 +
 hw/intc/ioapic_common.c      | 4 ++++
 hw/mem/cxl_type3.c           | 1 +
 hw/misc/xlnx-versal-trng.c   | 3 +--
 hw/pci-bridge/cxl_upstream.c | 1 +
 hw/vfio/iommufd.c            | 1 +
 7 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1


