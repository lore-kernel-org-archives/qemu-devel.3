Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EDEC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 07:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXyIj-0004zj-S5; Wed, 15 Jan 2025 02:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXyIf-0004zC-Lz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:58:55 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXyIc-0001wS-KP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736927930; x=1768463930;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jQDeMN5xwl1RJXxiEogsOPcsBD/ElhkO4QpF1REr5uk=;
 b=Zh5/TXt8BoTK8Fe/DoSSydUYfnmjuiun1x8u5DutYO2rMkwsHUUWLlH7
 SfqXkRW0OLe4qNyWsOOpWRNRZCsnG8ASxcvcS0CSNXbNMvdf12cQCzmJF
 N6qW93eoLT8udF1uHmr/uEXwRsWr3xNUnEzDJN1b4JVyx6YHwsi0/ox0P
 qAJ4FhAYj/EvCruAmKYZmZeN8SJAr25M+bfS4uMaul/TZaOF+UIG9W2PI
 JTqVHffgvuEXAJZv3k37EOFwcntkv+FIhYqD4mhRzP/i2Fp3ZY/+6pvKc
 KoG8DRG6bfNC1ZX8IAzXtSit6/6DGvfH/1DSP2FQuuTlxJzo3VYE8W4S1 g==;
X-CSE-ConnectionGUID: bqCIRd81TyS6H21A2MpGSA==
X-CSE-MsgGUID: GEGx4jcPQACcBbjjqO/mig==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="165538625"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="165538625"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 16:58:43 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id DE2BC96741
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id AC137D3F34
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 34FE06B4F3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:58:40 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 582B81A000B;
 Wed, 15 Jan 2025 15:58:39 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Date: Wed, 15 Jan 2025 15:58:34 +0800
Message-Id: <20250115075834.167504-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.006
X-TMASE-Result: 10--1.451200-10.000000
X-TMASE-MatchedRID: llTo18AJfvHCVJdexVBqdn1zro62qhdCLL6mJOIs/vZGQgIVrmBL5G7l
 BX/37R4p+xFlvZshf1aUrbS7Rz/s6duWQuISDK/kF63b38RTfu8bbhhV65kaY1gLks93sG9tOiw
 t/WQfkJ/tRjFyEsLiS4fv9hpetzmsL/tBTZzO5Q0D2WXLXdz+AVK6+0HOVoSoP/c8VwmgfSOjxY
 yRBa/qJXcsDK2xBHh7jaPj0W1qn0TGVuWouVipcs92lnk/vvrz/Vzb9/cD9OdIQGnyl2vpAl1nS
 gx1e+RcLNDgPaZ4SCFOIvGQcPibAygA7v0fn2MGBA2j/sFHfYC/yGMuHed7PxFltGxCTkwFQHVA
 +r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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

This assertion always happens when we sanitize the CXL memory device.
$ echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize

It is incorrect to register an MSIX number beyond the device's capability.

Increase the device's MSIX number to cover the mailbox msix number(9).

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  Just increate the device's msix number, A new enumeration will be introduced in later patch. # Jonathan

V2:
  Just increase msix number and add enum to maintainer their values # Jonathan
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index bd7652740f4b..0ae1704a345c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -843,7 +843,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
+    unsigned short msix_num = 10;
     int i, rc;
     uint16_t count;
 
-- 
2.47.0


