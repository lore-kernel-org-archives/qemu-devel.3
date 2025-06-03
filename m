Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFC1C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPN-00081L-Gg; Tue, 03 Jun 2025 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPJ-0007ve-Hr
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPE-0002A3-RF
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad8826c05f2so970928866b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948527; x=1749553327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPb8RRj9ZOs+lc3c2fT/refPNPIMxJmufi2jgYHy/Zg=;
 b=G3xf6FDE2ISkvYXC6INDHxs95mEBkDqcKTqcOGe3JJnl2mNWnAZ0Iw7UXPmLNZNDhz
 nqs0KLhD3aYVfETSRQUwDs4hXKx3brko6iOj4azX51U8rzqwa93w8Ef09bcRhRS/hiHm
 Owo3iP4Trl5slDrDx9TX0U/DIzuqx+q4s3tUrhM9CJDu/PpMef6czSI4OLrdQsluDzoU
 qfzxFOsitrVfHKTiZrMp+EgGxFQ3r0PRNEI6k+SPFfvMgsYeVWnnHi0kIsmpklprfDLo
 Vf6f8m12FKQZpJTut91hCmlDZpfFXGrFtVVKcIeNVk50ZoruV34cg60HFlI4VJcqUcxT
 mJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948527; x=1749553327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPb8RRj9ZOs+lc3c2fT/refPNPIMxJmufi2jgYHy/Zg=;
 b=gsiWz+4q8dREZTz3fxj8+KF/7BDIjjxEx3xdlmvEvGPS6FvbET67nE+q2yPe6LjR74
 lu+nl3L3brH1psEW6HJYtgt1ZHf/quNdorYRm5anElQ/wx/PSd7TvX7dMMRXQiCbX7Uj
 Vu2AIty6en3YVPSNOAjffnW5nR06W93Z1Eb8ZIX56yp5VsD6R23qkmCoXVI9+K6ARqDO
 t/YZ3z2mmZGYvIrfH3f3Rj2vejcPSRfomktdbhJmJUpgjWHrV5HYI5Lo8r9cMRKiEDfa
 7GSD5z5+34S5p/ZeHEQ81/MpXurmoU40H90LnVOZ24oudMrEiR+a735rYT3khOP42XXH
 FpWA==
X-Gm-Message-State: AOJu0YzQSRAKp6eDdAi1csQ4AqBY0mIJHi2dJOQeROrkh3LetFxRcL1G
 uF0QqU1H/ww4L/wSojrHdFO/LuP0gYC7njdbdIOVF6HA9vwBZ18v3KXUp3VvZNVU5Us=
X-Gm-Gg: ASbGnct7zDxNDtFdMMRhtb+Ufpolga2O7tlQgNodNaEXZTethYrlhCJIYMvAu2ebGZ+
 y8HShEz+hCI5s6AAE6x/Hr1Y0RAMwogQymFudkWNs22R1F4hElxs94UJJlLi03qa46pGJdwI1xe
 kTaxWvH/Pi5IdoIbheUx2J8M5lApEDECdeMOLxxWNXAb/unCK5SCg4WF/jT+/8chR+Ne609oPUY
 Bj3B4anX5mY2t73GrgMMfll5yUUflBF6ubtmeA0madQQc+nHQ68/e0pYfCrXF+wNqakDlLqUNNE
 kFRbGRkpM6H8jMmEhEfsmApHdYa6apkmpOkxp+QJkLDYwA598usovXCoiNbEDCs=
X-Google-Smtp-Source: AGHT+IF0KIPuoeV5rdcVdKOR0vC1mqECh4pnLKHwdwQaYDZnahQF8QfUXUBLANysDe7ORwoUb/eV6g==
X-Received: by 2002:a17:907:97c9:b0:acb:b267:436b with SMTP id
 a640c23a62f3a-adb36b4af87mr1558526566b.25.1748948527059; 
 Tue, 03 Jun 2025 04:02:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb390f09d7sm698366866b.148.2025.06.03.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A4D15F9CE;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 03/17] tests/tcg: make aarch64 boot.S handle different
 starting modes
Date: Tue,  3 Jun 2025 12:01:50 +0100
Message-ID: <20250603110204.838117-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
v4
  - drop post eret nops
  - proper error string for EL0 error case
  - clamp any invalid target EL value to 1
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
 tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++-
 2 files changed, 169 insertions(+), 6 deletions(-)

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


