Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A824DCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaW-0005tV-FX; Tue, 16 Sep 2025 10:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa0-0005i7-6B
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWZu-0008HY-TR
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445826fd9dso65598555ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032561; x=1758637361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3xm1kMJVy9epiTvDaZGGXppX5/JPVL6xwbTCzPX0xU=;
 b=y3QarTMOHAL0Kk3Zr/nlcd3dYEIeFwTh37+pA7FHXdodzWf//kDKeJnKvQ74697JXx
 sHNdAzDKIT4m/xRDGCatPRzrcnGEmkd83QSWfPWcBpwLmZ5xlNVzXxQPMiZbDD/1CjSy
 kSH5l11sakNmqM7cKWb4TXujsMTqOyelRx336kpXZtlTGk0/9tVrsE9KAh8emE6GxiBo
 kwYeJ3I8QM+SqHJ84j8wPBuf+SeZ2wlkF6J3LppwveidYoKLqcK6A2D6NzetRXJNEAXH
 aSvOLa9nbuhqzfqZBTqPRDPCnHucCNEpv7aiF166fMFBujW8A0rhFsy4smI998BrFz2e
 +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032561; x=1758637361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3xm1kMJVy9epiTvDaZGGXppX5/JPVL6xwbTCzPX0xU=;
 b=WjEoYua50931+TPA1LeFB9fr/+ijAhJOLgTKI9VpB/f6kZlC41KXP+4jceZE5mwrGv
 uqjVj8E9zjnu5/39w73283QT8nVzV6XNYuvAvKqbNyEiXD4Wlj47yhETR5XacjiC6A5M
 Sr6SVDdbr1vvHeRoMUGku+BpnryhkGX4VmbtDx+GIRNmu+7bC5JUsgwIiRegvpFPvkGH
 OdtuoFF46fPwCMXNCB3NrUECPNjGjhx8il8ho9KN9mKyrhuc++TGJ7QAVUyjSgCxq6rt
 y6Nz3cdo4kyd2jd+A4HoVJtYGtcli4h0gkTRLUSJ7zhYJ/fxKdgxS66iC0ccUjQE0t4M
 4tFw==
X-Gm-Message-State: AOJu0Yx2tlXeZfFeSqUB/CVKCoN084LU2K2ng8yU6bITcGTXP/ABn3A2
 FkV1oeBTT8KCO4VYCrAoYnttSlLjttYlUWr+m/uTkwDLdNDOSyaxg+StXYa6119buJ8mzHRILwK
 LVq6N
X-Gm-Gg: ASbGncuThKnHqTXRhSisNp1DZyNAInPxfaUUG9znMSrfyzRpPkUm2XA7NgJERlNLDto
 2Hl1nM1v0+YJA/6umOcBKj3+msmyuvTsueQo0T7t0DwU9IumEoIr7h+KyZr0waPql19sVonWDb6
 DnBjEqWzOc3I5gNAZME9QI2q7QtR9sv10SM7cNVHT0p747aTMknVBgCIj4+GMVd/4rY/LC7L3Z3
 NCh1t4qn42q6ajC5S1c93x9WJgDDehkMHwoHY1VLNyj0jPpdRLWC40+6PHNPUIFB01zyRGEsjrr
 T3Jp63Jh+kNnVj6diHEDgoP5jE1AIpbHCJS3ARpD7HGFavqCoep/12Pksde57uE1korBFpp3lYL
 HLk/99A6L/XS7QdeNPVbqT2jU95/Y
X-Google-Smtp-Source: AGHT+IEKYFr5mHf6j9pPZf1kw+lkToeLk+paj3zDSHydNPbS1vfxBAr8FDnRmwXS0QuIe2iW0HXWBQ==
X-Received: by 2002:a17:903:287:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-25d276242femr211550615ad.35.1758032560961; 
 Tue, 16 Sep 2025 07:22:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 02/36] target/arm: Move compare_u64 to helper.c
Date: Tue, 16 Sep 2025 07:22:03 -0700
Message-ID: <20250916142238.664316-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

We will use this function beyond kvm.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 +++
 target/arm/helper.c    | 11 +++++++++++
 target/arm/kvm.c       | 11 -----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5a1e75db3..41133df778 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1999,4 +1999,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
 
+/* Compare uint64_t for qsort and bsearch. */
+int compare_u64(const void *a, const void *b);
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19637e7301..df9e0c7bca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -40,6 +40,17 @@
 
 static void switch_mode(CPUARMState *env, int mode);
 
+int compare_u64(const void *a, const void *b)
+{
+    if (*(uint64_t *)a > *(uint64_t *)b) {
+        return 1;
+    }
+    if (*(uint64_t *)a < *(uint64_t *)b) {
+        return -1;
+    }
+    return 0;
+}
+
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6672344855..9e569eff65 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -718,17 +718,6 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
     memory_region_ref(kd->mr);
 }
 
-static int compare_u64(const void *a, const void *b)
-{
-    if (*(uint64_t *)a > *(uint64_t *)b) {
-        return 1;
-    }
-    if (*(uint64_t *)a < *(uint64_t *)b) {
-        return -1;
-    }
-    return 0;
-}
-
 /*
  * cpreg_values are sorted in ascending order by KVM register ID
  * (see kvm_arm_init_cpreg_list). This allows us to cheaply find
-- 
2.43.0


