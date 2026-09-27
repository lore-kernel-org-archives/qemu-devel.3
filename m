Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2030C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjIb-0000ci-V2; Sun, 27 Sep 2026 03:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHp-00007P-FI; Sun, 27 Sep 2026 03:27:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHn-0005SI-Rr; Sun, 27 Sep 2026 03:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=K1Lt7sP3wmT8RZ3tfnxOVyqp64tNz2mg0uZRAEwe8OI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ju4uubFvA7LdjZvFH9T/bLpgP/sBUtpUc/2+ICvzUeKDs7yIdSKiB/h15CM+V3Dwn
 CK1/J79UoB44wg+y0JZPzMTCH7Rtc08C2igbe9tifzXIaHJ8umALc66CtR+EEdbEJE
 b35tdkyp4xDJCzCbwwxByJdcVWib2cDg/W6/+epKpNwIumAU+v0ub1ctcK+R7G1sYO
 tm2ICxNqWb2gfVasKmBQHF8tEh9B4tInaNye/pCvjMKN2rIqKuvY9NQs4258bvvhB3
 LZ3FvKdW6xYMEs5/AD1FIZG8eHlKGJWZK5TznUAPA0/5VQoXYyN0G2yEUkVmDvyw/d
 bpjTkLGRbGdFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71D191D8ABD;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B77643204F;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E7E8E5E629; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 59/72] tcg/riscv64: Set vtype before
 whole-register vector loads
Date: Sun, 27 Sep 2026 10:25:51 +0300
Message-ID: <20260927072622.93656-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

With vtype uninitialized, VILL might be set, leading to SIGILL.
Also, assert vtype initialized for whole-register stores and moves.

Fixes: f63e7089b4 ("tcg/riscv: Add basic support for vector")
Reported-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 57d98debdf8a3a00e6022ad5c4dad1d8c4fa0f39)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index ec13d8fee9f..4e2cc24a862 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -784,6 +784,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
@@ -1023,6 +1024,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
             unsigned idx = type - riscv_lg2_vlenb;
 
             tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
+            /* We must initialize vtype to something to avoid VILL. */
+            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
+                set_vtype(s, type, MO_8);
+            }
             insn = whole_reg_ld[idx];
         } else {
             static const RISCVInsn unit_stride_ld[] = {
@@ -1055,6 +1060,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         if (type >= riscv_lg2_vlenb) {
             static const RISCVInsn whole_reg_st[] = {
                 OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
-- 
2.47.3


