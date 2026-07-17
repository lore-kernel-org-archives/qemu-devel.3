Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C13C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfb9-0002qo-Dd; Fri, 17 Jul 2026 06:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfb8-0002ov-1w; Fri, 17 Jul 2026 06:15:14 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfb4-0007Zr-7O; Fri, 17 Jul 2026 06:15:13 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S14;
 Fri, 17 Jul 2026 18:07:26 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/18] target/riscv: Add packed SIMD Q-format
 multiplication instructions
Date: Fri, 17 Jul 2026 10:07:05 +0000
Message-Id: <3dc78ada29626595765f4851210b8002ab5cb638.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S14
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4Dury7KFW5ur43JFWUArb_yoWrGrWDpF
 4kG3y3G3yxXrWfJas3tr4Yyr43Ww4Fgw4Duws3tF1rZay5XFZxXrnFqw12kFsrXF9rXr1Y
 9a1jyr98AFW8t3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 target/riscv/helper.h                       |  8 ++++++++
 target/riscv/insn32.decode                  | 12 ++++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  8 ++++++++
 target/riscv/tcg/psimd_helper.c             | 17 +++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 48604d91a79..638c7b0629d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1680,3 +1680,11 @@ DEF_HELPER_4(maccsu_w11, i64, env, i64, i64, i64)
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
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a9b407e43e2..9c50a4dbf52 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1522,3 +1522,15 @@ maccsu_w11      11111 11 ..... ..... 011 ..... 0111011 @r
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 5a30c49016f..3535f71de88 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -826,3 +826,11 @@ GEN_SIMD_TRANS_ACC_64(maccu_w00)
 GEN_SIMD_TRANS_ACC_64(maccu_w01)
 GEN_SIMD_TRANS_ACC_64(maccu_w11)
 
+/* Packed SIMD - Q-Format Multiplication Operations */
+GEN_SIMD_TRANS_VXSAT(pmulq_h)
+GEN_SIMD_TRANS_VXSAT(pmulqr_h)
+GEN_SIMD_TRANS_64_VXSAT(pmulq_w)
+GEN_SIMD_TRANS_64_VXSAT(pmulqr_w)
+GEN_SIMD_TRANS_32_VXSAT(mulq)
+GEN_SIMD_TRANS_32_VXSAT(mulqr)
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 91a3aac3ebb..11ca17576be 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2638,3 +2638,20 @@ GEN_PSIMD_MUL_ACC_INDEXED(maccu_w11, uint64_t, uint32_t, uint32_t,
                           EXTRACT64, INSERT64, ELEMS_D, 0, 1, 1,
                           PSIMD_MUL_U64)
 
+/* Q-Format Multiplication Operations */
+
+GEN_PSIMD_QMUL(pmulq_h, target_ulong, int16_t, int32_t, uint16_t,
+               EXTRACT16, INSERT16, ELEMS_H, 15, 0, INT16_MIN, INT16_MAX)
+GEN_PSIMD_QMUL(pmulqr_h, target_ulong, int16_t, int32_t, uint16_t,
+               EXTRACT16, INSERT16, ELEMS_H, 15, 1 << 14, INT16_MIN,
+               INT16_MAX)
+GEN_PSIMD_QMUL(pmulq_w, uint64_t, int32_t, int64_t, uint32_t,
+               EXTRACT32, INSERT32, ELEMS_W, 31, 0, INT32_MIN, INT32_MAX)
+GEN_PSIMD_QMUL(pmulqr_w, uint64_t, int32_t, int64_t, uint32_t,
+               EXTRACT32, INSERT32, ELEMS_W, 31, 1LL << 30, INT32_MIN,
+               INT32_MAX)
+GEN_PSIMD_QMUL(mulq, uint32_t, int32_t, int64_t, uint32_t,
+               EXTRACT32, INSERT32, ELEMS_W, 31, 0, INT32_MIN, INT32_MAX)
+GEN_PSIMD_QMUL(mulqr, uint32_t, int32_t, int64_t, uint32_t,
+               EXTRACT32, INSERT32, ELEMS_W, 31, 1LL << 30, INT32_MIN,
+               INT32_MAX)
-- 
2.34.1


