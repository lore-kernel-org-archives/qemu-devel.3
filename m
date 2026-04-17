Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8863F4368B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjq-0001XR-Ue; Fri, 17 Apr 2026 06:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjo-0001Tu-Hj; Fri, 17 Apr 2026 06:47:52 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjl-000846-F4; Fri, 17 Apr 2026 06:47:52 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S16;
 Fri, 17 Apr 2026 18:47:25 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/14] target/riscv: rvp: update to v020,
 add SHL and PNCLIP[U]P.* instructions
Date: Fri, 17 Apr 2026 18:46:51 +0800
Message-Id: <20260417104652.17857-15-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S16
X-Coremail-Antispam: 1UD129KBjvAXoWfJF4UWrWxCFyfXr4UGFyUZFb_yoW8Gw1xZo
 WrKw45Ar1fGw13u34F9w4UXr1UZr92vw1kGr48Zr42qas7Wr12gFn8J3s5AF40qrWayrW7
 XrZ3WryrtF1akr9rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOb7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw
 0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5Tmh
 DUUUU
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
 target/riscv/helper.h                   |  14 +
 target/riscv/insn32.decode              |  22 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  18 ++
 target/riscv/psimd_helper.c             | 370 ++++++++++++++++++++++++
 4 files changed, 424 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85d4fe1b67..a9dbe53dbf 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1483,6 +1483,14 @@ DEF_HELPER_3(ssha, i32, env, i32, i32)
 DEF_HELPER_3(sshar, i32, env, i32, i32)
 DEF_HELPER_3(sha, i64, env, i64, i64)
 DEF_HELPER_3(shar, i64, env, i64, i64)
+DEF_HELPER_3(psshl_hs, tl, env, tl, tl)
+DEF_HELPER_3(psshlr_hs, tl, env, tl, tl)
+DEF_HELPER_3(psshl_ws, i64, env, i64, i64)
+DEF_HELPER_3(psshlr_ws, i64, env, i64, i64)
+DEF_HELPER_3(sshl, i32, env, i32, i32)
+DEF_HELPER_3(sshlr, i32, env, i32, i32)
+DEF_HELPER_3(shl, i64, env, i64, i64)
+DEF_HELPER_3(shlr, i64, env, i64, i64)
 
 /* Packed SIMD - Exchange Operations */
 DEF_HELPER_3(pas_hx, tl, env, tl, tl)
@@ -1538,6 +1546,12 @@ DEF_HELPER_4(srx, tl, env, tl, tl, tl)
 DEF_HELPER_4(mvm, tl, env, tl, tl, tl)
 DEF_HELPER_4(mvmn, tl, env, tl, tl, tl)
 DEF_HELPER_4(merge, tl, env, tl, tl, tl)
+DEF_HELPER_3(pnclipp_b, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_b, i64, env, i64, i64)
+DEF_HELPER_3(pnclipp_h, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_h, i64, env, i64, i64)
+DEF_HELPER_3(pnclipp_w, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_w, i64, env, i64, i64)
 
 /* Packed SIMD - Count Leading Operations */
 DEF_HELPER_2(cls, tl, env, tl)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 7be0b9e5e6..d7aebd55e2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1293,6 +1293,18 @@ psshar_hs  1111100 ..... ..... 010 ..... 0011011 @r
 }
 sha        1110111 ..... ..... 010 ..... 0011011 @r
 shar       1111111 ..... ..... 010 ..... 0011011 @r
+psshl_hs   1010100 ..... ..... 010 ..... 0011011 @r
+psshlr_hs  1011100 ..... ..... 010 ..... 0011011 @r
+{
+  psshl_ws   1010101 ..... ..... 010 ..... 0011011 @r
+  sshl       1010101 ..... ..... 010 ..... 0011011 @r
+}
+{
+  psshlr_ws  1011101 ..... ..... 010 ..... 0011011 @r
+  sshlr      1011101 ..... ..... 010 ..... 0011011 @r
+}
+shl        1010111 ..... ..... 010 ..... 0011011 @r
+shlr       1011111 ..... ..... 010 ..... 0011011 @r
 
 # Packed SIMD - Exchange Operations
 pas_hx     1000000 ..... ..... 110 ..... 0111011 @r
@@ -1346,6 +1358,12 @@ srx         1010111 ..... ..... 001 ..... 0111011 @r
 mvm         1010100 ..... ..... 001 ..... 0111011 @r
 mvmn        1010101 ..... ..... 001 ..... 0111011 @r
 merge       1010110 ..... ..... 001 ..... 0111011 @r
+pnclipp_b   1100000 ..... ..... 010 ..... 0111011 @r
+pnclipup_b  1000000 ..... ..... 010 ..... 0111011 @r
+pnclipp_h   1100001 ..... ..... 010 ..... 0111011 @r
+pnclipup_h  1000001 ..... ..... 010 ..... 0111011 @r
+pnclipp_w   1100011 ..... ..... 010 ..... 0111011 @r
+pnclipup_w  1000011 ..... ..... 010 ..... 0111011 @r
 
 # Packed SIMD - Count Leading Operations
 cls    01100 0000011 ..... 001 ..... 0010011 @r2
@@ -1790,12 +1808,16 @@ psrl_dhs    0000100 ..... .... 1110 .... 00011011 @r_p_3
 psra_dhs    0100100 ..... .... 1110 .... 00011011 @r_p_3
 pssha_dhs   0110100 ..... .... 0110 .... 00011011 @r_p_3
 psshar_dhs  0111100 ..... .... 0110 .... 00011011 @r_p_3
+psshl_dhs   0010100 ..... .... 0110 .... 00011011 @r_p_3
+psshlr_dhs  0011100 ..... .... 0110 .... 00011011 @r_p_3
 padd_dws    0001101 ..... .... 0110 .... 00011011 @r_p_3
 psll_dws    0000101 ..... .... 0110 .... 00011011 @r_p_3
 psrl_dws    0000101 ..... .... 1110 .... 00011011 @r_p_3
 psra_dws    0100101 ..... .... 1110 .... 00011011 @r_p_3
 pssha_dws   0110101 ..... .... 0110 .... 00011011 @r_p_3
 psshar_dws  0111101 ..... .... 0110 .... 00011011 @r_p_3
+psshl_dws   0010101 ..... .... 0110 .... 00011011 @r_p_3
+psshlr_dws  0011101 ..... .... 0110 .... 00011011 @r_p_3
 
 # register-pair operands
 ppaire_db    1000000 .... 0 .... 1110 .... 00011011 @r_p_2
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index ca459293a3..b4142adcfb 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -686,6 +686,14 @@ GEN_SIMD_TRANS_32(ssha)
 GEN_SIMD_TRANS_32(sshar)
 GEN_SIMD_TRANS_64(sha)
 GEN_SIMD_TRANS_64(shar)
+GEN_SIMD_TRANS(psshl_hs)
+GEN_SIMD_TRANS(psshlr_hs)
+GEN_SIMD_TRANS_64(psshl_ws)
+GEN_SIMD_TRANS_64(psshlr_ws)
+GEN_SIMD_TRANS_32(sshl)
+GEN_SIMD_TRANS_32(sshlr)
+GEN_SIMD_TRANS_64(shl)
+GEN_SIMD_TRANS_64(shlr)
 
 /* Packed SIMD - Exchange Operations */
 GEN_SIMD_TRANS(pas_hx)
@@ -739,6 +747,12 @@ GEN_SIMD_TRANS_ACC(srx)
 GEN_SIMD_TRANS_ACC(mvm)
 GEN_SIMD_TRANS_ACC(mvmn)
 GEN_SIMD_TRANS_ACC(merge)
+GEN_SIMD_TRANS_64(pnclipp_b)
+GEN_SIMD_TRANS_64(pnclipup_b)
+GEN_SIMD_TRANS_64(pnclipp_h)
+GEN_SIMD_TRANS_64(pnclipup_h)
+GEN_SIMD_TRANS_64(pnclipp_w)
+GEN_SIMD_TRANS_64(pnclipup_w)
 
 /* Packed SIMD - Count Leading Operations */
 GEN_SIMD_TRANS_R1(cls)
@@ -1066,8 +1080,12 @@ GEN_SIMD_TRANS_REG_PAIR_3(psrl_dhs, psrl_hs)
 GEN_SIMD_TRANS_REG_PAIR_3(psra_dhs, psra_hs)
 GEN_SIMD_TRANS_REG_PAIR_3(pssha_dhs, pssha_hs)
 GEN_SIMD_TRANS_REG_PAIR_3(psshar_dhs, psshar_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psshl_dhs, psshl_hs)
+GEN_SIMD_TRANS_REG_PAIR_3(psshlr_dhs, psshlr_hs)
 GEN_SIMD_TRANS_REG_PAIR_DW(pssha_dws, ssha)
 GEN_SIMD_TRANS_REG_PAIR_DW(psshar_dws, sshar)
+GEN_SIMD_TRANS_REG_PAIR_DW(psshl_dws, sshl)
+GEN_SIMD_TRANS_REG_PAIR_DW(psshlr_dws, sshlr)
 
 GEN_SIMD_TRANS_REG_PAIR_2(ppairo_db, ppairo_b)
 GEN_SIMD_TRANS_REG_PAIR_2(ppairo_dh, ppairo_h)
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index 4c91800128..96e016d90d 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -2704,6 +2704,242 @@ uint64_t HELPER(shar)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     }
 }
 
+/**
+ * PSSHL.HS - Packed 16-bit variable shift with unsigned saturation
+ * Positive shift left (saturating), negative shift right (logical)
+ */
+target_ulong HELPER(psshl_hs)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = (uint16_t)EXTRACT16(rs1, i);
+        uint16_t res;
+
+        if (shamt >= 0) {
+            uint32_t shifted = (shamt >= 16) ? ((uint32_t)e1 << 16)
+                                             : ((uint32_t)e1 << shamt);
+            res = unsigned_saturate_h(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right >= 16) {
+                res = 0;
+            } else {
+                res = e1 >> right;
+            }
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
+ * PSSHLR.HS - Packed 16-bit variable shift with rounding
+ * and unsigned saturation
+ * Positive shift left (saturating), negative shift right (logical, rounded)
+ */
+target_ulong HELPER(psshlr_hs)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = (uint16_t)EXTRACT16(rs1, i);
+        uint16_t res;
+
+        if (shamt >= 0) {
+            uint32_t shifted = (shamt >= 16) ? ((uint32_t)e1 << 16)
+                                             : ((uint32_t)e1 << shamt);
+            res = unsigned_saturate_h(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right > 16) {
+                res = 0;
+            } else {
+                uint32_t rounded = ((uint32_t)e1 >> (right - 1)) + 1;
+                res = (uint16_t)(rounded >> 1);
+            }
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
+ * PSSHL.WS - Packed 32-bit variable shift with unsigned saturation (RV64 only)
+ * Positive shift left (saturating), negative shift right (logical)
+ */
+uint64_t HELPER(psshl_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint32_t)EXTRACT32(rs1, i);
+        uint32_t res;
+
+        if (shamt >= 0) {
+            uint64_t shifted = (shamt >= 32) ? ((uint64_t)e1 << 32)
+                                             : ((uint64_t)e1 << shamt);
+            res = unsigned_saturate_w(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right >= 32) {
+                res = 0;
+            } else {
+                res = e1 >> right;
+            }
+        }
+
+        rd = INSERT32(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSHLR.WS - Packed 32-bit variable shift with rounding
+ * and unsigned saturation (RV64 only)
+ * Positive shift left (saturating), negative shift right (logical, rounded)
+ */
+uint64_t HELPER(psshlr_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t e1 = (uint32_t)EXTRACT32(rs1, i);
+        uint32_t res;
+
+        if (shamt >= 0) {
+            uint64_t shifted = (shamt >= 32) ? ((uint64_t)e1 << 32)
+                                             : ((uint64_t)e1 << shamt);
+            res = unsigned_saturate_w(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right > 32) {
+                res = 0;
+            } else {
+                uint64_t rounded = ((uint64_t)e1 >> (right - 1)) + 1;
+                res = (uint32_t)(rounded >> 1);
+            }
+        }
+
+        rd = INSERT32(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * SSHL - 32-bit scalar variable shift with unsigned saturation
+ */
+uint32_t HELPER(sshl)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt < 0) {
+        int right = -shamt;
+        return (right >= 32) ? 0 : (rs1 >> right);
+    } else {
+        uint64_t shifted = (shamt >= 32) ? ((uint64_t)rs1 << 32)
+                                         : ((uint64_t)rs1 << shamt);
+        uint32_t res = unsigned_saturate_w(shifted, &sat);
+        if (sat) {
+            env->vxsat = 1;
+        }
+        return res;
+    }
+}
+
+/**
+ * SSHLR - 32-bit scalar variable shift with rounding and unsigned saturation
+ */
+uint32_t HELPER(sshlr)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt < 0) {
+        int right = -shamt;
+        if (right > 32) {
+            return 0;
+        } else {
+            uint64_t rounded = ((uint64_t)rs1 >> (right - 1)) + 1;
+            return rounded >> 1;
+        }
+    } else {
+        uint64_t shifted = (shamt >= 32) ? ((uint64_t)rs1 << 32)
+                                         : ((uint64_t)rs1 << shamt);
+        uint32_t res = unsigned_saturate_w(shifted, &sat);
+        if (sat) {
+            env->vxsat = 1;
+        }
+        return res;
+    }
+}
+
+/**
+ * SHL - 64-bit scalar variable logical shift
+ */
+uint64_t HELPER(shl)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt < 0) {
+        int right = -shamt;
+        return (right >= 64) ? 0 : (rs1 >> right);
+    } else {
+        return (shamt >= 64) ? 0 : (rs1 << shamt);
+    }
+}
+
+/**
+ * SHLR - 64-bit scalar variable logical shift with rounding
+ */
+uint64_t HELPER(shlr)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt < 0) {
+        int right = -shamt;
+        if (right > 64) {
+            return 0;
+        } else {
+            uint64_t rounded = (rs1 >> (right - 1)) + 1;
+            return rounded >> 1;
+        }
+    } else {
+        return (shamt >= 64) ? 0 : (rs1 << shamt);
+    }
+}
+
 /* Exchange operations (AS/SA/AS/SA with X suffix) */
 
 /**
@@ -3573,6 +3809,140 @@ target_ulong HELPER(merge)(CPURISCVState *env, target_ulong rs1,
     return (~rd & rs1) | (rd & rs2);
 }
 
+/**
+ * PNCLIPP.B - Pack narrow clip signed halfwords to bytes (RV64 only)
+ */
+uint64_t HELPER(pnclipp_b)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        int16_t lo = (int16_t)EXTRACT16(rs1, i);
+        int16_t hi = (int16_t)EXTRACT16(rs2, i);
+        int8_t res_lo = signed_saturate_b(lo, &sat);
+        int8_t res_hi = signed_saturate_b(hi, &sat);
+
+        rd = (uint64_t)INSERT8(rd, res_lo, i);
+        rd = (uint64_t)INSERT8(rd, res_hi, i + 4);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPUP.B - Pack narrow clip unsigned halfwords to bytes (RV64 only)
+ */
+uint64_t HELPER(pnclipup_b)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t lo = (uint16_t)EXTRACT16(rs1, i);
+        uint16_t hi = (uint16_t)EXTRACT16(rs2, i);
+        uint8_t res_lo = unsigned_saturate_b(lo, &sat);
+        uint8_t res_hi = unsigned_saturate_b(hi, &sat);
+
+        rd = (uint64_t)INSERT8(rd, res_lo, i);
+        rd = (uint64_t)INSERT8(rd, res_hi, i + 4);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPP.H - Pack narrow clip signed words to halfwords (RV64 only)
+ */
+uint64_t HELPER(pnclipp_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t lo = (int32_t)EXTRACT32(rs1, i);
+        int32_t hi = (int32_t)EXTRACT32(rs2, i);
+        int16_t res_lo = signed_saturate_h(lo, &sat);
+        int16_t res_hi = signed_saturate_h(hi, &sat);
+
+        rd = (uint64_t)INSERT16(rd, res_lo, i);
+        rd = (uint64_t)INSERT16(rd, res_hi, i + 2);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPUP.H - Pack narrow clip unsigned words to halfwords (RV64 only)
+ */
+uint64_t HELPER(pnclipup_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint32_t lo = (uint32_t)EXTRACT32(rs1, i);
+        uint32_t hi = (uint32_t)EXTRACT32(rs2, i);
+        uint16_t res_lo = unsigned_saturate_h(lo, &sat);
+        uint16_t res_hi = unsigned_saturate_h(hi, &sat);
+
+        rd = (uint64_t)INSERT16(rd, res_lo, i);
+        rd = (uint64_t)INSERT16(rd, res_hi, i + 2);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPP.W - Pack narrow clip signed doublewords to words (RV64 only)
+ */
+uint64_t HELPER(pnclipp_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+    int32_t res_lo = signed_saturate_w((int64_t)rs1, &sat);
+    int32_t res_hi = signed_saturate_w((int64_t)rs2, &sat);
+
+    rd = (uint64_t)(uint32_t)res_lo;
+    rd |= (uint64_t)(uint32_t)res_hi << 32;
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PNCLIPUP.W - Pack narrow clip unsigned doublewords to words (RV64 only)
+ */
+uint64_t HELPER(pnclipup_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int sat = 0;
+    uint32_t res_lo = unsigned_saturate_w(rs1, &sat);
+    uint32_t res_hi = unsigned_saturate_w(rs2, &sat);
+
+    rd = (uint64_t)res_lo;
+    rd |= (uint64_t)res_hi << 32;
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
 /* Count leading operations */
 
 /**
-- 
2.34.1


