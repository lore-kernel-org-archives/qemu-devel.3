Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C55FC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfU1-0003kK-Ux; Fri, 17 Jul 2026 06:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfU0-0003j3-Ap; Fri, 17 Jul 2026 06:07:52 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wkfTy-0006ac-3i; Fri, 17 Jul 2026 06:07:52 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3T_Pa_llqSAw4AA--.34459S9;
 Fri, 17 Jul 2026 18:07:25 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/18] target/riscv: Add packed SIMD exchange instructions
Date: Fri, 17 Jul 2026 10:07:00 +0000
Message-Id: <3015b4f4966b22a962ce89ec8b19a0393df38e6e.1784280142.git.xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3T_Pa_llqSAw4AA--.34459S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrZw1ktFWkAFyxuw4kZwb_yoW7WF4rpa
 97KFy3WayUKryft3WSkr45tw13Ga1fKa18urs3KFs5ZanrJFW3XryUtr12kF47XF9rXr1U
 WayFyr98AFWkX3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 target/riscv/helper.h                       | 14 +++++++
 target/riscv/insn32.decode                  | 14 +++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 14 +++++++
 target/riscv/tcg/psimd_helper.c             | 44 +++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d72323890f6..d0b13cf3c6a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1498,3 +1498,17 @@ DEF_HELPER_3(sshl, i32, env, i32, i32)
 DEF_HELPER_3(sshlr, i32, env, i32, i32)
 DEF_HELPER_3(shl, i64, env, i64, i64)
 DEF_HELPER_3(shlr, i64, env, i64, i64)
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
index fb029bb512f..e331ba6a38c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1274,3 +1274,17 @@ psshlr_hs  1011100 ..... ..... 010 ..... 0011011 @r
 }
 shl        1010111 ..... ..... 010 ..... 0011011 @r
 shlr       1011111 ..... ..... 010 ..... 0011011 @r
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
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index fb82760a60c..61e1fb8d816 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -644,3 +644,17 @@ GEN_SIMD_TRANS_32_VXSAT(sshlr)
 GEN_SIMD_TRANS_64(shl)
 GEN_SIMD_TRANS_64(shlr)
 
+/* Packed SIMD - Exchange Operations */
+GEN_SIMD_TRANS(pas_hx)
+GEN_SIMD_TRANS(psa_hx)
+GEN_SIMD_TRANS_VXSAT(psas_hx)
+GEN_SIMD_TRANS_VXSAT(pssa_hx)
+GEN_SIMD_TRANS(paas_hx)
+GEN_SIMD_TRANS(pasa_hx)
+GEN_SIMD_TRANS_64(pas_wx)
+GEN_SIMD_TRANS_64(psa_wx)
+GEN_SIMD_TRANS_64_VXSAT(psas_wx)
+GEN_SIMD_TRANS_64_VXSAT(pssa_wx)
+GEN_SIMD_TRANS_64(paas_wx)
+GEN_SIMD_TRANS_64(pasa_wx)
+
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 8b106a336f5..ccc43b2dda0 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2052,3 +2052,47 @@ GEN_PSIMD_VAR_USHLR(sshlr, uint32_t, uint32_t, uint64_t,
 GEN_PSIMD_VAR_SRL64(shl, PSIMD_DO_SRL64)
 GEN_PSIMD_VAR_SRL64(shlr, PSIMD_DO_RNDSRL64)
 
+/* Exchange operations (AS/SA/AS/SA with X suffix) */
+
+GEN_PSIMD_XPAIR_BINOP(pas_hx, target_ulong, int16_t,
+                      EXTRACT16, INSERT16, ELEMS_H,
+                      PSIMD_DO_SUB, PSIMD_DO_ADD)
+GEN_PSIMD_XPAIR_BINOP(psa_hx, target_ulong, int16_t,
+                      EXTRACT16, INSERT16, ELEMS_H,
+                      PSIMD_DO_ADD, PSIMD_DO_SUB)
+
+GEN_PSIMD_XPAIR_SAT_BINOP(psas_hx, target_ulong, int16_t, int32_t,
+                          EXTRACT16, INSERT16, ELEMS_H,
+                          PSIMD_DO_SUB, PSIMD_DO_ADD, signed_saturate_h)
+GEN_PSIMD_XPAIR_SAT_BINOP(pssa_hx, target_ulong, int16_t, int32_t,
+                          EXTRACT16, INSERT16, ELEMS_H,
+                          PSIMD_DO_ADD, PSIMD_DO_SUB, signed_saturate_h)
+
+GEN_PSIMD_XPAIR_AVG_BINOP(paas_hx, target_ulong, int16_t, int32_t,
+                          EXTRACT16, INSERT16, ELEMS_H,
+                          PSIMD_DO_SUB, PSIMD_DO_ADD)
+GEN_PSIMD_XPAIR_AVG_BINOP(pasa_hx, target_ulong, int16_t, int32_t,
+                          EXTRACT16, INSERT16, ELEMS_H,
+                          PSIMD_DO_ADD, PSIMD_DO_SUB)
+
+GEN_PSIMD_XPAIR_BINOP(pas_wx, uint64_t, int32_t,
+                      EXTRACT32, INSERT32, ELEMS_W,
+                      PSIMD_DO_SUB, PSIMD_DO_ADD)
+GEN_PSIMD_XPAIR_BINOP(psa_wx, uint64_t, int32_t,
+                      EXTRACT32, INSERT32, ELEMS_W,
+                      PSIMD_DO_ADD, PSIMD_DO_SUB)
+
+GEN_PSIMD_XPAIR_SAT_BINOP(psas_wx, uint64_t, int32_t, int64_t,
+                          EXTRACT32, INSERT32, ELEMS_W,
+                          PSIMD_DO_SUB, PSIMD_DO_ADD, signed_saturate_w)
+GEN_PSIMD_XPAIR_SAT_BINOP(pssa_wx, uint64_t, int32_t, int64_t,
+                          EXTRACT32, INSERT32, ELEMS_W,
+                          PSIMD_DO_ADD, PSIMD_DO_SUB, signed_saturate_w)
+
+GEN_PSIMD_XPAIR_AVG_BINOP(paas_wx, uint64_t, int32_t, int64_t,
+                          EXTRACT32, INSERT32, ELEMS_W,
+                          PSIMD_DO_SUB, PSIMD_DO_ADD)
+GEN_PSIMD_XPAIR_AVG_BINOP(pasa_wx, uint64_t, int32_t, int64_t,
+                          EXTRACT32, INSERT32, ELEMS_W,
+                          PSIMD_DO_ADD, PSIMD_DO_SUB)
+
-- 
2.34.1


