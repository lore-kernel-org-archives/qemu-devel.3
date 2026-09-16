Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1689C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkm-0005oM-0N; Wed, 16 Sep 2026 03:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jka-0005dL-Ox; Wed, 16 Sep 2026 03:08:13 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkU-0008JI-TU; Wed, 16 Sep 2026 03:08:12 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S9;
 Wed, 16 Sep 2026 15:08:02 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 07/19] target/riscv: Add packed SIMD exchange instructions
Date: Wed, 16 Sep 2026 07:07:09 +0000
Message-Id: <20260916070721.3279229-8-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr43tFWfWryfWry5tF47Arb_yoW7tr1fpa
 97GFy3WayUKry3t3WSkr45tw13Gw4fKa1kursxKFsYva1DJF43XryUtr12kF47ZF9rXr1U
 Way0yr98AaykX3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8V
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
index 53107334e1f..cca3b88535d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1497,3 +1497,17 @@ DEF_HELPER_3(sshl, i32, env, i32, i32)
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
index 82434b10410..3cfd8602c1c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1276,3 +1276,17 @@ psshlr_hs  1011100 ..... ..... 010 ..... 0011011 @r
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
index 32b5de9f1b6..c991ac37e32 100644
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
index cd110aa1cdc..0cb81151d79 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2418,3 +2418,47 @@ GEN_PSIMD_VAR_USHLR(sshlr, uint32_t, uint32_t, uint64_t,
 
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
2.34.1


