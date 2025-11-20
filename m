Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3A3CF8854
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4Fh-0008Jl-QH; Thu, 20 Nov 2025 07:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4Fb-0008J8-To
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vM4FZ-0006K3-Gv
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:59:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477770019e4so8495235e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763643540; x=1764248340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtF24qAlWQOoDeMvYCKIIi54CEpEOaFUzDD/yLc7IWw=;
 b=S2vQo7Y0nTcqJQTevI7vvf5MHERO00tQmdc74M7ztvGvIbHahvnpY681/6qE/XcnZl
 930CSyOpWV4awS8ofM50HLUmRpm5Lh6DTGSvuPda+DR5o6WWWO6VAscgQv8qfaZQRHM2
 6UaTfmVELdjY67rYcILC76ksnQmfx/5G6ZbcQiPy0mhTFW9gUZ6D0DFFVSxKa3A0F2RN
 7M+o8rR0+p4F9/9sX1QGp/XqnTs2aO1BImrgbPwlQpS7n74EGuJ5vdmBpVdXZZowpnlD
 c1bVJ4AgQp+u/Pqmy+D/aG7xa4BVpltxCClLa8yxCAhbcA4POGQ3oWNF+AqcaVbfIWzJ
 5VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643540; x=1764248340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AtF24qAlWQOoDeMvYCKIIi54CEpEOaFUzDD/yLc7IWw=;
 b=ht8qhgMr4/jL+KJrqc/piBifRqXq64/nNbe2S+jqjhOLeUzJBo864iz7sI0k2J1NPq
 7bE/GOzH7wmsDZH/j2Tesb1EfjtmiFb8/ed2CqZb3ClP4CqqzUHT6inIYAbpyLsCf7CV
 ybPDg4S3X633odO4pHOy843CQcRktHWI4GIDXVoGsD4JGIlKNbHYleyawbaC/vbvpRm7
 SU6gcGgwKWhVQYzX+Z8CEJZ9W875/jVdal5p+Q0V22adclf4Gw3FOAbpJ5zghB5+lN+z
 LBh73Ew2qtwq1yv2nu6BcB8hNkPM+6Vmpah4SGQWQ8rIuFZjfUTwKR1XIOPd2Gg2PbjW
 VYQg==
X-Gm-Message-State: AOJu0Yxg5+VwFsUguJjs92NkVi75EcWQMDnZFdMBAaMwRxP2lB+kOGBs
 e0ivWWLY6f7UwrjATD434Ys7Dm5CX83TiSDxshdYf4nK9sGGdFBJBtYtPwU7q5ebKFEfXpMqQUb
 SF+176U4=
X-Gm-Gg: ASbGncvg5vQS4nIQC6VQ4Y7kQoxZY7PCx/i9RZEW1V/aH52jEw58KY1B5QcvA4/Wn/7
 bQcp5aZ0pCWxzfQEtQY7nbHa0nWeA+dqRKOQmvFLb+tPJmQa5lO0e6QV0F858fPPsUJzdwvLmnr
 saLqcH5S0wpM7tvxjGkLh3M9AtUWlanNNJ2i+8jiwCdlFm8uboUlNeVkgknjtmpaN5u55Bb7jgw
 XsmZLE+gMeanODV9yrubVa7awALvu1A1tP5YbRKoCTq9N8CMiK2mb0Mk06HB4/6kPuX30pQ0/Zd
 2ka7TnExt7wFjl18BpaqIH3pqbvxyPRZUgRjtWCaTjlqBmsa4DSu5+hOXJG8ttgfittqu2XT36I
 Olb5rsXF0a0IopbB2MMU80k/Id6qDX9YgyYG21syRsl8T0hrTpjL3/0Q3STjYWbWLa0PgM6/9Up
 3J6eoUAgEsFkF+wYTIT7UBXR0=
X-Google-Smtp-Source: AGHT+IFCecowj+AJTIhrlYVVx1WGfA0ROQyujO7OWcNTCy4FHQ1kjd/gGnvXp8y+vbRMJpuJfKYirQ==
X-Received: by 2002:a05:600c:4fc4:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-477b8d8ed39mr31449865e9.33.1763643540041; 
 Thu, 20 Nov 2025 04:59:00 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:1328:3324:f0af:9332])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831421fsm46082145e9.10.2025.11.20.04.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 04:58:59 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 2/3] target/arm: Enable ASID2 for cpu_max, allow writes to FNG1,
 FNG0, A2
Date: Thu, 20 Nov 2025 12:54:15 +0000
Message-ID: <20251120125833.123813-3-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120125833.123813-1-jim.macarthur@linaro.org>
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32c.google.com
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

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 7 +++++++
 target/arm/helper.c       | 6 ++++++
 target/arm/tcg/cpu64.c    | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..d56bda9ce0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c20334fa65..7812a82bab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6102,6 +6102,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6121,6 +6124,9 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ef4c0c8d73 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.43.0


