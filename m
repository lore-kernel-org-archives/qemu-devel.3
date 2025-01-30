Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B5DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUbs-0004is-4r; Thu, 30 Jan 2025 08:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbq-0004iF-7x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:30 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbo-0001PK-OP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3C86E5C05CD;
 Thu, 30 Jan 2025 13:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CBC4CED2;
 Thu, 30 Jan 2025 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738243768;
 bh=TTZQ3gdFh6H6hJ0o3arXtbhMAP/Olm8bzx/GKUy+TWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=go3z/Y+Y96v0V6FQYz7+I5P/d55oszu4HB5K71ZxBLUpMW7KjGxXX95PL3RU1iXi4
 XKrmrYvGy+6vOMq2EVU+40u4Rm3zyOvqiYV8Muwi69n3WIDxl++HseRic1GvGaUUI/
 VucfxOFlYGm08T8ZxoRp+4Mf+HdQtfnWiJu+KlX0I8AWiYgwiniKopvj+Qfziwz8o5
 ShtcnAoDfXlURLlEZHnMF7vDQHm4doRP9jmqc8YVxIE9yXP3gpOX5leRPiG2BQfU9R
 Ji2ujXsHKv5quUDTgv226+sfTPH65GbxgsybYqBfTNBlEd173JLvQmEIC4KlJi1nIK
 ilUQ1Tot2JMqw==
From: deller@kernel.org
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 6/9] target/hppa: Add instruction decoding for mfdiag and mtdiag
Date: Thu, 30 Jan 2025 14:29:11 +0100
Message-ID: <20250130132915.16846-7-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130132915.16846-1-deller@kernel.org>
References: <20250130132915.16846-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


