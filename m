Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7B0C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCMVG-0005SM-M9; Tue, 06 May 2025 13:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCMQk-0000Lb-0D
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:50:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCMQh-0003hm-Kt
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:50:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-afc857702d1so5804285a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746553805; x=1747158605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziWvuP2yCLI2zotueDBtJ4waOtELy7ZWSUvZwJzeEiw=;
 b=jzo6N+3SeEEvCtBiNWuWTjMRj22GukerD7DXs/TgseMFeHssIDM3JJH9xVw+Y8xPVW
 Gx5bKZ+3n0bLDU1u3uaRipsi/cmkDA9pcqiincuZ15jIcQfrY6zMmc0thCNfFrQmHrIB
 uvYNaGMOiSeF0kLvPkE5gd+vCVPH6OFxNIXG4V+d2s7zOkoFOIZ1+HruUVE5GuzogZaY
 6520dM2tHTrhj4AnJXtgxyNTFD5lUyrOiT/YPKmygTnwp3ZkC18dHS5qGpy8fsw/zjS2
 19QPGnOYGYLanD3H0KK3ySbp0URUOrTIWIX0EKkwqw6qViMpJ3saPGanXKVeckw55CvJ
 f6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746553805; x=1747158605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ziWvuP2yCLI2zotueDBtJ4waOtELy7ZWSUvZwJzeEiw=;
 b=DBhdiKVU3RNrQh+q3KZf1gdsEy40vbysVqILo6SDglZP9fy9FmcNVRidIJA/+kFztB
 46dgwoy/fezUK8pfiStRxtzenQgjc/6IEL3v+90zFiQDq7OZsQMNrigV0Qx+MdjuKbN0
 m0InPyb+JcwdPsr8iz/C1XmXKESloOOEQNrIwDeuwSqxNXhBwqFCv0RiA06VPsJhxYVC
 ZwnuzG9eDiDtHW6p/LCnsLtc9P2rs0+jt4/QyUV232TEw2rgC3AnbNBf9yybx5hV/+Dp
 WwqM/OH/78dZnKEPF+RvyypIp0gac/BzOYP04fwSpDpOQOkcgUQvxrIASPIrXfnwmSXN
 Mapw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCIaNMjhgfJ6VqMHqmiUr8VlWtjhMb+X30Tf6eaWXKx2kbOmOgyxX1Ysr/2xCIqmnHs1HU/WV1LoEi@nongnu.org
X-Gm-Message-State: AOJu0Yybc/7dBJhSt0J1QwrlGBSXSnTAiENpwX7robe6S+LBC8KCZkLZ
 QVn6DjYquYkt8cxqtBw6izzjJZHW4h0iOK0wMtFmRacvWq8ioKZuv0cQ4LuI7NwAAfa2SOtilLI
 C
X-Gm-Gg: ASbGnctK40/gCuS/rC4iLIwE6mrLuchELfEmN5JJtDhIYqDLC79hkW5iVzx+Q2ZY5SK
 LLveXJ6V2lxCJjOa8JuhG2r3ZnVvdrIiT4ka/mUsLsxbKTQrEFoWI1r6lgevJatiPI3tGXPSQvM
 Be3EthkXi2mbwUmZDJX0z23RJB8e/CMzsu5BcA8n5CMru6f/YJqiUi3LnorUVjm8WpB0kFi1Ki/
 vsrn+Q9j9OU1fYLeltlsJ1ie+nn6XOpJwymV1nWgvu3sWnZXILOqTMSVh8YJBxdUI07dEhGp9wj
 WCoM66sWnb5W27OZwPo+oUflYVCB5P/Po6uleu621nu5xcM08N3U4fIw5XCt0Ehx1P+5upUrLE4
 Oh8s/nCM=
X-Google-Smtp-Source: AGHT+IF38fYNxxSmh2i2oXx6/ZWu3ll4Fwa0eU9YKHB+3JTD8Ld+7G/YPWZhO6cL62YGXyQeqXoo1w==
X-Received: by 2002:a05:6a20:d04f:b0:1f5:8eec:e517 with SMTP id
 adf61e73a8af0-2148b728042mr192047637.9.1746553805274; 
 Tue, 06 May 2025 10:50:05 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbc12fsm9483055b3a.64.2025.05.06.10.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 10:50:04 -0700 (PDT)
Message-ID: <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
Date: Tue, 6 May 2025 10:50:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix incorrect rounding in fnm{add, sub}
 under certain modes
To: WANG Rui <wangrui@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>
References: <20250506152600.2521399-1-wangrui@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250506152600.2521399-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/6/25 08:26, WANG Rui wrote:
> This patch fixes incorrect results for [xv]fnm{add,sub}.{s,d}
> instructions when rounding toward zero, postive, negative.
> 
> According to the LoongArch ISA specification, these instructions perform
> a fused multiply-add followed by a negation of the final result.
> 
> Previously, the sign inversion was applied before fused operation, which
> interfered with rounding decisions that depend on the result sign --
> leading to deviations from the expected behavior. This patch corrects
> the implementation by applying the negation after fused multiply-add,
> ensuring that rounding is performed on the correct intermediate result.
> 
> Reported-by: mengqinggang <mengqinggang@loongson.cn>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/tcg/fpu_helper.c     |  8 ++++++++
>   target/loongarch/tcg/vec_helper.c     |  7 ++++++-
>   tests/tcg/loongarch64/Makefile.target |  2 ++
>   tests/tcg/loongarch64/test_fnmsub.c   | 20 ++++++++++++++++++++
>   tests/tcg/loongarch64/test_vfnmsub.c  | 27 +++++++++++++++++++++++++++
>   5 files changed, 63 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/loongarch64/test_fnmsub.c
>   create mode 100644 tests/tcg/loongarch64/test_vfnmsub.c
> 
> diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
> index fc3fd0561e..970b88ac56 100644
> --- a/target/loongarch/tcg/fpu_helper.c
> +++ b/target/loongarch/tcg/fpu_helper.c
> @@ -389,9 +389,13 @@ uint64_t helper_fmuladd_s(CPULoongArchState *env, uint64_t fj,
>                             uint64_t fk, uint64_t fa, uint32_t flag)
>   {
>       uint64_t fd;
> +    uint32_t neg_res;
>   
> +    neg_res = flag & float_muladd_negate_result;
> +    flag ^= neg_res;
>       fd = nanbox_s(float32_muladd((uint32_t)fj, (uint32_t)fk,
>                                    (uint32_t)fa, flag, &env->fp_status));
> +    fd |= neg_res ? 0x80000000ULL : 0;

|= cannot possibly be correct -- it would have to be ^=.

Is this a problem with the sign of a NaN result?  That's the only case that isn't handled 
by floatN_muladd.  target/arm/ does not use the float_muladd_* flags for exactly this 
reason.  The LoongArch manual has

   FNMSUB.D:
     FR[fd] = -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])

which matches the language in the Arm manual.  Which does suggest that the negation before 
on fa and the negation after on the result should be unconditional.

However, for this test case, if I'm interpreting these numbers correctly,

> +    *(uint64_t *)&x = 0x4ff0000000000000UL;
> +    *(uint64_t *)&y = 0x4ff0000000000000UL;

  0x1.0p256

> +    *(uint64_t *)&z = 0x2ff0000000000000UL;

  0x1.0p-256

> +
> +    fesetround(FE_DOWNWARD);
> +    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
> +        :[x]"+f"(x)
> +        :[y]"f"(y), [z]"f"(z));
> +
> +    assert(*(uint64_t *)&x == 0xdfefffffffffffffUL);

   -(0x1.0p512 - epsilon)

That really should have worked as-is.  I'll have a quick look.


r~

