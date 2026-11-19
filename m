Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAA606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpM-00076r-2G; Thu, 19 Nov 2026 02:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoX-0006v2-E5; Thu, 19 Nov 2026 02:44:15 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoS-0001j1-Ls; Thu, 19 Nov 2026 02:44:12 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S9;
 Thu, 19 Nov 2026 15:44:03 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 07/20] target/riscv: Add packed SIMD exchange instructions
Date: Thu, 19 Nov 2026 07:43:27 +0000
Message-ID: <20261119074345.866125-8-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr43tFWfWryfWry5tF47Arb_yoW7uw4kpa
 97GFWagayUKryft3WSkr45tw13Ww4fKa1kursxKFsYva1DJF43XryUtr1akF47ZF9rXr1U
 Way0yr98AaykX3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement packed add-subtract cross operations.  Cover normal,
saturating, and averaging variants for halfword and word elements.
Add the associated decode entries, translators and helpers.

These instructions perform addition and subtraction using crossed
source elements within each packed element pair.  Note that saturating
variants clamp results to the signed element range and set vxsat when
saturation occurs, while averaging variants shift the intermediate
results right by one bit and do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       | 14 +++++++
 target/riscv/insn32.decode                  | 14 +++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 14 +++++++
 target/riscv/tcg/psimd_helper.c             | 44 +++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 198e2792c0..eded651d2b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1536,3 +1536,17 @@ DEF_HELPER_3(sshl, i32, env, i32, i32)
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
index 30ee8319ea..5c3b6195b9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1287,3 +1287,17 @@ psshlr_hs  1011100 ..... ..... 010 ..... 0011011 @r
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
index 32b5de9f1b..c991ac37e3 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -650,3 +650,17 @@ GEN_SIMD_TRANS_32_VXSAT(sshl)
 GEN_SIMD_TRANS_32_VXSAT(sshlr)
 GEN_SIMD_TRANS_64(shl)
 GEN_SIMD_TRANS_64(shlr)
+
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
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 87359db208..5537a44dff 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2413,3 +2413,47 @@ GEN_PSIMD_VAR_USHLR(sshlr, uint32_t, uint32_t, uint64_t,
 
 GEN_PSIMD_VAR_SRL64(shl, PSIMD_DO_SRL64)
 GEN_PSIMD_VAR_SRL64(shlr, PSIMD_DO_RNDSRL64)
+
+/* Cross add/subtract operations */
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
-- 
2.53.0


