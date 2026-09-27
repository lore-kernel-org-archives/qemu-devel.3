Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BE4C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksD-0006fY-OZ; Sun, 27 Sep 2026 05:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqg-0001i5-4U; Sun, 27 Sep 2026 05:07:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqe-0008Al-JX; Sun, 27 Sep 2026 05:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=Z/LXGCYI/1dhN3wjcVVBEmbET1GiKlT4Rdlg5vpf7B8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vvy6dWTBTR59vCP3QdJ0S+eGmJcvSKtnd8DAr/CdSNvwTfamH8IOcdf9LQCS5q5fo
 cZ2FYHIyooZmJL1Cph6yZHvf4pMFN1aWIk0EDNJlWahgpyEk5sw/Buy7De8uBAX63e
 /PJLNDHv8Vnd07fGA9d3KyLx+Z1TH0ELW/BJNwYaGBWWLIOSH0bfSdL6Ath5rG/2BZ
 yWEatf/qKhhva545wwJELklhZ4kC5ge5FCLQYRJIg9XFmc0uAsLKlxvPD3uOCLVxwb
 9bhz6HCzxQuCiIqqP7ynbSdgxZoe2oebVAQXA3mzBJx8ap8ebuC3qPtZPzt9XhhwSm
 dFfQjIzsidi9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C4261D8B1A;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0953C4320D3;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CE0995E665; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 73/86] tcg/riscv64: Set vtype before whole-register
 vector loads
Date: Sun, 27 Sep 2026 12:05:20 +0300
Message-ID: <20260927090540.102811-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 76dd4fca97b..86baf5a213c 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -768,6 +768,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
@@ -1007,6 +1008,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
             unsigned idx = type - riscv_lg2_vlenb;
 
             tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
+            /* We must initialize vtype to something to avoid VILL. */
+            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
+                set_vtype(s, type, MO_8);
+            }
             insn = whole_reg_ld[idx];
         } else {
             static const RISCVInsn unit_stride_ld[] = {
@@ -1039,6 +1044,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         if (type >= riscv_lg2_vlenb) {
             static const RISCVInsn whole_reg_st[] = {
                 OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
-- 
2.47.3


