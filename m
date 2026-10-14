Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A266BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH1rh-0000Ef-0B; Wed, 14 Oct 2026 12:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rL-00006M-Gs; Wed, 14 Oct 2026 12:29:45 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rH-00069F-95; Wed, 14 Oct 2026 12:29:41 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACXmDbrrc9q4kXBCg--.37629S8;
 Thu, 15 Oct 2026 00:29:33 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 christoph.muellner@vrull.eu
Subject: [PATCH v5 4/5] target/riscv: prioritize Zicfilp checks for misaligned
 JALR
Date: Thu, 15 Oct 2026 00:29:29 +0800
Message-ID: <20261014162930.251-5-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261014162930.251-1-wangyang25@otcaix.iscas.ac.cn>
References: <20261014162930.251-1-wangyang25@otcaix.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmDbrrc9q4kXBCg--.37629S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4UWF17Zr1fWF4DJryDtrb_yoW8Wryrpr
 40k3yUKrZ8tF95ZF4SqF4UtF43Xa1fWa10qws2q3Z5tF4YyrW3tF1qkryagFyUAF4kur1a
 9FWqya45WFWUJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20x
 vEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj
 6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7
 CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
 6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
 C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
 Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
 cSsGvfC2KfnxnUUI43ZEXa7IUYnAwDUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


