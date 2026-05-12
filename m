Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67098CD4F27
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgXL-00032A-P3; Tue, 12 May 2026 02:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMgWf-0001jF-3P; Tue, 12 May 2026 02:23:39 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMgWY-0004tW-6O; Tue, 12 May 2026 02:23:28 -0400
Received: from yzs (unknown [122.231.43.248])
 by APP-03 (Coremail) with SMTP id rQCowAB3XONPxwJqhZ7CEA--.13122S2;
 Tue, 12 May 2026 14:23:11 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH] hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT ID
 mapping
Date: Tue, 12 May 2026 14:23:10 +0800
Message-ID: <20260512062310.348208-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3XONPxwJqhZ7CEA--.13122S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry8Xw1UJw45CFWftr17trb_yoW8AF1kpr
 W3KrWayry8Xws7A3W3tF1UWF15t34v9a4Y9r15Crs8Aws0kFW5XF4rKFWrKrnIyF48Xa9I
 kr1Yv3s3ur1YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-6pPUUUUU=
X-Originating-IP: [122.231.43.248]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREFA2oCsEUZtQABsu
Received-SPF: pass client-ip=159.226.251.81; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
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

In build_rimt(), the calculation of `num_ids` for the ID mapping array
incorrectly uses the same formula (`0xffff - s->pci_iommu_bdf`) for both
System IOMMU and PCI IOMMU topologies.

For a System IOMMU, `s->pci_iommu_bdf` is 0. This results in a `num_ids`
value of 0xffff. Since the source ID base starts at 0, the mapping only
covers Requester IDs from 0 to 0xfffe. The final valid PCI Requester ID
(0xffff) is erroneously omitted from the RIMT table.

Fix this by decoupling the `num_ids` calculation. For System IOMMUs,
explicitly set `num_ids` to 0x10000 to cover the entire PCI Requester ID
space.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/c78dacf66c8acd677b3538c837fde310bb71a97b/output/riscv-server-platform/pr-102/qemu.txt#L32
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 hw/riscv/virt-acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index fd6ca5dbc4ff..413d47d70ef1 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -802,10 +802,11 @@ static void build_rimt(GArray *table_data, BIOSLinker *linker,
         range = &g_array_index(iommu_idmaps, AcpiRimtIdMapping, i);
         if (virt_is_iommu_sys_enabled(s)) {
             range->source_id_base = 0;
+            range->num_ids = 0x10000;
         } else {
             range->source_id_base = s->pci_iommu_bdf + 1;
+            range->num_ids = 0xffff - s->pci_iommu_bdf;
         }
-        range->num_ids = 0xffff - s->pci_iommu_bdf;
         build_rimt_id_mapping(table_data, range->source_id_base,
                               range->num_ids, iommu_offset);
     }
-- 
2.51.2


