Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA95C3ABA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 03:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9xkw-0000Ei-Bq; Tue, 29 Apr 2025 23:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9xkt-0000EA-Vd
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 23:05:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9xkq-0006s6-Oy
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 23:05:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaWpUkxFo7LXKAA--.9954S3;
 Wed, 30 Apr 2025 11:04:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8VTkxFoLWSfAA--.8808S2;
 Wed, 30 Apr 2025 11:04:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/loongarch/virt: Get physical entry address with elf file
Date: Wed, 30 Apr 2025 11:04:47 +0800
Message-Id: <20250430030447.1404720-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8VTkxFoLWSfAA--.8808S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

With load_elf() api, image load low address and high address is converted
to physical address if parameter translate_fn is provided. However
executing entry address is still virtual address. Here convert entry
address into physical address, since MMU is disabled when system power on,
the first PC instruction should be physical address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
  v2 ... v3:
  1. Modify link script about tcg system test cases, loading address is
     changed from virtual address 0x9000000000200000 to physical address
     0x200000. Otherwise test case memory-with-libmem.so fails to run
     with check-tcg command.

  v1 ... v2:
  1. Only modify LoongArch specified rather than load_elf() API, since
     there is be potential influence with other architectures.
---
 hw/loongarch/boot.c                    | 1 +
 tests/tcg/loongarch64/system/kernel.ld | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 354cf458c8..0324d6adcb 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -245,6 +245,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, ELFDATA2LSB,
                            EM_LOONGARCH, 1, 0);
+    kernel_entry = cpu_loongarch_virt_to_phys(NULL, kernel_entry);
     if (kernel_size < 0) {
         kernel_size = load_loongarch_linux_image(info->kernel_filename,
                                                  &kernel_entry, &kernel_low,
diff --git a/tests/tcg/loongarch64/system/kernel.ld b/tests/tcg/loongarch64/system/kernel.ld
index f1a7c0168c..56d8588f1a 100644
--- a/tests/tcg/loongarch64/system/kernel.ld
+++ b/tests/tcg/loongarch64/system/kernel.ld
@@ -3,7 +3,7 @@ ENTRY(_start)
 SECTIONS
 {
     /* Linux kernel legacy start address.  */
-    . = 0x9000000000200000;
+    . = 0x200000;
     _text = .;
     .text : {
         *(.text)

base-commit: 73d29ea2417b58ca55fba1aa468ba38e3607b583
-- 
2.39.3


