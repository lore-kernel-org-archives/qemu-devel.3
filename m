Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86FCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98N7-00026v-9r; Wed, 15 Oct 2025 16:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98N2-00026B-96
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:45:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98Mx-0005OP-9L
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:45:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso101835e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561107; x=1761165907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89S0CX547rC8THYkPWCjy3CF0sp/ueb59L3X+8Z6has=;
 b=MgZuOmGyNZLNlCYG7ZWuZuS/hBP+5VuIUdngvPNbSAIkst6e4nr2zjX7CzXAGu48Eq
 XGRfKmHB4yaUZFucOD4R3ChEQyEonry1A7bNpVUyYuDkGF7xf6tdlqWEoa9eZUScEcJY
 EcmWh2Lx0cR+AcnSIwLGk/TB9gY1Ri0fRRGSbyJtEYJNkawqphi4guQJvSoGEDn0AmOt
 maOL7GFOPqU6Wy10IGZFjv633mdPKWptS63MtV3+VOe4e38HANGbbdyTSoaOeVCjb2eF
 mC9SSPGuLnzRAIsYBwmjIA7n5Bsj6KsRBKS9xNbP5REQnUtRkb4f5cKbXUZrRDE4U3Rq
 AoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561107; x=1761165907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89S0CX547rC8THYkPWCjy3CF0sp/ueb59L3X+8Z6has=;
 b=o3JTzAvpZ+jtjp8kxUj2ld12NZCyx704d4r568btKgsZd9lWyw7QVVf0z8JwFpwgZ0
 ZrbEaG1C5msgxoOCjDFyXv5xiCdKE5b7DH5Iw9sBK5babh5/ryQeKdUcqsjtmDDcmko5
 w8LB2A+RrkqBTugsP8O0tiHKiMVoHNEmu5NagtWsri9bJdYNXcx5ZaL8x3uTfidDEa58
 FoIBusamEmLZLNKZeu/eqo/IuJuhfLKQTBPHhTM37Jz/2eNjbQMr2bHjBbQ4swe22ZX0
 DTF6tRYdbdKyeKd3zjvkEOw3mcwZGn1ci5TLf3LgtKohEN+c8YH0RQv1S5UOhqgQELZf
 nqMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXdz9BrxAbXpZDJ+Sd5bxCLqBdOLyr2St7cLVQWS5IIRRpu2cP0cvz8g7b3xiyrp1sLwsEGrdbmNXU@nongnu.org
X-Gm-Message-State: AOJu0Yxqd3eMLh3tlZ0M9r6GCxugagAxWXylYQZFzVjuO3u9PcI2MlDu
 earsa/zOk4gdERb8L8Ddkhn+tLxGYwcz0ws6wqsR5vbfVm1hpqL0S/r7gUL0WOg1cBM=
X-Gm-Gg: ASbGnct2lmzI5lkQ9jy1OYxLeX2BnJ0EjqWCJcY1njgPWYpgyIlNbM+2Yqq3JSTVyW9
 HoN9rX3EnLuLQ/TDpD2Oh1T7o1DL+KDaWU172I4NsaqvSKBC8H3kw5CJGLXC1C3YQVbSR/h6YlZ
 e09pvswy4YImPZ9FvOtchUV6O4eDlah/7cgXfVVyJoEDXJVm0F4uE/K/87fCYOuVngFL7hlTMCJ
 hWsFkiF+zqvK9S0HFXrvGXYuWtLe6AIvln8w4L8xfru9zW9s44CS2eBHvep9ooiFnC1lw3yvdDf
 rEK1RoIXwwAyGumpW6cfVtpBMoW10VFtY7FwqbmQ5+at5N2cBIVJJGjCFXUZ6TSWpHkrFvyvaWD
 G0tIvhWrgxRC7kWu7IJpHDyvaFhrxnj+StmpBPZLS+OHBeNalfQ6eEISvnhXZ+G6flU7kgbYlP0
 vZAzRQpaNArHmsrWo6zqVlYnahxLmv1jVjkBTuXB6xt0eHg+g=
X-Google-Smtp-Source: AGHT+IEEdWdj/zBiW/frZ7iIgO+GngB1quT3hG6+6S+6nXIuPC61Ha+MSC/xjuTSg8XeQ9Py9yYYPQ==
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-46fa9b17e16mr174167825e9.33.1760561107346; 
 Wed, 15 Oct 2025 13:45:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101be0c5bsm67595155e9.1.2025.10.15.13.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:45:06 -0700 (PDT)
Message-ID: <4fc973be-6295-4309-b054-c07b178664d1@linaro.org>
Date: Wed, 15 Oct 2025 22:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/34] target/riscv: Fix size of irq_overflow_left
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-26-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-26-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 14/10/25 22:35, Anton Johansson wrote:
> Fix to 64 bits to hold all relevant values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c192359e56..cb99314679 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -223,7 +223,7 @@ typedef struct PMUCTRState {
>       /* Snapshot value of a counter */
>       uint64_t mhpmcounter_prev;
>       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
> -    target_ulong irq_overflow_left;
> +    uint64_t irq_overflow_left;
>   } PMUCTRState;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


