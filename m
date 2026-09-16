Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jlD-0006ER-1L; Wed, 16 Sep 2026 03:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkt-0005px-Fs; Wed, 16 Sep 2026 03:08:33 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkp-0008Jf-O3; Wed, 16 Sep 2026 03:08:31 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S15;
 Wed, 16 Sep 2026 15:08:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] target/riscv: Add packed SIMD Q-format MAC
 instructions
Date: Wed, 16 Sep 2026 07:07:15 +0000
Message-Id: <20260916070721.3279229-14-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S15
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4DZw4xuw1rKrWrZw1rXrb_yoWfZr18pF
 Z7GrW7WrWIgr43tFyvgr45Cw4DWr4Skw4DCr13JF15AFZ5XFn8Gryjqw17ua17WFZrXF1Y
 9ayIyrWq9aySqwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
 67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULSdkUUUUU=
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

Implement Q-format multiply-accumulate operations.  Cover packed and
scalar forms, halfword and word source-element selections, and rounded
and non-rounded variants.Add the associated decode entries, translators
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
index 40cb4f3825e..7a052991ad1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1685,3 +1685,23 @@ DEF_HELPER_3(pmulq_w, i64, env, i64, i64)
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
index 6f9c40f2db7..3d9e79de58f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1535,3 +1535,35 @@ pmulqr_h    11010 10 ..... ..... 111 ..... 0111011 @r
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
index 5eff8031885..ef3c5b00a3a 100644
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
index 52df992b462..feb93561e60 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3023,3 +3023,81 @@ GEN_PSIMD_QMUL(mulq, uint32_t, int32_t, int64_t, uint32_t,
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


