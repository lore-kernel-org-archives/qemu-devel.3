Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F001BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R5-00069O-Gg; Tue, 07 Oct 2025 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qx-00063k-FU
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qe-0002PP-GW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so68787345e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846350; x=1760451150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D40qfYdygi4qxK7R3G0gRUYsCh2wZ6BpNynFJicW9VI=;
 b=Y64O6W+lgfyKgXu7vOD08T1UzQ2PxxkABbmxOJVIJ2J8CpgMKk151XL3BDP/jIIr2o
 M/Jlxpr16nBeK45B9WsACO1ggDYft5BZEeuLX0WgG6mO4Ou3CaUSfALs3NblXYT9ashl
 z2lnlPK0yptmS5f8in5YNwy9Tv+T4EnzIrJCEjpuD8hr/BwI7L+VQo4BZ/YRY8EjhQPN
 5gKCMTD/4umuyvaGB4O59BMZuvmC5hYan5LxZfkXZ4EntbDXFHhxwaOMTEJt2BBIaa8h
 4xsD/tOn3jXOWz7MyQnysPoigSOn3rfpIanK5+V2QfMcjyvH2p4XsKkukA2hcJvUhiPa
 aXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846350; x=1760451150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D40qfYdygi4qxK7R3G0gRUYsCh2wZ6BpNynFJicW9VI=;
 b=kOxD+/zrUDUZ80AJS2hQ37olWPqkpO5I+m2UJZam02GZuEzbRYeIdK5vuk/mZkdDoj
 S2RYpcpn1jV1UDFcsawGlrkj+zXy4AimRVGmh6/uhpiLOENYlUCAwz889NjXYh9T7UXV
 ASr5G3aYQ/RXz9yn7yvHRBCpj77nsADdOGRE1RcQRZhfXIjz8Bi5VSvK9OTJniBU2kvx
 +cYIhr9/q6uGmldndBnXPPfEUcGZX8OWREu8nmAuwTljvSngEF8xhJdS11GsfjOk2dJu
 edGI3zFaiE80B0vitfXi9t0KXbcqlKgqowvyiOSv9h4LcUI9kklrwpWE8sqByhv70KHR
 6exg==
X-Gm-Message-State: AOJu0YwI9BZ3rLvGPArHWz2tvoQQOuoGDdZfXgnFNnbVBLa4BdOloPXM
 AGso2dAAQkTD+TbtP4bYuc/lCnEJ80szPNTW97Kh4BGtuZyj2gwHigG/DtdQH3k2CRijE2ci873
 0FzM3
X-Gm-Gg: ASbGnctvoO6i2W1/QDXPYU/vacbvvHr1DV2DviV3hagVQ8TlNGq0qkIPryhY0Uq88eI
 7SCdTW3rfnIkK9zDl6ZYHuh72UCQ+OYOLZyk5bP5VXgmuK9gO7F4B0R/gae5yjFOf92wuRhlzVM
 WG3Hr+J7KKceaT0dxPm5kK+8vwWCPs3K70dNHKek94kQsy0HOPPhaw6HPPwBu/PZM3rSk55/f+z
 sgDpW7hEdbE6g2MO3F0bzXsHPvbZJPfCVT7B7iofvRq2Be1130xsrD/Y8bBfSGKy8ken4yV6M/h
 ELsYvFT7EDa8EN+L831snGiluZQra84cRwI9QlRKN49mhv/6OD3bBpUKdc7h9SoUPUzim51niSg
 hVy2DG2Rk/3Iiwg8it5p88H5zCuyV/FGW3YBYIbogPX1PrHkVajwyX2wY
X-Google-Smtp-Source: AGHT+IFhlIVIkeoD1uv8TR22qC77+F5sZjTop4P7TPHdCKSZvMc2SHnN+jGNfAiRinFcNFVEqNlidQ==
X-Received: by 2002:a05:600c:1e20:b0:45d:f7cb:70f4 with SMTP id
 5b1f17b1804b1-46e7110ef7bmr92097965e9.13.1759846349562; 
 Tue, 07 Oct 2025 07:12:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/62] target/arm: Implement SPAD, NSPAD, RLPAD
Date: Tue,  7 Oct 2025 15:11:19 +0100
Message-ID: <20251007141123.3239867-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These bits disable all access to a particular address space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 56a3cd8fa0f..36917be83e3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -387,7 +387,25 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     l0gptsz = 30 + FIELD_EX64(gpccr, GPCCR, L0GPTSZ);
 
     /*
-     * GPC Priority 2: Secure, Realm or Root address exceeds PPS.
+     * GPC Priority 2: Access to Secure, NonSecure or Realm is prevented
+     * by one of the GPCCR_EL3 address space disable bits (R_TCWMD).
+     * All of these bits are checked vs aa64_rme_gpc2 in gpccr_write.
+     */
+    {
+        static const uint8_t disable_masks[4] = {
+            [ARMSS_Secure] = R_GPCCR_SPAD_MASK,
+            [ARMSS_NonSecure] = R_GPCCR_NSPAD_MASK,
+            [ARMSS_Root] = 0,
+            [ARMSS_Realm] = R_GPCCR_RLPAD_MASK,
+        };
+
+        if (gpccr & disable_masks[pspace]) {
+            goto fault_fail;
+        }
+    }
+
+    /*
+     * GPC Priority 3: Secure, Realm or Root address exceeds PPS.
      * R_CPDSB: A NonSecure physical address input exceeding PPS
      * does not experience any fault.
      */
@@ -398,7 +416,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         goto fault_size;
     }
 
-    /* GPC Priority 3: the base address of GPTBR_EL3 exceeds PPS. */
+    /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
     tableaddr = env->cp15.gptbr_el3 << 12;
     if (tableaddr & ~pps_mask) {
         goto fault_size;
@@ -502,6 +520,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         goto fault_walk; /* reserved */
     }
 
+ fault_fail:
     fi->gpcf = GPCF_Fail;
     goto fault_common;
  fault_eabt:
-- 
2.43.0


