Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9707EC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaF-0006yY-0q; Wed, 21 Feb 2024 10:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcoSL-0004Hd-T4; Wed, 21 Feb 2024 10:24:23 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcivE-0003PR-GE; Wed, 21 Feb 2024 04:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708507789; x=1740043789;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DMvGc8DfimJRTPgD6QMJJKd+KloeFda9pBPBryI/NJk=;
 b=QcCveHMg8XDjPDkTD2QaGnIImu9+N4JvU+ZT6VKezVT2KrzUiKAy52AC
 e8U3GcuenGkugwDG6k0zm5hNzWzv5PLWQYp5ZYBdYpTlQBQuF80gIzuu0
 B83OcT9j3ZK3cbVrZ4a2xPsJfqJ7t0AYnETR6I1lLfKKIOf3M/apZiuF6
 6pqTQeemSU0T1ScuT5s48xB+nEe1ZfEH2aowNgRNTfwP8WlbboVCivaYb
 C9QSrFuYm6VJYkBDiLzyMcROXFKlYkvjsHGwLQUoW0bFzv0aA5pi6kJwq
 9iBrk4WYS0Y4WEgEAJphc93HbUQAsI9YGrOzEj+aLOgtUY5QZ4ijtLkzi w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2795430"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2795430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2024 01:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9719977"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 21 Feb 2024 01:29:39 -0800
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
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/6] [PATCH 0/6] Fix missing ERRP_GUARD() when dereference
 @errp
Date: Wed, 21 Feb 2024 17:43:11 +0800
Message-Id: <20240221094317.994454-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

Thanks to Markus's explanation about ERRP_GUARD() on my previsou
patch [1],

I realize that perhaps more @errp dereference cases need to be
double-checked to ensure that ERRP_GUARD() is being used correctly.

Therefore, there're the patches to add more missing ERRP_GUARD().

[1]: https://lore.kernel.org/qemu-devel/875xz0ojg7.fsf@pond.sub.org/

Thanks and Best Regards,
Zhao

---
Zhao Liu (6):
  hw/cxl/cxl-host: Fix missing ERRP_GUARD() in
    cxl_fixed_memory_window_config()
  hw/display/macfb: Fix missing ERRP_GUARD() in macfb_nubus_realize()
  hw/mem/cxl_type3: Fix missing ERRP_GUARD() in ct3_realize()
  hw/misc/xlnx-versal-trng: Fix missing ERRP_GUARD() in
    trng_prop_fault_event_set()
  hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD() in
    cxl_usp_realize()
  hw/vfio/iommufd: Fix missing ERRP_GUARD() in iommufd_cdev_getfd()

 hw/cxl/cxl-host.c            | 1 +
 hw/display/macfb.c           | 1 +
 hw/mem/cxl_type3.c           | 1 +
 hw/misc/xlnx-versal-trng.c   | 2 ++
 hw/pci-bridge/cxl_upstream.c | 1 +
 hw/vfio/iommufd.c            | 1 +
 6 files changed, 7 insertions(+)

-- 
2.34.1


