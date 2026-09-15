Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B25C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Nbo-0008Kn-Ae; Tue, 15 Sep 2026 03:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1712AE31BF=lirongqing@baidu.com>)
 id 1x6Nbk-0008KT-HZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:29:36 -0400
Received: from mx21.baidu.com ([220.181.3.85] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1712AE31BF=lirongqing@baidu.com>)
 id 1x6Nbd-0004I9-6W
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:29:34 -0400
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] pcie_aer: fix pci_set_long overflow into PCI_EXP_LNKCAP
Date: Tue, 15 Sep 2026 15:29:08 +0800
Message-ID: <20260915072908.2197-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc13.internal.baidu.com (172.31.4.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1789457356;
 bh=DQbdwpCH9YgbPVUq2woUeW5Jrdfp8Cyb9n6JchKAGKo=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=apwhUr99QHkaPWOCCrfveD1SDDITnCyfDPwfNbwnfiMM8Wf9EnQ8puC588kICpP2V
 Nu2iDqpow5LBpTRlsBWvkwZwTdvQHQKsIT5Qn2KiIxPT41t9mzHKXbQDqCC/Szpzon
 hajOaRHGnoyWcDxcuNv/vFJTUwO0xDrgauezQXGjhxwD3TKPflg9jKDUCu5zKiR8MM
 aseH+2nn432FmmsU+p0IS4s7EhoOXqdk64KisOscEqowT2h7MTQ9g0opNg/wPC4SyS
 SXCgCVesJQPTVOc7g/ZCSdEhp+o7dz5Za99Od2ZYYlPGM2tAwGc11hfmBtL77LB38h
 dNsYLQxtVw2Og==
Received-SPF: pass client-ip=220.181.3.85;
 envelope-from=prvs=md1712AE31BF=lirongqing@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Li RongQing <lirongqing@baidu.com>

pcie_aer_inject_uncor_error() wrote inj->devsta (a uint16_t) into
PCI_EXP_DEVSTA using pci_set_long(), which writes 4 bytes. PCI_EXP_DEVSTA
is a 16-bit register at offset 0x0a; the extra 2 bytes written by
pci_set_long() land at offset 0x0c, the low half of PCI_EXP_LNKCAP,
zeroing the link speed/width capability fields on every uncorrectable
error injection.

Use pci_set_word() instead, matching the correctable error path in
pcie_aer_inject_cor_error().

Fixes: 34e65944c0351 ("pcie/aer: helper functions for pcie aer capability")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 hw/pci/pcie_aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 22497b1..43b14c1 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -589,7 +589,7 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject *inj, bool is_fatal)
     if (inj->unsupported_request) {
         inj->devsta |= PCI_EXP_DEVSTA_URD;
     }
-    pci_set_long(dev->config + dev->exp.exp_cap + PCI_EXP_DEVSTA, inj->devsta);
+    pci_set_word(dev->config + dev->exp.exp_cap + PCI_EXP_DEVSTA, inj->devsta);
 
     if (inj->aer_cap) {
         uint32_t mask = pci_get_long(inj->aer_cap + PCI_ERR_UNCOR_MASK);
-- 
2.9.4


