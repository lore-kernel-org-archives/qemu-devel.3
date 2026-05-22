Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12A5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXyn-0000NR-SG; Fri, 22 May 2026 18:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxj-0007jM-1q
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:24 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxh-00083L-4B
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36936dcf19dso3815727a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487400; x=1780092200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5+7YH7c/Km6Z0lmi07jiku/34VE5LjvhNJduDNbaZo=;
 b=wwtUt82Qul0Jl+sYG/0jp+LTXvSrkBfnRd416FoOU5m+pHOlbI0ydluwfSgOLSalmK
 wKNkCb+7AR2uPWMa5wtWRX1E6iTa14+IOnSLUowWJVbFl0D6rhVjA/405QipcGK+NBfJ
 ji7LWsI6CXbxRQtT/qbkw5cV1XhaLEuwg8VH4HSnuDL5Bpt3k9HY3Ki1+kzqs2iUfbLq
 juW9sZmRJ5oaEomYiI6TZv1tylnwLrmk+kYsh7EiNkGbcAmdIfXSbFbn8r1Td1t55ubd
 pofs9lgJ8CYCOQxa6m3CP/Pzx9itdWfff/+orGq5wuC4o7miZcGTQwHDB5UQNK//vTfa
 vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487400; x=1780092200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5+7YH7c/Km6Z0lmi07jiku/34VE5LjvhNJduDNbaZo=;
 b=UgckRycM5VFXMDd3pnQ1iLlmlpG6c2A0e2JVjxRc1NHgYl2+8FAB4niDVIEwMnSO6q
 czeKhSJFpea54OUL1OTOZKJRve1W/R4m+7pPWCIdoQKzBFMa1G1Ymg1S5Vyt5NFf18fm
 ncyFmzZIQ168Hlmkdwya/7mqYG+w/hxRhC09Rtrmklv4C7Hokul3nrt8XI8aSh2LaDt9
 GNGHfxaew+ZIMcVpv61VFD7H2SoySCs5GeeYHYxm19tVhDu6K4/Wo/qB/3BUj0i9wusU
 ii+Jl7srfCOwGS6MKA934hInMwbV+SFU/iYApis2E7KPZbw/s0aXqXT9sj1BIPnTJDSG
 +jJQ==
X-Gm-Message-State: AOJu0YwgND9Enq5qJTZYU/QY+ljEzP0wdUgiYVTfQ9KVoQm7S61Ov6f7
 vutuuZe21Pl1z6K5Yluy1PTYh7rZn6LY/znRtkUhCqCMwCoakQGcZf/S6qCBsZWznvR6AcFMwUR
 ECBg1
X-Gm-Gg: Acq92OEigz4EXzN3y2P0j0qmoHtSza1Uyu4zcolpmIwADKKKS0u9JxgV+WO37TnlV6j
 JtCZ7raB7Sf+/mzcGyb36VTZXnPZz1cV5cIsfwZEIrniODSGWyA9Bpz7k0PkoGiIKuWdm9y6UZl
 PnAUQanzQ7+ju0TT3AqOu8VBhvT4xET/l2/EcKfkj+2Q0O+7qqtqM+pUG5g97Tm3pD+vWu6C73o
 7e4MTyIrKKFuBP88FmSSB6ZCQys/cMLjjelVK1ZYSDYtPrwJYO63FwAHilEoI4U5zVPSXUexFJ+
 AhYS1lnXKA3c38rXdY1+anQqNCOgIXx/qi0MQ2MDbIxnJrCzWT2FvOBk9WEFque5dKY7/ATE+A7
 8UyPIz1XvPTDs1wXsAPhcZCsgT0PP6NvAOxc4E5PplxGpVmPqbzqvNTxGtW7eSPncYQnxLydW0I
 PrCKWhlpaUdpQwBy2CECphZNOsYMq7VSrKzVYO8TA=
X-Received: by 2002:a17:90b:5343:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-36a6772e208mr4509480a91.9.1779487399620; 
 Fri, 22 May 2026 15:03:19 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 12/64] target/arm: Add FPMR_EL to TBFLAGS
Date: Fri, 22 May 2026 15:02:14 -0700
Message-ID: <20260522220306.235200-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prepare to perform access checks for direct and
indirect uses of FPMR.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/hflags.c        | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 4 files changed, 46 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e9e261eb2a..2a93de4132 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2567,6 +2567,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 273399a732..9dc0eed630 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -199,6 +199,8 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* FPMR access exception EL or 0 if enabled. */
+    uint8_t fpmr_el;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..794cdf00b2 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -237,6 +237,44 @@ static int zt0_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for FPMR.
+ * Compare the EnFPM bits in the "Accessing FPMR" pseudocode.  Note that
+ * the floating-point enabled check will be handled separately.
+ */
+static int fpmr_exception_el(CPUARMState *env, int el)
+{
+    switch (el) {
+    case 0:
+        if (el_is_in_host(env, 0)) {
+            if (!(env->cp15.sctlr_el[2] & SCTLR_EnFPM)) {
+                return 2;
+            }
+            break;
+        }
+        if (!(env->cp15.sctlr_el[1] & SCTLR_EnFPM)) {
+            return 1;
+        }
+        /* fall through */
+    case 1:
+        if (!(arm_hcrx_el2_eff(env) & HCRX_ENFPM)) {
+            return 2;
+        }
+        break;
+    case 2:
+        break;
+    case 3:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ENFPM)) {
+        return 3;
+    }
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -500,6 +538,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b5f953ab0a..d1a581acfd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10723,6 +10723,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
     dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
     dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


