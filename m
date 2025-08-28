Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E47CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau2-0003Js-DK; Thu, 28 Aug 2025 07:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratz-0003Gr-Bg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratv-0005fN-5Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so4645385e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380881; x=1756985681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M4pBND/JQTcCccX+raHz6psiQqmFDrMciZMnw68mDqI=;
 b=REl/iDF2jMslMdCKJQ5WMkfd+7ZKztwRD82Y91Z1g8bj1JriTK3HmJQd8jMWyOZ7rB
 mxjUd1T1CxzZQIkx83zA0igVGVZ410tqLkjZ2ZHvIGBvqYE8H6105TnOEvL2q3Ksu6vm
 vBdcR9EWzfm9T3TUuKMQHapENYWTB8vVk5uPQ46aXXQ4i0qqORad9vS+eysfmo3Zx48A
 svmyiyNJUR5B0ieZq/jJ/cHjUb7X5EXCR7LRuy1dgKM0KFIJM4WN9QN2rHKcj78ROu+N
 iYWu+Zfda69CC9a4X6v9XDf5Aww8oWrTKEYjXkIWN5+LKiFD1l4uM0Z7QcQlmhSBGjyw
 0qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380881; x=1756985681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4pBND/JQTcCccX+raHz6psiQqmFDrMciZMnw68mDqI=;
 b=w370jZ0pe+xtqyHiPOBYowmXrMSVHXch+ciP5DNA/8vORo8UVQTstzUjCzF2HIRwHV
 ldzgCiZNpjyM0zyuderJ6V9wuTBsu1G0e5bdlq8YORG/CSIe1Kv1tDdULSsOH/MUUT4l
 dPOKl0YI++0PhoZ0/9Z+mkWtf4tXIkrGpxWp9oJx/kPYo4e7LqkPu2Cxw+0bDwRWBaD7
 BctjJjYh0h70xnyjoUjH0Hu1YoP01z/CF4aW7dzGn8ylU9WGYUgWGcS4MMeBQv/4sEZh
 yqfeOUmwnX2DVtFJB1XfVPhh9CMomSQeeaC5ez9Q0d42d7S8bl3ddzgGIO6N/eU9xrM2
 uOrg==
X-Gm-Message-State: AOJu0YwAwr3iDtVwQURDmPzUDNtbGyFrxTtKPnmePW6zBkuK3sVWu3ck
 fQJCw71nuA8GbMqAaj6uzfD0+9yzipy3PqZyv+2xuY6RqLJFg5Ko5rsHSCbuUjIGysVZEP2DDLp
 WUiLW
X-Gm-Gg: ASbGncvyaXmGPoy4ZzDaAOCV/kPntNhBSFcXFSPlOLbk3AZIxAn6Z55RMqGCPn3gLQV
 pA0eFUGiXzjcsKITU1c6a58LIz9TjXkufaYt21kYQeCXlfAO/7SdZyUV91M5eQfZnBLZXf5ul+T
 vp0Y5cCICt0dS0W+uEb3KGfWHmO8BckidtwxVs0pRRBh348SQrD0YZ2/9txA8SjtGrTEG9fGvYX
 8RUuVYd6GpTT8184lpxSlm8+GfZP68Pf1hNLoQ85768Z6IInH5C+YAnAVJZ6yJbuwdTV1KaNN0a
 kWK7hNrROqjhpGR/adPz+xsRkwKPRZSBxQU0T1mR8DJwO1UF+fQ+ZDhLiDPw/Wu8Esb7OKDztYK
 6V92SHH72bRL8AFpb+2ggir6IKX5UlrOTSRlokJM=
X-Google-Smtp-Source: AGHT+IEdz0Exd+tkPMLH2LsoXlF4kG4ph21pBUUVCxtfqqVsAifWP67pZKynIer5qdJZhvL0+R5acQ==
X-Received: by 2002:a05:600c:5247:b0:45b:7580:6f46 with SMTP id
 5b1f17b1804b1-45b75807d2fmr31059455e9.20.1756380881316; 
 Thu, 28 Aug 2025 04:34:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Date: Thu, 28 Aug 2025 12:34:04 +0100
Message-ID: <20250828113430.3214314-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Smail AIDER <smail.aider@huawei.com>

Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
accesses to the PMCR register to EL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Smail AIDER <smail.aider@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250811112143.1577055-2-smail.aider@huawei.com
Message-Id: <20250722131925.2119169-1-smail.aider@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs-pmu.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 9c4431c18ba..31c01eddc87 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -228,22 +228,27 @@ static bool event_supported(uint16_t number)
     return supported_event_map[number] != UNSUPPORTED_EVENT;
 }
 
-static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   bool isread)
+static CPAccessResult do_pmreg_access(CPUARMState *env, bool is_pmcr)
 {
     /*
      * Performance monitor registers user accessibility is controlled
-     * by PMUSERENR. MDCR_EL2.TPM and MDCR_EL3.TPM allow configurable
+     * by PMUSERENR. MDCR_EL2.TPM/TPMCR and MDCR_EL3.TPM allow configurable
      * trapping to EL2 or EL3 for other accesses.
      */
     int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
 
     if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
         return CP_ACCESS_TRAP_EL1;
     }
-    if (el < 2 && (mdcr_el2 & MDCR_TPM)) {
-        return CP_ACCESS_TRAP_EL2;
+    if (el < 2) {
+        uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
+
+        if (mdcr_el2 & MDCR_TPM) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        if (is_pmcr && (mdcr_el2 & MDCR_TPMCR)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TPM)) {
         return CP_ACCESS_TRAP_EL3;
@@ -252,6 +257,19 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    return do_pmreg_access(env, false);
+}
+
+static CPAccessResult pmreg_access_pmcr(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    return do_pmreg_access(env, true);
+}
+
 static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
                                            const ARMCPRegInfo *ri,
                                            bool isread)
@@ -1187,14 +1205,14 @@ void define_pm_cpregs(ARMCPU *cpu)
             .fgt = FGT_PMCR_EL0,
             .type = ARM_CP_IO | ARM_CP_ALIAS,
             .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-            .accessfn = pmreg_access,
+            .accessfn = pmreg_access_pmcr,
             .readfn = pmcr_read, .raw_readfn = raw_read,
             .writefn = pmcr_write, .raw_writefn = raw_write,
         };
         const ARMCPRegInfo pmcr64 = {
             .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
             .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
-            .access = PL0_RW, .accessfn = pmreg_access,
+            .access = PL0_RW, .accessfn = pmreg_access_pmcr,
             .fgt = FGT_PMCR_EL0,
             .type = ARM_CP_IO,
             .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-- 
2.43.0


