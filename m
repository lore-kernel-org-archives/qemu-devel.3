Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF2CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cAZ-0004St-PZ; Wed, 08 Oct 2025 17:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9y-0004EG-VB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:23 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c99-0006gh-Qw
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:22 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso208122a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960588; x=1760565388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9r+qjPCi/YxIE5NGkpLP7uv12jecqWEAb1ZemlLCdc=;
 b=CTlivMV9s+gyMg0jyHu7dGGRwuGQxiRQDR2qMGROy3FTKGZnfruP2guwQX6ZE6kjR9
 aNV8uw24pivBOWu5pNGuXFIrfTt8fsbaYRxjAr2u9J2gh0wKKp0QaSFyInnWrVGO2Yw2
 PqY3gMbynR1I1QM+keLszBNWOjML5F0/1AH8W7xrT5DoFKSSVuwVax4FcakmKV3JSv8J
 OshVjUXgUtO8kp0RX8snyOnD/9rAvOsHCrzr06QNCTYbemIv3+HuCJOOX1kyqdDoTJ+z
 1ff9k7givWQEPKFdOCT4zobEZfmJvJ1vIaaq54TNXOwWiUjhXV7HMGDHcWY9hG2fxrMf
 GU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960588; x=1760565388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9r+qjPCi/YxIE5NGkpLP7uv12jecqWEAb1ZemlLCdc=;
 b=XUrRXglkLTVlg3sUaR/skX45rhII3ti2rFS3EGbmzCfCtr18uxCWJmTpdl7Ub3CT9q
 0KVWPmhEsRDp4Y0aYZiPmFFngub4ZWejavh3hU7wSg67YB+DP8g0jXLUIQQva2Nu65/V
 3pp+e5gsLiPf8M/ZibvPFCl14F78J0tXu2icN8M79jAiEeAnejKNJjkzkj4vbh6x8gjf
 URnJEU0caYY+70/R7QlgPwTMJGM5dZ44w9ljk0/fjro1YU+4STYOfRo4WVnqJOnj+5dQ
 Dm1tXn+BHczILIzEcbXgrNMnmBtgaLENn39TL+qHGUH7d1Glvj2m5xtkQ3XgiZN/aqys
 w2xA==
X-Gm-Message-State: AOJu0YyPURl1x8U6WmImJYuH8pDyZD+bJ1ral7h9PKn2BqztG9nT3XVE
 70UoO1HiG9WCxbGFCp9SRiGuKb9wkzHrGNbG8RR8/9yxbmTbMMQJ8GtXxek6npqH+mfEuczd6jK
 7DbBOXDc=
X-Gm-Gg: ASbGncvqONGwyO00Oo+yTafdFINFuWJ4uzQvusH7loxavjUinEb0DlIHZKmNYoTZ7u+
 YJNTtfDCZ/NnL+u3Nx8iVe6wH7EjlzTXIt79SGd7GjObW5l6FQyAX2fPOc0uo6LwRVVU1QrEpgZ
 iYrHM/K+rLydiMxeVMIvmx5dBmmVjRrSNGP5qld1FPtIwjGHyMZhJEelgeH1gAr8DmmEw9LBdok
 CWf6faMnq8T7Uf3onfJMAd8f2Wo5FnHPjFtDNUOdsjGx1kb2iGzuluvXMA5Jl0s71Opro+CHA0T
 mJKTnoyd66RIfY5YTB5/Aua9AxjBrg8ogIEgMCHz2kpcBz2dV8xl2qBJssKowNpLF8ZhpCWrOJY
 6gbczWkzKP8h3Exbom0V26GntsJx1NKBbft7CiF7bg14bAIN0Rl+aVU1c
X-Google-Smtp-Source: AGHT+IGysLccaQiYOb/n9LJflb20NwTjxOMhCAkFTuNI5KHTx0HidwfDoOGM8P1gXeqkEpB/6LHPgQ==
X-Received: by 2002:a17:902:ccc4:b0:24c:e6fa:2a38 with SMTP id
 d9443c01a7336-2902739ad2emr63888965ad.25.1759960588514; 
 Wed, 08 Oct 2025 14:56:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 21/73] target/arm: Remove unused env argument from
 regime_is_pan
Date: Wed,  8 Oct 2025 14:55:21 -0700
Message-ID: <20251008215613.300150-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/ptw.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 061472a943..cb2ffeff59 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,7 +1027,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9c89ffe8a5..1080b6d69d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1429,10 +1429,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
          * We make the IMPDEF choices that SCR_EL3.SIF and Realm EL2&0
          * do not affect EPAN.
          */
-        if (user_rw && regime_is_pan(env, mmu_idx)) {
+        if (user_rw && regime_is_pan(mmu_idx)) {
             prot_rw = 0;
         } else if (cpu_isar_feature(aa64_pan3, cpu) && is_aa64 &&
-                   regime_is_pan(env, mmu_idx) &&
+                   regime_is_pan(mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
         }
@@ -1571,7 +1571,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
             p_perm &= ~(PAGE_RWX | PAGE_GCS);
             u_perm &= ~(PAGE_RWX | PAGE_GCS);
         }
-        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(env, mmu_idx)) {
+        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
         perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
-- 
2.43.0


