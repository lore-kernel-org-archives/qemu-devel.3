Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23ABC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 02:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u88cN-00047a-3W; Thu, 24 Apr 2025 22:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u88cL-00047O-5r
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 22:16:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u88cI-00017d-5k
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 22:16:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxrOJ58ApowcjFAA--.26700S3;
 Fri, 25 Apr 2025 10:16:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxH+V08ApoDG6UAA--.43193S2;
 Fri, 25 Apr 2025 10:16:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/loongarch/virt: Get physical entry address with elf file
Date: Fri, 25 Apr 2025 10:16:20 +0800
Message-Id: <20250425021620.3968737-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxH+V08ApoDG6UAA--.43193S2
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
---
  v1 ... v2:
  1. Only modify LoongArch specified rather than load_elf() API, since
     there is be potential influence with other architectures.
---
 hw/loongarch/boot.c | 1 +
 1 file changed, 1 insertion(+)

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

base-commit: 019fbfa4bcd2d3a835c241295e22ab2b5b56129b
-- 
2.39.3


