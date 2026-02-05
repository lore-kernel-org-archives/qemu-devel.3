Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C63EA7966
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 04:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnr6e-0006nY-89; Wed, 04 Feb 2026 23:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnr6c-0006n3-O4
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 23:36:38 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnr6b-0000QN-5c
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 23:36:38 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so604981b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 20:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770266195; x=1770870995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PwoKjZlALAMKycsCbRjNHfPD6VbPqrSwbc0AdAoTn/k=;
 b=EUVzevKgZvsvKjpBapoZC12Fo94fFegMqdfH4pCcp2mQtXChp9dFysYAftSehrURcV
 HEua8tWehQuEdg/I9LBPik0bscAB+1rDIyrY3lz4goobeMy+fLiUKk8TmW39NwhwTnNE
 8LHwJcejkROpCxWKGDJqGDWVRvSBjU2sUzvgTzWHkQRoXbLUizh49/apdXIWGLCloNtR
 66doQeHZbr3RITpfnyCsCFLEtdFVPJdJjadDYyQbkXLVUVn/WcYdv9uxnBaGJe/sOFtt
 tauFJbETyTgI+cUVLXsXHYHbxgGm+MGa4kGEfd0r2B8Zm56PqR6DGFuAtbdIVW7uFukV
 Lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770266195; x=1770870995;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PwoKjZlALAMKycsCbRjNHfPD6VbPqrSwbc0AdAoTn/k=;
 b=t+TrLcxGiCput0bgF4F+fx6AcqsT4mZGPMvrg8phiTpONuuNC6/U91YZR/dRjHyC6o
 yCedteEylLg13dDMqJZYCdqjE2enOE9+eTYTvc9zSdRw7nZk+1DKBpGr9oFxetzDXtCx
 1YLtt/3naPS7H187VC1RJpTEHo9X4xCFh5ChU3pJOyvG7zKq+s8DIXOdHmiOqy5G+DrR
 47eiiV/fhWVKYWydBbrGUctYyNZiXLuZzUb0Z2x7mJOGWHmfeBlX9Lq5t4sIg0r2WfLk
 ZsbLYeLSp2jmqZpRejyvSltVnfwbOxTyGCfW9uxc9/2KGKuaD2H/54OZRFIB+6DBVn9c
 0Exg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb9y2+DiX8+EGo9z3U9It32jU/viQUDBNAugSuXYFLShncSbEvvQQiHdoTY5HB9/Ud1ZMk0x6rvBTi@nongnu.org
X-Gm-Message-State: AOJu0YzlR/gYZxOdZaTd2L5DYicoylt39mciuHjBKdNbNiBZFVX6B8DW
 9sWAiP1sTtxWqtiwZ0tnKYAv0ze7c1HyUUvYI2HHmAmnfWgdzxyjIm1xCtOBfGnKNO4=
X-Gm-Gg: AZuq6aJwXwwrAMhSRRkLbudmfy6sl+/TuK71u3ARxeEV2M3XDB9sEX4L2Ddn2Fr3rSm
 3H9/21tMS2tygZTqm1SP1afCnnoO7UYamlbYRGx6hy/FxunwX1wCcGmDZn86cC7wmc7HpePwCER
 3PmP8SP+c0nb9YjinuMtzXIG3VE9bDKSAcATl5abZKVwIqauyOfe3SVfCyVWSdR445xI/lKkoel
 MPSR2acripiRCpALAxgM9EQyUaa2vKL4KBD5JbPBwJi/N1YLnGbBQ3kJlLm4JLl/xUw1MwVPKat
 1pwQ5nt+mwGyoTlr02qRQoJ1zJkcdA2ltFry+u1TizdhaSfVQZqNaTHCErSNMwtFtNXw3LfXeii
 Cxuk0cU17CjKcRKh+G/Hdif5J7WNYr+MKzJsRgqUZtbMvXIBjcCBHl+9ZkfRl5gJmNZbjHomAoE
 jyLCq/ZBB109xSXfYLu9K0Fn7C9P9nAue4UjfvzyZn/q85yww/Je2arjSVwMffbHJzdsvy18dt5
 6au+cnOFrB8n7aO7f7zRLgaZbgVv2xagsprfm2Cyg==
X-Received: by 2002:aa7:8881:0:b0:81f:3c34:fa78 with SMTP id
 d2e1a72fcca58-8241c1deae5mr5906549b3a.25.1770266194798; 
 Wed, 04 Feb 2026 20:36:34 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d43851csm3999861b3a.31.2026.02.04.20.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 20:36:34 -0800 (PST)
Message-ID: <797df006-5270-462d-a0a4-4e5951cbdb1d@linaro.org>
Date: Thu, 5 Feb 2026 14:36:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] fpu/softfloat: Support OCP(Open Compute Project)
 OFP8 data type
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-6-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204051756.667397-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 15:17, Max Chou wrote:
> This commit provides the implementation defined behavior flags and the basic
> operation support for the OCP float8 data types(E4M3 & E5M2).

I'd really like to see this split into parts.  Beginning with

> @@ -542,11 +549,39 @@ typedef struct {
>       int exp_max;
>       int frac_size;
>       int frac_shift;
> -    bool arm_althp;
>       bool has_explicit_bit;
>       uint64_t round_mask;
> +    /*
> +     * Format capability flags:
> +     * no_infinity: Format has no infinity encoding. When true, exp=exp_max
> +     *   with frac=0 is NOT infinity - it's either NaN or max normal.
> +     *
> +     * limited_nan: Format has limited or no NaN patterns. When combined
> +     *   with normal_frac_max, determines NaN encoding capability:
> +     *   - limited_nan=false: Standard IEEE NaN (exp=exp_max, frac!=0)
> +     *   - limited_nan=true && normal_frac_max!=0: Limited NaN (E4M3)
> +     *   - limited_nan=true && normal_frac_max==0: No NaN encoding (AHP, E2M1)
> +     *
> +     * overflow_raises_invalid: Raise Invalid (not Overflow) exception.
> +     *   ARM Alt HP uses this to signal overflow as an invalid operation.
> +     *
> +     * normal_frac_max: For formats with limited_nan, the maximum fraction
> +     *   value (after normalization shift, including implicit bit) that is
> +     *   still considered normal at exp=exp_max.
> +     *   Use NORMAL_FRAC_MAX_ALL (0) to indicate all frac values at exp_max
> +     *   are normal (E2M1, ARM Alt HP), which also implies no NaN encoding.
> +     */
> +    bool no_infinity;
> +    bool limited_nan;
> +    bool overflow_raises_invalid;
> +    uint64_t normal_frac_max;
>   } FloatFmt;

... this.  I wanted to say something about this vs previous revisions, but I hadn't had 
anything coherent to say besides "meh".

In particular, I think separating "no_infinity" and "limited_nan" leads to confusing 
checks, such as the one in parts_canonicalize where you test "limited_nan" in a context 
that is really testing for overflow to infinity.

Further, normal_frac_max is defined oddly, such that you have to test it twice, once vs 
frac_hi and once vs NORMAL_FRAC_MAX_ALL.  Since this is used for exactly one format, this 
is perhaps trying to be overly general.

I think better might be:

     typedef enum {
         /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
         float_maxexp_ieee,
         /* exp==max is a normal number; no infinity or nan representation. */
         float_maxexp_normal,
         /* exp==max, frac==max ? nan : normal; no infinity. */
         float_maxexp_e4m3,
     } FloatFmtMaxExp;

We can stage in this behaviour without also including either FP8 format.
Just changing Arm althp in a separate patch is large enough.


r~

