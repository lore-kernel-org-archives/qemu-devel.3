Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A33EC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKn-0002Wo-9w; Mon, 23 Feb 2026 12:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKl-0002UF-C6
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKj-0000Ii-OF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so28245685e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866176; x=1772470976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HXAErUH26qog8NLwcGHpVWf2yib3kbn8Xkw9zUFi3XE=;
 b=n1BRVyzd3r3M5hMt0jlbZhSHfWAmwO4q6UUzNbtc9tG2x5HYPVE0ac7WMoak8qvcTg
 tgwi/t1zCct7Eom1vGNnKXIZpZavqTn+8yJWDrkKC5+rXc/2E8vXwzzYlcQFej6yq0tf
 Gd/xNLeF/J7GnRSNPYCexQQmLMP3bt2DPNQ1ZLLHxeDsoCNeE6qyNI0acSP5K+Zkn+YG
 yTArkkzdLdhpDrXsua3hUz773Uu8B/ARAYdDjN7MrKd8Ew9M45NzBZFvlwMkYe59UlI/
 f+PS0pAQqVr50l38IwaV/aGkLrPnctlW+dYp+kAnWGxcrETN4fwe8v4DAfDC9JbwWfyy
 73aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866176; x=1772470976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HXAErUH26qog8NLwcGHpVWf2yib3kbn8Xkw9zUFi3XE=;
 b=dH0jNJ+H1ky2PcgdePmHicTVvYNUrMnt6M++0eqps0HifNNNX6NB8/nhatV38qKTW4
 u97WyXeFQhgutE4P0Wb7k/HW7YTH05fZ9vQQD1XnAogk155TnJPw/5qbrlaf1fzhiRCw
 KtsMlN6ZF8NTzCgMAYtqDqROqqOSY2d5coH+ISlCRh4PfxeyIHkBbX+q8qd+qcEvppCH
 7TyZGZ0/VSgllyTqxqbiZ2CtfuqgqFaXl42zGKUiCHia7k9HYiUAb4lCJOXyoh4PE8sF
 DBRAmPGvLQAbqqDevMKXptbD0/CWcHEyT3FxG8HTKmiemem/ONJ+QT66OJFHyDPoP0WQ
 w0Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3x14YApvrUtm1jA1W8Clnm/0+HPTbw/Wsgr45/QYVNPR+fgxCgW4RDAR8QopqdsO4f7MYyc8ZuY9f@nongnu.org
X-Gm-Message-State: AOJu0Ywqvcva64IsnQRoWK5bJjbM8yqS6qtDJsntH/TrUmeT9t3Qgeku
 d0Tb0TVNrRp0NB9WpwO5mHjP7zHZcFAVaQpdf+bBeLnYhX60p4Gmqsh+q8VTN+Ec5I7RxngxlHQ
 KNOCp
X-Gm-Gg: AZuq6aIIn5dIVDJep6twpI0F3vcqjzI4Wd6zg9CBhMyoJ80ay13Kz+WOMvJdzQA1VDo
 M8TmEFF5ntt9TNujTnp3VEnOl2a0Om2pUkVhGdYF2MGfD6NGA6zbpqLX0K3rCF0fHMuG0sTWcL+
 1XC6NTdNkmM/kZHqifzp+ey5rdXdAoY2h0gsnTvIIdcQ16Gd72XfbebmmFxYEwan81YyrpsOTuF
 wdgVx5haZP5vsh2/o0nnY1YmD51S7vKQxgzprxBlrvgxEClz3WHpQ2KVvFlgA6TI9IMXC7Q3aaU
 OGuu7aWSHvCwu9vxspdslpbiXbpkzwGCHueWuAqiUmUhF1nehEEf6KJ+cesC4v2MrguSmESrTPw
 R3tYeSOpiw0HRtFZVSKrRU0DUgWRroZwz1sBVN7TVA+IXj4eZDNfGpptsGaumqNqB8l7Q5B0/iI
 K+R/OofLTg2fy8byj+sTLJ9ElXOKNtTP1DdIMOivIXzOSgK9NeFgpXjOTwiLjvrB7Zg/9L2uuvA
 dw5jnava5zdK+OW9UNroXEV/GGy5wI=
X-Received: by 2002:a05:600c:3106:b0:483:afbb:a077 with SMTP id
 5b1f17b1804b1-483afbba2afmr85773125e9.1.1771866176102; 
 Mon, 23 Feb 2026 09:02:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 37/65] target/arm: GICv5 cpuif: Implement PPI pending status
 registers
Date: Mon, 23 Feb 2026 17:01:44 +0000
Message-ID: <20260223170212.441276-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The GICv5 PPI pending status is handled by two registers, one of
which is write-1-to-set and one of which is write-1-to-clear.  The
pending state is read-only for PPIs where the handling mode is Edge.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4574f7005d..980abda3ca 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -606,6 +606,7 @@ typedef struct CPUArchState {
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_pend[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 6fbc962131..4647fd40ba 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -199,6 +199,26 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, old | value);
 }
 
+static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
+    uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
+    value &= ~hm;
+    raw_write(env, ri, old & ~value);
+}
+
+static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    uint64_t old = raw_read(env, ri);
+    /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
+    uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
+    value &= ~hm;
+    raw_write(env, ri, old | value);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -314,6 +334,30 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
         .resetvalue = PPI_HMR1_RESET,
     },
+    {   .name = "ICC_PPI_CPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 4,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .writefn = gic_ppi_cpend_write,
+    },
+    {   .name = "ICC_PPI_CPENDR1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 5,
+        .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .writefn = gic_ppi_cpend_write,
+    },
+    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 6,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .writefn = gic_ppi_spend_write,
+    },
+    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 7,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .writefn = gic_ppi_spend_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


