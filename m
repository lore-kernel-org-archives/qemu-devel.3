Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7472C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNQ-0004ts-9Z; Tue, 06 Feb 2024 15:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSND-0004so-Go
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:55 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNB-0001eS-OA
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:55 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 73AA4407672D;
 Tue,  6 Feb 2024 20:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 73AA4407672D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252521;
 bh=W6EAekkBjy9x2cgLMjMZlCKw0B9qmi55hLClRB6gYtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ig2MPlqgvp1AsoB2P6yxYnJQngGebIorQ5g5xdtrp+72uh5Ui3aCaK23ir1cxGGd9
 nKKQAh6bDb1QHB4AGzqzYikh5511lXCWUFEl8mRbeiFe0O77oDJ3qlCdrrsjWn7vvL
 hViUTBmg5UOnkiLKiu1l7t2b5yzN8AKsd96i2ywI=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 6/6] util/bufferiszero: improve scalar variant
Date: Tue,  6 Feb 2024 23:48:09 +0300
Message-Id: <20240206204809.9859-7-amonakov@ispras.ru>
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

Take into account that the inline wrapper ensures len >= 4.

Use __attribute__((may_alias)) for accesses via non-char pointers.

Avoid using out-of-bounds pointers in loop boundary conditions by
reformulating the 'for' loop as 'if (...) do { ... } while (...)'.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
---
 util/bufferiszero.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index d752edd8cc..1f4cbfaea4 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -29,35 +29,27 @@
 bool
 buffer_is_zero_len_4_plus(const void *buf, size_t len)
 {
-    if (unlikely(len < 8)) {
-        /* For a very small buffer, simply accumulate all the bytes.  */
-        const unsigned char *p = buf;
-        const unsigned char *e = buf + len;
-        unsigned char t = 0;
-
-        do {
-            t |= *p++;
-        } while (p < e);
-
-        return t == 0;
+    if (unlikely(len <= 8)) {
+        /* Our caller ensures len >= 4.  */
+        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
     } else {
-        /* Otherwise, use the unaligned memory access functions to
-           handle the beginning and end of the buffer, with a couple
+        /* Use unaligned memory access functions to handle
+           the beginning and end of the buffer, with a couple
            of loops handling the middle aligned section.  */
-        uint64_t t = ldq_he_p(buf);
-        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
-        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
+        uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+        typedef uint64_t uint64_a __attribute__((may_alias));
+        const uint64_a *p = (void *)(((uintptr_t)buf + 8) & -8);
+        const uint64_a *e = (void *)(((uintptr_t)buf + len - 1) & -8);
 
-        for (; p + 8 <= e; p += 8) {
+        if (e - p >= 8) do {
             if (t) {
                 return false;
             }
             t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
-        }
+        } while ((p += 8) <= e - 8);
         while (p < e) {
             t |= *p++;
         }
-        t |= ldq_he_p(buf + len - 8);
 
         return t == 0;
     }
-- 
2.32.0


