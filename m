Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B3C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkg-0005fq-24; Wed, 16 Sep 2026 03:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkZ-0005cW-DK; Wed, 16 Sep 2026 03:08:11 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkU-0008JG-HV; Wed, 16 Sep 2026 03:08:10 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S10;
 Wed, 16 Sep 2026 15:08:02 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 08/19] target/riscv: Add packed SIMD horizontal reduction
 instructions
Date: Wed, 16 Sep 2026 07:07:10 +0000
Message-Id: <20260916070721.3279229-9-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S10
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UZrW7KF1fuF45CF15urg_yoWrXF15pF
 s7GrW3JrWUJFyaqas3tr4Y9w13WwsYga15CwsaqFnYvay5JFWru34DKr12kF4UXF9rur1U
 Wa10yrZxAFWrX3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Implement packed horizontal reduction-sum operations.  Cover signed and
unsigned variants for byte, halfword, and word elements. These instructions
sum all packed elements in rs1 and add the result to rs2.
Add the associated decode entries, translators and helpers.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  8 ++++++++
 target/riscv/insn32.decode                  |  8 ++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  8 ++++++++
 target/riscv/tcg/psimd_helper.c             | 15 +++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index cca3b88535d..824779f05d0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1511,3 +1511,11 @@ DEF_HELPER_3(psas_wx, i64, env, i64, i64)
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
index 3cfd8602c1c..3f8314d382b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1290,3 +1290,11 @@ psas_wx    1001001 ..... ..... 110 ..... 0111011 @r
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
index c991ac37e32..726707b2956 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -664,3 +664,11 @@ GEN_SIMD_TRANS_64_VXSAT(psas_wx)
 GEN_SIMD_TRANS_64_VXSAT(pssa_wx)
 GEN_SIMD_TRANS_64(paas_wx)
 GEN_SIMD_TRANS_64(pasa_wx)
+
+/* Packed SIMD - Horizontal Reduction Operations */
+GEN_SIMD_TRANS(predsum_bs)
+GEN_SIMD_TRANS(predsumu_bs)
+GEN_SIMD_TRANS(predsum_hs)
+GEN_SIMD_TRANS(predsumu_hs)
+GEN_SIMD_TRANS_64(predsum_ws)
+GEN_SIMD_TRANS_64(predsumu_ws)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 0cb81151d79..397efa66aeb 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2462,3 +2462,18 @@ GEN_PSIMD_XPAIR_AVG_BINOP(paas_wx, uint64_t, int32_t, int64_t,
 GEN_PSIMD_XPAIR_AVG_BINOP(pasa_wx, uint64_t, int32_t, int64_t,
                           EXTRACT32, INSERT32, ELEMS_W,
                           PSIMD_DO_ADD, PSIMD_DO_SUB)
+
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
-- 
2.34.1


