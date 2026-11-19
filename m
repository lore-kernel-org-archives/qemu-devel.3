Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA9E606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTs7P-0000pb-Ra; Wed, 18 Nov 2026 21:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7N-0000pL-IO; Wed, 18 Nov 2026 21:43:21 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7K-0005aN-Ov; Wed, 18 Nov 2026 21:43:21 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowAD3Hfg8Yv5qZFtAAQ--.232S4;
 Thu, 19 Nov 2026 10:43:12 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 2/3] hw/riscv: iommu-pci: Add migration support
Date: Thu, 19 Nov 2026 10:42:49 +0800
Message-ID: <20261119024251.280765-3-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3Hfg8Yv5qZFtAAQ--.232S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3ZF1DKryDGryrXFW8Zwb_yoW8Cw4DpF
 s5ur4Sy3W5JFs2qa13Jw4UGF4YqanYg3WYvr47Ca1kJa1UKrWYqFsxA347Ar4DJFW5Xw12
 vw4fCFWDCF4jywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
 1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
 JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUiFxUUUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
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

Replace the unmigratable VMState description with one that saves
the PCI configuration space and MSI-X state.

Use the existing PCI migration helpers to preserve the MSI-X
table and pending bit array when MSI-X is present.

The common IOMMU state is migrated separately by the embedded
RISC-V IOMMU device.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu-pci.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 14dd5f3857..d149032cd1 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -143,9 +143,23 @@ static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
     pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
 }
 
-static const VMStateDescription riscv_iommu_vmstate = {
-    .name = "riscv-iommu",
-    .unmigratable = 1
+static bool riscv_iommu_pci_msix_present(void *opaque, int version_id)
+{
+    RISCVIOMMUStatePci *s = opaque;
+
+    return msix_present(&s->pci);
+}
+
+static const VMStateDescription vmstate_riscv_iommu_pci = {
+    .name = "riscv-iommu-pci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pci, RISCVIOMMUStatePci),
+        VMSTATE_MSIX_TEST(pci, RISCVIOMMUStatePci,
+                          riscv_iommu_pci_msix_present),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static void riscv_iommu_pci_init(Object *obj)
@@ -193,7 +207,7 @@ static void riscv_iommu_pci_class_init(ObjectClass *klass, const void *data)
     k->exit = riscv_iommu_pci_exit;
     k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
     dc->desc = "RISCV-IOMMU DMA Remapping device";
-    dc->vmsd = &riscv_iommu_vmstate;
+    dc->vmsd = &vmstate_riscv_iommu_pci;
     dc->hotpluggable = false;
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.53.0


