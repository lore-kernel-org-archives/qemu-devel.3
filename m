Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE1CF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjL-000154-FW; Fri, 17 Apr 2026 06:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjJ-00013B-0o; Fri, 17 Apr 2026 06:47:21 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjF-0007yf-PG; Fri, 17 Apr 2026 06:47:20 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S8;
 Fri, 17 Apr 2026 18:47:13 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/14] target/riscv: rvp: add exchange operations
Date: Fri, 17 Apr 2026 18:46:43 +0800
Message-Id: <20260417104652.17857-7-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S8
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1rXF1xKF47Kw45ZrW7twb_yoWkAryDpF
 Wvkry2q3y3JFySgw4fKF1fAw15WwsxJry8GrZxKF1Sqa1fXF1kJrW5tw13urs7GF9rWry5
 Wa98A3y8AFyIq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r
 43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
 Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
 0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
 JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
 IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5TmhDUUU
 U
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
 target/riscv/helper.h                   |  14 ++
 target/riscv/insn32.decode              |  14 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  14 ++
 target/riscv/psimd_helper.c             | 294 ++++++++++++++++++++++++
 4 files changed, 336 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d97552eb58..fc66712570 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1483,3 +1483,17 @@ DEF_HELPER_3(ssha, i32, env, i32, i32)
 DEF_HELPER_3(sshar, i32, env, i32, i32)
 DEF_HELPER_3(sha, i64, env, i64, i64)
 DEF_HELPER_3(shar, i64, env, i64, i64)
+
+/* Packed SIMD - Exchange Operations */
+DEF_HELPER_3(pas_hx, tl, env, tl, tl)
+DEF_HELPER_3(psa_hx, tl, env, tl, tl)
+DEF_HELPER_3(psas_hx, tl, env, tl, tl)
+DEF_HELPER_3(pssa_hx, tl, env, tl, tl)
+DEF_HELPER_3(paas_hx, tl, env, tl, tl)
+DEF_HELPER_3(pasa_hx, tl, env, tl, tl)
+DEF_HELPER_3(pas_wx, i64, env, i64, i64)
+DEF_HELPER_3(psa_wx, i64, env, i64, i64)
+DEF_HELPER_3(psas_wx, i64, env, i64, i64)
+DEF_HELPER_3(pssa_wx, i64, env, i64, i64)
+DEF_HELPER_3(paas_wx, i64, env, i64, i64)
+DEF_HELPER_3(pasa_wx, i64, env, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 69514e2cb9..ba003ed513 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1263,3 +1263,17 @@ psshar_hs  1111100 ..... ..... 010 ..... 0011011 @r
 }
 sha        1110111 ..... ..... 010 ..... 0011011 @r
 shar       1111111 ..... ..... 010 ..... 0011011 @r
+
+# Packed SIMD - Exchange Operations
+pas_hx     1000000 ..... ..... 110 ..... 0111011 @r
+psa_hx     1000010 ..... ..... 110 ..... 0111011 @r
+psas_hx    1001000 ..... ..... 110 ..... 0111011 @r
+pssa_hx    1001010 ..... ..... 110 ..... 0111011 @r
+paas_hx    1001100 ..... ..... 110 ..... 0111011 @r
+pasa_hx    1001110 ..... ..... 110 ..... 0111011 @r
+pas_wx     1000001 ..... ..... 110 ..... 0111011 @r
+psa_wx     1000011 ..... ..... 110 ..... 0111011 @r
+psas_wx    1001001 ..... ..... 110 ..... 0111011 @r
+pssa_wx    1001011 ..... ..... 110 ..... 0111011 @r
+paas_wx    1001101 ..... ..... 110 ..... 0111011 @r
+pasa_wx    1001111 ..... ..... 110 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index d0b645d083..b24a8ef7c2 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -654,3 +654,17 @@ GEN_SIMD_TRANS_32(ssha)
 GEN_SIMD_TRANS_32(sshar)
 GEN_SIMD_TRANS_64(sha)
 GEN_SIMD_TRANS_64(shar)
+
+/* Packed SIMD - Exchange Operations */
+GEN_SIMD_TRANS(pas_hx)
+GEN_SIMD_TRANS(psa_hx)
+GEN_SIMD_TRANS(psas_hx)
+GEN_SIMD_TRANS(pssa_hx)
+GEN_SIMD_TRANS(paas_hx)
+GEN_SIMD_TRANS(pasa_hx)
+GEN_SIMD_TRANS_64(pas_wx)
+GEN_SIMD_TRANS_64(psa_wx)
+GEN_SIMD_TRANS_64(psas_wx)
+GEN_SIMD_TRANS_64(pssa_wx)
+GEN_SIMD_TRANS_64(paas_wx)
+GEN_SIMD_TRANS_64(pasa_wx)
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index ef556eb007..e48c9897ae 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -2703,3 +2703,297 @@ uint64_t HELPER(shar)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
         }
     }
 }
+
+/* Exchange operations (AS/SA/AS/SA with X suffix) */
+
+/**
+ * PAS.HX - Packed add-subtract with exchange
+ * For each pair: {rd[2i] = rs1[2i] - rs2[2i+1], rd[2i+1] = rs1[2i+1] + rs2[2i]}
+ */
+target_ulong HELPER(pas_hx)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int16_t res_lo = s1_lo - s2_hi;
+        int16_t res_hi = s1_hi + s2_lo;
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PSA.HX - Packed subtract-add with exchange
+ * For each pair: {rd[2i] = rs1[2i] + rs2[2i+1], rd[2i+1] = rs1[2i+1] - rs2[2i]}
+ */
+target_ulong HELPER(psa_hx)(CPURISCVState *env,
+                            target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int16_t res_lo = s1_lo + s2_hi;
+        int16_t res_hi = s1_hi - s2_lo;
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PSAS.HX - Packed saturating add-subtract with exchange
+ */
+target_ulong HELPER(psas_hx)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int32_t diff = (int32_t)s1_lo - (int32_t)s2_hi;
+        int32_t sum = (int32_t)s1_hi + (int32_t)s2_lo;
+        int16_t res_lo = signed_saturate_h(diff, &sat);
+        int16_t res_hi = signed_saturate_h(sum, &sat);
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSA.HX - Packed saturating subtract-add with exchange
+ */
+target_ulong HELPER(pssa_hx)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int32_t sum = (int32_t)s1_lo + (int32_t)s2_hi;
+        int32_t diff = (int32_t)s1_hi - (int32_t)s2_lo;
+        int16_t res_lo = signed_saturate_h(sum, &sat);
+        int16_t res_hi = signed_saturate_h(diff, &sat);
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PAAS.HX - Packed averaging add-subtract with exchange
+ */
+target_ulong HELPER(paas_hx)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int16_t res_lo = (s1_lo - s2_hi) >> 1;
+        int16_t res_hi = (s1_hi + s2_lo) >> 1;
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PASA.HX - Packed averaging subtract-add with exchange
+ */
+target_ulong HELPER(pasa_hx)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i += 2) {
+        int16_t s1_lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t s1_hi = (int16_t)EXTRACT16(rs1, i + 1);
+        int16_t s2_lo = (int16_t)EXTRACT16(rs2, i);
+        int16_t s2_hi = (int16_t)EXTRACT16(rs2, i + 1);
+        int16_t res_lo = (s1_lo + s2_hi) >> 1;
+        int16_t res_hi = (s1_hi - s2_lo) >> 1;
+        rd = INSERT16(rd, res_lo, i);
+        rd = INSERT16(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PAS.WX - Word version of packed add-subtract with exchange (RV64 only)
+ */
+uint64_t HELPER(pas_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i += 2) {
+        int32_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int32_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int32_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int32_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int32_t res_lo = s1_lo - s2_hi;
+        int32_t res_hi = s1_hi + s2_lo;
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PSA.WX - Word version of packed subtract-add with exchange (RV64 only)
+ */
+uint64_t HELPER(psa_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i += 2) {
+        int32_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int32_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int32_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int32_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int32_t res_lo = s1_lo + s2_hi;
+        int32_t res_hi = s1_hi - s2_lo;
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PSAS.WX - Word version of packed saturating
+ * add-subtract with exchange (RV64 only)
+ */
+uint64_t HELPER(psas_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+
+    for (int i = 0; i < elems; i += 2) {
+        int32_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int32_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int32_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int32_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int64_t diff = (int64_t)s1_lo - (int64_t)s2_hi;
+        int64_t sum = (int64_t)s1_hi + (int64_t)s2_lo;
+        int32_t res_lo = signed_saturate_w(diff, &sat);
+        int32_t res_hi = signed_saturate_w(sum, &sat);
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSA.WX - Word version of packed saturating
+ * subtract-add with exchange (RV64 only)
+ */
+uint64_t HELPER(pssa_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+
+    for (int i = 0; i < elems; i += 2) {
+        int32_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int32_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int32_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int32_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int64_t sum = (int64_t)s1_lo + (int64_t)s2_hi;
+        int64_t diff = (int64_t)s1_hi - (int64_t)s2_lo;
+        int32_t res_lo = signed_saturate_w(sum, &sat);
+        int32_t res_hi = signed_saturate_w(diff, &sat);
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PAAS.WX - Word version of packed averaging
+ * add-subtract with exchange (RV64 only)
+ */
+uint64_t HELPER(paas_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i += 2) {
+        int64_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int64_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int64_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int64_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int32_t res_lo = (s1_lo - s2_hi) >> 1;
+        int32_t res_hi = (s1_hi + s2_lo) >> 1;
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+    return rd;
+}
+
+/**
+ * PASA.WX - Word version of packed averaging
+ * subtract-add with exchange (RV64 only)
+ */
+uint64_t HELPER(pasa_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i += 2) {
+        int64_t s1_lo = (int32_t)EXTRACT32(rs1, i);
+        int64_t s1_hi = (int32_t)EXTRACT32(rs1, i + 1);
+        int64_t s2_lo = (int32_t)EXTRACT32(rs2, i);
+        int64_t s2_hi = (int32_t)EXTRACT32(rs2, i + 1);
+        int32_t res_lo = (s1_lo + s2_hi) >> 1;
+        int32_t res_hi = (s1_hi - s2_lo) >> 1;
+        rd = INSERT32(rd, res_lo, i);
+        rd = INSERT32(rd, res_hi, i + 1);
+    }
+    return rd;
+}
-- 
2.34.1


