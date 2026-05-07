Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF34CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OO-0000KW-KI; Thu, 07 May 2026 19:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OL-0000Hi-MH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:29 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OJ-00012S-PG
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:29 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso1234700a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197466; x=1778802266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBEpCMl8nikzb4pGbSsObaFAkRMOHpI7n4RJ+Yuy9pM=;
 b=LIXtsaywE2+0Lb/AhV21ozlkF19yOyhNCqXZIhf+ammq/QljuMj5vky7accGXDffkM
 tDWqmBXRQwq5B1SthBAMC+IRCjPFNYtwyQEbZpShAxsgd3WmSrzB01y4VPVSMvZLx2FB
 Ca3Q/gA5krI+ykk75SI0WZWTGhVHOeikfzbsmXjVuAnRje531xkbtlAZwLSW96lKmzBb
 +7mRz+USWy4kFgvi7uzI5SdoLI6rPx4DEaaKMFRHEF1KZ6kG+d3RPQnBe5Hq0vjUJqGV
 aLZJYIrij19bAtIrXlrpHO6s53RFcFNjw6hMv6uydHhHknihRwzlwlyuXE1mT2F/5FH4
 l9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197466; x=1778802266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBEpCMl8nikzb4pGbSsObaFAkRMOHpI7n4RJ+Yuy9pM=;
 b=hzJo/1xZcc1y9S/FRX1vGFxotVHQTrZbVM5V35dxZZpeLZU3SPdemlTqLOX8v2tKe9
 LX68DNrX2zUaT/Q7oYusPs2dKjmv8mVmTo6L6YvodldTgMzUWVKYOJMMSx5I3nTt+T/J
 lrkE0cq739HVUcYTUlydeGFrQM0k6dIE8Wpl9QqpHLF52Q8jkqAtWYnoqwNMi4M2oTqG
 uhWv/WfjL/4kOMXO0x62SM0WfIO+lf0N2egwWI98qU1sb2uRrMwdKvRSUVNHs7KgzKJe
 JqyerTmdjJN3aJKjCckxCdjzFBAc3Z4RTMUbkDORhJPLw1eRevmNlP+HDS1+ZYgWORt3
 XK3g==
X-Gm-Message-State: AOJu0YxZWCu0zOipXMGxKXeHs0VakUaM6+O8y0YdvMaouwue6vwKNiQ9
 /oM9c3InnPbQ+hInJFPsbHNK4EcCunkkC8alvVoUMsh2I0m3az4s/+HutJWSrd5uRObpTzs/E6A
 TKwMa
X-Gm-Gg: AeBDieshELiynZ9QMq6xJK9Tyb7K/Upxw1DOjDPG/dBCODIAFqaQe0cMzcqrnxISSHE
 PrkoxrmWkndNn9Lf3aCh9lGtprXSx7EvPa/rMQKksX1AebSWwKTi4OPvcEpul/5wNDnP767AnF8
 NesjrVUprqgZUfrCkORsLjDVBCDeoCp9zQ9iyxVLPT2GcN6/as7MOKM9fLyu5bg7jSytAYzcR1B
 O3cH7+XxXrja2oReuvrdmcY+xa7Gyo5wXoYpOZoFyK53p0w/vy52er/XES8YgRIG0H6bBp5WJ2K
 oQ7gtRL2MBED1iI323z7LzprJM0L3Esp6CniNFLXJUzkYMD4UVoFtZoAFvau/hUvhK07JEPe5y6
 aNR4tzq7ovc1cwTsIKL5XzlHRucwdIPtQhS0GL1jvO7JEoCUSxf2EQKdZPUWCjpNchMF6HSxD3s
 F1YJ0jb9XU6rlgjV+1yzrRctiwNISpsL2pZ51cuw0zUudrbQ==
X-Received: by 2002:a05:6830:1299:b0:7db:a297:9e62 with SMTP id
 46e09a7af769-7e1fcf48a25mr2312137a34.8.1778197466321; 
 Thu, 07 May 2026 16:44:26 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 12/60] target/arm: Add FPMR_EL to TBFLAGS
Date: Thu,  7 May 2026 18:43:25 -0500
Message-ID: <20260507234413.643512-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
index 8f2c13ca20..24707ac085 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2542,6 +2542,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
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


