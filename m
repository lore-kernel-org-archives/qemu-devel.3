Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0740CCFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2d-0006MS-F6; Sat, 05 Oct 2024 16:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2b-0006L7-PA
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2a-0001lH-9G
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b64584fd4so31622195ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158771; x=1728763571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=posPbKSzdb+ffX+WhfgYFaW0pAyKjx4IZlbzVQLaTuc=;
 b=biJvJf7wos00Tvn/zBBXdRUSswBdCaY5G59gtRmKzqtoqmyi/75x5xDuQ/reIjDraG
 5YukJlEkeMUJjyFNehbPunAV1RZQby6xMwyp9t9wVHLjp0jfS8qV+en9TssXuWaINmS1
 xiFB+G3adOqO8UBdcw0g3gPsFBfD38jWpmJLRaaM6VDpUrFizVhGWvj881hH0sObx645
 b9i7XqC5WVMXgeDg+yp4XfrX6wrY5KuzH5ym7lA0PpuL4i5VT6sLK9ILo/zFVFxVQwiq
 AAIlkP8itVjoOxFutzZhWGTEa01wWcudDtnmvPbZdClHW6LhBs/wd5/7qffY5D/+CXIs
 IrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158771; x=1728763571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=posPbKSzdb+ffX+WhfgYFaW0pAyKjx4IZlbzVQLaTuc=;
 b=BliutfFt63tI+8O50l2bqm1M+RIbocdoXDHJTCkzrNDewyS9tvjI9puRO3gGgpYTgj
 PrWDB/ttmyL++iZgO1Thg+bVDPXCXWDZsXrSCsDZqPNNRJF7KvHwCL4DkO8rRxIeufhL
 sRa7PHOqu1HLE+JuTdb6r9M3EZYo0PJSe3/ZvWZcrVBUa/bng/nadey9k3Svy3Wb3zEi
 vX5R9eDdR/vh+xps+HOsG09DgoAAxNXIkFIPenWdftHUgkNBQ6PtCX0WcvhkgFAng55O
 208N77WbfMMe8fQ0eI2SkFsnysRtjsDse4wpwmg5B+Z/XMTKOlSiSnay0BFlPP73iTLw
 ibcQ==
X-Gm-Message-State: AOJu0YwjfcJb3MrsbLIYVW6fGM0rcAtVy2D/GzT3N8tXM/RChh8Dj7ye
 ae+aRMGnHyOPHANjvY4YJkbcGh9Mnj/fuqiJRYrMrFnCpvuzR0O9hA/hMCWQWW8xgS2V5PsCDzw
 +
X-Google-Smtp-Source: AGHT+IFkbH5I/ZaJe+I4v335+XuhQ/F/ef46EsJUG+t30A/nnryOiFz1aTLseUaZK0R77t/l8tl9fg==
X-Received: by 2002:a17:902:da91:b0:20b:7c00:5e50 with SMTP id
 d9443c01a7336-20bfe022a33mr98058335ad.12.1728158770895; 
 Sat, 05 Oct 2024 13:06:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 10/21] target/hppa: Fix priority of T, D, and B page faults
Date: Sat,  5 Oct 2024 13:05:49 -0700
Message-ID: <20241005200600.493604-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Drop the 'else' so that ret is overridden with the
highest priority fault.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f027c494e2..f71cedd7a9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -288,7 +288,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
     /*
-     * In priority order, check for conditions which raise faults.
+     * In reverse priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
      * so that the resulting PROT will force a re-check of the
      * architectural TLB entry for the next access.
@@ -299,13 +299,15 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             /* The T bit is set -- Page Reference Fault.  */
             ret = EXCP_PAGE_REF;
         }
-    } else if (!ent->d) {
+    }
+    if (unlikely(!ent->d)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /* The D bit is not set -- TLB Dirty Bit Fault.  */
             ret = EXCP_TLB_DIRTY;
         }
-    } else if (unlikely(ent->b)) {
+    }
+    if (unlikely(ent->b)) {
         prot &= PAGE_READ | PAGE_EXEC;
         if (type & PAGE_WRITE) {
             /*
-- 
2.43.0


