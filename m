Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA42CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgg8-0001qt-UZ; Mon, 05 Oct 2026 07:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xDgfo-0001mP-DR; Mon, 05 Oct 2026 07:16:01 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xDgfl-0007Br-M4; Mon, 05 Oct 2026 07:16:00 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowABnZjTNhsNqNyGuCQ--.34860S2;
 Mon, 05 Oct 2026 19:15:48 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-stable@nongnu.org
Subject: [PATCH v2] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
Date: Mon,  5 Oct 2026 19:15:23 +0800
Message-ID: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnZjTNhsNqNyGuCQ--.34860S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45tF4DGFyrJryfCw48Zwb_yoW8Ar4fpr
 W3Kr4rA3WrXFn2y3Z2kw48CF409an5Wa4Yvr15uwn5Ar45KrWUCF4Dt3s7ua4DtFs5uF1a
 vw4j9r1DZF1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
 AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUe_-BDUUU
 U
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

riscv_iommu_translate() allocates an IOATC entry before passing it to
riscv_iommu_iot_update(). The update helper normally transfers ownership
to the hash table.

When ioatc-limit is zero, however, the helper returns without inserting or
freeing the entry. Every cacheable non-identity translation therefore leaks
one RISCVIOMMUEntry.

Avoid this by disabling caching at the caller when ioatc-limit is zero,
so riscv_iommu_translate() does not allocate an IOATC entry in the first
place. This avoids special-casing entry freeing in riscv_iommu_iot_update()
and keeps the ownership semantics simpler.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
v2:
- Disable caching when ioatc-limit is zero instead of freeing the
  allocated entry in riscv_iommu_iot_update().

 hw/riscv/riscv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..866f49cc39 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2919,7 +2919,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb,
+                                     as->iommu->iot_limit > 0)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-- 
2.53.0


