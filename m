Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C076E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFlD-0004ER-Qi; Fri, 10 Jan 2025 09:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1tWBMg-0006mp-NO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:31:42 -0500
Received: from out28-146.mail.aliyun.com ([115.124.28.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1tWBMe-0000jS-1Y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:31:38 -0500
Received: from DESKTOP-MLVKPO8.(mailfrom:huangborong@bosc.ac.cn
 fp:SMTPD_---.b.A-9Hc_1736501164 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 17:26:12 +0800
From: Huang Borong <huangborong@bosc.ac.cn>
To: qemu-devel@nongnu.org
Cc: Huang Borong <huangborong@bosc.ac.cn>
Subject: [PATCH] hw/intc/riscv_aplic: Remove redundant masking of hart_idx in
 riscv_aplic_msi_send()
Date: Fri, 10 Jan 2025 17:25:36 +0800
Message-Id: <20250110092536.309217-1-huangborong@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.146;
 envelope-from=huangborong@bosc.ac.cn; helo=out28-146.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jan 2025 09:13:13 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The line "hart_idx &= APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);" was removed
because the same operation is performed later in the address calculation.
This change improves code clarity and avoids unnecessary operations.

Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
---
 hw/intc/riscv_aplic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4866649115..0974c6a5db 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -421,7 +421,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
     group_idx = hart_idx >> lhxw;
-    hart_idx &= APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);
 
     addr = msicfgaddr;
     addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK)) << 32;
-- 
2.34.1


