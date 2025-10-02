Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OvB-0001Zp-5d; Thu, 02 Oct 2025 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ov4-0001Y5-Fj
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:24:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Oup-0005pU-GC
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:24:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-28832ad6f64so15884465ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759433065; x=1760037865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYxWXD1VrLsiDZFYmI/K1x6gGms4I+Qu59ukqBsqEgY=;
 b=Q7ECKKEmmm6yYO6CqgQygvEtCu7NdM/obwSsVULWzQCHY85sGaQPAHjujFl14YQp6D
 WOjRckkHRt5HEpLiacaMJIHeoq/DtcVfOAqsTb7Ag4vPNhRP+SuUMNPThsUKFP65gX6N
 owUkDBGqr4A1UtY13wUvr3i76fS9F95Hc1uEJ3mg7Cr2tbgwxosg+dxN/WF+8sMY7mnm
 l3mmw/0Oq/OEiVdE+wL1RzW110xiE86DclztdrUJM8RoVkcTxs6cHS0Ite9PmOqDtnnN
 jtdYwhGIDc6T9v/gkS/wXs5H98F/t/BLpDucraz9Suu/u3uWQ3CLqdoTJ2Vdj4qBrF+b
 EddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433065; x=1760037865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYxWXD1VrLsiDZFYmI/K1x6gGms4I+Qu59ukqBsqEgY=;
 b=azvaOQxShw2+ufiX0SZ91D7czR4q0nsIYV86RjT3eH4h60RTHHTI5CvlNXQYD/tMt1
 rLd26roKXtx51tedj2JbQRA2vs6P4872IbGfWXwvdqvlJBudpLDoPC4K6h3UPkVmpmDC
 gX2lvQ+sDpSEYcNbZ6ZLZ8Boxv+7Hr7jWvXZpzs+IZkwV7fJDhp3zWfPTfCnCt71XbSe
 cCkg4RumngCjdrjZySUy46Gwiex/T1lFG4+Gu1SwbuTcJ9qa56vKjzSquoWhYlZ2IviZ
 S2+e+V60eTeQWKlD+SZZJuh+ifW7jHlSSqxKRcGzQnQg3Ch2RS9330GFl36m5HysZ3j+
 ASwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm7X0z5RRIl7iK27u6pwbu0i0DSXd1yQS4PNgRZCoMOyKS9Xdpxkf8jGt2AzikXSDd6JudhIIbpUBj@nongnu.org
X-Gm-Message-State: AOJu0YzU1o/D3mv6eBl/+QYnZZLxF1oGZ/YMaLiRHq0dbv57udZTYjnh
 UwvIBVFb+af/a4jyOpMYpVl/wQJIa/aKmp5Nb3g4+beAyqm/KasgDUFUa9XycodIzqF+AR7pSR8
 ZifIG
X-Gm-Gg: ASbGnctsYhCcpObNS3FZq/dFgaiJOvBef4ZtSCnVgYMtYNw/G++WMrvfD+jIebnpQ4Y
 /4qE/irvdgDYIGUjauhT9ZyMEh8u7hUJt6mvE2r4vP4UOSUfPk90UgkeHi6QAnEI033Ad6vALzx
 1T2Ew0LM+B6epyzsPbLsbslKbQ9f+7b2G80MXjFLc6uTszMF0yqpAI8TKi9fgqBAmWz6N5DGFd8
 gkbg+adhSvALNj3xx5kEo48HgVksrMrkmyWUHeiheD3oyWwN5UoDBfNbZnk//H9IFTyKyawjebA
 PIbuFJ/inI75Tv85xGQeSjrz406z7lGXHWZVXCiSRU4jpGrmwIYBTGWLflWxSSatZFoJQgUoLF6
 VhjNXwe2/jb88aZJBXpL/Oi0WIIUxVGW0+HFh6qmp5fl8K3Ma3qBXXwIiSjKvA7A=
X-Google-Smtp-Source: AGHT+IF6gg0PGvnQ9WKMhVEDLvZlMQ7KPSOihM5SiQjFln26KdxoqbnQbxnalbRcZQEs0bwW+4ZFZw==
X-Received: by 2002:a17:903:244f:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-28e9a6491e9mr4897395ad.42.1759433065145; 
 Thu, 02 Oct 2025 12:24:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d126efesm28606815ad.30.2025.10.02.12.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:24:24 -0700 (PDT)
Message-ID: <a3814f7c-cb74-438e-85ef-b580c10c6854@linaro.org>
Date: Thu, 2 Oct 2025 12:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/33] target/riscv: Combine mhpmcounter and
 mhpmcounterh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-9-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> According to version 20250508 of the privileged specification,
> mhpmconter is a 64-bit register and mhpmcounterh refers to the top
> 32 bits of this register when XLEN == 32.  No real advantage is
> gained by keeping them separate, and combining allows for slight
> simplification.
> 
> Note, the cpu/pmu VMSTATE version is bumped breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     |   8 +--
>   target/riscv/csr.c     |  74 +++++++++++++--------------
>   target/riscv/machine.c |  10 ++--
>   target/riscv/pmu.c     | 111 +++++++++++------------------------------
>   4 files changed, 70 insertions(+), 133 deletions(-)
> 

...

>   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> -                                         bool upper_half, uint32_t ctr_idx)
> +                                  bool upper_half, uint32_t ctr_idx)
>   {
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    target_ulong ctr_prev = upper_half ? counter->mhpmcounterh_prev :
> -                                         counter->mhpmcounter_prev;
> -    target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
> -                                        counter->mhpmcounter_val;
> +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
> +    int start = upper_half ? 32 : 0;
> +    int length = rv32 ? 32 : 64;
> +    uint64_t ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
> +    uint64_t ctr_val  = extract64(counter->mhpmcounter_val, start, length);
> +
> +    /* Ensure upper_half is only set for XLEN == 32 */
> +    g_assert(rv32 || !upper_half);

An assert will be triggered by extract64 first if this happens.
static inline uint64_t extract64(uint64_t value, int start, int length)
{
     assert(start >= 0 && length > 0 && length <= 64 - start);

Thus, you can move the assert before extract64 calls.

