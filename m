Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E720CCD18D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eRR-0003uV-Kq; Tue, 14 Oct 2025 08:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8eRQ-0003u6-Jg
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:47:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8eRJ-0003NQ-VX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:47:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-634a3327ff7so10819883a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760446057; x=1761050857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzcCdvqVExjkLrdp+A5jr5Gzjr8KK8VBYoh/fTORjEQ=;
 b=NJaeDfUtaOWuDyWeJZThEhF6i8nVPMPj2vvhaw+8NHFzZl8BR9zxuMr4EQKI0h/cgs
 13M6HlP9SXmwDogfJXr9wq4P7sYC1fFGUIjJbya4ABO5NRS02BNFZtk8QxNCD18wv2mw
 cN7ox5wPA0uyxJR8T+rQXmMPDXxrK41xX1t7HxB1MzCjnMYawG++NlGIaOJd/5Lpsyas
 woEmYzS375I5UZ71SE5cFyyds3D//We9EZ75rYfqd0zxTdnmRiXhvTBG+XkRSfJY/RT2
 nfdlKcht3x22cnsbW4adsN0vKlD/TiIt1l3UO0d0G6SlBD5OaD0WDWLhlTrj8eb4nXu3
 Kk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446057; x=1761050857;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FzcCdvqVExjkLrdp+A5jr5Gzjr8KK8VBYoh/fTORjEQ=;
 b=CZjVE9nllt14zR12vOLhuzW6+v76fRoJmRusfG38RlCIqWmq5/5KH4Pkh0srIM6JQ9
 JnEgWyFlR5/7BbdOUHG/tvYbjj2MSk9sE9IjcoxnYjW1kTLrZk+iGyKwSpVd2kSs2YsE
 U0ZI2GSIJqkpIfjN5vLNzu9ZgBXGZCxG79DnKb/h5fJwfGFiKAVA27VhRf3aNvQXVRsC
 PwsK61uZi+Kp0kPdFlNjiog8FaozutOTUDe/1wCJYdmVdPKv8xS/+WeSlgdjD/lOGlTr
 okLf/8RjA01/o+Cqhfn9bnCRMNTTs3i7076/NhM1nZpP+qOX8fMzi54ZlqONBTZiaFcN
 h7Zg==
X-Gm-Message-State: AOJu0Yynsb7UGlxMkMV2nezvon6qk9Gd/o69zj1HzfIQ3q96eLHBE1Y2
 z8v3uChkWVbF1VBhlD+c+du1n5eogBHwmE/OJGENpHYaS4gcqfes9mCwJ//b/coboD0=
X-Gm-Gg: ASbGncuimzxKSGP0BEgGPdVs1fqrA9s48xnmpZU221PB5Cm9/TWTJ8vA/gT7SHTv3KO
 wnCmykGYR8w1YZR6eL4lfsO1FKmtMO/H57hiF9Kh5MWBiDoJRvZPn0KARJim3WlgfiOgjscqyUw
 /mFE6lxk92f09HGdp0dvz9vtW4by1oRr2TNVIVNQyRy0gN9qsF3dfzDU+qAhM8zYTCWyoqhgQkI
 2c3W9CowNLXAHiLtX2GYHwBdbQnoWYrO4UxqP14CzJAQ9n7ahzw+ky4mvkSMpRHx1ACysGnE5t8
 Xa7KT8aS1arb/heZO/klOdP1v1mAZSDIVTycdSnk8NDJ4aiSFPHCBawJXJDGM5LAjwOgi656gQN
 p6LUarXZKXDxDau12UCjSQvlXb7uZKebPwgskVL41ADN9hRSefCmSPoSw
X-Google-Smtp-Source: AGHT+IFnz6+YfnK3Z8hw9t93tzgf+lO2jkmS8U5hxVB8zl32u0LiOBndlgoGIHbPX2e5A80b2bK/3A==
X-Received: by 2002:a05:6402:2809:b0:639:c9c2:3956 with SMTP id
 4fb4d7f45d1cf-639d5c5a382mr24681592a12.28.1760446055853; 
 Tue, 14 Oct 2025 05:47:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5235dca9sm11132257a12.8.2025.10.14.05.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 05:47:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 617A85F812;
 Tue, 14 Oct 2025 13:47:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: Re: [PATCH v7 25/25] tests: add test with interrupted memory
 accesses on rv64
In-Reply-To: <729c8db0f4b61033f5a460747ea50fced9dabc1e.1759744337.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 6 Oct 2025 11:59:20 +0200")
References: <cover.1759744337.git.neither@nut.email>
 <729c8db0f4b61033f5a460747ea50fced9dabc1e.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 13:47:34 +0100
Message-ID: <87frbllkex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Julian Ganz <neither@nut.email> writes:

> This test aims at catching API misbehaviour w.r.t. the interaction
> between interrupts and memory accesses, such as the bug fixed in
>
>     27f347e6a1d269c533633c812321cabb249eada8

Even better the abbrev with title:

  27f347e6a1d (accel/tcg: also suppress asynchronous IRQs for cpu_io_recomp=
ile)

> Because the condition for triggering misbehaviour may not be
> deterministic and the cross-section between memory accesses and
> interrupt handlers may be small, we have to place our trust in large
> numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
> decided to loop for a fixed amount of real-time. This avoids the test
> running into a time-out on slower machines while enabling a high number
> of possible interactions on faster machines.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
>  tests/tcg/riscv64/interruptedmemory.S     | 67 +++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>  create mode 100644 tests/tcg/riscv64/interruptedmemory.S
>
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv6=
4/Makefile.softmmu-target
> index 1a71a78653..d8f92b8e61 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
>  	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
>  	  $(QEMU_OPTS)$<)
>=20=20
> +EXTRA_RUNS +=3D run-plugin-interruptedmemory
> +run-plugin-interruptedmemory: interruptedmemory
> +	$(call run-test, $<, \
> +	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> +	  $(QEMU_OPTS)$<)

Something went wrong with substitutions there because I see:

  timeout -s KILL --foreground 120  /home/alex/lsrc/qemu.git/builds/all/qem=
u-system-riscv64 -plugin ../plugins/libdiscons.so -d plugin -D .pout -M vir=
t -display none -semihosting -device loader,file=3Dinterruptedmemory

There doesn't seem to be any output either when I run it manually -
should we be checking the output and at least confirming we are
detecting the right sort of events?

> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/in=
terruptedmemory.S
> new file mode 100644
> index 0000000000..a32d672849
> --- /dev/null
> +++ b/tests/tcg/riscv64/interruptedmemory.S
> @@ -0,0 +1,67 @@
> +	.option norvc
> +
> +	.text
> +	.global _start
> +_start:
> +	# Set up trap vector
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	# Set up timer
> +	lui	t1, 0x02004
> +	sd	zero, 0(t1) # MTIMECMP0
> +
> +	# Enable timer interrupts
> +	li	t0, 0x80
> +	csrrs	zero, mie, t0
> +	csrrsi	zero, mstatus, 0x8
> +
> +	# Find out when to stop
> +	call	rtc_get
> +	li	t0, 60
> +	slli	t0, t0, 30 # Approx. 10e9 ns
> +	add	t0, t0, a0

The runtime of 60s seems quite long for a tcg test. Can we not show
stuff happening in a shorter period of time?

> +
> +	# Loop with memory accesses
> +	la	t1, semiargs
> +0:
> +	ld	t2, 0(t1)
> +	sd	t2, 0(t1)
> +	call	rtc_get
> +	bltu	a0, t0, 0b
> +
> +	li	a0, 0
> +	lla	a1, semiargs
> +	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
> +
> +	# Semihosting call sequence
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +rtc_get:
> +	# Get current time from the goldfish RTC
> +	lui	t3, 0x0101
> +	lw	a0, 0(t3)
> +	lw	t3, 4(t3)
> +	slli	t3, t3, 32
> +	add	a0, a0, t3
> +	ret
> +
> +trap:
> +	lui	t5, 0x0200c
> +	ld	t6, -0x8(t5) # MTIME
> +	addi	t6, t6, 100
> +	lui	t5, 0x02004
> +	sd	t6, 0(t5) # MTIMECMP
> +	mret
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

