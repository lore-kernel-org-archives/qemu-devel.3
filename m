Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2EACD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9q-0006YV-94; Wed, 29 Apr 2026 20:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9b-0006O9-3q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9X-0006Gs-M2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-834f1075805so248784b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508474; x=1778113274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6A2mgR71x2gRQlZNLDb+phH7Gxy6pN9ynlj49DFnFXE=;
 b=gYTeefYMQ7kD+JynVQ12l0g27Q+9Zrr7/wY+dSH0RymeIfm1+wJr7f/r2Ccf25anrQ
 NtrPerAAV2jN7wGtJWDxAw+2X2OIfNeQAy3uBglsMbuNFMdVeO6JEd1iHqyDlE0Y/yY2
 zyXYjuErgBs97Zb9DWaf3ql2zH7Q95yI8KI4U66+22FYxKZl+kLM6dzxfeEZyDWosIz4
 JxpF9BM8doY9SpOoOBY9RZPQ67ofIqaRykvbH60IRPyZq+FKV2A1j1qxUmVnKWImBYMA
 IbJ2hQPieFn25FLD/Sbc9bruElrLmcwjixLj/rHN9oNTPUuRqCj+gSimi8pB5nsOgV6A
 mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508474; x=1778113274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6A2mgR71x2gRQlZNLDb+phH7Gxy6pN9ynlj49DFnFXE=;
 b=nVmbwjtwhUyh0Zg6bTf+nLwBc5AOwBSkSuBnul8YgJCiPaV9vEYkd1HtEwywwcPyU2
 oHzzJIW5LjI64RKhsSV0R0O1N+477FmGSdLDTOqApdXR1wwxEGzjPjE1NPFf4XPABGhX
 ED501wzKCJwJS7DpB2udpQedlzTSvK/o2kxeUbEiFk1WzDZTqm/v+CS99GmIYNKrQcIF
 oRgotbwVeNU0RTKouZnc9tmH+DqA6ClzaNlPJOrb0t1POrQOTTZP5X8XqmDrF9n0/na9
 DwpTZ0gAy9X1g1a+LGbAa0IObG1WaNXXOOUvwXfigDT91BHzS7dEo7nZsnvNqMOnQZjJ
 lGwA==
X-Gm-Message-State: AOJu0YxumXyZjHKFOu1MYJneDCTpgkVUYD7MtnTOWMieCxKwk3zpAR5Y
 IDPf0K9VzUkBQEe4zyk0PBImtmvWD879BJoNdr7gUmeCOO5Z4Lzd13YrF8RJ1+MJEWSigMwqe67
 byeaTHo8=
X-Gm-Gg: AeBDieviCXkp8OqFFb7/f6LQEvNacbuWvaOytJi09jdVZVsYwjhER91EHkNaz5L88Rx
 xfN0XYEuOqNHvACC/vl2nrAmIO7EazCxH8+KM5IR9PdzKZoRnHRF+mxh8ywLJQ8YFsCTJ3nQU1m
 +xgke8x+6N8HN9rlYVEZ28AVaMmipDYJWpa7kw6D8p5D3I0slJZuv9uF4ycM0xHpaBRYxP+T9uU
 QaZCnwGYgBQj0vMmxtGXsAgLYcQmQZx1853wDjiaUS2+xcV11e+LTwxrYV3eKuY5sc6QXqqrNJa
 1NbmnhvNdrg4SWxEsf7CANMFCBOELbvZbrf4W3cUEl8LV6WMKeitJ42uRuM9LFoR9cQh0dQ5BAB
 NGfvb1/YYFqaCLF6kroc2rdxRyH30C87auicjEO1Kpk7lwxDCl1ceQvIvUxNUxGliLRwwIWgX8Y
 v+D6cOrLhBe0L0XDGeWKNm0UWtiuKJVSBHqlPbr5eVCyty2AJ2Ars=
X-Received: by 2002:a05:6a00:4b13:b0:82c:dfea:9e2a with SMTP id
 d2e1a72fcca58-834fdb0a1fbmr910795b3a.2.1777508474364; 
 Wed, 29 Apr 2026 17:21:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 10/47] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Thu, 30 Apr 2026 10:20:09 +1000
Message-ID: <20260430002046.59739-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 304db1a479..7a17fd39e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            valid_mask |= SCR_ENFPM;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -3953,6 +3956,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_gcs, cpu)) {
         valid_mask |= HCRX_GCSEN;
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        valid_mask |= HCRX_ENFPM;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4026,6 +4032,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             hcrx |= HCRX_GCSEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            hcrx |= HCRX_ENFPM;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
-- 
2.43.0


