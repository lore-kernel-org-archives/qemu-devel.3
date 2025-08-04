Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847C5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 14:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwKP-0005Yc-2k; Mon, 04 Aug 2025 10:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uiv7M-00069n-Ob
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:20:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uiv7J-000625-7A
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:20:44 -0400
Received: from loongson.cn (unknown [223.64.120.241])
 by gateway (Coremail) with SMTP id _____8BxJHChs5Bo3Vg4AQ--.4905S3;
 Mon, 04 Aug 2025 21:20:34 +0800 (CST)
Received: from localhost (unknown [223.64.120.241])
 by front1 (Coremail) with SMTP id qMiowJDxQ+Sbs5BoOZg1AA--.1786S2;
 Mon, 04 Aug 2025 21:20:32 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: gaosong <gaosong@loongson.cn>,
	bibo mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, WANG Rui <wangrui@loongson.cn>,
 Zhou Qiankang <wszqkzqk@qq.com>
Subject: [PATCH v2] target/loongarch: Fix [X]VLDI raising exception incorrectly
Date: Mon,  4 Aug 2025 21:22:12 +0800
Message-ID: <20250804132212.4816-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+Sbs5BoOZg1AA--.1786S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr18AF17Jw4DuFWUZFyrAFc_yoW8GF15pr
 4akrWUKrWrJFZ3ZFyYvw4jyr15G395tw4IgFn3t3Z3Aa9xtryvqr40qFW2vFyUCFyDXr1j
 vF4Fvw1Yqa17ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
 AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
 6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
 AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
 2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
 C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
 nUUI43ZEXa7IU8hiSPUUUUU==
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
v1 -> v2:
- Keep the INE exception prioritized over the [A]SXD.
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 78730029cb..38bccf2838 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3585,7 +3585,9 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     int sel, vece;
     uint64_t value;
 
-    if (!check_valid_vldi_mode(a)) {
+    sel = (a->imm >> 12) & 0x1;
+
+    if (sel && !check_valid_vldi_mode(a)) {
         generate_exception(ctx, EXCCODE_INE);
         return true;
     }
@@ -3594,8 +3596,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
         return true;
     }
 
-    sel = (a->imm >> 12) & 0x1;
-
     if (sel) {
         value = vldi_get_value(ctx, a->imm);
         vece = MO_64;
-- 
2.50.1


