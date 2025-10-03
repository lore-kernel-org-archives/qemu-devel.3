Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B7BCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jIY-0002fH-AD; Fri, 03 Oct 2025 13:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIB-0002Nv-TL
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:06 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGl-0006JK-9m
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso1969826a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511307; x=1760116107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePluHC0H/NP5Mr3iGwvDk85qezCPg64S4ISl6e9Zi/A=;
 b=IEBV7ex2uwp9J+ofhnB9QbQQkXzSmYQ7aXiDCmvEpz2/RClNxzkGIfS1RM+gl/hUkK
 aZFRulz9rTFMpAhH+r2+rO8TnarYvNPVXasdMKk12x/1kGolM44gGFk5cehhnsn8IDXs
 jzXpRPYxhTTtjdi8HcaHSYDrVPE16ZOXonpW7PE0/t9D7pgREG1MgfZDv30s2NDBJbqJ
 l/tAZH6rfB39QmbmHyHEtVZKbGzauwaPdGkofajuSrADZgpi2LQlz5Xzso4MfX2JDS4Q
 SsaqJEIbdat5TtgTqPv21fiyhuFD7aMX00qiqz4Whkk/WBut+UuWip9xHgHx4pbt/ajn
 9tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511307; x=1760116107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePluHC0H/NP5Mr3iGwvDk85qezCPg64S4ISl6e9Zi/A=;
 b=XNl7mWx/gGOQg75J2uHZpmYzk+2dE6ozHFXMNNRjlbuW0rZq5/hdCsyfBc8R6hvy99
 1QGRqiZSPxv9MHhPMMnDcXFCKbPVwfAiOhMvFvIr2t4qepCCE/wsBGh5OANfgJNucGtH
 UOZ4UbjTnqexy2ZeeRiTNg1Ledp12DEK/EmshoRi0lh+Pn1tyWqWnIS+pGtufLiu4lwQ
 uUOzzzF+eErW3rOuWoDe1PWUbd3xrtqveyPFnUytkAAjJI6HtTDxc55sTScNxtAEvp+3
 6veH29awcd/WLaPSZQm1knUdn4AsAsVxrRzjGFlHSnRLEr1tlyLKQFx9vzcpfPJjF87y
 XRzg==
X-Gm-Message-State: AOJu0YxU4EX2ygXdcezkgTOkhiUZbvmFVoU4rSBSNPEzK+JRRUv9vJb9
 ijGz7dMZ8zGBcgdAr+M4H7TOWeB2SlBhQb8r8qfODWvcI+eN1XMnJv4ABgHyBcxY/gfhtuJcrSb
 w8RR1OQU=
X-Gm-Gg: ASbGncuBlsF+2kVo6tKDOwJKRoQ7Hhq7VQZLes+GDCLOiwfyUHrezFfLNq+QuEMjkcU
 DiEaXQj4fQfahzR6590uOb3RtwouAtz3tfrH3W66KHuknqVO7ed59viMECRu34hYr4BBGWVWWJx
 1Oozj5puAFZix2iGzOpohXxlkHdU1bPXTFvHxQpmNqGyuJVYGX/KhJiJvuNkpq5njaWSI3SzGq6
 kOanxHiIlPPuGNTvzUg+QojBIDrwm6aAY5p61+608umKnmQqwanoCHktDrRSaw3SAZ1ukzlJZYX
 S3MjB8sSwSv768f+jlf+7xrOI91rDyQTbcSYF0qF0pJJYwsWPi8VNQl33LdZZ7MDEVF/4GcOJf0
 8oIuNq6m/wg9FmAZnose/31G20zOq3udxfYPXd6tzZM8Pbh79+sUHiiuk
X-Google-Smtp-Source: AGHT+IEFMLsMp34swcTZi4Seywg3BQN7qAjDY75WsEdsxXxhyiByIK85Yx9O+KVNBnQHljrxY/N66A==
X-Received: by 2002:a17:903:2f0e:b0:269:a75f:e9d5 with SMTP id
 d9443c01a7336-28e9a6486b0mr49029065ad.42.1759511307564; 
 Fri, 03 Oct 2025 10:08:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 29/73] target/arm: Support page protections for GCS mmu
 indexes
Date: Fri,  3 Oct 2025 10:07:16 -0700
Message-ID: <20251003170800.997167-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 16ca2b6187..bfa0aeb4c0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1583,12 +1583,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
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
 
@@ -2241,6 +2245,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


