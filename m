Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF0CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNL-0003ES-4Q; Wed, 10 Apr 2024 03:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMs-0002Ml-67; Wed, 10 Apr 2024 03:27:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMq-0004oJ-HR; Wed, 10 Apr 2024 03:27:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC00F5D6A0;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9018FB02E0;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191792 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 48/87] target/hppa: mask privilege bits in mfia
Date: Wed, 10 Apr 2024 10:22:21 +0300
Message-Id: <20240410072303.4191455-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

mfia should return only the iaoq bits without privilege
bits.

Fixes: 98a9cb792c8 ("target-hppa: Implement system and memory-management insns")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-Id: <20240319161921.487080-6-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit b5e0b3a53c983c4a9620a44a6a557b389e589218)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ccf03b1ce7..19c4df8960 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2011,7 +2011,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
     TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
+    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.39.2


