Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387E606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsyo-0001ee-KL; Fri, 13 Nov 2026 10:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xRsxo-0001Cu-Mg; Fri, 13 Nov 2026 10:13:37 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xRsxm-0001sG-Gg; Fri, 13 Nov 2026 10:13:16 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowACneZr1KPdqPKn0AA--.15904S4;
 Fri, 13 Nov 2026 23:13:02 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, nutty.liu@hotmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2 2/3] hw/riscv: iommu: Check permissions on IOATC hits
Date: Fri, 13 Nov 2026 23:12:50 +0800
Message-ID: <20261113151251.30618-3-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113151251.30618-1-tanchi25@mails.ucas.ac.cn>
References: <20261113151251.30618-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACneZr1KPdqPKn0AA--.15904S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw17uF45KFWktr1DJrWxtFb_yoW8Gr48pr
 WDGr4Y9ayFqrn3Za42ya1DAF1Ut3Z3WF1aqrySkF4UtF4Fqr4UAr45tayjgw1jkF4kuFy2
 9wsF9rn5Zr1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
 z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5WwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUYNtxUUUUU=
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current implementation reuses cached translations without checking
whether their permissions satisfy the requested access.

Only reuse an IOATC entry when its permissions cover the current
request. Otherwise, perform a page-table walk to check the requested
access. Preserve the existing behavior for requests with IOMMU_NONE.

This is also needed for hardware A/D updates, where mappings with a
clear D bit must not cache write permission until the bit has been set.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 hw/riscv/riscv-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5b8cfff3bd..8c26b7f2b2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1779,7 +1779,9 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         phys = iot->phys;
     }
     qemu_mutex_unlock(&s->iot_lock);
-    if (perm != IOMMU_NONE) {
+    if (perm != IOMMU_NONE &&
+        (iotlb->perm == IOMMU_NONE ||
+         (perm & iotlb->perm) == iotlb->perm)) {
         iotlb->translated_addr = PPN_PHYS(phys);
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         iotlb->perm = perm;
-- 
2.53.0


