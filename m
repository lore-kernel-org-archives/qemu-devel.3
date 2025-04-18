Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFF7C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5gx2-0008N9-Da; Fri, 18 Apr 2025 04:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u5gx1-0008Mw-Og
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u5gwz-0003Rx-QB
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:55 -0400
Received: from loongson.cn (unknown [223.64.28.203])
 by gateway (Coremail) with SMTP id _____8AxaeAmCwJoIJrBAA--.60096S3;
 Fri, 18 Apr 2025 16:19:50 +0800 (CST)
Received: from lvm.. (unknown [223.64.28.203])
 by front1 (Coremail) with SMTP id qMiowMBxn8UfCwJoYSyJAA--.12831S4;
 Fri, 18 Apr 2025 16:19:48 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc,
 WANG Rui <wangrui@loongson.cn>
Subject: [PATCH v4 2/3] target/loongarch: Guard BCEQZ/BCNEZ instructions with
 FP feature
Date: Fri, 18 Apr 2025 16:21:02 +0800
Message-ID: <20250418082103.447780-3-wangrui@loongson.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418082103.447780-1-wangrui@loongson.cn>
References: <20250418082103.447780-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8UfCwJoYSyJAA--.12831S4
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury7Cw17Ar4rXF45KrW7GFX_yoW8Jw17pw
 1Duw10kFW7Jr93Cw1rX3yqyF13Xws0kw47WFsrtwn3Zw45XryvqFy8Krn8KF43AF1IvrW0
 vFWSvryUWF4UZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
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

The BCEQZ and BCNEZ instructions depend on access to condition codes
from floating-point comparisons. Previously, these instructions were
unconditionally enabled for 64-bit targets.

This patch updates their translation to be gated under the `FP` feature
flag instead, ensuring they are only available when the floating-point
unit is present.

This improves correctness for CPUs lacking floating-point support.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_branch.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
index 221e5159db..f94c1f37ab 100644
--- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
 TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
 TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
 TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
-TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
-TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
+TRANS(bceqz, FP, gen_cz_bc, TCG_COND_EQ)
+TRANS(bcnez, FP, gen_cz_bc, TCG_COND_NE)
-- 
2.49.0


