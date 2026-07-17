Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58291C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfU3-0003nF-T4; Fri, 17 Jul 2026 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfU2-0003kR-1P; Fri, 17 Jul 2026 06:07:54 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTy-0006av-IN; Fri, 17 Jul 2026 06:07:53 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S15;
 Fri, 17 Jul 2026 18:07:26 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/18] target/riscv: Add packed SIMD Q-format MAC
 instructions
Date: Fri, 17 Jul 2026 10:07:06 +0000
Message-Id: <1630945f33187a0b92bf356350fd676d72f6eb64.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S15
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW5KryxAr17tw15XFyxZrb_yoWfJF17pa
 97GrW7WrWIgr13tFyvgr45Cw4DWr4akw1DCr13JF15AFZ5XFn8Gryjqw17uanrWFZrXF1Y
 9ayIyrWq9ayIqwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 target/riscv/helper.h                       | 20 ++++++
 target/riscv/insn32.decode                  | 32 +++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 20 ++++++
 target/riscv/tcg/psimd_helper.c             | 78 +++++++++++++++++++++
 4 files changed, 150 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 638c7b0629d..9568a7f91c4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1688,3 +1688,23 @@ DEF_HELPER_3(pmulq_w, i64, env, i64, i64)
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
index 9c50a4dbf52..e2af5f83965 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1534,3 +1534,35 @@ pmulqr_h    11010 10 ..... ..... 111 ..... 0111011 @r
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
index 3535f71de88..cec18255a1e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -834,3 +834,23 @@ GEN_SIMD_TRANS_64_VXSAT(pmulqr_w)
 GEN_SIMD_TRANS_32_VXSAT(mulq)
 GEN_SIMD_TRANS_32_VXSAT(mulqr)
 
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
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 11ca17576be..ecdb20bbb58 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2655,3 +2655,81 @@ GEN_PSIMD_QMUL(mulq, uint32_t, int32_t, int64_t, uint32_t,
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
2.34.1


