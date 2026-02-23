Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED5EC1111
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKk-0002Tq-TJ; Mon, 23 Feb 2026 12:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKj-0002S3-2Y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKh-0000Hg-Dq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so26660115e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866174; x=1772470974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Mw22eOdEKGVrHgSJcdy0DJe9ef4kO7Rp5jrpc0VMn8=;
 b=qJADO7yvPw292zSD2Jkki4HHi5KIPUwQBhKxqg/tgZCsWlU7AkxDFc0X5Ygu8/6+nI
 YXgoUWDNb+UtCi8BTNvuv8q2Cx754s0F3wL6aNWOgaNiaLHbPGGsbVBptDXq9CPAb/DW
 CflsoIAZNOFPv+YCzdZPwRcfqMZN7A+Vp30CXTod8poK/DF9QaU15ysx6IZuTcipZJNQ
 mw1SnSoemNDke9RGey4JIsyDogkMjnxoTzpHFyUJ7txo7wfpezsPawThgpTyZwJqXiNG
 4OzpNwH2xqefj3XNSLi49E2RdajjuLZPnf+xWySwypWrEIsux/Cp+x8SzcKcgOgtz4T3
 iXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866174; x=1772470974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/Mw22eOdEKGVrHgSJcdy0DJe9ef4kO7Rp5jrpc0VMn8=;
 b=YEQNCL7Yh9nAIK4KoCbkYlH7g/slW11ZWb/4jsuqvRySugRqmjjIF95tIVYphcYAb6
 nh1zJeBSFy6+YqmKTWOvmwxLB2mwsh3mRJ5PwFu4pczh0a/cTwmlySzo7mC61ajoOV3V
 /oTMKjWhutz/e2yOXXjd5TbovEgX7PektsZdo2h9oPxWjoi1vPQs1VtI0DFBekJ7prWJ
 vJUJsEMaVGWvmjocLY1niRfyq5P42kvtm0jVv4TIt94MshiW34vTdMT5WA62bqVLvya/
 rQCnEfeg3g3ClQ0UmnEDnjA85CYzsKqqPmpOyYgwOvbcEHbAQ57kSpi4eZYSbjQuObrY
 +krg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpC1skLeZgKzDrq5k4el4r+jVySMZiSxTb+rEYvvRnlZB2HTzVfYeIO1BKAbKY1kEUutFr1PXnXe5c@nongnu.org
X-Gm-Message-State: AOJu0YxYRZqxyqMyvCVPaGbMpo6fT0haEHlRry/YQW6QHMDg+R07slpG
 xkBqrZ9FSdqsJesmbHEPCJY4rdecdmRYw2Ev5yKGZWvgY6XtvmBEx0xAGid0s5mbZZ4=
X-Gm-Gg: AZuq6aL+Yk3F0WO89XOXQtG+RZfrcXjedAt2bCEIPNlt8RrT+yG2OYUEQgyByu2Y9vU
 N+k/oqGdudb0SymB9g2J1S3ps/Uk/oEaEN6BCgjRTwXxTCjqaBfdV9vbozWINH2ve9BxVYWEGA/
 bxgYtRaQ46gJQ4S3NsHJwMqe3HjZkfcKOwvGbqQlXTjXPXfBX+PYvHgUy+6XcRvvibZPCrl7OWj
 0qjqxMOGmq5xqKxT5qRvC0UG9KlOJToHxJ0hw0ddzKq8x14n84iiOzSXU3nN/FdsiSGeEf9b9OT
 zggZL1r7bi+lgSymot+5iAWAbpGCS2FxdT1p+6w2XuB0b/YkFETn7pcuSdk6c/s/vJ/BO9Hyv9G
 +XOU1m9VMe4at0xcXk9BgEUottxTrkPsQp1qp9AwZBzIYLfLE2ev/CbffIyWVuYcnKELQE8gOAa
 NgG733pfDfEjblISoZt/HWemGEenNwlYs8PuC9QE/G5W81JIlKmGrSt4P7aq0K62U1jSmoCdpC0
 t9nNZG/EM328enFVWGKzG/vdBo9zrLc4dE14eOxLA==
X-Received: by 2002:a05:600c:1c22:b0:483:79ad:f3b9 with SMTP id
 5b1f17b1804b1-483a95eada4mr163288105e9.28.1771866173689; 
 Mon, 23 Feb 2026 09:02:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 35/65] target/arm: GICv5 cpuif: Implement GICv5 PPI active
 set/clear registers
Date: Mon, 23 Feb 2026 17:01:42 +0000
Message-ID: <20260223170212.441276-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
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

In the GICv5 PPI state and control lives in the CPU interface; this
is different from the GICv3 where this was all in the redistributor.

Implement the access system registers for the PPI active state; this
is a pair of registers, one of which has "write 1 to clear" behaviour
and the other of which has "write 1 to set".  In both cases, reads
return the current state.

We start here by implementing the accessors for the underlying state;
we don't yet attempt to do anything (e.g.  recalculating the highest
priority pending PPI) when the state changes.  That will come in
subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  5 +++++
 target/arm/tcg/gicv5-cpuif.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a32c5f3ab1..dd4dc12feb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -257,6 +257,9 @@ typedef enum ARMFPStatusFlavour {
 } ARMFPStatusFlavour;
 #define FPST_COUNT  10
 
+/* Architecturally there are 128 PPIs in a GICv5 */
+#define GICV5_NUM_PPIS 128
+
 typedef struct CPUArchState {
     /* Regs for current mode.  */
     uint32_t regs[16];
@@ -600,6 +603,8 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
+        uint64_t ppi_active[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 36d1c196a8..0132b13853 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -175,6 +175,20 @@ static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_handling(gic, id, hm, domain, type, virtual);
 }
 
+static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old & ~value);
+}
+
+static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    raw_write(env, ri, old | value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -254,6 +268,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
          */
         .resetfn = arm_cp_reset_ignore,
     },
+    {   .name = "ICC_PPI_CACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_CACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 1,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_cactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 2,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .writefn = gic_ppi_sactive_write,
+    },
+    {   .name = "ICC_PPI_SACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 3,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .writefn = gic_ppi_sactive_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


