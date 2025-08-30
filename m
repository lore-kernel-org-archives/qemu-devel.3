Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE51ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOCJ-0001BZ-8N; Sat, 30 Aug 2025 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQA-00078w-NM
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQ8-0004nP-Sz
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-244580523a0so28179365ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532795; x=1757137595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkpSbMfpbNsDrBnQ4JDG9oAjHTCy5iQvZkW4JhQwNdo=;
 b=wOmQJDybrBwtsSKkb++VrQy7gdaWSp80w3fuaWLeBT/EFSKao7A8O+f9Maef3TBXms
 0PK4+J7xg01PpIjRISrfka//ZrrU2gC8Mfmk9xSWk/cY7bemGWvcxA9RI5GYrbm6eZSM
 YGqpuheStJMs4kxeRiPg2TwfiPKIbZ4x80Xc8f2cJUeMJN22VHIWKBne0O7Qs2LY77/C
 Yfze5qAuXPHibD4lz0NOtPu9QpFFm0ls4VF2rELrrzqmgp6yee0Afg4txyc0nLUyFQgx
 dp9vs0+4Dupzw8qC/vG6yuuy2UzJL5/Bts9h4cIW9s0Ks2E9CXBH0QIFwnTc1SqoPrHf
 EOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532795; x=1757137595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkpSbMfpbNsDrBnQ4JDG9oAjHTCy5iQvZkW4JhQwNdo=;
 b=qn9IjF9kZ8PbuM2nJAPPmDwIB5cpYCO8Z5L5VtU5sPjpfUph1Fow0LxdtwBHYjrV+I
 YootbVPzrlmSb32M7lVOV6OCICm2Zdu4kVa+whDaG1cskcXP0Oj+qwU9IjLXdsXxvL/2
 ALebPkBKrffPRuPqF4Qaqqql72NP48qRwPf5lmYI1/P3pj08uQIRfwoJ1jkgH6Ob7cv5
 ESiNekXA2PZBImvPkbX9atYwnLoDoMISd/V1yG4kS5sPBYr236NJgxUT7nQVvj2BTfjp
 Nv5pzfVK42hQAFENaxD/OoDSrTgIzEu1rkCuN+QRVeJB58OYg0gb0IkSWwTi6YWQm5bV
 y/GA==
X-Gm-Message-State: AOJu0Yz8jAqEjiV/+u47XUVjpadIC88gE3G64XI2vbkBjrbirzxe63jH
 bUssPKx00YdYXqZ94bvxSoL+5WgE/DxevAya8eheAcgdOylnhCma3wU8OHLC6LDaJtPJHbfsjkI
 2uSjCihk=
X-Gm-Gg: ASbGnctHMPL4qIp4s0NJ1gB09X1hZXgjddSGl2D9qtDhROYB+/qGRymapXoTsyaiwn7
 Vr+tjw7IYKf3kGI5giTgJEceigI+0zrUyDgl6q9Xp/I4Q9khDbOpfjoBEw+hJM+DU8X2WNUeSPX
 nzbjH+iC1EwKKBvY3V0CBJEbZZgSfWt4LCvKeer17bH8+LM32z+lWtake1gxq4ScLjE3Iti77Oj
 YXGpSm700QijLE1NRYqeDbNWYqYkZuBf1AuVzX8bw/nKp3wjCcLUE3bAuelC3oDI4Y8tX5KTz5F
 AKFYA3OfIXr1dVuEl+iYyCQu9PEBqQkdxwsd8VNuvmvOT+7LUF9gCoiKHH0qd4xNcHjeUGxt03B
 2RfDLfxKjfQJVMCV6yPtGxa7pqc3n8j82n8nH712hXleDpgKhxoHxTj5AAdw4J5M=
X-Google-Smtp-Source: AGHT+IHkpB4oi0x+n5Gndyo3YF00AytJ/T4RwkLqAD2OGXt4bi23j9TPQmqsaKS3wq4VNodUPWJiLQ==
X-Received: by 2002:a17:903:1988:b0:248:cd0b:3434 with SMTP id
 d9443c01a7336-24944b0d876mr14314415ad.36.1756532795446; 
 Fri, 29 Aug 2025 22:46:35 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 42/84] target/arm: Convert regime_is_stage2 to table
Date: Sat, 30 Aug 2025 15:40:46 +1000
Message-ID: <20250830054128.448363-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This wasn't using a switch, but two comparisons.
Convert it to arm_mmuidx_table for consistency.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 5 -----
 target/arm/mmuidx-internal.h | 8 ++++++++
 target/arm/mmuidx.c          | 5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 68db7559b0..eb11389720 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,11 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
-{
-    return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 55fba4aae2..1d948aa6f4 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -19,6 +19,7 @@ FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
+FIELD(MMUIDXINFO, STAGE2, 10, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -84,4 +85,11 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
 }
 
+/* Return true if this mmu index is stage 2 of a 2-stage translation. */
+static inline bool regime_is_stage2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE2);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index c5b43a5932..61a682e655 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -14,6 +14,7 @@
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
 #define S1     R_MMUIDXINFO_STAGE1_MASK
+#define S2     R_MMUIDXINFO_STAGE2_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,8 +34,8 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
-    [ARMMMUIdx_Stage2_S]        = REL(2),
-    [ARMMMUIdx_Stage2]          = REL(2),
+    [ARMMMUIdx_Stage2_S]        = REL(2) | S2,
+    [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
-- 
2.43.0


