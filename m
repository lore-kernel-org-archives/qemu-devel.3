Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE5C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRW-00031R-MY; Sun, 27 Jul 2025 04:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPa-0002j1-DQ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPY-0004of-JL
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23636167afeso29870725ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603631; x=1754208431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IXOiXj1C1ZetYUAJn76SJu5i4qqFoVN2qqJt7z2Klg=;
 b=BqfKWI1pKEMvpsARuvEY8QWhVROAAl9orvFfRn40cOh935v+0wEf8rZ93veo7A1yrQ
 vPCVm9qY+XFI/vH4wLA5uFbKkO6uiS3bygpX6iD5OE3aVrS92INbm9ruLAFjdxQ0yzMa
 G1Sa5rWiqAt/oBK4hvnCFnsrwoHtKGdseAjhgpJJJpVzCbvQqwUDTfwl8Yo2/7cta5xg
 EqA6Cqx5lu0Rltjm/NZ0KaX5qn2Jb4uw33lHg0XFa2oLq3mprr4PcYcTmH8tu6smVmvZ
 rhkr1SdwJdi6TJKE1/o3x8weSCxfe+EPhCq2RptdtGrenC6sqH4IOGFy4KcwDloRMNLQ
 l++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603631; x=1754208431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IXOiXj1C1ZetYUAJn76SJu5i4qqFoVN2qqJt7z2Klg=;
 b=QDuVSlLZFDucP/yXnDru+FjP3vsQWoZuPkKjqWyu5EkTMNdyY9hwZk0HJUhHKPdFwH
 wJGepf7478XB3Y5HeQNdVpjpwB0TRNh4cdo3bsOuKQC8Ewrn9MAbyn4wtd6omKqt0/Ql
 4eKoG/dsZJ2pxFUoaKIY+2lpzaVII0QRrsuQEXV41UqpgXot9WKLNzaFmH7ppclHmD5o
 j+TUPEmbw4ak4GlBWWibn5R8nIdgIkuPs8HAnMZaq6QG4m2VZiT7INu3QjVN9S1X0DLZ
 TpItoIaA1imbasx1k4iprv7xG8EFKimbpNjOxU3RQF9ToRmNBbNHY9PC/g38xhdo32nq
 YihQ==
X-Gm-Message-State: AOJu0YzKKoOahJcojKLlKdYqu/iwJ424Lt/77Y9jieXUfTmSwno5VqLW
 58ZhpsQKpLFPEnf+sCEUUyWKNw8gQ2/MUxd7lgxGULu5L6jS2RF9e4Ox0lSl1ciJDF9zTZplYx8
 VLpSy
X-Gm-Gg: ASbGncvTy/gNSNvTtHwBFsTsrvzjWZq/CAeJX84pzp1sEx9WM/oiefr0uD56ERVUAkr
 jv3lM8ZSIADKj+Tjxn6R2lUWARakaGMB+dEJSmkna8Xqye+FiXYWMg77iNbs7gtnDU5jTqWSTt1
 TTCV384HRCCcCbgzXsvw3gEPRUrUTZJoRWQL5Vf8uTyf4AIVYhPbVSysUDEntxKaem0AdbgG9KS
 /nxul+xzZx/eM2rxWvxKR9I/FQ29QCMl7vw6J2+2TXGgpXfMtniEKRgAeRsKhk6v+JDZpTuKeG1
 CrSsPqEQxeakHxFGUnexkDt2KcupBjlgGnJYGSdJS0uOQTv1kxOQ72++Sr14zOOLyTiyZ7i0lgJ
 jpe8MaqcMnjzIuQu9RynRInpues3cPzdk3HVh9yPf45+uTbaLcJesPwJ4VgyVGW8Ssy8jZYcDAJ
 pd5uGBBlV2Vw==
X-Google-Smtp-Source: AGHT+IHjBkuqtuiOLcMSppkeQ2Zf4hV3hjaQ82NkUs+E4Dc3jfIUVk7HlFBsz/i+AYABL1BqbJndOw==
X-Received: by 2002:a17:902:ea02:b0:234:9375:e081 with SMTP id
 d9443c01a7336-23fb319041emr108186605ad.42.1753603631121; 
 Sun, 27 Jul 2025 01:07:11 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 61/82] target/arm: Implement GCSSS1
Date: Sat, 26 Jul 2025 22:02:33 -1000
Message-ID: <20250727080254.83840-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 392a0a264f..ee8b870e17 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -52,6 +52,7 @@ enum {
     ARM_CP_GCSPUSHX              = 0x000a,
     ARM_CP_GCSPOPX               = 0x000b,
     ARM_CP_GCSPOPCX              = 0x000c,
+    ARM_CP_GCSSS1                = 0x000d,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index ab53a4314f..bdafc60786 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -114,6 +114,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
     { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
       .access = PL0_R, .type = ARM_CP_GCSPOPM },
+    { .name = "GCSSS1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 2,
+      .access = PL0_W, .type = ARM_CP_GCSSS1 },
     { .name = "GCSPUSHX", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index af91b7f95f..e4c7801740 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2634,6 +2634,33 @@ static void gen_gcspopx(DisasContext *s)
     tcg_gen_st_i64(addr, tcg_env, sp_off);
 }
 
+static void gen_gcsss1(DisasContext *s, int rt)
+{
+    int sp_off = offsetof(CPUARMState, cp15.gcspr_el[s->current_el]);
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 inptr = cpu_reg(s, rt);
+    TCGv_i64 cmp = tcg_temp_new_i64();
+    TCGv_i64 new = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSSS1, rt));
+
+    /* Compute the valid cap entry that the new stack must have. */
+    tcg_gen_ld_i64(new, tcg_env, sp_off);
+    tcg_gen_deposit_i64(cmp, inptr, tcg_constant_i64(1), 0, 12);
+    /* Compute the in-progress cap entry for the old stack. */
+    tcg_gen_deposit_i64(new, new, tcg_constant_i64(5), 0, 3);
+
+    /* Swap the valid cap the with the in-progress cap. */
+    tcg_gen_atomic_cmpxchg_i64(old, inptr, cmp, new, mmuidx, mop);
+    tcg_gen_brcond_i64(TCG_COND_NE, old, cmp, fail_label);
+
+    /* The new stack had a valid cap: change gcspr. */
+    tcg_gen_andi_i64(new, inptr, ~7);
+    tcg_gen_st_i64(new, tcg_env, sp_off);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2945,6 +2972,11 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspopx(s);
         }
         return;
+    case ARM_CP_GCSSS1:
+        if (s->gcs_en) {
+            gen_gcsss1(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


