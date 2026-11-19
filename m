Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AB606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpT-0007J2-8S; Thu, 19 Nov 2026 02:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoq-0006xZ-Uy; Thu, 19 Nov 2026 02:44:34 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoo-0001jX-3K; Thu, 19 Nov 2026 02:44:32 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S15;
 Thu, 19 Nov 2026 15:44:05 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 13/20] target/riscv: Add packed SIMD Q-format MAC
 instructions
Date: Thu, 19 Nov 2026 07:43:33 +0000
Message-ID: <20261119074345.866125-14-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S15
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4DZw4xuw1rKrWrZw1rXrb_yoWfCw4rpF
 Z7GrW7WrWIgr13tFyvgr45Cw4DWr4akw4DCr13JF15AFZ5XFn8Gryjqw17ua17WFZrXF1Y
 9ayIyrWq9aySqwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
 8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7
 JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 YxBIdaVFxhVjvjDU0xZFpf9x0JUHE__UUUUU=
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.993,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement Q-format multiply-accumulate operations.  Cover packed and
scalar forms, halfword and word source-element selections, and rounded
and non-rounded variants. Add the associated decode entries, translators
and helpers.

These instructions multiply selected signed source elements, discard
the low fractional bits to produce a Q-format result in the wider
destination element width, and add it to the corresponding element of
rd.  Rounded variants add the required rounding value before extracting
the product.  Accumulation wraps to the destination element width, and
these operations do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       | 20 ++++++
 target/riscv/insn32.decode                  | 32 +++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 20 ++++++
 target/riscv/tcg/psimd_helper.c             | 78 +++++++++++++++++++++
 4 files changed, 150 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a3cbc3736d..6a41d0a9bf 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1724,3 +1724,23 @@ DEF_HELPER_3(pmulq_w, i64, env, i64, i64)
 DEF_HELPER_3(pmulqr_w, i64, env, i64, i64)
 DEF_HELPER_3(mulq, i32, env, i32, i32)
 DEF_HELPER_3(mulqr, i32, env, i32, i32)
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
index b42ae50dd2..62a1b7b21b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1546,3 +1546,35 @@ pmulqr_h    11010 10 ..... ..... 111 ..... 0111011 @r
   mulqr     11010 11 ..... ..... 111 ..... 0111011 @r
   pmulqr_w  11010 11 ..... ..... 111 ..... 0111011 @r
 }
+
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 5eff803188..ef3c5b00a3 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -854,3 +854,23 @@ GEN_SIMD_TRANS_64_VXSAT(pmulq_w)
 GEN_SIMD_TRANS_64_VXSAT(pmulqr_w)
 GEN_SIMD_TRANS_32_VXSAT(mulq)
 GEN_SIMD_TRANS_32_VXSAT(mulqr)
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
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index e29f4438a0..6df8b65ca5 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3018,3 +3018,81 @@ GEN_PSIMD_QMUL(mulq, uint32_t, int32_t, int64_t, uint32_t,
 GEN_PSIMD_QMUL(mulqr, uint32_t, int32_t, int64_t, uint32_t,
                EXTRACT32, INSERT32, ELEMS_W, 31, 1LL << 30, INT32_MIN,
                INT32_MAX)
+
+
+/* Q-Format Multiply-Accumulate Operations */
+
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_h00, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 0, 0, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_h01, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 0, 1, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_h11, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 1, 1, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_h00, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 0, 0, 15,
+                           1LL << 14, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_h01, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 0, 1, 15,
+                           1LL << 14, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_h11, uint32_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 0, 1, 1, 15,
+                           1LL << 14, PSIMD_MUL_S64)
+
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_w00, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 0, 0, 31, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_w01, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 0, 1, 31, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqacc_w11, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 1, 1, 31, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_w00, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 0, 0, 31,
+                           1LL << 30, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_w01, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 0, 1, 31,
+                           1LL << 30, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(mqracc_w11, uint64_t, int32_t, int32_t,
+                           int64_t, int64_t, int64_t, uint64_t, EXTRACT32,
+                           EXTRACT64, INSERT64, ELEMS_D, 0, 1, 1, 31,
+                           1LL << 30, PSIMD_MUL_S64)
+
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqacc_w_h00, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 0, 0, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqacc_w_h01, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 0, 1, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqacc_w_h11, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 1, 1, 15, 0,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqracc_w_h00, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 0, 0, 15,
+                           1LL << 14, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqracc_w_h01, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 0, 1, 15,
+                           1LL << 14, PSIMD_MUL_S64)
+GEN_PSIMD_QMUL_ACC_INDEXED(pmqracc_w_h11, uint64_t, int16_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
+                           EXTRACT32, INSERT32, ELEMS_W, 2, 1, 1, 15,
+                           1LL << 14, PSIMD_MUL_S64)
-- 
2.53.0


