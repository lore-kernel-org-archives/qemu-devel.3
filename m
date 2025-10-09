Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B364CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qFx-0006fj-Mb; Thu, 09 Oct 2025 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v6qFj-0006Un-Le
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v6qFU-0006g7-6E
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxndLHsedopEkUAA--.42756S3;
 Thu, 09 Oct 2025 20:59:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxG8HCsedoBqnWAA--.42888S4;
 Thu, 09 Oct 2025 20:59:50 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>, WANG Rui <wangrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL  2/6] hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
Date: Thu,  9 Oct 2025 20:35:57 +0800
Message-Id: <20251009123601.2380901-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251009123601.2380901-1-gaosong@loongson.cn>
References: <20251009123601.2380901-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxG8HCsedoBqnWAA--.42888S4
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Huacai Chen <chenhuacai@loongson.cn>

Now VIRT_GED_CPUHP_ADDR is not aligned to 4 bytes, but if Linux kernel
is built with ACPI_MISALIGNMENT_NOT_SUPPORTED, it assumes the alignment,
otherwise we get ACPI errors at boot phase:

ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)

VIRT_GED_MEM_ADDR and VIRT_GED_REG_ADDR are already aligned now, but use
QEMU_ALIGN_UP() to explicitly align them can make code more robust.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250923143542.2391576-3-chenhuacai@kernel.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/loongarch/virt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index cd97bdfb8d..76fa57cd07 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -49,9 +49,9 @@
 #define VIRT_LOWMEM_SIZE        0x10000000
 #define VIRT_HIGHMEM_BASE       0x80000000
 #define VIRT_GED_EVT_ADDR       0x100e0000
-#define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
-#define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
-#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
+#define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN, 4)
+#define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN, 4)
+#define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT, 4)
 
 #define COMMAND_LINE_SIZE       512
 
-- 
2.47.0


