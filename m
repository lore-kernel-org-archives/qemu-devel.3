Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BC3C5320E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 03:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgbf3-00060y-Rc; Tue, 20 Aug 2024 23:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sgbez-0005zg-Hc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 23:05:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sgbew-00035F-M2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 23:05:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxvOpkWcVmVcoaAA--.58451S3;
 Wed, 21 Aug 2024 11:05:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxLGdhWcVm6jEcAA--.28456S3;
 Wed, 21 Aug 2024 11:05:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/1] hw/loongarch: Fix length for lowram in ACPI SRAT
Date: Wed, 21 Aug 2024 10:47:39 +0800
Message-Id: <20240821024739.3024705-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240821024739.3024705-1-gaosong@loongson.cn>
References: <20240821024739.3024705-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxLGdhWcVm6jEcAA--.28456S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

The size of lowram should be "gap" instead of the whole node.

This is failing kernel's sanity check:

[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x16fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x170000000-0x26fffffff]
[    0.000000] Warning: node 0 [mem 0x00000000-0xffffffff] overlaps with itself [mem 0x80000000-0x16fffffff]

Fixes: fc100011f38d ("hw/loongarch: Refine acpi srat table for numa memory")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 72bfc35ae6..2638f87434 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -218,7 +218,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
          *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
          */
         if (len >= gap) {
-            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            build_srat_memory(table_data, base, gap, i, MEM_AFFINITY_ENABLED);
             len -= gap;
             base = VIRT_HIGHMEM_BASE;
             gap = machine->ram_size - VIRT_LOWMEM_SIZE;
-- 
2.34.1


