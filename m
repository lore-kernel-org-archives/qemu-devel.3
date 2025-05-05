Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D180C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4R-0002Tb-Cc; Sun, 04 May 2025 21:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4K-0001wq-ID
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4I-00036k-NA
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so2882152a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410189; x=1747014989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAOgrGi4ghC8+gWPIlyM/nbU9ofyXXxCXlHL7nptXa0=;
 b=IDdoyt5KpZRbDUKgoqrZp/FYf073AOdli/yQ5laNrKlhuvKfZ82NH4ixEriaWBTD46
 9fd/91Z+1AwEY324NCR2i1rO03LJSNpe8udT6OSeOiE0NroWNjl2KOo0povqCS33Ztcw
 KBdpztRmojh7gTZvcqm21SNPuN/WkWqs/qyQXBApw9DTFnyiHs8KKXm/QElG5/g1yM7i
 +r0B7XaxQMxM+vw4HEm9HY5XIl3XIk5mllgXjzGUUy88wZD6VxdmCz4dvznz8hCkclHH
 PzVGmGRH5cHNaFBNFvEXpNQCNY6id7YAS9R9wlnvT38IxGgpod+6nYhIBwA/7n7WMIri
 VMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410189; x=1747014989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAOgrGi4ghC8+gWPIlyM/nbU9ofyXXxCXlHL7nptXa0=;
 b=LSxRP8OIJByOcmtzrRo3ABmDFHYZLFezJ0jRT+/+EYnk8FQPZ9pXhv9I06/YzxI0es
 y0aVhaLfFfp4r1lsS/ZIjNEwlJIsXNy1MFW8pFPvVf7RT/ndAY/9eXm2g1ozpcdCJ4jR
 hBbcE7fOveTk+Maqr4doQIRWflqgl64lSw7qCbBn2Vz0g23ioUWnxV3TQDpN7+ob9HgF
 SujKqQI5WhHDHu37IUM1SyGoAknu29f+UPja3dzQtVLia1IH2vd9m9kejRQIyO5k1VXE
 n3EKsLdhna0r3TAOLm1w3prCTTByjczi8Xw2i6Rgd+f1GoRLX2mB/MSj9i5330102WoR
 iZaA==
X-Gm-Message-State: AOJu0YyoanLwVa8ywyGyZDMcY3rcox5LU48DdFAulx7jsLrZfP5lWmOV
 UltlGG2yzXtvTvQ3nkHscvXBFSNKYuq3e3xx9JaMLdcjaSCDnQAoZYeQO3Deg9sRO5jKUNY39/S
 vBuc=
X-Gm-Gg: ASbGncvXVbDmKoouso5n770mOHUT7XMjXsxY8cbg0YC6vo2YUA2KUS8lpNPe7o91wWK
 RI5ApvQjZY2vV7VUlyREPF6hHE1FyeHGAgSwtcCaBJoB3J2sHiFv8/BxD8ScOY2i5LsbOjmca9d
 WhjWwmKle6dKPjZEkIQBgyr1nyviSva08E+ASgZ9TSq0s0hG/eg0MTDJ3QoD/EPMJFmOJYLkfpQ
 3m4uexfXw3oFoG2rOGlAVwC2bcnu8FArWntsdDsE+Aof3OPXEpMrStBTnnXVsANpMjwdfdIITzk
 kDk/roLWaW+XHyFiaAubNKpAKys0cnZPhT1U9RHy
X-Google-Smtp-Source: AGHT+IHyZNLrInoF0UGi8/gWlcgqZ15bxABMny7v/Brhs4Ifj0FpxPAHa/DSU+TaHYiyNKfZ9pvvmQ==
X-Received: by 2002:a17:90b:4c12:b0:305:2d68:8d91 with SMTP id
 98e67ed59e1d1-30a4e622226mr16542763a91.28.1746410189330; 
 Sun, 04 May 2025 18:56:29 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 46/48] target/arm/tcg/tlb-insns: compile file twice (system, user)
Date: Sun,  4 May 2025 18:52:21 -0700
Message-ID: <20250505015223.3895275-47-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
safe to expose it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 7 -------
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 0407ad5542d..95c26c6d463 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -35,7 +35,6 @@ static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-#ifdef TARGET_AARCH64
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
 static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
@@ -46,7 +45,6 @@ static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
     }
     return CP_ACCESS_OK;
 }
-#endif
 
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -802,7 +800,6 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
-#ifdef TARGET_AARCH64
 typedef struct {
     uint64_t base;
     uint64_t length;
@@ -1270,8 +1267,6 @@ static const ARMCPRegInfo tlbi_rme_reginfo[] = {
       .writefn = tlbi_aa64_paallos_write },
 };
 
-#endif
-
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1299,7 +1294,6 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
     }
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_tlbirange, cpu)) {
         define_arm_cp_regs(cpu, tlbirange_reginfo);
     }
@@ -1309,5 +1303,4 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rme, cpu)) {
         define_arm_cp_regs(cpu, tlbi_rme_reginfo);
     }
-#endif
 }
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 9669eab89e3..a5fcf0e7b88 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'tlb-insns.c',
   'arith_helper.c',
   'vfp_helper.c',
 ))
@@ -65,6 +64,7 @@ arm_common_system_ss.add(files(
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'tlb-insns.c',
 ))
 arm_user_ss.add(files(
   'crypto_helper.c',
@@ -72,4 +72,5 @@ arm_user_ss.add(files(
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'tlb-insns.c',
 ))
-- 
2.47.2


