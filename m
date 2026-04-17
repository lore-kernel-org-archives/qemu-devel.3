Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7050F4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjs-0001Xw-9Y; Fri, 17 Apr 2026 06:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjp-0001Uw-9F; Fri, 17 Apr 2026 06:47:53 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjj-00083b-QA; Fri, 17 Apr 2026 06:47:52 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S15;
 Fri, 17 Apr 2026 18:47:23 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/14] target/riscv: rvp: add rv32-only register-pair
 instructions
Date: Fri, 17 Apr 2026 18:46:50 +0800
Message-Id: <20260417104652.17857-14-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S15
X-Coremail-Antispam: 1UD129KBjvAXoWDKw1rGFWfGrykAFy3Kr1DGFg_yoWfXr48to
 W5Gw15Ar97GrW7ua4akw4UXFy7Zry2vwn3Jr45Zr47uayfGr47KFn8Jrn5Zay8JrWFkFWf
 XFZ3Grn5tr1a934Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY37AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
 IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
 IFyTuYvjfU5TmhDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.998,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                   |  131 ++
 target/riscv/insn32.decode              |  279 +++
 target/riscv/insn_trans/trans_rvp.c.inc |  786 ++++++++-
 target/riscv/psimd_helper.c             | 2068 +++++++++++++++++++++++
 4 files changed, 3220 insertions(+), 44 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 663ac0e242..85d4fe1b67 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1737,3 +1737,134 @@ DEF_HELPER_3(pm4addu_h, i64, env, i64, i64)
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
index b1bde37de4..7be0b9e5e6 100644
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
@@ -69,6 +72,7 @@
 &mop5 imm rd rs1
 &mop3 imm rd rs1 rs2
 &p_l  imm rd
+&p_ui imm rs1 rd
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -101,6 +105,11 @@
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
@@ -122,6 +131,18 @@
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
@@ -1612,3 +1633,261 @@ pli_h    1011000 .......... 010 ..... 0011011 @p_l2
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
+psra_dbs    0100110 ..... .... 1110 .... 00011011 @r_p_3
+padd_dhs    0001100 ..... .... 0110 .... 00011011 @r_p_3
+psll_dhs    0000100 ..... .... 0110 .... 00011011 @r_p_3
+psrl_dhs    0000100 ..... .... 1110 .... 00011011 @r_p_3
+psra_dhs    0100100 ..... .... 1110 .... 00011011 @r_p_3
+pssha_dhs   0110100 ..... .... 0110 .... 00011011 @r_p_3
+psshar_dhs  0111100 ..... .... 0110 .... 00011011 @r_p_3
+padd_dws    0001101 ..... .... 0110 .... 00011011 @r_p_3
+psll_dws    0000101 ..... .... 0110 .... 00011011 @r_p_3
+psrl_dws    0000101 ..... .... 1110 .... 00011011 @r_p_3
+psra_dws    0100101 ..... .... 1110 .... 00011011 @r_p_3
+pssha_dws   0110101 ..... .... 0110 .... 00011011 @r_p_3
+psshar_dws  0111101 ..... .... 0110 .... 00011011 @r_p_3
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
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index b82774e00f..ca459293a3 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -2,6 +2,38 @@
 /* RISC-V translation routines for the P Standard Extensions. */
 /* Copyright (c) 2026 ISRC ISCAS. */
 
+/* Save a 64 bit data in src to dst and dst + 1 */
+static void set_pair_regs(DisasContext *ctx, int dst, TCGv_i64 src)
+{
+#if defined(TARGET_RISCV32)
+    TCGv_i64 tl_64 = tcg_temp_new_i64();
+    TCGv_i64 th_64 = tcg_temp_new_i64();
+    TCGv_i32 tl_32 = tcg_temp_new_i32();
+    TCGv_i32 th_32 = tcg_temp_new_i32();
+    tcg_gen_extract_i64(tl_64, src, 0, 32);
+    tcg_gen_extract_i64(th_64, src, 32, 32);
+    tcg_gen_trunc_i64_tl(tl_32, tl_64);
+    tcg_gen_trunc_i64_tl(th_32, th_64);
+    gen_set_gpr(ctx, dst, tl_32);
+    gen_set_gpr(ctx, dst + 1, th_32);
+# else
+    gen_set_gpr(ctx, dst, src);
+#endif
+}
+
+/* Concat two 32 bit data in src and src + 1 to dst */
+static void get_pair_regs(DisasContext *ctx, TCGv_i64 dst, int src)
+{
+#if defined(TARGET_RISCV32)
+    TCGv t1 = get_gpr(ctx, src, EXT_NONE);
+    TCGv t2 = get_gpr(ctx, src + 1, EXT_NONE);
+    tcg_gen_concat_i32_i64(dst, t1, t2);
+#else
+    TCGv t1 = get_gpr(ctx, src, EXT_NONE);
+    tcg_gen_mov_tl(dst, t1);
+#endif
+}
+
 #define GEN_SIMD_TRANS(NAME)                                \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
@@ -10,7 +42,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);              \
    TCGv dest = dest_gpr(ctx, a->rd);                        \
    gen_helper_##NAME(dest, tcg_env, src1, src2);            \
-   return true;                                             \
+   return true;                                            \
 }
 
 #if defined(TARGET_RISCV32)
@@ -23,14 +55,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1, src2);           \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_32(NAME)                             \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -39,7 +71,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
 {                                                           \
    REQUIRE_64BIT(ctx);                                      \
-   return true;                                             \
+   return true;                                            \
 }
 #else
 #define GEN_SIMD_TRANS_64(NAME)                             \
@@ -51,7 +83,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1, src2);           \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -65,7 +97,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv t = tcg_temp_new();                                \
     gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
     gen_set_gpr(ctx, a->rd, t);                             \
-    return true;                                            \
+    return true;                                           \
 }
 
 #if defined(TARGET_RISCV32)
@@ -80,14 +112,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv t = tcg_temp_new();                                \
     gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
     gen_set_gpr(ctx, a->rd, t);                             \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_ACC_32(NAME)                         \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -96,7 +128,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_64BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_ACC_64(NAME)                         \
@@ -110,7 +142,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv t = tcg_temp_new();                                \
     gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
     gen_set_gpr(ctx, a->rd, t);                             \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -122,7 +154,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1);                 \
     gen_set_gpr(ctx, a->rd, dest);                          \
-    return true;                                            \
+    return true;                                           \
 }
 
 #if defined(TARGET_RISCV32)
@@ -130,7 +162,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_64BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_R1_64(NAME)                          \
@@ -141,7 +173,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1);                 \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -153,7 +185,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv imm = tcg_constant_tl(a->imm);                     \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1, imm);            \
-    return true;                                            \
+    return true;                                           \
 }
 
 #if defined(TARGET_RISCV32)
@@ -166,14 +198,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv imm = tcg_constant_tl(a->imm);                     \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1, imm);            \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_IMM_32(NAME)                         \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -182,7 +214,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_64BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_IMM_64(NAME)                         \
@@ -194,7 +226,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv imm = tcg_constant_tl(a->imm);                     \
     TCGv dest = dest_gpr(ctx, a->rd);                       \
     gen_helper_##NAME(dest, tcg_env, src1, imm);            \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -209,14 +241,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv_i64 t = tcg_temp_new_i64();                        \
     gen_helper_##NAME(t, tcg_env, src1, src2);              \
     set_pair_regs(ctx, (a->rd) * 2, t);                       \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_1(NAME)                     \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -234,14 +266,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
     TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
     gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);      \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);      \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_2(INSN, HELPER)                \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -257,14 +289,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
     TCGv src2   = get_gpr(ctx, a->rs2, EXT_NONE);              \
     gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);        \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_3(INSN, HELPER)                \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -282,14 +314,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
     TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
     gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);      \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);      \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_DW(INSN, HELPER)               \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -307,14 +339,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
     TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
     gen_helper_##HELPER(dest_0, tcg_env, src1_0, imm_0);       \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1, imm_1);       \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_DW_IMM(INSN, HELPER)           \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -332,14 +364,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
     TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
     gen_helper_##HELPER##_32(dest_0, tcg_env, src1_0, imm_0);  \
     gen_helper_##HELPER##_32(dest_1, tcg_env, src1_1, imm_1);  \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(INSN, HELPER)         \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -356,14 +388,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1);              \
     gen_set_gpr(ctx, (a->rd) * 2, dest_0);                       \
     gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                     \
-    return true;                                               \
+    return true;                                              \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_5(INSN, HELPER)                \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
 {                                                              \
     REQUIRE_32BIT(ctx);                                        \
-    return true;                                               \
+    return true;                                              \
 }
 #endif
 
@@ -378,14 +410,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv_i64 t = tcg_temp_new_i64();                        \
     gen_helper_##NAME(t, tcg_env, src1, imm);               \
     set_pair_regs(ctx, (a->rd) * 2, t);                       \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_IMM(NAME)                   \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -403,14 +435,14 @@ static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)  \
     TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                \
     gen_helper_##HELPER(dest_0, tcg_env, src1_0, imm_0);     \
     gen_helper_##HELPER(dest_1, tcg_env, src1_1, imm_1);     \
-    return true;                                             \
+    return true;                                            \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_IMM_2(INSN, HELPER)          \
 static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)  \
 {                                                            \
     REQUIRE_32BIT(ctx);                                      \
-    return true;                                             \
+    return true;                                            \
 }
 #endif
 
@@ -430,14 +462,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     }                                                       \
     gen_helper_##NAME(t, tcg_env, src1, src2, t);           \
     set_pair_regs(ctx, (a->rd) * 2, t);                       \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_ACC_REG_PAIR_1(NAME)                 \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -461,14 +493,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
         src1_h = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);      \
     }                                                       \
     gen_helper_##NAME(dest, tcg_env, src1_l, src1_h, src2); \
-    return true;                                            \
+    return true;                                           \
 }
 #else
 #define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME)               \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                           \
     REQUIRE_32BIT(ctx);                                     \
-    return true;                                            \
+    return true;                                           \
 }
 #endif
 
@@ -487,14 +519,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv shamt = tcg_constant_tl(a->imm);                  \
     TCGv_i32 dest = dest_gpr(ctx, a->rd);                  \
     gen_helper_##NAME(dest, tcg_env, s1, shamt);           \
-    return true;                                           \
+    return true;                                          \
 }
 #else
 #define GEN_SIMD_TRANS_PN_OP_IMM(NAME)                     \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                          \
     REQUIRE_32BIT(ctx);                                    \
-    return true;                                           \
+    return true;                                          \
 }
 #endif
 
@@ -513,14 +545,14 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     TCGv_i32 rs2 = get_gpr(ctx, a->rs2, EXT_NONE);         \
     TCGv_i32 dest = dest_gpr(ctx, a->rd);                  \
     gen_helper_##NAME(dest, tcg_env, s1, rs2);             \
-    return true;                                           \
+    return true;                                          \
 }
 #else
 #define GEN_SIMD_TRANS_PN_OP_REG(NAME)                     \
 static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 {                                                          \
     REQUIRE_32BIT(ctx);                                    \
-    return true;                                           \
+    return true;                                          \
 }
 #endif
 
@@ -907,6 +939,236 @@ GEN_SIMD_TRANS_ACC_64(pm4adda_h)
 GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
 GEN_SIMD_TRANS_ACC_64(pm4addau_h)
 
+/* Packed SIMD - Double-Width Operations (RV32 only, register pairs) */
+GEN_SIMD_TRANS_REG_PAIR_1(pwadd_b)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwadda_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwaddu_b)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwaddau_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsub_b)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwsuba_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsubu_b)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwsubau_b)
+GEN_SIMD_TRANS_REG_PAIR_IMM(pwslli_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsll_bs)
+GEN_SIMD_TRANS_REG_PAIR_IMM(pwslai_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsla_bs)
+
+GEN_SIMD_TRANS_REG_PAIR_1(pwadd_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwadda_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwaddu_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwaddau_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsub_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwsuba_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsubu_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwsubau_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM(pwslli_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsll_hs)
+GEN_SIMD_TRANS_REG_PAIR_IMM(pwslai_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwsla_hs)
+
+GEN_SIMD_TRANS_REG_PAIR_1(wadd)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wadda)
+GEN_SIMD_TRANS_REG_PAIR_1(waddu)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(waddau)
+GEN_SIMD_TRANS_REG_PAIR_1(wsub)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wsuba)
+GEN_SIMD_TRANS_REG_PAIR_1(wsubu)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wsubau)
+
+GEN_SIMD_TRANS_REG_PAIR_IMM(wslli)
+GEN_SIMD_TRANS_REG_PAIR_1(wsll)
+GEN_SIMD_TRANS_REG_PAIR_IMM(wslai)
+GEN_SIMD_TRANS_REG_PAIR_1(wsla)
+
+GEN_SIMD_TRANS_REG_PAIR_2(padd_db, padd_b)
+GEN_SIMD_TRANS_REG_PAIR_2(psub_db, psub_b)
+GEN_SIMD_TRANS_REG_PAIR_2(psadd_db, psadd_b)
+GEN_SIMD_TRANS_REG_PAIR_2(psaddu_db, psaddu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pssub_db, pssub_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pssubu_db, pssubu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(paadd_db, paadd_b)
+GEN_SIMD_TRANS_REG_PAIR_2(paaddu_db, paaddu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pasub_db, pasub_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pasubu_db, pasubu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pabd_db, pabd_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pabdu_db, pabdu_b)
+GEN_SIMD_TRANS_REG_PAIR_5(psabs_db, psabs_b)
+GEN_SIMD_TRANS_REG_PAIR_2(padd_dh, padd_h)
+GEN_SIMD_TRANS_REG_PAIR_2(psub_dh, psub_h)
+GEN_SIMD_TRANS_REG_PAIR_2(psadd_dh, psadd_h)
+GEN_SIMD_TRANS_REG_PAIR_2(psaddu_dh, psaddu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pssub_dh, pssub_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pssubu_dh, pssubu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(paadd_dh, paadd_h)
+GEN_SIMD_TRANS_REG_PAIR_2(paaddu_dh, paaddu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pasub_dh, pasub_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pasubu_dh, pasubu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(psh1add_dh, psh1add_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pssh1sadd_dh, pssh1sadd_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pas_dhx, pas_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(psa_dhx, psa_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(psas_dhx, psas_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(pssa_dhx, pssa_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(paas_dhx, paas_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(pasa_dhx, pasa_hx)
+GEN_SIMD_TRANS_REG_PAIR_2(pabd_dh, pabd_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pabdu_dh, pabdu_h)
+GEN_SIMD_TRANS_REG_PAIR_5(psabs_dh, psabs_h)
+GEN_SIMD_TRANS_REG_PAIR_DW(psadd_dw, sadd)
+GEN_SIMD_TRANS_REG_PAIR_DW(psaddu_dw, saddu)
+GEN_SIMD_TRANS_REG_PAIR_DW(pssub_dw, ssub)
+GEN_SIMD_TRANS_REG_PAIR_DW(pssubu_dw, ssubu)
+GEN_SIMD_TRANS_REG_PAIR_DW(paadd_dw, aadd)
+GEN_SIMD_TRANS_REG_PAIR_DW(paaddu_dw, aaddu)
+GEN_SIMD_TRANS_REG_PAIR_DW(pasub_dw, asub)
+GEN_SIMD_TRANS_REG_PAIR_DW(pasubu_dw, asubu)
+GEN_SIMD_TRANS_REG_PAIR_DW(pssh1sadd_dw, ssh1sadd)
+
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(pslli_db, pslli_b)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psrli_db, psrli_b)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psrai_db, psrai_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmin_db, pmin_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pminu_db, pminu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmax_db, pmax_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmaxu_db, pmaxu_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmseq_db, pmseq_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmslt_db, pmslt_b)
+GEN_SIMD_TRANS_REG_PAIR_2(pmsltu_db, pmsltu_b)
+GEN_SIMD_TRANS_REG_PAIR_5(psext_dh_b, psext_h_b)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psati_dh, psati_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(pusati_dh, pusati_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(pslli_dh, pslli_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psrli_dh, psrli_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psrai_dh, psrai_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psslai_dh, psslai_h)
+GEN_SIMD_TRANS_REG_PAIR_IMM_2(psrari_dh, psrari_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmin_dh, pmin_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pminu_dh, pminu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmax_dh, pmax_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmaxu_dh, pmaxu_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmseq_dh, pmseq_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmslt_dh, pmslt_h)
+GEN_SIMD_TRANS_REG_PAIR_2(pmsltu_dh, pmsltu_h)
+GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(psati_dw, sati)
+GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(pusati_dw, usati)
+GEN_SIMD_TRANS_REG_PAIR_DW_IMM(psslai_dw, sslai)
+GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(psrari_dw, srari)
+GEN_SIMD_TRANS_REG_PAIR_DW(pmseq_dw, mseq)
+GEN_SIMD_TRANS_REG_PAIR_DW(pmslt_dw, mslt)
+GEN_SIMD_TRANS_REG_PAIR_DW(pmsltu_dw, msltu)
+
+GEN_SIMD_TRANS_REG_PAIR_3(padd_dbs, padd_bs)
+GEN_SIMD_TRANS_REG_PAIR_3(psll_dbs, psll_bs)
+GEN_SIMD_TRANS_REG_PAIR_3(psra_dbs, psra_bs)
+GEN_SIMD_TRANS_REG_PAIR_3(padd_dhs, padd_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psll_dhs, psll_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psrl_dhs, psrl_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psra_dhs, psra_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(pssha_dhs, pssha_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psshar_dhs, psshar_hs)
+GEN_SIMD_TRANS_REG_PAIR_DW(pssha_dws, ssha)
+GEN_SIMD_TRANS_REG_PAIR_DW(psshar_dws, sshar)
+
+GEN_SIMD_TRANS_REG_PAIR_2(ppairo_db, ppairo_b)
+GEN_SIMD_TRANS_REG_PAIR_2(ppairo_dh, ppairo_h)
+GEN_SIMD_TRANS_REG_PAIR_2(ppaire_db, ppaire_b)
+GEN_SIMD_TRANS_REG_PAIR_2(ppaireo_db, ppaireo_b)
+GEN_SIMD_TRANS_REG_PAIR_2(ppaireo_dh, ppaireo_h)
+GEN_SIMD_TRANS_REG_PAIR_2(ppairoe_dh, ppairoe_h)
+GEN_SIMD_TRANS_REG_PAIR_2(ppairoe_db, ppairoe_b)
+
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsum_dbs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsumu_dbs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsum_dhs)
+GEN_SIMD_TRANS_REG_PAIR_PREDSUM(predsumu_dhs)
+
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrli_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrai_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrari_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipi_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipri_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipiu_b)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipriu_b)
+
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrli_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrai_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnsrari_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipi_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipri_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipiu_h)
+GEN_SIMD_TRANS_PN_OP_IMM(pnclipriu_h)
+
+GEN_SIMD_TRANS_PN_OP_IMM(nsrli)
+GEN_SIMD_TRANS_PN_OP_IMM(nsrai)
+GEN_SIMD_TRANS_PN_OP_IMM(nsrari)
+GEN_SIMD_TRANS_PN_OP_IMM(nclipi)
+GEN_SIMD_TRANS_PN_OP_IMM(nclipri)
+GEN_SIMD_TRANS_PN_OP_IMM(nclipiu)
+GEN_SIMD_TRANS_PN_OP_IMM(nclipriu)
+
+GEN_SIMD_TRANS_PN_OP_REG(pnsrl_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsra_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsrar_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclip_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipr_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipu_bs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipru_bs)
+
+GEN_SIMD_TRANS_PN_OP_REG(pnsrl_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsra_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnsrar_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclip_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipr_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipu_hs)
+GEN_SIMD_TRANS_PN_OP_REG(pnclipru_hs)
+
+GEN_SIMD_TRANS_PN_OP_REG(nsrl)
+GEN_SIMD_TRANS_PN_OP_REG(nsra)
+GEN_SIMD_TRANS_PN_OP_REG(nsrar)
+GEN_SIMD_TRANS_PN_OP_REG(nclip)
+GEN_SIMD_TRANS_PN_OP_REG(nclipr)
+GEN_SIMD_TRANS_PN_OP_REG(nclipu)
+GEN_SIMD_TRANS_PN_OP_REG(nclipru)
+
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pmqwacc_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pmqrwacc_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(mqwacc)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(mqrwacc)
+
+GEN_SIMD_TRANS_REG_PAIR_1(pwmul_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwmulsu_b)
+GEN_SIMD_TRANS_REG_PAIR_1(pwmulu_b)
+
+GEN_SIMD_TRANS_REG_PAIR_1(pwmul_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwmulsu_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pwmulu_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwmacc_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwmaccsu_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pwmaccu_h)
+
+GEN_SIMD_TRANS_REG_PAIR_1(wmul)
+GEN_SIMD_TRANS_REG_PAIR_1(wmulsu)
+GEN_SIMD_TRANS_REG_PAIR_1(wmulu)
+
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wmacc)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wmaccsu)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(wmaccu)
+
+GEN_SIMD_TRANS_REG_PAIR_1(pm2wadd_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pm2waddsu_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pm2waddu_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pm2wadd_hx)
+
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2wadda_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2waddasu_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2waddau_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2wadda_hx)
+
+GEN_SIMD_TRANS_REG_PAIR_1(pm2wsub_h)
+GEN_SIMD_TRANS_REG_PAIR_1(pm2wsub_hx)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2wsuba_h)
+GEN_SIMD_TRANS_ACC_REG_PAIR_1(pm2wsuba_hx)
+
 static bool trans_pli_b(DisasContext *ctx, arg_pli_b * a)
 {
     REQUIRE_EXT(ctx, RVP);
@@ -973,3 +1235,439 @@ static bool trans_plui_w(DisasContext *ctx, arg_plui_w * a)
     gen_set_gpri(ctx, a->rd, imm);
     return true;
 }
+
+static bool trans_pli_db(DisasContext *ctx, arg_pli_db * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE) {
+        imm = ((imm << 8) + a->imm);
+        i++;
+    }
+    gen_set_gpri(ctx, (a->rd) * 2, imm);
+    gen_set_gpri(ctx, (a->rd) * 2 + 1, imm);
+    return true;
+}
+
+static bool trans_pli_dh(DisasContext *ctx, arg_pli_dh * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 2) {
+        imm = (imm << 16) + (a->imm & 0xFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, (a->rd) * 2, imm);
+    gen_set_gpri(ctx, (a->rd) * 2 + 1, imm);
+    return true;
+}
+
+static bool trans_plui_dh(DisasContext *ctx, arg_plui_dh * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 2) {
+        imm = (imm << 16) + (a->imm & 0xFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, (a->rd) * 2, imm);
+    gen_set_gpri(ctx, (a->rd) * 2 + 1, imm);
+    return true;
+}
+
+static bool trans_padd_dw(DisasContext *ctx, arg_padd_dw * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);
+    TCGv src2_0 = get_gpr(ctx, (a->rs2) * 2, EXT_NONE);
+    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);
+    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);
+    TCGv src2_1 = get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE);
+    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);
+    tcg_gen_add_tl(dest_0, src1_0, src2_0);
+    tcg_gen_add_tl(dest_1, src1_1, src2_1);
+    gen_set_gpr(ctx, (a->rd) * 2, dest_0);
+    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);
+    return true;
+}
+
+static bool trans_psub_dw(DisasContext *ctx, arg_psub_dw * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);
+    TCGv src2_0 = get_gpr(ctx, (a->rs2) * 2, EXT_NONE);
+    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);
+    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);
+    TCGv src2_1 = get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE);
+    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);
+    tcg_gen_sub_tl(dest_0, src1_0, src2_0);
+    tcg_gen_sub_tl(dest_1, src1_1, src2_1);
+    gen_set_gpr(ctx, (a->rd) * 2, dest_0);
+    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);
+    return true;
+}
+
+static bool trans_psh1add_dw(DisasContext *ctx, arg_psh1add_dw * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);
+    TCGv src2_0 = get_gpr(ctx, (a->rs2) * 2, EXT_NONE);
+    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);
+    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);
+    TCGv src2_1 = get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE);
+    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);
+    gen_sh1add(dest_0, src1_0, src2_0);
+    gen_sh1add(dest_1, src1_1, src2_1);
+    gen_set_gpr(ctx, (a->rd) * 2, dest_0);
+    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);
+    return true;
+}
+
+/* Verify rd is not zero register for wzip8p and wzip16p. */
+#if defined(TARGET_RISCV32)
+static bool trans_wzip8p(DisasContext *ctx, arg_wzip8p * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 t = tcg_temp_new_i64();
+    if (a->rd == 0) {
+        return true;
+    } else {
+        get_pair_regs(ctx, t, (a->rd) * 2);
+    }
+    gen_helper_wzip8p(t, tcg_env, src1, src2);
+    set_pair_regs(ctx, (a->rd) * 2, t);
+    return true;
+}
+#else
+static bool trans_wzip8p(DisasContext *ctx, arg_wzip8p * a)
+{
+    REQUIRE_32BIT(ctx);
+    return true;
+}
+#endif
+
+#if defined(TARGET_RISCV32)
+static bool trans_wzip16p(DisasContext *ctx, arg_wzip16p * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 t = tcg_temp_new_i64();
+    if (a->rd == 0) {
+        return true;
+    } else {
+        get_pair_regs(ctx, t, (a->rd) * 2);
+    }
+    gen_helper_wzip16p(t, tcg_env, src1, src2);
+    set_pair_regs(ctx, (a->rd) * 2, t);
+    return true;
+}
+#else
+static bool trans_wzip16p(DisasContext *ctx, arg_wzip16p * a)
+{
+    REQUIRE_32BIT(ctx);
+    return true;
+}
+#endif
+
+static bool trans_addd_p(DisasContext *ctx, arg_addd_p * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv_i64 src1 = tcg_temp_new_i64();
+    TCGv_i64 src2 = tcg_temp_new_i64();
+    TCGv_i64 dest = tcg_temp_new_i64();
+    get_pair_regs(ctx, src1, (a->rs1) * 2);
+    get_pair_regs(ctx, src2, (a->rs2) * 2);
+    get_pair_regs(ctx, dest, (a->rd) * 2);
+    tcg_gen_add_i64(dest, src1, src2);
+    set_pair_regs(ctx, (a->rd) * 2, dest);
+
+    return true;
+}
+
+static bool trans_subd_p(DisasContext *ctx, arg_subd_p * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv_i64 src1 = tcg_temp_new_i64();
+    TCGv_i64 src2 = tcg_temp_new_i64();
+    TCGv_i64 dest = tcg_temp_new_i64();
+    get_pair_regs(ctx, src1, (a->rs1) * 2);
+    get_pair_regs(ctx, src2, (a->rs2) * 2);
+    get_pair_regs(ctx, dest, (a->rd) * 2);
+    tcg_gen_sub_i64(dest, src1, src2);
+    set_pair_regs(ctx, (a->rd) * 2, dest);
+
+    return true;
+}
+
+static bool trans_psext_dw_b(DisasContext *ctx, arg_psext_dw_b * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);
+    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);
+    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);
+    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);
+
+    tcg_gen_ext8s_tl(dest_0, src1_0);
+    gen_set_gpr(ctx, (a->rd) * 2, dest_0);
+
+    tcg_gen_ext8s_tl(dest_1, src1_1);
+    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);
+
+    return true;
+}
+
+static bool trans_psext_dw_h(DisasContext *ctx, arg_psext_dw_h * a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);
+    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);
+    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);
+    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);
+
+    tcg_gen_ext16s_tl(dest_0, src1_0);
+    gen_set_gpr(ctx, (a->rd) * 2, dest_0);
+
+    tcg_gen_ext16s_tl(dest_1, src1_1);
+    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);
+
+    return true;
+}
+
+static bool trans_pslli_dw(DisasContext *ctx, arg_pslli_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_shift a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.shamt = a->imm;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.shamt = a->imm;
+
+    gen_shift_imm_fn(ctx, &a0, EXT_NONE, tcg_gen_shli_tl, NULL);
+    gen_shift_imm_fn(ctx, &a1, EXT_NONE, tcg_gen_shli_tl, NULL);
+
+    return true;
+}
+
+static bool trans_psrli_dw(DisasContext *ctx, arg_psrli_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_shift a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.shamt = a->imm;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.shamt = a->imm;
+
+    gen_shift_imm_fn_per_ol(ctx, &a0, EXT_NONE, tcg_gen_shri_tl,
+                            gen_srliw, NULL);
+    gen_shift_imm_fn_per_ol(ctx, &a1, EXT_NONE, tcg_gen_shri_tl,
+                            gen_srliw, NULL);
+
+    return true;
+}
+
+static bool trans_psrai_dw(DisasContext *ctx, arg_psrai_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_shift a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.shamt = a->imm;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.shamt = a->imm;
+
+    gen_shift_imm_fn_per_ol(ctx, &a0, EXT_NONE, tcg_gen_sari_tl,
+                            gen_sraiw, NULL);
+    gen_shift_imm_fn_per_ol(ctx, &a1, EXT_NONE, tcg_gen_sari_tl,
+                            gen_sraiw, NULL);
+
+    return true;
+}
+
+static bool trans_pmin_dw(DisasContext *ctx, arg_pmin_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    REQUIRE_ZBB(ctx);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = (a->rs2) * 2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = (a->rs2) * 2 + 1;
+
+    gen_arith(ctx, &a0, EXT_SIGN, tcg_gen_smin_tl, NULL);
+    gen_arith(ctx, &a1, EXT_SIGN, tcg_gen_smin_tl, NULL);
+
+    return true;
+}
+
+static bool trans_pminu_dw(DisasContext *ctx, arg_pminu_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    REQUIRE_ZBB(ctx);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = (a->rs2) * 2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = (a->rs2) * 2 + 1;
+
+    gen_arith(ctx, &a0, EXT_SIGN, tcg_gen_umin_tl, NULL);
+    gen_arith(ctx, &a1, EXT_SIGN, tcg_gen_umin_tl, NULL);
+
+    return true;
+}
+
+static bool trans_pmax_dw(DisasContext *ctx, arg_pmax_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    REQUIRE_ZBB(ctx);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = (a->rs2) * 2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = (a->rs2) * 2 + 1;
+
+    gen_arith(ctx, &a0, EXT_SIGN, tcg_gen_smax_tl, NULL);
+    gen_arith(ctx, &a1, EXT_SIGN, tcg_gen_smax_tl, NULL);
+
+    return true;
+}
+
+static bool trans_pmaxu_dw(DisasContext *ctx, arg_pmaxu_dw *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    REQUIRE_ZBB(ctx);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = (a->rs2) * 2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = (a->rs2) * 2 + 1;
+
+    gen_arith(ctx, &a0, EXT_SIGN, tcg_gen_umax_tl, NULL);
+    gen_arith(ctx, &a1, EXT_SIGN, tcg_gen_umax_tl, NULL);
+
+    return true;
+}
+
+static bool trans_padd_dws(DisasContext *ctx, arg_padd_dws *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = a->rs2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = a->rs2;
+
+    gen_arith(ctx, &a0, EXT_NONE, tcg_gen_add_tl, NULL);
+    gen_arith(ctx, &a1, EXT_NONE, tcg_gen_add_tl, NULL);
+
+    return true;
+}
+
+static bool trans_psll_dws(DisasContext *ctx, arg_psll_dws *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = a->rs2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = a->rs2;
+
+    gen_shift(ctx, &a0, EXT_NONE, tcg_gen_shl_tl, NULL);
+    gen_shift(ctx, &a1, EXT_NONE, tcg_gen_shl_tl, NULL);
+
+    return true;
+}
+
+static bool trans_psrl_dws(DisasContext *ctx, arg_psrl_dws *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = a->rs2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = a->rs2;
+
+    gen_shift(ctx, &a0, EXT_ZERO, tcg_gen_shr_tl, NULL);
+    gen_shift(ctx, &a1, EXT_ZERO, tcg_gen_shr_tl, NULL);
+
+    return true;
+}
+
+static bool trans_psra_dws(DisasContext *ctx, arg_psra_dws *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = a->rs2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = a->rs2;
+
+    gen_shift(ctx, &a0, EXT_SIGN, tcg_gen_sar_tl, NULL);
+    gen_shift(ctx, &a1, EXT_SIGN, tcg_gen_sar_tl, NULL);
+
+    return true;
+}
+
+static bool trans_ppaire_dh(DisasContext *ctx, arg_ppaire_dh *a)
+{
+    REQUIRE_32BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    REQUIRE_ZBKB(ctx);
+    arg_r a0, a1;
+    a0.rd = (a->rd) * 2;
+    a0.rs1 = (a->rs1) * 2;
+    a0.rs2 = (a->rs2) * 2;
+    a1.rd = (a->rd) * 2 + 1;
+    a1.rs1 = (a->rs1) * 2 + 1;
+    a1.rs2 = (a->rs2) * 2 + 1;
+
+    gen_arith(ctx, &a0, EXT_NONE, gen_pack, NULL);
+    gen_arith(ctx, &a1, EXT_NONE, gen_pack, NULL);
+    return true;
+}
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index 5eede48581..4c91800128 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -7012,3 +7012,2071 @@ uint64_t HELPER(pm4addau_h)(CPURISCVState *env, uint64_t rs1,
     uint64_t prod3 = (uint64_t)s1_h3 * (uint64_t)s2_h3;
     return d + prod0 + prod1 + prod2 + prod3;
 }
+
+/* Double-Width Operations (RV32 only, register pairs) */
+
+/**
+ * PWADD.B - Packed widening byte to halfword addition (RV32)
+ * rd_pair = {rs1[31:24]+rs2[31:24], rs1[23:16]+rs2[23:16],
+ *            rs1[15:8]+rs2[15:8], rs1[7:0]+rs2[7:0]} (sign-extended)
+ */
+uint64_t HELPER(pwadd_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t e2 = (int8_t)((rs2 >> (i * 8)) & 0xFF);
+        int16_t res = e1 + e2;
+        rd |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWADDA.B - Packed widening byte to halfword addition with accumulate (RV32)
+ * rd_pair += {rs1[i] + rs2[i]}
+ */
+uint64_t HELPER(pwadda_b)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t e2 = (int8_t)((rs2 >> (i * 8)) & 0xFF);
+        int16_t acc = (int16_t)((rd >> (i * 16)) & 0xFFFF);
+        int16_t res = acc + e1 + e2;
+        result |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return result;
+}
+
+/**
+ * PWADDU.B - Packed widening byte to halfword unsigned addition (RV32)
+ */
+uint64_t HELPER(pwaddu_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t e2 = (uint8_t)((rs2 >> (i * 8)) & 0xFF);
+        uint16_t res = e1 + e2;
+        rd |= ((uint64_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWADDAU.B - Packed widening byte to halfword unsigned addition
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwaddau_b)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t e2 = (uint8_t)((rs2 >> (i * 8)) & 0xFF);
+        uint16_t acc = (uint16_t)((rd >> (i * 16)) & 0xFFFF);
+        uint16_t res = acc + e1 + e2;
+        result |= ((uint64_t)res) << (i * 16);
+    }
+
+    return result;
+}
+
+/**
+ * PWSUB.B - Packed widening byte to halfword subtraction (RV32)
+ */
+uint64_t HELPER(pwsub_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t e2 = (int8_t)((rs2 >> (i * 8)) & 0xFF);
+        int16_t res = e1 - e2;
+        rd |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSUBA.B - Packed widening byte to halfword subtraction
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwsuba_b)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t e2 = (int8_t)((rs2 >> (i * 8)) & 0xFF);
+        int16_t acc = (int16_t)((rd >> (i * 16)) & 0xFFFF);
+        int16_t res = acc + (e1 - e2);
+        result |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return result;
+}
+
+/**
+ * PWSUBU.B - Packed widening byte to halfword unsigned subtraction (RV32)
+ */
+uint64_t HELPER(pwsubu_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t e2 = (uint8_t)((rs2 >> (i * 8)) & 0xFF);
+        uint16_t res = e1 - e2;
+        rd |= ((uint64_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSUBAU.B - Packed widening byte to halfword unsigned subtraction
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwsubau_b)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t e2 = (uint8_t)((rs2 >> (i * 8)) & 0xFF);
+        uint16_t acc = (uint16_t)((rd >> (i * 16)) & 0xFFFF);
+        uint16_t res = acc + (e1 - e2);
+        result |= ((uint64_t)res) << (i * 16);
+    }
+
+    return result;
+}
+
+/**
+ * PWSLLI.B - Packed widening shift left immediate (byte to halfword)
+ */
+uint64_t HELPER(pwslli_b)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = imm & 0x0F;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t res = e1 << shamt;
+        rd |= ((uint64_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLL.BS - Packed widening shift left from register (byte to halfword)
+ */
+uint64_t HELPER(pwsll_bs)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t e1 = (uint8_t)((rs1 >> (i * 8)) & 0xFF);
+        uint16_t res = e1 << shamt;
+        rd |= ((uint64_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLAI.B - Packed widening signed shift left immediate (byte to halfword)
+ */
+uint64_t HELPER(pwslai_b)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = imm & 0x0F;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t res = e1 << shamt;
+        rd |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLA.BS - Packed widening signed shift left from register (byte to halfword)
+ */
+uint64_t HELPER(pwsla_bs)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t e1 = (int8_t)((rs1 >> (i * 8)) & 0xFF);
+        int16_t res = e1 << shamt;
+        rd |= ((uint64_t)(uint16_t)res) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PWADD.H - Packed widening halfword to word addition (RV32)
+ */
+uint64_t HELPER(pwadd_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t e2 = (int16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        int32_t res = e1 + e2;
+        rd |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWADDA.H - Packed widening halfword to word addition with accumulate (RV32)
+ */
+uint64_t HELPER(pwadda_h)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t e2 = (int16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        int32_t acc = (int32_t)((rd >> (i * 32)) & 0xFFFFFFFF);
+        int32_t res = acc + e1 + e2;
+        result |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return result;
+}
+
+/**
+ * PWADDU.H - Packed widening halfword to word unsigned addition (RV32)
+ */
+uint64_t HELPER(pwaddu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t e2 = (uint16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        uint32_t res = e1 + e2;
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWADDAU.H - Packed widening halfword to word unsigned addition
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwaddau_h)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t e2 = (uint16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        uint32_t acc = (uint32_t)((rd >> (i * 32)) & 0xFFFFFFFF);
+        uint32_t res = acc + e1 + e2;
+        result |= ((uint64_t)res) << (i * 32);
+    }
+
+    return result;
+}
+
+/**
+ * PWSUB.H - Packed widening halfword to word subtraction (RV32)
+ */
+uint64_t HELPER(pwsub_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t e2 = (int16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        int32_t res = e1 - e2;
+        rd |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSUBA.H - Packed widening halfword to word subtraction
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwsuba_h)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t e2 = (int16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        int32_t acc = (int32_t)((rd >> (i * 32)) & 0xFFFFFFFF);
+        int32_t res = acc + (e1 - e2);
+        result |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return result;
+}
+
+/**
+ * PWSUBU.H - Packed widening halfword to word unsigned subtraction (RV32)
+ */
+uint64_t HELPER(pwsubu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t e2 = (uint16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        uint32_t res = e1 - e2;
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSUBAU.H - Packed widening halfword to word unsigned subtraction
+ * with accumulate (RV32)
+ */
+uint64_t HELPER(pwsubau_h)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t rd)
+{
+    uint64_t result = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t e2 = (uint16_t)((rs2 >> (i * 16)) & 0xFFFF);
+        uint32_t acc = (uint32_t)((rd >> (i * 32)) & 0xFFFFFFFF);
+        uint32_t res = acc + (e1 - e2);
+        result |= ((uint64_t)res) << (i * 32);
+    }
+
+    return result;
+}
+
+/**
+ * PWSLLI.H - Packed widening shift left immediate (halfword to word)
+ */
+uint64_t HELPER(pwslli_h)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = imm & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t res = e1 << shamt;
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLL.HS - Packed widening shift left from register (halfword to word)
+ */
+uint64_t HELPER(pwsll_hs)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        uint32_t res = e1 << shamt;
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLAI.H - Packed widening signed shift left immediate (halfword to word)
+ */
+uint64_t HELPER(pwslai_h)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = imm & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t res = e1 << shamt;
+        rd |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * PWSLA.HS - Packed widening signed shift left from register (halfword to word)
+ */
+uint64_t HELPER(pwsla_hs)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int16_t)((rs1 >> (i * 16)) & 0xFFFF);
+        int32_t res = e1 << shamt;
+        rd |= ((uint64_t)(uint32_t)res) << (i * 32);
+    }
+
+    return rd;
+}
+
+/**
+ * WADD - Widening signed addition (RV32)
+ */
+uint64_t HELPER(wadd)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    return (uint64_t)(a + b);
+}
+
+/**
+ * WADDA - Widening signed addition with accumulate (RV32)
+ */
+uint64_t HELPER(wadda)(CPURISCVState *env, uint32_t rs1,
+                       uint32_t rs2, uint64_t rd)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    int64_t acc = (int64_t)rd;
+    return (uint64_t)(acc + a + b);
+}
+
+/**
+ * WADDU - Widening unsigned addition (RV32)
+ */
+uint64_t HELPER(waddu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t a = rs1;
+    uint64_t b = rs2;
+    return a + b;
+}
+
+/**
+ * WADDAU - Widening unsigned addition with accumulate (RV32)
+ */
+uint64_t HELPER(waddau)(CPURISCVState *env, uint32_t rs1,
+                        uint32_t rs2, uint64_t rd)
+{
+    uint64_t acc = rd;
+    return acc + rs1 + rs2;
+}
+
+/**
+ * WSUB - Widening signed subtraction (RV32)
+ */
+uint64_t HELPER(wsub)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    return (uint64_t)(a - b);
+}
+
+/**
+ * WSUBA - Widening signed subtraction with accumulate (RV32)
+ */
+uint64_t HELPER(wsuba)(CPURISCVState *env, uint32_t rs1,
+                       uint32_t rs2, uint64_t rd)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    int64_t acc = (int64_t)rd;
+    return (uint64_t)(acc + a - b);
+}
+
+/**
+ * WSUBU - Widening unsigned subtraction (RV32)
+ */
+uint64_t HELPER(wsubu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t a = rs1;
+    uint64_t b = rs2;
+    return a - b;
+}
+
+/**
+ * WSUBAU - Widening unsigned subtraction with accumulate (RV32)
+ */
+uint64_t HELPER(wsubau)(CPURISCVState *env, uint32_t rs1,
+                        uint32_t rs2, uint64_t rd)
+{
+    uint64_t acc = rd;
+    return acc + rs1 - rs2;
+}
+
+/**
+ * WSLLI - Widening logical shift left immediate (RV32)
+ */
+uint64_t HELPER(wslli)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    uint64_t a = rs1;
+    uint8_t shamt = imm & 0x3F;
+    return a << shamt;
+}
+
+/**
+ * WSLL - Widening logical shift left from register (RV32)
+ */
+uint64_t HELPER(wsll)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t a = rs1;
+    uint8_t shamt = rs2 & 0x3F;
+    return a << shamt;
+}
+
+/**
+ * WSLAI - Widening signed shift left immediate (RV32)
+ */
+uint64_t HELPER(wslai)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    int64_t a = (int32_t)rs1;
+    uint8_t shamt = imm & 0x3F;
+    return (uint64_t)(a << shamt);
+}
+
+/**
+ * WSLA - Widening signed shift left from register (RV32)
+ */
+uint64_t HELPER(wsla)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int64_t a = (int32_t)rs1;
+    uint8_t shamt = rs2 & 0x3F;
+    return (uint64_t)(a << shamt);
+}
+
+/**
+ * WZIP8P - Double-width interleave bytes (RV32)
+ */
+uint64_t HELPER(wzip8p)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint64_t b1 = (uint64_t)EXTRACT8(rs1, i) << 16 * i;
+        uint64_t b2 = (uint64_t)EXTRACT8(rs2, i) << (16 * i + 8);
+        rd = rd | b2 | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * WZIP16P - Double-width interleave halfwords (RV32)
+ */
+uint64_t HELPER(wzip16p)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint64_t h1 = (uint64_t)EXTRACT16(rs1, i) << (32 * i);
+        uint64_t h2 = (uint64_t)EXTRACT16(rs2, i) << (32 * i + 16);
+        rd = rd | h2 | h1;
+    }
+
+    return rd;
+}
+
+/**
+ * PREDSUM.DBS - Double-width signed reduction sum of bytes (RV32)
+ */
+uint32_t HELPER(predsum_dbs)(CPURISCVState *env, uint32_t rs1_lo,
+                             uint32_t rs1_hi, uint32_t rs2)
+{
+    int64_t sum = (int32_t)rs2;
+    int64_t s1 = ((int64_t)rs1_hi << 32) | rs1_lo;
+
+    for (int i = 0; i < 8; i++) {
+        int8_t b = (int8_t)((s1 >> (i * 8)) & 0xFF);
+        sum += b;
+    }
+
+    return (uint32_t)sum;
+}
+
+/**
+ * PREDSUMU.DBS - Double-width unsigned reduction sum of bytes (RV32)
+ */
+uint32_t HELPER(predsumu_dbs)(CPURISCVState *env, uint32_t rs1_lo,
+                              uint32_t rs1_hi, uint32_t rs2)
+{
+    uint64_t sum = rs2;
+    uint64_t s1 = ((uint64_t)rs1_hi << 32) | rs1_lo;
+
+    for (int i = 0; i < 8; i++) {
+        uint8_t b = (uint8_t)((s1 >> (i * 8)) & 0xFF);
+        sum += b;
+    }
+
+    return (uint32_t)sum;
+}
+
+/**
+ * PREDSUM.DHS - Double-width signed reduction sum of halfwords (RV32)
+ */
+uint32_t HELPER(predsum_dhs)(CPURISCVState *env, uint32_t rs1_lo,
+                             uint32_t rs1_hi, uint32_t rs2)
+{
+    int64_t sum = (int32_t)rs2;
+    int64_t s1 = ((int64_t)rs1_hi << 32) | rs1_lo;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t h = (int16_t)((s1 >> (i * 16)) & 0xFFFF);
+        sum += h;
+    }
+
+    return (uint32_t)sum;
+}
+
+/**
+ * PREDSUMU.DHS - Double-width unsigned reduction sum of halfwords (RV32)
+ */
+uint32_t HELPER(predsumu_dhs)(CPURISCVState *env, uint32_t rs1_lo,
+                              uint32_t rs1_hi, uint32_t rs2)
+{
+    uint64_t sum = rs2;
+    uint64_t s1 = ((uint64_t)rs1_hi << 32) | rs1_lo;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t h = (uint16_t)((s1 >> (i * 16)) & 0xFFFF);
+        sum += h;
+    }
+
+    return (uint32_t)sum;
+}
+
+
+/* Narrowing Operations (RV32 only, register pair sources) */
+
+/**
+ * PNSRLI.B - Narrowing logical shift right immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsrli_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint8_t result = (s1_h >> (shamt & 0xF)) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRL.BS - Narrowing logical shift right from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsrl_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint32_t s1_h_z32 = (uint32_t)s1_h;
+        uint8_t result = (s1_h_z32 >> (shamt & 0x1F)) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRAI.B - Narrowing arithmetic shift right immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsrai_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int32_t s1_h_s32 = (int32_t)(int16_t)s1_h;
+        int32_t s1_h_s24 = (s1_h_s32 << 8) >> 8;
+        uint8_t result = s1_h_s24 >> (shamt & 0xF) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRA.BS - Narrowing arithmetic shift right from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsra_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int64_t s1_h_s64 = (int64_t)(int16_t)s1_h;
+        s1_h_s64 = (s1_h_s64 << 24) >> 24;
+        uint8_t result = s1_h_s64 >> (shamt & 0x1F) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRARI.B - Narrowing arithmetic shift right with rounding
+ * immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsrari_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int32_t s1_h_s32 = (int32_t)(int16_t)s1_h;
+        int32_t s1_h_s24 = (s1_h_s32 << 8) >> 8;
+        uint32_t shx_25bit = ((uint32_t)s1_h_s24 << 1);
+        uint32_t shx = (shx_25bit >> (shamt & 0xF)) & 0x1FF;
+        uint8_t result = ((shx + 1) >> 1) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRAR.BS - Narrowing arithmetic shift right with rounding
+ * from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnsrar_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int64_t s1_h_s64 = (int64_t)(int16_t)s1_h;
+        int64_t s1_h_s40 = (s1_h_s64 << 24) >> 24;
+        uint64_t shx_41bit = ((uint64_t)s1_h_s40 << 1);
+        uint64_t shx = (shx_41bit >> (shamt & 0x1F)) & 0x1FF;
+        uint8_t result = ((shx + 1) >> 1) & 0xFF;
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    return rd;
+}
+
+/**
+ * PNCLIPI.B - Narrowing clip signed (64-bit to 32-bit) with immediate shift
+ */
+uint32_t HELPER(pnclipi_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int32_t s1_h_s32 = (int32_t)(int16_t)s1_h;
+        int16_t shx = (int16_t)(s1_h_s32 >> (shamt & 0xF));
+        uint8_t result = 0;
+
+        if (shx < -128) {
+            sat = 1;
+            result = 0x80; /* -128 */
+        } else if (shx > 127) {
+            sat = 1;
+            result = 0x7F; /* 127 */
+        } else {
+            result = (uint8_t)shx;
+        }
+        rd |= ((uint32_t)result << (i * 8));
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPRI.B - Narrowing clip signed with rounding
+ * (64-bit to 32-bit) with immediate shift
+ */
+uint32_t HELPER(pnclipri_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int32_t s1_h_s32 = (int32_t)(int16_t)s1_h;
+        uint64_t shx_33bit = ((uint32_t)s1_h_s32 << 1);
+        uint32_t shx = (shx_33bit >> (shamt & 0xF)) & 0x1FFFF;
+        uint16_t round_shx = (uint16_t)((shx + 1) >> 1);
+        int16_t round_shx_s = (int16_t)round_shx;
+        uint8_t result = 0;
+
+        if (round_shx_s < -128) {
+            sat = 1;
+            result = 0x80;
+        } else if (round_shx_s > 127) {
+            sat = 1;
+            result = 0x7F;
+        } else {
+            result = (uint8_t)round_shx;
+        }
+
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPIU.B - Narrowing clip unsigned (64-bit to 32-bit) with immediate shift
+ */
+uint32_t HELPER(pnclipiu_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint16_t shx = s1_h >> (shamt & 0xF);
+        uint8_t result = 0;
+
+        if (shx > 0x00FF) {
+            sat = 1;
+            result = 0xFF;
+        } else {
+            result = (uint8_t)(shx & 0xFF);
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPRIU.B - Narrowing clip unsigned with rounding
+ * (64-bit to 32-bit) with immediate shift
+ */
+uint32_t HELPER(pnclipriu_b)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint32_t shx_17bit = ((uint32_t)s1_h << 1);
+        uint32_t shx = shx_17bit >> (shamt & 0xF);
+        uint16_t round_shx = (uint16_t)((shx + 1) >> 1);
+        uint8_t result = 0;
+
+        if (round_shx > 0x00FF) {
+            sat = 1;
+            result = 0xFF;
+        } else {
+            result = (uint8_t)(round_shx & 0xFF);
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIP.BS - Narrowing clip signed from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnclip_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int64_t s1_h_s64 = (int64_t)(int16_t)s1_h;
+        int64_t s1_h_s48 = (s1_h_s64 << 16) >> 16;
+        int16_t shx = (int16_t)(s1_h_s48 >> (shamt & 0x1F));
+        uint8_t result = 0;
+
+        if (shx < -128) {
+            sat = 1;
+            result = 0x80;
+        } else if (shx > 127) {
+            sat = 1;
+            result = 0x7F;
+        } else {
+            result = (uint8_t)shx;
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPR.BS - Narrowing clip signed with rounding
+ * from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnclipr_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        int64_t s1_h_s64 = (int64_t)(int16_t)s1_h;
+        int64_t s1_h_s48 = (s1_h_s64 << 16) >> 16;
+        uint64_t shx_49bit = ((uint64_t)s1_h_s48 << 1);
+        uint32_t shx = (shx_49bit >> (shamt & 0x1F)) & 0x1FFFF;
+        uint16_t round_shx = (uint16_t)((shx + 1) >> 1);
+        int16_t round_shx_s = (int16_t)round_shx;
+        uint8_t result = 0;
+
+        if (round_shx_s < -128) {
+            sat = 1;
+            result = 0x80;
+        } else if (round_shx_s > 127) {
+            sat = 1;
+            result = 0x7F;
+        } else {
+            result = (uint8_t)round_shx;
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPU.BS - Narrowing clip unsigned from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnclipu_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint32_t s1_h_z32 = (uint32_t)s1_h;
+        uint16_t shx = (s1_h_z32 >> (shamt & 0x1F)) & 0xFFFF;
+        uint8_t result = 0;
+
+        if (shx > 0x00FF) {
+            sat = 1;
+            result = 0xFF;
+        } else {
+            result = (uint8_t)(shx & 0xFF);
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPRU.BS - Narrowing clip unsigned with rounding
+ * from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(pnclipru_bs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t s1_h = (s1 >> (i * 16)) & 0xFFFF;
+        uint32_t s1_h_z32 = (uint32_t)s1_h;
+        uint64_t shx_33bit = ((uint64_t)s1_h_z32 << 1);
+        uint32_t shx = (shx_33bit >> (shamt & 0x1F)) & 0x1FFFF;
+        uint16_t round_shx = (uint16_t)((shx + 1) >> 1);
+        uint8_t result = 0;
+
+        if (round_shx > 0x00FF) {
+            sat = 1;
+            result = 0xFF;
+        } else {
+            result = (uint8_t)(round_shx & 0xFF);
+        }
+        rd |= ((uint32_t)result) << (i * 8);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNSRLI.H - Narrowing logical shift right immediate
+ * (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsrli_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    uint32_t s1_low  = (uint32_t)(s1 & 0xFFFFFFFF);
+    uint32_t s1_high = (uint32_t)((s1 >> 32) & 0xFFFFFFFF);
+
+    uint16_t rd_low  = (s1_low  >> (shamt & 0x1F)) & 0xFFFF;
+    uint16_t rd_high = (s1_high >> (shamt & 0x1F)) & 0xFFFF;
+
+    rd = ((uint32_t)rd_high << 16) | rd_low;
+    return rd;
+}
+
+/**
+ * PNSRAI.H - Narrowing arithmetic shift right immediate
+ * (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsrai_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    uint32_t s1_low  = (uint32_t)(s1 & 0xFFFFFFFF);
+    int64_t s1_low_s64 = (int64_t)(int32_t)s1_low;
+    int64_t s1_low_s48 = (s1_low_s64 << 16) >> 16;
+
+    uint32_t s1_high = (uint32_t)((s1 >> 32) & 0xFFFFFFFF);
+    int64_t s1_high_s64 = (int64_t)(int32_t)s1_high;
+    int64_t s1_high_s48 = (s1_high_s64 << 16) >> 16;
+
+    uint16_t rd_low  = (s1_low_s48  >> (shamt & 0x1F)) & 0xFFFF;
+    uint16_t rd_high = (s1_high_s48 >> (shamt & 0x1F)) & 0xFFFF;
+
+    rd = ((uint32_t)rd_high << 16) | rd_low;
+    return rd;
+}
+
+/**
+ * PNSRARI.H - Narrowing arithmetic shift right with rounding
+ * immediate (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsrari_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = (s1 >> (i * 32)) & 0xFFFFFFFF;
+        int64_t s1_w_s64 = (int64_t)(int32_t)s1_w;
+        int64_t s1_w_s48 = (s1_w_s64 << 16) >> 16;
+        uint64_t shx_49bit = ((uint64_t)s1_w_s48 << 1);
+        uint32_t shx = (shx_49bit >> (shamt & 0x1F)) & 0x1FFFF;
+        rd |= ((uint16_t)((shx + 1) >> 1)) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PNSRL.HS - Narrowing logical shift right from register
+ * (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsrl_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    uint32_t s1_low  = (uint32_t)(s1 & 0xFFFFFFFF);
+    uint32_t s1_high = (uint32_t)((s1 >> 32) & 0xFFFFFFFF);
+
+    uint16_t rd_low  = (s1_low  >> (shamt & 0x1F)) & 0xFFFF;
+    uint16_t rd_high = (s1_high >> (shamt & 0x1F)) & 0xFFFF;
+
+    rd = ((uint32_t)rd_high << 16) | rd_low;
+    return rd;
+}
+
+/**
+ * PNSRA.HS - Narrowing arithmetic shift right from register
+ * (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsra_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    uint32_t s1_low  = (uint32_t)(s1 & 0xFFFFFFFF);
+    uint32_t s1_high = (uint32_t)((s1 >> 32) & 0xFFFFFFFF);
+
+    uint16_t rd_low  = (s1_low  >> (shamt & 0x1F)) & 0xFFFF;
+    uint16_t rd_high = (s1_high >> (shamt & 0x1F)) & 0xFFFF;
+
+    rd = ((uint32_t)rd_high << 16) | rd_low;
+    return rd;
+}
+
+/**
+ * PNSRAR.HS - Narrowing arithmetic shift right with rounding
+ * from register (64-bit to 32-bit, word to halfword)
+ */
+uint32_t HELPER(pnsrar_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = (s1 >> (i * 32)) & 0xFFFFFFFF;
+        int64_t s1_w_s64 = (int64_t)(int32_t)s1_w;
+        int64_t s1_w_s48 = (s1_w_s64 << 16) >> 16;
+        uint64_t shx_49bit = ((uint64_t)s1_w_s48 << 1);
+        uint32_t shx = (shx_49bit >> (shamt & 0x1F)) & 0x1FFFF;
+        rd |= ((uint16_t)((shx + 1) >> 1)) << (i * 16);
+    }
+
+    return rd;
+}
+
+/**
+ * PNCLIP.HS - Narrowing signed clip from register shift (word to halfword)
+ * For each word: arithmetic right shift, clip to signed 16-bit
+ *   shx = (int32_t)rs1[i] >> shamt
+ *   result = sat16(shx)
+ */
+uint32_t HELPER(pnclip_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+    uint8_t shift = shamt & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = EXTRACT32(s1, i);
+        int64_t s1_w_s64 = (int64_t)(int32_t)s1_w;
+        int32_t shx = (int32_t)(s1_w_s64 >> shift);
+        uint16_t result;
+
+        if (shx < -32768) {
+            sat = 1;
+            result = 0x8000;
+        } else if (shx > 32767) {
+            sat = 1;
+            result = 0x7FFF;
+        } else {
+            result = (uint16_t)shx;
+        }
+
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPR.HS - Narrowing signed clip with rounding
+ * from register (word to halfword)
+ * For each word: ((int32_t)rs1[i] << 1) >> shamt, round, clip to signed 16-bit
+ *   shx_65bit = ((int64_t)rs1[i] << 1)
+ *   shx = (shx_65bit >> shamt) & mask
+ *   round = (shx + 1) >> 1
+ *   result = sat16(round)
+ */
+uint32_t HELPER(pnclipr_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+    uint8_t shift = shamt & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = EXTRACT32(s1, i);
+        int64_t s1_w_s64 = (int64_t)(int32_t)s1_w;
+        __uint128_t shx_65bit = (__uint128_t)s1_w_s64 << 1;
+        uint64_t shx = (uint64_t)(shx_65bit >> shift) & 0x1FFFFFFFF;
+        int32_t round_shx = (int32_t)((shx + 1) >> 1);
+        uint16_t result;
+
+        if (round_shx < -32768) {
+            sat = 1;
+            result = 0x8000;
+        } else if (round_shx > 32767) {
+            sat = 1;
+            result = 0x7FFF;
+        } else {
+            result = (uint16_t)round_shx;
+        }
+
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPI.H - Narrowing signed clip from immediate shift (word to halfword)
+ * For each word: rs1[i] >> imm, clip to signed 16-bit
+ */
+uint32_t HELPER(pnclipi_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return HELPER(pnclip_hs)(env, s1, shamt);
+}
+
+/**
+ * PNCLIPRI.H - Narrowing signed clip with rounding
+ * from immediate shift (word to halfword)
+ * For each word: (rs1[i] << 1) >> imm, round, clip to signed 16-bit
+ */
+uint32_t HELPER(pnclipri_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return HELPER(pnclipr_hs)(env, s1, shamt);
+}
+
+/**
+ * PNCLIPU.HS - Narrowing unsigned clip from register shift (word to halfword)
+ * For each word: shift right, clip to unsigned 16-bit
+ *   shx = rs1[i] >> shamt
+ *   result = (shx > 65535) ? 0xFFFF : shx
+ */
+uint32_t HELPER(pnclipu_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+    uint8_t shift = shamt & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = EXTRACT32(s1, i);
+        uint32_t shx = s1_w >> shift;
+        uint16_t result;
+
+        if (shx > 65535) {
+            sat = 1;
+            result = 0xFFFF;
+        } else {
+            result = (uint16_t)shx;
+        }
+
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPRU.HS - Narrowing unsigned clip with rounding
+ * from register (word to halfword)
+ * For each word: (rs1[i] << 1) >> shamt, round, clip to unsigned 16-bit
+ *   shx = ((rs1[i] << 1) >> shamt)
+ *   round = (shx + 1) >> 1
+ *   result = (round > 65535) ? 0xFFFF : round
+ */
+uint32_t HELPER(pnclipru_hs)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint32_t rd = 0;
+    int sat = 0;
+    uint8_t shift = shamt & 0x1F;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t s1_w = EXTRACT32(s1, i);
+        uint64_t shx_33bit = (uint64_t)s1_w << 1;
+        uint64_t shx = shx_33bit >> shift;
+        uint32_t round_shx = (uint32_t)((shx + 1) >> 1);
+        uint16_t result;
+
+        if (round_shx > 65535) {
+            sat = 1;
+            result = 0xFFFF;
+        } else {
+            result = (uint16_t)round_shx;
+        }
+
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPIU.H - Narrowing unsigned clip from immediate shift (word to halfword)
+ * For each word: rs1[i] >> imm, clip to unsigned 16-bit
+ */
+uint32_t HELPER(pnclipiu_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return HELPER(pnclipu_hs)(env, s1, shamt);
+}
+
+/**
+ * PNCLIPRIU.H - Narrowing unsigned clip with rounding
+ * from immediate shift (word to halfword)
+ * For each word: (rs1[i] << 1) >> imm, round, clip to unsigned 16-bit
+ */
+uint32_t HELPER(pnclipriu_h)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return HELPER(pnclipru_hs)(env, s1, shamt);
+}
+
+/**
+ * NSRLI - Narrowing logical shift right immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsrli)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return (s1 >> (shamt & 0x3F)) & 0xFFFFFFFF;
+}
+
+/**
+ * NSRAI - Narrowing arithmetic shift right immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsrai)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    __int128_t s1_s96 = (s1_s128 << 32) >> 32;
+    return (uint32_t)(s1_s96 >> (shamt & 0x3F)) & 0xFFFFFFFF;
+}
+
+/**
+ * NSRARI - Narrowing arithmetic shift right with rounding
+ * immediate (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsrari)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    __int128_t s1_s96 = (s1_s128 << 32) >> 32;
+    __uint128_t shx_97bit = ((__uint128_t)s1_s96 << 1);
+    uint64_t shx = (uint64_t)(shx_97bit >> (shamt & 0x3F)) & 0x1FFFFFFFF;
+    return (uint32_t)((shx + 1) >> 1);
+}
+
+/**
+ * NSRL - Narrowing logical shift right from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsrl)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    return (s1 >> (shamt & 0x3F)) & 0xFFFFFFFF;
+}
+
+/**
+ * NSRA - Narrowing arithmetic shift right from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsra)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    __int128_t s1_s96 = (s1_s128 << 32) >> 32;
+    return (uint32_t)(s1_s96 >> (shamt & 0x3F)) & 0xFFFFFFFF;
+}
+
+/**
+ * NSRAR - Narrowing arithmetic shift right with rounding
+ * from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nsrar)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    __int128_t s1_s96 = (s1_s128 << 32) >> 32;
+    __uint128_t shx_97bit = ((__uint128_t)s1_s96 << 1);
+    uint64_t shx = (uint64_t)(shx_97bit >> (shamt & 0x3F)) & 0x1FFFFFFFF;
+    return (uint32_t)((shx + 1) >> 1);
+}
+
+/**
+ * NCLIPI - Narrowing clip signed with immediate shift (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipi)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    int64_t shx = (int64_t)(s1_s128 >> (shamt & 0x3F));
+
+    if (shx < -2147483648LL) {
+        env->vxsat = 1;
+        return 0x80000000U;
+    } else if (shx > 2147483647LL) {
+        env->vxsat = 1;
+        return 0x7FFFFFFFU;
+    } else {
+        return (uint32_t)(shx & 0xFFFFFFFF);
+    }
+}
+
+/**
+ * NCLIPRI - Narrowing clip signed with rounding and immediate
+ * shift (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipri)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    typedef struct {
+        __uint128_t low;
+        uint8_t high;
+    } Uint129;
+
+    Uint129 left_shift_1(__int128_t s1_s128)
+    {
+        Uint129 result;
+        __uint128_t us1 = (__uint128_t)s1_s128;
+        result.low = us1 << 1;
+        result.high = (us1 >> 127) & 0x1;
+        return result;
+    }
+
+    Uint129 right_shift(Uint129 val, uint32_t smt)
+    {
+        Uint129 result;
+        if (smt == 0) {
+            return val;
+        } else if (smt >= 129) {
+            result.low = 0;
+            result.high = 0;
+        } else if (smt == 128) {
+            result.low = val.high;
+            result.high = 0;
+        } else {
+            result.low = (val.low >> smt) |
+                         ((__uint128_t)val.high << (128 - smt));
+            result.high = (val.high >> smt);
+        }
+        return result;
+    }
+
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    Uint129 shx_129bit = left_shift_1(s1_s128);
+    Uint129 shx = right_shift(shx_129bit, shamt & 0x3F);
+    int64_t round_shx = (int64_t)((shx.low + 1) >> 1);
+
+    if (round_shx < -2147483648LL) {
+        env->vxsat = 1;
+        return 0x80000000U;
+    } else if (round_shx > 2147483647LL) {
+        env->vxsat = 1;
+        return 0x7FFFFFFFU;
+    } else {
+        return (uint32_t)round_shx;
+    }
+}
+
+/**
+ * NCLIPIU - Narrowing clip unsigned with immediate shift (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipiu)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint64_t shx = s1 >> (shamt & 0x3F);
+
+    if (shx > 4294967295ULL) {
+        env->vxsat = 1;
+        return 0xFFFFFFFFU;
+    } else {
+        return (uint32_t)(shx & 0xFFFFFFFF);
+    }
+}
+
+/**
+ * NCLIPRIU - Narrowing clip unsigned with rounding and immediate
+ * shift (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipriu)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __uint128_t shx_65bit = (s1 << 1);
+    __uint128_t shx = shx_65bit >> (shamt & 0x3F);
+    uint64_t round_shx = (shx + 1) >> 1;
+
+    if (round_shx > 4294967295ULL) {
+        env->vxsat = 1;
+        return 0xFFFFFFFFU;
+    } else {
+        return (uint32_t)(round_shx & 0xFFFFFFFF);
+    }
+}
+
+/**
+ * NCLIP - Narrowing clip signed from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclip)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    int64_t shx = (int64_t)(s1_s128 >> (shamt & 0x3F));
+
+    if (shx < -2147483648LL) {
+        env->vxsat = 1;
+        return 0x80000000U;
+    } else if (shx > 2147483647LL) {
+        env->vxsat = 1;
+        return 0x7FFFFFFFU;
+    } else {
+        return (uint32_t)(shx & 0xFFFFFFFF);
+    }
+}
+
+/**
+ * NCLIPR - Narrowing clip signed with rounding from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipr)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    typedef struct {
+        __uint128_t low;
+        uint8_t high;
+    } Uint129;
+
+    Uint129 left_shift_1(__int128_t s1_s128)
+    {
+        Uint129 result;
+        __uint128_t us1 = (__uint128_t)s1_s128;
+        result.low = us1 << 1;
+        result.high = (us1 >> 127) & 0x1;
+        return result;
+    }
+
+    Uint129 right_shift(Uint129 val, uint32_t smt)
+    {
+        Uint129 result;
+        if (smt == 0) {
+            return val;
+        } else if (smt >= 129) {
+            result.low = 0;
+            result.high = 0;
+        } else if (smt == 128) {
+            result.low = val.high;
+            result.high = 0;
+        } else {
+            result.low = (val.low >> smt) |
+                         ((__uint128_t)val.high << (128 - smt));
+            result.high = (val.high >> smt);
+        }
+        return result;
+    }
+
+    __int128_t s1_s128 = (__int128_t)((int64_t)s1);
+    Uint129 shx_129bit = left_shift_1(s1_s128);
+    Uint129 shx = right_shift(shx_129bit, shamt & 0x3F);
+    int64_t round_shx = (int64_t)((shx.low + 1) >> 1);
+
+    if (round_shx < -2147483648LL) {
+        env->vxsat = 1;
+        return 0x80000000U;
+    } else if (round_shx > 2147483647LL) {
+        env->vxsat = 1;
+        return 0x7FFFFFFFU;
+    } else {
+        return (uint32_t)round_shx;
+    }
+}
+
+/**
+ * NCLIPU - Narrowing clip unsigned from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipu)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    uint64_t shx = s1 >> (shamt & 0x3F);
+
+    if (shx > 4294967295ULL) {
+        env->vxsat = 1;
+        return 0xFFFFFFFFU;
+    } else {
+        return (uint32_t)(shx & 0xFFFFFFFF);
+    }
+}
+
+/**
+ * NCLIPRU - Narrowing clip unsigned with rounding
+ * from register (64-bit to 32-bit)
+ */
+uint32_t HELPER(nclipru)(CPURISCVState *env, uint64_t s1, uint32_t shamt)
+{
+    __uint128_t shx_65bit = (s1 << 1);
+    __uint128_t shx = shx_65bit >> (shamt & 0x3F);
+    uint64_t round_shx = (shx + 1) >> 1;
+
+    if (round_shx > 4294967295ULL) {
+        env->vxsat = 1;
+        return 0xFFFFFFFFU;
+    } else {
+        return (uint32_t)(round_shx & 0xFFFFFFFF);
+    }
+}
+
+/* Multiplication with Even-Odd Register Pairs as Destination (RV32 only) */
+
+/**
+ * PMQWACC.H - Packed Q-format halfword to word multiply accumulate
+ */
+uint64_t HELPER(pmqwacc_h)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h * (int64_t)s2_h;
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQRWACC.H - Packed Q-format halfword to word multiply
+ * accumulate with rounding
+ */
+uint64_t HELPER(pmqrwacc_h)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h * (int64_t)s2_h + (1LL << 14);
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PWMUL.B - Widening byte to halfword multiplication
+ */
+uint64_t HELPER(pwmul_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int8_t s1_b = (int8_t)EXTRACT8(rs1, i);
+        int8_t s2_b = (int8_t)EXTRACT8(rs2, i);
+        int16_t prod = (int16_t)s1_b * (int16_t)s2_b;
+        rd |= ((uint64_t)(uint16_t)prod) << (i * 16);
+    }
+    return rd;
+}
+
+/**
+ * PWMULSU.B - Widening signed x unsigned byte to halfword multiplication
+ */
+uint64_t HELPER(pwmulsu_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int8_t s1_b = (int8_t)EXTRACT8(rs1, i);
+        uint8_t s2_b = EXTRACT8(rs2, i);
+        int16_t prod = (int16_t)s1_b * (uint16_t)s2_b;
+        rd |= ((uint64_t)(uint16_t)prod) << (i * 16);
+    }
+    return rd;
+}
+
+/**
+ * PWMULU.B - Widening unsigned byte to halfword multiplication
+ */
+uint64_t HELPER(pwmulu_b)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint8_t s1_b = EXTRACT8(rs1, i);
+        uint8_t s2_b = EXTRACT8(rs2, i);
+        uint16_t prod = (uint16_t)s1_b * (uint16_t)s2_b;
+        rd |= ((uint64_t)prod) << (i * 16);
+    }
+    return rd;
+}
+
+/**
+ * PWMUL.H - Widening halfword to word multiplication
+ */
+uint64_t HELPER(pwmul_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i);
+        int16_t s2_h = (int16_t)EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)s1_h * (int32_t)s2_h;
+        rd |= ((uint64_t)(uint32_t)prod) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * PWMULSU.H - Widening signed x unsigned halfword to word multiplication
+ */
+uint64_t HELPER(pwmulsu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i);
+        uint16_t s2_h = EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)s1_h * (uint32_t)s2_h;
+        rd |= ((uint64_t)(uint32_t)prod) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * PWMULU.H - Widening unsigned halfword to word multiplication
+ */
+uint64_t HELPER(pwmulu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint16_t s1_h = EXTRACT16(rs1, i);
+        uint16_t s2_h = EXTRACT16(rs2, i);
+        uint32_t prod = (uint32_t)s1_h * (uint32_t)s2_h;
+        rd |= ((uint64_t)prod) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * PWMACC.H - Widening multiply accumulate (halfword to word)
+ */
+uint64_t HELPER(pwmacc_h)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i);
+        int16_t s2_h = (int16_t)EXTRACT16(rs2, i);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int32_t prod = (int32_t)s1_h * (int32_t)s2_h;
+        uint32_t res = (uint32_t)(d_w + prod);
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * PWMACCSU.H - Widening signed x unsigned multiply
+ * accumulate (halfword to word)
+ */
+uint64_t HELPER(pwmaccsu_h)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h = (int16_t)EXTRACT16(rs1, i);
+        uint16_t s2_h = EXTRACT16(rs2, i);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int32_t prod = (int32_t)s1_h * (uint32_t)s2_h;
+        uint32_t res = (uint32_t)(d_w + prod);
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * PWMACCU.H - Widening unsigned multiply accumulate (halfword to word)
+ */
+uint64_t HELPER(pwmaccu_h)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint16_t s1_h = EXTRACT16(rs1, i);
+        uint16_t s2_h = EXTRACT16(rs2, i);
+        uint32_t d_w = EXTRACT32(dest, i);
+        uint32_t prod = (uint32_t)s1_h * (uint32_t)s2_h;
+        uint32_t res = d_w + prod;
+        rd |= ((uint64_t)res) << (i * 32);
+    }
+    return rd;
+}
+
+/**
+ * MQWACC - Q-format word multiply accumulate
+ */
+uint64_t HELPER(mqwacc)(CPURISCVState *env, uint32_t rs1,
+                        uint32_t rs2, uint64_t dest)
+{
+    int64_t s1 = (int64_t)(int32_t)rs1;
+    int64_t s2 = (int64_t)(int32_t)rs2;
+    int64_t d = (int64_t)dest;
+    __int128_t prod = (__int128_t)s1 * (__int128_t)s2;
+    return (uint64_t)(d + (int64_t)(prod >> 31));
+}
+
+/**
+ * MQRWACC - Q-format word multiply accumulate with rounding
+ */
+uint64_t HELPER(mqrwacc)(CPURISCVState *env, uint32_t rs1,
+                         uint32_t rs2, uint64_t dest)
+{
+    int64_t s1 = (int64_t)(int32_t)rs1;
+    int64_t s2 = (int64_t)(int32_t)rs2;
+    int64_t d = (int64_t)dest;
+    __int128_t prod = (__int128_t)s1 * (__int128_t)s2 + (1LL << 30);
+    return (uint64_t)(d + (int64_t)(prod >> 31));
+}
+
+/**
+ * WMUL - Widening signed multiplication (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmul)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return (uint64_t)((int64_t)(int32_t)rs1 * (int64_t)(int32_t)rs2);
+}
+
+/**
+ * WMULSU - Widening signed x unsigned multiplication (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmulsu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return (uint64_t)((int64_t)(int32_t)rs1 * (uint64_t)rs2);
+}
+
+/**
+ * WMULU - Widening unsigned multiplication (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmulu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return (uint64_t)rs1 * (uint64_t)rs2;
+}
+
+/**
+ * WMACC - Widening multiply accumulate signed (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmacc)(CPURISCVState *env, uint32_t rs1,
+                       uint32_t rs2, uint64_t dest)
+{
+    return (uint64_t)((int64_t)(int32_t)rs1 *
+                      (int64_t)(int32_t)rs2 + (int64_t)dest);
+}
+
+/**
+ * WMACCSU - Widening multiply accumulate signed x unsigned
+ * (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmaccsu)(CPURISCVState *env, uint32_t rs1,
+                         uint32_t rs2, uint64_t dest)
+{
+    return (uint64_t)((int64_t)(int32_t)rs1 * (uint64_t)rs2 + (int64_t)dest);
+}
+
+/**
+ * WMACCU - Widening multiply accumulate unsigned (32-bit to 64-bit, RV32)
+ */
+uint64_t HELPER(wmaccu)(CPURISCVState *env, uint32_t rs1,
+                        uint32_t rs2, uint64_t dest)
+{
+    return (uint64_t)rs1 * (uint64_t)rs2 + (uint64_t)dest;
+}
+
+/**
+ * PM2WADD.H - Add two widening products (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wadd_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t prod0 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    return (uint64_t)(prod0 + prod1);
+}
+
+/**
+ * PM2WADDSU.H - Add two widening products
+ * (signed x unsigned, halfword to doubleword)
+ */
+uint64_t HELPER(pm2waddsu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    int64_t prod0 = (int64_t)s1_h0 * (uint64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (uint64_t)s2_h1;
+    return (uint64_t)(prod0 + prod1);
+}
+
+/**
+ * PM2WADDU.H - Add two widening products (unsigned, halfword to doubleword)
+ */
+uint64_t HELPER(pm2waddu_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s1_h1 = EXTRACT16(rs1, 1);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint64_t prod0 = (uint64_t)s1_h0 * (uint64_t)s2_h0;
+    uint64_t prod1 = (uint64_t)s1_h1 * (uint64_t)s2_h1;
+    return prod0 + prod1;
+}
+
+/**
+ * PM2WADDA.H - Add two widening products with accumulate
+ * (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wadda_h)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = EXTRACT16(rs1, 0);
+    int16_t s1_h1 = EXTRACT16(rs1, 1);
+    int16_t s2_h0 = EXTRACT16(rs2, 0);
+    int16_t s2_h1 = EXTRACT16(rs2, 1);
+    int64_t d_h = (int64_t)dest;
+    int64_t mul_00 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t mul_11 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    return (uint64_t)(d_h + mul_00 + mul_11);
+}
+
+/**
+ * PM2WADDASU.H - Add two widening products with accumulate
+ * (signed x unsigned, halfword to doubleword)
+ */
+uint64_t HELPER(pm2waddasu_h)(CPURISCVState *env, uint32_t rs1,
+                              uint32_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    uint16_t s2_h0 = (uint16_t)EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = (uint16_t)EXTRACT16(rs2, 1);
+    int64_t d_h = (int64_t)dest;
+    int64_t mul_00 = (int64_t)s1_h0 * (uint64_t)s2_h0;
+    int64_t mul_11 = (int64_t)s1_h1 * (uint64_t)s2_h1;
+    return (uint64_t)(d_h + mul_00 + mul_11);
+}
+
+/**
+ * PM2WADDAU.H - Add two widening products with accumulate
+ * (unsigned, halfword to doubleword)
+ */
+uint64_t HELPER(pm2waddau_h)(CPURISCVState *env, uint32_t rs1,
+                             uint32_t rs2, uint64_t dest)
+{
+    uint16_t s1_h0 = (uint16_t)EXTRACT16(rs1, 0);
+    uint16_t s1_h1 = (uint16_t)EXTRACT16(rs1, 1);
+    uint16_t s2_h0 = (uint16_t)EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = (uint16_t)EXTRACT16(rs2, 1);
+    uint64_t d_h = (uint64_t)dest;
+    uint64_t mul_00 = (uint64_t)s1_h0 * (uint64_t)s2_h0;
+    uint64_t mul_11 = (uint64_t)s1_h1 * (uint64_t)s2_h1;
+    return (uint64_t)(d_h + mul_00 + mul_11);
+}
+
+/**
+ * PM2WADD.HX - Add two widening cross products (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wadd_hx)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t prod01 = (int64_t)s1_h0 * (int64_t)s2_h1;
+    int64_t prod10 = (int64_t)s1_h1 * (int64_t)s2_h0;
+    return (uint64_t)(prod01 + prod10);
+}
+
+/**
+ * PM2WADDA.HX - Add two widening cross products with accumulate
+ * (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wadda_hx)(CPURISCVState *env, uint32_t rs1,
+                             uint32_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod01 = (int64_t)s1_h0 * (int64_t)s2_h1;
+    int64_t prod10 = (int64_t)s1_h1 * (int64_t)s2_h0;
+    return (uint64_t)(d + prod01 + prod10);
+}
+
+/**
+ * PM2WSUB.H - Subtract two widening products (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wsub_h)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t prod0 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    return (uint64_t)(prod0 - prod1);
+}
+
+/**
+ * PM2WSUB.HX - Subtract two widening cross products (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wsub_hx)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t prod01 = (int64_t)s1_h0 * (int64_t)s2_h1;
+    int64_t prod10 = (int64_t)s1_h1 * (int64_t)s2_h0;
+    return (uint64_t)(prod01 - prod10);
+}
+
+/**
+ * PM2WSUBA.H - Subtract two widening products with accumulate
+ * (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wsuba_h)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    return (uint64_t)(d + prod0 - prod1);
+}
+
+/**
+ * PM2WSUBA.HX - Subtract two widening cross products with accumulate
+ * (halfword to doubleword)
+ */
+uint64_t HELPER(pm2wsuba_hx)(CPURISCVState *env, uint32_t rs1,
+                             uint32_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod01 = (int64_t)s1_h0 * (int64_t)s2_h1;
+    int64_t prod10 = (int64_t)s1_h1 * (int64_t)s2_h0;
+    return (uint64_t)(d + prod01 - prod10);
+}
-- 
2.34.1


