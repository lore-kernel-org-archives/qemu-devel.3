Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259DDCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru6No-0001vL-LV; Tue, 09 Apr 2024 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ru6Nj-0001uz-MS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:59:05 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ru6Ng-0006K3-DR
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712649540; x=1744185540;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cr75vmQQ4tjMyuDlPBiVrzxG5Gv0w637W9cL2RfcGas=;
 b=Q8AzN6pXqrwRt8VXHAxiUR6cT3zwO/EhlFPLpOk7kLOKlSTHBtCh0vKf
 9RhkV5ciJgP1WWOZTTZ1duQuJ/0aQaGT7viIKeA3+2fK+eCccyIAK+8uP
 lc71FtIHCJtIH6K1dcoLvlPsHjUdDH+4LxFnwVSIogfffHzgd3NXXFlri
 cY/0+ZBkwJHEbeWO/PR6HOq3LwszOF5cBsgwKmg/qRoTcO+uYr0NNLgxq
 4wj4Ba4VMgZnYZ7N2Vp4WvGy7xQ7pmpzSc6KKi4+zVERg5apG/2sNKSkC
 dHvcHQXTE4eR1SOKlKCZZEkj4usqjau3PXpKxHH2LhfCqSTnfd2pvEjyj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="155309814"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; d="scan'208";a="155309814"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2024 16:58:54 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 68B62DCB72
 for <qemu-devel@nongnu.org>; Tue,  9 Apr 2024 16:58:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 92F96FCEF8
 for <qemu-devel@nongnu.org>; Tue,  9 Apr 2024 16:58:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E46D20097CC7
 for <qemu-devel@nongnu.org>; Tue,  9 Apr 2024 16:58:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6293D1A0002;
 Tue,  9 Apr 2024 15:58:50 +0800 (CST)
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Date: Tue,  9 Apr 2024 15:58:46 +0800
Message-Id: <20240409075846.85370-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28306.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28306.006
X-TMASE-Result: 10--9.351400-10.000000
X-TMASE-MatchedRID: uWxJDmPsnWHOugYCEJUMNSrLqyE6Ur/j1Ee54j3itDaJXRC/bWSJueLa
 AlZI/DlqEpqGYdoOBVcHw5SpXQUTkBT0CagFsN1kEVuC0eNRYvIXivwflisSrCWLxjlrSy8vuxW
 P7AlD8NO3nQMqHp+dH+affHI8kAmiHY/bzRmIaZGdd2mFBNIr8gV54COoxb6XR6RHdVK85hXuQ7
 Jl58fF92sRrupgWdD3DHgfvPgXVeSel3N+gDvB50VOF9zLtdyMeF+F9LT9kRKbKItl61J/yZ+in
 TK0bC9eKrauXd3MZDVt7biF0Cnq/FsUqcjBanlSra5fkKjdyekD49NFNTBfWdZEUZ4TJWg7
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

After the kernel commit
0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
CXL type3 devices cannot be enabled again after the reboot because the
control register(see 8.1.3.2 in CXL specifiction 2.0 for more details) was
not reset.

These registers could be changed by the firmware or OS, let them have
their initial value in reboot so that the OS can read their clean status.

Fixes: e1706ea83da0 ("hw/cxl/device: Add a memory device (8.2.8.5)")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
root_port, usp and dsp have the same issue, if this patch get approved,
I will send another patch to fix them later.

V2:
   Add fixes tag.
   Reset all dvsecs registers instead of CTRL only
---
 hw/mem/cxl_type3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b64..4f09d0b8fedc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CT3D_CAP_SN_OFFSET PCI_CONFIG_SPACE_SIZE
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -284,6 +285,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
              range2_size_hi = 0, range2_size_lo = 0,
              range2_base_hi = 0, range2_base_lo = 0;
 
+    cxl_cstate->dvsec_offset = CT3D_CAP_SN_OFFSET;
+    if (ct3d->sn != UI64_NULL) {
+        cxl_cstate->dvsec_offset += PCI_EXT_CAP_DSN_SIZEOF;
+    }
     /*
      * Volatile memory is mapped as (0x0)
      * Persistent memory is mapped at (volatile->size)
@@ -664,10 +669,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     if (ct3d->sn != UI64_NULL) {
-        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
-        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
-    } else {
-        cxl_cstate->dvsec_offset = 0x100;
+        pcie_dev_ser_num_init(pci_dev, CT3D_CAP_SN_OFFSET, ct3d->sn);
     }
 
     ct3d->cxl_cstate.pdev = pci_dev;
@@ -907,6 +909,7 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+    build_dvsecs(ct3d);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.29.2


