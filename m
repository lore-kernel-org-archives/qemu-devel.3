Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FF8C44517
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfTm-0003ZL-5M; Fri, 17 Jul 2026 06:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTj-0003Xg-74; Fri, 17 Jul 2026 06:07:35 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTg-0006aV-89; Fri, 17 Jul 2026 06:07:34 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S6;
 Fri, 17 Jul 2026 18:07:24 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/18] target/riscv: Add packed SIMD averaging and rounding
 instructions
Date: Fri, 17 Jul 2026 10:06:57 +0000
Message-Id: <d6d31bfcc7d3490b8fdf5dc5c7d0e2c4480a16f9.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW7GFW8JryfGr4DtrWfuFg_yoWxJr1Dpa
 n7Gry3JrW8tFWaqFySkr15Jw13WrsxK3yUur43KFyfZay5JFyfJw1Utr4aka13XryDWr1j
 9ayFyr98AFWFg3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
 xan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x0JULvtZUUUUU=
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
 target/riscv/helper.h                       | 18 ++++++++++
 target/riscv/insn32.decode                  | 26 ++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 18 ++++++++++
 target/riscv/tcg/psimd_helper.c             | 40 +++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eebb2febd95..7256f776ae6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1399,3 +1399,21 @@ DEF_HELPER_3(sati_32, i32, env, i32, i32)
 DEF_HELPER_3(usati_32, i32, env, i32, i32)
 DEF_HELPER_3(sati_64, i64, env, i64, i64)
 DEF_HELPER_3(usati_64, i64, env, i64, i64)
+
+/* Packed SIMD - Averaging and Rounding Operations */
+DEF_HELPER_3(paadd_b, tl, env, tl, tl)
+DEF_HELPER_3(paadd_h, tl, env, tl, tl)
+DEF_HELPER_3(paadd_w, i64, env, i64, i64)
+DEF_HELPER_3(paaddu_b, tl, env, tl, tl)
+DEF_HELPER_3(paaddu_h, tl, env, tl, tl)
+DEF_HELPER_3(paaddu_w, i64, env, i64, i64)
+DEF_HELPER_3(aadd, i32, env, i32, i32)
+DEF_HELPER_3(aaddu, i32, env, i32, i32)
+DEF_HELPER_3(pasub_b, tl, env, tl, tl)
+DEF_HELPER_3(pasub_h, tl, env, tl, tl)
+DEF_HELPER_3(pasub_w, i64, env, i64, i64)
+DEF_HELPER_3(pasubu_b, tl, env, tl, tl)
+DEF_HELPER_3(pasubu_h, tl, env, tl, tl)
+DEF_HELPER_3(pasubu_w, i64, env, i64, i64)
+DEF_HELPER_3(asub, i32, env, i32, i32)
+DEF_HELPER_3(asubu, i32, env, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8da13669d73..005cc055b8a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1147,3 +1147,29 @@ pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
 }
 sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
 usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
+
+# Packed SIMD - Averaging and Rounding Operations
+paadd_b    1001110 ..... ..... 000 ..... 0111011 @r
+paadd_h    1001100 ..... ..... 000 ..... 0111011 @r
+{
+  aadd     1001101 ..... ..... 000 ..... 0111011 @r
+  paadd_w  1001101 ..... ..... 000 ..... 0111011 @r
+}
+paaddu_b   1011110 ..... ..... 000 ..... 0111011 @r
+paaddu_h   1011100 ..... ..... 000 ..... 0111011 @r
+{
+  aaddu    1011101 ..... ..... 000 ..... 0111011 @r
+  paaddu_w 1011101 ..... ..... 000 ..... 0111011 @r
+}
+pasub_b    1101110 ..... ..... 000 ..... 0111011 @r
+pasub_h    1101100 ..... ..... 000 ..... 0111011 @r
+{
+  asub     1101101 ..... ..... 000 ..... 0111011 @r
+  pasub_w  1101101 ..... ..... 000 ..... 0111011 @r
+}
+pasubu_b   1111110 ..... ..... 000 ..... 0111011 @r
+pasubu_h   1111100 ..... ..... 000 ..... 0111011 @r
+{
+  asubu    1111101 ..... ..... 000 ..... 0111011 @r
+  pasubu_w 1111101 ..... ..... 000 ..... 0111011 @r
+}
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 056ccfb486e..43c59aef182 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -545,3 +545,21 @@ GEN_SIMD_TRANS_IMM_32_VXSAT(usati_32)
 GEN_SIMD_TRANS_IMM_64_VXSAT(sati_64)
 GEN_SIMD_TRANS_IMM_64_VXSAT(usati_64)
 
+/* Packed SIMD - Averaging and Rounding Operations */
+GEN_SIMD_TRANS(paadd_b)
+GEN_SIMD_TRANS(paadd_h)
+GEN_SIMD_TRANS_64(paadd_w)
+GEN_SIMD_TRANS(paaddu_b)
+GEN_SIMD_TRANS(paaddu_h)
+GEN_SIMD_TRANS_64(paaddu_w)
+GEN_SIMD_TRANS_32(aadd)
+GEN_SIMD_TRANS_32(aaddu)
+GEN_SIMD_TRANS(pasub_b)
+GEN_SIMD_TRANS(pasub_h)
+GEN_SIMD_TRANS_64(pasub_w)
+GEN_SIMD_TRANS(pasubu_b)
+GEN_SIMD_TRANS(pasubu_h)
+GEN_SIMD_TRANS_64(pasubu_w)
+GEN_SIMD_TRANS_32(asub)
+GEN_SIMD_TRANS_32(asubu)
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 52c58e0287e..162041a8f18 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -1768,3 +1768,43 @@ GEN_PSIMD_SATI(sati_64, uint64_t, int64_t, int64_t,
 GEN_PSIMD_USATI(usati_64, uint64_t, int64_t, uint64_t, uint64_t,
                 EXTRACT64, INSERT64, ELEMS_D, 1ULL)
 
+/* Averaging Operations (non-saturating) */
+
+GEN_PSIMD_AVG_BINOP(paadd_b, target_ulong, int8_t, int16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paadd_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paadd_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(paaddu_b, target_ulong, uint8_t, uint16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paaddu_h, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paaddu_w, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(aadd, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(aaddu, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(pasub_b, target_ulong, int8_t, int16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasub_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasub_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+GEN_PSIMD_AVG_BINOP(pasubu_b, target_ulong, uint8_t, uint16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasubu_h, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasubu_w, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+GEN_PSIMD_AVG_BINOP(asub, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(asubu, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
-- 
2.34.1


