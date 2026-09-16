Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6299C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkp-0005oy-Jt; Wed, 16 Sep 2026 03:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkZ-0005co-Qj; Wed, 16 Sep 2026 03:08:11 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkT-0008JC-SW; Wed, 16 Sep 2026 03:08:11 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S7;
 Wed, 16 Sep 2026 15:08:01 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 05/19] target/riscv: Add packed SIMD absolute, difference,
 compare and mask instructions
Date: Wed, 16 Sep 2026 07:07:07 +0000
Message-Id: <20260916070721.3279229-6-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S7
X-Coremail-Antispam: 1UD129KBjvJXoW3CF18Jr18urWkGFykGw45KFg_yoWkAr1Upa
 ykGry3WrW0qrWFq34xKr15J3ZxWanIk3y8ur43KF1fZay5XFWkXr1Utr4ayF4UXr9rWFWj
 gay0y34DAay0v3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbKZX7UUUUU==
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

Implement saturating absolute value, absolute difference,
sum-of-absolute-differences, accumulated
sum-of-absolute-differences, and comparison and mask-generation
operations.Add the associated decode entries, translators and helpers.

Note that the PSABS.* instructions produce results in the signed element
domain.  Since the absolute value of the minimum signed value cannot be
represented in the same element width, saturate it to the maximum signed
value and set vxsat.  All other values are converted to their absolute
values without saturation.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       | 38 +++++++++
 target/riscv/insn32.decode                  | 44 ++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 38 +++++++++
 target/riscv/tcg/psimd_helper.c             | 95 +++++++++++++++++++++
 4 files changed, 215 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 0b0f5791874..d9ea90a5c2e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1416,3 +1416,41 @@ DEF_HELPER_3(pasubu_h, tl, env, tl, tl)
 DEF_HELPER_3(pasubu_w, i64, env, i64, i64)
 DEF_HELPER_3(asub, i32, env, i32, i32)
 DEF_HELPER_3(asubu, i32, env, i32, i32)
+
+/* Packed SIMD - Absolute Value and Difference Operations */
+DEF_HELPER_2(psabs_b, tl, env, tl)
+DEF_HELPER_2(psabs_h, tl, env, tl)
+DEF_HELPER_2(abs, tl, env, tl)
+DEF_HELPER_2(absw, i64, env, i64)
+DEF_HELPER_3(pabd_b, tl, env, tl, tl)
+DEF_HELPER_3(pabdu_b, tl, env, tl, tl)
+DEF_HELPER_3(pabd_h, tl, env, tl, tl)
+DEF_HELPER_3(pabdu_h, tl, env, tl, tl)
+DEF_HELPER_3(pabdsumu_b, tl, env, tl, tl)
+DEF_HELPER_4(pabdsumau_b, tl, env, tl, tl, tl)
+
+/* Packed SIMD - Comparison and Mask Generation Operations */
+DEF_HELPER_3(pmseq_b, tl, env, tl, tl)
+DEF_HELPER_3(pmslt_b, tl, env, tl, tl)
+DEF_HELPER_3(pmsltu_b, tl, env, tl, tl)
+DEF_HELPER_3(pmin_b, tl, env, tl, tl)
+DEF_HELPER_3(pminu_b, tl, env, tl, tl)
+DEF_HELPER_3(pmax_b, tl, env, tl, tl)
+DEF_HELPER_3(pmaxu_b, tl, env, tl, tl)
+DEF_HELPER_3(pmseq_h, tl, env, tl, tl)
+DEF_HELPER_3(pmslt_h, tl, env, tl, tl)
+DEF_HELPER_3(pmsltu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmin_h, tl, env, tl, tl)
+DEF_HELPER_3(pminu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmax_h, tl, env, tl, tl)
+DEF_HELPER_3(pmaxu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmseq_w, i64, env, i64, i64)
+DEF_HELPER_3(pmslt_w, i64, env, i64, i64)
+DEF_HELPER_3(pmsltu_w, i64, env, i64, i64)
+DEF_HELPER_3(pmin_w, i64, env, i64, i64)
+DEF_HELPER_3(pminu_w, i64, env, i64, i64)
+DEF_HELPER_3(pmax_w, i64, env, i64, i64)
+DEF_HELPER_3(pmaxu_w, i64, env, i64, i64)
+DEF_HELPER_3(mseq, i32, env, i32, i32)
+DEF_HELPER_3(mslt, i32, env, i32, i32)
+DEF_HELPER_3(msltu, i32, env, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e06cc82bdef..32eb7b153aa 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1175,3 +1175,47 @@ pasubu_h   1111100 ..... ..... 000 ..... 0111011 @r
   asubu    1111101 ..... ..... 000 ..... 0111011 @r
   pasubu_w 1111101 ..... ..... 000 ..... 0111011 @r
 }
+
+# Packed SIMD - Absolute Value and Difference Operations
+psabs_b    1110010 00111 ..... 010 ..... 0011011 @r2
+psabs_h    1110000 00111 ..... 010 ..... 0011011 @r2
+abs        01100 0000111 ..... 001 ..... 0010011 @r2
+absw       01100 0000111 ..... 001 ..... 0011011 @r2
+pabd_b     1100110 ..... ..... 000 ..... 0111011 @r
+pabdu_b    1110110 ..... ..... 000 ..... 0111011 @r
+pabd_h     1100100 ..... ..... 000 ..... 0111011 @r
+pabdu_h    1110100 ..... ..... 000 ..... 0111011 @r
+pabdsumu_b 1011010 ..... ..... 001 ..... 0111011 @r
+pabdsumau_b 1011110 ..... ..... 001 ..... 0111011 @r
+
+# Packed SIMD - Comparison and Mask Generation Operations
+pmseq_b    1100010 ..... ..... 110 ..... 0111011 @r
+pmslt_b    1101010 ..... ..... 110 ..... 0111011 @r
+pmsltu_b   1101110 ..... ..... 110 ..... 0111011 @r
+pmin_b     1110010 ..... ..... 110 ..... 0111011 @r
+pminu_b    1110110 ..... ..... 110 ..... 0111011 @r
+pmax_b     1111010 ..... ..... 110 ..... 0111011 @r
+pmaxu_b    1111110 ..... ..... 110 ..... 0111011 @r
+pmseq_h    1100000 ..... ..... 110 ..... 0111011 @r
+pmslt_h    1101000 ..... ..... 110 ..... 0111011 @r
+pmsltu_h   1101100 ..... ..... 110 ..... 0111011 @r
+pmin_h     1110000 ..... ..... 110 ..... 0111011 @r
+pminu_h    1110100 ..... ..... 110 ..... 0111011 @r
+pmax_h     1111000 ..... ..... 110 ..... 0111011 @r
+pmaxu_h    1111100 ..... ..... 110 ..... 0111011 @r
+{
+  mseq     1100001 ..... ..... 110 ..... 0111011 @r
+  pmseq_w  1100001 ..... ..... 110 ..... 0111011 @r
+}
+{
+  mslt     1101001 ..... ..... 110 ..... 0111011 @r
+  pmslt_w  1101001 ..... ..... 110 ..... 0111011 @r
+}
+{
+  msltu    1101101 ..... ..... 110 ..... 0111011 @r
+  pmsltu_w 1101101 ..... ..... 110 ..... 0111011 @r
+}
+pmin_w     1110001 ..... ..... 110 ..... 0111011 @r
+pminu_w    1110101 ..... ..... 110 ..... 0111011 @r
+pmax_w     1111001 ..... ..... 110 ..... 0111011 @r
+pmaxu_w    1111101 ..... ..... 110 ..... 0111011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 820d11c33b2..81d3f90eb08 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -569,3 +569,41 @@ GEN_SIMD_TRANS(pasubu_h)
 GEN_SIMD_TRANS_64(pasubu_w)
 GEN_SIMD_TRANS_32(asub)
 GEN_SIMD_TRANS_32(asubu)
+
+/* Packed SIMD - Absolute Value and Difference Operations */
+GEN_SIMD_TRANS_R1_VXSAT(psabs_b)
+GEN_SIMD_TRANS_R1_VXSAT(psabs_h)
+GEN_SIMD_TRANS_R1(abs)
+GEN_SIMD_TRANS_R1_64(absw)
+GEN_SIMD_TRANS(pabd_b)
+GEN_SIMD_TRANS(pabdu_b)
+GEN_SIMD_TRANS(pabd_h)
+GEN_SIMD_TRANS(pabdu_h)
+GEN_SIMD_TRANS(pabdsumu_b)
+GEN_SIMD_TRANS_ACC(pabdsumau_b)
+
+/* Packed SIMD - Comparison and Mask Generation Operations */
+GEN_SIMD_TRANS(pmseq_b)
+GEN_SIMD_TRANS(pmslt_b)
+GEN_SIMD_TRANS(pmsltu_b)
+GEN_SIMD_TRANS(pmin_b)
+GEN_SIMD_TRANS(pminu_b)
+GEN_SIMD_TRANS(pmax_b)
+GEN_SIMD_TRANS(pmaxu_b)
+GEN_SIMD_TRANS(pmseq_h)
+GEN_SIMD_TRANS(pmslt_h)
+GEN_SIMD_TRANS(pmsltu_h)
+GEN_SIMD_TRANS(pmin_h)
+GEN_SIMD_TRANS(pminu_h)
+GEN_SIMD_TRANS(pmax_h)
+GEN_SIMD_TRANS(pmaxu_h)
+GEN_SIMD_TRANS_64(pmseq_w)
+GEN_SIMD_TRANS_64(pmslt_w)
+GEN_SIMD_TRANS_64(pmsltu_w)
+GEN_SIMD_TRANS_64(pmin_w)
+GEN_SIMD_TRANS_64(pminu_w)
+GEN_SIMD_TRANS_64(pmax_w)
+GEN_SIMD_TRANS_64(pmaxu_w)
+GEN_SIMD_TRANS_32(mseq)
+GEN_SIMD_TRANS_32(mslt)
+GEN_SIMD_TRANS_32(msltu)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index e2796230710..625928dc1dd 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2200,3 +2200,98 @@ GEN_PSIMD_AVG_BINOP(asub, uint32_t, int32_t, int64_t,
                     EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
 GEN_PSIMD_AVG_BINOP(asubu, uint32_t, uint32_t, uint64_t,
                     EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+/* Absolute value operations */
+
+GEN_PSIMD_ABS(psabs_b, target_ulong, int8_t,
+              EXTRACT8, INSERT8, ELEMS_B, INT8_MIN, INT8_MAX)
+GEN_PSIMD_ABS(psabs_h, target_ulong, int16_t,
+              EXTRACT16, INSERT16, ELEMS_H, INT16_MIN, INT16_MAX)
+
+GEN_PSIMD_SCALAR_ABS(abs, target_ulong, target_long, target_ulong)
+GEN_PSIMD_SCALAR_ABS(absw, uint64_t, int32_t, uint32_t)
+
+/* Absolute difference operations */
+
+GEN_PSIMD_BINOP(pabd_b, target_ulong, int8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ABD)
+GEN_PSIMD_BINOP(pabdu_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ABD)
+GEN_PSIMD_BINOP(pabd_h, target_ulong, int16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ABD)
+GEN_PSIMD_BINOP(pabdu_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ABD)
+
+/**
+ * PABDSUMU.B - Sum of unsigned absolute differences
+ * Returns sum(|rs1[i] - rs2[i]|) for all bytes
+ */
+target_ulong HELPER(pabdsumu_b)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    return psimd_abdsumu_b(rs1, rs2, 0);
+}
+
+/**
+ * PABDSUMAU.B - Accumulated sum of unsigned absolute differences
+ * rd = rd + sum(|rs1[i] - rs2[i]|)
+ */
+target_ulong HELPER(pabdsumau_b)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong rd)
+{
+    return psimd_abdsumu_b(rs1, rs2, rd);
+}
+
+/* Comparison operations (producing masks) */
+
+GEN_PSIMD_BINOP(pmseq_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_EQ_MASK)
+GEN_PSIMD_BINOP(pmslt_b, target_ulong, int8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmsltu_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmin_b, target_ulong, int8_t, int8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pminu_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pmax_b, target_ulong, int8_t, int8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_MAX)
+GEN_PSIMD_BINOP(pmaxu_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_MAX)
+
+GEN_PSIMD_BINOP(pmseq_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_EQ_MASK)
+GEN_PSIMD_BINOP(pmslt_h, target_ulong, int16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmsltu_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmin_h, target_ulong, int16_t, int16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pminu_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pmax_h, target_ulong, int16_t, int16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_MAX)
+GEN_PSIMD_BINOP(pmaxu_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_MAX)
+
+GEN_PSIMD_BINOP(pmseq_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_EQ_MASK)
+GEN_PSIMD_BINOP(pmslt_w, uint64_t, int32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmsltu_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(pmin_w, uint64_t, int32_t, int32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pminu_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_MIN)
+GEN_PSIMD_BINOP(pmax_w, uint64_t, int32_t, int32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_MAX)
+GEN_PSIMD_BINOP(pmaxu_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_MAX)
+
+GEN_PSIMD_BINOP(mseq, uint32_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_EQ_MASK)
+GEN_PSIMD_BINOP(mslt, uint32_t, int32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
+GEN_PSIMD_BINOP(msltu, uint32_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
-- 
2.34.1


