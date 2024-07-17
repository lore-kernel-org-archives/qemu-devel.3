Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170B1C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0Sz-0001P6-T1; Wed, 17 Jul 2024 04:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sU0Sj-0001Bl-Iq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:56:38 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sU0Sh-00035p-2H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721206596; x=1752742596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sVI0RniNYi0W5BbxKf/SmIGPggwqI+jvDgAGkKB2HVk=;
 b=Y57iWAFr9baElUGdBkwv4aOnjrsA/l9SIrCh4TiMrK7PlUJoyiW0Ccy4
 7TfUGuFlYF/hJaG1bGgQMvLq4z5JPe6oYB/J/gXm8bULA17H7MlNGftQ7
 LgMJa2KJ2jItZfFU+JHmR6PUvlHCx5jcxa2GTU62cyJxzPuSZou2jnRCp
 MhgN+wc6vXA03v8SJyPXzuuzKYCxlPEKWJcK7dRAvT9gaC3iLSX3DHTBF
 qGP/dflP07Hs3QgqwNMeDc2Z0ip2tSFjVi/Zz6ikvEwwKVhXO12JGB5jI
 kz6iJqNQo1e6LH1GPjkV7I2D/ev47nlT2ztIDWVPLrKigz6j4S2cAQnyM A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="167551159"
X-IronPort-AV: E=Sophos;i="6.09,214,1716217200"; d="scan'208";a="167551159"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 17:56:30 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 67EE0D4F56
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 17:56:27 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A6507D50ED
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 17:56:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BC44E5E45
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 17:56:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 377B01A000A;
 Wed, 17 Jul 2024 16:56:25 +0800 (CST)
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2] pci-bridge: avoid linking a single downstream port more
 than once
Date: Wed, 17 Jul 2024 04:56:21 -0400
Message-Id: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28534.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28534.005
X-TMASE-Result: 10--6.176500-10.000000
X-TMASE-MatchedRID: Yt5+J3IIlN56bMYbioM9qazGfgakLdjaBGvINcfHqhcOabErRKSRvego
 SvaKsl/kIvrftAIhWmLy9zcRSkKatWA1R1xiceE7s0T0PE+KHuVYjHef2XEWkQZZ8N3RvTMxo8W
 MkQWv6iXBcIE78YqRWvcUt5lc1lLgOMB0shqXhHrEADU5fwfpWn1Whz8oylpkqoRmqV8XOn7SyQ
 /OlZbotvkcX3eSdgyP
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
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
V1[1] -> V2:
 - Move downstream port check forward

[1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
---
 hw/pci-bridge/cxl_downstream.c     | 5 +++++
 hw/pci-bridge/pcie_root_port.c     | 5 +++++
 hw/pci-bridge/xio3130_downstream.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 742da07a015a..af81ddfeec13 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -142,6 +142,11 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
     MemoryRegion *component_bar = &cregs->component_registers;
     int rc;
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        error_setg(errp, "Can't link port, error %d", -EBUSY);
+        return;
+    }
+
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 09a34786bc62..a540204bda27 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -67,6 +67,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
     int rc;
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        error_setg(errp, "Can't link port, error %d", -EBUSY);
+        return;
+    }
+
     pci_config_set_interrupt_pin(d->config, 1);
     if (d->cap_present & QEMU_PCIE_CAP_CXL) {
         pci_bridge_initfn(d, TYPE_CXL_BUS);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 907d5105b019..63f6baa615fd 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -69,6 +69,11 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     PCIESlot *s = PCIE_SLOT(d);
     int rc;
 
+    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
+        error_setg(errp, "Can't link port, error %d", -EBUSY);
+        return;
+    }
+
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
 
-- 
2.37.3


