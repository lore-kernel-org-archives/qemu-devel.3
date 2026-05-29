Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECCCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyPU-0000op-AS; Fri, 29 May 2026 10:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@loongson.cn>)
 id 1wSxr8-0006rU-SF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:06:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@loongson.cn>) id 1wSxr5-0000vR-3u
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:06:34 -0400
Received: from loongson.cn (unknown [223.64.68.59])
 by gateway (Coremail) with SMTP id _____8CxQ_BXnRlqWo8OAA--.41044S3;
 Fri, 29 May 2026 22:06:15 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
 by front1 (Coremail) with SMTP id qMiowJBxrsJPnRlqqRKVAA--.64350S2;
 Fri, 29 May 2026 22:06:14 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Gabriel Somlo <somlo@cmu.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org, loongarch@lists.linux.dev,
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] fw_cfg: Add support for LoongArch architecture
Date: Fri, 29 May 2026 22:05:59 +0800
Message-ID: <20260529140559.1775511-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxrsJPnRlqqRKVAA--.64350S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW8Wry8tFW5GFyUGw15trc_yoW8Wry5pr
 4DXFWjkrWrJa1FgrZrJa1q9r1aqas3JrZrua47Aa1qv3W3A3ykJr98AFW5tFyqvr4vyFWY
 kF1fKw1a9F1vkagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxU2MKZDUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=chenhuacai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 May 2026 10:42:00 -0400
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

Qemu fw_cfg support was missing for LoongArch, which made some functions
unusable in virtual machines. So add the missing LoongArch defines.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/firmware/Kconfig       | 2 +-
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..9ec747716389 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -121,7 +121,7 @@ config RASPBERRYPI_FIRMWARE
 
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
-	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
+	depends on SYSFS && (ARM || ARM64 || LOONGARCH || PARISC || PPC_PMAC || RISCV || SPARC || X86)
 	depends on HAS_IOPORT_MAP
 	default n
 	help
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 87a5421bc7d5..0c51a9df589f 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
 
 /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
 #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
-# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
+# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH) || defined(CONFIG_RISCV))
 #  define FW_CFG_CTRL_OFF 0x08
 #  define FW_CFG_DATA_OFF 0x00
 #  define FW_CFG_DMA_OFF 0x10
-- 
2.52.0


