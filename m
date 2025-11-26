Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47CED1118C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJqI-0004xL-GN; Wed, 26 Nov 2025 13:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJq4-0004vk-D9
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:02:06 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJq2-0003Mq-No
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:02:00 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo8343831b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180117; x=1764784917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awUNOYjDxiwO7q2P91Dm6/bM5O5H81wECevD/Vxkcqs=;
 b=C+IWDyGSK9qD8Ndik7CICIbSWzhOsKZwf3H/axX4TB9QVuLXKqA7M4LbmQqAtP6h/l
 DGWmNYH/UCy0aZ4GK/qaZJbSGZR7sD5OsAtNcOqNf6O2zbYPRajR0NNQX/dY87cZt08K
 pJsPgZuCC+ScbhRt0XC+nR5vA+BdIOVKTy92kqLVwxvcAozcgbIgttV/rVln09p0/JtN
 kGk6dWDVkZxTeUfT+6hHCYFDQoZ/SN7GAGaC4qmUdjgUuTu8Sx1w7BclNJWvh7XJK0jY
 kdN73m1Wi2RjxmVsEtvHNfUhfCdvaqObmY8qdeZ92ntCfSYYOc6TeUaDOPFaSQzPtc/Y
 L83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180117; x=1764784917;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awUNOYjDxiwO7q2P91Dm6/bM5O5H81wECevD/Vxkcqs=;
 b=EMrCUQnGWsUlD0QcQ9/4WWIp/PHviJRCHN6t+RgMj0PS/w3oEgqE7o6UzFUoF2xVpv
 nhMcq8vewaH8VvUdQuEf96yOY+9/F0R0xUUosS+V4sCfgdbmZLp/hzqd/um7W4gNlSXu
 FBQ2VvgQbHSuXsYvbf6dmwiUv2d8fjP14QVCxxjwZCKi57pVQQXrzfJ2V1PkEWEIDhdd
 rS07YaBPgwmDybyp7sVbZdzYYOp/yehw9gXmfvAaCn9HqHpvl8g0L9UBlhP4bayn7ep1
 IFQRtJrB7cX28mPCdB7uwtRZ8NrK7yqRkuuXVyoLfcAbPmpkUPPAo/CROBuIBqnWICbG
 /fEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrwM9WkRdzTAELfTKtb1sKP73ID02G8KnNLcjNDgl9KTzvgr4ehIw+DJRgCAJ2cBiVqJLNnCObJ8ln@nongnu.org
X-Gm-Message-State: AOJu0Yyp8lOrD63bY0eM3Ye++8vyWjmzJaOSxmywvFIkUgD7kFowBwzR
 42fYhuSt3b45tp1Q0mVT+xUcYHpdTazYM+mNa3mV6EyEgosa1fBmJ9erW8aUUSbyjCQ=
X-Gm-Gg: ASbGncutscbo1xt25wtdO9oe8NFxENpE2cN/5WilkIMxPqOKtIJdNUvb0cFGUPyra+B
 lUm0YoyCPjWd6fOiOvGjpo/6eUOQ8Elb3+2EONTT2qv4KYPpV4ksIBzEnhTLnrdasC5ydKz0ewp
 VG9CXrZTm++Au93bUkyqqjo4foz1JP/SRnRZ3wxvvC7I92RVj8Wvt1kA8OpDehBKJH67WhO1o5Y
 AkiAqqJncie1376y2yuMhVWB949n1vEUY60tsI8b0YbgU6w9BL79LrwklojL+3H2ikhCZ/DKIlf
 q5woA4IGRu9Rn9H5y84gRzaV0TCpakaPWrfFlYgP0aGrUmHVKjy3frdYwP4f2F56bm8plEORoew
 kL5wGvpkIIBCyXixyrqBaCBoHnj8oE7a4aRBOokzjgtCa/r62nEw8exhSVO7swViJ0+k7g2a0Xw
 h/fBa8gYKkDjuccZYFq83L0B8zIAPg7SQRwakYdyckXUkLJFPRL2s5WplHgpYE
X-Google-Smtp-Source: AGHT+IENLkB8dG7LkdDe1sGKQaU2cl0VDKx1J2SFkJqV2iGu3QhPOCDy4Wx527bXNX/txjPAZEgv0Q==
X-Received: by 2002:a05:6a20:a111:b0:340:cc06:94ee with SMTP id
 adf61e73a8af0-36150f41f8amr20335941637.60.1764180116527; 
 Wed, 26 Nov 2025 10:01:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd775ccabfdsm19766592a12.29.2025.11.26.10.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:01:56 -0800 (PST)
Message-ID: <873f44fb-3ff2-4b6d-bd05-0fed91c91b8b@linaro.org>
Date: Wed, 26 Nov 2025 10:01:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 01/12] target/hexagon: Use little-endian
 variant of cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 11/25/25 23:49, Philippe Mathieu-Daudé wrote:
> We only build the Hexagon target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=hexagon; \
>      end=le; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Brian Cain<brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/macros.h    | 6 +++---
>   target/hexagon/op_helper.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

