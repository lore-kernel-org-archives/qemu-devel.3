Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvk-0006Yw-7G; Sat, 30 Aug 2025 11:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELX-0005pg-TQ
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELU-00043I-JD
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:51 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3276f46c1caso2521835a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532506; x=1757137306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBvQBImbMcXSRJ7/gU+od/3k59vUr39ACcyOL54SreM=;
 b=jQ7NAE0dbfhtSunlXEhKUc6x2kqoVqlmBFXVxVYlpFnidtUPNM9QwS9QfTD5C+sowi
 7REFyfnl+G3uCcW8njLnPaBXgOpb39Uxuam4fz9XJezVskGt9P2rHF63eoAXs66djcN2
 dwyBRVLWAEWlb6er5TztlnUQACEWRnFthhFo7gzjb6XxrI7suD8B4V7krTscXq7dnwj+
 ow9SfcaQAx6KT10XAZFljZl1GBOjS8FTb7p1FbYlO6UFDBRX9yJOG4DkO25x54wOVpba
 4gJUI0THmueBzN49NmtvighL4fgxYgh+f2EscQ3QLhm0ZuN4KOVk7eiHmlWBVBJQ7m9o
 HdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532506; x=1757137306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBvQBImbMcXSRJ7/gU+od/3k59vUr39ACcyOL54SreM=;
 b=PQR6qZCQtKQNfRsGqF021kUUOwe4farVirEWF0lFHpQaEAcQ7iPv+4VtjkPwNvfPeE
 xn6b4Ti77ZYfG30Lm5Q6UheKWQq75ehjUsi89CJPllS3H7K7O6RX2o/ZSE40HbWWYkz6
 Gb9VIbHahpiC0s8vC17qSLw99rEEZwbRgLAdZ0+dyvIlTaUlCHWknO4vgrRrbh0iG+5l
 PB4b6O64mPfrpWDmiIXPiDpC1+9D/yBQ5UQk7/KEL4LrpiEXN8f5Yv7m8mAtLPzXQNFK
 0mr5GM4bsURQRboCUJqVAZ/FZ4/TibYAR71nCEm4tFLrlHel7cK+VP73rx0sX+xvWI1v
 h8ig==
X-Gm-Message-State: AOJu0Yz9PjCl8qrPMd/IF/wr/OnTmkGnjw5Tl5XCstgOJDFeCcalLjYs
 o/iYnSE/kn790EkqyUAbbiPBpt7VB/VbCJ6k0vbKxlG0jZL4TNE4vPIuc1BEqsDxLNaVig88Tdg
 S85lyN8c=
X-Gm-Gg: ASbGncuuekryv3twws6zeu+2p9dWLSNng0WBZmvuNNmGaQ9a9d30kUj2brMy7sSQ2Xu
 raadNdPFKoq9KwPXt6GEZxGZqjS7bvof5FeBfRbxkXStI0xoX1pJ+jLgLvo3vRR7z3cSR1eQsxL
 LrtRgLqDP+YeP6N8V3rd3KXq0IadmWQc9KcbraJAvFxbUxxMAZ7lrDmRAf8qTuIwM8MOvWWytzc
 P+pl80+Z9FjdVR1mH+XaeuSiMNdCkJ0AUZAUNrQ/1cNHcg4OUca0fZaArnzcFSLd88M8B8EiAjF
 abScuBrzgaxpfrqBNsQgJUTBa1I9cRjccdQSFWtKnrBsXFLRt+q4pw4+VjkbRHiI4cnN6A4xleD
 4s0XEUMQYbBnEir+K4tAYGPesY2+L0EN36t8t1MMyC/T9ocd0a3K/4DtBUE2G
X-Google-Smtp-Source: AGHT+IHMn9sp2TrzN98FIZZhsnmIwo9I2cjXSjrsnTvMhnO3N8E/U6sbgjBDJW90cIGKQd1VCZCVwg==
X-Received: by 2002:a17:90b:3bcd:b0:31e:7417:9e86 with SMTP id
 98e67ed59e1d1-3280d34bf25mr2228371a91.9.1756532505994; 
 Fri, 29 Aug 2025 22:41:45 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 04/84] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
Date: Sat, 30 Aug 2025 15:40:08 +1000
Message-ID: <20250830054128.448363-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Separate the access_type from the protection check.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h    |  5 +++--
 target/arm/ptw.c          | 11 ++++++-----
 target/arm/tcg/m_helper.c |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5a1e75db3..899242e572 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1624,8 +1624,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool is_secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool is_secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
 void arm_log_exception(CPUState *cs);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ed5c728eab..9652f40ff8 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2561,8 +2561,9 @@ static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
 }
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                       bool secure, GetPhysAddrResult *result,
+                       MMUAccessType access_type, unsigned prot_check,
+                       ARMMMUIdx mmu_idx, bool secure,
+                       GetPhysAddrResult *result,
                        ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /*
@@ -2750,7 +2751,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     if (arm_feature(env, ARM_FEATURE_M)) {
         fi->level = 1;
     }
-    return !(result->f.prot & (1 << access_type));
+    return (prot_check & ~result->f.prot) != 0;
 }
 
 static bool v8m_is_sau_exempt(CPUARMState *env,
@@ -2952,8 +2953,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, mmu_idx, secure,
-                            result, fi, NULL);
+    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+                            mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 28307b5615..d856e3bc8e 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2829,8 +2829,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
         ARMMMUFaultInfo fi = {};
 
         /* We can ignore the return value as prot is always set */
-        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx, targetsec,
-                          &res, &fi, &mregion);
+        pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, PAGE_READ, mmu_idx,
+                          targetsec, &res, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.43.0


