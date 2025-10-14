Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6389CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lK1-0002fh-LL; Tue, 14 Oct 2025 16:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJy-0002eP-Ch
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ9-0005O6-NB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so4838496b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472458; x=1761077258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb6Ug62u8i32giQ9ctSs3FRRaaSEfAU/TVaCJ65QMa0=;
 b=zZj+ehXzsBBHo+lVYxYHUgv6kZk/98wTAyQ28WhktH+MUXmwne6cUC3IFyjV84rnV7
 lyUkASROX6rsHY3IAXj48mVZv/acJi7siuaqj2V3jcsEnRn22Zjsxx75to2EtKuKplfH
 CW5mZKGtNalW83Z/0FylZV42qnfXewRLTeB04oYAVD43s1R0Lo0nV3ZCTceANAzY5XZv
 BphBxASc5clIePTj8NnHp4ZzZE7CBGO+iie6W7gGH67lh40/pvTDD5VvbASEuQxzjxTA
 3TyAC2ejckpgh7hGIP+bMKTrVBcG5whgbGmuUBQXyq077FiihzgY4Ejfs0jxmNZ5KS45
 OcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472458; x=1761077258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pb6Ug62u8i32giQ9ctSs3FRRaaSEfAU/TVaCJ65QMa0=;
 b=mrQ+jGghjKmK1YdeNqRSEtiGUkgE5sx3D8NFZ14ukHRcwrJedOkxNRX09QZeSny2RC
 0egqY4ALN/tx4HV7ToxCeXkDRl2GX6eHZsZVbgKneiDSAgXOi9Z3PToyWVgW79/OUcIb
 gvr5FtuS/43twLOwDPHCIGS2ArGdcWQuE/ZXgBzIjcaMFmKONiiUhUkwZFAqNd3UkshZ
 yd0Zrn/9TV1yJD4nLsTVpiPgLLmGWr01YuZAE6SKHW7IsrQbVZeCa7VG85soebKKWiYV
 xWwdd8VnN3CY44RnIgJO0GDPqQ8XSyxgWtdVPvfwmjqiK2GqZT1izKIyVu1GzlQC2yzZ
 YCKw==
X-Gm-Message-State: AOJu0YxtFyHTZHCkBdM+pigzxuyls+SjvQeHMRMNQKWdunGJcwzzID1A
 WeS0LMJZI17uQiGB4dRgVxwkI0S5XJaCdtpW5/Pakc36SN1N2smXyZ2gV++fXe+Q6aZzMHYV2yB
 zkRCpzgo=
X-Gm-Gg: ASbGncsAU0ocSHtybVUxcaNd1hF0VbVIv8yfuos4PII3/u0KBsvQXpn/+NYt6WJldro
 iwAH4jWArgb7wrvD3ymMhWTpIjWJ1f8OMWxN4IGO8aTeUonMHMe/D9zoWP6nPuTe0AmsamdPhgf
 nSjRjeemsN4gzBddjPNOCedN8F8I8n4JnkF9xClVVfJq1e18KTZQCiWL7mG/VSvRUyJJPcMz4i7
 iSNLrjo2F11DsYj2HpytzSwgHoKnqv3kD8zjnJpUcNHqAAvA2+kshEpdA7RKVxdo2tvcV0/1JuX
 f9WrvwPOyKJs6cZLDa2YBqcXPIyAZ43MVpVGCTUBvau8yjDBFcFyNfwG3hhfjknGQAU7ttFF3XN
 kIdwLokWURrsbHNjOMV8gagBfupKv2+tE7xKE8grSvNgYBE6WNxbd7LNbuiyGeLYSDhoh2zQj
X-Google-Smtp-Source: AGHT+IGmnUV3bcelfsBoY5Sh9s8q4WFA0Jh+CKb7Y44kUj1Q4Hqkh3MjQQJwosPZLt1duq7g04QlQg==
X-Received: by 2002:a17:902:cec2:b0:256:2b13:5f11 with SMTP id
 d9443c01a7336-290272e19bbmr403030485ad.40.1760472457861; 
 Tue, 14 Oct 2025 13:07:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 26/37] target/arm: Implement TLBIP IPAS2E1, IPAS2LE1
Date: Tue, 14 Oct 2025 13:07:07 -0700
Message-ID: <20251014200718.422022-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/tcg/tlb-insns.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 1a0a332583..bf8f007869 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -512,6 +512,20 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbi_aa64_ipas2e1_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = ipas2e1_tlbmask(env, vallo);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+    } else {
+        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
+    }
+}
+
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
@@ -721,12 +735,16 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ipas2e1_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ipas2e1_write,
+      .write128fn = tlbi_aa64_ipas2e1_write128 },
     { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_ipas2e1_write },
+      .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_ipas2e1_write,
+      .write128fn = tlbi_aa64_ipas2e1_write128 },
     { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-- 
2.43.0


