Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE588F4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjq-0001Wz-GK; Fri, 17 Apr 2026 06:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjn-0001Ps-Ig; Fri, 17 Apr 2026 06:47:51 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjh-00080h-PI; Fri, 17 Apr 2026 06:47:51 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S13;
 Fri, 17 Apr 2026 18:47:20 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/14] target/riscv: rvp: add two-way and four-way multiply
 and accumulate operations
Date: Fri, 17 Apr 2026 18:46:48 +0800
Message-Id: <20260417104652.17857-12-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S13
X-Coremail-Antispam: 1UD129KBjvAXoWfKw48WryDAw4UArWkGrW7urg_yoWrWr1kto
 W3G3Wjy393Xw17uws5uw1UZr1vvrW2vrn8Ww40vr15Xas7Gry7KF1rXw1kZFW8CrWSyFWU
 WrZ2vF1rJa43C3srn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
 target/riscv/helper.h                   |  48 ++
 target/riscv/insn32.decode              |  48 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  48 ++
 target/riscv/psimd_helper.c             | 938 ++++++++++++++++++++++++
 4 files changed, 1082 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a5ecf9b7d7..663ac0e242 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1689,3 +1689,51 @@ DEF_HELPER_4(pmqacc_w_h11, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h00, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h01, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h11, i64, env, i64, i64, i64)
+
+/* Packed SIMD - Two-Way Multiply and Accumulate Operations */
+DEF_HELPER_3(pmq2add_h, tl, env, tl, tl)
+DEF_HELPER_3(pmqr2add_h, tl, env, tl, tl)
+DEF_HELPER_4(pmq2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmqr2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_3(pmq2add_w, i64, env, i64, i64)
+DEF_HELPER_3(pmqr2add_w, i64, env, i64, i64)
+DEF_HELPER_4(pmq2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqr2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_3(pm2add_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2addsu_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2addu_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2add_hx, tl, env, tl, tl)
+DEF_HELPER_3(pm2sub_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2sub_hx, tl, env, tl, tl)
+DEF_HELPER_4(pm2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2addasu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2addau_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2adda_hx, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2suba_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2suba_hx, tl, env, tl, tl, tl)
+DEF_HELPER_3(pm2add_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2addsu_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2addu_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2add_wx, i64, env, i64, i64)
+DEF_HELPER_3(pm2sub_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2sub_wx, i64, env, i64, i64)
+DEF_HELPER_4(pm2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2addasu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2addau_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2adda_wx, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2suba_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2suba_wx, i64, env, i64, i64, i64)
+
+/* Packed SIMD - Four-Way Multiply and Accumulate Operations */
+DEF_HELPER_3(pm4add_b, tl, env, tl, tl)
+DEF_HELPER_3(pm4addsu_b, tl, env, tl, tl)
+DEF_HELPER_3(pm4addu_b, tl, env, tl, tl)
+DEF_HELPER_4(pm4adda_b, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm4addasu_b, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm4addau_b, tl, env, tl, tl, tl)
+DEF_HELPER_3(pm4add_h, i64, env, i64, i64)
+DEF_HELPER_3(pm4addsu_h, i64, env, i64, i64)
+DEF_HELPER_3(pm4addu_h, i64, env, i64, i64)
+DEF_HELPER_4(pm4adda_h, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm4addasu_h, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm4addau_h, i64, env, i64, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b2a89e3a1f..ebfbf8c799 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1548,3 +1548,51 @@ mqacc_w11       11111 01 ..... ..... 111 ..... 0111011 @r
 mqracc_w00      11101 11 ..... ..... 111 ..... 0111011 @r
 mqracc_w01      11111 11 ..... ..... 101 ..... 0111011 @r
 mqracc_w11      11111 11 ..... ..... 111 ..... 0111011 @r
+
+# Packed SIMD - Two-Way Multiply and Accumulate Operations
+pmq2add_h       10110 00 ..... ..... 101 ..... 0111011 @r
+pmqr2add_h      10110 10 ..... ..... 101 ..... 0111011 @r
+pmq2adda_h      10111 00 ..... ..... 101 ..... 0111011 @r
+pmqr2adda_h     10111 10 ..... ..... 101 ..... 0111011 @r
+pmq2add_w       10110 01 ..... ..... 101 ..... 0111011 @r
+pmqr2add_w      10110 11 ..... ..... 101 ..... 0111011 @r
+pmq2adda_w      10111 01 ..... ..... 101 ..... 0111011 @r
+pmqr2adda_w     10111 11 ..... ..... 101 ..... 0111011 @r
+pm2add_h        10000 00 ..... ..... 101 ..... 0111011 @r
+pm2addsu_h      11100 00 ..... ..... 101 ..... 0111011 @r
+pm2addu_h       10100 00 ..... ..... 101 ..... 0111011 @r
+pm2add_hx       10010 00 ..... ..... 101 ..... 0111011 @r
+pm2sub_h        11000 00 ..... ..... 101 ..... 0111011 @r
+pm2sub_hx       11010 00 ..... ..... 101 ..... 0111011 @r
+pm2adda_h       10001 00 ..... ..... 101 ..... 0111011 @r
+pm2addasu_h     11101 00 ..... ..... 101 ..... 0111011 @r
+pm2addau_h      10101 00 ..... ..... 101 ..... 0111011 @r
+pm2adda_hx      10011 00 ..... ..... 101 ..... 0111011 @r
+pm2suba_h       11001 00 ..... ..... 101 ..... 0111011 @r
+pm2suba_hx      11011 00 ..... ..... 101 ..... 0111011 @r
+pm2add_w        10000 01 ..... ..... 101 ..... 0111011 @r
+pm2addsu_w      11100 01 ..... ..... 101 ..... 0111011 @r
+pm2addu_w       10100 01 ..... ..... 101 ..... 0111011 @r
+pm2add_wx       10010 01 ..... ..... 101 ..... 0111011 @r
+pm2sub_w        11000 01 ..... ..... 101 ..... 0111011 @r
+pm2sub_wx       11010 01 ..... ..... 101 ..... 0111011 @r
+pm2adda_w       10001 01 ..... ..... 101 ..... 0111011 @r
+pm2addasu_w     11101 01 ..... ..... 101 ..... 0111011 @r
+pm2addau_w      10101 01 ..... ..... 101 ..... 0111011 @r
+pm2adda_wx      10011 01 ..... ..... 101 ..... 0111011 @r
+pm2suba_w       11001 01 ..... ..... 101 ..... 0111011 @r
+pm2suba_wx      11011 01 ..... ..... 101 ..... 0111011 @r
+
+# Packed SIMD - Four-Way Multiply and Accumulate Operations
+pm4add_b        10000 10 ..... ..... 101 ..... 0111011 @r
+pm4addsu_b      11100 10 ..... ..... 101 ..... 0111011 @r
+pm4addu_b       10100 10 ..... ..... 101 ..... 0111011 @r
+pm4adda_b       10001 10 ..... ..... 101 ..... 0111011 @r
+pm4addasu_b     11101 10 ..... ..... 101 ..... 0111011 @r
+pm4addau_b      10101 10 ..... ..... 101 ..... 0111011 @r
+pm4add_h        10000 11 ..... ..... 101 ..... 0111011 @r
+pm4addsu_h      11100 11 ..... ..... 101 ..... 0111011 @r
+pm4addu_h       10100 11 ..... ..... 101 ..... 0111011 @r
+pm4adda_h       10001 11 ..... ..... 101 ..... 0111011 @r
+pm4addasu_h     11101 11 ..... ..... 101 ..... 0111011 @r
+pm4addau_h      10101 11 ..... ..... 101 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index 3310e23dce..86071d71f7 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -858,3 +858,51 @@ GEN_SIMD_TRANS_ACC_64(pmqacc_w_h11)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h00)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h01)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h11)
+
+/* Packed SIMD - Two-Way Multiply and Accumulate Operations */
+GEN_SIMD_TRANS(pmq2add_h)
+GEN_SIMD_TRANS(pmqr2add_h)
+GEN_SIMD_TRANS_ACC(pmq2adda_h)
+GEN_SIMD_TRANS_ACC(pmqr2adda_h)
+GEN_SIMD_TRANS_64(pmq2add_w)
+GEN_SIMD_TRANS_64(pmqr2add_w)
+GEN_SIMD_TRANS_ACC_64(pmq2adda_w)
+GEN_SIMD_TRANS_ACC_64(pmqr2adda_w)
+GEN_SIMD_TRANS(pm2add_h)
+GEN_SIMD_TRANS(pm2addsu_h)
+GEN_SIMD_TRANS(pm2addu_h)
+GEN_SIMD_TRANS(pm2add_hx)
+GEN_SIMD_TRANS(pm2sub_h)
+GEN_SIMD_TRANS(pm2sub_hx)
+GEN_SIMD_TRANS_ACC(pm2adda_h)
+GEN_SIMD_TRANS_ACC(pm2addasu_h)
+GEN_SIMD_TRANS_ACC(pm2addau_h)
+GEN_SIMD_TRANS_ACC(pm2adda_hx)
+GEN_SIMD_TRANS_ACC(pm2suba_h)
+GEN_SIMD_TRANS_ACC(pm2suba_hx)
+GEN_SIMD_TRANS_64(pm2add_w)
+GEN_SIMD_TRANS_64(pm2addsu_w)
+GEN_SIMD_TRANS_64(pm2addu_w)
+GEN_SIMD_TRANS_64(pm2add_wx)
+GEN_SIMD_TRANS_64(pm2sub_w)
+GEN_SIMD_TRANS_64(pm2sub_wx)
+GEN_SIMD_TRANS_ACC_64(pm2adda_w)
+GEN_SIMD_TRANS_ACC_64(pm2addasu_w)
+GEN_SIMD_TRANS_ACC_64(pm2addau_w)
+GEN_SIMD_TRANS_ACC_64(pm2adda_wx)
+GEN_SIMD_TRANS_ACC_64(pm2suba_w)
+GEN_SIMD_TRANS_ACC_64(pm2suba_wx)
+
+/* Packed SIMD - Four-Way Multiply and Accumulate Operations */
+GEN_SIMD_TRANS(pm4add_b)
+GEN_SIMD_TRANS(pm4addsu_b)
+GEN_SIMD_TRANS(pm4addu_b)
+GEN_SIMD_TRANS_ACC(pm4adda_b)
+GEN_SIMD_TRANS_ACC(pm4addasu_b)
+GEN_SIMD_TRANS_ACC(pm4addau_b)
+GEN_SIMD_TRANS_64(pm4add_h)
+GEN_SIMD_TRANS_64(pm4addsu_h)
+GEN_SIMD_TRANS_64(pm4addu_h)
+GEN_SIMD_TRANS_ACC_64(pm4adda_h)
+GEN_SIMD_TRANS_ACC_64(pm4addasu_h)
+GEN_SIMD_TRANS_ACC_64(pm4addau_h)
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index d69a2f6453..5eede48581 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -6074,3 +6074,941 @@ uint64_t HELPER(pmqracc_w_h11)(CPURISCVState *env, uint64_t rs1,
     }
     return rd;
 }
+
+/* Two-Way Multiply and Accumulate Operations */
+
+/**
+ * PMQ2ADD.H - Add two Q-format products
+ */
+target_ulong HELPER(pmq2add_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int64_t prod0_47 = ((int64_t)prod0) >> 15;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        int64_t prod1_47 = ((int64_t)prod1) >> 15;
+        uint32_t sum = (uint32_t)(prod0_47 + prod1_47);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQR2ADD.H - Add two Q-format products with rounding
+ */
+target_ulong HELPER(pmqr2add_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0 + (1LL << 14);
+        int64_t prod0_47 = ((int64_t)prod0) >> 15;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1 + (1LL << 14);
+        int64_t prod1_47 = ((int64_t)prod1) >> 15;
+        uint32_t sum = (uint32_t)(prod0_47 + prod1_47);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQ2ADDA.H - Add two Q-format products with accumulate
+ */
+target_ulong HELPER(pmq2adda_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int64_t prod0_47 = ((int64_t)prod0) >> 15;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        int64_t prod1_47 = ((int64_t)prod1) >> 15;
+        uint32_t sum = (uint32_t)(d + prod0_47 + prod1_47);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQR2ADDA.H - Add two Q-format products with rounding and accumulate
+ */
+target_ulong HELPER(pmqr2adda_h)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0 + (1LL << 14);
+        int64_t prod0_47 = ((int64_t)prod0) >> 15;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1 + (1LL << 14);
+        int64_t prod1_47 = ((int64_t)prod1) >> 15;
+        uint32_t sum = (uint32_t)(d + prod0_47 + prod1_47);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PMQ2ADD.W - Add two Q-format products (word, RV64 only)
+ */
+uint64_t HELPER(pmq2add_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    __int128_t prod0_95 = ((__int128_t)prod0) >> 31;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    __int128_t prod1_95 = ((__int128_t)prod1) >> 31;
+    return (uint64_t)(prod0_95 + prod1_95);
+}
+
+/**
+ * PMQR2ADD.W - Add two Q-format products with rounding (word, RV64 only)
+ */
+uint64_t HELPER(pmqr2add_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0 + (1LL << 30);
+    __int128_t prod0_95 = ((__int128_t)prod0) >> 31;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1 + (1LL << 30);
+    __int128_t prod1_95 = ((__int128_t)prod1) >> 31;
+    return (uint64_t)(prod0_95 + prod1_95);
+}
+
+/**
+ * PMQ2ADDA.W - Add two Q-format products with accumulate (word, RV64 only)
+ */
+uint64_t HELPER(pmq2adda_w)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    __int128_t prod0_95 = ((__int128_t)prod0) >> 31;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    __int128_t prod1_95 = ((__int128_t)prod1) >> 31;
+    return (uint64_t)(d + prod0_95 + prod1_95);
+}
+
+/**
+ * PMQR2ADDA.W - Add two Q-format products with rounding
+ * and accumulate (word, RV64 only)
+ */
+uint64_t HELPER(pmqr2adda_w)(CPURISCVState *env, uint64_t rs1,
+                             uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0 + (1LL << 30);
+    __int128_t prod0_95 = ((__int128_t)prod0) >> 31;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1 + (1LL << 30);
+    __int128_t prod1_95 = ((__int128_t)prod1) >> 31;
+    return (uint64_t)(d + prod0_95 + prod1_95);
+}
+
+/**
+ * PM2ADD.H - Add two products horizontally
+ * For each word: rd[i] = rs1[2i] * rs2[2i] + rs1[2i+1] * rs2[2i+1]
+ */
+target_ulong HELPER(pm2add_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        uint32_t sum = (uint32_t)(prod0 + prod1);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDSU.H - Add two products horizontally (signed x unsigned)
+ */
+target_ulong HELPER(pm2addsu_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod0 = (int32_t)s1_h0 * (uint32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (uint32_t)s2_h1;
+        uint32_t sum = (uint32_t)(prod0 + prod1);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDU.H - Add two products horizontally (unsigned)
+ */
+target_ulong HELPER(pm2addu_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s1_h1 = EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t prod0 = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+        uint32_t prod1 = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+        uint32_t sum = prod0 + prod1;
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADD.HX - Add cross products horizontally
+ * For each word: rd[i] = rs1[2i] * rs2[2i+1] + rs1[2i+1] * rs2[2i]
+ */
+target_ulong HELPER(pm2add_hx)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod01 = (int32_t)s1_h0 * (int32_t)s2_h1;
+        int32_t prod10 = (int32_t)s1_h1 * (int32_t)s2_h0;
+        uint32_t sum = (uint32_t)(prod01 + prod10);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2SUB.H - Subtract two products horizontally
+ * For each word: rd[i] = rs1[2i] * rs2[2i] - rs1[2i+1] * rs2[2i+1]
+ */
+target_ulong HELPER(pm2sub_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        uint32_t diff = (uint32_t)(prod0 - prod1);
+        rd = INSERT32(rd, diff, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2SUB.HX - Subtract cross products horizontally
+ * For each word: rd[i] = rs1[2i+1] * rs2[2i] - rs1[2i] * rs2[2i+1]
+ */
+target_ulong HELPER(pm2sub_hx)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t prod10 = (int32_t)s1_h1 * (int32_t)s2_h0;
+        int32_t prod01 = (int32_t)s1_h0 * (int32_t)s2_h1;
+        uint32_t diff = (uint32_t)(prod10 - prod01);
+        rd = INSERT32(rd, diff, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDA.H - Add two products horizontally with accumulate
+ */
+target_ulong HELPER(pm2adda_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        uint32_t sum = (uint32_t)(d + prod0 + prod1);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDASU.H - Add two products horizontally with accumulate
+ * (signed x unsigned)
+ */
+target_ulong HELPER(pm2addasu_h)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_h0 * (uint32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (uint32_t)s2_h1;
+        uint32_t sum = (uint32_t)(d + prod0 + prod1);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDAU.H - Add two products horizontally with accumulate (unsigned)
+ */
+target_ulong HELPER(pm2addau_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s1_h1 = EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t d = EXTRACT32(dest, i);
+        uint32_t prod0 = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+        uint32_t prod1 = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+        uint32_t sum = d + prod0 + prod1;
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADDA.HX - Add cross products horizontally with accumulate
+ */
+target_ulong HELPER(pm2adda_hx)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod01 = (int32_t)s1_h0 * (int32_t)s2_h1;
+        int32_t prod10 = (int32_t)s1_h1 * (int32_t)s2_h0;
+        uint32_t sum = (uint32_t)(d + prod01 + prod10);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2SUBA.H - Subtract two products horizontally with accumulate
+ */
+target_ulong HELPER(pm2suba_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_h0 * (int32_t)s2_h0;
+        int32_t prod1 = (int32_t)s1_h1 * (int32_t)s2_h1;
+        uint32_t diff = (uint32_t)(d + prod0 - prod1);
+        rd = INSERT32(rd, diff, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2SUBA.HX - Subtract cross products horizontally with accumulate
+ */
+target_ulong HELPER(pm2suba_hx)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod01 = (int32_t)s1_h0 * (int32_t)s2_h1;
+        int32_t prod10 = (int32_t)s1_h1 * (int32_t)s2_h0;
+        uint32_t diff = (uint32_t)(d + prod01 - prod10);
+        rd = INSERT32(rd, diff, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2ADD.W - Add two products horizontally (word, RV64 only)
+ */
+uint64_t HELPER(pm2add_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)(prod0 + prod1);
+}
+
+/**
+ * PM2ADDSU.W - Add two products horizontally (signed x unsigned, RV64 only)
+ */
+uint64_t HELPER(pm2addsu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    int64_t prod0 = (int64_t)s1_w0 * (uint64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (uint64_t)s2_w1;
+    return (uint64_t)(prod0 + prod1);
+}
+
+/**
+ * PM2ADDU.W - Add two products horizontally (unsigned, RV64 only)
+ */
+uint64_t HELPER(pm2addu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s1_w1 = EXTRACT32(rs1, 1);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t prod0 = (uint64_t)s1_w0 * (uint64_t)s2_w0;
+    uint64_t prod1 = (uint64_t)s1_w1 * (uint64_t)s2_w1;
+    return prod0 + prod1;
+}
+
+/**
+ * PM2ADD.WX - Add cross products horizontally (word, RV64 only)
+ */
+uint64_t HELPER(pm2add_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod01 = (int64_t)s1_w0 * (int64_t)s2_w1;
+    int64_t prod10 = (int64_t)s1_w1 * (int64_t)s2_w0;
+    return (uint64_t)(prod01 + prod10);
+}
+
+/**
+ * PM2SUB.W - Subtract two products horizontally (word, RV64 only)
+ */
+uint64_t HELPER(pm2sub_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)(prod0 - prod1);
+}
+
+/**
+ * PM2SUB.WX - Subtract cross products horizontally (word, RV64 only)
+ */
+uint64_t HELPER(pm2sub_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t prod10 = (int64_t)s1_w1 * (int64_t)s2_w0;
+    int64_t prod01 = (int64_t)s1_w0 * (int64_t)s2_w1;
+    return (uint64_t)(prod10 - prod01);
+}
+
+/**
+ * PM2ADDA.W - Add two products horizontally with accumulate (word, RV64 only)
+ */
+uint64_t HELPER(pm2adda_w)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)(d + prod0 + prod1);
+}
+
+/**
+ * PM2ADDASU.W - Add two products horizontally with accumulate
+ * (signed x unsigned, RV64 only)
+ */
+uint64_t HELPER(pm2addasu_w)(CPURISCVState *env, uint64_t rs1,
+                             uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_w0 * (uint64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (uint64_t)s2_w1;
+    return (uint64_t)(d + prod0 + prod1);
+}
+
+/**
+ * PM2ADDAU.W - Add two products horizontally with accumulate
+ * (unsigned, RV64 only)
+ */
+uint64_t HELPER(pm2addau_w)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s1_w1 = EXTRACT32(rs1, 1);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t d = dest;
+    uint64_t prod0 = (uint64_t)s1_w0 * (uint64_t)s2_w0;
+    uint64_t prod1 = (uint64_t)s1_w1 * (uint64_t)s2_w1;
+    return d + prod0 + prod1;
+}
+
+/**
+ * PM2ADDA.WX - Add cross products horizontally with accumulate
+ * (word, RV64 only)
+ */
+uint64_t HELPER(pm2adda_wx)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod01 = (int64_t)s1_w0 * (int64_t)s2_w1;
+    int64_t prod10 = (int64_t)s1_w1 * (int64_t)s2_w0;
+    return (uint64_t)(d + prod01 + prod10);
+}
+
+/**
+ * PM2SUBA.W - Subtract two products horizontally with accumulate
+ * (word, RV64 only)
+ */
+uint64_t HELPER(pm2suba_w)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_w0 * (int64_t)s2_w0;
+    int64_t prod1 = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)(d + prod0 - prod1);
+}
+
+/**
+ * PM2SUBA.WX - Subtract cross products horizontally with accumulate
+ * (word, RV64 only)
+ */
+uint64_t HELPER(pm2suba_wx)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d = (int64_t)dest;
+    int64_t prod01 = (int64_t)s1_w0 * (int64_t)s2_w1;
+    int64_t prod10 = (int64_t)s1_w1 * (int64_t)s2_w0;
+    return (uint64_t)(d + prod01 - prod10);
+}
+
+
+/* Four-Way Multiply and Accumulate Operations */
+
+/**
+ * PM4ADD.B - Add four products horizontally (byte to word)
+ */
+target_ulong HELPER(pm4add_b)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t s1_b0 = (int8_t)EXTRACT8(rs1, i * 4);
+        int8_t s1_b1 = (int8_t)EXTRACT8(rs1, i * 4 + 1);
+        int8_t s1_b2 = (int8_t)EXTRACT8(rs1, i * 4 + 2);
+        int8_t s1_b3 = (int8_t)EXTRACT8(rs1, i * 4 + 3);
+        int8_t s2_b0 = (int8_t)EXTRACT8(rs2, i * 4);
+        int8_t s2_b1 = (int8_t)EXTRACT8(rs2, i * 4 + 1);
+        int8_t s2_b2 = (int8_t)EXTRACT8(rs2, i * 4 + 2);
+        int8_t s2_b3 = (int8_t)EXTRACT8(rs2, i * 4 + 3);
+        int32_t prod0 = (int32_t)s1_b0 * (int32_t)s2_b0;
+        int32_t prod1 = (int32_t)s1_b1 * (int32_t)s2_b1;
+        int32_t prod2 = (int32_t)s1_b2 * (int32_t)s2_b2;
+        int32_t prod3 = (int32_t)s1_b3 * (int32_t)s2_b3;
+        uint32_t sum = (uint32_t)(prod0 + prod1 + prod2 + prod3);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADDSU.B - Add four products horizontally (signed x unsigned)
+ */
+target_ulong HELPER(pm4addsu_b)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t s1_b0 = (int8_t)EXTRACT8(rs1, i * 4);
+        int8_t s1_b1 = (int8_t)EXTRACT8(rs1, i * 4 + 1);
+        int8_t s1_b2 = (int8_t)EXTRACT8(rs1, i * 4 + 2);
+        int8_t s1_b3 = (int8_t)EXTRACT8(rs1, i * 4 + 3);
+        uint8_t s2_b0 = EXTRACT8(rs2, i * 4);
+        uint8_t s2_b1 = EXTRACT8(rs2, i * 4 + 1);
+        uint8_t s2_b2 = EXTRACT8(rs2, i * 4 + 2);
+        uint8_t s2_b3 = EXTRACT8(rs2, i * 4 + 3);
+        int32_t prod0 = (int32_t)s1_b0 * (uint32_t)s2_b0;
+        int32_t prod1 = (int32_t)s1_b1 * (uint32_t)s2_b1;
+        int32_t prod2 = (int32_t)s1_b2 * (uint32_t)s2_b2;
+        int32_t prod3 = (int32_t)s1_b3 * (uint32_t)s2_b3;
+        uint32_t sum = (uint32_t)(prod0 + prod1 + prod2 + prod3);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADDU.B - Add four products horizontally (unsigned)
+ */
+target_ulong HELPER(pm4addu_b)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t s1_b0 = EXTRACT8(rs1, i * 4);
+        uint8_t s1_b1 = EXTRACT8(rs1, i * 4 + 1);
+        uint8_t s1_b2 = EXTRACT8(rs1, i * 4 + 2);
+        uint8_t s1_b3 = EXTRACT8(rs1, i * 4 + 3);
+        uint8_t s2_b0 = EXTRACT8(rs2, i * 4);
+        uint8_t s2_b1 = EXTRACT8(rs2, i * 4 + 1);
+        uint8_t s2_b2 = EXTRACT8(rs2, i * 4 + 2);
+        uint8_t s2_b3 = EXTRACT8(rs2, i * 4 + 3);
+        uint32_t prod0 = (uint32_t)s1_b0 * (uint32_t)s2_b0;
+        uint32_t prod1 = (uint32_t)s1_b1 * (uint32_t)s2_b1;
+        uint32_t prod2 = (uint32_t)s1_b2 * (uint32_t)s2_b2;
+        uint32_t prod3 = (uint32_t)s1_b3 * (uint32_t)s2_b3;
+        uint32_t sum = prod0 + prod1 + prod2 + prod3;
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADDA.B - Add four products horizontally with accumulate
+ */
+target_ulong HELPER(pm4adda_b)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t s1_b0 = (int8_t)EXTRACT8(rs1, i * 4);
+        int8_t s1_b1 = (int8_t)EXTRACT8(rs1, i * 4 + 1);
+        int8_t s1_b2 = (int8_t)EXTRACT8(rs1, i * 4 + 2);
+        int8_t s1_b3 = (int8_t)EXTRACT8(rs1, i * 4 + 3);
+        int8_t s2_b0 = (int8_t)EXTRACT8(rs2, i * 4);
+        int8_t s2_b1 = (int8_t)EXTRACT8(rs2, i * 4 + 1);
+        int8_t s2_b2 = (int8_t)EXTRACT8(rs2, i * 4 + 2);
+        int8_t s2_b3 = (int8_t)EXTRACT8(rs2, i * 4 + 3);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_b0 * (int32_t)s2_b0;
+        int32_t prod1 = (int32_t)s1_b1 * (int32_t)s2_b1;
+        int32_t prod2 = (int32_t)s1_b2 * (int32_t)s2_b2;
+        int32_t prod3 = (int32_t)s1_b3 * (int32_t)s2_b3;
+        uint32_t sum = (uint32_t)(d + prod0 + prod1 + prod2 + prod3);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADDASU.B - Add four products horizontally with accumulate
+ * (signed x unsigned)
+ */
+target_ulong HELPER(pm4addasu_b)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t s1_b0 = (int8_t)EXTRACT8(rs1, i * 4);
+        int8_t s1_b1 = (int8_t)EXTRACT8(rs1, i * 4 + 1);
+        int8_t s1_b2 = (int8_t)EXTRACT8(rs1, i * 4 + 2);
+        int8_t s1_b3 = (int8_t)EXTRACT8(rs1, i * 4 + 3);
+        uint8_t s2_b0 = EXTRACT8(rs2, i * 4);
+        uint8_t s2_b1 = EXTRACT8(rs2, i * 4 + 1);
+        uint8_t s2_b2 = EXTRACT8(rs2, i * 4 + 2);
+        uint8_t s2_b3 = EXTRACT8(rs2, i * 4 + 3);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int32_t prod0 = (int32_t)s1_b0 * (uint32_t)s2_b0;
+        int32_t prod1 = (int32_t)s1_b1 * (uint32_t)s2_b1;
+        int32_t prod2 = (int32_t)s1_b2 * (uint32_t)s2_b2;
+        int32_t prod3 = (int32_t)s1_b3 * (uint32_t)s2_b3;
+        uint32_t sum = (uint32_t)(d + prod0 + prod1 + prod2 + prod3);
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADDAU.B - Add four products horizontally with accumulate (unsigned)
+ */
+target_ulong HELPER(pm4addau_b)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t s1_b0 = EXTRACT8(rs1, i * 4);
+        uint8_t s1_b1 = EXTRACT8(rs1, i * 4 + 1);
+        uint8_t s1_b2 = EXTRACT8(rs1, i * 4 + 2);
+        uint8_t s1_b3 = EXTRACT8(rs1, i * 4 + 3);
+        uint8_t s2_b0 = EXTRACT8(rs2, i * 4);
+        uint8_t s2_b1 = EXTRACT8(rs2, i * 4 + 1);
+        uint8_t s2_b2 = EXTRACT8(rs2, i * 4 + 2);
+        uint8_t s2_b3 = EXTRACT8(rs2, i * 4 + 3);
+        uint32_t d = EXTRACT32(dest, i);
+        uint32_t prod0 = (uint32_t)s1_b0 * (uint32_t)s2_b0;
+        uint32_t prod1 = (uint32_t)s1_b1 * (uint32_t)s2_b1;
+        uint32_t prod2 = (uint32_t)s1_b2 * (uint32_t)s2_b2;
+        uint32_t prod3 = (uint32_t)s1_b3 * (uint32_t)s2_b3;
+        uint32_t sum = d + prod0 + prod1 + prod2 + prod3;
+        rd = INSERT32(rd, sum, i);
+    }
+    return rd;
+}
+
+/**
+ * PM4ADD.H - Add four products horizontally (halfword to doubleword, RV64 only)
+ */
+uint64_t HELPER(pm4add_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s1_h2 = (int16_t)EXTRACT16(rs1, 2);
+    int16_t s1_h3 = (int16_t)EXTRACT16(rs1, 3);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int16_t s2_h2 = (int16_t)EXTRACT16(rs2, 2);
+    int16_t s2_h3 = (int16_t)EXTRACT16(rs2, 3);
+    int64_t prod0 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    int64_t prod2 = (int64_t)s1_h2 * (int64_t)s2_h2;
+    int64_t prod3 = (int64_t)s1_h3 * (int64_t)s2_h3;
+    rd = (uint64_t)(prod0 + prod1 + prod2 + prod3);
+    return rd;
+}
+
+/**
+ * PM4ADDSU.H - Add four products horizontally (signed x unsigned, RV64 only)
+ */
+uint64_t HELPER(pm4addsu_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s1_h2 = (int16_t)EXTRACT16(rs1, 2);
+    int16_t s1_h3 = (int16_t)EXTRACT16(rs1, 3);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint16_t s2_h2 = EXTRACT16(rs2, 2);
+    uint16_t s2_h3 = EXTRACT16(rs2, 3);
+    int64_t prod0 = (int64_t)s1_h0 * (uint64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (uint64_t)s2_h1;
+    int64_t prod2 = (int64_t)s1_h2 * (uint64_t)s2_h2;
+    int64_t prod3 = (int64_t)s1_h3 * (uint64_t)s2_h3;
+    rd = (uint64_t)(prod0 + prod1 + prod2 + prod3);
+    return rd;
+}
+
+/**
+ * PM4ADDU.H - Add four products horizontally (unsigned, RV64 only)
+ */
+uint64_t HELPER(pm4addu_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s1_h1 = EXTRACT16(rs1, 1);
+    uint16_t s1_h2 = EXTRACT16(rs1, 2);
+    uint16_t s1_h3 = EXTRACT16(rs1, 3);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint16_t s2_h2 = EXTRACT16(rs2, 2);
+    uint16_t s2_h3 = EXTRACT16(rs2, 3);
+    uint64_t prod0 = (uint64_t)s1_h0 * (uint64_t)s2_h0;
+    uint64_t prod1 = (uint64_t)s1_h1 * (uint64_t)s2_h1;
+    uint64_t prod2 = (uint64_t)s1_h2 * (uint64_t)s2_h2;
+    uint64_t prod3 = (uint64_t)s1_h3 * (uint64_t)s2_h3;
+    rd = prod0 + prod1 + prod2 + prod3;
+    return rd;
+}
+
+/**
+ * PM4ADDA.H - Add four products horizontally with accumulate (RV64 only)
+ */
+uint64_t HELPER(pm4adda_h)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s1_h2 = (int16_t)EXTRACT16(rs1, 2);
+    int16_t s1_h3 = (int16_t)EXTRACT16(rs1, 3);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int16_t s2_h2 = (int16_t)EXTRACT16(rs2, 2);
+    int16_t s2_h3 = (int16_t)EXTRACT16(rs2, 3);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_h0 * (int64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (int64_t)s2_h1;
+    int64_t prod2 = (int64_t)s1_h2 * (int64_t)s2_h2;
+    int64_t prod3 = (int64_t)s1_h3 * (int64_t)s2_h3;
+    return (uint64_t)(d + prod0 + prod1 + prod2 + prod3);
+}
+
+/**
+ * PM4ADDASU.H - Add four products horizontally with accumulate
+ * (signed x unsigned, RV64 only)
+ */
+uint64_t HELPER(pm4addasu_h)(CPURISCVState *env, uint64_t rs1,
+                             uint64_t rs2, uint64_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s1_h2 = (int16_t)EXTRACT16(rs1, 2);
+    int16_t s1_h3 = (int16_t)EXTRACT16(rs1, 3);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint16_t s2_h2 = EXTRACT16(rs2, 2);
+    uint16_t s2_h3 = EXTRACT16(rs2, 3);
+    int64_t d = (int64_t)dest;
+    int64_t prod0 = (int64_t)s1_h0 * (uint64_t)s2_h0;
+    int64_t prod1 = (int64_t)s1_h1 * (uint64_t)s2_h1;
+    int64_t prod2 = (int64_t)s1_h2 * (uint64_t)s2_h2;
+    int64_t prod3 = (int64_t)s1_h3 * (uint64_t)s2_h3;
+    return (uint64_t)(d + prod0 + prod1 + prod2 + prod3);
+}
+
+/**
+ * PM4ADDAU.H - Add four products horizontally with accumulate
+ * (unsigned, RV64 only)
+ */
+uint64_t HELPER(pm4addau_h)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s1_h1 = EXTRACT16(rs1, 1);
+    uint16_t s1_h2 = EXTRACT16(rs1, 2);
+    uint16_t s1_h3 = EXTRACT16(rs1, 3);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint16_t s2_h2 = EXTRACT16(rs2, 2);
+    uint16_t s2_h3 = EXTRACT16(rs2, 3);
+    uint64_t d = dest;
+    uint64_t prod0 = (uint64_t)s1_h0 * (uint64_t)s2_h0;
+    uint64_t prod1 = (uint64_t)s1_h1 * (uint64_t)s2_h1;
+    uint64_t prod2 = (uint64_t)s1_h2 * (uint64_t)s2_h2;
+    uint64_t prod3 = (uint64_t)s1_h3 * (uint64_t)s2_h3;
+    return d + prod0 + prod1 + prod2 + prod3;
+}
-- 
2.34.1


