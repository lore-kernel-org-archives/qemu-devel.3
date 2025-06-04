Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C3CC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmkm-0005By-OD; Wed, 04 Jun 2025 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmkk-0005BK-9a
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:57:54 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMmki-0000nv-1d
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749038272; x=1780574272;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B++aRPVR6eNRDldiaGain7aoMtEq+8qkEt0pThruT8o=;
 b=VdFwO29Xz+koM7bQUnJQHK+dAaJtzPAzoB3mjQ1+f0bwJthfsFffMLe/
 oZKgOPX0rnclqLzoJYbDiWKqmPPobJ6dp5PG4QMCjjYNC59m60Q8my9ya
 SCa2pSAbFDaUO5CBOhUFmUBFEd7DIS5j7Sa9+i7LKkH0LeciyIv6REfbz
 eaQyDe1ZUFEjQCilMKcjzFyW5dvBb2CRwewHtbYXA2UVLOADc3NRfs27Y
 a8y0k71O7h1feMNqcSsoTa4WBxIJ7EzAEp/G+qGslaJKuDqoDkRAsdgDJ
 vyYW07aiEPDRIBrl7xcz4pMxWe+JrtmguEX7qxfU+OEWCJn7EqBinHOVC A==;
X-CSE-ConnectionGUID: 7NHmsYP0R7uv8h/pZDUl7w==
X-CSE-MsgGUID: XdpBRCSBTiOleu7WkQeEkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54915351"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="54915351"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:49 -0700
X-CSE-ConnectionGUID: MebmHboOTduDaK0HTGKVHQ==
X-CSE-MsgGUID: 4XYxobAqRSaQvBSwDj9luw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208";a="150048269"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 04:57:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/5] Fix definition of classes with wrong parent
Date: Wed,  4 Jun 2025 19:53:55 +0800
Message-Id: <20250604115400.98905-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Hi,

This fix definition of some classes with wrong parent.
Used below script to get a list, hoping all are addressed.

find "$directory" -type d \( -name "roms" -o -name "build" \) -prune -o -type f \( -name "*.c" -o -name "*.h" \) -print | while read -r file; do
    awk '/^(struct |typedef struct )/ { 
        first = $0;
        getline second; 
        getline third; 
        if (first ~ /[Cc]lass/ && !(second ~ /Class/) && !(third ~ /Class/)) {
            print FILENAME ":" NR-2 ": " first; 
            print FILENAME ":" NR-1 ": " second; 
            print FILENAME ":" NR ": " third;
        }
    }' "$file"
done

Thanks
Zhenzhong

Changelog:
v2:
- add more fixes per David

Zhenzhong Duan (5):
  virtio-mem: Fix definition of VirtIOMEMClass
  virtio-pmem: Fix definition of VirtIOPMEMClass
  hw/gpio/aspeed: Fix definition of AspeedGPIOClass
  hw/char/sh_serial: Remove dummy definition of SH_SERIAL class
  hw/riscv/riscv-iommu: Remove definition of RISCVIOMMU[Pci|Sys]Class

 include/hw/gpio/aspeed_gpio.h   | 2 +-
 include/hw/riscv/iommu.h        | 6 ++----
 include/hw/virtio/virtio-mem.h  | 2 +-
 include/hw/virtio/virtio-pmem.h | 2 +-
 hw/char/sh_serial.c             | 4 +---
 hw/riscv/riscv-iommu-pci.c      | 6 ------
 hw/riscv/riscv-iommu-sys.c      | 6 ------
 7 files changed, 6 insertions(+), 22 deletions(-)

-- 
2.34.1


