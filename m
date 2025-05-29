Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647A1C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKckA-0004ie-HZ; Thu, 29 May 2025 08:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uKZXr-0003R9-Hc
 for qemu-devel@nongnu.org; Thu, 29 May 2025 05:27:27 -0400
Received: from sg-1-30.ptr.blmpb.com ([118.26.132.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uKZXn-0002jz-A9
 for qemu-devel@nongnu.org; Thu, 29 May 2025 05:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1748510828;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cfUuzY8O5t9PwOW0P7Ys3TjZf/rdbS8I8bh0pKYOtWQ=;
 b=A1QF8N8vRsuUMI+WemKSZkqJZDyIYxcxTwJC3YB7cUeT0rCdjuFsiHSt/6FqLXvg15hCm7
 bZWREa4hIiSJ+IPhjXVYgBGNH8xeOrFJCEXIt0we7UBsEZiE+lvrnd799iRJnwmav1oi4x
 +v5PNlD+15NaV8eBy9iMGYkH9WnOi870qrS878AQoRCl+T6jbONRMo+56w5qi64L3jPfUk
 7lpcK0tgvsV4sBvrJbDErVXal4BTKymHgYfCY3on+Z5mcVV9TWvBH2PwC4D9CPvXxqHHFQ
 ALctWqV9gtkSfUw0Q6MtzieTyyA0chbD24YL9+z4uSHNPsG4wssxbYrHgstsQQ==
Content-Transfer-Encoding: 7bit
To: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Message-Id: <20250529092632.4367-1-liujingqi@lanxincomputing.com>
X-Lms-Return-Path: <lba+268382869+7e291e+nongnu.org+liujingqi@lanxincomputing.com>
Cc: "Nutty Liu" <liujingqi@lanxincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Received: from localhost.localdomain ([180.165.20.212]) by smtp.feishu.cn with
 ESMTP; Thu, 29 May 2025 17:27:04 +0800
Subject: [PATCH] hw/riscv/riscv-iommu: Fix PPN field of Translation-reponse
 register
Mime-Version: 1.0
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Date: Thu, 29 May 2025 17:26:32 +0800
Received-SPF: pass client-ip=118.26.132.30;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-30.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 May 2025 08:52:18 -0400
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

The original implementation incorrectly performed a bitwise AND
operation between the PPN of iova and PPN Mask, leading to an
incorrect PPN field in Translation-reponse register.

The PPN of iova should be set entirely in the PPN field of
Translation-reponse register.

Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
---
 hw/riscv/riscv-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a877e5da84..f529a6a3d7 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1935,8 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
             iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
         } else {
             iova = iotlb.translated_addr & ~iotlb.addr_mask;
-            iova >>= TARGET_PAGE_BITS;
-            iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
+            iova = set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
 
             /* We do not support superpages (> 4kbs) for now */
             iova &= ~RISCV_IOMMU_TR_RESPONSE_S;
-- 
2.49.0.windows.1

