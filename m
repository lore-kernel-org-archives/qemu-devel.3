Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D7C44517
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfTs-0003f4-Pw; Fri, 17 Jul 2026 06:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTm-0003aM-HM; Fri, 17 Jul 2026 06:07:38 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTg-0006ad-VG; Fri, 17 Jul 2026 06:07:38 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S10;
 Fri, 17 Jul 2026 18:07:25 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/18] target/riscv: Add packed SIMD horizontal reduction
 instructions
Date: Fri, 17 Jul 2026 10:07:01 +0000
Message-Id: <ccd16153de572b5980cd19949160d87ab26fef9b.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4DurykJrW8Ar15ZF1kZrb_yoW5Kry7pF
 s7GrW3JrWUXFyaqas3Kr4Y93W3XwsYga15CwsaqFnYvay5JFW5W34DKr12kF4UXF9ruF15
 Wa10yrZrAFWrX3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j
 6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
 8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
 JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
 WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
 cSsGvfC2KfnxnUUI43ZEXa7VUbNVy3UUUUU==
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
 target/riscv/insn32.decode                  |  8 ++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  8 ++++++++
 target/riscv/tcg/psimd_helper.c             | 15 +++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d0b13cf3c6a..5fe650c5d71 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1512,3 +1512,11 @@ DEF_HELPER_3(psas_wx, i64, env, i64, i64)
 DEF_HELPER_3(pssa_wx, i64, env, i64, i64)
 DEF_HELPER_3(paas_wx, i64, env, i64, i64)
 DEF_HELPER_3(pasa_wx, i64, env, i64, i64)
+
+/* Packed SIMD - Horizontal Reduction Operations */
+DEF_HELPER_3(predsum_bs, tl, env, tl, tl)
+DEF_HELPER_3(predsumu_bs, tl, env, tl, tl)
+DEF_HELPER_3(predsum_hs, tl, env, tl, tl)
+DEF_HELPER_3(predsumu_hs, tl, env, tl, tl)
+DEF_HELPER_3(predsum_ws, i64, env, i64, i64)
+DEF_HELPER_3(predsumu_ws, i64, env, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e331ba6a38c..9d0f5c48b6d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1288,3 +1288,11 @@ psas_wx    1001001 ..... ..... 110 ..... 0111011 @r
 pssa_wx    1001011 ..... ..... 110 ..... 0111011 @r
 paas_wx    1001101 ..... ..... 110 ..... 0111011 @r
 pasa_wx    1001111 ..... ..... 110 ..... 0111011 @r
+
+# Packed SIMD - Horizontal Reduction Operations
+predsum_bs   1001110 ..... ..... 100 ..... 0011011 @r
+predsumu_bs  1011110 ..... ..... 100 ..... 0011011 @r
+predsum_hs   1001100 ..... ..... 100 ..... 0011011 @r
+predsumu_hs  1011100 ..... ..... 100 ..... 0011011 @r
+predsum_ws   1001101 ..... ..... 100 ..... 0011011 @r
+predsumu_ws  1011101 ..... ..... 100 ..... 0011011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 61e1fb8d816..9f2ae9da1d1 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -658,3 +658,11 @@ GEN_SIMD_TRANS_64_VXSAT(pssa_wx)
 GEN_SIMD_TRANS_64(paas_wx)
 GEN_SIMD_TRANS_64(pasa_wx)
 
+/* Packed SIMD - Horizontal Reduction Operations */
+GEN_SIMD_TRANS(predsum_bs)
+GEN_SIMD_TRANS(predsumu_bs)
+GEN_SIMD_TRANS(predsum_hs)
+GEN_SIMD_TRANS(predsumu_hs)
+GEN_SIMD_TRANS_64(predsum_ws)
+GEN_SIMD_TRANS_64(predsumu_ws)
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index ccc43b2dda0..0acf0414bf9 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2096,3 +2096,18 @@ GEN_PSIMD_XPAIR_AVG_BINOP(pasa_wx, uint64_t, int32_t, int64_t,
                           EXTRACT32, INSERT32, ELEMS_W,
                           PSIMD_DO_ADD, PSIMD_DO_SUB)
 
+/* Horizontal sum operations */
+
+GEN_PSIMD_REDSUM(predsum_bs, target_ulong, int64_t, int8_t,
+                 EXTRACT8, ELEMS_B, (int64_t)(int32_t)rs2)
+GEN_PSIMD_REDSUM(predsumu_bs, target_ulong, uint64_t, uint8_t,
+                 EXTRACT8, ELEMS_B, rs2)
+GEN_PSIMD_REDSUM(predsum_hs, target_ulong, int64_t, int16_t,
+                 EXTRACT16, ELEMS_H, (int64_t)(int32_t)rs2)
+GEN_PSIMD_REDSUM(predsumu_hs, target_ulong, uint64_t, uint16_t,
+                 EXTRACT16, ELEMS_H, rs2)
+GEN_PSIMD_REDSUM(predsum_ws, uint64_t, int64_t, int32_t,
+                 EXTRACT32, ELEMS_W, (int64_t)rs2)
+GEN_PSIMD_REDSUM(predsumu_ws, uint64_t, uint64_t, uint32_t,
+                 EXTRACT32, ELEMS_W, rs2)
+
-- 
2.34.1


