Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EACC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNA2J-0004Vj-VC; Thu, 05 Jun 2025 08:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uNA2H-0004VR-5Q
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:49:33 -0400
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uNA2C-0002uz-0P
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1749127755;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BwT03PuYNPx6ZhnFlEBVIWTkbTJBcigSSkfhmsOlP0w=;
 b=apSQOcWClLk6rQmNu32bJlGzGghJmgrteRxWawnq9qiGd1tScKhF1HosbZZK8EeReLarZ0
 R7aL4V5k87OHJLPCmnlXaV6PJ/K85Yi6jdhyOnDLfDLyxt8bnjpcDSpLL0RZcgxZoV3GHq
 C9vti7GRvJW86T8z1p20VRSo60xwYRIJvyLApEDcVYDm2nIaTzbkiqbypCwDKtx1IXTQtT
 ZT9CNJ4ZWzm6XOiZBxdbE1s9GFD0/b3pmP0XhDnLmNbmd9tUNzogyKCkPnq12rs/gZUA72
 iE9gYzLp9u15gbvr1NjGQA33LP4282kDKY7Qk4QJRAxEv/HyufUGfGv64HYYoA==
Content-Transfer-Encoding: 7bit
Cc: "Nutty Liu" <liujingqi@lanxincomputing.com>, 
 "Tomasz Jeznach" <tjeznach@rivosinc.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Received: from localhost.localdomain ([180.165.23.184]) by smtp.feishu.cn with
 ESMTP; Thu, 05 Jun 2025 20:49:12 +0800
Mime-Version: 1.0
Message-Id: <20250605124848.1248-1-liujingqi@lanxincomputing.com>
X-Lms-Return-Path: <lba+268419249+a25c3e+nongnu.org+liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu,  5 Jun 2025 20:48:48 +0800
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: [PATCH v2] hw/riscv/riscv-iommu: Fix PPN field of Translation-reponse
 register
To: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>
Received-SPF: pass client-ip=118.26.132.12;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-12.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The original implementation incorrectly performed a bitwise AND
operation between the PPN of iova and PPN Mask, leading to an
incorrect PPN field in Translation-reponse register.

The PPN of iova should be set entirely in the PPN field of
Translation-reponse register.

Also remove the code that was used to clear S field since this
field is already zero.

Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
V1 -> V2:
 - Commented by Alistair
 - Reviewed by Tomasz
 - Remove the extra code
---
 hw/riscv/riscv-iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a877e5da84..d8b1cb03a8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1935,11 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
             iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
         } else {
             iova = iotlb.translated_addr & ~iotlb.addr_mask;
-            iova >>= TARGET_PAGE_BITS;
-            iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
-
-            /* We do not support superpages (> 4kbs) for now */
-            iova &= ~RISCV_IOMMU_TR_RESPONSE_S;
+            iova = set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
         }
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
     }
-- 
2.49.0.windows.1

