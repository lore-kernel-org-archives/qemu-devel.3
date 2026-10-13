Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26274CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3g-0007ee-8d; Tue, 13 Oct 2026 04:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3R-00075x-7I
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3L-0007cj-IN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so22011165e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880796; x=1792485596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FcrvcwO8TfKKXlj5jfLPNIJA9YWvLSs6kM7SKop1Kq4=;
 b=ujt5PVQkNfTI6SyhYanDDDkRFwjaQAI+vkpjUmqHqRT/0bCgUqWPKUhtGf+EXy+4mP
 t/2HZX8gQ/Srxuij++ZIaP0LEYb2u2uj6hgIpZDJTRGOSGL338LYKPW5zF97U2HMTLQV
 2iggm1d3MfaMGFx5txbLK3XVqCU1s+nl8RukLrRr2yHfeUHIwiAHCmzFjW8ZulISCjnM
 kCjWfJkpbs6t2XGmyu7n1/Ogp+VoZyLI089dP7INBISG8ONU4cs5EYTMwB871uqApcB8
 z52KjZVDRo/7SKIM6WeXtgp49zLCIv+VHpb/mGBiayq1j6nlfaX2PCB9B3T8Wx4+Prkc
 ZuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880796; x=1792485596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FcrvcwO8TfKKXlj5jfLPNIJA9YWvLSs6kM7SKop1Kq4=;
 b=Bq1g6N4EWEHneIMsk9zxRyGBnZKcJs8pDGqP8GEmlWjyt8SFu4bojzG35OT2nx9TSi
 cdct9gGR+akH7Lb91HShvlrVayGkAuYYIK9IxsLL4e+EsOAzwAuYXOSxZxKyzR6vGBMI
 IikJ7ewUV1liVbxUGmeMtacaLNHhg9/EuOPs4C1eVObyeu9xBBPmfb6nqb2keERlk8Bi
 q0giYCLkfFyGeT+R2feg8OsYWsBUg1s402dPjgX+uhUVIcJYDbQiPjZd9a2n2x4n0FUr
 4HHUhzf2B+v4+4TCT3tSI4wbYEIWmxBeKZ3iArTMh/usUEogb/KX7E3+sqObTNUYhEYy
 4cKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaSnc1u0e5818t1LXqv6zSSJGZh7ZGE8N8bXvFlTq3xnh/Bm8LyPJNUe4Fik+du3mIR8GpVuarXuJM@nongnu.org
X-Gm-Message-State: AFq9FYLu1kQLZ6ODyV7u0blzBcOdQkn4x24WyBG2Ir7vJGERJnyiEMLE
 CsNydlaEz2WfNe7YqFygNEGmeej+qDbo/xBt41ReZiQtgvd8sak8F9fD6FrWodCJ8Sv8twNusjU
 K6mLX9Tc=
X-Gm-Gg: AYBFou2DWJcC0DGkYk4Ogb9x9p0p1HJpCgRymxBqOuFgwqjmeO5DOk3XlhLoLrDnXZ2
 4kGRFPUu5JygmpP+QXMMUMMxYRBIHnAL6DLiVWaCOKW4W98JRb4evfZPj6Xeky9AvYMzWvY5c8G
 M7Mf+vRjuTQIrBqyj8OezPLD5slhOUe9q2Z8zR625ItJpHB1vU3RKOsDxswBZOpkAxX12Ek9q1Y
 w8VZWmVnjjG++7DW6rfZ7xIuDJ5+aZQ+HW7u+FaSUQRY/OPl3GkUwZJPrGiRWlOyum1XwrP4r+B
 ajg1es9ZRq1XAAZRilAlaXzIQiC3IYwbAYBkK2USsT3e+J4I79zKMumcBG/v1RlRx1dxXSJkA+d
 tUWrCkuTqZmZqEITB8dKZP7vzitPE0ndJcmrDvGaMPmnEP9W9RtGa+m8A6sSvHUj7eIFEYAu62i
 5fw3VdX6l8uDcoJXvodjXpet7Ts7dY2o95upm2NA95EFn2TJu8wlGehDWIgwmeGg3G5CFgT5kK8
 a9KEutt1sHuEXkhS64Qc4jWuXh6K35RHv07EOwWgjaeffJCUdMFTFqj3wujHWPoKRLvBDKgYNrG
 75s=
X-Received: by 2002:a05:600c:3144:b0:4a0:2423:946 with SMTP id
 5b1f17b1804b1-4a18e48d362mr224435315e9.15.1791880796256; 
 Tue, 13 Oct 2026 01:39:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/86] target/arm: GICv5 cpuif: Implement ICH_PPI_DVIR<n>_EL2
Date: Tue, 13 Oct 2026 09:38:23 +0100
Message-ID: <20261013083933.1024405-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Implement ICH_PPI_DVIR<n>_EL2, which is the register that controls
whether pending physical PPIs are directly injected as virtual PPIs
to the virtual interrupt domain.

Bits in this register are RAZ/WI from EL1 and EL2 if the PPI is
not assigned to the current interrupt domain, but since we don't
yet implement EL3 GICv5 support yet all PPIs are always assigned
to the current interrupt domain.

In this commit we just implement the register access to the state;
actual injection of PPIs will be dealt with later. We give the
register a writefn because eventually writing to this will need
to trigger a recalculation of VIRQ/VFIQ.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 287cfa87140..5d3587739d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -599,6 +599,7 @@ typedef struct CPUArchState {
         uint64_t ich_ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_enable[GICV5_NUM_PPIS / 64];
+        uint64_t ich_ppi_dvi[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_priority[GICV5_NUM_PPIS / 8];
     } gicv5_cpuif;
 
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index b901e64ef0d..2141f1d8e2c 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -487,6 +487,12 @@ static void gic_ich_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ich_ppi_dvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 /*
  * ICC_APR_EL1 is banked and reads/writes as the version for the
  * current logical interrupt domain.
@@ -961,6 +967,27 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .accessfn = access_gicv5_ich_reg,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_apr_el2),
     },
+    /*
+     * Note that DVIR bits RAZ/WI when the PPI isn't assigned to the
+     * current domain, so we will need to mask them when we implement
+     * EL3 support and ICC_PPI_DOMAINR<n>_EL3
+     */
+    {   .name = "ICH_PPI_DVIR0_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 0,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb40,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_dvi[0]),
+        .writefn = gic_ich_ppi_dvi_write,
+    },
+    {   .name = "ICH_PPI_DVIR1_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 1,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb48,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_dvi[1]),
+        .writefn = gic_ich_ppi_dvi_write,
+    },
     {   .name = "ICH_PPI_ENABLER0_EL2", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 10, .opc2 = 2,
         .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-- 
2.43.0


