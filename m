Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A081C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6JD-0003Cg-Vl; Mon, 22 Jul 2024 23:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JC-00035n-6b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JA-0001zD-9F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d138e06e3so1921708b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705723; x=1722310523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg9qUEQyPB3zLUZtLfqXq0g2/mBlvx+VDk4J1iPFK7Y=;
 b=vV8wlmQajOqaKAwZXENLOCvbcOX8SmTEJZO9a8E/3vhyxCnZG7TTMJvgpffAW0UJKe
 FuuHgd2LoHI7oJnC+XGi258kzTCWjso6NWazivYVL6z2AXtvNtaeSQa8BZx58gyD6kE+
 tc3awAcXUKTf3VPrQx/U2x6yoExIr+PVYP2AAUTaQUH5gd1ddXnFyPGMk9ZPjRIXDtvn
 My1Lt8pkDZHyQ66s6PAhy/XC+EXp+NLKc50gPnGEwVFSUvj0uyQQnwdU3G8jpkh1SnWG
 sRyJNii7ukM3MxyLxjm9vdvSNDutKQiLBb5iBVuIYum5+qnQ85db6FS1fIbuvpOcqsa5
 SLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705723; x=1722310523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg9qUEQyPB3zLUZtLfqXq0g2/mBlvx+VDk4J1iPFK7Y=;
 b=VZ8GgrKRpPifGZTm/z2/TH7mi3CIrnynO2dy7zg29MM3FizYey8kegkufW+cnONsFw
 +WDx+Fper0A43ZRLlGQeCPx5EqBsxJDuMDLsy7hsPE/+XEM0nSNeI+ufCGm7DlAU/ZiV
 abE/ImB/yrpio72393Jz5A6HO7Q0EcVig8CNPbP3Hu1MSfS0BEOB1D4hOjNUki3CD7s7
 xMbr/PGAFIzgC5HLKhPbhxPHUCRTnKZSgdEeC+DkaWvbBRKUv8dlu+3FVSseO20rNnkx
 WzDjriMQaWXOg2aWaoSg35VlO+rGZ0APES4p/rY+bMsoWjUp6O6xCYfQg0YfI3bmenkK
 IqwQ==
X-Gm-Message-State: AOJu0YxFoHP6W46lRLKwV46oKwFKa2edalOg5KBsIdJlbPXeTS28ODZO
 aMLbzk5ZE+lNKiYMF3jmDOkbnwxA0iCjpU1H7XZ8/t4LBdT89HCEjv01SG0bcIJFaHgBat8QGnp
 0LJOFLA==
X-Google-Smtp-Source: AGHT+IGvciqi8cV0n+WG1q0Mb6FyyWyOw1eaxsFtweQ0HlZc2gP1bOyntZvczofZRoIR+h0e6UROCQ==
X-Received: by 2002:a05:6a00:3991:b0:706:750c:8dda with SMTP id
 d2e1a72fcca58-70d0847c8e3mr12793630b3a.6.1721705722751; 
 Mon, 22 Jul 2024 20:35:22 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 10/12] target/s390x: Use user_or_likely in access_memmove
Date: Tue, 23 Jul 2024 13:34:49 +1000
Message-ID: <20240723033451.546151-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Invert the conditional, indent the block, and use the macro
that expands to true for user-only.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 54 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 5311a15a09..331a35b2e5 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -296,41 +296,39 @@ static void access_memmove(CPUS390XState *env, S390Access *desta,
                            S390Access *srca, uintptr_t ra)
 {
     int len = desta->size1 + desta->size2;
-    int diff;
 
     assert(len == srca->size1 + srca->size2);
 
     /* Fallback to slow access in case we don't have access to all host pages */
-    if (unlikely(!desta->haddr1 || (desta->size2 && !desta->haddr2) ||
-                 !srca->haddr1 || (srca->size2 && !srca->haddr2))) {
-        int i;
+    if (user_or_likely(desta->haddr1 &&
+                       srca->haddr1 &&
+                       (!desta->size2 || desta->haddr2) &&
+                       (!srca->size2 || srca->haddr2))) {
+        int diff = desta->size1 - srca->size1;
 
-        for (i = 0; i < len; i++) {
-            uint8_t byte = access_get_byte(env, srca, i, ra);
-
-            access_set_byte(env, desta, i, byte, ra);
-        }
-        return;
-    }
-
-    diff = desta->size1 - srca->size1;
-    if (likely(diff == 0)) {
-        memmove(desta->haddr1, srca->haddr1, srca->size1);
-        if (unlikely(srca->size2)) {
-            memmove(desta->haddr2, srca->haddr2, srca->size2);
-        }
-    } else if (diff > 0) {
-        memmove(desta->haddr1, srca->haddr1, srca->size1);
-        memmove(desta->haddr1 + srca->size1, srca->haddr2, diff);
-        if (likely(desta->size2)) {
-            memmove(desta->haddr2, srca->haddr2 + diff, desta->size2);
+        if (likely(diff == 0)) {
+            memmove(desta->haddr1, srca->haddr1, srca->size1);
+            if (unlikely(srca->size2)) {
+                memmove(desta->haddr2, srca->haddr2, srca->size2);
+            }
+        } else if (diff > 0) {
+            memmove(desta->haddr1, srca->haddr1, srca->size1);
+            memmove(desta->haddr1 + srca->size1, srca->haddr2, diff);
+            if (likely(desta->size2)) {
+                memmove(desta->haddr2, srca->haddr2 + diff, desta->size2);
+            }
+        } else {
+            diff = -diff;
+            memmove(desta->haddr1, srca->haddr1, desta->size1);
+            memmove(desta->haddr2, srca->haddr1 + desta->size1, diff);
+            if (likely(srca->size2)) {
+                memmove(desta->haddr2 + diff, srca->haddr2, srca->size2);
+            }
         }
     } else {
-        diff = -diff;
-        memmove(desta->haddr1, srca->haddr1, desta->size1);
-        memmove(desta->haddr2, srca->haddr1 + desta->size1, diff);
-        if (likely(srca->size2)) {
-            memmove(desta->haddr2 + diff, srca->haddr2, srca->size2);
+        for (int i = 0; i < len; i++) {
+            uint8_t byte = access_get_byte(env, srca, i, ra);
+            access_set_byte(env, desta, i, byte, ra);
         }
     }
 }
-- 
2.43.0


