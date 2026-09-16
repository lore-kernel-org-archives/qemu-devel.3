Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5EBC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jlA-0006AS-II; Wed, 16 Sep 2026 03:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkv-0005w4-Hi; Wed, 16 Sep 2026 03:08:36 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkq-0008Jt-Eh; Wed, 16 Sep 2026 03:08:32 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S17;
 Wed, 16 Sep 2026 15:08:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 15/19] target/riscv: Add packed SIMD four-way multiply-add
 instructions
Date: Wed, 16 Sep 2026 07:07:17 +0000
Message-Id: <20260916070721.3279229-16-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S17
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW5Cw1fCw17JrWxJFWfGrg_yoWxWrWrpa
 18Gry3WFWxGFyfXas3tr43Jw43Xrsa9w18WF4fJF1UZFW5JFykWw1jqr12yF43XFyDuF1U
 Wa4vkryDAaykJwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Implement PM4 horizontal multiply-add operations.  Cover byte and
halfword source elements, signed, unsigned, and mixed-sign products, and
accumulating and non-accumulating variants. Add the associated
decode entries, translators and helpers.

These instructions multiply four corresponding packed element pairs and
sum the four full products into a wider destination element.
Accumulating variants add the combined result to the corresponding
element of rd.  Accumulation wraps to the destination element width,
and these operations do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       | 14 +++++++
 target/riscv/insn32.decode                  | 14 +++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 14 +++++++
 target/riscv/tcg/psimd_helper.c             | 41 +++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5e33026bcb0..9a75a13d06d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1741,3 +1741,17 @@ DEF_HELPER_4(pm2addau_w, i64, env, i64, i64, i64)
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
index 263e02ef903..f9c3adc5ffc 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1603,3 +1603,17 @@ pm2addau_w      10101 01 ..... ..... 101 ..... 0111011 @r
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
index 65647fd61eb..eba377fac6b 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -910,3 +910,17 @@ GEN_SIMD_TRANS_ACC_64(pm2addau_w)
 GEN_SIMD_TRANS_ACC_64(pm2adda_wx)
 GEN_SIMD_TRANS_ACC_64(pm2suba_w)
 GEN_SIMD_TRANS_ACC_64(pm2suba_wx)
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
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 639557351da..94eb68776aa 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3220,3 +3220,44 @@ GEN_PSIMD_2WAY_MUL_ACC(pm2suba_wx, uint64_t, int32_t, int32_t,
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


