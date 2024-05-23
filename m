Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62F8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHa2-0004oO-LK; Thu, 23 May 2024 19:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZl-00037x-3K; Thu, 23 May 2024 19:10:21 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZc-00065E-Qj; Thu, 23 May 2024 19:10:20 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3737b27dc95so1569135ab.0; 
 Thu, 23 May 2024 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505810; x=1717110610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwUtarmCOIlit6nKCVmwVsEWWjZXwUEGtfIuJDu/51c=;
 b=O6wDGnPuVQj6sYXRp7pr6Wuy6r7IIpq6uSTdNGi4Rm9BRkwBp8CqRvzBpJ7eoYsoR0
 hC/bO1/hBjASDS2RK+ym0MpzZFmicciGMqWKV6WCxK9FzWb9rAzP1lharbi1b2zKO9yH
 qyt2erDb+PDlyo+lO3f6pwi8dG+woHwH2VBMfGnMuT7R2resJA0Jkz6WAa7PVJMmPIZd
 5G6SmxgBYjPkfHfF798RnYlFKJC3h7EVAGhgrkZG4I4eENL4xkZceFV0S0AC8H+0t2a9
 RhGPwFMISHHBlSNFBkicfw2lJi9mLiiluX2EAyax/66ePp1qgboixTGYtmzm3iaM0fJP
 zZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505810; x=1717110610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwUtarmCOIlit6nKCVmwVsEWWjZXwUEGtfIuJDu/51c=;
 b=AnVulkdYjefVq5HKtyPHib5aYNbH9dkVhUigoY6DE7gB3JGoQCblF63tduYc60O7rd
 7BLR9tF3jgXtrrBWMirEpOwOmCDLRX+rWgh9OWOm19a6NTpmNCSLnz1bcI85Awid1NF8
 rzltwYcT5KsPXmCyWFxx25O+rjvik1LHcdy8dVj//gX5ee/yycY1ar0ayo97NR8M68gu
 EHBhGWlOnpCf0Vv8/K3n9ryfcPcOSpZIQfRY7eIen6crMDi0hbtKHRiX0aWRw53mJINq
 uOw/SJa5NoGrykDtJIkEflD8ZPxIgjVPoUQi6wOPscUd0jS58FN4ceAvB61kaUPLrDeD
 swPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgiWWYq03+q6nE6vMk84DjZULs4ieMQ0Nk8WDgH2Ldk6j82UmvL3QuuIIaeFmLBh8470EukAWurCgjpdnP5FrWBXL/
X-Gm-Message-State: AOJu0YzDj/pGxrMrGrocQq58CfZ/+k3JhHfAHmim8uFpLicmiiDhNBRh
 nNRztJhC/yP8E2kA2i9Nr3d+REp+T778TiYBvPSHFY5qWGcNuwjRx8ef4Q==
X-Google-Smtp-Source: AGHT+IFbpxA8zOzxHC6/1m+Vr5PakA295xwdeklWi7oJqXu66cQx6GVCs1RyPyIYlwWCxauVTA1eiA==
X-Received: by 2002:a05:6e02:1c88:b0:36c:5228:446 with SMTP id
 e9e14a558f8ab-3737b31e13amr9395835ab.26.1716505810557; 
 Thu, 23 May 2024 16:10:10 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 43/72] target/ppc/mmu_common.c: Simplify checking for real mode
Date: Fri, 24 May 2024 09:07:16 +1000
Message-ID: <20240523230747.45703-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

In get_physical_address_wtlb() the real_mode flag depends on either
the MSR[IR] or MSR[DR] bit depending on access_type. Extract just the
needed bit in a more straight forward way instead of doing unnecessary
computation.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 09cbeb0052..886fb6a657 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1184,8 +1184,10 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      int mmu_idx)
 {
     int ret = -1;
-    bool real_mode = (type == ACCESS_CODE && !FIELD_EX64(env->msr, MSR, IR)) ||
-                     (type != ACCESS_CODE && !FIELD_EX64(env->msr, MSR, DR));
+    bool real_mode;
+
+    real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
+                                      : !FIELD_EX64(env->msr, MSR, DR);
 
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
-- 
2.43.0


