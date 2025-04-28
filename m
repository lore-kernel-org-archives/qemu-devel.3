Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10183C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5O-0008DP-I7; Mon, 28 Apr 2025 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O52-0007tf-C9
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4x-00036m-Rn
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:27 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso10136939a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845162; x=1746449962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qc7SHqkPGeFwD7OQUk3puk/Z8FG2BzOSogWjxrnjPA8=;
 b=d+g609W23dZf8fHRhusj8Fq3akM6BdgiY+PQ9nONOXDBWULwvLDmZpFAXx8tHD50yB
 LoeGkH7Vcxd9Fn8IQMm0ZtwcaWOsmBkIwz6ar4G++lmEwT7HCbF6Yl9PlR2fqavD9VwF
 KIAWRVYi5jQaqVs+V5ndIcd4sMsXfQGb9pLYw8sYc4wwu4Ja8LJYqK4MnmRLJ+Fla+sU
 M/+JQGuXB0HazwsmVeRmz88hkk3y9XxmR51ylPEovGHtkyl3JhPitV+J+O6Rer/zAHbs
 Kf2IJJ+tTBAmuuFVVZfjv3tJ0PF/uwzsX0sF/+JY4gklFLm3zbxmJ2hE1eYsO2Xv4rlQ
 WmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845162; x=1746449962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qc7SHqkPGeFwD7OQUk3puk/Z8FG2BzOSogWjxrnjPA8=;
 b=lwqCdmHBclPxxwH+5Tjl+5LJ84F7/5wIQXvEi2koxUAMBFIf1wC/NgparJYO3oGPN8
 lTt5qQaGb3SntnUNQsGFRtNsk1Bb6gkV2/bkapfQlkXaCZfFTTjwZbJblLC4dT5vjZob
 CKf8K4Gc1kVQNGT2ES0XyPSIV/9XIP0PeiHeJLvUP7LMPiZX6qgYDJit/L9DDEpw0auG
 4G6uUVQQ5BD/J0eUxuuqJx8bmbNY3y/Nm8wMZfy4tK1XXvxsW2+JbCs4WGaX/Dldbj+m
 uENTSvPO9barH4o9CJdilvQiAG3m6tNuFd7O3M0qCRFsIQTeNZfEMSs1zKMUnPiUwxM4
 QiUw==
X-Gm-Message-State: AOJu0YzjZVYFuVR+g1vDM7GIMnrmlwkW0pIenR+Af95SHIWejDxD5hlG
 oBYQSxUdYTczrrNQZKyBudhibswE6WOt8NtVZy3UcL1KCg6hbq0RP21wBxbE2z4=
X-Gm-Gg: ASbGnctHB6EjrBXgBdduEP60tgdTG2TwfKK1vofL0pO2EIOywsyXsO27vtjlcrbfRWo
 kj/4upQOHaAW37BwyNY6g6L10OzOmJ0VruMTz+Ht+EXn4+RfO8dNbHNzPyd0Rl9Ao0Oszb1Vv/f
 MKoYRPaPYM/H7oqV7MMKhTPNZySRqmtRJBvJZ9y9Fv6lr7Zrf4Rfh/RH0zOOFiZb0qKsTnVY2ga
 SmGlRJXLuo/6xVLhoZ7QuR2un/TK/drj8oDeVpx/vCUdZWiJ2HW8CQAk7ukF2mbzKn3pTT+z8i7
 q8ei9YPtVJR97dtx/Ti8rgnoRbe00Zz9hrv9Qfz8JWQ=
X-Google-Smtp-Source: AGHT+IE+eA1K57D+aP//w4zVpGdfWX3dp+jz8kBavF64IIX6pe/P9Jpwrs2+anccJQKcffPU0zvjCg==
X-Received: by 2002:a17:907:3da0:b0:acb:a7cc:4102 with SMTP id
 a640c23a62f3a-ace5a124bfbmr1411844266b.4.1745845162079; 
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e5959basm617760466b.82.2025.04.28.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8662C5FAE8;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 3/9] tests/tcg: make aarch64 boot.S handle different starting
 modes
Date: Mon, 28 Apr 2025 13:59:12 +0100
Message-Id: <20250428125918.449346-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If a test needs to be at a particular EL it can use the semihosting
command line to indicate the level we should execute in.

Cc: Julian Armistead <julian.armistead@linaro.org>
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - allow tests to control the final EL we end up at
---
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 127 +++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 9c52475b7a..f7a7d2b800 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
 
 # vtimer test needs EL2
 QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
+QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
 
 # Simple Record/Replay Test
 .PHONY: memory-record
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index a5df9c173d..19b18bdeec 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -16,6 +16,7 @@
 #define semihosting_call hlt 0xf000
 #define SYS_WRITEC	0x03	/* character to debug channel */
 #define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_GET_CMDLINE 0x15	/* get command line */
 #define SYS_EXIT	0x18
 
 	.align	12
@@ -81,10 +82,129 @@ lower_a32_serror:
 .error:
 	.string "Terminated by exception.\n"
 
+	.align 8
+.get_cmd:
+	.quad	cmdline
+	.quad	128
+
 	.text
 	.align 4
 	.global __start
 __start:
+	/*
+	 * The test can set the semihosting command line to the target
+	 * EL needed for the test. Keep that in w11.
+	 */
+	mov	x0, SYS_GET_CMDLINE
+	adr	x1, .get_cmd
+	semihosting_call
+	adrp	x10, cmdline
+	add	x10, x10, :lo12:cmdline
+	ldrb	w11, [x10]
+	cbz	w11, 1f
+	sub 	w11, w11, #'0'
+1:
+
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
+	b.eq    at_testel            /* Already at EL1, skip transition */
+	/* Should not be at EL0 - error out */
+	b       curr_sp0_sync
+
+setup_el3:
+	/* Ensure we trap if we get anything wrong */
+	adr	x0, vector_table
+	msr	vbar_el3, x0
+
+	/* Does the test want to be at EL3? */
+	cmp	w11, #3
+	beq	at_testel
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
+	adr     x0, at_testel
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
+	/* Does the test want to be at EL2? */
+	cmp	w11, #2
+	beq	at_testel
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
+	adr     x0, at_testel
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
+	/*
+	 * At the target EL for the test, usually EL1. Note we still
+	 * set everything up as if we were at EL1.
+	 */
+at_testel:
 	/* Installs a table of exception vectors to catch and handle all
 	   exceptions by terminating the process with a diagnostic.  */
 	adr	x0, vector_table
@@ -100,7 +220,7 @@ __start:
 	 * maps RAM to the first Gb. The stage2 tables have two 2mb
 	 * translation block entries covering a series of adjacent
 	 * 4k pages.
-	*/
+ 	 */
 
 	/* Stage 1 entry: indexed by IA[38:30] */
 	adr	x1, .				/* phys address */
@@ -233,6 +353,11 @@ __sys_outc:
 	ret
 
 	.data
+
+	.align 8
+cmdline:
+	.space 128, 0
+
 	.align	12
 
 	/* Translation table
-- 
2.39.5


