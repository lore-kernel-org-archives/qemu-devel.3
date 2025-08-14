Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F18CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXZ9-000381-B1; Thu, 14 Aug 2025 09:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXZ0-0002yD-Go
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYw-0004U9-VU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:13 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-321cf75482fso1870772a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176402; x=1755781202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/0IpRgg6t34zaimtrRMdlDr3oUmrGBXYyd7BxUgZh4=;
 b=Ytsj21XNAg+1gqn6o9VdkWHnuX35807UqFGg+HqdlO2V3zuwTfnYnbNoQQVkn1PwQG
 TmQXJslYzBBBYZJUKLdafqbssk+tChuaQTK9aD6VkX+MOqgACKfQxTF4hFV3Alyb9WbA
 hiF+il1xZzldiJIeIvfKArgQS5sl2soWnolNkJITnDHgaudef2d7PC44ef4kKMsxIiMx
 d38UZj4TvHc9koMQS49iK/7ADRNrvsGHemiZ5CMzQPcEkXMtethX/F7JL4LKd1IKF61q
 jbxggA6Yu1clhoYA74znY1UXHUet/cZNtQl8MKLLvagBV9+JT2Japd9n8M+JM9lXRyG9
 ILXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176402; x=1755781202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/0IpRgg6t34zaimtrRMdlDr3oUmrGBXYyd7BxUgZh4=;
 b=vb+Wkg6jug9fowRo1aRVLkITevo51pug8LMV0OS/NebOZAytKrpoijLfXfTUCUmFQ9
 mYx527dO8MzvCF3h4d01Ue9LLSMa6McTrQ2SlC4608Q9e4FOOxhHL8JBFhYfxHMWf6jX
 KVPt0J2YfCcC2EQroLjfYfOM8aWvEwpgfVoNfS/5HbCMkO1Q5Qe6sg6BNX1HIpkvpzqn
 tLGCG1Cpwz0c23T3k1M3yJ3dtKvosGrkxQZDJnFk+4z4fJgPCmVyNT51GyshtAnC/xI7
 Ri97l1ZZSci7SsartZUVFKROZIF/eBDTkBc1lbmrKzkws8oav7Vd5r7i2FQsUh9Xnxlq
 9whA==
X-Gm-Message-State: AOJu0YwD9TTghfPQ2P9ZC+tEKYdh/B2/VpXUKdsCrsi7qbxRxyIjaQ0a
 HWh1sJ237ZMDJ82FzzkxYt6jjY+gXQ06+MVly+S5qxPEArkmPpbAMICWQyyo/71OAkCHYHI10KT
 4TELZTS0=
X-Gm-Gg: ASbGncv9GlFB+Sm5snHZ6owj332EdDaRnPxRpHnMz3O+lgFJK3uA1jTbRsTq0wZtw3v
 tSnBfkfc7jIlgVufgEaJ1j9PWTgwrXFdYhJjJqHSCy2JgSm2h3fLwr1wEdOgughFvHRuXfk9VoG
 eWhu+srTeDePEDCT1vNXzkUjdhswqKllnh6UeaRTS5n6S9Qm2KWrfYQ+f0LONVgmxB4EzyRTjsq
 6MBeIgXCQ6ntLtrjkwOLiFmz75Nb0PifdJAUS+eRaQmKHxKqSZZjAU3ZJwkuTH7x80EXhxcXESU
 bCOqoHS6JXlhcz77U0jQwzPY4sy0uycJXci1QyBtuepQYRLpUxANpWsiIb5PdZhA4jEhstDGvTn
 KFgh4HHf/mszEqb8HkF3yFlwI2Bd0rX/OQcWEptyXA1VJAhY=
X-Google-Smtp-Source: AGHT+IGt5QpqCa5lWoGezXXfy9akMqbB1GCv3xNXn4zTk2H/Ex+69winOrS5ok6KAIb1OjAMal08XA==
X-Received: by 2002:a17:90a:c2cd:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-32329ab24f7mr4201738a91.11.1755176402488; 
 Thu, 14 Aug 2025 06:00:02 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 37/85] target/arm: Remove unused env argument from
 regime_is_pan
Date: Thu, 14 Aug 2025 22:57:04 +1000
Message-ID: <20250814125752.164107-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


