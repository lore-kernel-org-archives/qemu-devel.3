Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DC606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpR-0007Fk-DQ; Thu, 19 Nov 2026 02:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwou-0006yQ-Pa; Thu, 19 Nov 2026 02:44:42 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwos-0001kw-B2; Thu, 19 Nov 2026 02:44:36 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S22;
 Thu, 19 Nov 2026 15:44:09 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 20/20] target/riscv: align rounded logical right shifts
 with P extension v0.6
Date: Thu, 19 Nov 2026 07:43:40 +0000
Message-ID: <20261119074345.866125-21-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S22
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1Dtw1UGrWktF1UWFW8Xrb_yoWxZFyUpr
 43Gry5urZ5W3WIq3Zrtw1Yyw15twsIk3Z8C345Gr10vr47JrW3Xw15JrWIywsYqrn8Xry2
 9a1qvrWFkrW0kw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWD
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Align PSSHLR.HS/WS/DHS/DWS, SSHLR, and SHLR with the P extension v0.6
specification: return zero when the rounded logical right shift amount
exceeds the lane width.

Update the corresponding PSIMD TCG tests.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/insn32.decode      |  2 +-
 target/riscv/tcg/psimd_helper.c | 12 ++++++++----
 tests/tcg/riscv/psimd-common.S  | 14 ++++++++++++--
 tests/tcg/riscv/psimd-rv32.S    | 21 ++++++++++++++++++++-
 tests/tcg/riscv/psimd-rv64.S    | 13 +++++++++++--
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 5315896717..ce38f66459 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1137,7 +1137,7 @@ vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
 vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
 vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
 
-# *** P Experimental Extension Version v020 ***
+# *** P Experimental Extension Version v0.6 ***
 # Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating)
 padd_b     1000010 ..... ..... 000 ..... 0111011 @r
 padd_h     1000000 ..... ..... 000 ..... 0111011 @r
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index c6abd069b6..7057187c82 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -697,9 +697,13 @@ RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
                             ((WTYPE)e1 << shamt);                         \
             res = SAT_FN(shifted, &sat);                                  \
         } else {                                                          \
-            int right = MIN(-shamt, (BITS));                              \
-            WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;               \
-            res = (ETYPE)(rounded >> 1);                                  \
+            int right = -shamt;                                           \
+            if (right > (BITS)) {                                         \
+                res = 0;                                                  \
+            } else {                                                      \
+                WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;           \
+                res = (ETYPE)(rounded >> 1);                              \
+            }                                                             \
         }                                                                 \
                                                                           \
         rd = INSERT(rd, res, i);                                          \
@@ -738,7 +742,7 @@ uint64_t HELPER(NAME)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)     \
 
 #define PSIMD_DO_SRL64(A, B) (((B) >= 64) ? 0 : ((A) >> (B)))
 #define PSIMD_DO_RNDSRL64(A, B)                                          \
-    (uint64_t)((((__uint128_t)(A) >> (MIN((B), 64) - 1)) + 1) >> 1)
+    (uint64_t)((B) > 64 ? 0 : (((__uint128_t)(A) >> ((B) - 1)) + 1) >> 1)
 
 /*
  * Generate an unsigned 64-bit bidirectional-shift helper.  rs1 is the
diff --git a/tests/tcg/riscv/psimd-common.S b/tests/tcg/riscv/psimd-common.S
index 61c64305e8..07e14e7209 100644
--- a/tests/tcg/riscv/psimd-common.S
+++ b/tests/tcg/riscv/psimd-common.S
@@ -284,8 +284,13 @@
                           0xffff0001, 1, 0xffff0002
     TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
                                0x80030002, -1, 0x40020001, 0, 0
+    /* At lane width, round the top bit; beyond it, return zero. */
     TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
-                               0x80017fff, -17, 0x00010000, 0, 0
+                               0x80017fff, -16, 0x00010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x80017fff, -17, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               -1, -128, 0, 1, 1
 
     TEST_PSIMD_SAT_RR_SET 332, ssha, 1, 1, 2, \
                           0x40000000, 1, 0x7fffffff, \
@@ -878,9 +883,14 @@
     TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
                                0x8003000200030002, -1, \
                                0x4002000100020001, 0, 0
+    /* At lane width, round the top bit; beyond it, return zero. */
     TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
-                               0x80017fff80000001, -17, \
+                               0x80017fff80000001, -16, \
                                0x0001000000010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x80017fff80000001, -17, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               -1, -128, 0, 1, 1
 
     TEST_PSIMD_SAT_RR_SET 336, pssha.ws, \
                           0x00000001ffffffff, 1, \
diff --git a/tests/tcg/riscv/psimd-rv32.S b/tests/tcg/riscv/psimd-rv32.S
index 9a20142e98..b5e6d616a8 100644
--- a/tests/tcg/riscv/psimd-rv32.S
+++ b/tests/tcg/riscv/psimd-rv32.S
@@ -1223,8 +1223,15 @@ _start:
         0x80000000, 1, -1, -1, 1, -1
     TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
         0x80000003, -1, 0x40000002, 0, 0
+    /* At lane width, round the top bit; beyond it, return zero. */
     TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
-        0x80000000, -33, 1, 0, 0
+        0x80000000, -32, 1, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
+        0x7fffffff, -32, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
+        0x80000000, -33, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
+        -1, -128, 0, 1, 1
 
     TEST_PSIMD_PAIR_VAR_SAT_SET 604, psshl.dhs, \
         0x7ffe4000, 0x00020001, 0xfffc8000, 0x00040002, \
@@ -1243,11 +1250,23 @@ _start:
         0xffff0001, 0, 0xffff0002, 0
     TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 606, psshlr.dhs, \
         0x80030002, 0xffff0001, -1, 0x40020001, 0x80000001, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 606, psshlr.dhs, \
+        0x80017fff, 0xffff8000, -16, 0x00010000, 0x00010001, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 606, psshlr.dhs, \
+        0x80017fff, 0xffff8000, -17, 0, 0, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 606, psshlr.dhs, \
+        -1, -1, -128, 0, 0, 1, 1
     TEST_PSIMD_PAIR_VAR_SAT_SET 607, psshlr.dws, \
         0x40000000, 1, 0x80000000, 2, \
         0x80000000, 0, -1, 0, -1, 0, -1, 0
     TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 607, psshlr.dws, \
         0x80000003, 2, -1, 0x40000002, 1, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 607, psshlr.dws, \
+        0x80000000, 0x7fffffff, -32, 1, 0, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 607, psshlr.dws, \
+        0x80000000, 0x7fffffff, -33, 0, 0, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 607, psshlr.dws, \
+        -1, -1, -128, 0, 0, 1, 1
     PSIMD_TEST_EXIT 0
     .size _start, .-_start
 
diff --git a/tests/tcg/riscv/psimd-rv64.S b/tests/tcg/riscv/psimd-rv64.S
index ea1db55cd0..47aeba903a 100644
--- a/tests/tcg/riscv/psimd-rv64.S
+++ b/tests/tcg/riscv/psimd-rv64.S
@@ -523,8 +523,13 @@ _start:
         0xffffffff00000001, 1, 0xffffffff00000002
     TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
         0x800000037ffffffe, -1, 0x400000023fffffff, 0, 0
+    /* At lane width, round the top bit; beyond it, return zero. */
     TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
-        0x800000017fffffff, -33, 0x0000000100000000, 0, 0
+        0x800000017fffffff, -32, 0x0000000100000000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
+        0x800000017fffffff, -33, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
+        -1, -128, 0, 1, 1
 
     TEST_PSIMD_RR_SET 610, shl, 0x8000000000000001, -1, \
         0x4000000000000000
@@ -533,7 +538,11 @@ _start:
         0x4000000000000002
     TEST_PSIMD_RR 611, shlr, -1, -1, 0x8000000000000000
     TEST_PSIMD_RR 611, shlr, -1, -64, 1
-    TEST_PSIMD_RR 611, shlr, 0x8000000000000000, -65, 1
+    TEST_PSIMD_RR 611, shlr, 0x8000000000000000, -64, 1
+    TEST_PSIMD_RR 611, shlr, 0x7fffffffffffffff, -64, 0
+    TEST_PSIMD_RR_VXSAT_STATE 611, shlr, \
+        0x8000000000000000, -65, 0, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 611, shlr, -1, -128, 0, 1, 1
 
     TEST_PSIMD_SAT_RR_SET 612, pnclipp.b, \
         0x0001ffff007fff80, 0x007efffe00020000, \
-- 
2.53.0


