Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A03FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCi-0008DH-5u; Wed, 25 Feb 2026 18:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCb-0008C6-E7
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCZ-0004PB-Ol
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:57 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so2535355e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061714; x=1772666514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kEjkvI21KJhfxoPnZ142F140lecsb92SIRQcE5bRkmg=;
 b=bYPPF/TqhiP7ihwfLXYYYeGvmeC3jF/hG5m5snDDa0VhpNaLOhd5UsgdP1pvb7205a
 BYTfTHaMv8BM/ATc0jcDfegJiNlvYFqiFkLRzQF042eyWEHSuxJa+XDrYtrNbe4luusq
 8eBUFHjkR0f5gXUTQ++LKeFMqZZyQUz43PgbH5WkpAJanspQPiQqsqEjehllxUq783kk
 lJeMKJMv3a6Ob+g7HlnatMBvYE0cFffTjXK0QdId0ETR71OZnmwjd2JbIK07KnNu9/3Y
 KQxfCi862ENgqq1KDGTQvbhC+ezTlKpOwoEKDOkv7vOtEO43Wd+jI9/prfOnygq6jJey
 1G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061714; x=1772666514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kEjkvI21KJhfxoPnZ142F140lecsb92SIRQcE5bRkmg=;
 b=fOt+qSgOUq2Vp/41M7Wlpo7AHTpuk76K6leqU9SrYK5rxlTcXwPonFN6GgWw5EMgZD
 Uvti+aW+NJzV3ncv6GixI4xXOAMu0kAWkXSx9szIP8pMJt/fF2hx007OZi+Mse4hnRhj
 rDspMVE0StwXv32lN/b/pYk6U/j9eYbzw+oUfJ7Wb/uDHwnQrP1f9tLdvCWKardV5KQc
 1rjIIea10tVcEIg6GVAUYOjXq+jh7A8ZCREutCBdATx0UqorZdMLO8I72C2jAkKDJA9z
 GQzFjTTR5xMaxqwOsiudd1j16bOEqY+RifTHDZYVYExpdvsyuRwnUQCqvHSaNzgTm8Ns
 iO3A==
X-Gm-Message-State: AOJu0YwTk6JE0sLaeCjKOpT8/egrMEi6KsPQQC2n5lQzxLw8x9tw+AuU
 x24UKSwEl4EvfNc9jywnXTWvqnNYv7hFAQsMYSAA2jzfp4E2AL8Q4sSJIp76F8NPsXmWGas9KKc
 kc7FiXOE=
X-Gm-Gg: ATEYQzz98pUZPlCzn1v8TXcPomODcu/qhGN/YxxBMUwFGHuJlq0mbQ/GYnxNalMzApJ
 7HbsOZJbp+hAVdvvMuflNB0kJWegaHCL/JIpxim92pkuA+skuAKW+74ovVm9NU1wgioJGl0Y8ws
 gPFeRe1WwIFIdhjkeo+kCNOl9cxBiIxutlOGX5FRHL36ZbInyLSKUxQ9p3rNpEZqo/2rf4lL7pT
 YHkGkiA6JjcwXIUGxjz9vwATsUFJ20VUFYZPSZQ5YwjxrjPXvo8NJUz4mF2Cc07xeQprH6l2xSZ
 fS+KYKom8PMfiHiIrT/XZBiIfrCU79AKsEIJa/8hi4X8RjGXNbDIODXTfit/X9ShaK863iOp3EN
 DzcSoBcWRSmEnAmaQxZUmESl0PbbXnZb9E3SPuBdPO1wod8JRsvO5Bq+b++H0ZnObQA6T5Uynr3
 uXeDn8bt4Cd9kS9gT9rQAINy+ibvW6GO8xTOOtg7Wm/B9fcINqm1QElWcA01y+On5zD4KLDkkf
X-Received: by 2002:a05:600c:c166:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483a960a0e8mr323729185e9.15.1772061713963; 
 Wed, 25 Feb 2026 15:21:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm56953255e9.0.2026.02.25.15.21.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/70] page-vary: Build set_preferred_target_page_bits as
 common code
Date: Thu, 26 Feb 2026 00:14:08 +0100
Message-ID: <20260225231411.96482-69-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Use target_info->page_bits_vary to merge
set_preferred_target_page_bits_common into
set_preferred_target_page_bits in page-vary-common.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260217095106.598486-5-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/page-vary.h |  1 -
 page-vary-common.c       | 29 ++++++++++++++++++-----------
 page-vary-target.c       | 10 ----------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 3c77689ca52..c4dc56634bc 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -41,7 +41,6 @@ typedef struct {
 } TargetPageBits;
 
 #ifdef IN_PAGE_VARY
-bool set_preferred_target_page_bits_common(int bits);
 void finalize_target_page_bits_common(int min);
 #endif
 
diff --git a/page-vary-common.c b/page-vary-common.c
index ab77672dd41..b41137c644d 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,25 +20,32 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
 
 TargetPageBits target_page;
 
-bool set_preferred_target_page_bits_common(int bits)
+bool set_preferred_target_page_bits(int bits)
 {
-    /*
-     * The target page size is the lowest common denominator for all
-     * the CPUs in the system, so we can only make it smaller, never
-     * larger. And we can't make it smaller once we've committed to
-     * a particular size.
-     */
-    if (target_page.bits == 0 || target_page.bits > bits) {
-        if (target_page.decided) {
-            return false;
+    const TargetInfo *ti = target_info();
+
+    assert(bits >= TARGET_PAGE_BITS_MIN);
+    if (ti->page_bits_vary) {
+
+        /*
+         * The target page size is the lowest common denominator for all
+         * the CPUs in the system, so we can only make it smaller, never
+         * larger. And we can't make it smaller once we've committed to
+         * a particular size.
+         */
+        if (target_page.bits == 0 || target_page.bits > bits) {
+            if (target_page.decided) {
+                return false;
+            }
+            target_page.bits = bits;
         }
-        target_page.bits = bits;
     }
     return true;
 }
diff --git a/page-vary-target.c b/page-vary-target.c
index 7c0565dd8dc..d388c5c3d64 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -39,16 +39,6 @@ int migration_legacy_page_bits(void)
 }
 #endif
 
-bool set_preferred_target_page_bits(int bits)
-{
-    assert(bits >= TARGET_PAGE_BITS_MIN);
-#ifdef TARGET_PAGE_BITS_VARY
-    return set_preferred_target_page_bits_common(bits);
-#else
-    return true;
-#endif
-}
-
 void finalize_target_page_bits(void)
 {
 #ifndef TARGET_PAGE_BITS_VARY
-- 
2.52.0


