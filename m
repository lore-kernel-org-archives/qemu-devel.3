Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67953C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 21:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXR9K-000870-6n; Thu, 03 Jul 2025 17:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXR9I-00086M-Pg
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:07:16 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uXR9G-0004ok-VS
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:07:16 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d3900f90f6so31490885a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751576834; x=1752181634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAnY07EyCL8o9fgGf3cdrQzSE/PJTZzAdTm7kISpcB4=;
 b=JFku90Oil8dpINln/tl7ky/TJosWN4h/Fbrv4kxqiHpxZCeUmOxZ7/NNFFL3ptTlLW
 OPjzqZII4/CnENZ8qhurBPtwGI4Za6f3oXolwvrXPEVnwLNyIYBSsolBZuKGK5rSr1Z8
 t9npBlIfwZKaOaP0ZTAyZc2AAReszSSATCPBySAlcNJ2WnAhlNFG98wHMocf8HoRJAwN
 tz+/x2BLwfXMh9LynSKtgFfAQpCwxxejI9vC9aW2ciPgvEljXGd7c/NZDBlXyVBaTHkH
 VMwMANUsM/5CB9hPe5chvknT+d+4USht6/imKistCjUWx1Af2etxlKrUrMUU/dndMCID
 Dlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751576834; x=1752181634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAnY07EyCL8o9fgGf3cdrQzSE/PJTZzAdTm7kISpcB4=;
 b=tfPXQ/xa9dNoA/ONVnSA2I80y4KJ/4a6np0kEFP1EpQZgsiQGPA8D0AVFUClO4GP8z
 1xm5tCICc0J6ClWIDYWY7UdxOEY804lHslROVINxFsfPUJdQmxrAcAGzjGSYMMDds7n8
 49juVqNeKGwnTAea4ioDPpdsVEoALQEUgZ3ml+HgbpFE0Nc1beXCyIA/6YPQcmneIzgg
 UPCja4Ai+Hd78+kfQSwpYZUTinuMXzyAtgO+hKJ4jD6UL0xNjDkIQ+7+cIPidleUo4eY
 HD/dJb9xgmQ5buVg1iQhVnvJk3tnarKQqJD87B99EsAYJgIB89+WqB+4UtS7oZ6r8JwA
 yP5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN8f6hiFjGs1dAyhk/9d4ntsY95+V3SKtNMcqMVsRud7KMASgAJIE2AzjOuvcyBCcVKcZ06qUm02mx@nongnu.org
X-Gm-Message-State: AOJu0YyNOl0m9nQuWBc5vr/WA18UlXszaAfXCg+A1E36527dTXqWcKOk
 ZRgosB5QxKuyyJUk1SL6Qz+cFiW6utnBifV/ilButDW2VetLawEF58A7D0tfAeYN1Wk=
X-Gm-Gg: ASbGnctkOFldeSTMWKZ3N0Jppke+By8WQbp/0S3z254W9MLUG+Sl9CEq9T3psAenVkO
 cHcq633ghhAOsvRVRkIWuUmKVlY3lfryuVB4w7icpq8sbvZacNerIwykjsVCF1ejNJQhGSpp4gZ
 7YkKcRQIYfF6dpF3LxhB+wsahDCOGqSIGZhftf+Yd47gTLZW3CuGcD4g05vDMBDL+ZISxFmAs+M
 AYZm5Fd5saeTlCetn08Wb/UnkEv61sdqvuLjHALLxAqi+ZzTRFkn0RhKdC2rxW2PgEZM7A6+57t
 WVkgnGT9dlznzIPz6uSLJAkQEChOroLKmxvei9+GtgKd4hX8i0UWbWp/Ltr3PCG7fkN2UD79nh0
 42GOz/TYgJTbn
X-Google-Smtp-Source: AGHT+IFJmcHoPIzZ9L264veetB7nxvS2a+7JPWtJfEvBDpSSyE2BpSfEnDiOTdaw54r4hCf2QZIUqw==
X-Received: by 2002:a05:620a:27c2:b0:7c0:b523:e1b6 with SMTP id
 af79cd13be357-7d5dcc7603emr67525685a.11.1751576833609; 
 Thu, 03 Jul 2025 14:07:13 -0700 (PDT)
Received: from [192.168.68.110] ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbd93e46sm52290885a.13.2025.07.03.14.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 14:07:13 -0700 (PDT)
Message-ID: <bf6c0cc7-114c-4587-80d5-c152e7eef212@ventanamicro.com>
Date: Thu, 3 Jul 2025 18:07:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/riscv64: Add test for MEPC bit masking
To: Charalampos Mitrodimas <charmitro@posteo.net>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20250703182157.281320-1-charmitro@posteo.net>
 <20250703182157.281320-3-charmitro@posteo.net>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250703182157.281320-3-charmitro@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x729.google.com
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



On 7/3/25 3:21 PM, Charalampos Mitrodimas wrote:
> Add a regression test to verify that MEPC properly masks the lower
> bits when an address with mode bits is written to it, as required by
> the RISC-V Privileged Architecture specification.
> 
> The test sets STVEC to an address with bit 0 set (vectored mode),
> triggers an illegal instruction exception, copies STVEC to MEPC in the
> trap handler, and verifies that MEPC masks bits [1:0] correctly for
> IALIGN=32.
> 
> Without the fix, MEPC retains the mode bits (returns non-zero/FAIL).
> With the fix, MEPC clears bits [1:0] (returns 0/PASS).
> 
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---

The additional test is appreciated. Thanks!


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
>   tests/tcg/riscv64/test-mepc-masking.S     | 73 +++++++++++++++++++++++
>   2 files changed, 77 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-mepc-masking.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 7c1d44d3f4..3ca595335d 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -20,5 +20,9 @@ EXTRA_RUNS += run-issue1060
>   run-issue1060: issue1060
>   	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-test-mepc-masking
> +run-test-mepc-masking: test-mepc-masking
> +	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-mepc-masking.S b/tests/tcg/riscv64/test-mepc-masking.S
> new file mode 100644
> index 0000000000..fccd2a7ac4
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-mepc-masking.S
> @@ -0,0 +1,73 @@
> +/*
> + * Test for MEPC masking bug fix
> + *
> + * This test verifies that MEPC properly masks the lower bits according
> + * to the RISC-V specification when vectored mode bits from STVEC are
> + * written to MEPC.
> + */
> +
> +	.option	norvc
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Set up machine trap vector */
> +	lla	t0, machine_trap_handler
> +	csrw	mtvec, t0
> +
> +	/* Set STVEC with vectored mode (mode bits = 01) */
> +	li	t0, 0x80004001
> +	csrw	stvec, t0
> +
> +	/* Clear medeleg to handle exceptions in M-mode */
> +	csrw	medeleg, zero
> +
> +	/* Trigger illegal instruction exception */
> +	.word	0xffffffff
> +
> +test_completed:
> +	/* Exit with result in a0 */
> +	/* a0 = 0: success (bits [1:0] were masked) */
> +	/* a0 != 0: failure (some bits were not masked) */
> +	j	_exit
> +
> +machine_trap_handler:
> +	/* Check if illegal instruction (mcause = 2) */
> +	csrr	t0, mcause
> +	li	t1, 2
> +	bne	t0, t1, skip_test
> +
> +	/* Test: Copy STVEC (with mode bits) to MEPC */
> +	csrr	t0, stvec	/* t0 = 0x80004001 */
> +	csrw	mepc, t0	/* Write to MEPC */
> +	csrr	t1, mepc	/* Read back MEPC */
> +
> +	/* Check if bits [1:0] are masked (IALIGN=32 without RVC) */
> +	andi	a0, t1, 3	/* a0 = 0 if both bits masked correctly */
> +
> +	/* Set correct return address */
> +	lla	t0, test_completed
> +	csrw	mepc, t0
> +
> +skip_test:
> +	mret
> +
> +/* Exit with semihosting */
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16


