Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48B3CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZD-0007Ye-N0; Wed, 20 May 2026 14:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYq-000738-0j
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:28 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYm-0000WF-Kb
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:27 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36622412e97so3784194a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301343; x=1779906143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2YowRxNRLBYS6ametaessFL4W/WU5kteC+kwFAECtE=;
 b=pCGxw6h12kzG2cz6T9BgpiJOdK+Fvwii5hXO05m+jhYl/GMJxCcKInW6zI349/DRrM
 b+x9DvTcmtsJYFjAimVyuHC19xpAjssb5bLvx0lsLoI0HhBSzMgvtiXxsXvE7v9OAmy2
 hezjN0mgyzpWP6lpGiowzgHEGdcCLbCgyQ/4KkJhjF46imCDKgpX45wKTDTwj8n7SCIG
 W9xW3gPNWUwUuh38AGx9SOl51EwvJi8QMkh8L+xNzDoY02cBHPJLYIa7AR6Iu+LmX96o
 PbCMC50MC6gYav3k88cfhjzT0uekNViVLIAaxcjbJYQYCj1mQvChPjwDsu9WBdTtTBfb
 GTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301343; x=1779906143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2YowRxNRLBYS6ametaessFL4W/WU5kteC+kwFAECtE=;
 b=keg8FJbFtQk8SZBj1wPCffWc+M/kUf0q3E4+S8y1E29jIJNl9ooqpe1kA3Ddi4mxDu
 oKjwA43FOdHNf4LFAlX+Fr5r97f0iNHuGLDHjRYplI7go9/ArWmo+0yfgwW2qZI2FAlv
 NOQKi6wDxYXXylCKsEz2Z6wFeQ1/ZSG9CyMbhaRtWz+GkqIHxGX1ZGLj6Tpsw6XIsxpl
 J4kGN03QJros7WJTeCS0zekaMg1i48vZclymvjU1QIZV0vv3WTbpDL7nRvQ7N2lFQ5uS
 d1CwEpHLaLcBoxYE5yqOi7MDzznTa7XEO7q3vEuW/GU1vV99mb7HKZk4GyMhtibWnDKU
 PKtQ==
X-Gm-Message-State: AOJu0YxWWjq27ZbcjtKanFxSilAXt73M/v+xOaJ9XZbtDdrxaJZgwQaX
 6Iovq9pl/C0L9/eoFYjD8KNSPwAhURKId6xwR/TkYlQV8TX1QY9AutyESCzDkwsLSE3TtY86m7I
 69uw9xxE=
X-Gm-Gg: Acq92OFv0qJK8xptb/xBVdC1BGKC2kpbCrWx1vhyUU6lbwNiRJ/r9ZfdVNY2JNvVyH2
 Cp+lXzIuiKpYbycXDfnTjNwJZQOBsvNtV9vhbzyQ/LqRdmHA2zElB2PdPTy+CHtdoX9Jsoum4wo
 ZC8wkswfYGsdLpQKDhP6u2QsvpMgpuud12DeUyhHm/UgQgTy2ndeJbHW/nP4AJO7UJB2vRO1vdx
 GAb8hicJ48eKsK3sIXM64dNVNKFlOEIdVb7w44bozYhDV4g1E0RrId5m54EikuCFnlLl/J5wffr
 katsnTx6+A9Pi8RIZ9buhZoE7DAw1vG2LbEOMyFY3WbXGcosKm3y58sQObfnPyJxKTD3v7u/zP1
 nqFFbehn3hWhJcI1IUSC+sycULPZCLxjesDzUg/8u312wbjVQGN0exFz0nlTSAaXOnzSAeiVMke
 sM9lyk5RJtxAXIOzgZ2Y7uyr8DlyGD
X-Received: by 2002:a17:90b:5483:b0:364:78a5:8d40 with SMTP id
 98e67ed59e1d1-36951b92cdamr23209080a91.20.1779301343075; 
 Wed, 20 May 2026 11:22:23 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 12/64] target/arm: Add FPMR_EL to TBFLAGS
Date: Wed, 20 May 2026 11:21:21 -0700
Message-ID: <20260520182213.872945-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/hflags.c        | 41 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  1 +
 4 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c114510446..9e637c1d80 100644
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
index 77fdc5f3a1..1648c2c96f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -199,6 +199,8 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
+    /* FMPR exception EL or 0 if enabled. */
+    uint8_t fpmr_el;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..6759b36f28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -237,6 +237,43 @@ static int zt0_exception_el(CPUARMState *env, int el)
     return 0;
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for FPMR.
+ * C.f. the ARM pseudocode function CheckFPMREnabled.
+ */
+static int fpmr_exception_el(CPUARMState *env, int el)
+{
+    switch (el) {
+    case 0:
+        if (el_is_in_host(env, el)) {
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
@@ -500,6 +537,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
+        DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c6559964b..b013dd51cb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10726,6 +10726,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
     dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
     dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
+    dc->fpmr_el = EX_TBFLAG_A64(tb_flags, FPMR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


