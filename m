Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00B0C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLeb-00065Y-By; Wed, 12 Jun 2024 06:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeZ-00064J-7e
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:31 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeX-0001BK-Fr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:31 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id B988840762E4;
 Wed, 12 Jun 2024 10:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B988840762E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718189770;
 bh=w7/Qh/yuZuxm08WeK7kpVgXaIgKtK2sK38ZgTE3gvGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WkFz3zWfKZ4tc9sjRk8D9cdFR2XaTEb8BW9+oiIN1SRZSd06v1g2KR8RJXTKOA8xy
 R/iXJzH0XNRdRuzlnInVBdfJ0vwAj97ieMDGfQDDVXBKOvRXJfuzJScA3NDTPUYt0+
 g2nsbIyHdDex9gSj0SDpL8n7V1dUwfeVztdxmzeM=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 2/5] Revert "host/i386: assume presence of SSSE3"
Date: Wed, 12 Jun 2024 13:55:22 +0300
Message-Id: <20240612105525.8795-3-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240612105525.8795-1-amonakov@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commit 433cd6d94a8256af70a5200f236dc8047c3c1468.

Revert in preparation to rolling back x86_64-v2 ISA requirement.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 util/cpuinfo-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 6d474a62..ca74ef04 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -38,8 +38,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
-        /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
-        info |= (c & bit_AES) ? CPUINFO_AES : 0;
+        /* Our AES support requires PSHUFB as well. */
+        info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.32.0


