Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC1CCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXI-0001J0-O8; Thu, 14 Aug 2025 08:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXI-0001IZ-0t
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:28 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXX9-00049s-3w
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b47175587c1so553558a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176294; x=1755781094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81S2M/79YurLIilhsbyfpTd1bD3tCzQZKOlyAZGCKkc=;
 b=mNBvnfrrfy4LRmw81z3r4ay8YAzjpIUsO9b7wUNWO9M6teGWNXpuUl8f7SnKgYoNGO
 b3nBl0DdRYGoRxIeI78cBDHYg9uhHKleXnebwTInkNvMfy5xhUbluidLpMyQpNL7FlJY
 22rs8HQKySqbZD5RjhGGbWScDq7OpGt8Tt5JqEjWUKnCv8adwfXpG5Y49awTTgr+w+U0
 5Vz992+j+T9jEJHiR7JpTC3dWFJPaf2USj/EsFLev58uvUjwGcGhaLo48UokOCJ8m0kh
 JdwSSg/T1nrd2H+SmYvamxEn9N2ITyKlQvRQX8WlnE9PWDLcWcsELgls5QpBTZbJCWHG
 Jobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176294; x=1755781094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81S2M/79YurLIilhsbyfpTd1bD3tCzQZKOlyAZGCKkc=;
 b=UZUOvWUO8vYr8Yko8kJ+tbA109sPfw/tMAnSH92aBgDLigwOGYiz5vfDfrVlHEutUU
 /U6SbPeWPdInu44YXGCJTh2Y+SRIXRbP+SAA6JGfftIWbwsviD0Za12jkSe/dWVPqg3R
 tcWHOU0pGmuOTLWhf6Traqr+cTFgo+3PlHfR3/4z7pyf5y0emv1DGy99ym77Zhkm/t2i
 K3RtNppVOIJt/dBjKmpnyGpUKkKoP4fJ0kCTfwKt0egGbdCNXnIAOJXy87rg7tvN81vd
 a2sj9YLARNcdQclJOtb3kJIo04MVteUa5OOyeggPbBy6ECuwmXKi8gNhXq6IkcHDofNe
 8/CQ==
X-Gm-Message-State: AOJu0YzWEMAMTRVLW4+JVY4SR1u4AZOE5guRfRXrPJK1k+IX/+vK6zub
 H8SgZSFCqW/fxsCENjlxIoiR+TVSfeqklAkFCfd78/duCNmN56BP7y50aveHnUZU88DZF16dD3q
 tn1tiDp8=
X-Gm-Gg: ASbGncvvaQXma0pmBCBNB8u5AZlM7FoTYQeETxIknIXJD0qTFPQD4jIUjzB0oxgEWja
 Ikuif5zC5rCqRvxaGFPs2GvoEYyNsqBlNJ+VzYPzTk/ay9kcEhSzt/9vtt9N7sNR3P05jiR65aq
 mEWWmvN1rnE+gOQu0FZMniJYrQY9LYb51vcYJ92TJ2OhSfXYA++ElqVnnbiFOpcGwsRKcksXnDU
 NV2UvcmRZuRmHrLBHTNMpx1EK5QZ1E0yOnmBwA3GngfRpDDFoZ6gJsd//SNgy96W6o7RUcNmiZL
 JL2ZBsrceiTBsQQx7D8BLK9ucQPBkGonksoBc6x2TICCnXZDJ45bGC3dsxokEiaMLivYSTRX5GE
 J+4uYRqxu1lO9JYZ+js1dygIgSCp7E0c/29GvnUbf0dOLw8c=
X-Google-Smtp-Source: AGHT+IFN6cCenHOTgCeQUsKMztGXpIJf1BUxGjvLzlMSZNTxOUVsFQSPTym1V7e0Yd7alZVE8lfc9A==
X-Received: by 2002:a17:90b:2891:b0:31e:8203:4b9d with SMTP id
 98e67ed59e1d1-32327b49c7fmr5034867a91.29.1755176294145; 
 Thu, 14 Aug 2025 05:58:14 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 04/85] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
Date: Thu, 14 Aug 2025 22:56:31 +1000
Message-ID: <20250814125752.164107-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
index 118659815f..326b5a73cf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1626,8 +1626,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
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
index 561bf2678e..a914e7e23c 100644
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


