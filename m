Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=qRgaM2S3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6o-00054F-6l; Fri, 27 Nov 2026 01:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6K-00045c-5Z; Fri, 27 Nov 2026 01:06:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6I-0001sE-AM; Fri, 27 Nov 2026 01:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=7XOnEIzdiqCNq87ksb2GZTmqOSiOxuorB8tMqsLt5O0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qRgaM2S31SyRv9FdMNtCAtlrOC2bownw1ASVmZ89qIZY5n0VyEjeI7ykX3g6fOv7X
 egbZLmAsDclMI8OYrPzhRjsT0S3YlELcD2qAztN0gCfQpWCkqnBVSjwQfSA5phM2pq
 VvjLyav7ODHjrLXujYxu4hLSTie3buy7Lry2jZ/vidDMCgZ/bhq37/R8UqzsTO2YKl
 zYc/r69tAJVCzXDuy19C6Abh4+plCD/AMo1Mq/mZvMvfKNFGR/9s5mEmByYPRw4JW2
 IcYHUGfkfRUOdotkW5oZtNBKV+883OG91YnD3jJpCszHjSFphi1G62g5/vr/iMqSy6
 ggj2peZwBLODg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C3451EA359;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19F09469984;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 04CDCCF300; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 103/152] target/arm: Fix barrier polarity of A32
 LDA load-acquire
Date: Fri, 27 Nov 2026 08:54:01 +0300
Message-ID: <20261127055709.39630-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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
index 12b9798946b..8ebfc6ceac6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4440,7 +4440,7 @@ static bool op_lda(DisasContext *s, arg_LDA *a, MemOp mop)
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
 
     store_reg(s, a->rt, tmp);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     return true;
 }
 
-- 
2.47.3


