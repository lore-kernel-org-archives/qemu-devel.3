Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE13D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xj4-00070s-MM; Tue, 29 Oct 2024 21:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t5xj3-0006yb-1Z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:42:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t5xj0-0001NW-1u
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:42:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxCeH0jiFnrUQdAA--.60254S3;
 Wed, 30 Oct 2024 09:42:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxVcDyjiFntjcoAA--.22949S2;
 Wed, 30 Oct 2024 09:42:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 jiaxun.yang@flygoat.com, maobibo@loongson.cn, pbonzini@redhat.com,
 armbru@redhat.com, lixianglai@loongson.cn
Subject: [PATCH v2] hw/loongarch/boot: Use warn_report when no kernel filename
Date: Wed, 30 Oct 2024 09:23:59 +0800
Message-Id: <20241030012359.4040817-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxVcDyjiFntjcoAA--.22949S2
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

When we run “qemu-system-loongarch64 -qmp stdio -vnc none -S”,
we get an error message “Need kernel filename” and then we can't use qmp cmd to query some information.
So, we just throw a warning and then the cpus starts running from address VIRT_FLASH0_BASE.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index cb668703bd..5f194e1a77 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -278,7 +278,7 @@ static void init_boot_rom(struct loongarch_boot_info *info, void *p)
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 {
     void *p, *bp;
-    int64_t kernel_addr = 0;
+    int64_t kernel_addr = VIRT_FLASH0_BASE;
     LoongArchCPU *lacpu;
     CPUState *cs;
 
@@ -286,8 +286,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
         kernel_addr = load_kernel_info(info);
     } else {
         if(!qtest_enabled()) {
-            error_report("Need kernel filename\n");
-            exit(1);
+            warn_report("No kernel provided, booting from flash drive. \n");
         }
     }
 
-- 
2.34.1


