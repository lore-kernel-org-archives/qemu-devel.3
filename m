Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDFCFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6ft-0002KF-Ei; Sat, 05 Oct 2024 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fd-00028Z-Rj
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fb-0002Pr-3b
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-207115e3056so28290475ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141969; x=1728746769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB3S/z+Tf/YurYPbjZAkQ2iOmy2pkllXkguo9aONGm0=;
 b=OtTQd1cdWPLuugQ5KG+BA0nlxRGl2kTb7ZBDToC5K+jfsnGgnMHovf332GqIFgnEDC
 RcPxcxk3tDjW7MImV2NdgrPlGUz5tBwqsOH+xlde72GeT9XHVgNj6f4sfC/Bvld6lMlB
 oLD3ymtbwEc3ba4Ipt4Jx6eW515SwyZiCCK7Hj08CzR+6mKUrMP3bIbrC6IP7rRPjox8
 1cMmpzmuY047u8PMfMA/Ds8RknVwrEiGmAFkV/NodaV4f86Es19IpNeJ15jxNudoCn1j
 Z4jRcatJLO0x7TMAmQW2E5BloR7uFvo/vhxv94M7ZYeNKcuU6itZFcMtVNgfFUlIJAiK
 tHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141969; x=1728746769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oB3S/z+Tf/YurYPbjZAkQ2iOmy2pkllXkguo9aONGm0=;
 b=RvrqLV+AsUY0BwTTpgr9fC29fyRwF6sSr0itYBWgZNNwb6+Bxw+6JTJIYeOkVyD4FR
 kf5DPlELoJT63O6NQoUb4OJwuof2XT/QlGKlcnYRzcMdM80bhpbUaA6scEPtjm43RSKR
 pNM0iXmkrvcS89Se7iuMjJ6zihjNEaLmJfJaA7HGV00hzDkhrXeDxbF4IRVDBTkffi6s
 bKfN2m/tSSv3qNcEOiQfPtMiAvX0dax1e1FZO89og8LcxOWz9jLD7Y0ArKRj+aE9mJOh
 PjmPfcDm8qpVfwlAfhBNnIt4s+0Qdfct3719tD6dL5Y5buHa7Nr+/PfFrAJBiiNwT5RE
 JY0Q==
X-Gm-Message-State: AOJu0Yw+hE3UkOtec9OJqDkNhtnBxVyrfdXnHpOl1SkOvEmOdJcKE7UY
 Jbc6IgP3EQZE2k0EYvaiqququjXzTiTG1J20fnoSMWvFdVZsrMSwsEtWQXA8gBslsWmYL9ho5A1
 E
X-Google-Smtp-Source: AGHT+IHGjDyFhoX1JFcZLwPMzIWk0VZ6VyK/OgPBEe0dpV3tD5qpqz+OhbMKSWs06HyBvYG2qhd0Ew==
X-Received: by 2002:a17:903:2343:b0:20b:8924:3a77 with SMTP id
 d9443c01a7336-20bfe071396mr82155675ad.26.1728141969294; 
 Sat, 05 Oct 2024 08:26:09 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 17/20] target/arm: Pass MemOp through get_phys_addr_twostage
Date: Sat,  5 Oct 2024 08:25:48 -0700
Message-ID: <20241005152551.307923-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Pass memop through get_phys_addr_twostage with its
recursion with get_phys_addr_nogpc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0445c3ccf3..f1fca086a4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3301,7 +3301,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
                                    vaddr address,
-                                   MMUAccessType access_type,
+                                   MMUAccessType access_type, MemOp memop,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
 {
@@ -3313,7 +3313,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
 
-    ret = get_phys_addr_nogpc(env, ptw, address, access_type, 0, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, address, access_type,
+                              memop, result, fi);
 
     /* If S1 fails, return early.  */
     if (ret) {
@@ -3339,7 +3340,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
-    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type, 0, result, fi);
+    ret = get_phys_addr_nogpc(env, ptw, ipa, access_type,
+                              memop, result, fi);
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
@@ -3469,7 +3471,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
             return get_phys_addr_twostage(env, ptw, address, access_type,
-                                          result, fi);
+                                          memop, result, fi);
         }
         /* fall through */
 
-- 
2.43.0


