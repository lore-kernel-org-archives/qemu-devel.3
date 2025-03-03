Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B58C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 06:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tozfU-0001fD-Gm; Mon, 03 Mar 2025 01:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tozf8-0001QF-2Y
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:52:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tozf4-0005aK-Rz
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 01:52:25 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxWXGbUcVng_CIAA--.37676S3;
 Mon, 03 Mar 2025 14:52:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXsWaUcVnqU0zAA--.57870S2;
 Mon, 03 Mar 2025 14:52:10 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Adjust the cpu reset action to a proper
 position
Date: Mon,  3 Mar 2025 14:30:43 +0800
Message-Id: <20250303063043.3237264-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsWaUcVnqU0zAA--.57870S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

The commit 5a99a10da6cf ("target/loongarch: fix vcpu reset command word issue")
fixes the error in the cpu reset ioctl command word delivery process,
so that the command word can be delivered correctly, and adds the judgment
and processing of the error return value, which exposes another problem that
under loongarch, the cpu reset action is earlier than the creation of vcpu.
An error occurs when the cpu reset command is sent.

Now adjust the order of cpu reset and vcpu create actions to fix this problem

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Bibo Mao <maobibo@loongson.cn>
Huacai Chen <chenhuacai@loongson.cn>
Song Gao <gaosong@loongson.cn>
Xianglai Li <lixianglai@loongson.cn>

 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 3788f895c1..67aa7875b6 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -640,8 +640,8 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 
     loongarch_cpu_register_gdb_regs_for_features(cs);
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
 
     lacc->parent_realize(dev, errp);
 }
-- 
2.39.1


