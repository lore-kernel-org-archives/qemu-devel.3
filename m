Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5428606A33F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwul-0005z0-Dt; Thu, 19 Nov 2026 02:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwuF-0005m7-0m; Thu, 19 Nov 2026 02:50:08 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwu9-0007Eu-TY; Thu, 19 Nov 2026 02:50:05 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S18;
 Thu, 19 Nov 2026 15:44:06 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 16/20] target/riscv: Add packed SIMD load-replicate
 instructions
Date: Thu, 19 Nov 2026 07:43:36 +0000
Message-ID: <20261119074345.866125-17-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S18
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4rtFyfWFWDJw1DKFW5trb_yoWrWw1DpF
 48Kr17KrW8Jry3AF93Kr45Jr13XrsxG3yUJwnxXw15Za15JFyrA34jk3yUKrW5XFyDWFyU
 W3WqyryDuaykJwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
 8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7
 JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUHE__UUUUU=
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.993,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement packed load-immediate and load-upper-immediate operations.
Cover byte, halfword, and word elements across the supported register
widths. Add the associated decode entries, translators.

These instructions construct an element-sized value from the encoded
immediate and replicate it into every packed destination element.
PLI.H and PLI.W sign-extend their 10-bit immediates, while PLUI.H and
PLUI.W place their immediates in the upper bits of each element and
clear the lower bits.  These operations do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/insn32.decode                  | 16 +++++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 25 +++++++++++++++++++++
 target/riscv/tcg/translate.c                |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4d77bb9c35..e1019eca62 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -44,6 +44,10 @@
 %imm_p_ui16 20:4
 %imm_p_ui32 20:5
 %imm_p_ui64 20:6
+%imm_p_l1  16:8
+%imm_p_l2  15:s1 16:9
+%imm_p_l3  15:s9 24:1              !function=ex_shift_6
+%imm_p_l4  15:s9 24:1              !function=ex_shift_22
 
 # Argument sets:
 &empty
@@ -53,6 +57,7 @@
 &r    rd rs1 rs2
 &r2   rd rs1
 &r2_s rs1 rs2
+&p_l  imm rd
 &s    imm rs1 rs2
 &u    imm rd
 &shift     shamt rs1 rd
@@ -114,6 +119,10 @@
 @p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
 @p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
 @p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
+@p_l1  ........ ........ .... ..... ....... &p_l      imm=%imm_p_l1         %rd
+@p_l2  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l2         %rd
+@p_l3  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l3         %rd
+@p_l4  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l4         %rd
 
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
@@ -1628,3 +1637,10 @@ pm4addu_h       10100 11 ..... ..... 101 ..... 0111011 @r
 pm4adda_h       10001 11 ..... ..... 101 ..... 0111011 @r
 pm4addasu_h     11101 11 ..... ..... 101 ..... 0111011 @r
 pm4addau_h      10101 11 ..... ..... 101 ..... 0111011 @r
+
+# Packed SIMD - Load and Replicate instructions
+pli_b    10110100 ........ 0010 ..... 0011011 @p_l1
+pli_h    1011000 .......... 010 ..... 0011011 @p_l2
+plui_h   1111000 .......... 010 ..... 0011011 @p_l3
+pli_w    1011001 ..... ..... 010 ..... 0011011 @p_l2
+plui_w   1111001 ..... ..... 010 ..... 0011011 @p_l4
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index eba377fac6..ccb02b78af 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -924,3 +924,28 @@ GEN_SIMD_TRANS_64(pm4addu_h)
 GEN_SIMD_TRANS_ACC_64(pm4adda_h)
 GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
 GEN_SIMD_TRANS_ACC_64(pm4addau_h)
+
+#define GEN_PLI(NAME, PRE_REQ, IMM_TYPE, LIMIT, SHIFT, ADDEND) \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)    \
+{                                                              \
+    PRE_REQ                                                    \
+    REQUIRE_RVP(ctx);                                          \
+    int i = 1;                                                 \
+    IMM_TYPE imm = a->imm;                                     \
+    while (i < (LIMIT)) {                                      \
+        imm = (imm << (SHIFT)) + (ADDEND);                     \
+        i++;                                                   \
+    }                                                          \
+    gen_set_gpri(ctx, a->rd, imm);                             \
+    return true;                                               \
+}
+
+GEN_PLI(pli_b, , target_long, TARGET_LONG_BITS / 8, 8, a->imm)
+GEN_PLI(pli_h, , target_long, TARGET_LONG_BITS / 16, 16,
+        a->imm & 0xFFFF)
+GEN_PLI(plui_h, , target_long, TARGET_LONG_BITS / 16, 16,
+        a->imm & 0xFFFF)
+GEN_PLI(pli_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_BITS / 32, 32,
+        a->imm & 0xFFFFFFFF)
+GEN_PLI(plui_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_BITS / 32, 32,
+        a->imm & 0xFFFFFFFF)
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 6db8004aff..d415d57171 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -799,7 +799,9 @@ EX_SH(1)
 EX_SH(2)
 EX_SH(3)
 EX_SH(4)
+EX_SH(6)
 EX_SH(12)
+EX_SH(22)
 
 #define REQUIRE_EXT(ctx, ext) do { \
     if (!has_ext(ctx, ext)) {      \
-- 
2.53.0


