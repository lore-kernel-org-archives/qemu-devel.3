Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E13C55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrEzp-0004wh-6F; Tue, 04 Aug 2026 09:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qiandongyan@loongson.cn>)
 id 1wr5sY-0008Am-JO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qiandongyan@loongson.cn>) id 1wr5sV-0002VO-IB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 23:31:45 -0400
Received: from loongson.cn (unknown [10.2.9.245])
 by gateway (Coremail) with SMTP id _____8BxHJsYXXFqHygKAA--.9978S3;
 Tue, 04 Aug 2026 11:31:36 +0800 (CST)
Received: from code-server.gen (unknown [10.2.9.245])
 by front1 (Coremail) with SMTP id qMiowJCxLcUXXXFq7fEiAA--.44786S4;
 Tue, 04 Aug 2026 11:31:35 +0800 (CST)
From: Dongyan Qian <qiandongyan@loongson.cn>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: [PATCH 2/3] hw/loongarch/virt: Set MADT revision to 6
Date: Tue,  4 Aug 2026 11:30:35 +0800
Message-Id: <20260804033036.2614008-3-qiandongyan@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260804033036.2614008-1-qiandongyan@loongson.cn>
References: <20260804033036.2614008-1-qiandongyan@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxLcUXXXFq7fEiAA--.44786S4
X-CM-SenderInfo: htld0v5rqj5t3q6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=qiandongyan@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Aug 2026 09:15:48 -0400
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

The LoongArch virt machine emits Core PIC, EIO PIC, MSI PIC and BIO PIC
subtables, but advertises MADT revision 1. Revision 1 predates these
LoongArch interrupt controller structures.

ACPI 6.5 introduced the LoongArch interrupt controller structures and
defined MADT revision 6. ACPI 6.6 raises the MADT revision to 7 for the
additional RISC-V interrupt controller structures, while leaving the
LoongArch structures unchanged.

Since the virt machine emits only the LoongArch structures defined by
ACPI 6.5, set the MADT header revision to 6, the minimum revision that
describes the table contents.

ACPI specifications:
https://uefi.org/specs/ACPI/6.5/
https://uefi.org/specs/ACPI/6.6/

Fixes: 735143f10d3 ("hw/loongarch: Add acpi ged support")
Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index a0b445f297..600ef60fc5 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -128,7 +128,7 @@ build_madt(GArray *table_data, BIOSLinker *linker,
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
     int i, arch_id, flags;
-    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lvms->oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = lvms->oem_id,
                         .oem_table_id = lvms->oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.43.0


