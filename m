Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7898C02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 22:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcuNs-0002aO-GR; Tue, 28 Jan 2025 17:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNm-0002ZX-1G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:36 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcuNk-00024A-G0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 17:48:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6B529A41470;
 Tue, 28 Jan 2025 22:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14248C4CEDF;
 Tue, 28 Jan 2025 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738104511;
 bh=aaNhqD+qxBnqaQFsiiicFI2/J+SvMD2ciIeBWu/M9qU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sksK2UGT+/GsvfLSdr5mccP2rVH5P8d+HTlGhESvxofCN3cl9GdLWSnJu65jfOj2n
 7OwlhrWpPMa+2Ia+7yYpjR4vsAbbGdKJD8iEi/YSEpQn22Lamd3geajl7DVifvSv7i
 qT5ir7EIdBKVSJdYXt1H93LqgcYqhjF4pW/qkDwFimPGtnWHFvl1Uij+XX3Fe2HmcW
 20c6rLkRtRJb7TJrXs11mvj0llK9cxobgekkZn+4MfvMjiooPIVAHMy3NwfRMTDeRR
 HaHjHDJwzNM7OFFkhe7xisB9Lqwm4vEFZwBH//kUZOxE+p9wDROzDR53Wki1gQzHEb
 zc/qMRkE6zmdw==
From: deller@kernel.org
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/4] target/hppa: Add instruction decoding for mfdiag and
 mtdiag
Date: Tue, 28 Jan 2025 23:45:42 +0100
Message-ID: <20250128224817.24715-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128224817.24715-1-deller@kernel.org>
References: <20250128224817.24715-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

Add 32- and 64-bit instruction decoding of the mfdiag and mtdiag
instructions which modify the diagnose registers.

diag_getshadowregs_pa2() and diag_putshadowregs_pa2() were added in
commit 3bdf20819e68 based on some analysis of ODE code, but now they
conflict with the generic mfdiag/mtdiag instructions. I believe the
former analysis was wrong, so remove them again. Note that all diag
instructions are badly documented, so most things are based on reverse
engineering and thus may be wrong.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3bdf20819e68 ("target/hppa: Add diag instructions to set/restore shadow registers")
---
 target/hppa/insns.decode |  6 ++++--
 target/hppa/translate.c  | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 71074a64c1..4eaac750ea 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -644,10 +644,12 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
     # For 32-bit PA-7300LC (PCX-L2)
     diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
     diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
+    diag_mfdiag             000101 dr:5  rt:5   0000 0110 0000 0000
+    diag_mtdiag             000101 dr:5  r1:5   0001 0110 0000 0000
 
     # For 64-bit PA8700 (PCX-W2)
-    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
-    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
+    diag_mfdiag             000101 dr:5  0 0000 0000 1000 101  rt:5
+    diag_mtdiag             000101 dr:5  r1:5   0001 1000 0100 0000
   ]
   diag_unimp                000101 i:26
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc04f9f3c0..7b9d3deb39 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4593,19 +4593,29 @@ static bool trans_diag_getshadowregs_pa1(DisasContext *ctx, arg_empty *a)
     return !ctx->is_pa20 && do_getshadowregs(ctx);
 }
 
-static bool trans_diag_getshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
 {
-    return ctx->is_pa20 && do_getshadowregs(ctx);
+    return !ctx->is_pa20 && do_putshadowregs(ctx);
 }
 
-static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_mfdiag(DisasContext *ctx, arg_diag_mfdiag *a)
 {
-    return !ctx->is_pa20 && do_putshadowregs(ctx);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    TCGv_i64 dest = dest_gpr(ctx, a->rt);
+    tcg_gen_ld_i64(dest, tcg_env,
+                       offsetof(CPUHPPAState, dr[a->dr]));
+    save_gpr(ctx, a->rt, dest);
+    return nullify_end(ctx);
 }
 
-static bool trans_diag_putshadowregs_pa2(DisasContext *ctx, arg_empty *a)
+static bool trans_diag_mtdiag(DisasContext *ctx, arg_diag_mtdiag *a)
 {
-    return ctx->is_pa20 && do_putshadowregs(ctx);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
+                        offsetof(CPUHPPAState, dr[a->dr]));
+    return nullify_end(ctx);
 }
 
 static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
-- 
2.47.0


