Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jb-0005vB-Tl; Tue, 26 Aug 2025 21:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4i7-0001uH-Kx
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ho-0000Jo-JE
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:19 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77057266cb8so2487954b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257121; x=1756861921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBSIyPR5+tmZH6nyR8nbv3qf1OhmXGnvq6KkWLsbNh4=;
 b=KQgUly8wN8rWqaHbyE9dqhjQpFWUvesBONbBEAEM11m/aligILd6nHtaTOeNB6k51G
 Kg+X+KJRQtVhn4ZGCazoKk9E4+zUgp8mO6PoFZLHcvSGnutMKnCR8m6W53jXqFYzAfpA
 3UzDRF1kwZhBbtxQqfEwneqqZ1WOu6qWhr6yh30ZSg91GwqYVnxu0hxrQFx8cPiUSER1
 KTifIYDtuyXhXYZqEyoxnh3qtxKm4ztxdYsbXDU0xR/wuoJI5qpJhDWH3R74Sjh64+XN
 1oiEUY0RXi8W4fy3jDpEVFd+Ktbd6s5U2thFKESTNGY0huxKWZnfhvH96Qxw7rI5Nn/+
 EOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257121; x=1756861921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBSIyPR5+tmZH6nyR8nbv3qf1OhmXGnvq6KkWLsbNh4=;
 b=HHXS5/kNjQTOj4IuwlG01YQorih/CK5hw24OcjcvepaIjypjn9dwwp72mTbSrDzANF
 n7P3FGXdS8M3VOfgK0Idx50jDY77XKtOzFpCSm+re9jvwHk1ATZRdBhqFHVkZ/c3GWO1
 CsKoCjT0FxuZGGGbtoAQY6i757rj3urIUX19MIZZxcYKzVdpPX3JA8bpfISuDwtOQbqs
 gxKvLVpUWN2BY1PR1Y86gQNbrBMaOCGWdtX7oI1PtiCgv+qHHhJE00hxP0GKAE/L9EM1
 04sLYnEsmdX8h6noCyx6iAjr1+OcMngTh2qeKDJwwPVaG3Uvdpk0hUEwbjesyH9H/Tqd
 h4FQ==
X-Gm-Message-State: AOJu0YxpobMeupH7ULzuSk5b8NZ7u01dy6wcIPnJ6kPCcbYJcHyQUwQe
 Tr26ViBTKK4aLLmWxSOayRB7f1EIvLxiKmpJ3YbN4zcabXg/HrwWvk8DBYYc1TtWUOhlFnSY2QQ
 Y+GVihzU=
X-Gm-Gg: ASbGncuQ8R0YNL/LqkGlYr3wzkn5hlH7lGY4egULKMKyZYjsX7GI4jUT4MjwjHxO1Af
 RpWMlJFDLaq+2Cokj+hdIu+UHBWKRg9hgv3oUHj5Gv+SJwQGr8kHoJHhWUBGuHb/yLQ6yfgirpg
 48N+DPBDxAo+YcAbs7gvRF8up6rXb86nYjPi9a7IW5DyMstPX5eX9iM8pgBFllJU+PyPgYVnAmd
 z32iMxBfXSQv0Q+jkyfMAmPPvGdlFGTXEtx9uayP+tcI/HjRM5RUUBI/yX57qWr+xeBbMaallfL
 9k20/TvKRLU4Ry/XWWLYdGzezo0CDJ+QKGN1PbTBVAXDLCRnz9xianF0W++BghVfbA62Z2f/gcY
 8qzdcKaGUwcTvJUjj4uZ47/90+FJG8ogpV4PR
X-Google-Smtp-Source: AGHT+IGIeTslXzJ8UeXaE4kTRZzume9aw9Fx+nWf67pV5apbFvk1a9dN6VuuRKAimrWKSsTQcXrcuQ==
X-Received: by 2002:a05:6a00:a1e:b0:76b:dd2e:5b89 with SMTP id
 d2e1a72fcca58-7702f9d8b6cmr28718906b3a.6.1756257121070; 
 Tue, 26 Aug 2025 18:12:01 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:12:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 57/61] target/arm: Extend PAR_EL1 to 128-bit
Date: Wed, 27 Aug 2025 11:04:48 +1000
Message-ID: <20250827010453.4059782-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

So far, just extend the data type and check access; do not yet
produce the 128-bit AT format result.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 14 +++++++-------
 target/arm/internals.h     |  1 +
 target/arm/helper.c        | 17 ++++++++++++++++-
 target/arm/tcg/cpregs-at.c |  4 +++-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f7b861c6d6..57e298363c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -415,15 +415,14 @@ typedef struct CPUArchState {
         };
         uint64_t hpfar_el2;
         uint64_t hstr_el2;
-        union { /* Translation result. */
+        /* Translation result. */
+        union {
             struct {
-                uint64_t _unused_par_0;
-                uint64_t par_ns;
-                uint64_t _unused_par_1;
-                uint64_t par_s;
-            };
-            uint64_t par_el[4];
+                uint64_t HOST_ENDIAN_FIELDS(par_ns, _unused_par_0);
+            };                  /* aa32 */
+            Int128 par_el1;     /* aa64 */
         };
+        uint64_t par_s;         /* aa32 */
 
         uint32_t c9_insn; /* Cache lockdown registers.  */
         uint32_t c9_data;
@@ -1703,6 +1702,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_HXEN              (1ULL << 38)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
+#define SCR_D128EN            (1ULL << 47)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_NSE               (1ULL << 62)
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 08e2acdb99..31934435db 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -232,6 +232,7 @@ FIELD(VTCR, SL2, 33, 1)
 #define HCRX_CMOW     (1ULL << 9)
 #define HCRX_MCE2     (1ULL << 10)
 #define HCRX_MSCEN    (1ULL << 11)
+#define HCRX_D128EN   (1ULL << 17)
 
 #define HPFAR_NS      (1ULL << 63)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0282e41c59..fb37d0674b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -498,6 +498,20 @@ static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_d128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el <= 1 && !(arm_hcrx_el2_eff(env) & HCRX_D128EN)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    if (el <= 2 && !(env->cp15.scr_el3 & SCR_D128EN)) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3270,7 +3284,8 @@ static void define_par_register(ARMCPU *cpu)
         .name = "PAR_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 7, .crm = 4, .opc2 = 0,
         .access = PL1_RW, .fgt = FGT_PAR_EL1,
-        .fieldoffset = offsetof(CPUARMState, cp15.par_el[1])
+        .type = ARM_CP_128BIT, .access128fn = access_d128,
+        .fieldoffset = offsetof(CPUARMState, cp15.par_el1)
     };
 
     static ARMCPRegInfo par64_reginfo[2] = {
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 398a61d398..ebf5a04a11 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -322,6 +322,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
     bool for_el3 = false;
     ARMSecuritySpace ss;
+    uint64_t par64;
 
     switch (ri->opc2 & 6) {
     case 0:
@@ -359,7 +360,8 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
+    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
+    env->cp15.par_el1 = int128_make64(par64);
 }
 
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


