Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5540CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34nD-0001Rt-Lg; Sun, 28 Sep 2025 23:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34nA-0001RS-Pi
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:13 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34mx-0007cT-Uj
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759117380; x=1790653380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=M0Emn4AhdtACLwbE9169hwJ3TjMF/3hUnCEfrs6URbE=;
 b=gGgrheE7v29Gmy90CS2b1lr8MxfcQVLkB8wFAYSTkKIB6Z8nw3Xb9UX1
 zzaxZQrpG37Vzwhe1LwCTmNUrr8sHC1bfUVVBeWqEfBTKeAMcJBPF6Fzd
 7h89gmnWCXOxr0NK9bTKZhQArVc6DEzbKfc3OkKQptYzzx2wkzV1Vbi3y
 R0tP8eqpJipBoyK6KvyA/mGR4mgfN/RlSY0W54by3T5lU+2uYtceIURif
 r9HbRsCYbUhIuQfr/dWr1+HMMuh1LoPEXUhJuLflN/oZOBxlgAzGm/3Pm
 oagfTVV6On5NfVoaaXxDM4fNfW6+OReXGHA6Z3d4odwUFSB0Fcz3vSYg5 w==;
X-CSE-ConnectionGUID: ABV0rf+MS+q953B3vlB6Tg==
X-CSE-MsgGUID: OR8AXUU4RlC695IdiuSxhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64989284"
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="64989284"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:48 -0700
X-CSE-ConnectionGUID: ZgrU4f98Sa6DcfpN15mGzA==
X-CSE-MsgGUID: wFPKaesOQ3miuuNO8NCPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="178865035"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/3] Enable ESRTPS and simplify caching-mode=on check
Date: Sun, 28 Sep 2025 23:42:03 -0400
Message-ID: <20250929034206.439266-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patch1 enable ESRTPS to avoid three global invalidation request in guest
kernel.
Patch2 rework caching mode check with simpler code for VFIO device.
Patch3 fix a wrong parameter passing, I didn't add Fixed-by as they
       belong to many different commits

Thanks
Zhenzhong

Changelog:
v2:
- restore the original code for VDPA, patch2 only take effect for VFIO device
- add patch3 to fix a parameter passing bug

Zhenzhong Duan (3):
  intel_iommu: Enable Enhanced Set Root Table Pointer Support (ESRTPS)
  intel_iommu: Simplify caching mode check with VFIO device
  pci: Fix wrong parameter passing to pci_device_get_iommu_bus_devfn()

 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 42 ++++++----------------------------
 hw/i386/pc.c                   | 20 ----------------
 hw/pci/pci.c                   | 18 +++++++--------
 4 files changed, 16 insertions(+), 65 deletions(-)


base-commit: 5ca676a4c78f14d01e4720eb6de786cf7f5b751d
-- 
2.47.1


