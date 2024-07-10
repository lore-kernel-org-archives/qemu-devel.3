Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB3AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0e-0001IO-Mg; Tue, 09 Jul 2024 23:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0b-00014R-EP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0L-0003ol-TR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70b0e7f6f8bso4156659b3a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582108; x=1721186908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqp8Kca9jeo/K5Zxv4t0koVy6btVrx9+gEVO+dirNNk=;
 b=ItpXi5GcTSNEhRfM53Q2CZ0BTaxz3ptTHLXXWOBRIPm3VEnaizEKkn/tFyvlMHhs5a
 /JY15flXpxsARig0Luor5ijed+XqmqWs1PDDW+dU2kq3/xuWlYFbteL0HwXbZZHTMPBC
 Q5cCt/12r4WHUrknyXSshd9kOVnDRTzYEqB9N1VUGGe7GlrEO+c+cJB+nslr05oCGIHI
 S86EWwuPixrd2t/w0E5GJKsBnzQuH8Dz4qxWbx0mRR8p4l3tudMBeRAMbGJpIJMLCZgO
 UnJ9OJpewvbd8xY1JdTEkx+1teB32wUVWomo3aoafiRQVNK5GXk+ZMXoYn6HKXubeAV6
 lp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582108; x=1721186908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yqp8Kca9jeo/K5Zxv4t0koVy6btVrx9+gEVO+dirNNk=;
 b=n/FMK5DwZBFdB7FfinhyOv0pyckxmB6keE1zX3/EJWtybMWtaKEaNa7Z8lt3/0Lc7A
 TxzyW0QxEsjZm5baSy4lXNQpRmVyOpLgkffLEtPrJe3qWZ63fuO8PNzGjGzsnpeCXqne
 /zBbUGbfotO6MqYY7vcXsN6r2Xk3Y5zUnW/GsDgO54TbX8fnQSx0M8l+w4i9vgQ1eU0Z
 P0ElVcC6oWwFRtLGhKRsTLPYPJK4M6PI16qhTML24zgPtB7/JBWWg5Qu0zHODdPCGZ1X
 MLuQ54GbGwAYPJuiN9CwMinFZEmobPnGRRvlKRYfdndYcZh1eilu8ZcMDNG8kr/d6QsS
 Vo4Q==
X-Gm-Message-State: AOJu0YzdtM+vwCXDRq0b0ZneHN4bIGosPb64InVqoyQnISjDLmw/QZHs
 q7BpGlIfkiJyxJVPpmFJHORacQzmni6SK4+Z3P60lLHBEt+F0/7abou8WX+qbi+aKFXAv4OLDBk
 DGGo=
X-Google-Smtp-Source: AGHT+IFLUD29yffT5cJpGs88RJlDRYYC8+Gqtr8VqtBz17Z69M0QP0ygTr1Qt78KEuGtJ9QNw+Fnvw==
X-Received: by 2002:a05:6a00:21cd:b0:70a:f38c:74ba with SMTP id
 d2e1a72fcca58-70b435eaa3fmr5320187b3a.22.1720582107678; 
 Tue, 09 Jul 2024 20:28:27 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 12/13] target/s390x: Use set/clear_helper_retaddr in
 mem_helper.c
Date: Tue,  9 Jul 2024 20:28:13 -0700
Message-ID: <20240710032814.104643-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Avoid a race condition with munmap in another thread.
For access_memset and access_memmove, manage the value
within the helper.  For uses of access_{get,set}_byte,
manage the value across the for loops.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index a76eb6182f..eb1f8880cd 100644
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


