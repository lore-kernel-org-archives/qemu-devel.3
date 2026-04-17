Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D174F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjm-0001P9-A8; Fri, 17 Apr 2026 06:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjk-0001OZ-4O; Fri, 17 Apr 2026 06:47:48 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjh-000827-W2; Fri, 17 Apr 2026 06:47:47 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S14;
 Fri, 17 Apr 2026 18:47:22 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/14] target/riscv: rvp: add load and replicate instructions.
Date: Fri, 17 Apr 2026 18:46:49 +0800
Message-Id: <20260417104652.17857-13-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXry3Kr4xuF1DXrWDKw18Grg_yoWrAr4fpF
 48Gr17GrWkGr13AF93Kr45Jr13Wrs5G34UG3sxW3Z7AF45JFWrA348Kw43tr4FqryDWFWU
 GF1UAryDuFZ5JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
 W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqLvNU
 UUUU=
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
 target/riscv/insn32.decode              | 16 ++++++
 target/riscv/insn_trans/trans_rvp.c.inc | 67 +++++++++++++++++++++++++
 target/riscv/translate.c                |  2 +
 3 files changed, 85 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ebfbf8c799..b1bde37de4 100644
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
@@ -64,6 +68,7 @@
 &k_aes     shamt rs2 rs1 rd
 &mop5 imm rd rs1
 &mop3 imm rd rs1 rs2
+&p_l  imm rd
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -113,6 +118,10 @@
 @p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
 @p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
 @p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
+@p_l1  ........ ........ .... ..... ....... &p_l      imm=%imm_p_l1         %rd
+@p_l2  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l2         %rd
+@p_l3  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l3         %rd
+@p_l4  ....... .......... ... ..... ....... &p_l      imm=%imm_p_l4         %rd
 
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
@@ -1596,3 +1605,10 @@ pm4addu_h       10100 11 ..... ..... 101 ..... 0111011 @r
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
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index 86071d71f7..b82774e00f 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -906,3 +906,70 @@ GEN_SIMD_TRANS_64(pm4addu_h)
 GEN_SIMD_TRANS_ACC_64(pm4adda_h)
 GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
 GEN_SIMD_TRANS_ACC_64(pm4addau_h)
+
+static bool trans_pli_b(DisasContext *ctx, arg_pli_b * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE) {
+        imm = ((imm << 8) + a->imm);
+        i++;
+    }
+    gen_set_gpri(ctx, a->rd, imm);
+    return true;
+}
+
+static bool trans_pli_h(DisasContext *ctx, arg_pli_h * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 2) {
+        imm = (imm << 16) + (a->imm & 0xFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, a->rd, imm);
+    return true;
+}
+
+static bool trans_plui_h(DisasContext *ctx, arg_plui_h * a)
+{
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    target_long imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 2) {
+        imm = (imm << 16) + (a->imm & 0xFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, a->rd, imm);
+    return true;
+}
+
+static bool trans_pli_w(DisasContext *ctx, arg_pli_w * a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    int64_t imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 4) {
+        imm = (imm << 32) + (a->imm & 0xFFFFFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, a->rd, imm);
+    return true;
+}
+
+static bool trans_plui_w(DisasContext *ctx, arg_plui_w * a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_EXT(ctx, RVP);
+    int i = 1;
+    int64_t imm = a->imm;
+    while (i < TARGET_LONG_SIZE / 4) {
+        imm = (imm << 32) + (a->imm & 0xFFFFFFFF);
+        i++;
+    }
+    gen_set_gpri(ctx, a->rd, imm);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index de3ec7a7ec..04efc7aced 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -796,7 +796,9 @@ EX_SH(1)
 EX_SH(2)
 EX_SH(3)
 EX_SH(4)
+EX_SH(6)
 EX_SH(12)
+EX_SH(22)
 
 #define REQUIRE_EXT(ctx, ext) do { \
     if (!has_ext(ctx, ext)) {      \
-- 
2.34.1


