Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27762CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vzp-0000mn-S7; Thu, 09 Oct 2025 15:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6vzo-0000mR-9w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6vzl-0007HZ-Ve
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:08:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1061982b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760036886; x=1760641686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4TNG7ELvrSqB+9dOebhSoNp03ttXxYoXDXu1Ilb2x3M=;
 b=IJVQQ2yCv4IH+FpTysIU2kEq4Xe3GOiNy5bluZD9QLaA63IBuvi2HyQy9nOoEG4kcX
 0EsF7DwR2Jj0L5s/7isyVeYDy/ktmuXlmRHYHGWBPUh7Tp1ahbiKSInAqPCqHqt9ah0l
 7HSP7ADSDhsCeBxXkf2eQAmUpTrE+XHCV55h0z3hSKf2Qgsc2KDH1oe7JQVfMJUQwdQD
 TMloLzfmMg9wI33M3rg/y1fBdV+7NBS3xo3iETUvJqYedl8cUnfwzspt+5bVUgenpFWF
 2osApSJz3/Z0MEasTBn73w71DT4V07hWwBNgy7hVbplB6yKdBxuH8D9wl5/Emxx7Ub9S
 Mw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036886; x=1760641686;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TNG7ELvrSqB+9dOebhSoNp03ttXxYoXDXu1Ilb2x3M=;
 b=OkJGwMJjd6lTfPjgDYDtIN2Qw+828/ycGG38DF3NUsSZfwxNlq2oLEAf9Yb5mzixDt
 HgI7Bb6KveVJ5r8tId33F/gWa3+/gfSt4r9iTtEvOl2AbUASE56LNik+/J5P452bpQMc
 dTsjWsXxBDK+O7l2vp+hhZxli+1jcTo3RywKWEb4QOELJsIz4EZF535AspygFmKltfhw
 lzpR/bj7XK4yE6+uiNo1Q+W02Z8NUAa1rgEuNL3PmplwTWxzw9oNRGUb9w6UbrFuCLk6
 tnljE7T9Y7iAQ8AwH3Gny2g3od83NtGuDtEulgArNXM9993PxcDv21htJOkrbcqy21h7
 hjyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5WJtFiCi0Qu0oABTDxiJaijCFknys93iPVGHOD+xRr8e0to34D1QZ7S32KzSiatvcfMcuz8Ifbnpj@nongnu.org
X-Gm-Message-State: AOJu0YyBiWFxOtLsoWBbM2Zn+vsSCRxrolFsdmdLvVXZX4MHNMh6xef3
 uNoi3O6M18UDMMjOYjOOpLP52l+ymfhlCyubfuDZbKLaaomzFnB2Mk6GfAd7/K+MZzg=
X-Gm-Gg: ASbGncvLtWw2F+EWzHbLEFS1RNDAy3JxQCky7kzk8z7RilmMZvb/+28pA0YCRZyDv5H
 pPm2wkxqdUdNnE3PCJEgt21MRP67ryfod71g6vGOU2aAKDAZ2un9JGU6Y/TKPvf+dd8vWN98xan
 upWIL9rvOFc4f94b6iFiHTKZpKXQNr7ZMVKMj6aIhsKcOQMjRAO6y5M+8MbD9NI2xgFZbU/F+eS
 Fto39vub+Lsok42hP3TZI5hKyLALT/v3Qf2jbmVN98Sn9jqlNIpyNIptQ1gL3pxtf/J5/kiVAMG
 XS7w1vAJoWSW8wxMO4BkfYq9mc1Z8SuxjzcMpMpdLWctLSXwYHzIcLRWlwrgozetxHNCG3IvSur
 P+vQQtf9Vqyh24jvZ9OMUo44VlimVXHIairr6Vv7yrnDHaiSWRlRtTzDuBdLqu9M2dn9T6yeWzb
 U=
X-Google-Smtp-Source: AGHT+IHabsmZFQGuh2CznvKavbwqpdXvtx1iz4C2ttNs6OSBlTYZboq5t/qQUffgfNn9Ji9uXiH6XA==
X-Received: by 2002:a05:6a20:1591:b0:2f6:9592:907f with SMTP id
 adf61e73a8af0-32da83e39bemr10894144637.29.1760036886231; 
 Thu, 09 Oct 2025 12:08:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b06075fsm508250b3a.17.2025.10.09.12.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 12:08:05 -0700 (PDT)
Message-ID: <9a2ce733-514d-497e-b885-7c7c551f34b3@linaro.org>
Date: Thu, 9 Oct 2025 12:08:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
 <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
 <f745f163-6bad-47ad-a1c0-4be96b604266@linaro.org>
 <c75dc27a-5c56-4010-a205-a8296a9ab1e0@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c75dc27a-5c56-4010-a205-a8296a9ab1e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/9/25 10:43, Philippe Mathieu-Daudé wrote:
> On 9/10/25 19:23, Philippe Mathieu-Daudé wrote:
>> On 21/8/25 22:27, Richard Henderson wrote:
>>> On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
>>>> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
>>>> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
>>>> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
>>>> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
>>>> is C_NotImplemented.
>>>
>>> Not true: ld2/st2 are also used for 128-bit load store.
>>>
>>> See: aarch64, x86_64, loongarch64, ppc64, s390x.
>>
>> OK. Hmm I guess I need to add a __attribute__((unused)) check like
>> you did in commit f408df587a0 ("tcg: Convert brcond2_i32 to
>> TCGOutOpBrcond2") to outop_qemu_ld2/st2 then.
> 
> OK I figured my issue, I shouldn't remove the following in the
> MIPS series [*]:
> 
> -- >8 --
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 3f4aca25b13..c519dfbf7d5 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1311,2 +1311,34 @@ static const TCGOutOpQemuLdSt outop_qemu_ld = {
> 
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    MemOp opc = get_memop(oi);
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
> +    ldst = prepare_host_addr(s, &h, addr, oi, true);
> +
> +    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
> +        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
> +    } else {
> +        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
> +    }
> +
> +    if (ldst) {
> +        ldst->type = type;
> +        ldst->datalo_reg = datalo;
> +        ldst->datahi_reg = datahi;
> +        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
> +    }
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    /* Ensure that the mips32 code is compiled but discarded for mips64. */
> +    .base.static_constraint =
> +        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
> +    .out =
> +        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
> +};

In the mips32 removal series, you should be removing the functions and simplifying this 
structure to

static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
     .base.static_constraint = C_NotImplemented,
};

> +static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {

Likewise.


r~

