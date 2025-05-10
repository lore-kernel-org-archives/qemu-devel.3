Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA563C3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 04:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDbiq-0006Lg-Cv; Sat, 10 May 2025 00:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDbio-0006LE-NR
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:21:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDbil-0004vN-Mj
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:21:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22fb7659866so26415235ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746850914; x=1747455714;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qPsDrHE/DgFgkvsM6mufkD2WR4T0NAe42f/Qx3S1T8s=;
 b=1mJNzPuSijG64ilTCT2+h/xtF5qA8Uq4KrPBxG1jz2GbV5ggbWwDyMPD1siVZa7W4b
 41Vs/1S/YGOFF/gaaQEG/Ss9Je2lYErIL8qMM9ofAaa8kRhYoAjCMG06Tw5l4IdfC/Sr
 X92U1ivJFQTQMPv+4t+AFQiQ4ZXAu78jnJ6PyFtHg1OPC2z/RVtWyd7fVq+q6IQfrWSi
 xU6yHI12ldTOlnZpCJgOezQ+bWUkRMUd2SFwfGZnITSOrDOEEZ9Y7aJ8eTXrsQfmRO25
 /3CBd4WJZxPjNlAAloMqr4WuqJti1zjhrqNa25xm1XAv5d5hQI+09iNZqj0mm++eXqz4
 oJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746850914; x=1747455714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qPsDrHE/DgFgkvsM6mufkD2WR4T0NAe42f/Qx3S1T8s=;
 b=sR7jVMAYnci+eLrQ4pSkbaYZE7vup/Adk5F3MY56Kw4Ts2yU3K3YOGdyIDBbT7SD1b
 TLc+Jy9M+bTTOj3YXCdAxenNO/4cfDGndb5+gy+ewgBU9+2znSVipK5sYzdi7oJhTPgf
 BzaRbQlA73+bkkk9XtHcZYTBExxIh5YxZWGVxQHoifbi6wOwm21goILaZpCRDaaOXc3B
 Jiyo9eKUH2fOG3fx6k2B42tgtzyGAN2pVD8OyV6E3aa4GlUKnwFar/0AvYqjA09Ifud5
 a8d8h1d9Xjt+F+iqUyGAc3xKA0tPl7RWrlX9bAviLuEKUdSwLdbAV8nDpLCivMNUMZuQ
 O4zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFMCx250JBVmUl5Ck6U8bC6/+Qj2Iv6MgpHIX8ffbS5VzIK1QHsiO0DLLVddQt9OXYy4bo0RZagDXl@nongnu.org
X-Gm-Message-State: AOJu0YwhTMkiGEeur5qlrez4N6whWw4+Z/LGsBlSA9Kq5mwVBuOsU3r2
 1Gx0LUWa+TeOwTD8Ona5mMthRdOcpSfCvByL4ONTULZOfwIbWNNkiLcOAvdzMUc=
X-Gm-Gg: ASbGncvxjOuKku2FCmqYbvFcfroOB18TqFNipdLFDP+ds/pxIhCioBMcUiT1+9+PWcF
 epU1Hd4qFKuBrECrCvv9D8lJ18UL2rNmXONnWfZ+s19SSjvQdBcXfsQ3Iaa7lwZTiZYYoqe4dWN
 Hu2HRBV1V9qSxvsUUuBRaaftiXhurr92heHL+wMn29hyk4efU+tenvsEqJHqmjI32/b6lwiT5do
 mSErzxejDgqQN9176ZcTSDEuk+We6thp/GvDAVh3DuFEx9ztLwi/YYWMAgt8y1ukHKayfTowZW7
 KBAt9uE8AGClXQw0U4BaLTfpVFNZlPIX4t3+2hNB4hH/0t3u+TDapsZgDeg+Ng==
X-Google-Smtp-Source: AGHT+IHxphVRFoXmz6jZVf3z8pHT4Ah1U0GfTb39t5YB6PE8f0K2EmkSBGB4+9ONoLjiTwB6HgyhIA==
X-Received: by 2002:a17:902:d487:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-22fc91a84e2mr85355995ad.46.1746850913593; 
 Fri, 09 May 2025 21:21:53 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfc20sm25262335ad.256.2025.05.09.21.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 21:21:53 -0700 (PDT)
Message-ID: <d2429cfd-d1b1-435c-b202-7f90f7365bf2@daynix.com>
Date: Sat, 10 May 2025 13:21:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] tests/tcg: make aarch64 boot.S handle different
 starting modes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250506125715.232872-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/06 21:57, Alex Bennée wrote:
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
> v2
>    - allow tests to control the final EL we end up at
>    - use tabs consistently
>    - validate command line arg is between 1 and 3
> ---
>   tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>   tests/tcg/aarch64/system/boot.S           | 135 +++++++++++++++++++++-
>   2 files changed, 136 insertions(+), 2 deletions(-)
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
> index a5df9c173d..a52d28c881 100644
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
> @@ -81,10 +82,137 @@ lower_a32_serror:
>   .error:
>   	.string "Terminated by exception.\n"
>   
> +	.align 8
> +.get_cmd:

This label is prefixed with a dot, which is inconsistent with the other 
labels except ".error".

I guess ".error" is prefixed with a dot to make it local, but a local 
symbol needs to be prefixed with ".L" instead according to:
https://sourceware.org/binutils/docs-2.41/as/Symbol-Names.html#Local-Symbol-Names

 > A local symbol is any symbol beginning with certain local label
 > prefixes. By default, the local label prefix is ‘.L’ for ELF systems
 > or ‘L’ for traditional a.out systems, but each target may have its own
 > set of local label prefixes. On the HPPA local symbols begin with
 > ‘L$’.

> +	.quad	cmdline
> +	.quad	128
> +
>   	.text
>   	.align 4
>   	.global __start
>   __start:
> +	/*
> +	 * The test can set the semihosting command line to the target
> +	 * EL needed for the test. Keep that in w11.
> +	 */
> +	mov	x0, SYS_GET_CMDLINE
> +	adr	x1, .get_cmd
> +	semihosting_call
> +	adrp	x10, cmdline
> +	add	x10, x10, :lo12:cmdline
 > +	ldrb	w11, [x10]> +	cbz	w11, 2f
> +
> +	/* sanity check, clamp to 1 if invalid */
> +	cmp w11, #'0'
> +	b.lt 1f
> +	cmp w11, #'4'
> +	b.ge 1f
> +	sub	w11, w11, #'0'
> +	b 2f
> +1:	mov w11, #1
> +
> +2:

This "sanity check" made me wonder what it is for. This code is simply 
unnecessary if any unknown values are to be ignored and is a bit 
misleading to have this code as it looks like it adds an additional 
behavior. "sub w11, w11, #'0'" is also unnecessary; we can compare w11 
with '2' and '3' later instead.

The patch message says this sanity check was added with v2 so I looked 
for a previous review and found this:
https://lore.kernel.org/qemu-devel/svmkvs.2mf5q4qhsfz83@linaro.org/

 > cmp w11, #'0'
 > b.lt curr_sp0_sync
 > cmp w11, #'4'
 > b.ge curr_sp0_sync

Now I get the original intent; it was to raise an error instead of 
simply ignoring unknown values. However I also see a few problems with 
this original code:
- It still ignores unknown strings that are longer than one character.
- curr_sp0_sync leads to the code that writes a message saying 
"Terminated by exception.", which is incorrect.
- "cmp w11, #'0'" is unnecessary if you check the value after "sub	w11, 
w11, #'0'".

> +	/* Determine current Exception Level */
> +	mrs	x0, CurrentEL
> +	lsr	x0, x0, #2	  /* CurrentEL[3:2] contains the current EL */
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

Why is a nop placed here?

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
> @@ -100,7 +228,7 @@ __start:
>   	 * maps RAM to the first Gb. The stage2 tables have two 2mb
>   	 * translation block entries covering a series of adjacent
>   	 * 4k pages.
> -	*/
> +	 */
>   
>   	/* Stage 1 entry: indexed by IA[38:30] */
>   	adr	x1, .				/* phys address */
> @@ -233,6 +361,11 @@ __sys_outc:
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


