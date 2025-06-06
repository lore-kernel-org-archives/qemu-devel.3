Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E86C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTMw-0005lz-54; Fri, 06 Jun 2025 05:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTMr-0005lR-RX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:06 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTMo-00019f-50
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749202083; x=1780738083;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Cgk3pwLgAi3s/hlGuQgw1WuaGUeAlciqJY644sEy8wA=;
 b=VSBurueubTEe157FM+htuCncwFJ9ARzRYnhplO0ANViITk/c86VTmC0m
 N4bj/Ljwu5Y8hIkcPSASht1xRnQZ/bjz8+HiJelG7y1theiFGdtQfNkV9
 YbRtKmqB6PSVCzX5dB+PK77Ah8GxBr+kGxIeEUepv5yA20wwgsdbhwuAb
 m/IrLCv4v8NSahXHZuclq7F0yN4IzKkTW09XO8h80IKuTp6VIt8gJg/bx
 zd+eTWYyg8RcA2EfaMmLHKMVxWmqMcWROOmPH4YZnVS7OZsOqO2oB9Zmm
 mJ8+MeNG59HXpxlSciX6j1k+CY1j2IZw58Jy9zWkRgo8uuF72UIXZlFe3 Q==;
X-CSE-ConnectionGUID: 6bJtpe4PSXy4TMEMW7H63w==
X-CSE-MsgGUID: 54l8Hz//TD2qOt5BMzI2mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55154591"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="55154591"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:27:56 -0700
X-CSE-ConnectionGUID: 1BZ+EQILSRmJwksrRQ7bnw==
X-CSE-MsgGUID: Zd6XU3sHSMuj8majH1T2Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="145706169"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:27:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 0/5] Fix definition of classes with wrong parent
Date: Fri,  6 Jun 2025 17:24:01 +0800
Message-Id: <20250606092406.229833-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

patch4/5 are more like cleanups instead of fixes as those class_size are not
initialized so class definition doesn't take effect, so no Fixes tag for them.

Thanks
Zhenzhong

Changelog:
v4:
- add comments 'this isn't catastrophic only because sizeof(VirtIODevice) >
  sizeof(VirtioDeviceClass).' to patch1/2/3 (Markus)
- collect RB for patch5

v3:
- s/Suggested-by/Reported-by on patch2 (David)
- add Closes: tag (David)
- collect RB

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


