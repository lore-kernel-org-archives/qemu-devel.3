Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D9C369CB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 08:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8aqs-0001D6-7m; Sat, 26 Apr 2025 04:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8aqp-0001Bn-Jh
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 04:25:31 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8aqo-0003ff-03
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 04:25:31 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3035858c687so2580049a91.2
 for <qemu-devel@nongnu.org>; Sat, 26 Apr 2025 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745655928; x=1746260728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJbb4+hSkt4RHYhhwAGL8sPw3IdMVtm60UXZ2B4P7oY=;
 b=fCtOWh/3cmzoHXNLYH2Ekp35oLBrth4YvAVuRdSYdCCml957cG8zhedvyrIdbix1Lu
 DlkDUPi2JwPbRS6EB07qnFEL3BMcInLYodImFhSz2peLugL6uP6QK0Q6cSyIYb5SD1H3
 9BQoiGzROVxHU4GjVarxkzTl+BdU9Ydqh8CauFWbMRRQwhcYXncEqppNbif1ke4JH5RU
 CtqGWjLKjQjTh0QW1yPVk9fpOHhqtSWwDbpgTQEgmNytZJTm4lKJ9z9N7MeIXGrFfMwd
 O5SjP1yZldjPTKzArXQXCSzTpGlQ35+blieRMrA3izkdRJyW2e0AhMUshhuDaAkNWpaY
 9Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745655928; x=1746260728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJbb4+hSkt4RHYhhwAGL8sPw3IdMVtm60UXZ2B4P7oY=;
 b=d2WjOF6uXKUsTxht6KPF21GNYmLBLVlGOUIt/6rbaHIuJs7V9DKlaBRhMSKJMdL2QX
 sypYvG8kU013z/rbEbkc4mLg8v+76sfUeMUqh3I+5Ck0E9lTYzsmXx/LiKGVNHoTEo8x
 51XvGvYWdWrxBE9GKHGE9RcnePLoEFojINXlWmCsgzMy617uWQDafALLEpbdOuniP88J
 phCx+SHHpnRy12/J5unjzbZWKX9LNAUQjNHZ0Hh3ebMGzpYFTb981/sK/bn3ZNJyfgR/
 EVucmhw/l4z2fXkUvGTflPSCUcLt8judEq22Ky8K2wemqQ+03Qh3fWUKCX5p6X2dS8ej
 5Enw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzgip1BStMY9thVYKf9a/hKbNIK4sE5gm83O2Sk4cIl3/PmOId6la8Q8Q6EzN9quecSMIV6k9ZOwA1@nongnu.org
X-Gm-Message-State: AOJu0YwLiRQdRduQidEkNkiQyF0xFxlEy9P4qHqRXYK2IlhevHEy82Rw
 QOyq0Uv1HonDgpd47HKjBWM6pIs/8YyB76vnsyVhISWVFj+sumZl5RFmSCDGiWA=
X-Gm-Gg: ASbGnctk/EG+vOBVDx1q9PkRaDru0TuRF+io8Q3UOj9S2QEPX9bQ9Ih3KrcJdEK9btc
 bQlifJMLl11nWa8qifZsOtJ9+fjyJnTV5guaHr/gSd+6R9MN3rsYfWiCSI8PelcQepwpiU+aQeV
 e8pVcookLcPas/yhI/cj0CLbeLqiqvvfuqqAI+Z4FFXhWG+FwerGQi+sl6WO7rMKGTogKVz1IRD
 sb+pQOOOes/cfgCVZxOT2Q9YZ0+K6DW6xNzHg+QQVRwFoI2SotVj/LYO5cQ4sGC3AAf9WUwamDd
 YAKWPHSPmOGENy8o6SfmNv+vOJrERSVLitsFXVOvBDIZjY/i4bOytZo=
X-Google-Smtp-Source: AGHT+IGH+mBV3pXLErxkR1zZ/9mp0TuWQsoypui8DmRK0Yq5Buy90yUN1vfhywKLdO2Mn0gAQEL3bQ==
X-Received: by 2002:a17:90a:d64b:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-309f7d87c12mr7356160a91.4.1745655928083; 
 Sat, 26 Apr 2025 01:25:28 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef14a190sm5358262a91.47.2025.04.26.01.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Apr 2025 01:25:27 -0700 (PDT)
Message-ID: <9ce04866-e6b9-4fe6-9a60-21c0084cda84@ventanamicro.com>
Date: Sat, 26 Apr 2025 05:25:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250425152311.804338-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
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



On 4/25/25 12:23 PM, Richard Henderson wrote:
> As discussed, the use of GETPC() within write_misa is wrong.
> I've done just enough plumbing to get the helper return address
> piped down to write_misa, so that we can make use of unwind data.
> 
> AFAIK, nothing in check-tcg or check-functional would test this.
> It shouldn't be too hard to write a test akin to issue1060.S,
> but I'm going to leave that to someone else.

All patches:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> 
> 
> r~
> 
> 
> Richard Henderson (7):
>    target/riscv: Pass ra to riscv_csr_write_fn
>    target/riscv: Pass ra to riscv_csrrw_do64
>    target/riscv: Pass ra to riscv_csrrw_do128
>    target/riscv: Pass ra to riscv_csrrw
>    target/riscv: Pass ra to riscv_csrrw_i128
>    target/riscv: Move insn_len to internals.h
>    target/riscv: Fix write_misa vs aligned next_pc
> 
>   target/riscv/cpu.h       |  15 ++-
>   target/riscv/internals.h |   5 +
>   hw/riscv/riscv_hart.c    |   2 +-
>   target/riscv/csr.c       | 278 +++++++++++++++++++++------------------
>   target/riscv/op_helper.c |  13 +-
>   target/riscv/translate.c |   5 -
>   6 files changed, 169 insertions(+), 149 deletions(-)
> 


