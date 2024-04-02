Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E59CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 01:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrTEs-0005IC-DJ; Mon, 01 Apr 2024 21:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrTEq-0005Hf-IB
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:47:00 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrTEo-00065o-LA
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712022418; x=1743558418;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5hVwL9nD3S8/Q24Xp6vbDPaGmmo86otoEA8J2qRq8Ik=;
 b=OhOgz44+pA5fotTa0He3KDLRVCQnkrLPQk4FezIgcjUFREEI0wAnoHzZ
 vjKV00gmzCThuW9Lm9GmJy/RGV+VpPa/Y/PFi1JSFXtIDJLVGNrlCY1Px
 0h3VVDqe+OfdfVGa+652pR2QoAfnL+jecAnu+4KrfMEMJSLwHAgxzQ3xF
 2a0P/iouV2EFuu+uvsIaG6+YM1gdT23rsdfnoMJhWZHkB5uQDPrhQxeq2
 a0dfZzBuyBS59I5FZEU4+m8Y0wE4Frb6NKK2RRltT+7bXwqM0DVXOt5jq
 2PBokCrt3+xs7/OgFXFOVTMi2VCJBXU+DGIBiIou750bTbtFwjaumufdh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="133613078"
X-IronPort-AV: E=Sophos;i="6.07,173,1708354800"; d="scan'208";a="133613078"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 10:46:53 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E4C8D3EAC
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:51 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BF29AD560D
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E06F200932CB
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 10:46:50 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F116B1A000C;
 Tue,  2 Apr 2024 09:46:49 +0800 (CST)
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Date: Tue,  2 Apr 2024 09:46:47 +0800
Message-ID: <20240402014647.3733839-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402014647.3733839-1-lizhijian@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28292.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28292.004
X-TMASE-Result: 10--10.847900-10.000000
X-TMASE-MatchedRID: Ugxu9kqXWxLOugYCEJUMNSrLqyE6Ur/j1Ee54j3itDZD9iPiuXvzgSsJ
 qmSIRx2QEpqGYdoOBVcxj6B+pIpORmJHJG/db0P+BcaL/tyWL2PBOVz0Jwcxl6vCrG0TnfVUg9x
 e4gtUJtqMu82DfPQ/zLRXbLwX8eqWeODBMji6el+dd2mFBNIr8lK6+0HOVoSonhD4vcFcha5eUx
 yj72GEheLzNWBegCW29sZ0UX0EaOILbigRnpKlKSPzRlrdFGDwoPutwA7Nt58xfHFubS9ewi8LJ
 ccdjSYtNmD0Hjho3a5fbqvtnybFzw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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
CXL type3 devices cannot be enabled again after the reboot because this
flag was not reset.

This flag could be changed by the firmware or OS, let it have a
reset(default) value in reboot so that the OS can read its clean status.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ad2fe7d463fb..3fe136053390 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -305,7 +305,8 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
         .cap = 0x1e,
-        .ctrl = 0x2,
+#define CT3D_DEVSEC_CXL_CTRL 0x2
+        .ctrl = CT3D_DEVSEC_CXL_CTRL,
         .status2 = 0x2,
         .range1_size_hi = range1_size_hi,
         .range1_size_lo = range1_size_lo,
@@ -906,6 +907,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+/* Reset DVSEC CXL Control */
+static void ct3d_dvsec_cxl_ctrl_reset(CXLType3Dev *ct3d)
+{
+    uint16_t offset = first_dvsec_offset(ct3d);
+    CXLDVSECDevice *dvsec;
+
+    dvsec = (CXLDVSECDevice *)(ct3d->cxl_cstate.pdev->config + offset);
+    dvsec->ctrl = CT3D_DEVSEC_CXL_CTRL;
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
@@ -914,6 +925,7 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+    ct3d_dvsec_cxl_ctrl_reset(ct3d);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
-- 
2.29.2


