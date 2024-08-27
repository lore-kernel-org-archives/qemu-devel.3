Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CFC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinLY-0004gn-VW; Mon, 26 Aug 2024 23:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sinLX-0004d5-08
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:58:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sinLU-0005Si-OD
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:58:18 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxGJrQTs1mIzghAA--.30725S3;
 Tue, 27 Aug 2024 11:58:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxG2fQTs1m5fEjAA--.57777S2;
 Tue, 27 Aug 2024 11:58:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Add compatible support about VM reboot
Date: Tue, 27 Aug 2024 11:58:07 +0800
Message-Id: <20240827035807.3326293-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxG2fQTs1m5fEjAA--.57777S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With edk2-stable202408 LoongArch UEFI bios, CSR PGD register is set only
if its value is equal to zero for boot cpu, it causes reboot issue. Since
CSR PGD register is changed with linux kernel, UEFI BIOS cannot use it.

Add workaround to clear CSR registers relative with TLB in function
loongarch_cpu_reset_hold(), so that VM can reboot with edk2-stable202408
UEFI bios.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5e85b9dbef..2f4d635d03 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -549,6 +549,20 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
     env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
     env->CSR_TID = cs->cpu_index;
+    /*
+     * Workaround for edk2-stable202408, CSR PGD register is set only if
+     * its value is equal to zero for boot cpu, it causes reboot issue.
+     *
+     * Here clear CSR registers relative with TLB.
+     */
+    env->CSR_PGDH = 0;
+    env->CSR_PGDL = 0;
+    env->CSR_PWCL = 0;
+    env->CSR_PWCH = 0;
+    env->CSR_STLBPS = 0;
+    env->CSR_EENTRY = 0;
+    env->CSR_TLBRENTRY = 0;
+    env->CSR_MERRENTRY = 0;
 
     for (n = 0; n < 4; n++) {
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);

base-commit: f259e4cb8a8b4ef5463326fc214a7d8d7703d5de
-- 
2.39.3


