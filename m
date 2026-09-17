Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE84C982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x729a-0006QD-L3; Wed, 16 Sep 2026 22:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7298-0006M8-1H
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x7296-00059y-4g
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 22:46:45 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxQNGSVKtqFOEMAA--.37951S3;
 Thu, 17 Sep 2026 10:46:42 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxe86QVKtqDK0hAA--.39741S2;
 Thu, 17 Sep 2026 10:46:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
Subject: [PULL 08/11] target/loongarch: Enable LoongArch Instruction Set
 version 1.1
Date: Thu, 17 Sep 2026 10:47:39 +0800
Message-ID: <20260917024742.200257-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917024742.200257-1-maobibo@loongson.cn>
References: <20260917024742.200257-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxe86QVKtqDK0hAA--.39741S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry7Wr4DArW8Cr1DGF4xKrX_yoW8uw18pr
 ZrArsIg39rtF4xAwnrJayYvrn5XF4xGw42yF4xtrW7Zw4DXFn7Xa4kJa10yF9Fy3s5AF4I
 9FW8AFW5GFs8AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Now LoongArch Instruction Set version 1.1 is enabled in TCG mode,
disabled in KVM mode. After LoongArch Instruction Set version 1.1
detection is added in KVM mode, it can be enabled with max cpu type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   Song Gao <17746591750@163.com>
---
 target/loongarch/cpu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b8e95750bb..2d58277549 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -467,6 +467,8 @@ static void loongarch_la132_initfn(Object *obj)
 static void loongarch_max_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t data;
+
     /* '-cpu max': use it for max supported CPU features */
     loongarch_la464_initfn(obj);
 
@@ -474,20 +476,25 @@ static void loongarch_max_initfn(Object *obj)
     if (kvm_enabled()){
         cpu->msgint=ON_OFF_AUTO_OFF;
     }
+
+    /* Enable LA v1.1 instructions */
+    data = cpu->env.cpucfg[2];
+    data = FIELD_DP32(data, CPUCFG2, FRECIPE, 1);
+    data = FIELD_DP32(data, CPUCFG2, LAM_BH, 1);
+    data = FIELD_DP32(data, CPUCFG2, LAMCAS, 1);
+    data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
+    data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
+    cpu->env.cpucfg[2] = data;
+
+    data = cpu->env.cpucfg[3];
+    data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
+    cpu->env.cpucfg[3] = data;
+
     if (tcg_enabled()) {
-        uint32_t data = cpu->env.cpucfg[2];
+        data = cpu->env.cpucfg[2];
         data = FIELD_DP32(data, CPUCFG2, HPTW, 1);
-        /* Enable LA v1.1 instructions */
-        data = FIELD_DP32(data, CPUCFG2, FRECIPE, 1);
-        data = FIELD_DP32(data, CPUCFG2, LAM_BH, 1);
-        data = FIELD_DP32(data, CPUCFG2, LAMCAS, 1);
-        data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
-        data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
         cpu->env.cpucfg[2] = data;
 
-        data = cpu->env.cpucfg[3];
-        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
-        cpu->env.cpucfg[3] = data;
 	 cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
         cpu->msgint = ON_OFF_AUTO_AUTO;
     }
-- 
2.54.0


