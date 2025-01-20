Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4968DC02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 03:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZiB4-0002Ji-6w; Sun, 19 Jan 2025 22:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiB1-0002J8-DP
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:11 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiAz-0007hV-QH
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737342609; x=1768878609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nYOxTDylACvmP6qrLuOl+iu07QERTW/jLVVEpGxqnfo=;
 b=QM3z5IwmG/ks/bZ4AJkNVAcY5nl8SKbcUcDnFLsOKHeKlkIlKZHyvNWC
 V51o2tKb0MPEboGPVN1Q90taiBuins+Pk3vTN2SXQSMBMXIW2IbDI/Qbz
 3VswW32c8W1Nyvgzibjq18kxLxyy7j3alcigY4FeCLJ6Zn7Hqz9HdVFWe
 q38Fgtlw25m31cQzDAN9OA0WCxaLnDcBtvuVwNt1aYNV/pi5eBPOxTFLk
 2ho+KrZB5cGgqrawLDLH8tFrmJLxc+eKpscBymOprNZqZYD8UN4Qp1+BN
 jcvFhh89xoZmCsdyi65fZ9PlBVJEo8MMmYMV80AA98qG90gVmXhLp3pYK A==;
X-CSE-ConnectionGUID: BT81+fC/RvuSMFaWNsIZkg==
X-CSE-MsgGUID: UlPJgF/gRBmcqJC+z+Qk/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="175065609"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; d="scan'208";a="175065609"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 12:09:59 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 844D7DBB87
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 58A83D7527
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E1FCA6BAC8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6B1111A0071;
 Mon, 20 Jan 2025 11:09:56 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/3] hw/mem/cxl_type3: Ensure errp is set on realization
 failure
Date: Mon, 20 Jan 2025 11:09:47 +0800
Message-Id: <20250120030947.254930-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250120030947.254930-1-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28934.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28934.004
X-TMASE-Result: 10-2.571100-10.000000
X-TMASE-MatchedRID: DVe2RIcZexn+iwYk8es7vxFbgtHjUWLy2FA7wK9mP9dULhp+W/a9mb8F
 Hrw7frluf146W0iUu2tMCgkc3/BmTUwYXRRr2ymnzr16YOzjZ126hgVvSdGKo5NciW4ks8ZLbf4
 4QeBkGfvi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFP2uYHfvH0BeyPnbtDEL25Nc5N
 vwi7UFuJWuTH306ghoOV8kmsf1pLOGjucNK4EBjs3VrL4N2KveoBg/1GfUNgr5rOGgS9jIc5sNE
 GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Simply pass the errp to its callee which will set errp if needed, to
enhance error reporting for CXL Type 3 device initialization by setting
the errp when realization functions fail.

Previously, failing to set `errp` could result in errors being overlooked,
causing the system to mistakenly treat failure scenarios as successful and
potentially leading to redundant cleanup operations in ct3_exit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9eb3d0979cf5..c3b6a1d6a612 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -883,7 +883,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initialization */
-    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
     if (rc) {
         goto err_free_special_ops;
     }
@@ -904,7 +904,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
-    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
+    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
     if (rc) {
         goto err_release_cdat;
     }
-- 
2.47.0


