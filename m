Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66140C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLk2-0006JZ-Hx; Sat, 02 Aug 2025 19:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLim-0002B3-PM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:33:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLil-0005I4-6r
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:33:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-741a8bb8aa4so160849a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177578; x=1754782378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbGwNjCy+e+Sbpz2PXB4lvl0QoItA91bfxAh1LBwoOc=;
 b=u6YQe8FERMXctgiKxbgOM/4r9cAOVwbCqrlkPNRIRJGMHBHm7Bl0m3MIorB5CM+QIR
 lXN6HH2kumJgC+jvLlGGmgP/GUt1G0Phyx9h4xu9m/H+jldJLYQEm01N0QU93LCvNB5y
 BWc1Z20AM1vEdTP4Jogkr8OkE1Li9/1/KF94XRnkTbLiHFxQNGgKOlQQEa1264pz32Ng
 0YlJj49g/lSlLAAtJobjcsZy/dr3aFervKsaqWSutZzkX4orLe4/3vDYcbg8v5fEajvb
 DnQSE10KJAc99J8wqKVe2Xb2RlBTr3kPD17rkFod1b4k/yB2ZUYjcOUmJtFPMjhgsPme
 WTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177578; x=1754782378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbGwNjCy+e+Sbpz2PXB4lvl0QoItA91bfxAh1LBwoOc=;
 b=bpMRWjo0vLOvmDCza+PRpAb8z3vIfOkIBIEe8sgFXnZY6ph/SXqhe9OtaaaImbxtD5
 z6GQZ75Y8P0JK7l5tnxRBwAg7KfMrwjBySIrfvVrAwFASZtIWxJvtL0bbnVCt7g4Syfc
 d7l4RSAEJIwS3ghm/S16eLXzIrPEj2LDsEXiweF9Zrm5vMRJYzDrAapPV24GAV+N/cbC
 IpjWzvzKsvuRiGDyS1ixjlqs64czGQAGYFbmpAeAetTSEEXjmjN6yfeyNq8S3FJbfQlq
 NxUsIG+DDD+vAD0VLacT+w0AAK0i98iRjljg3HVtRiat799SKN9T0gdC7XZDsMaIUgMR
 X2yg==
X-Gm-Message-State: AOJu0YyA2HkgbaKlqlJr8IHWMNT90doDYEnWQjYX++VxJgYNsHR7fPil
 fnGBFfBIAEytnRit0wnL7MOObjyZA1ejmYaA7yJyjiUlm2CrOOb2Y95baPpzM2rg2JeHkNMLFjV
 8gIh9F4Y=
X-Gm-Gg: ASbGnct13Smoz20vgt31GLyxU8vzm5wFHBQioQHqG2YMGwkxo+bJ2cYEuKiKRIUAOYX
 i4Xc9XeXhao4d89o5lZLfj6grv3kJxam4bDRepJkrPD+ANwvvyw4A/fDmK6CKWUu6JyA8qY50ZO
 uzlyAUUS5BIsNf3fR6oNDAd+UdXGtwk21w9SKTC8hhgsqLZvV46EZM8xJFnCog0kAQU6+ObRg31
 1UhAAptbWqsQbcgWlln6GeEjxg1FZwInJ5cmiG8ZGVlQdoF1R/eltHskM/qtWe97y6hSrSvNcJe
 XmZ8sAzQQxHfAYWEklx294UboFPubMBKSJKNUXxdVpt/lNmS5OP3Ea7DUt+svSUYe+JNqbZ3eg+
 I8/aGbfO+hbx0/zI27BxzmijfzqCxYwr/r2H1erWPse1/7+F2vqcA
X-Google-Smtp-Source: AGHT+IEIJnseBBBP2T/DvC6rREZP+EzcZqrLGtMbeoHwj5vBnVvN1cMSC0IGd3orqE3f1d1I4ht2eA==
X-Received: by 2002:a05:6871:610a:b0:2ff:8978:6be9 with SMTP id
 586e51a60fabf-30b675e77d9mr2548657fac.16.1754177577997; 
 Sat, 02 Aug 2025 16:32:57 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 37/85] target/arm: Remove unused env argument from
 regime_is_pan
Date: Sun,  3 Aug 2025 09:29:05 +1000
Message-ID: <20250802232953.413294-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/ptw.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0322646753..962fc423a6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1029,7 +1029,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 30c83334b6..c75b15b263 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1394,10 +1394,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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
@@ -1536,7 +1536,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
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


