Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED17C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 03:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWp9t-0006bt-C5; Wed, 24 Jul 2024 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWp9r-0006bC-0i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 23:28:47 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWp9o-0000gO-Ju
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 23:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721878124; x=1753414124;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=q71uB79MLTMHxUKtUITTX0EiNe+QmZcWINslj/ZPBCo=;
 b=H8inZxd0LlV7y/qVsrAUMSkbZKJithnd4ZUqmbEXGvEYkmEDs2YX+W0o
 T9EUxQRMU7uemAQ0OAmO4P/hlwe06J16HV8vlQSVbdQhY8CZUxHWRNwmO
 UdYbztjCGnq3+azS4G/svSIAbojFJPh6FHnFFQD8IXOyauwY3CpYAg7M5
 kmArVDxvjLRzrA5kK6MxljjLhvEfF0+f2Rgo6lB9FUoq7c5Vr0JSwinO4
 Uos3sCV6VoTFGdO+BJ/0vmXRTM1qZZuvCPJHHW9z4NV/Ww4sCiurZ0OI6
 Z5feVLE9sI6VwToKJfJ9giD4wzu6QKwGLDzaFVCsG42VN+CRqdatona33 Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="147339275"
X-IronPort-AV: E=Sophos;i="6.09,234,1716217200"; d="scan'208";a="147339275"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 12:28:36 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E5776D64AF
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 12:28:31 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3DEF3BDC96
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 12:28:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C292C200894A9
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 12:28:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2C4C81A0002;
 Thu, 25 Jul 2024 11:28:30 +0800 (CST)
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v3] pci-bridge: avoid linking a single downstream port more
 than once
Date: Wed, 24 Jul 2024 23:27:31 -0400
Message-ID: <20240725032731.13032-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28550.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28550.004
X-TMASE-Result: 10--6.084500-10.000000
X-TMASE-MatchedRID: R1u6Jncx2x16bMYbioM9qazGfgakLdjaBGvINcfHqhcOabErRKSRvb8F
 Hrw7frluf146W0iUu2tMCgkc3/BmTUq8tM/A6m4SqhcdnP91eXEIKmZZt8RasgZZ8N3RvTMxo8W
 MkQWv6iV3LAytsQR4e/nZI3fdS4AA3QfwsVk0Ubv+efAnnZBiL5K13zeQcKlRK8AfkNzU08AJcS
 grLhDLvZKYEo/aw2FqqLGnhZGRR+QLKQDU6lJ9TAj6L/Sqyb7X9wRqOteiI67IA5FeZngbOY0Wi
 v3Nj8beW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the downstream port is not checked, two slots can be linked to
a single port. However, this can prevent the driver from detecting the
device properly.

It is necessary to ensure that a downstream port is not linked more than
once.

Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

---
V2[2] -> V3:
 - Move this check into pcie_cap_init()

V1[1] -> V2:
 - Move downstream port check forward

[1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
[2] https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fujitsu.com
---
 hw/pci/pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6e0..aa154ec4b054 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
 
     assert(pci_is_express(dev));
 
+    if (pci_is_express_downstream_port(dev) &&
+        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
+        pos = -EBUSY;
+        error_setg(errp, "Can't link port, error %d", pos);
+        return pos;
+    }
+
     pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
                              PCI_EXP_VER2_SIZEOF, errp);
     if (pos < 0) {
-- 
2.41.0


