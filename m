Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E17AC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnEc-0008Hs-8C; Fri, 31 Jan 2025 04:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEa-0008HM-Jx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:44 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEZ-0004E5-8s
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 03411A41ACF;
 Fri, 31 Jan 2025 09:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200EAC4CEE2;
 Fri, 31 Jan 2025 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738315362;
 bh=TTZQ3gdFh6H6hJ0o3arXtbhMAP/Olm8bzx/GKUy+TWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LYRglHM+qHo4ZR9Cqky6KVVOesKzXlu3rtLRDTMTTI4j0sVJ8Tzftvm8qmbCjrTvI
 egpCH5vtOT2WhubQX3w6rDlnHvNEeBSjCjO7ge+07Ebp23oGRLgO9ZsGz5nphgynON
 DWj4knFNEOoIhD4YGoouls1LC9fJ4tMT72oavB5jEbBo9FuljAZN/eD63AYGVInWey
 gABcbjqO3YOlCkQuBbMBmWvSCHoO1zDrMtvLCNxrAQBYXGW8w0pQ5GslhArQGlL0hz
 Fmu2KeoxgeabAhghYt3huD1Py2LytLS/DabCFMDvz+LRMkrGMyk2UuATsS+lygqIcv
 6cMVXtjFnKTzg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL v2 6/9] target/hppa: Add instruction decoding for mfdiag and
 mtdiag
Date: Fri, 31 Jan 2025 10:22:26 +0100
Message-ID: <20250131092229.38232-7-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250131092229.38232-1-deller@kernel.org>
References: <20250131092229.38232-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  4 ++++
 target/hppa/translate.c  | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 527c453443..4eaac750ea 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -644,8 +644,12 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
     # For 32-bit PA-7300LC (PCX-L2)
     diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
     diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
+    diag_mfdiag             000101 dr:5  rt:5   0000 0110 0000 0000
+    diag_mtdiag             000101 dr:5  r1:5   0001 0110 0000 0000
 
     # For 64-bit PA8700 (PCX-W2)
+    diag_mfdiag             000101 dr:5  0 0000 0000 1000 101  rt:5
+    diag_mtdiag             000101 dr:5  r1:5   0001 1000 0100 0000
   ]
   diag_unimp                000101 i:26
 }
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 30fba5297a..7b9d3deb39 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4598,6 +4598,26 @@ static bool trans_diag_putshadowregs_pa1(DisasContext *ctx, arg_empty *a)
     return !ctx->is_pa20 && do_putshadowregs(ctx);
 }
 
+static bool trans_diag_mfdiag(DisasContext *ctx, arg_diag_mfdiag *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    TCGv_i64 dest = dest_gpr(ctx, a->rt);
+    tcg_gen_ld_i64(dest, tcg_env,
+                       offsetof(CPUHPPAState, dr[a->dr]));
+    save_gpr(ctx, a->rt, dest);
+    return nullify_end(ctx);
+}
+
+static bool trans_diag_mtdiag(DisasContext *ctx, arg_diag_mtdiag *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    tcg_gen_st_i64(load_gpr(ctx, a->r1), tcg_env,
+                        offsetof(CPUHPPAState, dr[a->dr]));
+    return nullify_end(ctx);
+}
+
 static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-- 
2.47.0


