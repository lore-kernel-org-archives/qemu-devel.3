Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 02:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uikzR-0007A5-KW; Sun, 03 Aug 2025 22:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uikz5-00073e-2t
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:31:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uikz1-0000mz-V4
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:31:30 -0400
Received: from loongson.cn (unknown [223.64.120.241])
 by gateway (Coremail) with SMTP id _____8BxPOJxG5BoSxY4AQ--.4369S3;
 Mon, 04 Aug 2025 10:31:13 +0800 (CST)
Received: from localhost (unknown [223.64.120.241])
 by front1 (Coremail) with SMTP id qMiowJDx_8NuG5BoZuQ0AA--.63472S2;
 Mon, 04 Aug 2025 10:31:12 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: gaosong <gaosong@loongson.cn>,
	bibo mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, WANG Rui <wangrui@loongson.cn>,
 Zhou Qiankang <wszqkzqk@qq.com>
Subject: [PATCH] target/loongarch: Fix [X]VLDI raising exception incorrectly
Date: Mon,  4 Aug 2025 10:32:06 +0800
Message-ID: <20250804023206.1306413-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NuG5BoZuQ0AA--.63472S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr18AF17Jw4DuF1rGw18tFc_yoW8GF45pr
 4akryUKrW8tFWfZF90yw4jyF15G3yftw4IgFn3t3Z3AFZxJrs5tr4FqFZFyFy3GFWDXr1j
 vF4FywnxWa12vacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
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

According to the specification, [X]VLDI should trigger an invalid instruction
exception only when Bit[12] is 1 and Bit[11:8] > 12. This patch fixes an issue
where an exception was incorrectly raised even when Bit[12] was 0.

Test case:

```
    .global main
main:
    vldi    $vr0, 3328
    ret
```

Reported-by: Zhou Qiankang <wszqkzqk@qq.com>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 78730029cb..ee10a9ebe1 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3585,11 +3585,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     int sel, vece;
     uint64_t value;
 
-    if (!check_valid_vldi_mode(a)) {
-        generate_exception(ctx, EXCCODE_INE);
-        return true;
-    }
-
     if (!check_vec(ctx, oprsz)) {
         return true;
     }
@@ -3597,6 +3592,11 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     sel = (a->imm >> 12) & 0x1;
 
     if (sel) {
+        if (!check_valid_vldi_mode(a)) {
+            generate_exception(ctx, EXCCODE_INE);
+            return true;
+        }
+
         value = vldi_get_value(ctx, a->imm);
         vece = MO_64;
     } else {
-- 
2.50.1


