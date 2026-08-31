Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD54EC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rg7-0002go-WB; Sun, 30 Aug 2026 22:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0rg4-0002gZ-G8
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:23:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0rg2-0000Ez-Du
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788142994; x=1819678994;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JfFtoKN/qdgOj3A9lANKsbktFZUUewgu65dOxEHAdww=;
 b=FNtIKc9PWsNz8lw80bWWGFTTnZOMFd3tMs7jZmp0OiqFTKi8kStE1FNb
 T/hYjDES7KcHZDijtsGJ7oVcY7IHokaVeHTvMlZccDRqshV+ZVuLGDlTq
 qgVYRwkeKDHO3je4I3C86IevKaSWnQSxOwQ7Enfc0U2nGG820dj/4fMvu
 zYEByu7KuMBkuZtbM0m7935vXX8IH21mpZ0sDjl3lpD7A7M2uhKQpFMKo
 jQQDvvSGxWhSESQ5E3BrYPpcO+YsaM292jaScoRtEswolr874pnTgAp5o
 c3q6cxPLhheqguuuZyIV0OWew6fYVVOtH4JpwIT/BqjQXqrTkSahaFPHy Q==;
X-CSE-ConnectionGUID: O5/qfOYwRMaEcfrI4Nfwqg==
X-CSE-MsgGUID: 2AMEJfo4Q3mKOB9AtjI0Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99703147"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="99703147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 19:23:11 -0700
X-CSE-ConnectionGUID: 6zp4s1G1SPylKnjVDBXrng==
X-CSE-MsgGUID: wHFmjOCJQ3m8BYGsjX6F6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="272859624"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 19:23:09 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: mst@redhat.com, Shrihari E S <shrihari.s@samsung.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when
 sn= is set
Date: Mon, 31 Aug 2026 10:23:02 +0800
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
Found while walking the extended capability chains for the UIO/SVC RFC
V2 review; independent of that series.

Tested at bde2492aac on q35 (pxb-cxl / cxl-rp / cxl-type3), dumping the
capability chain and raw config bytes from the guest with and without
sn=: the Flex Bus DVSEC keeps its full 0x20 bytes and the DOE sits at
0x19c; without sn= the bytes are identical before and after.  cxl-test
12/12.

On cxl-2026-03-25-draft REG_LOC_DVSEC_LENGTH is 0x34, so the overlap is
there without sn= too; with this change the DOE lands at 0x1a0/0x1ac.
cxl-2026-01-09-draft also fixes doe_comp at 0x1b0, which would then
collide -- the two want chaining.

 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..e6eb2e0cba 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;

base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
-- 
2.43.0


