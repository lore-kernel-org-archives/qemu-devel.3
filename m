Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD61BC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lNY-0008Ko-MI; Mon, 07 Sep 2026 22:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x3lNT-0008KC-Fg; Mon, 07 Sep 2026 22:16:03 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x3lNQ-00034O-Fr; Mon, 07 Sep 2026 22:16:03 -0400
Received: from [192.168.144.1] (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowACneu7Vb59qVCxsBw--.59943S6;
 Tue, 08 Sep 2026 10:15:50 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,    qemu-riscv@nongnu.org
Subject: [PATCH v2 4/5] target/riscv: prioritize Zicfilp checks for misaligned
 JALR
Date: Tue, 08 Sep 2026 10:15:50 +0800
Message-ID: <20260908101550.v2-wangyang25@otcaix.iscas.ac.cn-5>
In-Reply-To: <20260908101550.v2-wangyang25@otcaix.iscas.ac.cn-1>
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
 <20260908101550.v2-wangyang25@otcaix.iscas.ac.cn-1>
X-Mailer: git-send-email 2.55.0.windows.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CM-TRANSID: qwCowACneu7Vb59qVCxsBw--.59943S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4UWF17Zr1fWF4DJryDtrb_yoW8XF4fpF
 40krWUKrW5tFZ5ZF4IqF4UtF43Xa1fWa10qws2q3Z5tF4Yyry3tF1qkryagF1UCF4kWr12
 9FWqy3W5WFWUJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
 AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0E
 x4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
 0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
 6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
 C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
 JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
 WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
 CTnIWIevJa73UjIFyTuYvjxUg9jbDUUUU
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

When Zicfilp tracking is active, a misaligned indirect JALR target also
violates the landing-pad requirement. Generate the landing-pad
software-check before the generic instruction-address-misaligned
exception for tracked targets, while retaining the existing exception
for untracked targets.

Tested: RV64 M-mode and S-mode Zicfilp controls and misaligned
targets with c=true and c=false.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4415

Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index cc1b5dbbad..aa79a5ef3c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -187,7 +187,14 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 
     if (misaligned) {
         gen_set_label(misaligned);
-        gen_exception_inst_addr_mis(ctx, target_pc);
+        if (ctx->fcfi_enabled &&
+            a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                            tcg_env, offsetof(CPURISCVState, sw_check_code));
+            generate_exception(ctx, RISCV_EXCP_SW_CHECK);
+        } else {
+            gen_exception_inst_addr_mis(ctx, target_pc);
+        }
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 
-- 
2.55.0.windows.2


