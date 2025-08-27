Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F9CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jR-0004ms-HN; Tue, 26 Aug 2025 21:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4i3-0001p5-2s
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ht-0000Kt-Jl
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so3195926b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257126; x=1756861926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAmjouAdxbWZIhGVTm5xxs9AuY7ADuu5VQy/ar6fIhc=;
 b=GBz/CiV6F1B9+gzZC8vWoZT//1dgjqwJrBV0LOU1fZrvh6rW6mqt/TF7rIeoODF+5M
 fWUQAVIMiAAOH+UU/QQxMjqL4jEmlub1CLArvkps3sEou2s5vK0TlJoWfc0891hMBj++
 5OMqo90a03bUjensEKoCM0gQs9mBupYnMOU9iuE/c4C76d+pUlR9A52e81m0cwIR0SYD
 tnOKBYo6Pjt6FkajygAliWCDMovYU1SyCmCDBteOE5K9pP12wBlFBcNiHgOS6snvI7Vs
 bmTtKZi8y7EkvI4Kwj5yhT6HjxeWOZepkrpTODgYM789p51cnM0blMNKRqMv1WJRSOo0
 vLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257126; x=1756861926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAmjouAdxbWZIhGVTm5xxs9AuY7ADuu5VQy/ar6fIhc=;
 b=vZhsCFlszJZa+NNt0XQ0wpxd+QMLW0CS3XglAk1TAjmAlbXiVQ23qHmZiv/h7CRk4F
 a8po1sVE+aTb7PG16wuIA3uiDPbtRBxn43iQEsFVPiP/hAF2pamenXdU74QXfVnS+N+T
 gJw9pU9jDm+sr6Z2GJK5sLYKmH6im0YHhhrkWwC7Bv/nbPt498kjkw686xA3KYsJymTp
 rvLQ9j605xwTRNueK7ei658PWJOqpJQc7WzTvIRLMHFEoWHcpKB5IU8ahp2kNaFT9Ic0
 nLQB0J8FRJbs8w9GYvW7ZLAhkUfDaAJ6uXPCcsJ2xKvjXQT0wiEvS4SXi7SK8YtWlQu+
 hCKw==
X-Gm-Message-State: AOJu0YwDDUIkMDACVJXMqBVYPMeFWt3+7Xlf1LVNT/z90X7daFXvxL6A
 3kl10A6WxNAnVpTCHnDKREfzz1idGuidMfld7tVtAoOihVWK8L5AeoAMtbFXj2Dl5Ry0gl3Xb1f
 M/HHFDek=
X-Gm-Gg: ASbGncsAx3Vxc34i2ww+Z8dHtgtYb1lb8NDqtz7j3c8KvA9FuBv02/1JNSXaW+f3p3z
 zbLI0jnIxPGB2W/hJPkIo2rCUq6geYJKMM0oS8Xk+/XRpIRLEGY1lrdeTrvQKXby0p2rPo+oFbB
 IqvniIhzcEV9gJ8kWi9FicDRsyidwPBmBgCnLeQvcJNc1vtcmfKKuSVwGwxiNDPsrewVoIDe+4a
 pH26IOfUHBv27MLuHu8tsBJiz9Du7iJ0h0j3M4ox9e+h6qE+6ErWJkSghQe5/qXf5v9VANpEIvC
 gB9nOIjYINe6sk/bkVYZgwcRcSx2Z+/qCVuvFXA67BE7mDl0HCRqHJT7aRG6kEWgeZp/EffTYSR
 kpSdst2sfARyORjk9WSH4ApodI2GELOBfJUGW
X-Google-Smtp-Source: AGHT+IEDe1DmdxJj0gTYj51v6y56Jh/UPtgqAu9YwvRXI5lPmhHWkPvk1tzVI+KnBLWuxraa1Fa4DA==
X-Received: by 2002:a05:6a00:2d90:b0:772:3c9:ce3e with SMTP id
 d2e1a72fcca58-77203c9d114mr2492254b3a.7.1756257126338; 
 Tue, 26 Aug 2025 18:12:06 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:12:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 59/61] target/arm: Split out flush_if_asid_change
Date: Wed, 27 Aug 2025 11:04:50 +1000
Message-ID: <20250827010453.4059782-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3dde778369..7a817b7e28 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2893,6 +2893,15 @@ static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void flush_if_asid_change(CPUARMState *env, uint64_t old,
+                                 uint64_t new, unsigned mask)
+{
+    /* The ASID or VMID is in bits [63:48]. */
+    if ((old ^ new) >> 48) {
+        tlb_flush_by_mmuidx(env_cpu(env), mask);
+    }
+}
+
 static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -2914,12 +2923,11 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
      * holds the active ASID, only checking the field that might.
      */
-    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
-        (arm_hcr_el2_eff(env) & HCR_E2H)) {
-        uint16_t mask = ARMMMUIdxBit_E20_2 |
-                        ARMMMUIdxBit_E20_2_PAN |
-                        ARMMMUIdxBit_E20_0;
-        tlb_flush_by_mmuidx(env_cpu(env), mask);
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        flush_if_asid_change(env, raw_read(env, ri), value,
+                             ARMMMUIdxBit_E20_2 |
+                             ARMMMUIdxBit_E20_2_PAN |
+                             ARMMMUIdxBit_E20_0);
     }
     raw_write(env, ri, value);
 }
@@ -2927,16 +2935,11 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-
     /*
      * A change in VMID to the stage2 page table (Stage2) invalidates
      * the stage2 and combined stage 1&2 tlbs (EL10_1 and EL10_0).
      */
-    if (extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
-        tlb_flush_by_mmuidx(cs, alle1_tlbmask(env));
-    }
+    flush_if_asid_change(env, raw_read(env, ri), value, alle1_tlbmask(env));
     raw_write(env, ri, value);
 }
 
-- 
2.43.0


