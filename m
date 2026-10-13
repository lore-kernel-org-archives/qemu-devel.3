Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB60CC6B13
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4M-0000oC-Ku; Tue, 13 Oct 2026 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3R-00076M-F9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3L-0007pS-IA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so23058945e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880805; x=1792485605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iEX+WzxiZFfdpDo3ifOhYecTGAzyVyR7DGadGLTp9Rg=;
 b=IkRMtWW3tafpC+OYylMBOA54VUYCzHt8Two70H4zkbTXUuVCXGElYbsKqVsLnZlSCV
 fA5KgbABfA6bbYkbOz0az2PKXKnn3mD0WpK7kE9AqinqjeWHIYt9kbMScrDk3waezSq7
 MfWngMgo2Jm4wMI2Q3d1etpH10YYAdnzbcMHBISZUCwTBdDwvizvpZpVmZ0vxQeP4P36
 SY+CODaGxHsLkQYJqBxVXoj3kz18TmVTagCVqfFot2cQmXRGgCkG7zlt9YGsHv3SXBGh
 Wb4uDhTV7j2JgbPdHzl46c2GfM0NfHogHFVqhzqF/2ZqZzGKL2QOvH6DD/evSQlt1WIj
 fGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880805; x=1792485605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iEX+WzxiZFfdpDo3ifOhYecTGAzyVyR7DGadGLTp9Rg=;
 b=uRoSYzRjLeJF4ACnWydSRuUiDQ1vOjEBq1CyJBr99GpILW6y3+6CX/KeRXWgdFcqA7
 BKuXexLqGQ5EPQxJIeBxh4eEGNFyy4QJI94Eh/XXYkcY4s5g0hZbedcIbF/s1W5OTYCI
 wqdM4z358+o7XMWCPdsAwpe0xtlHUJoWRQNCOirzmV66ZqoOInwW0lQBzlh55Mb5Rx8T
 PKiJ1YhmAEnpz0RHA2yEDNocp/xDpiH+rinGTg3bqeOB4dcUk62bxUEBjne9Cb6UyzDf
 +K6rYQXhRWSRJImhVaxxngdNXKnmZ2Az3WdDLaCMdlP1W8eAS9Qf++AQbHIXw75bB8qb
 5EKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylQT3/ERY3Q3e1SvwLzwA6N5OVkQ8vilYpFCI4B9DphYD1ZNAmeG446VR8zM2vnOe+iJP6fzLDFu6m@nongnu.org
X-Gm-Message-State: AFq9FYKbI2UE2vzKRlzjfojSa1Ye+ITDdWuaENSvdYIuyvtqoaBuVZB1
 30Q9f5/J375h5JPEBDkP/bBJ6xgsSWThyzvT4VVeCNywUsgz9oN8jFcik0EZglo1sVw=
X-Gm-Gg: AYBFou1nyrh3hfWxWELHMwPgRYZ6tds2YhgcgRYmTmcu/yNHc8hDzdXpv+rO5CYXUzs
 8pKcOaKkPzrOILUvORzgD3N9kTSYb2gz8tiUGntnz/Pnmlcw54Xt38my14BN/QAZcJSiZYg7dQI
 Kw6k//OJ7ZI5baIDl9YiMrPCyvB8gp0QMI0SkLkI/Q6cWGJJxTEMpmRowjm+hhIlVFeWvSq2Ach
 G5CZW4CuFVergukagHBLGD0k3DAxHoNZzou1MBvYixtXN+XuYLxodZG5HEDwO27vcKzSWrTmeoS
 M9G3PVAYYQqzg36OKpKLvbzZDSjawZcN8jDX68dzHAkNnYZ+LRWJIYeU9Dw7p9pS19ljS9YbMk2
 dkmEiWvVikKGp2zju7FZ8dsDyQFJ8c+sPEBqmXgqKLJ4RULl2Kg+ZY1xmeZg6/juSwaToVHxYVl
 N5P9i7MX2syH1PmG8LfLo4W3oM5dfaq0EcV8/gHo/RgP48MIrvdxjyEAtHBQ23HV2QQfThgNdaF
 Dn1p6dqjro06+T34h1YkNXG5x8IECbxzyke6etZ8EXJDOyyww5J46dBGNG49OWU0SmW1j9er/TZ
 Yh4=
X-Received: by 2002:a05:600c:4ecb:b0:4a0:c01:1902 with SMTP id
 5b1f17b1804b1-4a18e43a29fmr236742755e9.2.1791880805159; 
 Tue, 13 Oct 2026 01:40:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 22/86] target/arm: GICv5 cpuif: Implement ICH_PPI_HVIR<n>_EL2
Date: Tue, 13 Oct 2026 09:38:29 +0100
Message-ID: <20261013083933.1024405-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The ICH_PPI_HVIR<n>_EL2 registers allow a hypervisor to hide a PPI
from the virtual interrupt domain.  When the bit is set, direct reads
and writes to ICV register fields for that PPI are RAZ/WI.

As we haven't yet implemented the ICV accesses, all we need to
implement here is the cpreg and its backing storage.  We will then be
able to test the DVI bits in the functions that add ICV read and
write handling. We give the register a writefn because eventually
it will need to trigger a recalculation of the virtual PPI HPPI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 276466d2b84..81fb68facb9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -600,6 +600,7 @@ typedef struct CPUArchState {
         uint64_t ich_apr_el2;
         uint64_t ich_vctlr_el2;
         uint64_t ich_vmcr_el2;
+        uint64_t ich_ppi_hvi[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_enable[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 8cb790204f1..93141c751e4 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -493,6 +493,12 @@ static void gic_ich_ppi_dvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ich_ppi_hvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 static void gic_ich_vctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
@@ -1002,6 +1008,22 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_pcr_el1_write,
         .resetfn = gic_icc_pcr_el1_reset,
     },
+    {   .name = "ICH_PPI_HVIR0_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 7, .opc2 = 0,
+        .access = PL2_RW, .type =  ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xc00,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_hvi[0]),
+        .writefn = gic_ich_ppi_hvi_write,
+    },
+    {   .name = "ICH_PPI_HVIR1_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 7, .opc2 = 1,
+        .access = PL2_RW, .type =  ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xc00,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_hvi[1]),
+        .writefn = gic_ich_ppi_hvi_write,
+    },
     {   .name = "ICH_APR_EL2", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 8, .opc2 = 4,
         .access = PL2_RW, .type = ARM_CP_NO_RAW,
-- 
2.43.0


