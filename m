Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6379C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jrV-0005pr-8z; Wed, 16 Sep 2026 03:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqy-0005bK-7c; Wed, 16 Sep 2026 03:14:48 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqr-0000zV-UP; Wed, 16 Sep 2026 03:14:48 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S19;
 Wed, 16 Sep 2026 15:08:05 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 17/19] target/riscv: Add packed SIMD RV32 only instructions
Date: Wed, 16 Sep 2026 07:07:19 +0000
Message-Id: <20260916070721.3279229-18-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S19
X-Coremail-Antispam: 1UD129KBjvAXoWDCw4DtFykWF1ruw15Kw4rKrg_yoW7uw17Co
 WrCw15Zrn7G348X34akw4UZFyUZrZ2vwn3KrW5Zr47Za93Jr9rGr1DJ34rZa48Zry5tFWf
 JrZ3Gwn8trnIgw1Dn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO97AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoBTYUUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Implement RV32-only register-pair operations.  Cover widening
arithmetic, shifts, multiplication and multiply-accumulate operations,
double-register equivalents of packed operations, horizontal
reductions, element rearrangement, comparisons, and narrowing shift and
clipping operations. Add the associated decode entries, translators and helpers.

These instructions represent 64-bit operands or results using even-odd
pairs of 32-bit registers.  The helpers combine source register pairs
before performing each operation and split results when writing a
destination pair.  A zero register-pair selector supplies a zero source
or suppresses the destination write as defined by the specification.
Saturating and clipping variants clamp out-of-range results and set
vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       | 131 ++++++
 target/riscv/insn32.decode                  | 285 +++++++++++-
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 488 ++++++++++++++++++++
 target/riscv/tcg/psimd_helper.c             | 273 +++++++++++
 4 files changed, 1176 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9a75a13d06d..1feddeb1d65 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1755,3 +1755,134 @@ DEF_HELPER_3(pm4addu_h, i64, env, i64, i64)
 DEF_HELPER_4(pm4adda_h, i64, env, i64, i64, i64)
 DEF_HELPER_4(pm4addasu_h, i64, env, i64, i64, i64)
 DEF_HELPER_4(pm4addau_h, i64, env, i64, i64, i64)
+
+/* Packed SIMD - Double-Width Operations (RV32 only, register pairs) */
+DEF_HELPER_3(pwadd_b, i64, env, i32, i32)
+DEF_HELPER_4(pwadda_b, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwaddu_b, i64, env, i32, i32)
+DEF_HELPER_4(pwaddau_b, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwsub_b, i64, env, i32, i32)
+DEF_HELPER_4(pwsuba_b, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwsubu_b, i64, env, i32, i32)
+DEF_HELPER_4(pwsubau_b, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwslli_b, i64, env, i32, i32)
+DEF_HELPER_3(pwsll_bs, i64, env, i32, i32)
+DEF_HELPER_3(pwslai_b, i64, env, i32, i32)
+DEF_HELPER_3(pwsla_bs, i64, env, i32, i32)
+
+DEF_HELPER_3(pwadd_h, i64, env, i32, i32)
+DEF_HELPER_4(pwadda_h, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwaddu_h, i64, env, i32, i32)
+DEF_HELPER_4(pwaddau_h, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwsub_h, i64, env, i32, i32)
+DEF_HELPER_4(pwsuba_h, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwsubu_h, i64, env, i32, i32)
+DEF_HELPER_4(pwsubau_h, i64, env, i32, i32, i64)
+DEF_HELPER_3(pwslli_h, i64, env, i32, i32)
+DEF_HELPER_3(pwsll_hs, i64, env, i32, i32)
+DEF_HELPER_3(pwslai_h, i64, env, i32, i32)
+DEF_HELPER_3(pwsla_hs, i64, env, i32, i32)
+
+DEF_HELPER_3(wadd, i64, env, i32, i32)
+DEF_HELPER_4(wadda, i64, env, i32, i32, i64)
+DEF_HELPER_3(waddu, i64, env, i32, i32)
+DEF_HELPER_4(waddau, i64, env, i32, i32, i64)
+DEF_HELPER_3(wsub, i64, env, i32, i32)
+DEF_HELPER_4(wsuba, i64, env, i32, i32, i64)
+DEF_HELPER_3(wsubu, i64, env, i32, i32)
+DEF_HELPER_4(wsubau, i64, env, i32, i32, i64)
+DEF_HELPER_3(wslli, i64, env, i32, i32)
+DEF_HELPER_3(wsll, i64, env, i32, i32)
+DEF_HELPER_3(wslai, i64, env, i32, i32)
+DEF_HELPER_3(wsla, i64, env, i32, i32)
+
+DEF_HELPER_3(wzip8p, i64, env, i32, i32)
+DEF_HELPER_3(wzip16p, i64, env, i32, i32)
+
+DEF_HELPER_4(predsum_dbs, i32, env, i32, i32, i32)
+DEF_HELPER_4(predsumu_dbs, i32, env, i32, i32, i32)
+DEF_HELPER_4(predsum_dhs, i32, env, i32, i32, i32)
+DEF_HELPER_4(predsumu_dhs, i32, env, i32, i32, i32)
+
+DEF_HELPER_3(pnsrli_b, i32, env, i64, i32)
+DEF_HELPER_3(pnsrai_b, i32, env, i64, i32)
+DEF_HELPER_3(pnsrari_b, i32, env, i64, i32)
+DEF_HELPER_3(pnclipi_b, i32, env, i64, i32)
+DEF_HELPER_3(pnclipri_b, i32, env, i64, i32)
+DEF_HELPER_3(pnclipiu_b, i32, env, i64, i32)
+DEF_HELPER_3(pnclipriu_b, i32, env, i64, i32)
+DEF_HELPER_3(pnsrl_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnsra_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnsrar_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnclip_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipr_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipu_bs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipru_bs, i32, env, i64, i32)
+
+DEF_HELPER_3(pnsrli_h, i32, env, i64, i32)
+DEF_HELPER_3(pnsrai_h, i32, env, i64, i32)
+DEF_HELPER_3(pnsrari_h, i32, env, i64, i32)
+DEF_HELPER_3(pnclipi_h, i32, env, i64, i32)
+DEF_HELPER_3(pnclipri_h, i32, env, i64, i32)
+DEF_HELPER_3(pnclipiu_h, i32, env, i64, i32)
+DEF_HELPER_3(pnclipriu_h, i32, env, i64, i32)
+DEF_HELPER_3(pnsrl_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnsra_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnsrar_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnclip_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipr_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipu_hs, i32, env, i64, i32)
+DEF_HELPER_3(pnclipru_hs, i32, env, i64, i32)
+
+DEF_HELPER_3(nsrli, i32, env, i64, i32)
+DEF_HELPER_3(nsrai, i32, env, i64, i32)
+DEF_HELPER_3(nsrari, i32, env, i64, i32)
+DEF_HELPER_3(nclipi, i32, env, i64, i32)
+DEF_HELPER_3(nclipri, i32, env, i64, i32)
+DEF_HELPER_3(nclipiu, i32, env, i64, i32)
+DEF_HELPER_3(nclipriu, i32, env, i64, i32)
+DEF_HELPER_3(nsrl, i32, env, i64, i32)
+DEF_HELPER_3(nsra, i32, env, i64, i32)
+DEF_HELPER_3(nsrar, i32, env, i64, i32)
+DEF_HELPER_3(nclip, i32, env, i64, i32)
+DEF_HELPER_3(nclipr, i32, env, i64, i32)
+DEF_HELPER_3(nclipu, i32, env, i64, i32)
+DEF_HELPER_3(nclipru, i32, env, i64, i32)
+
+DEF_HELPER_4(pmqwacc_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pmqrwacc_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(mqwacc, i64, env, i32, i32, i64)
+DEF_HELPER_4(mqrwacc, i64, env, i32, i32, i64)
+
+DEF_HELPER_3(pwmul_b, i64, env, i32, i32)
+DEF_HELPER_3(pwmulsu_b, i64, env, i32, i32)
+DEF_HELPER_3(pwmulu_b, i64, env, i32, i32)
+DEF_HELPER_3(pwmul_h, i64, env, i32, i32)
+DEF_HELPER_3(pwmulsu_h, i64, env, i32, i32)
+DEF_HELPER_3(pwmulu_h, i64, env, i32, i32)
+
+DEF_HELPER_4(pwmacc_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pwmaccsu_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pwmaccu_h, i64, env, i32, i32, i64)
+
+DEF_HELPER_3(wmul, i64, env, i32, i32)
+DEF_HELPER_3(wmulsu, i64, env, i32, i32)
+DEF_HELPER_3(wmulu, i64, env, i32, i32)
+
+DEF_HELPER_4(wmacc, i64, env, i32, i32, i64)
+DEF_HELPER_4(wmaccsu, i64, env, i32, i32, i64)
+DEF_HELPER_4(wmaccu, i64, env, i32, i32, i64)
+
+DEF_HELPER_3(pm2wadd_h, i64, env, i32, i32)
+DEF_HELPER_3(pm2waddsu_h, i64, env, i32, i32)
+DEF_HELPER_3(pm2waddu_h, i64, env, i32, i32)
+DEF_HELPER_3(pm2wadd_hx, i64, env, i32, i32)
+DEF_HELPER_4(pm2wadda_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pm2waddasu_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pm2waddau_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pm2wadda_hx, i64, env, i32, i32, i64)
+
+DEF_HELPER_3(pm2wsub_h, i64, env, i32, i32)
+DEF_HELPER_3(pm2wsub_hx, i64, env, i32, i32)
+DEF_HELPER_4(pm2wsuba_h, i64, env, i32, i32, i64)
+DEF_HELPER_4(pm2wsuba_hx, i64, env, i32, i32, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b7651bdcba3..9aabc45d5ca 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -23,6 +23,9 @@
 %rd        7:5
 %sh5       20:5
 %sh6       20:6
+%rs2_p     21:4
+%rs1_p     16:4
+%rd_p      8:4
 
 %sh7    20:7
 %csr    20:12
@@ -57,7 +60,6 @@
 &r    rd rs1 rs2
 &r2   rd rs1
 &r2_s rs1 rs2
-&p_l  imm rd
 &s    imm rs1 rs2
 &u    imm rd
 &shift     shamt rs1 rd
@@ -69,6 +71,7 @@
 &k_aes     shamt rs2 rs1 rd
 &mop5 imm rd rs1
 &mop3 imm rd rs1 rs2
+&p_l  imm rd
 &p_ui imm rs1 rd
 
 # Formats 32:
@@ -102,6 +105,11 @@
 @r2_zimm11 . zimm:11  ..... ... ..... ....... %rs1 %rd
 @r2_zimm10 .. zimm:10  ..... ... ..... ....... %rs1 %rd
 @r2_s    .......   ..... ..... ... ..... ....... %rs2 %rs1
+@r_p_1       .......   ..... ..... ... ..... ....... &r    %rs2 %rs1 rd=%rd_p
+@r_p_2     .......   ..... ..... ... ..... ....... &r    rs2=%rs2_p rs1=%rs1_p rd=%rd_p
+@r_p_3     .......   ..... ..... ... ..... ....... &r    %rs2 rs1=%rs1_p rd=%rd_p
+@r_p_4     .......   ..... ..... ... ..... ....... &r    %rs2 rs1=%rs1_p %rd
+@r2_p      .......   ..... ..... ... ..... ....... &r2   rs1=%rs1_p rd=%rd_p
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @hfence_vvma ....... ..... .....   ... ..... ....... %rs2 %rs1
@@ -123,6 +131,18 @@
 @p_l2  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l2         %rd
 @p_l3  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l3         %rd
 @p_l4  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l4         %rd
+@p_l1_p  ........ ........ .... ..... ....... &p_l    imm=%imm_p_l1         rd=%rd_p
+@p_l2_p  ........ ........ .... ..... ....... &p_l    imm=%imm_p_l2         rd=%rd_p
+@p_l3_p  ....... .......... ... ..... ....... &p_l    imm=%imm_p_l3         rd=%rd_p
+@p_ui8_p ..... .... ... ..... ... ..... .......  &i imm=%imm_p_ui8 rs1=%rs1_p rd=%rd_p
+@p_ui16_p ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui16 %rs1 rd=%rd_p
+@p_ui16_p_2 ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui16 rs1=%rs1_p rd=%rd_p
+@p_ui16_p_3 ..... .... ... .... .... ..... ....... &p_ui imm=%imm_p_ui16 rs1=%rs1_p %rd
+@p_ui32_p ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui32 %rs1 rd=%rd_p
+@p_ui32_p_2 ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui32 rs1=%rs1_p rd=%rd_p
+@p_ui32_p_3 ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui32 rs1=%rs1_p %rd
+@p_ui64_p ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui64 %rs1 rd=%rd_p
+@p_ui64_p_2 ..... .... ... ..... ... ..... ....... &p_ui imm=%imm_p_ui64 rs1=%rs1_p %rd
 
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
@@ -1633,3 +1653,266 @@ pli_h    1011000 .......... 010 ..... 0011011 @p_l2
 plui_h   1111000 .......... 010 ..... 0011011 @p_l3
 pli_w    1011001 ..... ..... 010 ..... 0011011 @p_l2
 plui_w   1111001 ..... ..... 010 ..... 0011011 @p_l4
+
+# Packed SIMD - Double-Width Operations (RV32 only, register pairs)
+# register-pair destination
+pwadd_b    0000010 ..... ..... 010 .... 10011011 @r_p_1
+pwadda_b   0000110 ..... ..... 010 .... 10011011 @r_p_1
+pwaddu_b   0001010 ..... ..... 010 .... 10011011 @r_p_1
+pwaddau_b  0001110 ..... ..... 010 .... 10011011 @r_p_1
+pwsub_b    0100010 ..... ..... 010 .... 10011011 @r_p_1
+pwsuba_b   0100110 ..... ..... 010 .... 10011011 @r_p_1
+pwsubu_b   0101010 ..... ..... 010 .... 10011011 @r_p_1
+pwsubau_b  0101110 ..... ..... 010 .... 10011011 @r_p_1
+pwslli_b   00000 001.... ..... 010 .... 00011011 @p_ui16_p
+pwsll_bs   0000100 ..... ..... 010 .... 00011011 @r_p_1
+pwslai_b   01000 001.... ..... 010 .... 00011011 @p_ui16_p
+pwsla_bs   0100100 ..... ..... 010 .... 00011011 @r_p_1
+
+pwadd_h    0000000 ..... ..... 010 .... 10011011 @r_p_1
+pwadda_h   0000100 ..... ..... 010 .... 10011011 @r_p_1
+pwaddu_h   0001000 ..... ..... 010 .... 10011011 @r_p_1
+pwaddau_h  0001100 ..... ..... 010 .... 10011011 @r_p_1
+pwsub_h    0100000 ..... ..... 010 .... 10011011 @r_p_1
+pwsuba_h   0100100 ..... ..... 010 .... 10011011 @r_p_1
+pwsubu_h   0101000 ..... ..... 010 .... 10011011 @r_p_1
+pwsubau_h  0101100 ..... ..... 010 .... 10011011 @r_p_1
+pwslli_h   00000 01..... ..... 010 .... 00011011 @p_ui32_p
+pwsll_hs   0000101 ..... ..... 010 .... 00011011 @r_p_1
+pwslai_h   01000 01..... ..... 010 .... 00011011 @p_ui32_p
+pwsla_hs   0100101 ..... ..... 010 .... 00011011 @r_p_1
+
+wadd    0000001 ..... ..... 010 .... 10011011 @r_p_1
+wadda   0000101 ..... ..... 010 .... 10011011 @r_p_1
+waddu   0001001 ..... ..... 010 .... 10011011 @r_p_1
+waddau  0001101 ..... ..... 010 .... 10011011 @r_p_1
+wsub    0100001 ..... ..... 010 .... 10011011 @r_p_1
+wsuba   0100101 ..... ..... 010 .... 10011011 @r_p_1
+wsubu   0101001 ..... ..... 010 .... 10011011 @r_p_1
+wsubau  0101101 ..... ..... 010 .... 10011011 @r_p_1
+wslli   00000 1...... ..... 010 .... 00011011 @p_ui64_p
+wsll    0000111 ..... ..... 010 .... 00011011 @r_p_1
+wslai   01000 1...... ..... 010 .... 00011011 @p_ui64_p
+wsla    0100111 ..... ..... 010 .... 00011011 @r_p_1
+
+wzip8p    0111100 ..... ..... 010 .... 00011011 @r_p_1
+wzip16p   0111101 ..... ..... 010 .... 00011011 @r_p_1
+
+#register-pair operands
+pli_db    00110100 ........ 0010 .... 00011011 @p_l1_p
+padd_db   1000010 .... 0 .... 0110 .... 00011011 @r_p_2
+psub_db   1100010 .... 0 .... 0110 .... 00011011 @r_p_2
+psadd_db  1001010 .... 0 .... 0110 .... 00011011 @r_p_2
+psaddu_db    1011010 .... 0 .... 0110 .... 00011011 @r_p_2
+pssub_db     1101010 .... 0 .... 0110 .... 00011011 @r_p_2
+pssubu_db    1111010 .... 0 .... 0110 .... 00011011 @r_p_2
+paadd_db     1001110 .... 0 .... 0110 .... 00011011 @r_p_2
+paaddu_db    1011110 .... 0 .... 0110 .... 00011011 @r_p_2
+pasub_db     1101110 .... 0 .... 0110 .... 00011011 @r_p_2
+pasubu_db    1111110 .... 0 .... 0110 .... 00011011 @r_p_2
+pabd_db      1100110 .... 0 .... 0110 .... 00011011 @r_p_2
+pabdu_db     1110110 .... 0 .... 0110 .... 00011011 @r_p_2
+psabs_db     0110010 00111 .... 0110 .... 00011011 @r2_p
+pli_dh    0011000 .......... 010 .... 00011011 @p_l2_p
+plui_dh   0111000 .......... 010 .... 00011011 @p_l3_p
+padd_dh   1000000 .... 0 .... 0110 .... 00011011 @r_p_2
+psub_dh   1100000 .... 0 .... 0110 .... 00011011 @r_p_2
+psadd_dh  1001000 .... 0 .... 0110 .... 00011011 @r_p_2
+psaddu_dh 1011000 .... 0 .... 0110 .... 00011011 @r_p_2
+pssub_dh  1101000 .... 0 .... 0110 .... 00011011 @r_p_2
+pssubu_dh 1111000 .... 0 .... 0110 .... 00011011 @r_p_2
+paadd_dh  1001100 .... 0 .... 0110 .... 00011011 @r_p_2
+paaddu_dh 1011100 .... 0 .... 0110 .... 00011011 @r_p_2
+pasub_dh  1101100 .... 0 .... 0110 .... 00011011 @r_p_2
+pasubu_dh    1111100 .... 0 .... 0110 .... 00011011 @r_p_2
+psh1add_dh   1010000 .... 1 .... 0110 .... 00011011 @r_p_2
+pssh1sadd_dh 1011000 .... 1 .... 0110 .... 00011011 @r_p_2
+pas_dhx    1000000 .... 1 .... 1110 .... 00011011 @r_p_2
+psa_dhx    1000010 .... 1 .... 1110 .... 00011011 @r_p_2
+psas_dhx   1001000 .... 1 .... 1110 .... 00011011 @r_p_2
+pssa_dhx   1001010 .... 1 .... 1110 .... 00011011 @r_p_2
+paas_dhx   1001100 .... 1 .... 1110 .... 00011011 @r_p_2
+pasa_dhx   1001110 .... 1 .... 1110 .... 00011011 @r_p_2
+pabd_dh    1100100 .... 0 .... 0110 .... 00011011 @r_p_2
+pabdu_dh   1110100 .... 0 .... 0110 .... 00011011 @r_p_2
+psabs_dh   0110000 00111 .... 0110 .... 00011011 @r2_p
+padd_dw    1000001 .... 0 .... 0110 .... 00011011 @r_p_2
+psub_dw    1100001 .... 0 .... 0110 .... 00011011 @r_p_2
+psadd_dw   1001001 .... 0 .... 0110 .... 00011011 @r_p_2
+psaddu_dw  1011001 .... 0 .... 0110 .... 00011011 @r_p_2
+pssub_dw   1101001 .... 0 .... 0110 .... 00011011 @r_p_2
+pssubu_dw  1111001 .... 0 .... 0110 .... 00011011 @r_p_2
+paadd_dw   1001101 .... 0 .... 0110 .... 00011011 @r_p_2
+paaddu_dw  1011101 .... 0 .... 0110 .... 00011011 @r_p_2
+pasub_dw   1101101 .... 0 .... 0110 .... 00011011 @r_p_2
+pasubu_dw  1111101 .... 0 .... 0110 .... 00011011 @r_p_2
+psh1add_dw 1010001 .... 1 .... 0110 .... 00011011 @r_p_2
+pssh1sadd_dw  1011001 .... 1 .... 0110 .... 00011011 @r_p_2
+addd_p    1000011 .... 0 .... 0110 .... 00011011 @r_p_2
+subd_p    1100011 .... 0 .... 0110 .... 00011011 @r_p_2
+
+# register-pair first source only
+predsum_dbs    0001110 ..... .... 0100 ..... 0011011 @r_p_4
+predsumu_dbs   0011110 ..... .... 0100 ..... 0011011 @r_p_4
+predsum_dhs    0001100 ..... .... 0100 ..... 0011011 @r_p_4
+predsumu_dhs   0011100 ..... .... 0100 ..... 0011011 @r_p_4
+
+# register-pair operands
+pslli_db    00000 0001... .... 0110 .... 00011011 @p_ui8_p
+psrli_db    00000 0001... .... 1110 .... 00011011 @p_ui8_p
+psrai_db    01000 0001... .... 1110 .... 00011011 @p_ui8_p
+pmin_db     1110010 .... 1 .... 1110 .... 00011011 @r_p_2
+pminu_db    1110110 .... 1 .... 1110 .... 00011011 @r_p_2
+pmax_db     1111010 .... 1 .... 1110 .... 00011011 @r_p_2
+pmaxu_db    1111110 .... 1 .... 1110 .... 00011011 @r_p_2
+pmseq_db    1100010 .... 1 .... 1110 .... 00011011 @r_p_2
+pmslt_db    1101010 .... 1 .... 1110 .... 00011011 @r_p_2
+pmsltu_db   1101110 .... 1 .... 1110 .... 00011011 @r_p_2
+psext_dh_b  0110000 00100 .... 0110 .... 00011011 @r2_p
+psati_dh    01100 001.... .... 1110 .... 00011011 @p_ui16_p_2
+pusati_dh   00100 001.... .... 1110 .... 00011011 @p_ui16_p_2
+pslli_dh    00000 001.... .... 0110 .... 00011011 @p_ui16_p_2
+psrli_dh    00000 001.... .... 1110 .... 00011011 @p_ui16_p_2
+psrai_dh    01000 001.... .... 1110 .... 00011011 @p_ui16_p_2
+psslai_dh   01010 001.... .... 0110 .... 00011011 @p_ui16_p_2
+psrari_dh   01010 001.... .... 1110 .... 00011011 @p_ui16_p_2
+pmin_dh     1110000 .... 1 .... 1110 .... 00011011 @r_p_2
+pminu_dh    1110100 .... 1 .... 1110 .... 00011011 @r_p_2
+pmax_dh     1111000 .... 1 .... 1110 .... 00011011 @r_p_2
+pmaxu_dh    1111100 .... 1 .... 1110 .... 00011011 @r_p_2
+pmseq_dh    1100000 .... 1 .... 1110 .... 00011011 @r_p_2
+pmslt_dh    1101000 .... 1 .... 1110 .... 00011011 @r_p_2
+pmsltu_dh   1101100 .... 1 .... 1110 .... 00011011 @r_p_2
+psext_dw_b  0110001 00100 .... 0110 .... 00011011 @r2_p
+psext_dw_h  0110001 00101 .... 0110 .... 00011011 @r2_p
+psati_dw    01100 01..... .... 1110 .... 00011011 @p_ui32_p_2
+pusati_dw   00100 01..... .... 1110 .... 00011011 @p_ui32_p_2
+pslli_dw    00000 01..... .... 0110 .... 00011011 @p_ui32_p_2
+psrli_dw    00000 01..... .... 1110 .... 00011011 @p_ui32_p_2
+psrai_dw    01000 01..... .... 1110 .... 00011011 @p_ui32_p_2
+psslai_dw   01010 01..... .... 0110 .... 00011011 @p_ui32_p_2
+psrari_dw   01010 01..... .... 1110 .... 00011011 @p_ui32_p_2
+pmin_dw    1110001 .... 1 .... 1110 .... 00011011 @r_p_2
+pminu_dw   1110101 .... 1 .... 1110 .... 00011011 @r_p_2
+pmax_dw    1111001 .... 1 .... 1110 .... 00011011 @r_p_2
+pmaxu_dw   1111101 .... 1 .... 1110 .... 00011011 @r_p_2
+pmseq_dw    1100001 .... 1 .... 1110 .... 00011011 @r_p_2
+pmslt_dw    1101001 .... 1 .... 1110 .... 00011011 @r_p_2
+pmsltu_dw   1101101 .... 1 .... 1110 .... 00011011 @r_p_2
+
+# register-pair first source and dest
+padd_dbs    0001110 ..... .... 0110 .... 00011011 @r_p_3
+psll_dbs    0000110 ..... .... 0110 .... 00011011 @r_p_3
+psrl_dbs    0000110 ..... .... 1110 .... 00011011 @r_p_3
+psra_dbs    0100110 ..... .... 1110 .... 00011011 @r_p_3
+padd_dhs    0001100 ..... .... 0110 .... 00011011 @r_p_3
+psll_dhs    0000100 ..... .... 0110 .... 00011011 @r_p_3
+psrl_dhs    0000100 ..... .... 1110 .... 00011011 @r_p_3
+psra_dhs    0100100 ..... .... 1110 .... 00011011 @r_p_3
+pssha_dhs   0110100 ..... .... 0110 .... 00011011 @r_p_3
+psshar_dhs  0111100 ..... .... 0110 .... 00011011 @r_p_3
+psshl_dhs   0010100 ..... .... 0110 .... 00011011 @r_p_3
+psshlr_dhs  0011100 ..... .... 0110 .... 00011011 @r_p_3
+padd_dws    0001101 ..... .... 0110 .... 00011011 @r_p_3
+psll_dws    0000101 ..... .... 0110 .... 00011011 @r_p_3
+psrl_dws    0000101 ..... .... 1110 .... 00011011 @r_p_3
+psra_dws    0100101 ..... .... 1110 .... 00011011 @r_p_3
+pssha_dws   0110101 ..... .... 0110 .... 00011011 @r_p_3
+psshar_dws  0111101 ..... .... 0110 .... 00011011 @r_p_3
+psshl_dws   0010101 ..... .... 0110 .... 00011011 @r_p_3
+psshlr_dws  0011101 ..... .... 0110 .... 00011011 @r_p_3
+
+# register-pair operands
+ppaire_db    1000000 .... 0 .... 1110 .... 00011011 @r_p_2
+ppaireo_db  1001000 .... 0 .... 1110 .... 00011011 @r_p_2
+ppairoe_db  1010000 .... 0 .... 1110 .... 00011011 @r_p_2
+ppairo_db   1011000 .... 0 .... 1110 .... 00011011 @r_p_2
+ppaire_dh    1000001 .... 0 .... 1110 .... 00011011 @r_p_2
+ppaireo_dh  1001001 .... 0 .... 1110 .... 00011011 @r_p_2
+ppairoe_dh  1010001 .... 0 .... 1110 .... 00011011 @r_p_2
+ppairo_dh   1011001 .... 0 .... 1110 .... 00011011 @r_p_2
+
+#register-pair first source only
+pnsrli_b    00000 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnsrai_b    01000 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnsrari_b   01010 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnclipi_b   01100 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnclipri_b  01110 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnclipiu_b  00100 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnclipriu_b 00110 001.... .... 1100 ..... 0011011 @p_ui16_p_3
+pnsrl_bs    00001 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnsra_bs    01001 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnsrar_bs   01011 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnclip_bs   01101 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipr_bs  01111 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipu_bs  00101 00 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipru_bs 00111 00 ..... .... 1100 ..... 0011011 @r_p_4
+
+pnsrli_h    00000 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnsrai_h    01000 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnsrari_h   01010 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnclipi_h   01100 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnclipri_h  01110 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnclipiu_h  00100 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnclipriu_h 00110 01..... .... 1100 ..... 0011011 @p_ui32_p_3
+pnsrl_hs    00001 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnsra_hs    01001 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnsrar_hs   01011 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnclip_hs   01101 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipr_hs  01111 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipu_hs  00101 01 ..... .... 1100 ..... 0011011 @r_p_4
+pnclipru_hs 00111 01 ..... .... 1100 ..... 0011011 @r_p_4
+
+nsrli       00000 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nsrai       01000 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nsrari      01010 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nclipi      01100 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nclipri     01110 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nclipiu     00100 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nclipriu    00110 1...... .... 1100 ..... 0011011 @p_ui64_p_2
+nsrl        00001 11 ..... .... 1100 ..... 0011011 @r_p_4
+nsra        01001 11 ..... .... 1100 ..... 0011011 @r_p_4
+nsrar       01011 11 ..... .... 1100 ..... 0011011 @r_p_4
+nclip       01101 11 ..... .... 1100 ..... 0011011 @r_p_4
+nclipr      01111 11 ..... .... 1100 ..... 0011011 @r_p_4
+nclipu      00101 11 ..... .... 1100 ..... 0011011 @r_p_4
+nclipru     00111 11 ..... .... 1100 ..... 0011011 @r_p_4
+
+# register-pair multiply
+pmqwacc_h       01111 00 ..... ..... 010 .... 10011011 @r_p_1
+pmqrwacc_h      01111 10 ..... ..... 010 .... 10011011 @r_p_1
+mqwacc          01111 01 ..... ..... 010 .... 10011011 @r_p_1
+mqrwacc         01111 11 ..... ..... 010 .... 10011011 @r_p_1
+
+pwmul_b         00100 10 ..... ..... 010 .... 10011011 @r_p_1
+pwmulsu_b       01100 10 ..... ..... 010 .... 10011011 @r_p_1
+pwmulu_b        00110 10 ..... ..... 010 .... 10011011 @r_p_1
+
+pwmul_h         00100 00 ..... ..... 010 .... 10011011 @r_p_1
+pwmulsu_h       01100 00 ..... ..... 010 .... 10011011 @r_p_1
+pwmulu_h        00110 00 ..... ..... 010 .... 10011011 @r_p_1
+pwmacc_h        00101 00 ..... ..... 010 .... 10011011 @r_p_1
+pwmaccsu_h      01101 00 ..... ..... 010 .... 10011011 @r_p_1
+pwmaccu_h       00111 00 ..... ..... 010 .... 10011011 @r_p_1
+
+wmul            00100 01 ..... ..... 010 .... 10011011 @r_p_1
+wmulsu          01100 01 ..... ..... 010 .... 10011011 @r_p_1
+wmulu           00110 01 ..... ..... 010 .... 10011011 @r_p_1
+wmacc           00101 01 ..... ..... 010 .... 10011011 @r_p_1
+wmaccsu         01101 01 ..... ..... 010 .... 10011011 @r_p_1
+wmaccu          00111 01 ..... ..... 010 .... 10011011 @r_p_1
+
+pm2wadd_h       00000 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2waddsu_h     01100 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2waddu_h      00100 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2wadd_hx      00010 11 ..... ..... 010 .... 10011011 @r_p_1
+
+pm2wadda_h      00001 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2waddasu_h    01101 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2waddau_h     00101 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2wadda_hx     00011 11 ..... ..... 010 .... 10011011 @r_p_1
+
+pm2wsub_h       01000 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2wsub_hx      01010 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2wsuba_h      01001 11 ..... ..... 010 .... 10011011 @r_p_1
+pm2wsuba_hx     01011 11 ..... ..... 010 .... 10011011 @r_p_1
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index c172c8e4e0a..bec44e98f7c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -2,6 +2,50 @@
 /* RISC-V translation routines for the P Standard Extensions. */
 /* Copyright (c) 2026 ISRC ISCAS. */
 
+/*
+ * A zero register-pair selector denotes { x0, x0 }, rather than { x1, x0 }.
+ */
+static int pair_reg(int pair, bool high)
+{
+    return pair == 0 ? 0 : pair * 2 + high;
+}
+
+/* Save a 64 bit value in the register pair selected by pair. */
+static void set_pair_regs(DisasContext *ctx, int pair, TCGv_i64 src)
+{
+#if defined(TARGET_RISCV32)
+    if (pair == 0) {
+        return;
+    }
+
+    TCGv_i64 tl_64 = tcg_temp_new_i64();
+    TCGv_i64 th_64 = tcg_temp_new_i64();
+    TCGv_i32 tl_32 = tcg_temp_new_i32();
+    TCGv_i32 th_32 = tcg_temp_new_i32();
+    tcg_gen_extract_i64(tl_64, src, 0, 32);
+    tcg_gen_extract_i64(th_64, src, 32, 32);
+    tcg_gen_trunc_i64_tl(tl_32, tl_64);
+    tcg_gen_trunc_i64_tl(th_32, th_64);
+    gen_set_gpr(ctx, pair_reg(pair, false), tl_32);
+    gen_set_gpr(ctx, pair_reg(pair, true), th_32);
+# else
+    gen_set_gpr(ctx, pair_reg(pair, false), src);
+#endif
+}
+
+/* Concatenate the two registers selected by pair into dst. */
+static void get_pair_regs(DisasContext *ctx, TCGv_i64 dst, int pair)
+{
+#if defined(TARGET_RISCV32)
+    TCGv t1 = get_gpr(ctx, pair_reg(pair, false), EXT_NONE);
+    TCGv t2 = get_gpr(ctx, pair_reg(pair, true), EXT_NONE);
+    tcg_gen_concat_i32_i64(dst, t1, t2);
+#else
+    TCGv t1 = get_gpr(ctx, pair_reg(pair, false), EXT_NONE);
+    tcg_gen_mov_tl(dst, t1);
+#endif
+}
+
 static bool require_rvp(DisasContext *ctx)
 {
     uint32_t opcode = ctx->opcode & 0x7f;
@@ -925,6 +969,241 @@ GEN_SIMD_TRANS_ACC_64(pm4adda_h)
 GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
 GEN_SIMD_TRANS_ACC_64(pm4addau_h)
 
+/* Packed SIMD - Double-Width Operations (RV32 only, register pairs) */
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwadd_b)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwadda_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwaddu_b)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwaddau_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsub_b)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwsuba_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsubu_b)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwsubau_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(pwslli_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsll_bs)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(pwslai_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsla_bs)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwadd_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwadda_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwaddu_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwaddau_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsub_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwsuba_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsubu_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwsubau_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(pwslli_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsll_hs)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(pwslai_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwsla_hs)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wadd)
+GEN_SIMD_TRANS_REG_PAIR_ACC(wadda)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(waddu)
+GEN_SIMD_TRANS_REG_PAIR_ACC(waddau)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wsub)
+GEN_SIMD_TRANS_REG_PAIR_ACC(wsuba)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wsubu)
+GEN_SIMD_TRANS_REG_PAIR_ACC(wsubau)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(wslli)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wsll)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(wslai)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wsla)
+
+GEN_SIMD_TRANS_REG_PAIR_LANE(padd_db, padd_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(psub_db, psub_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psadd_db, psadd_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psaddu_db, psaddu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssub_db, pssub_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssubu_db, pssubu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paadd_db, paadd_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paaddu_db, paaddu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasub_db, pasub_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasubu_db, pasubu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pabd_db, pabd_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pabdu_db, pabdu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(psabs_db, psabs_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(padd_dh, padd_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(psub_dh, psub_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psadd_dh, psadd_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psaddu_dh, psaddu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssub_dh, pssub_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssubu_dh, pssubu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paadd_dh, paadd_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paaddu_dh, paaddu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasub_dh, pasub_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasubu_dh, pasubu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(psh1add_dh, psh1add_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssh1sadd_dh, pssh1sadd_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pas_dhx, pas_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE(psa_dhx, psa_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psas_dhx, psas_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssa_dhx, pssa_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paas_dhx, paas_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasa_dhx, pasa_hx)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pabd_dh, pabd_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pabdu_dh, pabdu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(psabs_dh, psabs_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psadd_dw, sadd)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(psaddu_dw, saddu)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssub_dw, ssub)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssubu_dw, ssubu)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paadd_dw, aadd)
+GEN_SIMD_TRANS_REG_PAIR_LANE(paaddu_dw, aaddu)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasub_dw, asub)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pasubu_dw, asubu)
+GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(pssh1sadd_dw, ssh1sadd)
+
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(pslli_db, pslli_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrli_db, psrli_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrai_db, psrai_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmin_db, pmin_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pminu_db, pminu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmax_db, pmax_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmaxu_db, pmaxu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmseq_db, pmseq_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmslt_db, pmslt_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmsltu_db, pmsltu_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY(psext_dh_b, psext_h_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(psati_dh, psati_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(pusati_dh, pusati_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(pslli_dh, pslli_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrli_dh, psrli_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrai_dh, psrai_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(psslai_dh, psslai_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrari_dh, psrari_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmin_dh, pmin_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pminu_dh, pminu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmax_dh, pmax_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmaxu_dh, pmaxu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmseq_dh, pmseq_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmslt_dh, pmslt_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmsltu_dh, pmsltu_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(psati_dw, sati_32)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(pusati_dw, usati_32)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(psslai_dw, sslai)
+GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(psrari_dw, srari_32)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmseq_dw, mseq)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmslt_dw, mslt)
+GEN_SIMD_TRANS_REG_PAIR_LANE(pmsltu_dw, msltu)
+
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(padd_dbs, padd_bs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psll_dbs, psll_bs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psrl_dbs, psrl_bs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psra_dbs, psra_bs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(padd_dhs, padd_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psll_dhs, psll_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psrl_dhs, psrl_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(psra_dhs, psra_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(pssha_dhs, pssha_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshar_dhs, psshar_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshl_dhs, psshl_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshlr_dhs, psshlr_hs)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(pssha_dws, ssha)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshar_dws, sshar)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshl_dws, sshl)
+GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(psshlr_dws, sshlr)
+
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppairo_db, ppairo_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppairo_dh, ppairo_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppaire_db, ppaire_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppaireo_db, ppaireo_b)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppaireo_dh, ppaireo_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppairoe_dh, ppairoe_h)
+GEN_SIMD_TRANS_REG_PAIR_LANE(ppairoe_db, ppairoe_b)
+
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsum_dbs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsumu_dbs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsum_dhs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsumu_dhs)
+
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrli_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrai_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrari_b)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipi_b)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipri_b)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipiu_b)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipriu_b)
+
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrli_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrai_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrari_h)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipi_h)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipri_h)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipiu_h)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(pnclipriu_h)
+
+GEN_SIMD_TRANS_PN_OP_IMM(nsrli)
+GEN_SIMD_TRANS_PN_OP_IMM(nsrai)
+GEN_SIMD_TRANS_PN_OP_IMM(nsrari)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(nclipi)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(nclipri)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(nclipiu)
+GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(nclipriu)
+
+GEN_SIMD_TRANS_PN_OP_REG(pnsrl_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsra_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsrar_bs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclip_bs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipr_bs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipu_bs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipru_bs)
+
+GEN_SIMD_TRANS_PN_OP_REG(pnsrl_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsra_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsrar_hs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclip_hs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipr_hs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipu_hs)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(pnclipru_hs)
+
+GEN_SIMD_TRANS_PN_OP_REG(nsrl)
+GEN_SIMD_TRANS_PN_OP_REG(nsra)
+GEN_SIMD_TRANS_PN_OP_REG(nsrar)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(nclip)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(nclipr)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(nclipu)
+GEN_SIMD_TRANS_PN_OP_REG_VXSAT(nclipru)
+
+GEN_SIMD_TRANS_REG_PAIR_ACC(pmqwacc_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pmqrwacc_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(mqwacc)
+GEN_SIMD_TRANS_REG_PAIR_ACC(mqrwacc)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmul_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmulsu_b)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmulu_b)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmul_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmulsu_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pwmulu_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwmacc_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwmaccsu_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pwmaccu_h)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wmul)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wmulsu)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(wmulu)
+
+GEN_SIMD_TRANS_REG_PAIR_ACC(wmacc)
+GEN_SIMD_TRANS_REG_PAIR_ACC(wmaccsu)
+GEN_SIMD_TRANS_REG_PAIR_ACC(wmaccu)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2wadd_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2waddsu_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2waddu_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2wadd_hx)
+
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2wadda_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2waddasu_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2waddau_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2wadda_hx)
+
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2wsub_h)
+GEN_SIMD_TRANS_REG_PAIR_SCALAR(pm2wsub_hx)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2wsuba_h)
+GEN_SIMD_TRANS_REG_PAIR_ACC(pm2wsuba_hx)
+
 #define GEN_PLI(NAME, PRE_REQ, IMM_TYPE, LIMIT, SHIFT, ADDEND) \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)    \
 {                                                              \
@@ -940,6 +1219,21 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)    \
     return true;                                               \
 }
 
+#define GEN_PLI_D(NAME, IMM_TYPE, LIMIT, SHIFT, ADDEND)        \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)    \
+{                                                              \
+    REQUIRE_RVP(ctx);                                          \
+    int i = 1;                                                 \
+    IMM_TYPE imm = a->imm;                                     \
+    while (i < (LIMIT)) {                                      \
+        imm = (imm << (SHIFT)) + (ADDEND);                     \
+        i++;                                                   \
+    }                                                          \
+    gen_set_gpri(ctx, pair_reg(a->rd, false), imm);            \
+    gen_set_gpri(ctx, pair_reg(a->rd, true), imm);             \
+    return true;                                               \
+}
+
 GEN_PLI(pli_b, , target_long, TARGET_LONG_SIZE, 8, a->imm)
 GEN_PLI(pli_h, , target_long, TARGET_LONG_SIZE / 2, 16,
         a->imm & 0xFFFF)
@@ -949,3 +1243,197 @@ GEN_PLI(pli_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_SIZE / 4, 32,
         a->imm & 0xFFFFFFFF)
 GEN_PLI(plui_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_SIZE / 4, 32,
         a->imm & 0xFFFFFFFF)
+GEN_PLI_D(pli_db, target_long, TARGET_LONG_SIZE, 8, a->imm)
+GEN_PLI_D(pli_dh, target_long, TARGET_LONG_SIZE / 2, 16,
+          a->imm & 0xFFFF)
+GEN_PLI_D(plui_dh, target_long, TARGET_LONG_SIZE / 2, 16,
+          a->imm & 0xFFFF)
+
+#define GEN_DW_LANE_BINOP(NAME, OP)                                \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)        \
+{                                                                  \
+    REQUIRE_32BIT(ctx);                                            \
+    REQUIRE_RVP(ctx);                                              \
+    TCGv src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE); \
+    TCGv src2_0 = get_gpr(ctx, pair_reg(a->rs2, false), EXT_NONE); \
+    TCGv dest_0 = dest_gpr(ctx, pair_reg(a->rd, false));           \
+    TCGv src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);  \
+    TCGv src2_1 = get_gpr(ctx, pair_reg(a->rs2, true), EXT_NONE);  \
+    TCGv dest_1 = dest_gpr(ctx, pair_reg(a->rd, true));            \
+    OP(dest_0, src1_0, src2_0);                                    \
+    OP(dest_1, src1_1, src2_1);                                    \
+    gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);              \
+    gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);               \
+    return true;                                                   \
+}
+
+GEN_DW_LANE_BINOP(padd_dw, tcg_gen_add_tl)
+GEN_DW_LANE_BINOP(psub_dw, tcg_gen_sub_tl)
+GEN_DW_LANE_BINOP(psh1add_dw, gen_sh1add)
+
+/* Verify rd is not zero register for wzip8p and wzip16p. */
+#if defined(TARGET_RISCV32)
+#define GEN_WZIP_P(NAME)                                     \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
+{                                                            \
+    REQUIRE_32BIT(ctx);                                      \
+    REQUIRE_RVP(ctx);                                        \
+    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);          \
+    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);          \
+    TCGv_i64 t = tcg_temp_new_i64();                         \
+    if (a->rd == 0) {                                        \
+        return true;                                         \
+    } else {                                                 \
+        get_pair_regs(ctx, t, a->rd);                        \
+    }                                                        \
+    gen_helper_##NAME(t, tcg_env, src1, src2);               \
+    set_pair_regs(ctx, a->rd, t);                            \
+    return true;                                             \
+}
+#else
+#define GEN_WZIP_P(NAME)                                     \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
+{                                                            \
+    REQUIRE_32BIT(ctx);                                      \
+    return true;                                             \
+}
+#endif
+
+GEN_WZIP_P(wzip8p)
+GEN_WZIP_P(wzip16p)
+
+#define GEN_PAIR_I64_BINOP(NAME, OP)                         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
+{                                                            \
+    REQUIRE_32BIT(ctx);                                      \
+    REQUIRE_RVP(ctx);                                        \
+    TCGv_i64 src1 = tcg_temp_new_i64();                      \
+    TCGv_i64 src2 = tcg_temp_new_i64();                      \
+    TCGv_i64 dest = tcg_temp_new_i64();                      \
+    get_pair_regs(ctx, src1, a->rs1);                        \
+    get_pair_regs(ctx, src2, a->rs2);                        \
+    get_pair_regs(ctx, dest, a->rd);                         \
+    OP(dest, src1, src2);                                    \
+    set_pair_regs(ctx, a->rd, dest);                         \
+    return true;                                             \
+}
+
+GEN_PAIR_I64_BINOP(addd_p, tcg_gen_add_i64)
+GEN_PAIR_I64_BINOP(subd_p, tcg_gen_sub_i64)
+
+#define GEN_DW_EXT(NAME, OP)                                       \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)        \
+{                                                                  \
+    REQUIRE_32BIT(ctx);                                            \
+    REQUIRE_RVP(ctx);                                              \
+    TCGv dest_0 = dest_gpr(ctx, pair_reg(a->rd, false));           \
+    TCGv src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE); \
+    TCGv dest_1 = dest_gpr(ctx, pair_reg(a->rd, true));            \
+    TCGv src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);  \
+    OP(dest_0, src1_0);                                            \
+    gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);              \
+    OP(dest_1, src1_1);                                            \
+    gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);               \
+    return true;                                                   \
+}
+
+GEN_DW_EXT(psext_dw_b, tcg_gen_ext8s_tl)
+GEN_DW_EXT(psext_dw_h, tcg_gen_ext16s_tl)
+
+#define GEN_DW_SHIFT_IMM(NAME, OP)                          \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    arg_shift a0, a1;                                       \
+    a0.rd = pair_reg(a->rd, false);                         \
+    a0.rs1 = pair_reg(a->rs1, false);                       \
+    a0.shamt = a->imm;                                      \
+    a1.rd = pair_reg(a->rd, true);                          \
+    a1.rs1 = pair_reg(a->rs1, true);                        \
+    a1.shamt = a->imm;                                      \
+    gen_shift_imm_fn(ctx, &a0, EXT_NONE, OP, NULL);         \
+    gen_shift_imm_fn(ctx, &a1, EXT_NONE, OP, NULL);         \
+    return true;                                            \
+}
+
+#define GEN_DW_SHIFT_IMM_PER_OL(NAME, OP, OP_OL)                  \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)       \
+{                                                                 \
+    REQUIRE_32BIT(ctx);                                           \
+    REQUIRE_RVP(ctx);                                             \
+    arg_shift a0, a1;                                             \
+    a0.rd = pair_reg(a->rd, false);                               \
+    a0.rs1 = pair_reg(a->rs1, false);                             \
+    a0.shamt = a->imm;                                            \
+    a1.rd = pair_reg(a->rd, true);                                \
+    a1.rs1 = pair_reg(a->rs1, true);                              \
+    a1.shamt = a->imm;                                            \
+    gen_shift_imm_fn_per_ol(ctx, &a0, EXT_NONE, OP, OP_OL, NULL); \
+    gen_shift_imm_fn_per_ol(ctx, &a1, EXT_NONE, OP, OP_OL, NULL); \
+    return true;                                                  \
+}
+
+GEN_DW_SHIFT_IMM(pslli_dw, tcg_gen_shli_tl)
+GEN_DW_SHIFT_IMM_PER_OL(psrli_dw, tcg_gen_shri_tl, gen_srliw)
+GEN_DW_SHIFT_IMM_PER_OL(psrai_dw, tcg_gen_sari_tl, gen_sraiw)
+
+#define GEN_DW_PAIR_ARITH(NAME, EXTRA_REQ, EXT, OP)         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    EXTRA_REQ                                               \
+    arg_r a0, a1;                                           \
+    a0.rd = pair_reg(a->rd, false);                         \
+    a0.rs1 = pair_reg(a->rs1, false);                       \
+    a0.rs2 = pair_reg(a->rs2, false);                       \
+    a1.rd = pair_reg(a->rd, true);                          \
+    a1.rs1 = pair_reg(a->rs1, true);                        \
+    a1.rs2 = pair_reg(a->rs2, true);                        \
+    gen_arith(ctx, &a0, EXT, OP, NULL);                     \
+    gen_arith(ctx, &a1, EXT, OP, NULL);                     \
+    return true;                                            \
+}
+
+GEN_DW_PAIR_ARITH(pmin_dw, REQUIRE_ZBB(ctx); , EXT_SIGN, tcg_gen_smin_tl)
+GEN_DW_PAIR_ARITH(pminu_dw, REQUIRE_ZBB(ctx); , EXT_SIGN, tcg_gen_umin_tl)
+GEN_DW_PAIR_ARITH(pmax_dw, REQUIRE_ZBB(ctx); , EXT_SIGN, tcg_gen_smax_tl)
+GEN_DW_PAIR_ARITH(pmaxu_dw, REQUIRE_ZBB(ctx); , EXT_SIGN, tcg_gen_umax_tl)
+
+#define GEN_DWS_REG_OP(NAME, EXT, MASK_SHIFT, OP)            \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
+{                                                            \
+    REQUIRE_32BIT(ctx);                                      \
+    REQUIRE_RVP(ctx);                                        \
+    TCGv src1_0;                                             \
+    TCGv src1_1;                                             \
+    if (a->rs1 == 0) {                                       \
+        src1_0 = tcg_constant_tl(0);                         \
+        src1_1 = tcg_constant_tl(0);                         \
+    } else {                                                 \
+        src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT); \
+        src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT);  \
+    }                                                        \
+    TCGv src2 = tcg_temp_new();                              \
+    tcg_gen_mov_tl(src2, get_gpr(ctx, a->rs2, EXT_NONE));    \
+    if (MASK_SHIFT) {                                        \
+        tcg_gen_andi_tl(src2, src2, 31);                     \
+    }                                                        \
+    TCGv dest_0 = tcg_temp_new();                            \
+    TCGv dest_1 = tcg_temp_new();                            \
+    OP(dest_0, src1_0, src2);                                \
+    OP(dest_1, src1_1, src2);                                \
+    if (a->rd != 0) {                                        \
+        gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);    \
+        gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);     \
+    }                                                        \
+    return true;                                             \
+}
+
+GEN_DWS_REG_OP(padd_dws, EXT_NONE, false, tcg_gen_add_tl)
+GEN_DWS_REG_OP(psll_dws, EXT_NONE, true, tcg_gen_shl_tl)
+GEN_DWS_REG_OP(psrl_dws, EXT_ZERO, true, tcg_gen_shr_tl)
+GEN_DWS_REG_OP(psra_dws, EXT_SIGN, true, tcg_gen_sar_tl)
+
+GEN_DW_PAIR_ARITH(ppaire_dh, REQUIRE_ZBKB(ctx); , EXT_NONE, gen_pack)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 94eb68776aa..5e6ee7926a0 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3261,3 +3261,276 @@ GEN_PSIMD_4WAY_MUL_ACC(pm4addasu_h, uint64_t, int16_t, uint16_t,
 GEN_PSIMD_4WAY_MUL_ACC(pm4addau_h, uint64_t, uint16_t, uint16_t,
                        uint64_t, uint64_t, uint64_t, EXTRACT16, EXTRACT64,
                        INSERT64, ELEMS_D, 0, PSIMD_MUL_U64)
+
+/* Double-Width Operations (RV32 only, register pairs) */
+
+GEN_PSIMD_WIDEN_BINOP(pwadd_b, int8_t, int16_t, uint16_t,
+                      4, 8, 16, 0xFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwadda_b, int8_t, int16_t, uint16_t,
+                          4, 8, 16, 0xFF, 0xFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(pwaddu_b, uint8_t, uint16_t, uint16_t,
+                      4, 8, 16, 0xFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwaddau_b, uint8_t, uint16_t, uint16_t,
+                          4, 8, 16, 0xFF, 0xFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(pwsub_b, int8_t, int16_t, uint16_t,
+                      4, 8, 16, 0xFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwsuba_b, int8_t, int16_t, uint16_t,
+                          4, 8, 16, 0xFF, 0xFFFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP(pwsubu_b, uint8_t, uint16_t, uint16_t,
+                      4, 8, 16, 0xFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwsubau_b, uint8_t, uint16_t, uint16_t,
+                          4, 8, 16, 0xFF, 0xFFFF, PSIMD_COMB_SUB)
+
+GEN_PSIMD_WIDEN_SHIFT(pwslli_b, uint8_t, uint16_t, uint16_t,
+                      4, 8, 16, 0xFF, 0x0F)
+GEN_PSIMD_WIDEN_SHIFT(pwsll_bs, uint8_t, uint16_t, uint16_t,
+                      4, 8, 16, 0xFF, 0x1F)
+GEN_PSIMD_WIDEN_SHIFT(pwslai_b, int8_t, int16_t, uint16_t,
+                      4, 8, 16, 0xFF, 0x0F)
+GEN_PSIMD_WIDEN_SHIFT(pwsla_bs, int8_t, int16_t, uint16_t,
+                      4, 8, 16, 0xFF, 0x1F)
+
+GEN_PSIMD_WIDEN_BINOP(pwadd_h, int16_t, int32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwadda_h, int16_t, int32_t, uint32_t,
+                          2, 16, 32, 0xFFFF, 0xFFFFFFFFULL,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(pwaddu_h, uint16_t, uint32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwaddau_h, uint16_t, uint32_t, uint32_t,
+                          2, 16, 32, 0xFFFF, 0xFFFFFFFFULL,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(pwsub_h, int16_t, int32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwsuba_h, int16_t, int32_t, uint32_t,
+                          2, 16, 32, 0xFFFF, 0xFFFFFFFFULL,
+                          PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP(pwsubu_h, uint16_t, uint32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(pwsubau_h, uint16_t, uint32_t, uint32_t,
+                          2, 16, 32, 0xFFFF, 0xFFFFFFFFULL,
+                          PSIMD_COMB_SUB)
+
+GEN_PSIMD_WIDEN_SHIFT(pwslli_h, uint16_t, uint32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, 0x1F)
+GEN_PSIMD_WIDEN_SHIFT(pwsll_hs, uint16_t, uint32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, 0x1F)
+GEN_PSIMD_WIDEN_SHIFT(pwslai_h, int16_t, int32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, 0x1F)
+GEN_PSIMD_WIDEN_SHIFT(pwsla_hs, int16_t, int32_t, uint32_t,
+                      2, 16, 32, 0xFFFF, 0x1F)
+
+GEN_PSIMD_WIDEN_BINOP(wadd, int32_t, int64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(wadda, int32_t, int64_t, uint64_t,
+                          1, 32, 64, 0xFFFFFFFF, 0xFFFFFFFFFFFFFFFFULL,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(waddu, uint32_t, uint64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP_ACC(waddau, uint32_t, uint64_t, uint64_t,
+                          1, 32, 64, 0xFFFFFFFF, 0xFFFFFFFFFFFFFFFFULL,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_WIDEN_BINOP(wsub, int32_t, int64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(wsuba, int32_t, int64_t, uint64_t,
+                          1, 32, 64, 0xFFFFFFFF, 0xFFFFFFFFFFFFFFFFULL,
+                          PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP(wsubu, uint32_t, uint64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, PSIMD_COMB_SUB)
+GEN_PSIMD_WIDEN_BINOP_ACC(wsubau, uint32_t, uint64_t, uint64_t,
+                          1, 32, 64, 0xFFFFFFFF, 0xFFFFFFFFFFFFFFFFULL,
+                          PSIMD_COMB_SUB)
+
+GEN_PSIMD_WIDEN_SHIFT(wslli, uint32_t, uint64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, 0x3F)
+GEN_PSIMD_WIDEN_SHIFT(wsll, uint32_t, uint64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, 0x3F)
+GEN_PSIMD_WIDEN_SHIFT(wslai, int32_t, int64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, 0x3F)
+GEN_PSIMD_WIDEN_SHIFT(wsla, int32_t, int64_t, uint64_t,
+                      1, 32, 64, 0xFFFFFFFF, 0x3F)
+
+GEN_PSIMD_DW_ZIP(wzip8p, EXTRACT8, 4, 16, 8)
+GEN_PSIMD_DW_ZIP(wzip16p, EXTRACT16, 2, 32, 16)
+
+GEN_PSIMD_DW_REDSUM(predsum_dbs, int64_t, int32_t, int8_t, EXTRACT8, 8)
+GEN_PSIMD_DW_REDSUM(predsumu_dbs, uint64_t, uint32_t, uint8_t, EXTRACT8, 8)
+GEN_PSIMD_DW_REDSUM(predsum_dhs, int64_t, int32_t, int16_t, EXTRACT16, 4)
+GEN_PSIMD_DW_REDSUM(predsumu_dhs, uint64_t, uint32_t, uint16_t, EXTRACT16, 4)
+
+
+/* Narrowing Operations (RV32 only, register pair sources) */
+
+GEN_PSIMD_NARROW_SRL(pnsrli_b, uint16_t, uint8_t,
+                     4, 16, 8, 0xFFFF, 0x0F)
+GEN_PSIMD_NARROW_SRL(pnsrl_bs, uint16_t, uint8_t,
+                     4, 16, 8, 0xFFFF, 0x1F)
+GEN_PSIMD_NARROW_SRA_PACK(pnsrai_b, int16_t, int32_t, uint8_t,
+                          4, 16, 8, 0xFFFF, 0x0F)
+GEN_PSIMD_NARROW_SRA_PACK(pnsra_bs, int16_t, int32_t, uint8_t,
+                          4, 16, 8, 0xFFFF, 0x1F)
+GEN_PSIMD_NARROW_RNDSRA_PACK(pnsrari_b, int16_t, int32_t, uint8_t,
+                             4, 16, 8, 0xFFFF, 0x0F, 0x1FF)
+GEN_PSIMD_NARROW_RNDSRA_PACK(pnsrar_bs, int16_t, int32_t, uint8_t,
+                             4, 16, 8, 0xFFFF, 0x1F, 0x1FF)
+GEN_PSIMD_NCLIP_SIGNED_PACK(pnclipi_b, int16_t, int32_t, int16_t,
+                            uint8_t, 4, 16, 8, 0xFFFF, 0x0F,
+                            -128, 127, 0x80, 0x7F)
+GEN_PSIMD_NCLIPR_SIGNED_PACK(pnclipri_b, int16_t, int32_t, int16_t,
+                             uint8_t, 4, 16, 8, 0xFFFF, 0x0F, 0x1FFFF,
+                             -128, 127, 0x80, 0x7F)
+GEN_PSIMD_NCLIP_UNSIGNED_PACK(pnclipiu_b, uint16_t, uint16_t, uint8_t,
+                              4, 16, 8, 0xFFFF, 0x0F, 0x00FF)
+GEN_PSIMD_NCLIPR_UNSIGNED_PACK(pnclipriu_b, uint16_t, uint32_t, uint8_t,
+                               4, 16, 8, 0xFFFF, 0x0F, 0x00FF)
+GEN_PSIMD_NCLIP_SIGNED_PACK(pnclip_bs, int16_t, int32_t, int16_t,
+                            uint8_t, 4, 16, 8, 0xFFFF, 0x1F,
+                            -128, 127, 0x80, 0x7F)
+GEN_PSIMD_NCLIPR_SIGNED_PACK(pnclipr_bs, int16_t, int32_t, int16_t,
+                             uint8_t, 4, 16, 8, 0xFFFF, 0x1F, 0x1FFFF,
+                             -128, 127, 0x80, 0x7F)
+GEN_PSIMD_NCLIP_UNSIGNED_PACK(pnclipu_bs, uint16_t, uint32_t, uint8_t,
+                              4, 16, 8, 0xFFFF, 0x1F, 0x00FF)
+GEN_PSIMD_NCLIPR_UNSIGNED_PACK(pnclipru_bs, uint16_t, uint64_t, uint8_t,
+                               4, 16, 8, 0xFFFF, 0x1F, 0x00FF)
+
+GEN_PSIMD_NARROW_SRL(pnsrli_h, uint32_t, uint16_t,
+                     2, 32, 16, 0xFFFFFFFFULL, 0x1F)
+GEN_PSIMD_NARROW_SRA_PACK(pnsrai_h, int32_t, int64_t, uint16_t,
+                          2, 32, 16, 0xFFFFFFFFULL, 0x1F)
+GEN_PSIMD_NARROW_RNDSRA_PACK(pnsrari_h, int32_t, int64_t, uint16_t,
+                             2, 32, 16, 0xFFFFFFFFULL, 0x1F, 0x1FFFF)
+
+GEN_PSIMD_NARROW_SRL(pnsrl_hs, uint32_t, uint16_t,
+                     2, 32, 16, 0xFFFFFFFFULL, 0x1F)
+
+GEN_PSIMD_NARROW_ALIAS(pnsra_hs, pnsrai_h)
+GEN_PSIMD_NARROW_ALIAS(pnsrar_hs, pnsrari_h)
+
+GEN_PSIMD_NCLIP_SIGNED_PACK(pnclip_hs, int32_t, int64_t, int32_t,
+                            uint16_t, 2, 32, 16, 0xFFFFFFFFULL, 0x1F,
+                            -32768, 32767, 0x8000, 0x7FFF)
+GEN_PSIMD_NCLIPR_SIGNED_PACK(pnclipr_hs, int32_t, int64_t, int32_t,
+                             uint16_t, 2, 32, 16, 0xFFFFFFFFULL, 0x1F,
+                             0x1FFFFFFFF, -32768, 32767, 0x8000, 0x7FFF)
+
+GEN_PSIMD_NARROW_ALIAS(pnclipi_h, pnclip_hs)
+GEN_PSIMD_NARROW_ALIAS(pnclipri_h, pnclipr_hs)
+
+GEN_PSIMD_NCLIP_UNSIGNED_PACK(pnclipu_hs, uint32_t, uint32_t, uint16_t,
+                              2, 32, 16, 0xFFFFFFFFULL, 0x1F, 0xFFFF)
+GEN_PSIMD_NCLIPR_UNSIGNED_PACK(pnclipru_hs, uint32_t, uint64_t, uint16_t,
+                               2, 32, 16, 0xFFFFFFFFULL, 0x1F, 0xFFFF)
+
+GEN_PSIMD_NARROW_ALIAS(pnclipiu_h, pnclipu_hs)
+GEN_PSIMD_NARROW_ALIAS(pnclipriu_h, pnclipru_hs)
+
+GEN_PSIMD_NARROW_SRL(nsrli, uint64_t, uint32_t,
+                     1, 64, 32, 0xFFFFFFFFFFFFFFFFULL, 0x3F)
+
+GEN_PSIMD_NARROW_SRA(nsrai)
+GEN_PSIMD_NARROW_RNDSRA(nsrari)
+
+GEN_PSIMD_NARROW_SRL(nsrl, uint64_t, uint32_t,
+                     1, 64, 32, 0xFFFFFFFFFFFFFFFFULL, 0x3F)
+
+GEN_PSIMD_NARROW_SRA(nsra)
+GEN_PSIMD_NARROW_RNDSRA(nsrar)
+
+GEN_PSIMD_NCLIP(nclipi)
+GEN_PSIMD_NCLIPR(nclipri)
+GEN_PSIMD_NCLIPU(nclipiu)
+GEN_PSIMD_NCLIPRU(nclipriu)
+
+GEN_PSIMD_NCLIP(nclip)
+GEN_PSIMD_NCLIPR(nclipr)
+GEN_PSIMD_NCLIPU(nclipu)
+GEN_PSIMD_NCLIPRU(nclipru)
+
+/* Multiplication with Even-Odd Register Pairs as Destination (RV32 only) */
+
+GEN_PSIMD_WIDEN_QMUL_ACC(pmqwacc_h, int16_t, int32_t, int64_t,
+                         int32_t, uint32_t, 2, EXTRACT16, EXTRACT32,
+                         1, 0, 15, 0, 32, PSIMD_MUL_S64)
+GEN_PSIMD_WIDEN_QMUL_ACC(pmqrwacc_h, int16_t, int32_t, int64_t,
+                         int32_t, uint32_t, 2, EXTRACT16, EXTRACT32,
+                         1, 0, 15, 1LL << 14, 32, PSIMD_MUL_S64)
+
+GEN_PSIMD_WIDEN_MUL(pwmul_b, int8_t, int8_t, int16_t, uint16_t,
+                    4, EXTRACT8, 16, PSIMD_MUL_S32)
+GEN_PSIMD_WIDEN_MUL(pwmulsu_b, int8_t, uint8_t, int16_t, uint16_t,
+                    4, EXTRACT8, 16, PSIMD_MUL_SU16)
+GEN_PSIMD_WIDEN_MUL(pwmulu_b, uint8_t, uint8_t, uint16_t, uint16_t,
+                    4, EXTRACT8, 16, PSIMD_MUL_U32)
+GEN_PSIMD_WIDEN_MUL(pwmul_h, int16_t, int16_t, int32_t, uint32_t,
+                    2, EXTRACT16, 32, PSIMD_MUL_S32)
+GEN_PSIMD_WIDEN_MUL(pwmulsu_h, int16_t, uint16_t, int32_t, uint32_t,
+                    2, EXTRACT16, 32, PSIMD_MUL_SU32)
+GEN_PSIMD_WIDEN_MUL(pwmulu_h, uint16_t, uint16_t, uint32_t, uint32_t,
+                    2, EXTRACT16, 32, PSIMD_MUL_U32)
+
+GEN_PSIMD_WIDEN_MUL_ACC(pwmacc_h, int16_t, int16_t, int32_t,
+                        int32_t, uint32_t, 2, EXTRACT16, EXTRACT32, 32,
+                        PSIMD_MUL_S32)
+GEN_PSIMD_WIDEN_MUL_ACC(pwmaccsu_h, int16_t, uint16_t, int32_t,
+                        int32_t, uint32_t, 2, EXTRACT16, EXTRACT32, 32,
+                        PSIMD_MUL_SU32)
+GEN_PSIMD_WIDEN_MUL_ACC(pwmaccu_h, uint16_t, uint16_t, uint32_t,
+                        uint32_t, uint32_t, 2, EXTRACT16, EXTRACT32, 32,
+                        PSIMD_MUL_U32)
+
+GEN_PSIMD_WIDEN_QMUL_ACC(mqwacc, int32_t, int64_t, int64_t,
+                         int64_t, uint64_t, 1, EXTRACT32, EXTRACT64,
+                         0, 0, 31, 0, 64, PSIMD_MUL_S64)
+GEN_PSIMD_WIDEN_QMUL_ACC(mqrwacc, int32_t, int64_t, int64_t,
+                         int64_t, uint64_t, 1, EXTRACT32, EXTRACT64,
+                         0, 0, 31, 1LL << 30, 64, PSIMD_MUL_S64)
+
+GEN_PSIMD_WIDEN_MUL(wmul, int32_t, int32_t, int64_t, uint64_t,
+                    1, EXTRACT32, 64, PSIMD_MUL_S64)
+GEN_PSIMD_WIDEN_MUL(wmulsu, int32_t, uint32_t, int64_t, uint64_t,
+                    1, EXTRACT32, 64, PSIMD_MUL_SU64)
+GEN_PSIMD_WIDEN_MUL(wmulu, uint32_t, uint32_t, uint64_t, uint64_t,
+                    1, EXTRACT32, 64, PSIMD_MUL_U64)
+
+GEN_PSIMD_WIDEN_MUL_ACC(wmacc, int32_t, int32_t, int64_t,
+                        int64_t, uint64_t, 1, EXTRACT32, EXTRACT64, 64,
+                        PSIMD_MUL_S64)
+GEN_PSIMD_WIDEN_MUL_ACC(wmaccsu, int32_t, uint32_t, int64_t,
+                        int64_t, uint64_t, 1, EXTRACT32, EXTRACT64, 64,
+                        PSIMD_MUL_SU64)
+GEN_PSIMD_WIDEN_MUL_ACC(wmaccu, uint32_t, uint32_t, uint64_t,
+                        uint64_t, uint64_t, 1, EXTRACT32, EXTRACT64, 64,
+                        PSIMD_MUL_U64)
+
+GEN_PSIMD_DW_2WAY_MUL(pm2wadd_h, int16_t, int16_t, int64_t,
+                      EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_S64, PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL(pm2waddsu_h, int16_t, uint16_t, int64_t,
+                      EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_SU64,
+                      PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL(pm2waddu_h, uint16_t, uint16_t, uint64_t,
+                      EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_U64, PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2wadda_h, int16_t, int16_t, int64_t, int64_t,
+                          EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_S64,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2waddasu_h, int16_t, uint16_t, int64_t,
+                          int64_t, EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_SU64,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2waddau_h, uint16_t, uint16_t, uint64_t,
+                          uint64_t, EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_U64,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL(pm2wadd_hx, int16_t, int16_t, int64_t,
+                      EXTRACT16, 0, 1, 1, 0, PSIMD_MUL_S64, PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2wadda_hx, int16_t, int16_t, int64_t, int64_t,
+                          EXTRACT16, 0, 1, 1, 0, PSIMD_MUL_S64,
+                          PSIMD_COMB_ADD)
+GEN_PSIMD_DW_2WAY_MUL(pm2wsub_h, int16_t, int16_t, int64_t,
+                      EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_S64, PSIMD_COMB_SUB)
+GEN_PSIMD_DW_2WAY_MUL(pm2wsub_hx, int16_t, int16_t, int64_t,
+                      EXTRACT16, 0, 1, 1, 0, PSIMD_MUL_S64, PSIMD_COMB_SUB)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2wsuba_h, int16_t, int16_t, int64_t, int64_t,
+                          EXTRACT16, 0, 1, 0, 1, PSIMD_MUL_S64,
+                          PSIMD_COMB_SUB)
+GEN_PSIMD_DW_2WAY_MUL_ACC(pm2wsuba_hx, int16_t, int16_t, int64_t, int64_t,
+                          EXTRACT16, 0, 1, 1, 0, PSIMD_MUL_S64,
+                          PSIMD_COMB_SUB)
-- 
2.34.1


