Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10CCC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50Kp-00047t-SA; Fri, 11 Sep 2026 08:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Kl-000434-Sv; Fri, 11 Sep 2026 08:26:24 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Ki-0006CU-PU; Fri, 11 Sep 2026 08:26:23 -0400
Received: from [172.21.96.1] (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowABHtD5k86NqyHDqBw--.17498S4;
 Fri, 11 Sep 2026 20:26:13 +0800 (CST)
Message-ID: <b4423cb873e80241a40b02bdc2ecf45451df1860.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
In-Reply-To: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
References: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
Date: Fri, 11 Sep 2026 19:07:51 +0800
Subject: [PATCH v4 2/5] target/riscv: decode RV32 XTheadBb th.srri shift amount
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org
X-CM-TRANSID: zQCowABHtD5k86NqyHDqBw--.17498S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5Xr4rKw43WFy3Zr45Awb_yoW8Kr17pa
 10k34UCFs5Wryavr97tw45JF15GFs3ZayUt3WSqwn3WFW5XFWUJ34xtrW7KrW3ZrWkXrWj
 kF48Ar98trZ5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
 xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
 87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2
 AFwI0_Jw0_GFylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU0_nYUUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

The XTheadBb th.srri instruction uses the low log2(XLEN) bits of
imm6. The generic shift helper rejects values greater than or equal to
XLEN, which incorrectly rejects imm6 values 32 through 63 on RV32.
Decode the RV32 form with a five-bit shift field so the shared helper
receives the width-correct operand.

Tested: RV32 imm6 0, 31, 32, and 63 test cases with XTheadBb
enabled and disabled; RV64 imm6 63 with XTheadBb enabled and
disabled.
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4413
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
---
 target/riscv/tcg/insn_trans/trans_xthead.c.inc | 8 ++++++++
 target/riscv/xthead.decode                     | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
index 681f70e5bc..d47b5a85c6 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -145,6 +145,14 @@ static bool trans_th_srri(DisasContext *ctx, arg_th_srri * a)
                                    tcg_gen_rotri_tl, gen_roriw, NULL);
 }
 
+static bool trans_th_srri_rv32(DisasContext *ctx, arg_th_srri_rv32 *a)
+{
+    REQUIRE_XTHEADBB(ctx);
+    REQUIRE_32BIT(ctx);
+    return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
+                                   tcg_gen_rotri_tl, gen_roriw, NULL);
+}
+
 /* th.srriw is an alternate encoding for roriw (from Zbb) */
 static bool trans_th_srriw(DisasContext *ctx, arg_th_srriw *a)
 {
diff --git a/target/riscv/xthead.decode b/target/riscv/xthead.decode
index d1d104bcf2..33995168c4 100644
--- a/target/riscv/xthead.decode
+++ b/target/riscv/xthead.decode
@@ -64,7 +64,10 @@ th_ext           ...... ...... ..... 010 ..... 0001011 @th_bfext
 th_extu          ...... ...... ..... 011 ..... 0001011 @th_bfext
 th_ff0           1000010 00000 ..... 001 ..... 0001011 @r2
 th_ff1           1000011 00000 ..... 001 ..... 0001011 @r2
-th_srri          000100 ...... ..... 001 ..... 0001011 @sh6
+{
+  th_srri_rv32  000100 -..... ..... 001 ..... 0001011 @sh5
+  th_srri       000100 ...... ..... 001 ..... 0001011 @sh6
+}
 th_srriw         0001010 ..... ..... 001 ..... 0001011 @sh5
 th_rev           1000001 00000 ..... 001 ..... 0001011 @r2
 th_revw          1001000 00000 ..... 001 ..... 0001011 @r2
-- 
2.55.0.windows.2


