Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92D2F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjJ-00013K-9m; Fri, 17 Apr 2026 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjG-00012J-OJ; Fri, 17 Apr 2026 06:47:18 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjD-0007xe-ED; Fri, 17 Apr 2026 06:47:18 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S6;
 Fri, 17 Apr 2026 18:47:10 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/14] target/riscv: rvp: add absolute value and difference,
 comparison and mask generation operations
Date: Fri, 17 Apr 2026 18:46:41 +0800
Message-Id: <20260417104652.17857-5-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S6
X-Coremail-Antispam: 1UD129KBjvAXoWfuw4DJrWfKrWktw43GF43GFg_yoW8ur1kXo
 ZrKw15A34fGr1fW348uw4xZr18XrW2v3WDGr48uw45Z3s3WF1Sgr15J3WkA3WxtrWayrW3
 X39aqFn8J3ZxK3sxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOU7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
 W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
 CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbnNVPUU
 UUU==
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
 target/riscv/helper.h                   |  38 ++
 target/riscv/insn32.decode              |  44 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  38 ++
 target/riscv/psimd_helper.c             | 634 ++++++++++++++++++++++++
 4 files changed, 754 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a72e02b44c..f6351ecd43 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1411,3 +1411,41 @@ DEF_HELPER_3(pasubu_w, i64, env, i64, i64)
 DEF_HELPER_3(asub, i32, env, i32, i32)
 DEF_HELPER_3(asubu, i32, env, i32, i32)
 
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
+
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f609c38638..2034041639 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1175,3 +1175,47 @@ pasubu_h   1111100 ..... ..... 000 ..... 0111011 @r
   pasubu_w 1111101 ..... ..... 000 ..... 0111011 @r
 }
 
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
+
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index e3abb38d18..27d482863c 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -582,3 +582,41 @@ GEN_SIMD_TRANS_64(pasubu_w)
 GEN_SIMD_TRANS_32(asub)
 GEN_SIMD_TRANS_32(asubu)
 
+/* Packed SIMD - Absolute Value and Difference Operations */
+GEN_SIMD_TRANS_R1(psabs_b)
+GEN_SIMD_TRANS_R1(psabs_h)
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
+
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index 23c0402de2..38207c3a39 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -1333,3 +1333,637 @@ uint32_t HELPER(asubu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
     uint64_t b = rs2;
     return (uint32_t)((a - b) >> 1);
 }
+
+/* Absolute value operations */
+
+/**
+ * PSABS.B - Packed 8-bit absolute value
+ * For each byte: rd[i] = abs(rs1[i]), saturate if MIN
+ */
+target_ulong HELPER(psabs_b)(CPURISCVState *env, target_ulong rs1)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t res;
+
+        if (e1 == INT8_MIN) {
+            res = INT8_MAX;
+            sat = 1;
+        } else if (e1 < 0) {
+            res = -e1;
+        } else {
+            res = e1;
+        }
+
+        rd = INSERT8(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSABS.H - Packed 16-bit absolute value
+ * For each halfword: rd[i] = abs(rs1[i]), saturate if MIN
+ */
+target_ulong HELPER(psabs_h)(CPURISCVState *env, target_ulong rs1)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t res;
+
+        if (e1 == INT16_MIN) {
+            res = INT16_MAX;
+            sat = 1;
+        } else if (e1 < 0) {
+            res = -e1;
+        } else {
+            res = e1;
+        }
+
+        rd = INSERT16(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * ABS - 32/64-bit scalar absolute value
+ */
+target_ulong HELPER(abs)(CPURISCVState *env, target_ulong rs1)
+{
+    target_long a = (target_long)rs1;
+    return (a < 0) ? (target_ulong)(-a) : rs1;
+}
+
+/**
+ * ABSW - Absolute value of low 32 bits (RV64)
+ */
+uint64_t HELPER(absw)(CPURISCVState *env, uint64_t rs1)
+{
+    int32_t a = (int32_t)EXTRACT32(rs1, 0);
+    uint32_t res;
+
+    if (a == INT32_MIN) {
+        res = 0x80000000;
+    } else if (a < 0) {
+        res = (uint32_t)(-a);
+    } else {
+        res = (uint32_t)a;
+    }
+
+    return (uint64_t)res;
+}
+
+
+/* Absolute difference operations */
+
+/**
+ * PABD.B - Packed 8-bit signed absolute difference
+ * For each byte: rd[i] = |rs1[i] - rs2[i]|
+ */
+target_ulong HELPER(pabd_b)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
+        int16_t diff = (int16_t)e1 - (int16_t)e2;
+        uint8_t res = (diff >= 0) ? (uint8_t)diff : (uint8_t)(-diff);
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PABDU.B - Packed 8-bit unsigned absolute difference
+ * For each byte: rd[i] = |rs1[i] - rs2[i]|
+ */
+target_ulong HELPER(pabdu_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t res = (e1 > e2) ? (e1 - e2) : (e2 - e1);
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PABD.H - Packed 16-bit signed absolute difference
+ * For each halfword: rd[i] = |rs1[i] - rs2[i]|
+ */
+target_ulong HELPER(pabd_h)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int32_t diff = (int32_t)e1 - (int32_t)e2;
+        uint16_t res = (diff >= 0) ? (uint16_t)diff : (uint16_t)(-diff);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PABDU.H - Packed 16-bit unsigned absolute difference
+ * For each halfword: rd[i] = |rs1[i] - rs2[i]|
+ */
+target_ulong HELPER(pabdu_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = (e1 > e2) ? (e1 - e2) : (e2 - e1);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PABDSUMU.B - Sum of unsigned absolute differences
+ * Returns sum(|rs1[i] - rs2[i]|) for all bytes
+ */
+target_ulong HELPER(pabdsumu_b)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong sum = 0;
+    int elems = ELEMS_B(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t diff = (e1 > e2) ? (e1 - e2) : (e2 - e1);
+        sum += diff;
+    }
+
+    return sum;
+}
+
+/**
+ * PABDSUMAU.B - Accumulated sum of unsigned absolute differences
+ * rd = rd + sum(|rs1[i] - rs2[i]|)
+ */
+target_ulong HELPER(pabdsumau_b)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong rd)
+{
+    target_ulong sum = rd;
+    int elems = ELEMS_B(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t diff = (e1 > e2) ? (e1 - e2) : (e2 - e1);
+        sum += diff;
+    }
+
+    return sum;
+}
+
+/* Comparison operations (producing masks) */
+
+/**
+ * PMSEQ.B - Packed 8-bit equal comparison
+ * For each byte: rd[i] = 0xFF if rs1[i] == rs2[i], else 0x00
+ */
+target_ulong HELPER(pmseq_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t res = (e1 == e2) ? 0xFF : 0x00;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLT.B - Packed 8-bit signed less-than comparison
+ * For each byte: rd[i] = 0xFF if rs1[i] < rs2[i], else 0x00
+ */
+target_ulong HELPER(pmslt_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
+        uint8_t res = (e1 < e2) ? 0xFF : 0x00;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLTU.B - Packed 8-bit unsigned less-than comparison
+ * For each byte: rd[i] = 0xFF if rs1[i] < rs2[i], else 0x00
+ */
+target_ulong HELPER(pmsltu_b)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t res = (e1 < e2) ? 0xFF : 0x00;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMIN.B - Packed 8-bit signed minimum
+ * For each byte: rd[i] = min(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmin_b)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
+        int8_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMINU.B - Packed 8-bit unsigned minimum
+ * For each byte: rd[i] = min(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pminu_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAX.B - Packed 8-bit signed maximum
+ * For each byte: rd[i] = max(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmax_b)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
+        int8_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAXU.B - Packed 8-bit unsigned maximum
+ * For each byte: rd[i] = max(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmaxu_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i);
+        uint8_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSEQ.H - Packed 16-bit equal comparison
+ * For each halfword: rd[i] = 0xFFFF if rs1[i] == rs2[i], else 0x0000
+ */
+target_ulong HELPER(pmseq_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = (e1 == e2) ? 0xFFFF : 0x0000;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLT.H - Packed 16-bit signed less-than comparison
+ * For each halfword: rd[i] = 0xFFFF if rs1[i] < rs2[i], else 0x0000
+ */
+target_ulong HELPER(pmslt_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        uint16_t res = (e1 < e2) ? 0xFFFF : 0x0000;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLTU.H - Packed 16-bit unsigned less-than comparison
+ * For each halfword: rd[i] = 0xFFFF if rs1[i] < rs2[i], else 0x0000
+ */
+target_ulong HELPER(pmsltu_h)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = (e1 < e2) ? 0xFFFF : 0x0000;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMIN.H - Packed 16-bit signed minimum
+ * For each halfword: rd[i] = min(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmin_h)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int16_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMINU.H - Packed 16-bit unsigned minimum
+ * For each halfword: rd[i] = min(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pminu_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAX.H - Packed 16-bit signed maximum
+ * For each halfword: rd[i] = max(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmax_h)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int16_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAXU.H - Packed 16-bit unsigned maximum
+ * For each halfword: rd[i] = max(rs1[i], rs2[i])
+ */
+target_ulong HELPER(pmaxu_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSEQ.W - Packed 32-bit equal comparison (RV64 only)
+ * For each word: rd[i] = 0xFFFFFFFF if rs1[i] == rs2[i], else 0x00000000
+ */
+uint64_t HELPER(pmseq_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = (e1 == e2) ? 0xFFFFFFFFU : 0x00000000U;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLT.W - Packed 32-bit signed less-than comparison (RV64 only)
+ * For each word: rd[i] = 0xFFFFFFFF if rs1[i] < rs2[i], else 0x00000000
+ */
+uint64_t HELPER(pmslt_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        uint32_t res = (e1 < e2) ? 0xFFFFFFFFU : 0x00000000U;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMSLTU.W - Packed 32-bit unsigned less-than comparison (RV64 only)
+ * For each word: rd[i] = 0xFFFFFFFF if rs1[i] < rs2[i], else 0x00000000
+ */
+uint64_t HELPER(pmsltu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = (e1 < e2) ? 0xFFFFFFFFU : 0x00000000U;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMIN.W - Packed 32-bit signed minimum (RV64 only)
+ * For each word: rd[i] = min(rs1[i], rs2[i])
+ */
+uint64_t HELPER(pmin_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int32_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMINU.W - Packed 32-bit unsigned minimum (RV64 only)
+ * For each word: rd[i] = min(rs1[i], rs2[i])
+ */
+uint64_t HELPER(pminu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = (e1 < e2) ? e1 : e2;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAX.W - Packed 32-bit signed maximum (RV64 only)
+ * For each word: rd[i] = max(rs1[i], rs2[i])
+ */
+uint64_t HELPER(pmax_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int32_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMAXU.W - Packed 32-bit unsigned maximum (RV64 only)
+ * For each word: rd[i] = max(rs1[i], rs2[i])
+ */
+uint64_t HELPER(pmaxu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = (e1 > e2) ? e1 : e2;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * MSEQ - 32-bit scalar set if equal (mask)
+ */
+uint32_t HELPER(mseq)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return (rs1 == rs2) ? 0xFFFFFFFFU : 0x00000000U;
+}
+
+/**
+ * MSLT - 32-bit scalar set if signed less than (mask)
+ */
+uint32_t HELPER(mslt)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return ((int32_t)rs1 < (int32_t)rs2) ? 0xFFFFFFFFU : 0x00000000U;
+}
+
+/**
+ * MSLTU - 32-bit scalar set if unsigned less than (mask)
+ */
+uint32_t HELPER(msltu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    return (rs1 < rs2) ? 0xFFFFFFFFU : 0x00000000U;
+}
+
-- 
2.34.1


