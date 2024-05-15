Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78995C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vT-000236-84; Wed, 15 May 2024 04:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vQ-00022W-4l
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:48 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vM-000749-Nq
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761424; x=1747297424;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ti4S723wMl5WW9F/bO9TPjnL7ryKJawXlfARyZFQrYI=;
 b=Efo+kz1qqEprvrS2asiVxvNjUVqYwRBCOM43EmI/lj95y7u54YqKQunO
 48scOTRV/Sb8ZSFL+SfFNCIdfwGwPHao01jagSBrtyCRgDJeMMmjPcFVm
 DfTpkuZb1Yot6hykiad60M++UQ3zFGwLb0bVI84JoKMZImKHj3RWMMEG3
 CsucrCX8WIjqLYcYY5uKOtE48/0CLyrxYGxpP4QdJebCytD8c2ePbgGjW
 FhE5wZsApq5Sr9NiOOoCaZsbXXJsOm0IIHQzAHgMVE08THeeqAZEe019E
 FAzt8ZBw8LrsADkdCRrlzky4fZpXjycDIHBAnMmEBPiT1EW6eX0y8JmTE Q==;
X-CSE-ConnectionGUID: nLER//nsRJOHfEHRR3LwvA==
X-CSE-MsgGUID: I3L7Npd2TyCIC9Tlav0HzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961506"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:40 -0700
X-CSE-ConnectionGUID: y1hS5aXCTneEsdwrq5O4wA==
X-CSE-MsgGUID: kcmTjo2ARTKX59W+1d9ARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396207"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 00/16] VFIO: misc cleanups part2
Date: Wed, 15 May 2024 16:20:25 +0800
Message-Id: <20240515082041.556571-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi

This is the last round of cleanup series to change functions in hw/vfio/
to return bool when the error is passed through errp parameter.

The first round is at https://lists.gnu.org/archive/html/qemu-devel/2024-05/msg01147.html

I see Cédric is also working on some migration stuff cleanup,
so didn't touch migration.c, but all other files in hw/vfio/ are cleanup now.

Patch1 is a fix patch, all others are cleanup patches.

Test done on x86 platform:
vfio device hotplug/unplug with different backend
reboot

This series is rebased to https://github.com/legoater/qemu/tree/vfio-next

Thanks
Zhenzhong

Zhenzhong Duan (16):
  vfio/display: Fix error path in call site of ramfb_setup()
  vfio/display: Make vfio_display_*() return bool
  vfio/helpers: Use g_autofree in hw/vfio/helpers.c
  vfio/helpers: Make vfio_set_irq_signaling() return bool
  vfio/helpers: Make vfio_device_get_name() return bool
  vfio/platform: Make vfio_populate_device() and vfio_base_device_init()
    return bool
  vfio/ccw: Make vfio_ccw_get_region() return a bool
  vfio/pci: Make vfio_intx_enable_kvm() return a bool
  vfio/pci: Make vfio_pci_relocate_msix() and vfio_msix_early_setup()
    return a bool
  vfio/pci: Make vfio_populate_device() return a bool
  vfio/pci: Make vfio_intx_enable() return bool
  vfio/pci: Make vfio_populate_vga() return bool
  vfio/pci: Make capability related functions return bool
  vfio/pci: Use g_autofree for vfio_region_info pointer
  vfio/pci-quirks: Make vfio_pci_igd_opregion_init() return bool
  vfio/pci-quirks: Make vfio_add_*_cap() return bool

 hw/vfio/pci.h                 |  12 +-
 include/hw/vfio/vfio-common.h |   6 +-
 hw/vfio/ap.c                  |  10 +-
 hw/vfio/ccw.c                 |  25 ++--
 hw/vfio/display.c             |  22 ++--
 hw/vfio/helpers.c             |  33 ++---
 hw/vfio/igd.c                 |   5 +-
 hw/vfio/pci-quirks.c          |  50 ++++----
 hw/vfio/pci.c                 | 227 ++++++++++++++++------------------
 hw/vfio/platform.c            |  61 ++++-----
 10 files changed, 213 insertions(+), 238 deletions(-)

-- 
2.34.1


