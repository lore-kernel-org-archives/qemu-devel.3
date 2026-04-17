Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0C6F4368B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjW-0001Ft-RX; Fri, 17 Apr 2026 06:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjP-00017T-HB; Fri, 17 Apr 2026 06:47:28 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjL-0007zq-9r; Fri, 17 Apr 2026 06:47:27 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S12;
 Fri, 17 Apr 2026 18:47:19 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/14] target/riscv: rvp: add Q-format multiplication
 operations
Date: Fri, 17 Apr 2026 18:46:47 +0800
Message-Id: <20260417104652.17857-11-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S12
X-Coremail-Antispam: 1UD129KBjvAXoW3trW3Ar43XF43Aw17Kw1kAFb_yoW8Aw1rAo
 W3Gw1Yy395uw17ur409w4UX3WUXrZ2qw1DXw4UZr47Xa4xKrnrKF45J34kAFyxGrWayrW7
 WFZ3JF1rtFy3C3sxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
 target/riscv/helper.h                   |  28 ++
 target/riscv/insn32.decode              |  43 +++
 target/riscv/insn_trans/trans_rvp.c.inc |  28 ++
 target/riscv/psimd_helper.c             | 446 ++++++++++++++++++++++++
 4 files changed, 545 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 54f8591672..a5ecf9b7d7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1661,3 +1661,31 @@ DEF_HELPER_4(maccsu_w11, i64, env, i64, i64, i64)
 DEF_HELPER_4(maccu_w00, i64, env, i64, i64, i64)
 DEF_HELPER_4(maccu_w01, i64, env, i64, i64, i64)
 DEF_HELPER_4(maccu_w11, i64, env, i64, i64, i64)
+
+/* Packed SIMD - Q-Format Multiplication Operations */
+DEF_HELPER_3(pmulq_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulqr_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulq_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulqr_w, i64, env, i64, i64)
+DEF_HELPER_3(mulq, i32, env, i32, i32)
+DEF_HELPER_3(mulqr, i32, env, i32, i32)
+
+/* Packed SIMD - Q-Format Multiply-Accumulate Operations */
+DEF_HELPER_4(mqacc_h00, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqacc_h01, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqacc_h11, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqracc_h00, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqracc_h01, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqracc_h11, i32, env, i32, i32, i32)
+DEF_HELPER_4(mqacc_w00, i64, env, i64, i64, i64)
+DEF_HELPER_4(mqacc_w01, i64, env, i64, i64, i64)
+DEF_HELPER_4(mqacc_w11, i64, env, i64, i64, i64)
+DEF_HELPER_4(mqracc_w00, i64, env, i64, i64, i64)
+DEF_HELPER_4(mqracc_w01, i64, env, i64, i64, i64)
+DEF_HELPER_4(mqracc_w11, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqacc_w_h00, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqacc_w_h01, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqacc_w_h11, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqracc_w_h00, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqracc_w_h01, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqracc_w_h11, i64, env, i64, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 9944d0b52c..b2a89e3a1f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1505,3 +1505,46 @@ maccsu_w11      11111 11 ..... ..... 011 ..... 0111011 @r
 maccu_w00       10101 11 ..... ..... 011 ..... 0111011 @r
 maccu_w01       10111 11 ..... ..... 001 ..... 0111011 @r
 maccu_w11       10111 11 ..... ..... 011 ..... 0111011 @r
+
+# Packed SIMD - Q-Format Multiplication Operations
+pmulq_h     11010 00 ..... ..... 111 ..... 0111011 @r
+pmulqr_h    11010 10 ..... ..... 111 ..... 0111011 @r
+{
+  mulq      11010 01 ..... ..... 111 ..... 0111011 @r
+  pmulq_w   11010 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mulqr     11010 11 ..... ..... 111 ..... 0111011 @r
+  pmulqr_w  11010 11 ..... ..... 111 ..... 0111011 @r
+}
+# Packed SIMD - Q-Format Multiply-Accumulate Operations
+{
+  mqacc_h00 11101 00 ..... ..... 111 ..... 0111011 @r
+  pmqacc_w_h00  11101 00 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mqacc_h01 11111 00 ..... ..... 101 ..... 0111011 @r
+  pmqacc_w_h01 11111 00 ..... ..... 101 ..... 0111011 @r
+}
+{
+  mqacc_h11 11111 00 ..... ..... 111 ..... 0111011 @r
+  pmqacc_w_h11 11111 00 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mqracc_h00 11101 10 ..... ..... 111 ..... 0111011 @r
+  pmqracc_w_h00 11101 10 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mqracc_h01 11111 10 ..... ..... 101 ..... 0111011 @r
+  pmqracc_w_h01 11111 10 ..... ..... 101 ..... 0111011 @r
+}
+{
+  mqracc_h11 11111 10 ..... ..... 111 ..... 0111011 @r
+  pmqracc_w_h11 11111 10 ..... ..... 111 ..... 0111011 @r
+}
+mqacc_w00       11101 01 ..... ..... 111 ..... 0111011 @r
+mqacc_w01       11111 01 ..... ..... 101 ..... 0111011 @r
+mqacc_w11       11111 01 ..... ..... 111 ..... 0111011 @r
+mqracc_w00      11101 11 ..... ..... 111 ..... 0111011 @r
+mqracc_w01      11111 11 ..... ..... 101 ..... 0111011 @r
+mqracc_w11      11111 11 ..... ..... 111 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index b3476c26ad..3310e23dce 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -830,3 +830,31 @@ GEN_SIMD_TRANS_ACC_64(maccsu_w11)
 GEN_SIMD_TRANS_ACC_64(maccu_w00)
 GEN_SIMD_TRANS_ACC_64(maccu_w01)
 GEN_SIMD_TRANS_ACC_64(maccu_w11)
+
+/* Packed SIMD - Q-Format Multiplication Operations */
+GEN_SIMD_TRANS(pmulq_h)
+GEN_SIMD_TRANS(pmulqr_h)
+GEN_SIMD_TRANS_64(pmulq_w)
+GEN_SIMD_TRANS_64(pmulqr_w)
+GEN_SIMD_TRANS_32(mulq)
+GEN_SIMD_TRANS_32(mulqr)
+
+/* Packed SIMD - Q-Format Multiply-Accumulate Operations */
+GEN_SIMD_TRANS_ACC_32(mqacc_h00)
+GEN_SIMD_TRANS_ACC_32(mqacc_h01)
+GEN_SIMD_TRANS_ACC_32(mqacc_h11)
+GEN_SIMD_TRANS_ACC_32(mqracc_h00)
+GEN_SIMD_TRANS_ACC_32(mqracc_h01)
+GEN_SIMD_TRANS_ACC_32(mqracc_h11)
+GEN_SIMD_TRANS_ACC_64(mqacc_w00)
+GEN_SIMD_TRANS_ACC_64(mqacc_w01)
+GEN_SIMD_TRANS_ACC_64(mqacc_w11)
+GEN_SIMD_TRANS_ACC_64(mqracc_w00)
+GEN_SIMD_TRANS_ACC_64(mqracc_w01)
+GEN_SIMD_TRANS_ACC_64(mqracc_w11)
+GEN_SIMD_TRANS_ACC_64(pmqacc_w_h00)
+GEN_SIMD_TRANS_ACC_64(pmqacc_w_h01)
+GEN_SIMD_TRANS_ACC_64(pmqacc_w_h11)
+GEN_SIMD_TRANS_ACC_64(pmqracc_w_h00)
+GEN_SIMD_TRANS_ACC_64(pmqracc_w_h01)
+GEN_SIMD_TRANS_ACC_64(pmqracc_w_h11)
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index bddd24c997..d69a2f6453 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -5628,3 +5628,449 @@ uint64_t HELPER(maccu_w11)(CPURISCVState *env, uint64_t rs1,
     uint64_t mul = (uint64_t)s1_w1 * (uint64_t)s2_w1;
     return d_w + mul;
 }
+
+/* Q-Format Multiplication Operations */
+
+/**
+ * PMULQ.H - Packed signed Q-format multiply (fractional)
+ */
+target_ulong HELPER(pmulq_h)(CPURISCVState *env, target_ulong rs1,
+                             target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        uint16_t result;
+
+        if ((e1 == -32768) && (e2 == -32768)) {
+            sat = 1;
+            result = 0x7FFF;
+        } else {
+            int32_t prod = (int32_t)e1 * (int32_t)e2;
+            result = (prod >> 15) & 0xFFFF;
+        }
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PMULQR.H - Packed signed Q-format multiply with rounding
+ */
+target_ulong HELPER(pmulqr_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        uint16_t result;
+
+        if ((e1 == -32768) && (e2 == -32768)) {
+            sat = 1;
+            result = 0x7FFF;
+        } else {
+            int32_t prod = (int32_t)e1 * (int32_t)e2 + (1 << 14);
+            result = (prod >> 15) & 0xFFFF;
+        }
+        rd = INSERT16(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PMULQ.W - Packed signed 32-bit Q-format multiply (RV64 only)
+ */
+uint64_t HELPER(pmulq_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        uint32_t result;
+
+        if ((e1 == -2147483647 - 1) && (e2 == -2147483647 - 1)) {
+            sat = 1;
+            result = 0x7FFFFFFF;
+        } else {
+            int64_t prod = (int64_t)e1 * (int64_t)e2;
+            result = (uint32_t)(prod >> 31);
+        }
+        rd = INSERT32(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PMULQR.W - Packed signed 32-bit Q-format multiply with rounding (RV64 only)
+ */
+uint64_t HELPER(pmulqr_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        uint32_t result;
+
+        if ((e1 == -2147483647 - 1) && (e2 == -2147483647 - 1)) {
+            sat = 1;
+            result = 0x7FFFFFFF;
+        } else {
+            int64_t prod = (int64_t)e1 * (int64_t)e2 + (1LL << 30);
+            result = (uint32_t)(prod >> 31);
+        }
+        rd = INSERT32(rd, result, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * MULQ - 32-bit signed Q-format multiply
+ */
+uint32_t HELPER(mulq)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int32_t b = (int32_t)rs2;
+
+    if ((a == -2147483647 - 1) && (b == -2147483647 - 1)) {
+        env->vxsat = 1;
+        return 0x7FFFFFFF;
+    } else {
+        int64_t prod = (int64_t)a * (int64_t)b;
+        return (uint32_t)(prod >> 31);
+    }
+}
+
+/**
+ * MULQR - 32-bit signed Q-format multiply with rounding
+ */
+uint32_t HELPER(mulqr)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int32_t b = (int32_t)rs2;
+
+    if ((a == -2147483647 - 1) && (b == -2147483647 - 1)) {
+        env->vxsat = 1;
+        return 0x7FFFFFFF;
+    } else {
+        int64_t prod = (int64_t)a * (int64_t)b + (1LL << 30);
+        return (uint32_t)(prod >> 31);
+    }
+}
+
+
+/* Q-Format Multiply-Accumulate Operations */
+
+/**
+ * MQACC.H00 - Q-format multiply accumulate, both operands low halfword
+ */
+uint32_t HELPER(mqacc_h00)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)(rs1 & 0xFFFF);
+    int16_t s2_h0 = (int16_t)(rs2 & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h0;
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQACC.H01 - Q-format multiply accumulate, rs1 low, rs2 high
+ */
+uint32_t HELPER(mqacc_h01)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)(rs1 & 0xFFFF);
+    int16_t s2_h1 = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h1;
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQACC.H11 - Q-format multiply accumulate, both operands high halfword
+ */
+uint32_t HELPER(mqacc_h11)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h1 = (int16_t)((rs1 >> 16) & 0xFFFF);
+    int16_t s2_h1 = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h1 * (int64_t)s2_h1;
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQRACC.H00 - Q-format multiply accumulate with rounding, both low halfword
+ */
+uint32_t HELPER(mqracc_h00)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)(rs1 & 0xFFFF);
+    int16_t s2_h0 = (int16_t)(rs2 & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h0 + (1LL << 14);
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQRACC.H01 - Q-format multiply accumulate with rounding, rs1 low, rs2 high
+ */
+uint32_t HELPER(mqracc_h01)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)(rs1 & 0xFFFF);
+    int16_t s2_h1 = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h1 + (1LL << 14);
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQRACC.H11 - Q-format multiply accumulate with rounding, both high halfword
+ */
+uint32_t HELPER(mqracc_h11)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h1 = (int16_t)((rs1 >> 16) & 0xFFFF);
+    int16_t s2_h1 = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)s1_h1 * (int64_t)s2_h1 + (1LL << 14);
+    return (uint32_t)(d + (int32_t)(prod >> 15));
+}
+
+/**
+ * MQACC.W00 - Q-format multiply accumulate, both low word (RV64)
+ */
+uint64_t HELPER(mqacc_w00)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)(rs1 & 0xFFFFFFFF);
+    int32_t s2_w0 = (int32_t)(rs2 & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w0 * (int64_t)s2_w0;
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * MQACC.W01 - Q-format multiply accumulate, rs1 low, rs2 high (RV64)
+ */
+uint64_t HELPER(mqacc_w01)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)(rs1 & 0xFFFFFFFF);
+    int32_t s2_w1 = (int32_t)((rs2 >> 32) & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w0 * (int64_t)s2_w1;
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * MQACC.W11 - Q-format multiply accumulate, both high word (RV64)
+ */
+uint64_t HELPER(mqacc_w11)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w1 = (int32_t)((rs1 >> 32) & 0xFFFFFFFF);
+    int32_t s2_w1 = (int32_t)((rs2 >> 32) & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w1 * (int64_t)s2_w1;
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * MQRACC.W00 - Q-format multiply accumulate with rounding,
+ * both low word (RV64)
+ */
+uint64_t HELPER(mqracc_w00)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)(rs1 & 0xFFFFFFFF);
+    int32_t s2_w0 = (int32_t)(rs2 & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w0 * (int64_t)s2_w0 + (1LL << 30);
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * MQRACC.W01 - Q-format multiply accumulate with rounding,
+ * rs1 low, rs2 high (RV64)
+ */
+uint64_t HELPER(mqracc_w01)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)(rs1 & 0xFFFFFFFF);
+    int32_t s2_w1 = (int32_t)((rs2 >> 32) & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w0 * (int64_t)s2_w1 + (1LL << 30);
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * MQRACC.W11 - Q-format multiply accumulate with rounding,
+ * both high word (RV64)
+ */
+uint64_t HELPER(mqracc_w11)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w1 = (int32_t)((rs1 >> 32) & 0xFFFFFFFF);
+    int32_t s2_w1 = (int32_t)((rs2 >> 32) & 0xFFFFFFFF);
+    int64_t d = (int64_t)dest;
+    int64_t prod = (int64_t)s1_w1 * (int64_t)s2_w1 + (1LL << 30);
+    __int128_t prod_95 = ((__int128_t)prod) >> 31;
+    return (uint64_t)(d + (int64_t)prod_95);
+}
+
+/**
+ * PMQACC.W.H00 - Packed Q-format multiply accumulate,
+ * low halfword (RV64)
+ */
+uint64_t HELPER(pmqacc_w_h00)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h0;
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQACC.W.H01 - Packed Q-format multiply accumulate,
+ * rs1 low, rs2 high (RV64)
+ */
+uint64_t HELPER(pmqacc_w_h01)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h1;
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQACC.W.H11 - Packed Q-format multiply accumulate,
+ * both high halfword (RV64)
+ */
+uint64_t HELPER(pmqacc_w_h11)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h1 * (int64_t)s2_h1;
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQRACC.W.H00 - Packed Q-format multiply accumulate
+ * with rounding, low halfword (RV64)
+ */
+uint64_t HELPER(pmqracc_w_h00)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h0 + (1LL << 14);
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQRACC.W.H01 - Packed Q-format multiply accumulate
+ * with rounding, rs1 low, rs2 high (RV64)
+ */
+uint64_t HELPER(pmqracc_w_h01)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h0 * (int64_t)s2_h1 + (1LL << 14);
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQRACC.W.H11 - Packed Q-format multiply accumulate
+ * with rounding, both high halfword (RV64)
+ */
+uint64_t HELPER(pmqracc_w_h11)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_w = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)s1_h1 * (int64_t)s2_h1 + (1LL << 14);
+        uint32_t res = (uint32_t)(d_w + (int32_t)(prod >> 15));
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
-- 
2.34.1


