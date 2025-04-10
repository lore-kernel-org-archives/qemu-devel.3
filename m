Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEBBC369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2z0t-0005yc-RM; Thu, 10 Apr 2025 17:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0r-0005x9-DO
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0o-0001l7-R9
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso1102742b3a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744318837; x=1744923637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3O+ATcLarMi7TZZVeImu0PwvfcFGKqqf7QjA5Mk9PLE=;
 b=CGIxL26AA10ZS4wXmRj5Z150a1ynIzeTelyFyJQgdj8hvo6OIgsFiaJhPijSCQ/rXE
 QUdWhmsLmMeRRU/1M5Wof9Aqg+Vawn26kusVLQY2fSv/6gulf7c7Im4b2T2/Ga+Asqzy
 T3tLSKFHSv45wxDJRUuITTbpN9tndBbUnUXcx1JtWN9bFtPSuqcA7QG4VjeflwVC0dB/
 /T6KKzLpNZU/EQJH66PWxV3iseXFBzog8PUrNmY62x47LTmZOdsJtwQoiEYD5F/Co2s4
 oyE6KzoJIfjM9QGAwh6i+9ZGmvuJCak6WHY75Y1Z7jES2+xNbw9cr1FEkK9M32aidode
 HP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744318837; x=1744923637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3O+ATcLarMi7TZZVeImu0PwvfcFGKqqf7QjA5Mk9PLE=;
 b=g1LFCdjiqA5yLNjkEL2JUcAdFcpocNmVyMvVS7Qyn5T6OuD6Q3AvIMyedVYuazKZSv
 nMJRuFRllP/CXRMTf9I+4ZyC3h52ksXCYjyVKjrzCqFC3SJ8MAeFxWVhy0zygu3aBidx
 XF0SK8oIy+u+9xDiK+J3a0wmmarnCZpAY/S26AgScYh6RUDxd2ttA+hvPt4YZKO4NlRX
 PfGGUF+g7bPNGcDUqXjwyRjExr6e+ibTjDI0gfKTDoDYCSoc9ozra6IttH++TTO1sBgT
 KqwN/1njh4nlW/3wEEBMgQZQrrzhFwobNTYNUrg58zwjm5E42QIUjEjuh4FAxM9HBg+a
 +83A==
X-Gm-Message-State: AOJu0Yzcpgp3PM/ozGlJ6XRNn0cVkz720RmPgzJjei9OKZKQo+J88Fc1
 ZymZTusnfGBk4JP0boJLKYfA2wVm5KPK99YDSj906i9nIJmJ6JgfZDP3ZYUpPGjd9Y8IWwzrqgv
 g
X-Gm-Gg: ASbGncuIxQCBFqsWOWaaBf14iPSe+tbmWzWWFLTsIumqMDjww+3ttgf4XV2GG6hsuMS
 xV7fgLcZmuqZ4YDXNiwt4+vJmLDaz9MeFL2WL8pE2TdsaVBKwmPrSpNpxgVX849mHUtMVYbyZNx
 K6A1qSZYURAHZGFD3sb3ZJXYOzmbAOuW/JABY+I4I7SQTs78RZ1pD25jDDPc7MDsjg3s8yQ8S/E
 8v5nLhBWF9QuOGXVAdGEw6oSTDog+1zuPvK9CH8zl/RWAEZ8YCfj0kgIkxpwDpLQVklNdcWa2M9
 iJpjc+NpWkqhL3/edpjlj2XRWix+a+Jo3GoUBOPa
X-Google-Smtp-Source: AGHT+IHYmNsR4rzKKdqHaVRrwg0X9ECfGeohZSUpsRRprGst6uEADC8CnJXXG71yiK/pVkD2wl2tgA==
X-Received: by 2002:a05:6a00:4644:b0:736:9e40:13b1 with SMTP id
 d2e1a72fcca58-73bd12b1315mr371116b3a.23.1744318836380; 
 Thu, 10 Apr 2025 14:00:36 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82a3sm12431b3a.90.2025.04.10.14.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 14:00:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/4] target/arm/ptw: extract arm_mmu_idx_to_security_space
Date: Thu, 10 Apr 2025 14:00:19 -0700
Message-Id: <20250410210022.809905-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

We'll reuse this function later.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8d4e9e07a94..5e196cfa955 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3550,13 +3550,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                memop, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, vaddr address,
-                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
-                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+static ARMSecuritySpace arm_mmu_idx_to_security_space
+(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    S1Translate ptw = {
-        .in_mmu_idx = mmu_idx,
-    };
     ARMSecuritySpace ss;
 
     switch (mmu_idx) {
@@ -3617,7 +3613,18 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         g_assert_not_reached();
     }
 
-    ptw.in_space = ss;
+    return ss;
+}
+
+bool get_phys_addr(CPUARMState *env, vaddr address,
+                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
+                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
+{
+    S1Translate ptw = {
+        .in_mmu_idx = mmu_idx,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
+    };
+
     return get_phys_addr_gpc(env, &ptw, address, access_type,
                              memop, result, fi);
 }
-- 
2.39.5


