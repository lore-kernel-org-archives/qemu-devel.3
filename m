Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0BFC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXL-0004ku-W3; Wed, 07 Feb 2024 13:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXJ-0004jW-Ci
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:41 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXH-0008BV-Ts
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 05F6B61A14;
 Wed,  7 Feb 2024 18:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA70FC433F1;
 Wed,  7 Feb 2024 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330038;
 bh=KoFYV1cuiAvIfsT/+E/M7QzFRHRdtCx8I9CYomiWxOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dhFnrxvI0FODuvGp03xWec7LxBlbciVZNt4O4Codv3Di2CCXiSU+4N4D8+vsr4BeB
 IZJGcLfZIRPuODDtVcVs9vjyddagdYNRzr7fQfmX9MB5a3WyPXpfvY6U9gZauG/Vzh
 OIg3Zq3EW3Tx6lv0blXDYYxYAcPi6yfa7gvWtqtdxHVDTazz0DNTP8nlTEP96E7p3Y
 UHMBbbcUk0YKwMj5FBH3HBS0IDGCmHrBzI0DKnzdfS+4SMcJcoLzLO4fVr7Sd6/AKP
 XSZc0D+goeGIXH9BExZCZJD6yqQsXL19Vtjfsu40nzC+RQXwfYHpOhEtrlzuQjHfej
 NPidzhQZw3Lqw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 09/13] target/hppa: Allow read-access to PSW with rsm 0,
 reg instruction
Date: Wed,  7 Feb 2024 19:20:19 +0100
Message-ID: <20240207182023.36316-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

HP-UX 11 and HP ODE tools use the "rsm 0,%reg" instruction in not priviledged
code paths to get the current PSW flags. The constant 0 means that no bits of
the PSW shall be reset, so this is effectively a read-only access to the PSW.
Allow this read-only access even for not privileged code.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 10fdc0813d..7e58775bbf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2156,10 +2156,16 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
 
 static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
 {
+#ifdef CONFIG_USER_ONLY
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
+#else
     TCGv_i64 tmp;
 
+    /* HP-UX 11i and HP ODE use rsm for read-access to PSW */
+    if (a->i) {
+        CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    }
+
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-- 
2.43.0


