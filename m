Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C961C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 10:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0HNI-0000nW-TR; Thu, 03 Apr 2025 06:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0HNC-0000n6-Qu
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 06:00:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0HNA-00062X-3S
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 06:00:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e535e6739bso1133283a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743674429; x=1744279229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2YZH9GasqV1VOveziAJ9mcv4NculPTEI44DZKU7AEkM=;
 b=gvGFxpox6NKHEYTtH2bZGpc9ECDDNJynE34p5vSMjqpfG0IVFdGpXGsLecN5xxUNrT
 p1U/4QRSM4sBPplyZ3ZIEVbLrqIthiVAWrFXoVgekGHqzYmy3Bixo2znJ1gmuAdsIFW2
 aY1kS77us5d7bq9egPYQ8KIUKEQTuYxtYQ1hen9Xix58CHosLfwgPQhhX9pLqpHkmLwR
 w/v424UJsU+lpupVACLCU6IQJ2ffTAt/oH2ZVnMs59HOLBqkZ8bl87Ry5i5QQ4f+Xhbm
 2Xin4LQrfrj3ouAG4pbqLpFeoIbZM8FXBhFu3Y8qHUJha0j2UI+FoFfcjwejHJqhLous
 JtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743674429; x=1744279229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YZH9GasqV1VOveziAJ9mcv4NculPTEI44DZKU7AEkM=;
 b=spd3AOHBiCFn0AJOQvEtUFICYxErahxudLIK6aFAoxcuYQuLKyWtQCiuHng0J5zBlZ
 /ak2Aj1kkw39gc5aWQNS1sEGmquYR1woFz6nGgcKaetsRs7bF2Njaowjbj2W4AcUfufz
 puyDFke/yLU4bj2F/1t+PLuP87isOR4xNjmBgJIprnznC20Pt+09/hKnWnbT3kJi/RTK
 h1Epos/aSRuxe6sFVaNdr1nRWqdiMhyy1l1RrPIDrXejnSjfmsXz0jii7HWVYE1iFk+r
 /oVS1YPTXwSGFFYHKNAtXg8IUpaAJWragOU5P3N7zkmHSZ3G14hj/I7sYzAN0RkMkFNh
 TTJg==
X-Gm-Message-State: AOJu0YzED/I0AExmsGDTnFb7SQ+jdnYxZP7gf8Ll9JTwI/bo30dcyGhB
 P/h1nVmkgMHWrygxXYBAGPgqhG2QVzW+D9FNQYAmehqlRhtYEouzY3Xs3uUZSNY=
X-Gm-Gg: ASbGncs5dJMjvIBTSCt6pBqsxTbiwi4UUFpgGfA97qz+n3XrUF1TxhrhhQXTDWpaJWz
 hmr0eGwRX9eGvSG4CTkznXwsv/nCy/bPHP/1UnIp1hmYOzYqhi63Fn1WfRmpWf4Qjq3g7OIDkhg
 5AHC0Oq/7S5AdI4+Dvtk7eip/BgxdTqZDif/pLd6VAs3CiH48nxODFbZe5dZalywiPcmFnDo7cA
 p3xrkHeWVL+diZpEUzCrfGSCNqj+NbA4+UldJ73iojBSOElPeEhK41+MzgANg5F3s9PvuwcB+m7
 vdn/CP4c45sJVZv0YSc/1AbJ19pw0V6HLzm0lGNoye715nU=
X-Google-Smtp-Source: AGHT+IGVngfbOz7q6xU93CulD7dNWoi0iiLEPJagGivnuCLtaP9uEw3qZcJuY28jgJP41nRXd9Zh4A==
X-Received: by 2002:a17:907:7f1e:b0:ac7:16f2:e8e5 with SMTP id
 a640c23a62f3a-ac7bc287cbdmr145488266b.50.1743674429001; 
 Thu, 03 Apr 2025 03:00:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c924sm67494466b.30.2025.04.03.03.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 03:00:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 720275F90D;
 Thu,  3 Apr 2025 11:00:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] tests/tcg: make aarch64 boot.S handle different starting
 modes
Date: Thu,  3 Apr 2025 11:00:16 +0100
Message-Id: <20250403100016.4118475-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Currently the boot.S code assumes everything starts at EL1. This will
break things like the memory test which will barf on unaligned memory
access when run at a higher level.

Adapt the boot code to do some basic verification of the starting mode
and the minimal configuration to move to the lower exception levels.
With this we can run the memory test with:

  -M virt,secure=on
  -M virt,secure=on,virtualization=on
  -M virt,virtualisation=on

Cc: Julian Armistead <julian.armistead@linaro.org>
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/boot.S | 88 +++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 4eb1b35b88..8fbcba757e 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -86,6 +86,94 @@ lower_a32_serror:
 	.align 4
 	.global __start
 __start:
+	/* Determine current Exception Level */
+	mrs     x0, CurrentEL
+	lsr     x0, x0, #2        /* CurrentEL[3:2] contains the current EL */
+
+	/* Branch based on current EL */
+	cmp     x0, #3
+	b.eq    setup_el3
+	cmp     x0, #2
+	b.eq    setup_el2
+	cmp     x0, #1
+	b.eq    at_el1            /* Already at EL1, skip transition */
+	/* Should not be at EL0 - error out */
+	b       curr_sp0_sync
+
+setup_el3:
+	/* Ensure we trap if we get anything wrong */
+	adr	x0, vector_table
+	msr	vbar_el3, x0
+
+	/* Configure EL3 to for lower states (EL2 or EL1) */
+	mrs     x0, scr_el3
+	orr     x0, x0, #(1 << 10)    /* RW = 1: EL2/EL1 execution state is AArch64 */
+	orr     x0, x0, #(1 << 0)     /* NS = 1: Non-secure state */
+	msr     scr_el3, x0
+
+	/*
+	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
+	 * otherwise we should just jump straight to EL1.
+	 */
+	mrs     x0, id_aa64pfr0_el1
+	ubfx    x0, x0, #8, #4        /* Extract EL2 field (bits 11:8) */
+	cbz     x0, el2_not_present   /* If field is 0 no EL2 */
+
+
+	/* Prepare SPSR for exception return to EL2 */
+	mov	x0, #0x3c9            /* DAIF bits and EL2h mode (9) */
+	msr     spsr_el3, x0
+
+	/* Set EL2 entry point */
+	adr     x0, setup_el2
+	msr     elr_el3, x0
+
+	/* Return to EL2 */
+	eret
+	nop
+
+el2_not_present:
+	/* Initialize SCTLR_EL1 with reset value */
+	msr     sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr     x0, at_el1
+	msr     elr_el3, x0
+
+	/* Prepare SPSR for exception return to EL1h with interrupts masked */
+	mov     x0, #0x3c5            /* DAIF bits and EL1h mode (5) */
+	msr     spsr_el3, x0
+
+	isb                           /* Synchronization barrier */
+	eret                          /* Jump to EL1 */
+
+setup_el2:
+	/* Ensure we trap if we get anything wrong */
+	adr	x0, vector_table
+	msr	vbar_el2, x0
+
+	/* Configure EL2 to allow transition to EL1 */
+	mrs     x0, hcr_el2
+	orr     x0, x0, #(1 << 31)    /* RW = 1: EL1 execution state is AArch64 */
+	msr     hcr_el2, x0
+
+	/* Initialize SCTLR_EL1 with reset value */
+	msr     sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr     x0, at_el1
+	msr     elr_el2, x0
+
+	/* Prepare SPSR for exception return to EL1 */
+	mov     x0, #(0x5 << 0)       /* EL1h (SPx), with interrupts disabled */
+	msr     spsr_el2, x0
+
+	/* Return to EL1 */
+	eret
+
+	nop
+
+at_el1:
 	/* Installs a table of exception vectors to catch and handle all
 	   exceptions by terminating the process with a diagnostic.  */
 	adr	x0, vector_table
-- 
2.39.5


