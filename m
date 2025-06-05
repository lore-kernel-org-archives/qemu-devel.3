Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3110AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQj-0006zZ-AK; Thu, 05 Jun 2025 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0006yv-7g
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQe-0007vp-CX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:59 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso187173066b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140814; x=1749745614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmEv0t2K65ULl4o62PaYkBn9JBHNC8LgfDFkj21skSI=;
 b=isMBnWfORyJ24LBUsYeWmB8IKn5VXKT9BPC2qZra5WgPeVOlbYDh9aRAcbzCfCFj8+
 7fgxdY7LXdJSO2rbuNPngDO41BhKekt4HTfhTuYH8p5/iC9XqEl1HNP9SD7aeBYCL3R7
 YoDqika75F//vy6YAcnOnHiU74dLHjVMq8mZYLpyrZ8EadCbZ7lZ7ePxijWfGXvjwAwQ
 Tp3QczmkxPv5ass0UalgJeRAeJcesMGnAExZt14NChSyzecy1patUuvWcDQfKV1Hknbe
 MMn86uGUS7z9209GMEpVRAUSan8N+HXgS5UfwGKamruCREeFfk/nxMzYXqZm2kQJTxT+
 pwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140814; x=1749745614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmEv0t2K65ULl4o62PaYkBn9JBHNC8LgfDFkj21skSI=;
 b=Ls7NDi7PklQQIZIZ6K7Qb2XdrlOXv5tfPBmMfwSauKAEu9os5zSIouHD407pcEevJJ
 Qs0qir4GpUBDq9j6Pl5HEGjUPpGAtOBMP6C5MVZ/czvlrEkAHhX+xIee6p2xv5vSFGOg
 HwKc2H3wx7/dty0ttJFN+vlFdHejbQ+xmeSzQo2ghYxYaYfXHmBezUiX8enHyi0MuseB
 xMQyvSaDpbnLwIGlCEMV+obqPAZaI5LPB00MuGnZpDi5pGO8Bgk8baGaG8c6Pzj3+8Dx
 GbI1JZULq3nPv4rPNOZMZ1QWI05HiMN7dkgKBUVkGELs7eJKdpVmplddCd16j9Oo1zJC
 OKIQ==
X-Gm-Message-State: AOJu0Yy9nnGZvkGke7ixi1wHL1VX1GFMF6ZmFt0MDQdd6YuieqeL44t1
 JNg+YA1/KABifA9LBVErvBFn2HCHlo/8To1bkI39AkkJZrPg5WT/oH1j6yWGQ184Wpo=
X-Gm-Gg: ASbGncvai3b8bbJNW8QSH8Z/QHrYoyKcAfTOiYTxQH0VwhH4lrZRwU7MsA2lKMzOIbs
 eV54URVfLXwkQYkdXMk9iLucIOFroffCGX/OcCtw1wHI7gxN5tMkxQCE4pgk9ThYeTdrVC2bFEz
 KJe0ZjEbeFh8vIojmniCDfbhrylAdiOlsVUpRoAocjiSEWVHm5ii5ADn7itZdl4/6awLTMbjZPo
 HKFtwaaSpcdUq2N3su/WcVGJg9+KFg1Zbi147aQt7XIXpjE8aymD6ZwteQkbf923ZdhGXHqgrlI
 bdzWFfouSfYIhJ4IyZk3uZ6kehyPvdJ5+8LVHawtemXZdARxOLTraNVlS2Ozn/8=
X-Google-Smtp-Source: AGHT+IE8fKpNZa5y651ZqWjvovsE0eDyswGTucYubeD2toF7LCpjemeWEtwYT9G2bQ8N7wqwG9VqmQ==
X-Received: by 2002:a17:906:9f8f:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-addf8c87401mr692490566b.13.1749140814332; 
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d850d88sm1280215966b.77.2025.06.05.09.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1D955F7F5;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 03/17] tests/tcg: make aarch64 boot.S handle different starting
 modes
Date: Thu,  5 Jun 2025 17:26:36 +0100
Message-ID: <20250605162651.2614401-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
Message-ID: <20250603110204.838117-4-alex.bennee@linaro.org>

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
index a5df9c173d..8bfa4e4efc 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -16,6 +16,7 @@
 #define semihosting_call hlt 0xf000
 #define SYS_WRITEC	0x03	/* character to debug channel */
 #define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_GET_CMDLINE 0x15	/* get command line */
 #define SYS_EXIT	0x18
 
 	.align	12
@@ -70,21 +71,172 @@ lower_a32_sync:
 lower_a32_irq:
 lower_a32_fiq:
 lower_a32_serror:
+	adr	x1, .unexp_excp
+exit_msg:
 	mov	x0, SYS_WRITE0
-	adr	x1, .error
 	semihosting_call
 	mov	x0, 1 /* EXIT_FAILURE */
 	bl 	_exit
 	/* never returns */
 
 	.section .rodata
-.error:
-	.string "Terminated by exception.\n"
+.unexp_excp:
+	.string "Unexpected exception.\n"
+.high_el_msg:
+	.string "Started in lower EL than requested.\n"
+.unexp_el0:
+	.string "Started in invalid EL.\n"
+
+	.align 8
+.get_cmd:
+	.quad	cmdline
+	.quad	128
 
 	.text
 	.align 4
 	.global __start
 __start:
+	/*
+         * Initialise the stack for whatever EL we are in before
+	 * anything else, we need it to be able to _exit cleanly.
+	 * It's smaller than the stack we pass to the C code but we
+	 * don't need much.
+	 */
+	adrp	x0, system_stack_end
+	add	x0, x0, :lo12:system_stack_end
+	mov	sp, x0
+
+	/*
+	 * The test can set the semihosting command line to the target
+	 * EL needed for the test. However if no semihosting args are set we will
+	 * end up with -kernel/-append data (see semihosting_arg_fallback).
+	 * Keep the normalised target in w11.
+	 */
+	mov	x0, SYS_GET_CMDLINE
+	adr	x1, .get_cmd
+	semihosting_call
+	adrp	x10, cmdline
+	add	x10, x10, :lo12:cmdline
+	ldrb	w11, [x10]
+
+	/* sanity check, normalise char to EL, clamp to 1 if outside range */
+	subs w11, w11, #'0'
+	b.lt el_default
+	cmp  w11, #3
+	b.gt el_default
+	b 1f
+
+el_high:
+	adr	x1, .high_el_msg
+	b	exit_msg
+
+el_default:
+	mov	w11, #1
+
+1:
+	/* Determine current Exception Level */
+	mrs	x0, CurrentEL
+	lsr	x0, x0, #2	  /* CurrentEL[3:2] contains the current EL */
+
+	/* Are we already in a lower EL than we want? */
+	cmp	w11, w0
+	bgt	el_high
+
+	/* Branch based on current EL */
+	cmp	x0, #3
+	b.eq	setup_el3
+	cmp	x0, #2
+	b.eq	setup_el2
+	cmp	x0, #1
+	b.eq	at_testel	     /* Already at EL1, skip transition */
+
+	/* Should not be at EL0 - error out */
+	adr 	x1, .unexp_el0
+	b	exit_msg
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
+	mrs	x0, scr_el3
+	orr	x0, x0, #(1 << 10)    /* RW = 1: EL2/EL1 execution state is AArch64 */
+	orr	x0, x0, #(1 << 0)     /* NS = 1: Non-secure state */
+	msr	scr_el3, x0
+
+	/*
+	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
+	 * otherwise we should just jump straight to EL1.
+	 */
+	mrs	x0, id_aa64pfr0_el1
+	ubfx	x0, x0, #8, #4	      /* Extract EL2 field (bits 11:8) */
+	cbz	x0, el2_not_present   /* If field is 0 no EL2 */
+
+
+	/* Prepare SPSR for exception return to EL2 */
+	mov	x0, #0x3c9	      /* DAIF bits and EL2h mode (9) */
+	msr	spsr_el3, x0
+
+	/* Set EL2 entry point */
+	adr	x0, setup_el2
+	msr	elr_el3, x0
+
+	/* Return to EL2 */
+	eret
+
+el2_not_present:
+	/* Initialize SCTLR_EL1 with reset value */
+	msr	sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr	x0, at_testel
+	msr	elr_el3, x0
+
+	/* Prepare SPSR for exception return to EL1h with interrupts masked */
+	mov	x0, #0x3c5	      /* DAIF bits and EL1h mode (5) */
+	msr	spsr_el3, x0
+
+	isb			      /* Synchronization barrier */
+	eret			      /* Jump to EL1 */
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
+	mrs	x0, hcr_el2
+	orr	x0, x0, #(1 << 31)    /* RW = 1: EL1 execution state is AArch64 */
+	msr	hcr_el2, x0
+
+	/* Initialize SCTLR_EL1 with reset value */
+	msr	sctlr_el1, xzr
+
+	/* Set EL1 entry point */
+	adr	x0, at_testel
+	msr	elr_el2, x0
+
+	/* Prepare SPSR for exception return to EL1 */
+	mov	x0, #(0x5 << 0)	      /* EL1h (SPx), with interrupts disabled */
+	msr	spsr_el2, x0
+
+	/* Return to EL1 */
+	eret
+
+	/*
+	 * At the target EL for the test, usually EL1. Note we still
+	 * set everything up as if we were at EL1.
+	 */
+at_testel:
 	/* Installs a table of exception vectors to catch and handle all
 	   exceptions by terminating the process with a diagnostic.  */
 	adr	x0, vector_table
@@ -100,7 +252,7 @@ __start:
 	 * maps RAM to the first Gb. The stage2 tables have two 2mb
 	 * translation block entries covering a series of adjacent
 	 * 4k pages.
-	*/
+	 */
 
 	/* Stage 1 entry: indexed by IA[38:30] */
 	adr	x1, .				/* phys address */
@@ -198,7 +350,8 @@ __start:
 	orr	x0, x0, #(3 << 16)
 	msr	cpacr_el1, x0
 
-	/* Setup some stack space and enter the test code.
+	/*
+	 * Setup some stack space before we enter the test code.
 	 * Assume everything except the return value is garbage when we
 	 * return, we won't need it.
 	 */
@@ -233,6 +386,11 @@ __sys_outc:
 	ret
 
 	.data
+
+	.align 8
+cmdline:
+	.space 128, 0
+
 	.align	12
 
 	/* Translation table
@@ -246,6 +404,10 @@ ttb_stage2:
 	.space	4096, 0
 
 	.align	12
+system_stack:
+	.space 4096, 0
+system_stack_end:
+
 stack:
 	.space 65536, 0
 stack_end:
-- 
2.47.2


