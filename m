Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11835C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLeb-00065f-C9; Wed, 12 Jun 2024 06:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeZ-00064I-5F
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:31 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHLeX-0001BL-6u
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:56:30 -0400
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id DA1304076725;
 Wed, 12 Jun 2024 10:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DA1304076725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718189770;
 bh=eKTwM4O0d3P1nFCPrRtI4yphrKJSTtO5SItfNM7r8EM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fSweBRFKggD+2Za7GpX8WYny0lJuIjkXRtQDd1FxFadPkodAqZmjxuZwYKZIT0yqd
 bkF80GNi8QMtFqRSuQBsoXIdIK71DxObjUQSsDjiLG+1yo9Lm7aYmsvjP5bOm8PVva
 Xrurvh9+G7zMMEQLMSc+Iay8KUYlBT4f0KvRyv6o=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 3/5] Revert "host/i386: assume presence of SSE2"
Date: Wed, 12 Jun 2024 13:55:23 +0300
Message-Id: <20240612105525.8795-4-amonakov@ispras.ru>
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

This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.

Revert in preparation to rolling back x86_64-v2 ISA requirement.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 host/include/i386/host/cpuinfo.h | 1 +
 util/bufferiszero.c              | 4 ++--
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad6..81771733 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,6 +14,7 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 11c080e0..74864f7b 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -188,14 +188,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
-#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
 
+#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return 1;
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
 #elif defined(__aarch64__) && defined(__ARM_NEON)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04..90f92a42 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,6 +34,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
+        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.32.0


