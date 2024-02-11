Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5064C4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xl-0006BO-Si; Sun, 11 Feb 2024 07:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xi-000695-N1
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xg-0006G7-2v
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:34 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5BB44CE0D92;
 Sun, 11 Feb 2024 12:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA51C433C7;
 Sun, 11 Feb 2024 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654567;
 bh=QEDKIdARto+ZCseIU47VCEGfs+CMVMZ3Lv39zKgePHQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MZ6FFPhtbtlpDN418JaX0k1Zf2lELMe5/sb9d2g1hAFe5152AoHCV3t/SnJFuqLHa
 kB4xuEj6Qk/caP23es3U9RJBtPUf9Vk10CEKgf0g2JS0h9FRLq0IEe/AIWHXbR4Yct
 D61d0ghA/KIZz7c+Z6HrvSMR9dTCTB6Z7ydcHgFFgQeDtLucT+QGP8o8nmKbYfTTkT
 nw+ZNKCAPe8MwSVataCEUP6MwB8wY1OchvbzEKiOOu0bOElCb9GiXMaJ/kARzW05tY
 bnuQ01UvfeU7gxQ+FOnVC8S3JK4PRRx460VQ5NLxX6MMW/sE6Z70CFBtSRktDeJyAW
 d95M3Wu1D/90g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 08/12] target/hppa: Allow read-access to PSW with rsm 0,
 reg instruction
Date: Sun, 11 Feb 2024 13:29:05 +0100
Message-ID: <20240211122909.5807-9-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 53ec57ee86..01f3188656 100644
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


