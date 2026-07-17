Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C6C44517
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfb8-0002pq-NH; Fri, 17 Jul 2026 06:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfb6-0002nk-Ow; Fri, 17 Jul 2026 06:15:12 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfb4-0007Zv-5M; Fri, 17 Jul 2026 06:15:12 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S18;
 Fri, 17 Jul 2026 18:07:27 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/18] target/riscv: Add packed SIMD load-replicate
 instructions
Date: Fri, 17 Jul 2026 10:07:09 +0000
Message-Id: <246659451a5aac58f61f92751baac9bf57e4ba54.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S18
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUKFWrGFW8JFyDWr1rWFg_yoW5Kr1xpF
 18Gr17KrW8JrW7AFyfKr45Jr13JrsxG3yUGrnxX3Z3Za15JFWrA34UK3y7GrWYqFyDWFWU
 WF1qyryUWa95JwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
 8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
 JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JULvtZUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
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

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/insn32.decode                  | 16 ++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 24 +++++++++++++++++++++
 target/riscv/tcg/translate.c                |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8720fedb592..403e17e439d 100644
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
@@ -1614,3 +1623,10 @@ pm4addu_h       10100 11 ..... ..... 101 ..... 0111011 @r
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
index 6c344a66dc8..4d5fc230d2e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -902,3 +902,27 @@ GEN_SIMD_TRANS_ACC_64(pm4adda_h)
 GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
 GEN_SIMD_TRANS_ACC_64(pm4addau_h)
 
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
+GEN_PLI(pli_b, , target_long, TARGET_LONG_SIZE, 8, a->imm)
+GEN_PLI(pli_h, , target_long, TARGET_LONG_SIZE / 2, 16,
+        a->imm & 0xFFFF)
+GEN_PLI(plui_h, , target_long, TARGET_LONG_SIZE / 2, 16,
+        a->imm & 0xFFFF)
+GEN_PLI(pli_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_SIZE / 4, 32,
+        a->imm & 0xFFFFFFFF)
+GEN_PLI(plui_w, REQUIRE_64BIT(ctx); , int64_t, TARGET_LONG_SIZE / 4, 32,
+        a->imm & 0xFFFFFFFF)
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 0df9d4190f1..668ec3120af 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -790,7 +790,9 @@ EX_SH(1)
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


