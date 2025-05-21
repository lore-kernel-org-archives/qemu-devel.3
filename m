Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97D0C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmX3-0000Rx-Cs; Wed, 21 May 2025 12:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX1-0000Qh-Ns
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWv-00068p-V9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-601d66f8cafso5760463a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845775; x=1748450575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EeJt2/IHQl/YQCaB+UF88NGaWdjcKiX03wFO+hAP/s=;
 b=Er53yrV3/JavUEcsKQT0aT47SpZ2QPNwrDqg6+qf8fHzXtF/lTjsIWU30QYuCO4rbm
 uvY9HzNJUzkP3v3pwxN0R1DfBZF7i220Ewck01fsngEwZCS1R8WWuyV/dSjgWmiyKTk0
 fqzC6bKy/N1Q4xFq3WgGTNjtnOo5dgieuRzZ4p7npHjCjhnmJgV5AFz/0Q/4nJ3TX8dr
 ZKyonIiF95687G8u7p7oe1VW7jdXXYTkp16mh8cPzs/tb3r8soERjDwVgnARo45EQ3Fz
 od3IE3NgNImamsnMy6jhfpqaGhIuXUkEaoRBCzGQL/LWv2DNnMQwVZldAfRyvMHHQMmG
 XO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845775; x=1748450575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EeJt2/IHQl/YQCaB+UF88NGaWdjcKiX03wFO+hAP/s=;
 b=jjjIqo0F3a5w4ttfwXqRRxznFQ+9iDINvh3QKsrsorzOyYdDTb/XEmTwB4XMt/rnCF
 +wFoSM5mKnMSKBU26RUg60E8kpg1XGJBvirsJKc0D2wuUYTt1A5Up4SWQUN1pk0+JJoA
 RMWq2j4RByQMAN8h9II8MVOdB/yq9LeAmJmqGS3NBT1tGFXoeJRDwKT/HwrvPpb1ZW72
 MvT+IMhuGmy4G/Xpyqo/NKRGuVqJUjJtGRbtCSKFcpXKoHLg7TPVDJA+TyesM57KY7ZE
 P0OhwmKqZKTbNWd1CwzDpkpUJyJK9Asj6sf0+Ct6OF8WBEZw/R4VcrDPaJGQUZrbS/Gy
 3/Iw==
X-Gm-Message-State: AOJu0YwI/RTujqHLquDx5oLks/B+IgBTqKOAi4Ti7lVJV2X/p4Ikj1bE
 WsZ7lKVj3fsVUjGYLi+lGVr9wvNrgBwL2DuWVpVEnvylgMpOwHWpMu6ueqVfgLH8fRo=
X-Gm-Gg: ASbGncsH6djsMuQVRAKjZjRGxIBs9VxvtTkyGtArErguX0u1I4Q9MJdHoj5HdStkEEM
 /bctPhI7gQOERLsMIh1EQsLkTAE+Ku68t9g+N98WpLo7D05uCK9g7HHptiSrgUoMBMou1PnuPQu
 thLCeJFdZuwuorpijpQeILjTcw8g1SsdyHPcC2ObN4176FwukvWamgfbhnxHOH8mQr1FgZp5Dn8
 STESNo/uzIgZJULdRSuH75GzjP0yzuUgZQy2tACCLN00kuIyzWSQd5Kb2h2AcN4gdFOK6dvJEdQ
 0XoRju97L75GXzJs4XgAIheFKK2EHuokfZGBnrED8NhGyUu9ldKi
X-Google-Smtp-Source: AGHT+IFrxIu+/MshD4fiI9PW2BvC+QKbI1SmQki2KAwmnYsk5yG1VUW4PuHMwuhKfWh3/HwJbRYNQA==
X-Received: by 2002:a17:907:9803:b0:ad5:3156:2c06 with SMTP id
 a640c23a62f3a-ad536bdf940mr1711196366b.28.1747845774935; 
 Wed, 21 May 2025 09:42:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d047754sm918511066b.7.2025.05.21.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B9A15F9E3;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v3 03/20] tests/tcg: make aarch64 boot.S handle different
 starting modes
Date: Wed, 21 May 2025 17:42:33 +0100
Message-Id: <20250521164250.135776-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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
v3
  - create system stack so we _exit cleanly
  - normalise EL string before compares
  - catch when we start in a lower EL than we asked for
  - default to EL1 when arg unclear
v2
  - allow tests to control the final EL we end up at
  - use tabs consistently
  - validate command line arg is between 1 and 3
---
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 171 +++++++++++++++++++++-
 2 files changed, 168 insertions(+), 6 deletions(-)

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
index a5df9c173d..78380a6f75 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -16,6 +16,7 @@
 #define semihosting_call hlt 0xf000
 #define SYS_WRITEC	0x03	/* character to debug channel */
 #define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_GET_CMDLINE 0x15	/* get command line */
 #define SYS_EXIT	0x18
 
 	.align	12
@@ -70,21 +71,171 @@ lower_a32_sync:
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
+	/* Should not be at EL0 - error out */
+	b	curr_sp0_sync
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
+	nop
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
@@ -100,7 +251,7 @@ __start:
 	 * maps RAM to the first Gb. The stage2 tables have two 2mb
 	 * translation block entries covering a series of adjacent
 	 * 4k pages.
-	*/
+	 */
 
 	/* Stage 1 entry: indexed by IA[38:30] */
 	adr	x1, .				/* phys address */
@@ -198,7 +349,8 @@ __start:
 	orr	x0, x0, #(3 << 16)
 	msr	cpacr_el1, x0
 
-	/* Setup some stack space and enter the test code.
+	/*
+	 * Setup some stack space before we enter the test code.
 	 * Assume everything except the return value is garbage when we
 	 * return, we won't need it.
 	 */
@@ -233,6 +385,11 @@ __sys_outc:
 	ret
 
 	.data
+
+	.align 8
+cmdline:
+	.space 128, 0
+
 	.align	12
 
 	/* Translation table
@@ -246,6 +403,10 @@ ttb_stage2:
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
2.39.5


