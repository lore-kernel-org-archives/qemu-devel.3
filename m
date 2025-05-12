Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7631AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEScW-0006sr-07; Mon, 12 May 2025 08:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uEScL-0006kA-M2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:50:50 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uEScI-0005Vy-95
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:50:49 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-524168b16d3so3420673e0c.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747054244; x=1747659044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSSlv24hY/0OC75zbPVyrlSff1NxfPyECcOS06euD48=;
 b=aQCVxPYltLb0rbP5u+YbyF0bFEJ9NRAR2wA6piNEvEudQaJZNmUDXbu1Ghyf/WPzNR
 RjuRbIxQ+PM9zAdDKUbO8CdnME6UI478AnqC13GESHTuhf702XB4nqrfuC4OkDA2z/kS
 HOjYNiDU3MDZRY/cIT5SpKBrc9G/oxD6LIFRlL8vaAzo0OFi5clu+c0GoYbd+uv/ouTY
 eEHN+sAxQphw2EKRRmKiVDEfDxlYBp735/2QtszAL/o9jrfuhBLaBzXpAlqsRCajH7cY
 vx7eR5rkVIE5CuB1v1K58X9zQhiu0n29dNT4QiSDukda4/l/lBoCjPZVLbEwHHnDHwUY
 F03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747054244; x=1747659044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSSlv24hY/0OC75zbPVyrlSff1NxfPyECcOS06euD48=;
 b=hiM2TJ2CmIgMsSDTMau35tO1nw7qgy7F747P+g2XBn7RzkiqQ8N7sLh8m1gnbezJiv
 205pJBsiGniIC7UKn2v07UhGgZOtcVyfnHKID2ONqFjRd9cPL0m2Myh678qu/n19G72f
 fuaOKdBLXlvwOrrgupEKm/ild7/I+e6TPkWlmiZdveknX4Rpv88k/lagu0+7EzaCD4ue
 qCrXwCoIqnOKxJYrI9BVkIlP0PcPxxF/DnJueYJ53GwWj8RVlzFMEUNTFXQ27jNfeGn8
 jd7zdmf3jBoE0MFLSZ6hi44Ah02w550r8tTYHjECwivNTJigAC5Cwc9aZ/w//Jp9ryy1
 3t/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA7NMJB6tfvJ4O+Qn9oxUeRD881JOdQuAW+iCKrQGwzF7vHkZE245ZX89OMDMaGltdiWTPVr8kJT6U@nongnu.org
X-Gm-Message-State: AOJu0YyCYUeVO/OuJxfkEDTbsNMS/jbIKQecMI5+K2+YETtJl+/BtPtI
 uvlluDvkrEk+OWGqgJV1FMunsyJvBRDHFY9XG2+sbjQTHHZp0/hWy1wrr2y8ELU=
X-Gm-Gg: ASbGncvcVF7kHSY6s5LcrswL9KtWIp6zGa4EoCU8xvIhP8wAI1CbvEOIv5OcQ92QgR+
 AR/N8ZTzodmkq9OPOr6z+ABm2ma7DXWPWofH0KSWo7a0NMkm2UJuIcgO5p4sDGKaYJc/cPfj4kN
 N1D8sIfpUH0L12Q6LTQWsjtlua4hIve4a9gC56Bhb0bHPdS+j3mbXVky8HCpSv/WwBHyl0SgSoT
 WhqxDnE9deJgZXYk5sYxHMDKWAKigbDFane4dJpWurhhmVeZQ789F95DNJMOTKlEYEz8BsMD8n0
 aFssuT4CrCTHPOPta9096sYuq9QGMHrKH/Ayuf9bqYduFZy8SCDR1kwfaLekYpCFFg==
X-Google-Smtp-Source: AGHT+IH6bmtgT2/mht+6ILASt5GRwy3jNmqCtRv3qy0s4D92P1EJIgdvwpzakregeeVBeTZWlfJSCw==
X-Received: by 2002:a05:6122:8c0e:b0:523:91e8:324c with SMTP id
 71dfb90a1353d-52c53ce32fdmr9120311e0c.8.1747054244273; 
 Mon, 12 May 2025 05:50:44 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52c538a6e70sm5524272e0c.39.2025.05.12.05.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:50:43 -0700 (PDT)
Message-ID: <b595e8f1-f7e2-46c3-b2f5-96f17e99c1bb@ventanamicro.com>
Date: Mon, 12 May 2025 09:50:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/23] tests: add test for double-traps on rv64
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <cover.1746968215.git.neither@nut.email>
 <a8da56b19c033e4187dfaf2d279251381f1ff91b.1746968215.git.neither@nut.email>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a8da56b19c033e4187dfaf2d279251381f1ff91b.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa35.google.com
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



On 5/11/25 10:22 AM, Julian Ganz wrote:
> We do have a number of test-caes for various architectures exercising

s/test-caes/test-case

> their interrupt/exception logic. However, for the recently introduced
> trap API we also want to exercise the logic for double traps on at leat

s/leat/least ?

> one architecture.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---

With the commit msg typos fixed:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
>   tests/tcg/riscv64/doubletrap.S            | 73 +++++++++++++++++++++++
>   2 files changed, 79 insertions(+)
>   create mode 100644 tests/tcg/riscv64/doubletrap.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 7c1d44d3f4..5fba973e18 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -20,5 +20,11 @@ EXTRA_RUNS += run-issue1060
>   run-issue1060: issue1060
>   	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-plugin-doubletrap
> +run-plugin-doubletrap: doubletrap
> +	$(call run-test, $<, \
> +	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
> +	  $(QEMU_OPTS)$<)
> +
>   # We don't currently support the multiarch system tests
>   undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/doubletrap.S b/tests/tcg/riscv64/doubletrap.S
> new file mode 100644
> index 0000000000..b61089c9c1
> --- /dev/null
> +++ b/tests/tcg/riscv64/doubletrap.S
> @@ -0,0 +1,73 @@
> +	.option norvc
> +
> +	.text
> +	.global _start
> +_start:
> +	# Set up vectored interrupts
> +	lla	t0, trap
> +	add	t0, t0, 1
> +	csrw	mtvec, t0
> +
> +	# Enable sw interrupts
> +	csrrsi	zero, mie, 0x8
> +	csrrsi	zero, mstatus, 0x8
> +
> +	# Engage the double trap: we trigger an machine-level software
> +	# interrupt, which will trap to an illegal instruction
> +	lui	t1, 0x02000
> +	li	t0, 1
> +	sw	t0, 0(t1)
> +
> +	# If we still not went out via the software interrupt route after a
> +	# short while, we failed the test.
> +	lui	t0, 0x1
> +0:
> +	addi	t0, t0, -1
> +	bnez	t0, 0b
> +	j	fail
> +
> +trap:
> +	j	illegal_insn # Exceptions
> +	j	fail # Supervisor software interrupt
> +	j	fail
> +	.insn	i CUSTOM_0, 0, x0, x0, 0 # Machine software interrupt
> +	j	fail
> +	j	fail # Supervisor timer interrupt
> +	j	fail
> +	j	fail # Machine timer interrupt
> +	j	fail
> +	j	fail # Supervisor external interrupt
> +	j	fail
> +	j	fail # Machine external interrupt
> +	j	fail
> +	j	fail # Counter overflow interrupt
> +	j	fail
> +	j	fail
> +
> +illegal_insn:
> +	# Check whether we really got an illegal instruction
> +	csrr	t0, mcause
> +	li	t1, 2
> +	bne	t0, t1, fail
> +	li	a0, 0
> +	j	_exit
> +fail:
> +	li	a0, 1
> +_exit:
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
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16


