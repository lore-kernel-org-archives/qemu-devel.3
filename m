Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E97CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4f0-0002sW-1A; Tue, 26 Aug 2025 21:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dt-0000i7-E5
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dg-0007dT-Ii
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7704799d798so2856561b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256863; x=1756861663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x38MLekZNEZjsShxH8cHbE+ym7HzClucSOu45aiR/ek=;
 b=N8jW6y00dCRQAWsOCJYtR7IH6tQG0jZZTHS0+kzDcwFR+zvlFBccvlYJ4N7FxxhaB0
 jg5CThiQL3Fvukv17OAVNHvvRf0boRV+ZCKTYvCvHikRlNulqj9RVJPZ6QXC33lPcL3o
 pnX4dbnLzVA8E0p+zFDE6OgSWJmpNEgmo/TzysRvgqz/yVXiTNJjN0MzG6A8GxxhBK4u
 8e6d5CHPTI26EKyXhj1kiUp5TKKFWfQP1bTelEr7MHy4ALj5+4BqiswpBQQKJIp7U7ta
 9Ulc76mvdwzxEjBRCdeUgyQnPYlZI+Z6a75UxfVPELtnPtZWZyBm7VpTdcH6vD854pxc
 rA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256863; x=1756861663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x38MLekZNEZjsShxH8cHbE+ym7HzClucSOu45aiR/ek=;
 b=VZNS1PF5Hv/wdvVmuZMYFsEW3G85AqqO0rz9JHBAJ4o/JVRZv3LJz47UrRuKB520B4
 6gp049kC3r5bDsTjsyo/rnoBHU8EkMhGo2IK0Cm82ARFQOy83xPVB9w8/aGdpucRjptp
 LyHiR6MXicpSgkpmVagvrWbcCJtsCOG9TU8N+h9ELoVKou66WYeLrSRjN83rOqH/2ESa
 rR5T4lv7IErbv5TDITBGQeUaklHH3Texb/qGazrtq2c+ExuCyZT/8cCZnlHiDbfBlxJM
 cFmQhn+MaXvCvqLikHyLOnGzEDVPtd2w2mvsy/U7kJC7AC6x3HomGomm5SL6jcmW8KRA
 kyig==
X-Gm-Message-State: AOJu0YwICySO/oOjYEagKwXQJhCFYE8kBcOU9ZLq3OPeEDvh8aZ7k6dK
 kY6Ptwb2OMdcOo2gF6bLBysmtrEiyF3LBVbdsvz5esJqNJz6jz4qTHW53MxDTJXCNro3v356XXs
 bcKpRPsE=
X-Gm-Gg: ASbGncsqtb2bpqZKfAHRAdHvjSoyWkkVi3nOYVSH07gJiIEKsSisVB091Ahb07EqAhB
 Qpug4Eca28O8Tor3PDlBrhMy0c0zlgQQ6yr9Ud6GxLZoRvla8RnNpWPL+ctqEyANU1OfZoZOc8H
 mqFexSKEbN75a+xtCQOepsmey8V886kMths7nctEr5HrGr+IGsCzuJHEhfsbfmOLOW/E0hELt7a
 iGQlPU6wXGHphUiQdf6X7/NgLv9NwLhFNTJZNBhpZQL6lv0SIVzD8NojZldU4JZiV9Xw94f86Sq
 2GdmZ9vpz4x+h6L284yzItdSLYG/Nm8GszZKMJ34JP49zNa+Sxk/g32uF0VFAt7vUr4Da2/qiYr
 n5//8xMbwOkL83VgaukCfjUADSqaOT5nj4SiW
X-Google-Smtp-Source: AGHT+IGgKOvAv23b08ctn5rLyy68LHE+o0vS/RQA//ykRjQ+MH2h5EQDmxX/aOw+FJgu/BeEBHPJgw==
X-Received: by 2002:a05:6a00:181e:b0:772:921:e32b with SMTP id
 d2e1a72fcca58-77209220d75mr447339b3a.25.1756256863279; 
 Tue, 26 Aug 2025 18:07:43 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 31/61] target/arm: Rename TBFLAG_A64_NV2_MEM_E20 with *_E2H
Date: Wed, 27 Aug 2025 11:04:22 +1000
Message-ID: <20250827010453.4059782-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Install e2h in tbflags and compute nv2_mem_e20 from
that in aarch64_tr_init_disas_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 3 +--
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 8 +++++---
 target/arm/tcg/translate-a64.c | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c..919bd3d7eb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3076,8 +3076,7 @@ FIELD(TBFLAG_A64, ATA0, 31, 1)
 FIELD(TBFLAG_A64, NV, 32, 1)
 FIELD(TBFLAG_A64, NV1, 33, 1)
 FIELD(TBFLAG_A64, NV2, 34, 1)
-/* Set if FEAT_NV2 RAM accesses use the EL2&0 translation regime */
-FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
+FIELD(TBFLAG_A64, E2H, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f974996f3f..cd67c0ed07 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -150,6 +150,8 @@ typedef struct DisasContext {
     bool trap_eret;
     /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
     bool naa;
+    /* True if HCR_EL2.E2H is set */
+    bool e2h;
     /* True if FEAT_NV HCR_EL2.NV is enabled */
     bool nv;
     /* True if NV enabled and HCR_EL2.NV1 is set */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 59ab526375..6969d41ea0 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -258,6 +258,11 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
 
+    /* E2H is used by both VHE and NV2. */
+    if (hcr & HCR_E2H) {
+        DP_TBFLAG_A64(flags, E2H, 1);
+    }
+
     if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
         int sve_el = sve_exception_el(env, el);
 
@@ -390,9 +395,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         if (hcr & HCR_NV2) {
             DP_TBFLAG_A64(flags, NV2, 1);
-            if (hcr & HCR_E2H) {
-                DP_TBFLAG_A64(flags, NV2_MEM_E20, 1);
-            }
             if (env->cp15.sctlr_el[2] & SCTLR_EE) {
                 DP_TBFLAG_A64(flags, NV2_MEM_BE, 1);
             }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 58303c224f..648463f44a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10153,10 +10153,11 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
+    dc->e2h = EX_TBFLAG_A64(tb_flags, E2H);
     dc->nv = EX_TBFLAG_A64(tb_flags, NV);
     dc->nv1 = EX_TBFLAG_A64(tb_flags, NV1);
     dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
-    dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
+    dc->nv2_mem_e20 = dc->nv2 && dc->e2h;
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
-- 
2.43.0


