Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A5C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jlE-0006Jb-Bz; Wed, 16 Sep 2026 03:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkv-0005w5-If; Wed, 16 Sep 2026 03:08:37 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkr-0008KA-0Y; Wed, 16 Sep 2026 03:08:32 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S18;
 Wed, 16 Sep 2026 15:08:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 16/19] target/riscv: Add packed SIMD load-replicate
 instructions
Date: Wed, 16 Sep 2026 07:07:18 +0000
Message-Id: <20260916070721.3279229-17-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S18
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4rtFyfWFWDJw1DKFW5trb_yoWrWw4DpF
 48Kr17KrW8Jry7AF1fKr45Jr17XrsxG3yUJrnxXwnxZF45JFyrA34Ut3yUKrWYqFyDWFWU
 WF1qyryUuaykJwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
 67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULSdkUUUUU=
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

Implement packed load-immediate and load-upper-immediate operations.
Cover byte, halfword, and word elements across the supported register
widths. Add the associated decode entries, translators and helpers.

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
index f9c3adc5ffc..b7651bdcba3 100644
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
@@ -1617,3 +1626,10 @@ pm4addu_h       10100 11 ..... ..... 101 ..... 0111011 @r
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
index eba377fac6b..c172c8e4e0a 100644
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


