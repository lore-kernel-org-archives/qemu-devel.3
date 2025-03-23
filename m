Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA9AC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 08:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twGK1-0007iJ-Du; Sun, 23 Mar 2025 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1twGJz-0007i8-WD
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 04:04:40 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1twGJy-0006Vi-6c
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 04:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1742717079; x=1774253079;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=58LqqjA2NDxKt5Zx4AeK6Ham2POP/vmhVzEhbT7fq3g=;
 b=Zpozm3ManKcJo5F1UB0Hcm8ihIlIV/t7JNEwNbr0oKpcuzuNwBhf/BvA
 40DGC34dzEfn8zPIFql8blNir/cnr1acYuN8y3UsVP5xAL3xm/Ckhc2cX
 qn2DpNYOMzFizOiZZFOtD+4fDGqb2kglZBXU6suKGdAAFqfBhMAnnQvS0
 fNtmkPbRaLzVRXxee4j2UcnS7cpqJz3z6WItKJuW3vSW9kXwq7mQumHeT
 v596gO4flejNbqRPUCy4Qm2riZBMXnvdR/qH59Xzz9u5q4+BAqVe8pnS8
 XzB0X3slanwruKMZpPu5DTIX/sSgoD6vfIoG760QziZ9WYrB8g+Yiu3QH w==;
X-CSE-ConnectionGUID: /+gz4H6lRFaLO1P3bVl7Ww==
X-CSE-MsgGUID: RlSaA5tAS6WmXHGG3fDWsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="193894444"
X-IronPort-AV: E=Sophos;i="6.14,269,1736780400"; d="scan'208";a="193894444"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2025 17:04:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 848F8E9EE5
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 17:04:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4480BD4F46
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 17:04:27 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E6BF01A00A0;
 Sun, 23 Mar 2025 16:04:25 +0800 (CST)
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Date: Sun, 23 Mar 2025 16:04:20 +0800
Message-ID: <20250323080420.935930-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=lizhijian@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Reverse the logical condition for HDM passthrough support in
pci_expander_bridge. This patch ensures the HDM passthrough condition
is evaluated only when hdm_for_passthrough is set to true, aligning
behavior with intended semantics and comments.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

This change corrects what appears to be a previous mistake in logic
regarding HDM passthrough conditions.
---
 hw/pci-bridge/pci_expander_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3396ab4bdd..25f8922d76 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -307,7 +307,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
      */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+    if (PXB_CXL_DEV(dev)->hdm_for_passthrough) {
         dsp_count = pcie_count_ds_ports(hb->bus);
     }
     /* Initial reset will have 0 dsp so wait until > 0 */
-- 
2.41.0


