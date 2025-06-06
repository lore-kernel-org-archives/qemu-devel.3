Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C2C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQfq-0005l3-E9; Fri, 06 Jun 2025 02:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uNQfo-0005kt-AB
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:35:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uNQfm-0008BY-2P
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:35:28 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXWsrjEJosMANAQ--.38759S3;
 Fri, 06 Jun 2025 14:35:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcUrjEJoHsgMAQ--.39710S2;
 Fri, 06 Jun 2025 14:35:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 12/13] hw/loongarch/virt: Disable emulation with IOCSR misc
 register
Date: Fri,  6 Jun 2025 14:35:23 +0800
Message-Id: <20250606063523.2557513-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250606063033.2557365-1-maobibo@loongson.cn>
References: <20250606063033.2557365-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcUrjEJoHsgMAQ--.39710S2
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

Register IOCSR MISC_FUNC_REG is to enable features about EXTIOI
irqchip. If EXTIOI is emulated in kernel, MISC_FUNC_REG register
should be emulated in kernel also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1b504047db..69491fa31f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -509,6 +509,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case MISC_FUNC_REG:
+        if (kvm_irqchip_in_kernel()) {
+            return MEMTX_OK;
+        }
+
         if (!virt_is_veiointc_enabled(lvms)) {
             return MEMTX_OK;
         }
@@ -559,6 +563,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         ret = 0x303030354133ULL;     /* "3A5000" */
         break;
     case MISC_FUNC_REG:
+        if (kvm_irqchip_in_kernel()) {
+            return MEMTX_OK;
+        }
+
         if (!virt_is_veiointc_enabled(lvms)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
             break;
-- 
2.39.3


