Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC0C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyD5-0000UA-HS; Thu, 22 May 2025 01:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyCw-0000Tc-87
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:11:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyCr-0008Fh-DO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:11:04 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so8146922b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747890659; x=1748495459;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aBE+gmB0wIIuuVY+QPTGxfpJaOc5JyIquMbbFNf8+x4=;
 b=J5Fv7UmTu4N/t1ItnxUrqUKT57p+St68+vCeEGBWbN3inX5RiCo6PSrybvVQ/nqdWd
 LWzEYyrb1dhgiNBF3ivIrPBhghMMwt3nzMGQQpv2PN/NUAgGdAkKUxdlO0O0DX9DIyXp
 sEIzAOo/p17BV6yWeJVAlRlW7BeMC+9ipy+OucZN2kqeCoLcvOTylz5+PJid8xd01cUB
 nUfQlTz3VPN305r1E2NyOJLhWkGgBUsgkt6dugWh75gWDm80auThwb8le/XyF4Xs/mDb
 C8TwMm3zdNJE84aTBKWmSdOnWM46IJKRv/6eK9QB3/9WsQksTNO2fQMhRwxy0AsXwpa+
 v9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747890659; x=1748495459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aBE+gmB0wIIuuVY+QPTGxfpJaOc5JyIquMbbFNf8+x4=;
 b=j+HJLbniLz/nW/hWs6vyx4uqs8sAfpEYQJP6XKqJKV8pKX1YK/62McqCWaOxrE3xaI
 N0YaMzWD+r6rUacHWd7jX7gM7O+tnwzWVbyejqkXbBmhY9lllcgA1EvMB5LRWG8+veKh
 yReFUtuqNyb2yvUUOuYtUT5QVEM7997Ze7LlUpImQPk25z2ZDstEl0hS52S7K6oBrjBT
 tHVjc09R2W6zcqcFuKz903p7BwHRB/0YHN3vxoWBlboALSyHcDJpIp5dR7VZPmB3EbIi
 W4Q9ACETaygpqiDoc8997js60B9KuOMivMc+XZVTVvvd7W+/xpw37PRA1yTHF1VuYuJ1
 tStg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhZhQMu7v31A4inqSHuj1WXFKDCQOJWP/7f2OeHAtKsECLBKsnKQHpdozxGPjRtNEEUMArJI+VBrQB@nongnu.org
X-Gm-Message-State: AOJu0YzvTQROxDWmyNf3DoGBu0Otb4G8Y0kbs/LlT2DrpvTKg9tuuzub
 Qt6ftjiJzyIp0MBCF2ksBcUfyAXTrhQJpW4dVQHRaSLjQ+j8YXnEp0ZzoYpe+UPai8c=
X-Gm-Gg: ASbGncs4do0z1dYXn0CfwkSOrW7oTwBXPkNZe+S6r6q5J6jEwGLKNNPl/o47IrNk7g3
 +qncnNBfM71qhaU5KORu06u3skNMo2afcF1NjKwF0/m9ITvhsIFB3JTTu2oxmOsQcvd15kfAa85
 yc3vLBnwWG79X3T21LwFrDtLg1o64DMjX92SQx0hj7OYKkP9Kv31y6YZ8kvQQw7IKL9FRXoFeL7
 9AkZeLp3GMFl98HWQQLYXQ3HiZ6nARTVv8r+qRHyMnNR22o9UQVBpkGRwNBBn/AYmLBp8Vn8tB1
 iT7W/wBDqomedqEuUWk4vz6gHrOzWbhl26UqMDcrxDf0AbIUfYMFcQiEdOTp3Q==
X-Google-Smtp-Source: AGHT+IGLQId5d3lmhJlTNd/LKsI9RLP1Xu7ZyxKwOYcuz2XpYztfNuIondhh0Mwh9XHsCLY0CR29cw==
X-Received: by 2002:aa7:9ddd:0:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-742b3a6dbc0mr23729734b3a.20.1747890658973; 
 Wed, 21 May 2025 22:10:58 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829bb3sm10752070b3a.100.2025.05.21.22.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:10:58 -0700 (PDT)
Message-ID: <7a76e746-9022-48cf-8216-775071e6d631@daynix.com>
Date: Thu, 22 May 2025 14:10:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] tests/tcg: make aarch64 boot.S handle different
 starting modes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 1:42, Alex Bennée wrote:
> Currently the boot.S code assumes everything starts at EL1. This will
> break things like the memory test which will barf on unaligned memory
> access when run at a higher level.
> 
> Adapt the boot code to do some basic verification of the starting mode
> and the minimal configuration to move to the lower exception levels.
> With this we can run the memory test with:
> 
>    -M virt,secure=on
>    -M virt,secure=on,virtualization=on
>    -M virt,virtualisation=on
> 
> If a test needs to be at a particular EL it can use the semihosting
> command line to indicate the level we should execute in.
> 
> Cc: Julian Armistead <julian.armistead@linaro.org>
> Cc: Jim MacArthur <jim.macarthur@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - create system stack so we _exit cleanly
>    - normalise EL string before compares
>    - catch when we start in a lower EL than we asked for
>    - default to EL1 when arg unclear
> v2
>    - allow tests to control the final EL we end up at
>    - use tabs consistently
>    - validate command line arg is between 1 and 3
> ---
>   tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>   tests/tcg/aarch64/system/boot.S           | 171 +++++++++++++++++++++-
>   2 files changed, 168 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
> index 9c52475b7a..f7a7d2b800 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
>   
>   # vtimer test needs EL2
>   QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
> -run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
> +QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
> +run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
>   
>   # Simple Record/Replay Test
>   .PHONY: memory-record
> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
> index a5df9c173d..78380a6f75 100644
> --- a/tests/tcg/aarch64/system/boot.S
> +++ b/tests/tcg/aarch64/system/boot.S
> @@ -16,6 +16,7 @@
>   #define semihosting_call hlt 0xf000
>   #define SYS_WRITEC	0x03	/* character to debug channel */
>   #define SYS_WRITE0	0x04	/* string to debug channel */
> +#define SYS_GET_CMDLINE 0x15	/* get command line */
>   #define SYS_EXIT	0x18
>   
>   	.align	12
> @@ -70,21 +71,171 @@ lower_a32_sync:
>   lower_a32_irq:
>   lower_a32_fiq:
>   lower_a32_serror:
> +	adr	x1, .unexp_excp
> +exit_msg:
>   	mov	x0, SYS_WRITE0
> -	adr	x1, .error
>   	semihosting_call
>   	mov	x0, 1 /* EXIT_FAILURE */
>   	bl 	_exit
>   	/* never returns */
>   
>   	.section .rodata
> -.error:
> -	.string "Terminated by exception.\n"
> +.unexp_excp:
> +	.string "Unexpected exception.\n"
> +.high_el_msg:
> +	.string "Started in lower EL than requested.\n"
> +
> +	.align 8

.get_cmd may be put before strings to avoid unnecessary padding for 
alignment.

> +.get_cmd:

I pointed out a style problem with this label in the last review:

 > This label is prefixed with a dot, which is inconsistent with the other
 > labels except ".error".
 >
 > I guess ".error" is prefixed with a dot to make it local, but a local
 > symbol needs to be prefixed with ".L" instead according to:
 > https://sourceware.org/binutils/docs-2.41/as/Symbol-Names.html#Local-
 > Symbol-Names
 >
 >  > A local symbol is any symbol beginning with certain local label
 >  > prefixes. By default, the local label prefix is ‘.L’ for ELF systems
 >  > or ‘L’ for traditional a.out systems, but each target may have its own
 >  > set of local label prefixes. On the HPPA local symbols begin with
 >  > ‘L$’.

> +	.quad	cmdline
> +	.quad	128
>   
>   	.text
>   	.align 4
>   	.global __start
>   __start:
> +	/*
> +         * Initialise the stack for whatever EL we are in before
> +	 * anything else, we need it to be able to _exit cleanly.
> +	 * It's smaller than the stack we pass to the C code but we
> +	 * don't need much.
> +	 */
> +	adrp	x0, system_stack_end
> +	add	x0, x0, :lo12:system_stack_end
> +	mov	sp, x0
> +
> +	/*
> +	 * The test can set the semihosting command line to the target
> +	 * EL needed for the test. However if no semihosting args are set we will
> +	 * end up with -kernel/-append data (see semihosting_arg_fallback).
> +	 * Keep the normalised target in w11.
> +	 */
> +	mov	x0, SYS_GET_CMDLINE
> +	adr	x1, .get_cmd
> +	semihosting_call
> +	adrp	x10, cmdline
> +	add	x10, x10, :lo12:cmdline
> +	ldrb	w11, [x10]
> +
> +	/* sanity check, normalise char to EL, clamp to 1 if outside range */
> +	subs w11, w11, #'0'
> +	b.lt el_default
> +	cmp  w11, #3
> +	b.gt el_default
> +	b 1f
> +
> +el_high:
> +	adr	x1, .high_el_msg
> +	b	exit_msg
> +
> +el_default:
> +	mov	w11, #1
> +
> +1:
> +	/* Determine current Exception Level */
> +	mrs	x0, CurrentEL
> +	lsr	x0, x0, #2	  /* CurrentEL[3:2] contains the current EL */
> +
> +	/* Are we already in a lower EL than we want? */
> +	cmp	w11, w0
> +	bgt	el_high

Shorter:

	/* sanity check, normalise char to EL, clamp to 1 if outside range */
	subs	w11, w11, #'0'
	mov	w0, #1
	cmp	w11, #3
	csel	w11, w11, w0, GT

	/* Determine current Exception Level */
	mrs	x0, CurrentEL
	lsr	x0, x0, #2

	cmp	w11, w0
	ble	el_correct
	adr	x1, high_el_msg
	b	exit_msg

el_correct:

> +
> +	/* Branch based on current EL */
> +	cmp	x0, #3
> +	b.eq	setup_el3
> +	cmp	x0, #2
> +	b.eq	setup_el2
> +	cmp	x0, #1
> +	b.eq	at_testel	     /* Already at EL1, skip transition */
> +	/* Should not be at EL0 - error out */
> +	b	curr_sp0_sync

This still says "Unexpected exception."

> +
> +setup_el3:
> +	/* Ensure we trap if we get anything wrong */
> +	adr	x0, vector_table
> +	msr	vbar_el3, x0
> +
> +	/* Does the test want to be at EL3? */
> +	cmp	w11, #3
> +	beq	at_testel
> +
> +	/* Configure EL3 to for lower states (EL2 or EL1) */
> +	mrs	x0, scr_el3
> +	orr	x0, x0, #(1 << 10)    /* RW = 1: EL2/EL1 execution state is AArch64 */
> +	orr	x0, x0, #(1 << 0)     /* NS = 1: Non-secure state */
> +	msr	scr_el3, x0
> +
> +	/*
> +	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
> +	 * otherwise we should just jump straight to EL1.
> +	 */
> +	mrs	x0, id_aa64pfr0_el1
> +	ubfx	x0, x0, #8, #4	      /* Extract EL2 field (bits 11:8) */
> +	cbz	x0, el2_not_present   /* If field is 0 no EL2 */
> +
> +
> +	/* Prepare SPSR for exception return to EL2 */
> +	mov	x0, #0x3c9	      /* DAIF bits and EL2h mode (9) */
> +	msr	spsr_el3, x0
> +
> +	/* Set EL2 entry point */
> +	adr	x0, setup_el2
> +	msr	elr_el3, x0
> +
> +	/* Return to EL2 */
> +	eret
> +	nop

NOP is still present here.

> +
> +el2_not_present:
> +	/* Initialize SCTLR_EL1 with reset value */
> +	msr	sctlr_el1, xzr
> +
> +	/* Set EL1 entry point */
> +	adr	x0, at_testel
> +	msr	elr_el3, x0
> +
> +	/* Prepare SPSR for exception return to EL1h with interrupts masked */
> +	mov	x0, #0x3c5	      /* DAIF bits and EL1h mode (5) */
> +	msr	spsr_el3, x0
> +
> +	isb			      /* Synchronization barrier */
> +	eret			      /* Jump to EL1 */
> +
> +setup_el2:
> +	/* Ensure we trap if we get anything wrong */
> +	adr	x0, vector_table
> +	msr	vbar_el2, x0
> +
> +	/* Does the test want to be at EL2? */
> +	cmp	w11, #2
> +	beq	at_testel
> +
> +	/* Configure EL2 to allow transition to EL1 */
> +	mrs	x0, hcr_el2
> +	orr	x0, x0, #(1 << 31)    /* RW = 1: EL1 execution state is AArch64 */
> +	msr	hcr_el2, x0
> +
> +	/* Initialize SCTLR_EL1 with reset value */
> +	msr	sctlr_el1, xzr
> +
> +	/* Set EL1 entry point */
> +	adr	x0, at_testel
> +	msr	elr_el2, x0
> +
> +	/* Prepare SPSR for exception return to EL1 */
> +	mov	x0, #(0x5 << 0)	      /* EL1h (SPx), with interrupts disabled */
> +	msr	spsr_el2, x0
> +
> +	/* Return to EL1 */
> +	eret
> +
> +	nop
> +
> +	/*
> +	 * At the target EL for the test, usually EL1. Note we still
> +	 * set everything up as if we were at EL1.
> +	 */
> +at_testel:
>   	/* Installs a table of exception vectors to catch and handle all
>   	   exceptions by terminating the process with a diagnostic.  */
>   	adr	x0, vector_table
> @@ -100,7 +251,7 @@ __start:
>   	 * maps RAM to the first Gb. The stage2 tables have two 2mb
>   	 * translation block entries covering a series of adjacent
>   	 * 4k pages.
> -	*/
> +	 */
>   
>   	/* Stage 1 entry: indexed by IA[38:30] */
>   	adr	x1, .				/* phys address */
> @@ -198,7 +349,8 @@ __start:
>   	orr	x0, x0, #(3 << 16)
>   	msr	cpacr_el1, x0
>   
> -	/* Setup some stack space and enter the test code.
> +	/*
> +	 * Setup some stack space before we enter the test code.
>   	 * Assume everything except the return value is garbage when we
>   	 * return, we won't need it.
>   	 */
> @@ -233,6 +385,11 @@ __sys_outc:
>   	ret
>   
>   	.data
> +
> +	.align 8
> +cmdline:
> +	.space 128, 0
> +
>   	.align	12
>   
>   	/* Translation table
> @@ -246,6 +403,10 @@ ttb_stage2:
>   	.space	4096, 0
>   
>   	.align	12
> +system_stack:
> +	.space 4096, 0
> +system_stack_end:
> +
>   stack:
>   	.space 65536, 0
>   stack_end:


