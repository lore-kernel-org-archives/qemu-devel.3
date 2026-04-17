Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC16F4368B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjH-00012U-9I; Fri, 17 Apr 2026 06:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjE-00010h-AH; Fri, 17 Apr 2026 06:47:16 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjB-0007w9-75; Fri, 17 Apr 2026 06:47:16 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S5;
 Fri, 17 Apr 2026 18:47:09 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/14] target/riscv: rvp: add averaging operations
Date: Fri, 17 Apr 2026 18:46:40 +0800
Message-Id: <20260417104652.17857-4-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S5
X-Coremail-Antispam: 1UD129KBjvJXoW3uF47GF4kKrWUCr13ur4Durg_yoWkWr43pF
 WkJry2qay8JFWaqr4SkF15Ar43WFsxJw48Gr43tFySva1rJFZ5tryUtw42yFsxWF9rWF1Y
 9a90y34DAa4Iqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbF4iUUUUUU==
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
 target/riscv/helper.h                   |  20 ++
 target/riscv/insn32.decode              |  28 ++-
 target/riscv/insn_trans/trans_rvp.c.inc |  20 ++
 target/riscv/psimd_helper.c             | 266 ++++++++++++++++++++++++
 4 files changed, 333 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 76bc6583fb..a72e02b44c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1353,6 +1353,7 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 #endif
 
 /* Packed SIMD */
+/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
 DEF_HELPER_3(padd_b, tl, env, tl, tl)
 DEF_HELPER_3(padd_h, tl, env, tl, tl)
 DEF_HELPER_3(padd_w, i64, env, i64, i64)
@@ -1391,3 +1392,22 @@ DEF_HELPER_3(sati_32, i32, env, i32, i32)
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
+
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6043eb39cf..f609c38638 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1094,7 +1094,7 @@ sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
 
 
 # *** P Experimental Extension Version v018 ***
-# Arithmetic Operations(Non-Saturating and Saturating)
+# Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating)
 padd_b     1000010 ..... ..... 000 ..... 0111011 @r
 padd_h     1000000 ..... ..... 000 ..... 0111011 @r
 padd_w     1000001 ..... ..... 000 ..... 0111011 @r
@@ -1149,3 +1149,29 @@ pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
 sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
 usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
 
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
+
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index 6f7246b563..e3abb38d18 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -524,6 +524,7 @@ static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
 }
 #endif
 
+/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
 GEN_SIMD_TRANS(padd_b)
 GEN_SIMD_TRANS(padd_h)
 GEN_SIMD_TRANS_64(padd_w)
@@ -562,3 +563,22 @@ GEN_SIMD_TRANS_IMM_32(sati_32)
 GEN_SIMD_TRANS_IMM_32(usati_32)
 GEN_SIMD_TRANS_IMM_64(sati_64)
 GEN_SIMD_TRANS_IMM_64(usati_64)
+
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
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index a754ee3b5e..23c0402de2 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -1067,3 +1067,269 @@ uint64_t HELPER(usati_64)(CPURISCVState *env,
     }
     return (uint64_t)a;
 }
+
+/* Averaging Operations (non-saturating) */
+
+/**
+ * PAADD.B - Packed 8-bit signed averaging addition
+ * For each byte: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+target_ulong HELPER(paadd_b)(CPURISCVState *env, target_ulong rs1,
+                             target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int16_t e2 = (int8_t)EXTRACT8(rs2, i);
+        int16_t avg = (e1 + e2) >> 1;
+        rd = INSERT8(rd, (int8_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PAADD.H - Packed 16-bit signed averaging addition
+ * For each halfword: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+target_ulong HELPER(paadd_h)(CPURISCVState *env, target_ulong rs1,
+                             target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int32_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int32_t avg = (e1 + e2) >> 1;
+        rd = INSERT16(rd, (int16_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PAADD.W - Packed 32-bit signed averaging addition (RV64 only)
+ * For each word: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+uint64_t HELPER(paadd_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int64_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int64_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int64_t avg = (e1 + e2) >> 1;
+        rd = INSERT32(rd, (int32_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PAADDU.B - Packed 8-bit unsigned averaging addition
+ * For each byte: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+target_ulong HELPER(paaddu_b)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT8(rs1, i);
+        uint16_t e2 = EXTRACT8(rs2, i);
+        uint16_t avg = (e1 + e2) >> 1;
+        rd = INSERT8(rd, (uint8_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PAADDU.H - Packed 16-bit unsigned averaging addition
+ * For each halfword: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+target_ulong HELPER(paaddu_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT16(rs1, i);
+        uint32_t e2 = EXTRACT16(rs2, i);
+        uint32_t avg = (e1 + e2) >> 1;
+        rd = INSERT16(rd, (uint16_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PAADDU.W - Packed 32-bit unsigned averaging addition (RV64 only)
+ * For each word: rd[i] = (rs1[i] + rs2[i]) >> 1
+ */
+uint64_t HELPER(paaddu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint64_t e1 = EXTRACT32(rs1, i);
+        uint64_t e2 = EXTRACT32(rs2, i);
+        uint64_t avg = (e1 + e2) >> 1;
+        rd = INSERT32(rd, (uint32_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * AADD - 32-bit signed averaging addition
+ */
+uint32_t HELPER(aadd)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    return (uint32_t)((a + b) >> 1);
+}
+
+/**
+ * AADDU - 32-bit unsigned averaging addition
+ */
+uint32_t HELPER(aaddu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t a = rs1;
+    uint64_t b = rs2;
+    return (uint32_t)((a + b) >> 1);
+}
+
+/**
+ * PASUB.B - Packed 8-bit signed averaging subtraction
+ * For each byte: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+target_ulong HELPER(pasub_b)(CPURISCVState *env, target_ulong rs1,
+                             target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int16_t e2 = (int8_t)EXTRACT8(rs2, i);
+        int16_t avg = (e1 - e2) >> 1;
+        rd = INSERT8(rd, (int8_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PASUB.H - Packed 16-bit signed averaging subtraction
+ * For each halfword: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+target_ulong HELPER(pasub_h)(CPURISCVState *env, target_ulong rs1,
+                             target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int32_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int32_t avg = (e1 - e2) >> 1;
+        rd = INSERT16(rd, (int16_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PASUB.W - Packed 32-bit signed averaging subtraction (RV64 only)
+ * For each word: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+uint64_t HELPER(pasub_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int64_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int64_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int64_t avg = (e1 - e2) >> 1;
+        rd = INSERT32(rd, (int32_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PASUBU.B - Packed 8-bit unsigned averaging subtraction
+ * For each byte: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+target_ulong HELPER(pasubu_b)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT8(rs1, i);
+        uint16_t e2 = EXTRACT8(rs2, i);
+        uint16_t avg = (e1 - e2) >> 1;
+        rd = INSERT8(rd, (uint8_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PASUBU.H - Packed 16-bit unsigned averaging subtraction
+ * For each halfword: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+target_ulong HELPER(pasubu_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT16(rs1, i);
+        uint32_t e2 = EXTRACT16(rs2, i);
+        uint32_t avg = (e1 - e2) >> 1;
+        rd = INSERT16(rd, (uint16_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * PASUBU.W - Packed 32-bit unsigned averaging subtraction (RV64 only)
+ * For each word: rd[i] = (rs1[i] - rs2[i]) >> 1
+ */
+uint64_t HELPER(pasubu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint64_t e1 = EXTRACT32(rs1, i);
+        uint64_t e2 = EXTRACT32(rs2, i);
+        uint64_t avg = (e1 - e2) >> 1;
+        rd = INSERT32(rd, (uint32_t)avg, i);
+    }
+    return rd;
+}
+
+/**
+ * ASUB - 32-bit signed averaging subtraction
+ */
+uint32_t HELPER(asub)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int64_t a = (int32_t)rs1;
+    int64_t b = (int32_t)rs2;
+    return (uint32_t)((a - b) >> 1);
+}
+
+/**
+ * ASUBU - 32-bit unsigned averaging subtraction
+ */
+uint32_t HELPER(asubu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint64_t a = rs1;
+    uint64_t b = rs2;
+    return (uint32_t)((a - b) >> 1);
+}
-- 
2.34.1


