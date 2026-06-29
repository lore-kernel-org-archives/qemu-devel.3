Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94548C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgK-0007Ns-2e; Mon, 29 Jun 2026 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0006xf-RP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfh-0007Ri-L0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47362928f65so860115f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734463; x=1783339263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=67pmUAGyOu72n9LuXKVvGb2krgLoWbDoGX2iygyfoZ4=;
 b=eu85cG6ppKJ2mwribqln5POAOIvg2dfiYZveVWVjR/3E84PwKz6bqUcNzvdTD0gGbD
 GiP890vKwWN0UANbkSHPlbXQd/N2xk7opfd3+j+iTxSNTidnqAZbJ2moL7fA2yLCvvFx
 eZ4/xO0ow5SrJDppyIfywBi461bdnaqJ9EA/NwurUn1PdNmHEloBZ3OMy+Phr0VXhHcX
 szyT48Mje+XrgY9APuXe9PsYA401Ar4SUormqNQIxh5dDggsCcL+1iRzXmpLuUXhpF4N
 ch94NS9cIUadHcD7bQste+ArcSPmmV4RyGgPUOpWotmljuIHIVogBplq++vUDgahIAwU
 kPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734463; x=1783339263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=67pmUAGyOu72n9LuXKVvGb2krgLoWbDoGX2iygyfoZ4=;
 b=RvEYUG5kcdC4XftXAjF9B1LzTjLaJaU8qt273qJkBFddm6+7brGrQGSZp4BjUe2yV0
 iRSFx8uqG3YzRx8ZUhBRnkxYIYeiyLGBNGVI+Ki7AYiuKzOUuySkTqN+6DoBBpd8mLUC
 PAdoXxJCvyeThrcRBIQ/3a8EJ2kkT7kahJ9xI+CLG/z6rJ9rPE2VoxIXVvYCUMkm6cKW
 mpl7JUkBQpcMMQQITjVktAb0k6i1lJdUgeZxnspH1C+1Uj/NzHq4GPg+Yie8jWbuFyab
 5hqN4+n7rUa5e4V1Ze5ClEKu4skoSwIyyBCL3UUNpoy96LG7X1cX8aiR1KMWqRs/cAlv
 J+Ng==
X-Gm-Message-State: AOJu0Yy2U7QBZkKBl82Fe6Y7WNqTsap6kklplRgqMozo18+ZDwe+yk1M
 jUftcP87dGxWsLHhT19XoUcO6h6D4q+CjbWVcyZdClIqykZBTIO1K81VO3Yk0iTarmx4hbgtgdK
 IMudT
X-Gm-Gg: AfdE7cmzY+OoYkuJs2KiX5SzvowugeVwIHI9TknwVhIpdH1ul8ght4qvsPWOpdEa2L+
 pK+D4yZD520uecfxefvoFOTzyARZ75YlkXAxb8Wt6iyiqGolJZdK1i8maGidcee8xYas4a9LXFm
 RMNuBs5DrAOgljaRZPvlXgWuziE36QWjurICHQPT4qo8yMEX9RhMR8Nov705HfRY7lScwdMheRk
 6HMxqjpGDwbPbLq83BZOTQHQpuQl2CZPlvwb14A227UzwZ3PeFR1HhNE6tnKcE1sd8JijMbfkS8
 9rPrIG8OCN8ydUfbtt51yJ7KAzA9auKFmPV+oj33ChDQQicFZRCazrh8oM55wxKfQ+NTNGLDAJy
 1Lz7WgbV8jsNho/ZfRU6lqZwggBbPhxWtojOLqmRiOQezfd6s5Kkt3I608DmwMfBSTheodxKFla
 6S3Hvo4FdOYHxxpe0L1kU7SbGb1akK5aP+YAYhqdG9LPTxiJtY01aZ/wbOLc9LitAOMwFOdLM7U
 Fh1jRf6cf+lLYm0PJqRlw==
X-Received: by 2002:a05:6000:22ca:b0:46e:8226:96b1 with SMTP id
 ffacd0b85a97d-4750123322amr204765f8f.42.1782734461969; 
 Mon, 29 Jun 2026 05:01:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/54] target/arm/ptw.c: Add Granule Bypass Windows
Date: Mon, 29 Jun 2026 13:00:05 +0100
Message-ID: <20260629120032.1645265-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-3-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1470de3010..99295954a1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -343,11 +343,21 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         .space = ARMSS_Root,
     };
     const uint64_t gpccr = config.gpccr;
+    const uint64_t gpcbw = config.gpcbw;
     unsigned pps, pgs, l0gptsz, level = 0;
     uint64_t tableaddr, pps_mask, align, entry, index;
     MemTxResult result;
     int gpi;
 
+    const uint64_t BW_ADDR_SHIFT = 30;
+    const uint64_t BW_SIZE_SHIFT = 30;
+    const uint64_t BW_STRIDE_SHIFT = 40;
+
+    uint64_t bw_size_field = FIELD_EX64(gpcbw, GPCBW, BWSIZE);
+    uint64_t bw_stride_field = FIELD_EX64(gpcbw, GPCBW, BWSTRIDE);
+    uint64_t bw_addr = FIELD_EX64(gpcbw, GPCBW, BWADDR) << BW_ADDR_SHIFT;
+    uint64_t bw_mask = 0;
+
     /*
      * We assume Granule Protection Check is enabled when
      * calling this function (GPCCR.GPC == 1).
@@ -399,6 +409,58 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_walk;
     }
 
+    /* At this point, GPCCR_EL3 is valid */
+
+    /*
+     * GPC Priority 1 (R_GMGRR):
+     * If GPCCR_EL3.GPCBW is 1 and the configuration GPCBW
+     * is invalid, the access fails as GPT walk fault at level 0.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        uint64_t bw_size = 0;
+        uint64_t bw_stride = 0;
+
+        /* BWSIZE, BWSTRIDE have a limited number of acceptable values. */
+        switch (bw_size_field) {
+        case 0b000:
+        case 0b001:
+        case 0b010:
+        case 0b100:
+        case 0b110:
+            bw_size = 1ULL << (bw_size_field + BW_SIZE_SHIFT);
+            break;
+        default: /* Reserved value */
+            goto fault_walk;
+        }
+        switch (bw_stride_field) {
+        case 0b00000:
+        case 0b00010:
+        case 0b00100:
+        case 0b00110:
+        case 0b00111:
+        case 0b01000:
+        case 0b01001:
+        case 0b01010:
+        case 0b10000:
+            bw_stride = 1ULL << (bw_stride_field + BW_STRIDE_SHIFT);
+            break;
+        default: /* Reserved value */
+            goto fault_walk;
+        }
+        /*
+         * GPCBW is invalid if the base address is:
+         * not aligned to the size programmed in BWSIZE, or
+         * greater than or equal to the stride value configured by BWSTRIDE.
+         * We can make bw_mask which marks exactly which bits in bw_addr may
+         * be set (gpcbwu:gpcbwl).
+         */
+        bw_mask = bw_stride - bw_size;
+
+        if (bw_addr & ~bw_mask) {
+            goto fault_walk;
+        }
+    }
+
     /* Note this field is read-only and fixed at reset. */
     l0gptsz = 30 + FIELD_EX64(gpccr, GPCCR, L0GPTSZ);
 
@@ -433,6 +495,20 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         goto fault_fail;
     }
 
+    /*
+     * Bypass window check.
+     * I_JJLRM: Granule Protection Table (GPT) lookups can be skipped
+     * in portions of the memory map by using GPC bypass windows.
+     * I_XNHTX: The GPC bypass window check (...) is performed
+     * immediately after priority 3.
+     * bw_mask from earlier makes this check for us.
+     */
+    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
+        if ((paddress & bw_mask) == bw_addr) {
+            return true;
+        }
+    }
+
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
     tableaddr = config.gptbr << 12;
     if (tableaddr & ~pps_mask) {
@@ -3879,6 +3955,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
         };
         struct ARMGranuleProtectionConfig config = {
             .gpccr = env->cp15.gpccr_el3,
+            .gpcbw = env->cp15.gpcbw_el3,
             .gptbr = env->cp15.gptbr_el3,
             .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
             .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),
-- 
2.43.0


