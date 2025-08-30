Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5828FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOCZ-00027K-EO; Sat, 30 Aug 2025 12:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQJ-0007B7-4W
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:47 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQH-0004ox-4M
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2445805aa2eso29798005ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532804; x=1757137604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlZEvW/doqzO9xqWDxfXmugnbOqvwtxVDwPmklV4QPY=;
 b=LrDdUnjftbIyG32LtzYMrqn6G8bcfaQpO5cpYlXqx186WZo6hJCQzWzV69LRFYVNli
 sged6nwmDAl7D9Z0Xa7h5Vz3HJ1zy3ICJqMslf9d9VH9bzailsdysbFJK5rNJefucgGa
 1rH2h0Wj6ni6cEn0bTDVpoBYcOsQs6WxeUhQZOz4EYCoEYWhAonqqO+qWjytEntfr9YL
 2TpkcIDR8t+RAL27rO5RpYw19TXqTEhB9BEyLpeW1hXlP+gaB88hDso8hyuKMar3GI2Y
 1Rs9ctRFnzeRHFkPUmXCDXY5UDOeapDWrF6W6cqZX5RMhiETWWrqJoRX1T6p7E1HFO7h
 d5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532804; x=1757137604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlZEvW/doqzO9xqWDxfXmugnbOqvwtxVDwPmklV4QPY=;
 b=SdNI0MZuul+aCQgBoJGXGv9x4sTtEf+RuwGnJ/seLdwJIvdR8qvzwFec5x2M3/ZNhJ
 ByyDMz0EgR3caUcNgRk8zLiSfzkADX7a99Us7B4EKFvFk1Bulku85O00zh+scjBLqiMS
 pRB0K8gFz3DQXUSTJVMx6L5nACRROhH7ACCtvjYToO2y6DQb/mbEg1f3Frv/+lvBeOsY
 DxvXN5TczECGvd3LALIg3x3uzpo7mJqOCPlGEiumzr7yDAZFLEmjm/TH5mippfj6T3Lm
 aAuXuqKV6IOSTj1ozvhmvzVNq/da6vIY1J0rbGWZPqLYkWGNfJYBzguHsoLvqhLca4oX
 ofOQ==
X-Gm-Message-State: AOJu0YyHWjBXPqd+rIXOcDOzAvrg+ZaVplfaoQ2Mhgj2OpOoMS1IZTGf
 useTjM+kP3fmIXGTwYEw6xmDocedh8QoE6b0T0Bh2UfFuMHYz85H4/9e38CmRDvVCg3nMscE4wE
 bOWopM5Q=
X-Gm-Gg: ASbGncukv0w3yo27OYML5BKPlitOImkxSRd2XwjZoRcWrOgY60Qx0m1nWM/+uUMMeyj
 uI2UqFi15ofM8aJnyoVb77aquRjH/ZbZwuwtHl2SX3JJcUgelD1K4ijDog20iNw4RRJd/XOFrBX
 zwKgyB/Y0xAe5x35kYYicfbi+rCPc6rETlpcmXiTo7vzVuQWY/inH420AKwOwaGVqQVPPf/21sO
 siftIX2ZJk18paO4/zZOx55/hKVnxIEWaVJkBNsC0T5FuLg5SpTCssgkUc6K8jnAuUP8/xa0/Ro
 3ww1oXNcM0/i7jmFrOHOAomSqmn/S+2gP11Ddzh8virDJdhvmEiunrEUFSGc2AuSPS5efZufsYB
 VTvQc2gwUQ26g//5Fm4r1yILvx8areGiXR8P2zPd7IR+WhKsyVVDf5tBJt2GQoBGnWAPKMQl65g
 ==
X-Google-Smtp-Source: AGHT+IGBDunypJcA4WSE9leAfjgFS8ErG+yv+2Q1YKLFKsGAMMjqD0WVuETxwJ/TCYB9CGQg5R1mgw==
X-Received: by 2002:a17:902:ce8c:b0:249:3eec:15bb with SMTP id
 d9443c01a7336-249448e1ce7mr12667545ad.14.1756532803656; 
 Fri, 29 Aug 2025 22:46:43 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 45/84] target/arm: Support page protections for GCS mmu
 indexes
Date: Sat, 30 Aug 2025 15:40:49 +1000
Message-ID: <20250830054128.448363-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ccdf9076c3..62aaf0f792 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1584,12 +1584,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2236,6 +2240,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0


