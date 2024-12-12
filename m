Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D827DE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkA9-0002Xs-QV; Thu, 12 Dec 2024 09:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLkA4-0002Xi-2t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:27:29 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLkA1-0006gJ-Hs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:27:27 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17])
 by air.basealt.ru (Postfix) with ESMTPSA id DF9DC23388;
 Thu, 12 Dec 2024 17:27:18 +0300 (MSK)
From: gerben@altlinux.org
To: philmd@linaro.org, andrew@openedhand.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Denis Rastyogin <gerben@altlinux.org>,
 Denis Sergeev <zeff@altlinux.org>
Subject: [PATCH] target/arm/tcg: fix potential integer overflow in
 iwmmxt_macuw()
Date: Thu, 12 Dec 2024 17:27:09 +0300
Message-ID: <20241212142716.523980-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

The function iwmmxt_macuw() could potentially cause an integer
overflow when summing up four 32-bit multiplications.
This occurs because the intermediate results may exceed the 32-bit
range before being cast to uint64_t. The fix ensures each
multiplication is explicitly cast to uint64_t prior to summation,
preventing potential issues and ensuring correctness.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Sergeev <zeff@altlinux.org>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 target/arm/tcg/iwmmxt_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103..19c709655e 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -140,7 +140,7 @@ uint64_t HELPER(iwmmxt_macsw)(uint64_t a, uint64_t b)
 
 uint64_t HELPER(iwmmxt_macuw)(uint64_t a, uint64_t b)
 {
-#define MACU(SHR) ( \
+#define MACU(SHR) (uint64_t)( \
         (uint32_t) ((a >> SHR) & 0xffff) * \
         (uint32_t) ((b >> SHR) & 0xffff))
     return MACU(0) + MACU(16) + MACU(32) + MACU(48);
-- 
2.42.2


