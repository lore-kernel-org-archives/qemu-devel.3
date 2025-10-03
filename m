Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61182CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHs-00024a-DI; Fri, 03 Oct 2025 13:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHp-000216-KV
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGd-0006Hk-J5
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so24690045ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511301; x=1760116101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meX87Ydvhvkh0zCh32of1q2gaWRMIfLpN1nsf58T1MA=;
 b=t5EBpduFCRh6Xp6Rb2THEN5dg3RGL/Z2E00+0zbmd6pZRirRm/w3/gR2Uxu9WT5eVQ
 LrK81a7nhyPEbQT8u2AXnCpjH+2b8RoEoplOy1bNM52mjCdJHCuxx63iisesVDM+OK/9
 4XnnuiHSkzUlQm2HRqpJ0svFfWFggUJStNS126L8H7E1Tmq5vs2fr6qpuyJePtFkYKeN
 Q99GkNaAqWqUd1NxXkOB9MfcQFkVrOxllfqPzzS94HzX7J8p3kC7rEwI3r7xuIoqWLDm
 JNVcEvWBU9ktxYYtAaajPx9fdVKjfooKqfsMhxW3VdjtY6jvevHEwblESWU+K93Zsi2u
 ZZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511301; x=1760116101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meX87Ydvhvkh0zCh32of1q2gaWRMIfLpN1nsf58T1MA=;
 b=VKp9JZ0gU8JZCOfBya2obHZLqRaCHvKQDdh4DY/tVVFISBoO+m7cBnnbfcHqGJJDw0
 GumshP1/UmSDrFghL5t9JTlbpS/V4j4y4fdttb/uTy6rYp5Vi7zUA4w5WF1DcOjqBI4+
 od2JqaexqfsySv3LYQqS5ESwD9iCa/TESw4MVR64Wk3xboudG8qGtU58wnJL/PmPFc6/
 z6MhmMkU/SdbKXfUR2Uz95D7Us0o8JLWMjyp3nlwIVSHxnJSnAk+h7bO1slz9pNLF/KH
 b96F1hho83Ze1jBfI3GYh1dqEvF1SkWQjKGCFR6D9IDxGGnVeo6fLBWBd/hH8LQxNl5l
 tO1g==
X-Gm-Message-State: AOJu0YzF+rvu5f+hEcXxeXCocchnx9iLOAHxuNrtDDeHtufvgrRJbQAn
 dKgJa6+C0v6F6TBhJxPYTjQ7lV8SbrgBL6z44CP/crAxO2zmTvbmyfTtNhkCcr0dZZdX4+OQn1y
 A494/9dI=
X-Gm-Gg: ASbGncutsZHRpZM0zI/fGAE7iyQSZGfrzSaKYolY+H74khedN69/EcVMefE4Bm7tYr7
 GP+JFNA9Gaoxsh+MTUPeflzJ8wk09voJrxdQ12YCqDpsbqKdFazVNb3s6/Rh8qUMFD6N1ry8m0E
 qzkEDUwWX5YVvY38aoTJXK6GmbtTZR6uLmZHKlBaQYNjPNregMhIFWbytP5r8cmFGM1e7oaRM3L
 F4ru+VfsjvrKbxQPU4Mvg1xhhwyEtRAbTp11UkGjj/qqePVdp/YuQKL6XApSsdtwOXJ6suy7r2L
 qtWhtfthlHq20f4AMsz1E7PGm7r5GaNbEyqFb3ta+Q9LUvUcC+dFFVYY44STSvAfsRXLIGvEC/b
 g0MjywtBAuZ76V5S+cXvfsqZL8vdiXCvyb8Qas15InAoYmNtMgMjYpvr2
X-Google-Smtp-Source: AGHT+IHiqMYkIqu4dviAzcQIjnakLR9CIhm2Bpl6USCJiAEPitQVTVK0RO6KfFfZ7YrvuVIg66EjKQ==
X-Received: by 2002:a17:903:320d:b0:264:5c06:4d7b with SMTP id
 d9443c01a7336-28e9a5ff70emr42971975ad.32.1759511300881; 
 Fri, 03 Oct 2025 10:08:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 21/73] target/arm: Remove unused env argument from
 regime_is_pan
Date: Fri,  3 Oct 2025 10:07:08 -0700
Message-ID: <20251003170800.997167-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 622b5cf520..db51e55cd2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1393,10 +1393,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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
@@ -1535,7 +1535,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
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


