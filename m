Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F275DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFzW-0004A4-Sv; Mon, 16 Sep 2024 13:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sqFzP-000408-KE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:58:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sqFzM-0005ir-7L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:58:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso2438219b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726509494; x=1727114294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+ZPDeUbgcig5LmOL9oFi6iQlTYoCgou2pgDu6Rm/tY=;
 b=ZEo1fl5VH0i4MR6LArBByCyzx98DwvGS+dPNH0sxYOf4xhoVCXMotYwSTE3tti4Kt0
 CHold5yjSTcybBAzcTgUkAEU/0tBDiCUhlUxsr4y/UZ71j6PHE0fbGCZVAYOZNeLmOWZ
 ZgbBatmHFyeXzdI8DIoY4cOlvDPuyJU8OsnfHvbVmJmlLf0X9B4fH32U+l3tYpXhk8VA
 w2FZfYBUvVmRWj9wJmTJwS+N/FVrrfMZtFzUVkVNxVoWCz175SHMamGooAvQ3lVSRW/5
 3nWotgLBovziq9JIVHZJkoSQy2wFqIAo3my0x/+h7lQ5rVasmjyDAu99ljUmm0PhjKge
 213g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726509494; x=1727114294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+ZPDeUbgcig5LmOL9oFi6iQlTYoCgou2pgDu6Rm/tY=;
 b=vwLT0fTpxQKEloDMLH3PTYtfJvGWxhPuILRVyl4gildia7fFCERLmxMJ/m/KnSa8xS
 OhIb5dylWwVulK6XNIVuSBgAxj93Jple347sGXgWaFJfX3Tl2UWWeGS05O4Ze/aCZz5W
 S4C1sVSMfNx4ZB3WwCkniCLDgG6UyFXt21FBbAYkYy4Yt3OQE4JVYhklrDmJFtwKXHit
 GC8HXBZdC7iZ8BC9QgOSHCzn/f9T1XB4V7GWS2AQJDuznrU9k+cH3n7hZxjR9+Ag9PhW
 cEoY3Tjgn/HZVI90tsRMdmrdR0BC4wo0XvpNt65jZAQR2DetvYzb/jiKuUDyWfQvwpTA
 cLGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs7SNKGEqXTnYOJ5L17Xuz+ibBeRwx+MY3UszOe1Je6mNfNL89iKJItgBwFAl08gWKMyH10L8qSA2H@nongnu.org
X-Gm-Message-State: AOJu0YxeD2UylM0f5JosOHfX2v+1+H3Lzlr9ndgwLkYati3VWjZSWx8Z
 cO48YIJi39ymcxTWwrav+dR9j1Zli8WwpJfSQhPu2QBdsmtEWMl73PzOPiHqh5E=
X-Google-Smtp-Source: AGHT+IHI/Goph/kaHS7IP6EaeLjUPthuru89bRXln8dPJ+/h3jmozRl+k+HuJJ1WxJDK90UUnD3Z/w==
X-Received: by 2002:a05:6a00:3e15:b0:717:88eb:824d with SMTP id
 d2e1a72fcca58-71936a49609mr20641832b3a.7.1726509494278; 
 Mon, 16 Sep 2024 10:58:14 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944a973edsm3964807b3a.2.2024.09.16.10.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 10:58:13 -0700 (PDT)
Message-ID: <bb3bbe72-91e3-47dc-a793-4a2196a58d31@ventanamicro.com>
Date: Mon, 16 Sep 2024 14:58:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] bsd-user: Comprehensive RISCV Support
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 9/16/24 12:51 PM, Ajeet Singh wrote:
> Key Changes Compared to Version 6:
> Included "signal-common.h" in target_arch_cpu.h

Thanks. This version is successfully compiling in a FreeBSD x86 host.


Daniel

> 
> Mark Corbin (15):
>    bsd-user: Implement RISC-V CPU initialization and main loop
>    bsd-user: Add RISC-V CPU execution loop and syscall handling
>    bsd-user: Implement RISC-V CPU register cloning and reset functions
>    bsd-user: Implement RISC-V TLS register setup
>    bsd-user: Add RISC-V ELF definitions and hardware capability detection
>    bsd-user: Define RISC-V register structures and register copying
>    bsd-user: Add RISC-V signal trampoline setup function
>    bsd-user: Implement RISC-V sysarch system call emulation
>    bsd-user: Add RISC-V thread setup and initialization support
>    bsd-user: Define RISC-V VM parameters and helper functions
>    bsd-user: Define RISC-V system call structures and constants
>    bsd-user: Define RISC-V signal handling structures and constants
>    bsd-user: Implement RISC-V signal trampoline setup functions
>    bsd-user: Implement 'get_mcontext' for RISC-V
>    bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV
> 
> Warner Losh (2):
>    bsd-user: Add generic RISC-V64 target definitions
>    bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files
> 
>   bsd-user/riscv/signal.c               | 170 ++++++++++++++++++++++++++
>   bsd-user/riscv/target.h               |  20 +++
>   bsd-user/riscv/target_arch.h          |  27 ++++
>   bsd-user/riscv/target_arch_cpu.c      |  29 +++++
>   bsd-user/riscv/target_arch_cpu.h      | 148 ++++++++++++++++++++++
>   bsd-user/riscv/target_arch_elf.h      |  42 +++++++
>   bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
>   bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
>   bsd-user/riscv/target_arch_sigtramp.h |  41 +++++++
>   bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
>   bsd-user/riscv/target_arch_thread.h   |  47 +++++++
>   bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
>   bsd-user/riscv/target_syscall.h       |  38 ++++++
>   configs/targets/riscv64-bsd-user.mak  |   4 +
>   14 files changed, 823 insertions(+)
>   create mode 100644 bsd-user/riscv/signal.c
>   create mode 100644 bsd-user/riscv/target.h
>   create mode 100644 bsd-user/riscv/target_arch.h
>   create mode 100644 bsd-user/riscv/target_arch_cpu.c
>   create mode 100644 bsd-user/riscv/target_arch_cpu.h
>   create mode 100644 bsd-user/riscv/target_arch_elf.h
>   create mode 100644 bsd-user/riscv/target_arch_reg.h
>   create mode 100644 bsd-user/riscv/target_arch_signal.h
>   create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
>   create mode 100644 bsd-user/riscv/target_arch_sysarch.h
>   create mode 100644 bsd-user/riscv/target_arch_thread.h
>   create mode 100644 bsd-user/riscv/target_arch_vmparam.h
>   create mode 100644 bsd-user/riscv/target_syscall.h
>   create mode 100644 configs/targets/riscv64-bsd-user.mak
> 

