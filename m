Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9746EC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfU3-0003la-Bi; Fri, 17 Jul 2026 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfU2-0003kN-05; Fri, 17 Jul 2026 06:07:54 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTy-0006b5-Sy; Fri, 17 Jul 2026 06:07:53 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S17;
 Fri, 17 Jul 2026 18:07:27 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/18] target/riscv: Add packed SIMD four-way MAC
 instructions
Date: Fri, 17 Jul 2026 10:07:08 +0000
Message-Id: <18ecb088882c334bf44fb006f866d7f05edf5e50.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S17
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrZw1UCFWUGF1fZrWfuFg_yoW7try5pa
 18Gry3WFW8GryfZF93tr43Ja13Xr4a9w18ur4fJF1UZFW5JFykWw1jqr12yFsxWFyDuF1j
 gayvkryDAaykXwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 target/riscv/helper.h                       | 14 +++++++
 target/riscv/insn32.decode                  | 14 +++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 14 +++++++
 target/riscv/tcg/psimd_helper.c             | 41 +++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b0743d19177..fb95a9f71b5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1742,3 +1742,17 @@ DEF_HELPER_4(pm2addau_w, i64, env, i64, i64, i64)
 DEF_HELPER_4(pm2adda_wx, i64, env, i64, i64, i64)
 DEF_HELPER_4(pm2suba_w, i64, env, i64, i64, i64)
 DEF_HELPER_4(pm2suba_wx, i64, env, i64, i64, i64)
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
index 1c8bdde25c2..8720fedb592 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1600,3 +1600,17 @@ pm2addau_w      10101 01 ..... ..... 101 ..... 0111011 @r
 pm2adda_wx      10011 01 ..... ..... 101 ..... 0111011 @r
 pm2suba_w       11001 01 ..... ..... 101 ..... 0111011 @r
 pm2suba_wx      11011 01 ..... ..... 101 ..... 0111011 @r
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index cf670b144c3..6c344a66dc8 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -888,3 +888,17 @@ GEN_SIMD_TRANS_ACC_64(pm2adda_wx)
 GEN_SIMD_TRANS_ACC_64(pm2suba_w)
 GEN_SIMD_TRANS_ACC_64(pm2suba_wx)
 
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
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index bad04937b54..e7c7e554938 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2849,3 +2849,44 @@ GEN_PSIMD_2WAY_MUL_ACC(pm2suba_wx, uint64_t, int32_t, int32_t,
                        int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
                        INSERT64, ELEMS_D, 0, 0, 1, 1, 0, PSIMD_MUL_S64,
                        PSIMD_COMB_SUB)
+
+
+/* Four-Way Multiply and Accumulate Operations */
+
+GEN_PSIMD_4WAY_MUL(pm4add_b, target_ulong, int8_t, int8_t,
+                   int32_t, uint32_t, EXTRACT8, INSERT32, ELEMS_W, 4,
+                   PSIMD_MUL_S32)
+GEN_PSIMD_4WAY_MUL(pm4addsu_b, target_ulong, int8_t, uint8_t,
+                   int32_t, uint32_t, EXTRACT8, INSERT32, ELEMS_W, 4,
+                   PSIMD_MUL_SU32)
+GEN_PSIMD_4WAY_MUL(pm4addu_b, target_ulong, uint8_t, uint8_t,
+                   uint32_t, uint32_t, EXTRACT8, INSERT32, ELEMS_W, 4,
+                   PSIMD_MUL_U32)
+GEN_PSIMD_4WAY_MUL_ACC(pm4adda_b, target_ulong, int8_t, int8_t,
+                       int32_t, int32_t, uint32_t, EXTRACT8, EXTRACT32,
+                       INSERT32, ELEMS_W, 4, PSIMD_MUL_S32)
+GEN_PSIMD_4WAY_MUL_ACC(pm4addasu_b, target_ulong, int8_t, uint8_t,
+                       int32_t, int32_t, uint32_t, EXTRACT8, EXTRACT32,
+                       INSERT32, ELEMS_W, 4, PSIMD_MUL_SU32)
+GEN_PSIMD_4WAY_MUL_ACC(pm4addau_b, target_ulong, uint8_t, uint8_t,
+                       uint32_t, uint32_t, uint32_t, EXTRACT8, EXTRACT32,
+                       INSERT32, ELEMS_W, 4, PSIMD_MUL_U32)
+
+GEN_PSIMD_4WAY_MUL(pm4add_h, uint64_t, int16_t, int16_t,
+                   int64_t, uint64_t, EXTRACT16, INSERT64, ELEMS_D, 0,
+                   PSIMD_MUL_S64)
+GEN_PSIMD_4WAY_MUL(pm4addsu_h, uint64_t, int16_t, uint16_t,
+                   int64_t, uint64_t, EXTRACT16, INSERT64, ELEMS_D, 0,
+                   PSIMD_MUL_SU64)
+GEN_PSIMD_4WAY_MUL(pm4addu_h, uint64_t, uint16_t, uint16_t,
+                   uint64_t, uint64_t, EXTRACT16, INSERT64, ELEMS_D, 0,
+                   PSIMD_MUL_U64)
+GEN_PSIMD_4WAY_MUL_ACC(pm4adda_h, uint64_t, int16_t, int16_t,
+                       int64_t, int64_t, uint64_t, EXTRACT16, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, PSIMD_MUL_S64)
+GEN_PSIMD_4WAY_MUL_ACC(pm4addasu_h, uint64_t, int16_t, uint16_t,
+                       int64_t, int64_t, uint64_t, EXTRACT16, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, PSIMD_MUL_SU64)
+GEN_PSIMD_4WAY_MUL_ACC(pm4addau_h, uint64_t, uint16_t, uint16_t,
+                       uint64_t, uint64_t, uint64_t, EXTRACT16, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, PSIMD_MUL_U64)
-- 
2.34.1


