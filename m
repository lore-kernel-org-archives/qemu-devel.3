Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6433606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=pygjN6GS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxx-00035r-LN; Fri, 27 Nov 2026 00:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxu-00033E-Uk; Fri, 27 Nov 2026 00:57:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWoxt-00079y-9b; Fri, 27 Nov 2026 00:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758877; bh=7lbuisQW1pHPfNrLGn5eVn09Y96wWvLYoXZtWrCCFVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pygjN6GSoOm1AQJtVlqJlEFtuKor+OBbCJTNuxeRLSW2KcNvrHpWkZnYm7mqrEiCJ
 wjY9m5XuGlr/jqsd9fK7YFud57pZoDTOQYH7EE+ppwPs49BTiGmOtXDwX90neRhRCV
 muc+imUJZwLJisyu1MkmP1MFKaTLvQ187/vvxjOmWWpHHy/coFsOlDaBcLWuFXFIna
 DqU+Y9DUnCC8wP3Zf5Cbgg2gdy9yRwSrG24Uab7u54wT3Aai/fozpcLUF65TUNP1KO
 0aOK5OKH/yODdhLjPw+/3C3/OLylYcE9FB/Vd+ecE8jWq0AdrUz/f3Sr6rtsrWi2mG
 4Z8Ayxg4ZeWfQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A522D1EA2EA;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A2594469925;
 Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 905E2CF256; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 096/140] target/arm: Fix barrier polarity of A32
 LDA load-acquire
Date: Fri, 27 Nov 2026 08:53:22 +0300
Message-ID: <20261127055421.39015-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The A32 and T32 load-acquire instructions LDA, LDAB and LDAH must be
ordered before the memory accesses that follow them, so their
translator has to emit a trailing barrier.  op_lda() emits that barrier
with TCG_BAR_STRL instead of TCG_BAR_LDAQ, inverting the polarity:
TCG_BAR_STRL annotates a leading barrier ("previous ops will not be
delayed") and TCG_BAR_LDAQ a trailing one ("following ops will not come
forward"), as documented in include/tcg/tcg-mo.h.

The x86 and aarch64 backends only look at the TCG_MO_* bits, which the
wrong annotation does not affect, so the generated host code is
unchanged on those hosts.  The annotation is still wrong: it violates
the TCG barrier contract, it lets the optimizer's barrier merging in
fold_mb() combine the barriers of an "LDA; STL" pair into a weaker one
than the correctly annotated form (STRL|STRL stays STRL instead of
LDAQ|STRL = SC), and it diverges from every other load-acquire
translation in the target, which all use TCG_BAR_LDAQ.

Fix the polarity.

Cc: qemu-stable@nongnu.org
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5c33a72bdebe622200b5d81884e1a85090df6abc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 80b6e08921e..f1cc5300861 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5647,7 +5647,7 @@ static bool op_lda(DisasContext *s, arg_LDA *a, MemOp mop)
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
 
     store_reg(s, a->rt, tmp);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     return true;
 }
 
-- 
2.47.3


