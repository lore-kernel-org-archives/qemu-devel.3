Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD40606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTfm-0003vk-KS; Thu, 26 Nov 2026 02:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfi-0003uB-JG
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTff-0003D2-IE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:34 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxjdIY3Adr6CojAA--.34070S3;
 Thu, 26 Nov 2026 15:13:28 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs8V3AdruH03AA--.43941S3;
 Thu, 26 Nov 2026 15:13:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 09/18] target/loongarch: Do not raise exception on
 read-only CSR write
Date: Thu, 26 Nov 2026 15:14:31 +0800
Message-ID: <20261126071440.3293877-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs8V3AdruH03AA--.43941S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWrXrWxGry7uFyUZw1kZwc_yoW5AF43pr
 1UCrWUWr1UKr95Z395C3WY9F1Yq3WfGay2qa4akw1rurWfJr48Ja18Ja4a9ry8AF93Zr4F
 yFZ0y34kWay3C3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the LoongArch Reference Manual, a write to a read-only CSR
must not raise an exception. Instead the CSR update is silently discarded,
and the destination general-purpose register rd is still loaded with
value of CSR register.

Here change the CSR write behavior to match the architecture.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc     | 33 +++++++++++--------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 300361a1da..7a4f215283 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -135,6 +135,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     const CSRInfo *csr;
     GenCSRWrite writefn;
     tcg_target_long offset;
+    bool rdonly;
 
     if (check_plv(ctx)) {
         return false;
@@ -145,10 +146,12 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
         return true;
     }
-    if (!check_csr_flags(ctx, csr, true)) {
-        /* CSR is readonly: trap. */
-        return false;
-    }
+
+    /*
+     * For a read-only CSR, the CSR itself must not be updated, but the
+     * destination GPR rd must still be loaded with the value of CSR
+     */
+    rdonly = !check_csr_flags(ctx, csr, true);
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
     writefn = (GenCSRWrite)csr->writefn;
     if (writefn) {
@@ -158,7 +161,10 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         dest = tcg_temp_new();
         offset = get_csr_offset(csr, 0);
         tcg_gen_ld_tl(dest, tcg_env, offset);
-        tcg_gen_st_tl(src1, tcg_env, offset);
+
+        if (!rdonly) {
+            tcg_gen_st_tl(src1, tcg_env, offset);
+        }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
     return true;
@@ -170,6 +176,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     const CSRInfo *csr;
     GenCSRWrite writefn;
     tcg_target_long offset;
+    bool rdonly;
 
     if (check_plv(ctx)) {
         return false;
@@ -181,14 +188,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
         return true;
     }
 
-    if (!check_csr_flags(ctx, csr, true)) {
-        /* CSR is readonly: trap. */
-        return false;
-    }
-
-    /* So far only readonly csrs have readfn. */
-    assert(csr->readfn == NULL);
-
+    rdonly = !check_csr_flags(ctx, csr, true);
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
     mask = gpr_src(ctx, a->rj, EXT_NONE);
     oldv = tcg_temp_new();
@@ -197,6 +197,13 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
 
     offset = get_csr_offset(csr, 0);
     tcg_gen_ld_tl(oldv, tcg_env, offset);
+    if (rdonly) {
+        /* So far only readonly csrs have readfn. */
+        assert(csr->readfn == NULL);
+        gen_set_gpr(a->rd, oldv, EXT_NONE);
+        return true;
+    }
+
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
-- 
2.54.0


