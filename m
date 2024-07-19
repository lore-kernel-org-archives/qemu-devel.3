Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F1C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6k-0005nV-Gf; Thu, 18 Jul 2024 21:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6F-00047L-L8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:08:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6B-0000tr-Cd
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso9825165ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351270; x=1721956070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqmmPMBGBkj8EkL2sBghBJ5bQR2DDW9j3L8Pj6+n++Q=;
 b=yUzvaTX5AVJHx5ho1YSJXenhVWf/8ZRR/bJgKGxfnvZMom07oXG+bu+TX3GrTkUsDO
 V+2TwwJx62tMXO9q4EtRzmfjxk0WMhie4YhN5NIKqk6nbjTxDg9GoYRBMAfAhutRinS1
 ToKnceAsGpZ5Prnp1rUtTeS+uFP11QtpPjLrpeMPi8RSmGlLl2f8favFu6H2yz9S1SO8
 Dyk10r1l7Q0zDRgagw0jUGyFfZlVEpabo04gb6BkPqRdBu8yP10847r1GJMaYEQJxnVk
 aDoxSCPlNYpOo4sfoyimekos0FD8zQFDKzMt+EdnOkbg+ANQ5ZprXKstuwwPZufETJX7
 m37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351270; x=1721956070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqmmPMBGBkj8EkL2sBghBJ5bQR2DDW9j3L8Pj6+n++Q=;
 b=W6BPBqxOz2oNxM2qzAF7v2+rQb8FFX1YRsDE6UN6k5Ed/1fE2mBdhkQrq8HsliCCt/
 Xhc9mvBkU6P9F5W1+OPWmjnYm4zfnRnlaOoskmBVMqNcB4OkS8oa4f3zoiNvpIeymVQq
 /L1gIrtMcSoQYwHDrtOeFBN46vVUmp6svDE2rbTKPKWqJcwPstwBPZz3ANFHwDxoh3Ad
 ZhQTBl4ojEHn+3BqfqUN6V3F3sw/xKFPlND27+1Z2Lm6ss5iU6d5Gm6astB3eLXRw5X3
 pfoidLGctEWY1RVkDD93Ji+4WVW84+7sS3cu3+Zy0Ge2YRWecQCzIB6oiHz1CsWghN5g
 Kl6A==
X-Gm-Message-State: AOJu0YyAW12CZJTRs5uEuLLXow0Bzv8dA2UGpvSjkJSX14j3SwrYTNIF
 jphGAIW1aBw/2vd9KDk0WVmsB71m3B8VsH/ICb5sExJUTDrAtqoJhPXVrDpHNnG0N2T/9REOGfE
 zhvtvKg==
X-Google-Smtp-Source: AGHT+IGIks0RAD5g2qiuDVYD4SHobQIeZA2XH06sKSjd1vbzdOY+l1aECfdIH0117zW+wInRsYl57w==
X-Received: by 2002:a17:902:e751:b0:1fd:6677:69b4 with SMTP id
 d9443c01a7336-1fd66776de8mr1859415ad.49.1721351269676; 
 Thu, 18 Jul 2024 18:07:49 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 10/12] target/s390x: Use user_or_likely in access_memmove
Date: Fri, 19 Jul 2024 11:07:05 +1000
Message-ID: <20240719010707.1319675-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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


