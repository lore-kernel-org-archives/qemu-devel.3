Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCF7C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3tT-0002sr-8D; Mon, 03 Mar 2025 06:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tR-0002qi-JA; Mon, 03 Mar 2025 06:23:29 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tQ-00076t-4L; Mon, 03 Mar 2025 06:23:29 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2239aa5da08so18866465ad.3; 
 Mon, 03 Mar 2025 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741001006; x=1741605806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cu9dJddBsSRtdsBzKn6C+oUO9t7UsRoDwTthYYeOMK4=;
 b=BZQsabt0Z1LDOAThPP8CxjmYm373dpzxbDkWjHWUm86egTn4wk866I2yGF1V9fbZTy
 nIwBMwIpenasrYkEUMpRVnS0geZ2k4Le+q0XvfeyWz/BvLaPYG6H5jkhpPGxyPWeqHhZ
 Wyol5K5hcllX0JziIGJKDLgETJeNMnfGkkdJRhc3J6Zhfl/FJ47LVpVrOmIQKpfx5sl7
 y+vkb/IsIIENO6EiMgryfbXez4JRlhBPclvlGCcf9xuprwcDCup73QYLCaCKe7le+wha
 8Omvau9ulKwdX23f02KF5+snaaXH2yKjYe7jr5McLE5lY1YEfchz3CS/fC6evKP7L2nc
 0fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001006; x=1741605806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu9dJddBsSRtdsBzKn6C+oUO9t7UsRoDwTthYYeOMK4=;
 b=TV+1jDv5iVLx3nfM2qVXIHvlRttFY/bua9Wer6vcUOgmvXv+aJiOdb27x677CMdpXt
 jg9UYPAB71Pz8l1G2wMepzNY0zXHmcZw/tNf95Q3r8y4dLL4C1G1MF6FhZjgjXqotePe
 dfeSbl92NtimDwQW/BeSf7KnMzD/w5nor++hLVJPVIIv7A4uJc76SMC9n8yWYt0WthVy
 E3LkFdBGe+7sSqCCIfz79ncumkoGfN/dn4wBlL9aKMwCmBSdG3bm74lOF6VaFDfsi0pZ
 WasULatcJD36RBcCa3yC/FKs1agSWBOtxTqjeYgoHxAOO+4MydH7XbynRRMSuS8k+vNU
 2NEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAGJ5b2Gf5d5/jD69REUv0bdQxg/Q2SvTmFKkwKXpJ0s+GMuetQt1bwDSk7gClFqlVgsriBuLfS6d8@nongnu.org
X-Gm-Message-State: AOJu0YzJTLNdpCpIXY0E3EcGX/NX7UuTBsew8FSZTibPbvT1A7UnpbXI
 5HpGqxlk7fLgcUVCv3ov2es8KbTdUv4VtPsnkqSG2ZvE3CdHV5RCSl9dWA==
X-Gm-Gg: ASbGncsG+HVjqCJauPf1hqePlEVAhVDpF36CpB3ENIVNSAyUeCf8T4gpAu2+KHQqf1O
 1Cg1Z24K9ztXCLz7pXxjbHobDh+klyqasJJeMPtdYEgO/PMSG1xWp9t0QH31LApRxrb21VhFqkZ
 uTFJAoqr4z7Ydb3N5Gp5ZXJDihJkeoswx2LBd9DBv+ZfNX59CM1kRL3f7Vr9+cO0CB2miL1Vjwg
 9qYynbcOnG3RrWQ9m4IAEuJqW88ITggtMrIXvmRV43ssC625xe1gLcUznk7JiTWZxsRpKlTl4xZ
 8d1wWMIaPjVitE4Y57bCSfu5maqR8wKQjDRrLtI3y09GMIi/M/E=
X-Google-Smtp-Source: AGHT+IE0crRjB9HRFCalYWm1hjJO/xP7QWgt9BkE2vA+IItaNHeWguQc+99MOYmRxi7OZHcKsNQeyQ==
X-Received: by 2002:a17:903:18a:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-22368f6dc74mr226818155ad.10.1741001006109; 
 Mon, 03 Mar 2025 03:23:26 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e3bsm75388875ad.82.2025.03.03.03.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 03:23:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/ppc: Avoid work if MMU SPRs are written with same
 value
Date: Mon,  3 Mar 2025 21:23:13 +1000
Message-ID: <20250303112315.586478-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303112315.586478-1-npiggin@gmail.com>
References: <20250303112315.586478-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Avoid TLB flushing and hflags recomputation if LPCR, LPIDR, or PIDR
are written with the same value. This is observed to happen in some
cases (e.g., in hypervisor real-mode exit fastpath handlers).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.c         |  8 +++++++-
 target/ppc/misc_helper.c | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index cdd50cb36d6..0fa2ccfcb2f 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -97,8 +97,14 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
+    target_ulong old, new;
 
-    env->spr[SPR_LPCR] = val & pcc->lpcr_mask;
+    old = env->spr[SPR_LPCR];
+    new = val & pcc->lpcr_mask;
+    if (old == new) {
+        return;
+    }
+    env->spr[SPR_LPCR] = new;
     /* The gtse bit affects hflags */
     hreg_compute_hflags(env);
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 179e8b6b4d2..ac439e00326 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -403,12 +403,24 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
 {
+    if (env->spr[SPR_BOOKS_PID] == (uint32_t)val) {
+        return;
+    }
+
     env->spr[SPR_BOOKS_PID] = (uint32_t)val;
-    tlb_flush(env_cpu(env));
+
+    if (env->spr[SPR_LPCR] & LPCR_HR) {
+        /* PID is only relevant to CPU translations when LPCR[HR]=1 */
+        tlb_flush(env_cpu(env));
+    }
 }
 
 void helper_store_lpidr(CPUPPCState *env, target_ulong val)
 {
+    if (env->spr[SPR_LPIDR] == (uint32_t)val) {
+        return;
+    }
+
     env->spr[SPR_LPIDR] = (uint32_t)val;
 
     /*
-- 
2.47.1


