Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1B5C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 01:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub8PS-0001GN-58; Sun, 13 Jul 2025 21:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ub8PH-0001C1-Gv; Sun, 13 Jul 2025 21:55:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1ub8PE-0004rl-D1; Sun, 13 Jul 2025 21:55:02 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaWpqY3RoR+YoAQ--.23660S3;
 Mon, 14 Jul 2025 09:54:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxvsFpY3Ro8zIWAA--.15935S2;
 Mon, 14 Jul 2025 09:54:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/loongarch: Fix valid virtual address checking
Date: Mon, 14 Jul 2025 09:54:46 +0800
Message-Id: <20250714015446.746163-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxvsFpY3Ro8zIWAA--.15935S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On LoongArch64 system, the high 32 bit of 64 bit virtual address should be
0x00000[0-7]yyy or 0xffff8yyy. The bit from 47 to 63 should be all 0 or
all 1.

Function get_physical_address() only checks bit 48 to 63, there will be
problem with the following test case. On physical machine, there is bus
error report and program exits abnormally. However on qemu TCG system
emulation mode, the program runs normally. The virtual address
0xffff000000000000ULL + addr and addr are treated the same on TLB entry
checking. This patch fixes this issue.

void main()
{
        void *addr, *addr1;
        int val;

        addr = malloc(100);
        *(int *)addr = 1;
        addr1 = 0xffff000000000000ULL + addr;
        val = *(int *)addr1;
        printf("val %d \n", val);
}

Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index e172b11ce1..b5f732f15b 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -196,8 +196,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     /* Check valid extension */
-    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
-    if (!(addr_high == 0 || addr_high == -1)) {
+    addr_high = (int64_t)address >> (TARGET_VIRT_ADDR_SPACE_BITS - 1);
+    if (!(addr_high == 0 || addr_high == -1ULL)) {
         return TLBRET_BADADDR;
     }
 

base-commit: 9a4e273ddec3927920c5958d2226c6b38b543336
-- 
2.39.3


