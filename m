Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A56C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXP-0004lV-PK; Wed, 07 Feb 2024 13:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXK-0004kV-Ig
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:42 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXI-0008AI-Uj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 61CF9619D7;
 Wed,  7 Feb 2024 18:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393C2C433C7;
 Wed,  7 Feb 2024 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330040;
 bh=vLEiE8lhlyiRwJ4cJo1am9Zz8JhSgVENwn64GYYsBD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ucl7fOfxxecmxSmjqqKU3SBIT/G+EY87oPkwY6UtyMLsnhiQdxN+HpAiKPvLiqxdh
 tDtdqOd34UjKDBqU1Pyc8pRo8c+Q/5OWF+T8v3eOx2bErtxI8j26K0w2UOOmYvW4TX
 nljNqKtiaHz/Rjoditl4h/fr5jqebI4fUxf5aX2t4eN929mdBjtvQjOS/HohVnL9hH
 F05bNn88goGc4FkpWM76MhRb7p4DXZPXJBHnVwJimMlkOjpyPFrXcd+Y5i7KjgejEB
 JnzcXRPKBMWJGz9gJOgbCkcUKMqxeFkke/g1g07VHA1yOjzb9EBneXzOKxU5ScEMeg
 8f2d76RgcTnJA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 10/13] target/hppa: Check privilege only when PSW.P is set
Date: Wed,  7 Feb 2024 19:20:20 +0100
Message-ID: <20240207182023.36316-11-deller@kernel.org>
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

CHECK_MOST_PRIVILEGED() should check the privilege level only when the PSW.P
bit is set.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7e58775bbf..21c2734a1f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -604,7 +604,7 @@ static bool gen_illegal(DisasContext *ctx)
 #else
 #define CHECK_MOST_PRIVILEGED(EXCP) \
     do {                                     \
-        if (ctx->privilege != 0) {           \
+        if (ctx->privilege != 0 && (ctx->tb_flags & PSW_P)) { \
             return gen_excp_iir(ctx, EXCP);  \
         }                                    \
     } while (0)
-- 
2.43.0


