Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB8EC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 00:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgvic-0003IT-UG; Wed, 21 Aug 2024 20:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgviZ-0003Et-Ly
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:30:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgviT-0003D9-G6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:30:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7b594936e9bso198524a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724286614; x=1724891414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbhfdJ+vXkqcGL576u9oPp4leWyybB0oNlaZRZO+asU=;
 b=nAb48WFtkE4+6maVuVnMQ73iFiqSH1fq3yfaEAr+1iELkEAK7G1LU1eI85I5z0t5Vf
 XHZHuS0k/tjQE3cd4Co/kO11MgSPtKW+xk1juFUNW1XHgWkI6P+BIj54YIqdJ6VjST38
 lRzL8APdQJJDRB1slRMxJ54vMA1X48WINKlq+gbjb1egyNPE90/UuqZUXvhmAJpse/V4
 08yKWYxCrS/K9r666NudTLzB3NyEfftTaZ801XKdjqhbRtdP16PTycg/UwvSfCcadTuz
 gQnuYw7lUcVuX2vGQKdV9F/9edsMy+6VCxJYA3t/9ahbDI3WFYoiH6/CIxXraZjwJCGP
 fggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724286614; x=1724891414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbhfdJ+vXkqcGL576u9oPp4leWyybB0oNlaZRZO+asU=;
 b=XysQxoIXumeya/4Iuga/QKQ5DAe5g8FVujBDTd2FMdqhQcgUxrwU5oTbyoUuPaXKm4
 k2rBUz+E3mTJTfj1n8zmXE/R5Kl8NyZhrJD+RXwNgPoLyzcC0GarJLxPBUBJCzq2bpyW
 nY6TL+Ysxa6lhHl2vREGgaS9oceSd5qqHi0W5sH6qqXxr71rUERgU4nTGVUNnDadgE0t
 IprwV46Zquro5baNZltplNo/RA7d9E5e2v8Wu+FXBngElsjjtXHoXLkJaAzOatY4vMoX
 65ZyLOR7fw/3P0wzwZmWFk2Els8tDJpwf18XTYyjnVwXSIGPPMc5xOh1qUPdzbdBxfaC
 ZL5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXi8lhPsripUKWKNODJwxY3rbiJyU1SdLG4iFxhUzjmcXbrMO1dhS/i3nG3qaC9zDK4XvgSFzStj4@nongnu.org
X-Gm-Message-State: AOJu0Yyn8jsmhvSowcY6hX0UUihDUA2zi43t9l6MQf5+1rCvOUkKKD5+
 BSNJUXdo/glZ2WJjQ3EVavqwomvYhOPUHXumnv6/mkIMaC0xDW1ObrxPMltZjdGq8TFx9WIZ7Zp
 QCOE=
X-Google-Smtp-Source: AGHT+IFJsZuaC9nw6KmyNbPKal8Ac3zJ+K6y5FXhFL6o+8tvTXItSAhwb6OXEia0QZGLj+qPJjacOA==
X-Received: by 2002:a05:6a20:d486:b0:1c8:a0c4:2349 with SMTP id
 adf61e73a8af0-1cad81814a1mr5283715637.45.1724286613513; 
 Wed, 21 Aug 2024 17:30:13 -0700 (PDT)
Received: from [192.168.98.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434250f5asm239836b3a.69.2024.08.21.17.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 17:30:13 -0700 (PDT)
Message-ID: <1cb8d332-4092-4a2d-be24-01280f91cb8c@linaro.org>
Date: Thu, 22 Aug 2024 10:30:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240821215014.3859190-1-debug@rivosinc.com>
 <20240821215014.3859190-12-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240821215014.3859190-12-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/22/24 07:50, Deepak Gupta wrote:
> zicfiss protects shadow stack using new page table encodings PTE.W=0,
> PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
> implemented or if shadow stack are not enabled.
> Loads on shadow stack memory are allowed while stores to shadow stack
> memory leads to access faults. Shadow stack accesses to RO memory
> leads to store page fault.
> 
> To implement special nature of shadow stack memory where only selected
> stores (shadow stack stores from sspush) have to be allowed while rest
> of regular stores disallowed, new MMU TLB index is created for shadow
> stack.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
>   target/riscv/internals.h  |  3 +++
>   2 files changed, 34 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

