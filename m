Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F4DC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNT-0004uK-1V; Tue, 06 Feb 2024 15:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNR-0004tt-C9
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:09 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNN-0001cB-74
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:49:09 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 2C3094076729;
 Tue,  6 Feb 2024 20:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2C3094076729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252521;
 bh=VFrTWUlG2vqWX9RDmzX8dOxdM4X5eGzOS6RJxjiMu2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MvS/sCN7GSp4MF0lMpJkTKokikr4L+sbUSh9kXOC01mf7klPhtp2xzQCemckKKtak
 i6pqC3altfKaZa96P50v4rkqIlvBpTwZISqAYVkxSkuVWrz3oR/duq01gqOum2XNQM
 SDHMqgXg9/zQO4FPMM0i2zb4wcatETzlym8WKAAA=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 4/6] util/bufferiszero: remove useless prefetches
Date: Tue,  6 Feb 2024 23:48:07 +0300
Message-Id: <20240206204809.9859-5-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240206204809.9859-1-amonakov@ispras.ru>
References: <20240206204809.9859-1-amonakov@ispras.ru>
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

Use of prefetching in bufferiszero.c is quite questionable:

- prefetches are issued just a few CPU cycles before the corresponding
  line would be hit by demand loads;

- they are done for simple access patterns, i.e. where hardware
  prefetchers can perform better;

- they compete for load ports in loops that should be limited by load
  port throughput rather than ALU throughput.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---
 util/bufferiszero.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index c037d11d04..cb3eb2543f 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -49,7 +49,6 @@ buffer_is_zero_len_4_plus(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
             if (t) {
                 return false;
             }
@@ -79,7 +78,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
@@ -110,7 +108,6 @@ buffer_zero_avx2(const void *buf, size_t len)
 
     /* Loop over 32-byte aligned blocks of 128.  */
     while (p <= e) {
-        __builtin_prefetch(p);
         if (unlikely(!_mm256_testz_si256(t, t))) {
             return false;
         }
-- 
2.32.0


