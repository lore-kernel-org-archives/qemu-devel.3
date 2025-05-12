Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFDDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESdO-0008Uz-OT; Mon, 12 May 2025 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uESdL-0008Rh-TF
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:51:51 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uESdJ-0005cQ-UP
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:51:51 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-8783d2bf386so1136993241.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747054307; x=1747659107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0dMbmUTO+d1NfmxBMkSxF5qFgaq9PUVR8zKUYgXgECo=;
 b=aDJSu2J0pscQJZbaAgf8lCorpYX//wwQs3No3uotuIBNeyv+PDjrzjawRV7wpHIHQN
 NShUVWQzuI8UAe16FSXotPY/6nYNKu5y2us0n8SVGEce3Tp685lpKrPikIVXHtCuEjXt
 E2bFqAMICFdtHJ/L/auTTHdYqZlSp9rkUpxqh1+iekLLoa9/ztzhgtJmz9iy2ksA0ORz
 zMzRgZAQzYUxfg4aPrO7zIpcMn4RW1zPMJfWcdOYezim/GQLdGmJaQQ3D6z++0PqsL4F
 rovhD4hZ7WB4InqHxE/aSOm6WSIzY/RuCV1w43caI0d4dO4N+F7ML1qtMXd9LOsQ8/xe
 29og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747054307; x=1747659107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0dMbmUTO+d1NfmxBMkSxF5qFgaq9PUVR8zKUYgXgECo=;
 b=tD6ptkvYj2MOFIFVQZraCJ9qvzxHEfpxXIHvj6g0OQDm4ohbAevXGQuQQxFxYXfU+A
 e7OpT+ymvpzw/OYPXB10GNntILa/QFWj7jT4/fagWELr2iOqBxBEpRC1aWHG2yyCWdPf
 GJ30yFjft8+FPcd7UVE5ybQT6+I5ZBrqyPBJFPCrbRqsHe3FWN8to6ree2KHwyRLoEPG
 eUiZGHJxePkFvQZPbzVZ7OcJiYZRLKyjEI7vm7XIgSYMVTdesilrIHnw3OfFuDYswltx
 9K60SzQKkOv5syx/8EZsct05ZoLdlwQFD+CjIvoRgQxct7pSlbVEC+tafrWRal/sYYB8
 zJUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrTPUpbTfBIiARRQ9mr62KCTop/nOz4cWJAxwMTOe4u9XBb6F+hKLFSvpK4RvhofnzN44p7La6l9AO@nongnu.org
X-Gm-Message-State: AOJu0YwBVKIvbJMVzTo4gsdBvLCjVC1I/08C98AfZgHL5NVV3kWQHkak
 FjixfYbdklETKeCiNK4DpO4gaYZQgu8B5kAhWr2CHzm9FiXTZgBbyQvSs5KzeI4=
X-Gm-Gg: ASbGncu0yeBdUsS4HO/8CgjrqK/xRD+rGmL5E8Ua8Y0BlHRVqEonZrD/4Yc58o2b9HY
 CwbviyJCIziDWmKgoVKaMbiwYqfMf9zy6SR6G8ToHHhZwfj65zc7t4pBDfARfxGRhCsJyU/56jA
 f2zavcliA5Gh2vcBd9yNH9aFt244T+hKOk2voRTHnkuA2W1TUzA6lwuytpqX90JiBkABq5sX/jz
 hnhxZLt7OGsO+DL3jAxordE2zXwmPWS8bwdAZPqr5O5m0rLQH8gZNx7giXihTAYk/BGnEdKRRP7
 10snAp06XEtGyF1/GBXHWZSkCZQMI/PeYCDtC3qdixqCAFgcjHO4XA1juL+L1MTsIoOXh8Ms51e
 L
X-Google-Smtp-Source: AGHT+IG47Wb+tkjW1BSM/M92+Qe2QP7JWTBypFWGjiwzlXM5kWvqICfu5AVo6+NOE7JTxz6ERVIalw==
X-Received: by 2002:a05:6102:15a0:b0:4dd:b9bc:df71 with SMTP id
 ada2fe7eead31-4deed3552b0mr9757958137.10.1747054307161; 
 Mon, 12 May 2025 05:51:47 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-879f613b5d0sm5012615241.6.2025.05.12.05.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:51:46 -0700 (PDT)
Message-ID: <76f367f0-c92d-46e3-97a4-daa8c594b5ad@ventanamicro.com>
Date: Mon, 12 May 2025 09:51:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] tests: add test with interrupted memory accesses
 on rv64
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <cover.1746968215.git.neither@nut.email>
 <1e94b1c43e90ec21333dcf5ddcf5130090cabfe3.1746968215.git.neither@nut.email>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <1e94b1c43e90ec21333dcf5ddcf5130090cabfe3.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x92c.google.com
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



On 5/11/25 10:22 AM, Julian Ganz wrote:
> This test aims at catching API misbehaviour w.r.t. the interaction
> between interrupts and memory accesses, such as the bug fixed in
> 
>      27f347e6a1d269c533633c812321cabb249eada8
> 
> Because the condition for triggering misbehaviour may not be
> deterministic and the cross-section between memory accesses and
> interrupt handlers may be small, we have to place our trust in large
> numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
> decided to loop for a fixed amount of real-time. This avoids the test
> running into a time-out on slower machines while enabling a high number
> of possible interactions on faster machines.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
>   tests/tcg/riscv64/interruptedmemory.S     | 67 +++++++++++++++++++++++
>   2 files changed, 73 insertions(+)
>   create mode 100644 tests/tcg/riscv64/interruptedmemory.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 5fba973e18..5d07755964 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -26,5 +26,11 @@ run-plugin-doubletrap: doubletrap
>   	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
>   	  $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-plugin-interruptedmemory
> +run-plugin-interruptedmemory: interruptedmemory
> +	$(call run-test, $<, \
> +	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> +	  $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
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


