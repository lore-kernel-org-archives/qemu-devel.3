Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B34C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doL-0001LK-26; Wed, 22 May 2024 00:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doJ-0001Kp-5X
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doG-0005sK-9d
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352961; x=1747888961;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=y66cScg/UukbHTRP/VO+iec9E/PWgL+SYZtMT6FX0CE=;
 b=XYdIQrC+tPYBu0ZlUC3ThKcDj55dURwgR2nin3plRras7oMwQ1k2QDW1
 0q2MoIH0mx1kbV+Yke/wb0NwQyXmuW9KhR8Y4pGY9myUyuj2ef5yohfJ6
 F9pmaodMuU8i0MYIzxnIx7SKz5gsEebiSfNL3HE8wC/s1N7WHG7MD+NGB
 mu7uq6CM0bOFYhNJNh2lfwHnbE4RrYdz9zNP6YGLYLoY8DPD/YvvwD7T4
 w3YTneDhpE6IdoH6LlDc6L9CQHV5JTBAQge+pwGr5k5vMRcZwuFg0ul8G
 k0YQuPbZhtb1H9BNiaOIYmzBx43pLL6zO5MsHmEIbcgSbzGYon3BTQge5 g==;
X-CSE-ConnectionGUID: xj/XyzKpRZWNjpvzgONWkQ==
X-CSE-MsgGUID: 2V0Nz+0vTxC7vTWkGShV6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994108"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994108"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:35 -0700
X-CSE-ConnectionGUID: tYSMj8+TSB2dAtYZCK+fjg==
X-CSE-MsgGUID: 8YYYJbOMQN2p3AJNTdAEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683599"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/20] VFIO: misc cleanups part2
Date: Wed, 22 May 2024 12:39:55 +0800
Message-Id: <20240522044015.412951-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The first round is at 
https://lists.gnu.org/archive/html/qemu-devel/2024-05/msg01147.html

I see Cédric is also working on some migration stuff cleanup,
so didn't touch migration.c, but all other files in hw/vfio/ are cleanup now.

Patch1 and patch20 are fix patch, all others are cleanup patches.

Test done on x86 platform:
vfio device hotplug/unplug with different backend
reboot

This series is rebased to https://github.com/legoater/qemu/tree/vfio-next

Thanks
Zhenzhong

Changelog:
v2:
- add patch17 to use g_autofree in all callsite of vfio_get_region_info() (Cédric)
- add patch18 to use g_autofree in vfio_probe_igd_bar4_quirk()
- add patch19 to drop local err in vfio_ccw_realize() (Cédric)
- add patch20 to fix a bug I just found
- add R-B

Zhenzhong Duan (20):
  vfio/display: Fix error path in call site of ramfb_setup()
  vfio/display: Make vfio_display_*() return bool
  vfio/helpers: Use g_autofree in vfio_set_irq_signaling()
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
  vfio: Use g_autofree in all call site of vfio_get_region_info()
  vfio/igd: Use g_autofree in vfio_probe_igd_bar4_quirk()
  vfio/ccw: Drop local @err in vfio_ccw_realize()
  vfio/ccw: Fix the missed unrealize() call in error path

 hw/vfio/pci.h                 |  12 +-
 include/hw/vfio/vfio-common.h |   6 +-
 hw/vfio/ap.c                  |  10 +-
 hw/vfio/ccw.c                 |  47 ++++---
 hw/vfio/display.c             |  22 +--
 hw/vfio/helpers.c             |  36 ++---
 hw/vfio/igd.c                 |  35 +++--
 hw/vfio/pci-quirks.c          |  50 ++++---
 hw/vfio/pci.c                 | 243 ++++++++++++++++------------------
 hw/vfio/platform.c            |  61 ++++-----
 10 files changed, 241 insertions(+), 281 deletions(-)

-- 
2.34.1


