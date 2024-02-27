Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F7C54798
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 01:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf8ue-0002bi-8b; Tue, 27 Feb 2024 20:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <greg@gpanders.com>) id 1rf5qW-0006Xx-5z
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:22:44 -0500
Received: from out-172.mta0.migadu.com ([91.218.175.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <greg@gpanders.com>) id 1rf5qU-0007qy-9l
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:22:43 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
 s=key1; t=1709072557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dwmRI39xiP3NrsRq7zQOAs6W90Obz/H304ExfZbhqRg=;
 b=LImOfydnuSssmfuBcDkvS6BbeRbLpwMZtUbifnbEg/z+Zop5Ui5Q0YO12q7W6m47MPAMd7
 BolaqxG2+yMpKEXJxrlo8EwebsEj6hTPhKq5pXCTVFSIiar2PhQu8848a7XiDCg3LaQ9HY
 HWqd5jXAa2dKsHwsMIj04Yg0jRApqqFIWdJdCSIcBU4yNaOekVHsFEas+1Re/p5BoF3u1x
 RAFnYymRyRjpyUKk3x10TYgDPWeOrwy1WRJAo1grXqwJkl1Xap31Xux9PXkfdi0xj9H/0c
 JnaRg0sEY+5WPmTShP8mXVFN35PmqjbBWHSOawfzMCQCul7+LhrzGAZ24rk1NQ==
From: Gregory Anders <greg@gpanders.com>
To: qemu-devel@nongnu.org
Cc: Gregory Anders <greg@gpanders.com>
Subject: [PATCH] hw/misc: zynq_slcr: set SLC_RST bit in REBOOT_STATUS register
Date: Tue, 27 Feb 2024 16:22:03 -0600
Message-ID: <20240227222227.74935-1-greg@gpanders.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.172; envelope-from=greg@gpanders.com;
 helo=out-172.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 20:39:10 -0500
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

When the CPU is reset using PSS_RST_CTRL in the SLCR, bit 19 in
REBOOT_STATUS should be set.

Refer to page 1602 of the Xilinx Zynq 7000 Technical Reference Manual.

Signed-off-by: Gregory Anders <greg@gpanders.com>
---
 hw/misc/zynq_slcr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d2ac2e77f2..a8f1792bf6 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -120,6 +120,7 @@ REG32(RS_AWDT_CTRL, 0x24c)
 REG32(RST_REASON, 0x250)
 
 REG32(REBOOT_STATUS, 0x258)
+    FIELD(REBOOT_STATUS, SLC_RST, 19, 1)
 REG32(BOOT_MODE, 0x25c)
 
 REG32(APU_CTRL, 0x300)
@@ -562,6 +563,7 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
     switch (offset) {
     case R_PSS_RST_CTRL:
         if (FIELD_EX32(val, PSS_RST_CTRL, SOFT_RST)) {
+            s->regs[R_REBOOT_STATUS] |= R_REBOOT_STATUS_SLC_RST_MASK;
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
-- 
2.43.2


