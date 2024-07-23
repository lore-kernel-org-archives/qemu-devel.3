Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10139C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6JG-0003OR-QK; Mon, 22 Jul 2024 23:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JF-0003KQ-Ry
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:29 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6JC-0001zO-Mr
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:29 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-66599ca3470so50993797b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705725; x=1722310525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmWwVxVRnF8pwGo5KrCOQQuxqHCEbEF4oIcvEOO+M5Y=;
 b=o/NEWhbdG8ukSDHmEFhntdyuTMpLXCrFgEztfvH2PjNhEbIHL7yus6q5c1wF8RB0FA
 ZN2N/4p38EXfY9qiNWibfy7fL+pKgYS+5cFKSks6Dv09c7L8JICzv7xfKjuzv5VBQo6F
 tb77bDnp42N6/84kQF+mA4ma9uIltn7y0EpAnTI3VXwP4saS9CCmrEyYsHrqlTMTTRAQ
 5r9mYbM7ZElGdm133RE2GEZGjrUA1WCPCpHBmt0LlSytpjYp2hM/diaAeLryevgsgAuk
 yCqzZ6gR3o/sze/+FbMHtf4fJCzS0YHmg/fKZKl+Kvm413zBMZCu46ytcKHk9oT5s+CR
 kXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705725; x=1722310525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmWwVxVRnF8pwGo5KrCOQQuxqHCEbEF4oIcvEOO+M5Y=;
 b=iH4mL5mMdz2nQ7hN1b3Qn9f1n0sljQFpgzUFl5Lgdrj4VLPJFQTHHbMd6fOUSc6SZA
 Y3wJ56qC0FmuXgu2ZTqG8mSMaY+EMO0vYbNJ3SgWz4xxyUrZ3kGTiLCqIbNRe88aqmtO
 KbiCeuTy6jU4bxwDaU88cEtR1mwOBnLNZLmc4903U7A+pCjAbdsfuKat8fllw0/+7LX2
 xt8c/tzTj8/PlLtXXkR0IoPhiYZvpRvr7ZJdKUYZWp2oBt8R02t2EbFDRsHw6vJgGXTH
 JDvkE8oeHfUqpXHBrta7jBuAk/I/cCvNRZbLaIHJ9uQ8R4UH2dJSV9YVrCIPU/eU8nsV
 em4A==
X-Gm-Message-State: AOJu0YwX7j9uRAoKyAEJUbMVkvofwtpvctfLONov+wLY5jV2vyNVUn4a
 pHbTEi+qUSRnLSCbClG4+TZcwFEtnhS3Db1rhp164XUSmFufyYL9yvB3KDFpYYmyo+yQ+jmPNjb
 NFQR9gA==
X-Google-Smtp-Source: AGHT+IF8wmvPPHJCiQjtx3s2tL5D+m8K4ezqmu5knTi2aD/51pzHqxXa6MTIuLhi8a8ntHlIqzK2Yg==
X-Received: by 2002:a05:690c:290b:b0:62c:c684:b1e1 with SMTP id
 00721157ae682-66a682ce848mr107265187b3.29.1721705725132; 
 Mon, 22 Jul 2024 20:35:25 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/12] target/s390x: Use set/clear_helper_retaddr in
 mem_helper.c
Date: Tue, 23 Jul 2024 13:34:50 +1000
Message-ID: <20240723033451.546151-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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

Avoid a race condition with munmap in another thread.
For access_memset and access_memmove, manage the value
within the helper.  For uses of access_{get,set}_byte,
manage the value across the for loops.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 331a35b2e5..0e12dae2aa 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -238,14 +238,14 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
 static void access_memset(CPUS390XState *env, S390Access *desta,
                           uint8_t byte, uintptr_t ra)
 {
-
+    set_helper_retaddr(ra);
     do_access_memset(env, desta->vaddr1, desta->haddr1, byte, desta->size1,
                      desta->mmu_idx, ra);
-    if (likely(!desta->size2)) {
-        return;
+    if (unlikely(desta->size2)) {
+        do_access_memset(env, desta->vaddr2, desta->haddr2, byte,
+                         desta->size2, desta->mmu_idx, ra);
     }
-    do_access_memset(env, desta->vaddr2, desta->haddr2, byte, desta->size2,
-                     desta->mmu_idx, ra);
+    clear_helper_retaddr();
 }
 
 static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
@@ -366,6 +366,8 @@ static uint32_t do_helper_nc(CPUS390XState *env, uint32_t l, uint64_t dest,
     access_prepare(&srca1, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&srca2, env, dest, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+    set_helper_retaddr(ra);
+
     for (i = 0; i < l; i++) {
         const uint8_t x = access_get_byte(env, &srca1, i, ra) &
                           access_get_byte(env, &srca2, i, ra);
@@ -373,6 +375,8 @@ static uint32_t do_helper_nc(CPUS390XState *env, uint32_t l, uint64_t dest,
         c |= x;
         access_set_byte(env, &desta, i, x, ra);
     }
+
+    clear_helper_retaddr();
     return c != 0;
 }
 
@@ -407,6 +411,7 @@ static uint32_t do_helper_xc(CPUS390XState *env, uint32_t l, uint64_t dest,
         return 0;
     }
 
+    set_helper_retaddr(ra);
     for (i = 0; i < l; i++) {
         const uint8_t x = access_get_byte(env, &srca1, i, ra) ^
                           access_get_byte(env, &srca2, i, ra);
@@ -414,6 +419,7 @@ static uint32_t do_helper_xc(CPUS390XState *env, uint32_t l, uint64_t dest,
         c |= x;
         access_set_byte(env, &desta, i, x, ra);
     }
+    clear_helper_retaddr();
     return c != 0;
 }
 
@@ -441,6 +447,8 @@ static uint32_t do_helper_oc(CPUS390XState *env, uint32_t l, uint64_t dest,
     access_prepare(&srca1, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&srca2, env, dest, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+    set_helper_retaddr(ra);
+
     for (i = 0; i < l; i++) {
         const uint8_t x = access_get_byte(env, &srca1, i, ra) |
                           access_get_byte(env, &srca2, i, ra);
@@ -448,6 +456,8 @@ static uint32_t do_helper_oc(CPUS390XState *env, uint32_t l, uint64_t dest,
         c |= x;
         access_set_byte(env, &desta, i, x, ra);
     }
+
+    clear_helper_retaddr();
     return c != 0;
 }
 
@@ -484,11 +494,13 @@ static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
     } else if (!is_destructive_overlap(env, dest, src, l)) {
         access_memmove(env, &desta, &srca, ra);
     } else {
+        set_helper_retaddr(ra);
         for (i = 0; i < l; i++) {
             uint8_t byte = access_get_byte(env, &srca, i, ra);
 
             access_set_byte(env, &desta, i, byte, ra);
         }
+        clear_helper_retaddr();
     }
 
     return env->cc_op;
@@ -514,10 +526,12 @@ void HELPER(mvcrl)(CPUS390XState *env, uint64_t l, uint64_t dest, uint64_t src)
     access_prepare(&srca, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
 
+    set_helper_retaddr(ra);
     for (i = l - 1; i >= 0; i--) {
         uint8_t byte = access_get_byte(env, &srca, i, ra);
         access_set_byte(env, &desta, i, byte, ra);
     }
+    clear_helper_retaddr();
 }
 
 /* move inverse  */
@@ -534,11 +548,13 @@ void HELPER(mvcin)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     src = wrap_address(env, src - l + 1);
     access_prepare(&srca, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+
+    set_helper_retaddr(ra);
     for (i = 0; i < l; i++) {
         const uint8_t x = access_get_byte(env, &srca, l - i - 1, ra);
-
         access_set_byte(env, &desta, i, x, ra);
     }
+    clear_helper_retaddr();
 }
 
 /* move numerics  */
@@ -555,12 +571,15 @@ void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     access_prepare(&srca1, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&srca2, env, dest, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+
+    set_helper_retaddr(ra);
     for (i = 0; i < l; i++) {
         const uint8_t x = (access_get_byte(env, &srca1, i, ra) & 0x0f) |
                           (access_get_byte(env, &srca2, i, ra) & 0xf0);
 
         access_set_byte(env, &desta, i, x, ra);
     }
+    clear_helper_retaddr();
 }
 
 /* move with offset  */
@@ -580,6 +599,8 @@ void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 
     /* Handle rightmost byte */
     byte_dest = cpu_ldub_data_ra(env, dest + len_dest - 1, ra);
+
+    set_helper_retaddr(ra);
     byte_src = access_get_byte(env, &srca, len_src - 1, ra);
     byte_dest = (byte_dest & 0x0f) | (byte_src << 4);
     access_set_byte(env, &desta, len_dest - 1, byte_dest, ra);
@@ -595,6 +616,7 @@ void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
         byte_dest |= byte_src << 4;
         access_set_byte(env, &desta, i, byte_dest, ra);
     }
+    clear_helper_retaddr();
 }
 
 /* move zones  */
@@ -611,12 +633,15 @@ void HELPER(mvz)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
     access_prepare(&srca1, env, src, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&srca2, env, dest, l, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, dest, l, MMU_DATA_STORE, mmu_idx, ra);
+
+    set_helper_retaddr(ra);
     for (i = 0; i < l; i++) {
         const uint8_t x = (access_get_byte(env, &srca1, i, ra) & 0xf0) |
                           (access_get_byte(env, &srca2, i, ra) & 0x0f);
 
         access_set_byte(env, &desta, i, x, ra);
     }
+    clear_helper_retaddr();
 }
 
 /* compare unsigned byte arrays */
@@ -961,15 +986,19 @@ uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
      */
     access_prepare(&srca, env, s, len, MMU_DATA_LOAD, mmu_idx, ra);
     access_prepare(&desta, env, d, len, MMU_DATA_STORE, mmu_idx, ra);
+
+    set_helper_retaddr(ra);
     for (i = 0; i < len; i++) {
         const uint8_t v = access_get_byte(env, &srca, i, ra);
 
         access_set_byte(env, &desta, i, v, ra);
         if (v == c) {
+            clear_helper_retaddr();
             set_address_zero(env, r1, d + i);
             return 1;
         }
     }
+    clear_helper_retaddr();
     set_address_zero(env, r1, d + len);
     set_address_zero(env, r2, s + len);
     return 3;
@@ -1060,6 +1089,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
         *dest = wrap_address(env, *dest + len);
     } else {
         access_prepare(&desta, env, *dest, len, MMU_DATA_STORE, mmu_idx, ra);
+        set_helper_retaddr(ra);
 
         /* The remaining length selects the padding byte. */
         for (i = 0; i < len; (*destlen)--, i++) {
@@ -1069,6 +1099,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
                 access_set_byte(env, &desta, i, pad >> 8, ra);
             }
         }
+        clear_helper_retaddr();
         *dest = wrap_address(env, *dest + len);
     }
 
-- 
2.43.0


