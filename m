Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C9FCD1288
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 01:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrTEs-0005IF-VP; Mon, 01 Apr 2024 21:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrTEq-0005Hg-Kj
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:47:00 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrTEo-00065p-Pz
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712022419; x=1743558419;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DNNYcQcdHMiCbKTsvXixSeA8d386h61SexbhnWnXcVg=;
 b=T/pdAalpUf0lhQIFK/CHesUPkNLt6TGH0+BD0Tktlg022WxSJn9l3KPI
 VaQ90tb0rscJj3z7i1HQMV6Z8dXf++e9hNd+EBTH/YMLN22UTm0M7G7Jf
 nj4Azjbeaoemaxn0weuPzS/qzamhwj/WBRsc0HUxjCLJyRHj7fb0/+2YJ
 7W0AWu2OFhFhsbRoFoc1J8sjgKFZp1q5vLJKs8KQGjU3HUYKl9BjNFvDf
 l/HnGgH0DBhKsI8tvoRVp7T13vx7EL6qbxPq0wC2g2rQtLqvpiA/xK3rU
 UbgfaDP59Q57Ta22wud8GIC607RC/p1cFQRWoR5vSfEmC/xneZb3oVpqw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="156200238"
X-IronPort-AV: E=Sophos;i="6.07,173,1708354800"; d="scan'208";a="156200238"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 10:46:54 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B47C2D4801
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 91EE3D9498
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 33305E4751
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:50 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 92B041A0002;
 Tue,  2 Apr 2024 09:46:49 +0800 (CST)
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] CXL/cxl_type3: add first_dvsec_offset() helper
Date: Tue,  2 Apr 2024 09:46:46 +0800
Message-ID: <20240402014647.3733839-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28292.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28292.004
X-TMASE-Result: 10--5.367900-10.000000
X-TMASE-MatchedRID: toN6SH028bWPo+6vQMop+oeAntdoMxBa8SkdpG2/n9fcRlVxRCnt1itT
 H97dsk/Kf0UGUjPHyTvmn3xyPJAJoh2P280ZiGmRgjO1b6N9SrgFeeAjqMW+l7s3Yh2IOCYz18a
 7/fBfKbtwSFMaEckqJH41niV9KymzHxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiSEQD
 MuycsRUn+CifraaK2HwslpIthDaVPXrpL+7vYdnH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=lizhijian@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
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

It helps to figure out where the first dvsec register is located. In
addition, replace offset and size hardcore with existing macros.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b64..ad2fe7d463fb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -643,6 +643,16 @@ static DOEProtocol doe_cdat_prot[] = {
     { }
 };
 
+static uint16_t first_dvsec_offset(CXLType3Dev *ct3d)
+{
+    uint16_t offset = PCI_CONFIG_SPACE_SIZE;
+
+    if (ct3d->sn != UI64_NULL)
+        offset += PCI_EXT_CAP_DSN_SIZEOF;
+
+    return offset;
+}
+
 static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -663,13 +673,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_prog_interface(pci_conf, 0x10);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
-    if (ct3d->sn != UI64_NULL) {
-        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
-        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
-    } else {
-        cxl_cstate->dvsec_offset = 0x100;
-    }
+    if (ct3d->sn != UI64_NULL)
+        pcie_dev_ser_num_init(pci_dev, PCI_CONFIG_SPACE_SIZE, ct3d->sn);
 
+    cxl_cstate->dvsec_offset = first_dvsec_offset(ct3d);
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
 
-- 
2.29.2


