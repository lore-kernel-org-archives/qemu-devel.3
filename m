Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D18FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 03:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZiB1-0002Ib-3k; Sun, 19 Jan 2025 22:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiAz-0002Hf-Dy
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:09 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiAx-0007hU-Cz
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737342607; x=1768878607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nXzUK/sz09DWb4nGyQfonpqJK7eujChpZ4+W5SccXTM=;
 b=JaEQcsbgnkZY9QDgaBwap8gdFiMToyyg4Gvshq3Aao4rFqAJdKR/GPX0
 Gx/nnvK2+DBuyb711IgLzd2iw5wtFDNVM4kwMHcvkoAAkZxUPPgJ2Rc4a
 bSapr2FtLdgQ4Ln5liLtodiS2+RwaanVzQqh/dv8IrnDuSI9NeJzR9HmR
 LSBmDQReoo2imsImHkuxvIH+d2omqwaVb1q0VNM6wGn2qIqznXlN5+pJc
 us1T+3ZY4FzGh67Kt9TswrmvGrwEw1cZyR4SSt+VM+OvI9I2oG2OTaLq6
 U+zdCxT6/rm4ofqi4i3jrXVPnY99NHVodsTpcZ+n7N5zlJKcOWpzegGlc A==;
X-CSE-ConnectionGUID: qhefXLhRQiyAPGQAQATjJg==
X-CSE-MsgGUID: F/figfRlQ4mqtzCRm1KgsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="187106267"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; d="scan'208";a="187106267"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 12:09:59 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3BFE2E8525
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1179DD5077
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C14720074735
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D40D1A0073;
 Mon, 20 Jan 2025 11:09:56 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Date: Mon, 20 Jan 2025 11:09:46 +0800
Message-Id: <20250120030947.254930-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250120030947.254930-1-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28934.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28934.004
X-TMASE-Result: 10--4.187500-10.000000
X-TMASE-MatchedRID: VbO/xkC3pzsHdJSFlLCdzomfV7NNMGm+w4SuXsUCGYgli8Y5a0svL9e3
 02kawuyZnuC4VmJFPYZZO+ygKNx8vKWgCWYvFMxFxVQFfLw4zf+6hgVvSdGKo8C5DTEMxpeQfiq
 1gj2xET856WD6kuo88S//MlDRqI8mEd0YyW6tLbmCM7Vvo31KuH0tCKdnhB589yM15V5aWpj6C0
 ePs7A07aqzOOiUJy/IuinVLBUcG6y5uCtM/wfGlIx9zWcOKuXW2Kph7/SS809B/LeDv7BJAMkja
 rEF4+w+uSGtLYy5tELefneus6YT/gd0ruCUrh2IhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP
 4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.47; envelope-from=lizhijian@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
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

Address a memory leak issue by ensuring `regs->special_ops` is freed when
`msix_init_exclusive_bar()` encounters an error during CXL Type3 device
initialization.

Additionally, this patch renames err_address_space_free to err_msix_uninit
for better clarity and logical flow

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9dad250f56d5..9eb3d0979cf5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -885,7 +885,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
     if (rc) {
-        goto err_address_space_free;
+        goto err_free_special_ops;
     }
     for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
         msix_vector_use(pci_dev, i);
@@ -899,7 +899,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
-        goto err_free_special_ops;
+        goto err_msix_uninit;
     }
 
     pcie_cap_deverr_init(pci_dev);
@@ -936,9 +936,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
-    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-err_address_space_free:
+err_msix_uninit:
+    msix_uninit_exclusive_bar(pci_dev);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
-- 
2.47.0


