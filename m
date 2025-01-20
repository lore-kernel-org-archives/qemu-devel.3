Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA3C02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 03:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZiB1-0002J0-K3; Sun, 19 Jan 2025 22:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiAz-0002Hh-Fa
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:09 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tZiAx-0007hV-Nt
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 22:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737342607; x=1768878607;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EQIXurmzibcHcsG4mInmq0nLx5Lm78b8PKA8N1qOnJo=;
 b=FkY/2OhMtiy7wqAYVRAo5Dd9EEsiAKqe97vNZM5KhIg2SQLDo12Txsk1
 IzN5ATzKMk7UOYuvtFZQsp5P7YrikjqIa/s1h9zthOhCrdAUcwdmsdM2/
 zLD7Nvhw0QFkvXdT9ut8IS9X/eglX/w0ifeLIBalz2FwH5mhEkbpZMb+O
 ANsIG0Tz4H/QCdbI1x5BRibdo/dm3XBvQIwFFRQQ9m/bZMAaATAqUb//2
 JGfn/bR+6M6zq2OXbYnnqLNu6+n9D8DnIV7A/nXQzc1QCzGnnIt9zXaQs
 tVXS0/mISvIemLEQaKkj/Xu0U8k9/6NI5bsCl+CG801IFRRHe5rMrffSn g==;
X-CSE-ConnectionGUID: BpEIFR2QQG2fuaxt5eW//w==
X-CSE-MsgGUID: jCYU9553Quafo2Bj+GPshQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="175065607"
X-IronPort-AV: E=Sophos;i="6.13,218,1732546800"; d="scan'208";a="175065607"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 12:09:59 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F34FFD6EA9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C4DECCFBB1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 447606BAC6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:09:56 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5C8891A0071;
 Mon, 20 Jan 2025 11:09:55 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/3] hw/mem/cxl_type3: Add paired msix_uninit_exclusive_bar()
 call
Date: Mon, 20 Jan 2025 11:09:45 +0800
Message-Id: <20250120030947.254930-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28934.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28934.004
X-TMASE-Result: 10-0.176100-10.000000
X-TMASE-MatchedRID: toN6SH028bUy7r9tI4sSuomfV7NNMGm+1GdxOr7L6H2u9yzHHu0ZiSZl
 e49VkKqHIvrftAIhWmLy9zcRSkKatXwzxAv8kID0zr16YOzjZ13QiNv55aRoGrqln+jYe7Zh17f
 TaRrC7JloAzXI4Nhg5341niV9KymzHxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIcSqbxBgG0w4cPL
 OQ+phrrYqdbFd4X7QAKvPEkuwr1iSKfjOIOfJrLtIq+VrwLz72zNQ3fXMkh2SDToamn92pqqZUo
 ggwSSPywmvPT4lO6OdbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
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

msix_uninit_exclusive_bar() should be paired with msix_init_exclusive_bar()

Ensure proper resource cleanup by adding the missing
`msix_uninit_exclusive_bar()` call for the Type3 CXL device.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f64af19ed6ae..9dad250f56d5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,6 +936,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
 err_free_special_ops:
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
@@ -959,6 +960,7 @@ static void ct3_exit(PCIDevice *pci_dev)
 
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
+    msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
-- 
2.47.0


