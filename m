Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CACCAC5BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299Q-0000Cg-2I; Fri, 26 Sep 2025 10:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2994-0008IM-45
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298X-0005l0-Bv
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fae12so1212136f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895760; x=1759500560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=54i7q0TRCUXKYY+qLOk6M0n5wBbAsiSPn2GQEuQkelk=;
 b=WHtff3c2SJRMVtyeCQTiDMNnUbjYLRhd4V2WXDVP9tpX/OGbmFXukQM6pFLkZd+QvH
 OlDFmquhYjr19YFKlyXg/Xon1xSQ3rvsqA4yP1VXoh06Wglaj39B09hGE5u0vGyrJ6f2
 qCK/rg+SgctptB6hpEw4PidhCoFlG7gbmN7SmkxZ+DIBZVl3/bOsjtRtnqDe1jPQ+hPM
 D8ilzXx/W46RxjAMnUuo9s0YvoH6cfRx9ngI9JpNEaQy6w9c7BKpQxZV4/c4VYVuYOTU
 xmyk7nTYrNXSlz36XW4NdIg4Hj9NpypDidMboDcOkZxEL/7Za8Q7fJ/doXEpOZdQ1pDN
 YyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895760; x=1759500560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54i7q0TRCUXKYY+qLOk6M0n5wBbAsiSPn2GQEuQkelk=;
 b=MSog9xEb+EA1TE3Q1oF5VvD1OBAOj8W/GQqvRqlDw2nfsV/20WJ5roOOEmqRT45SZm
 TnURhsVqdhszZkQlTgqiiOnP54CphrMY8ygP5rXZqRYUj0q/lTWy9PhaFTz2W/vmx5XU
 j+UMN1BQm/QmWTe4nwBbHXv4ognDQviSQmG1BPlEWmpdeE+IK9IYWf9ubKKMhFGMfBzV
 kZuXUZK01/Mgy/JKzJ36522J87LsfYKWgN9EDUVWl21S58WTpa+j89mNfzdxwqg8xPZd
 MRqfLnIay5PlbgIZKKfkqCRoByf0EcLJV8dwhZxWs0FRwCLBpiGl70KHyIPOetvBTlqD
 5m+Q==
X-Gm-Message-State: AOJu0Yyb7YjTobW/AFrDEy2Fy9z2h1nb8gaFw9cUw9CiLDD3nIhcMaDA
 GPKY/xYTAzwu2wOoh/nwFCdhcvqUxmbgyFGnjibAsuqLXaSMQ/Q0vewkCMx5O/B4t/ji97AoEuc
 7LYDD
X-Gm-Gg: ASbGnctcOCh34dE9xXcmdBmtdBjVORi9FQOmkq0Pjs4m/wX1dxNSdbaDdZo6yNv80K3
 xgOUAEFQ80779T6o9qp+u0+FOgX3eweJgMKClR2OjvV88y5sCrOi8P0GpAEgCqJcjHPZdYEA96A
 WKOi0/MnTLVkePKq2yv9Yh1vxtDrRg7k5xRMBLqLXGo9Q6MjDxN9lPwQEuvSxBYx+VduFE33FLQ
 8UOaixXYTRWQfMYZ39i9AfOf5JgI7J9HkNoV+VyB/5YH00hnSca9qmSC7GjJGgg0k2c4Q20ws0l
 YBHzInHZLxHq5KX9i1+kMsAEcVO/zVDbzHJJhFSuivMKXIXDV4e7wd2cxOoTkVUsuY+aM26GoH/
 XNyzOLgtlYOSCPvX2zObj4b9k5kez
X-Google-Smtp-Source: AGHT+IFXxgCTK9nl6ZczIjMt1k3oDsAvJOxzSiawIk0ukf5LiKUtQ5XD+MIF8MgsB1OyeuurvKthMA==
X-Received: by 2002:a5d:5d0b:0:b0:3ec:db87:fff7 with SMTP id
 ffacd0b85a97d-40e4a9ee4aemr6563793f8f.26.1758895760020; 
 Fri, 26 Sep 2025 07:09:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/44] target/arm: Rename TBFLAG_A64_NV2_MEM_E20 with *_E2H
Date: Fri, 26 Sep 2025 15:08:33 +0100
Message-ID: <20250926140844.1493020-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Install e2h in tbflags and compute nv2_mem_e20 from
that in aarch64_tr_init_disas_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 3 +--
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 8 +++++---
 target/arm/tcg/translate-a64.c | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1c0deb723d7..d5534e35804 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3065,8 +3065,7 @@ FIELD(TBFLAG_A64, ATA0, 31, 1)
 FIELD(TBFLAG_A64, NV, 32, 1)
 FIELD(TBFLAG_A64, NV1, 33, 1)
 FIELD(TBFLAG_A64, NV2, 34, 1)
-/* Set if FEAT_NV2 RAM accesses use the EL2&0 translation regime */
-FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
+FIELD(TBFLAG_A64, E2H, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index ec4755ae3fd..f1a6e5e2b61 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -150,6 +150,8 @@ typedef struct DisasContext {
     bool trap_eret;
     /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
     bool naa;
+    /* True if HCR_EL2.E2H is set */
+    bool e2h;
     /* True if FEAT_NV HCR_EL2.NV is enabled */
     bool nv;
     /* True if NV enabled and HCR_EL2.NV1 is set */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 01894226cc9..17f83f13a40 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -258,6 +258,11 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
 
+    /* E2H is used by both VHE and NV2. */
+    if (hcr & HCR_E2H) {
+        DP_TBFLAG_A64(flags, E2H, 1);
+    }
+
     if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
         int sve_el = sve_exception_el(env, el);
 
@@ -390,9 +395,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         if (hcr & HCR_NV2) {
             DP_TBFLAG_A64(flags, NV2, 1);
-            if (hcr & HCR_E2H) {
-                DP_TBFLAG_A64(flags, NV2_MEM_E20, 1);
-            }
             if (env->cp15.sctlr_el[2] & SCTLR_EE) {
                 DP_TBFLAG_A64(flags, NV2_MEM_BE, 1);
             }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0ec309f1ea9..599e7a36ee3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10304,10 +10304,11 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
+    dc->e2h = EX_TBFLAG_A64(tb_flags, E2H);
     dc->nv = EX_TBFLAG_A64(tb_flags, NV);
     dc->nv1 = EX_TBFLAG_A64(tb_flags, NV1);
     dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
-    dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
+    dc->nv2_mem_e20 = dc->nv2 && dc->e2h;
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
-- 
2.43.0


