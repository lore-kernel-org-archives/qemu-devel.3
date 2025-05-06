Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8899C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 18:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCN72-0007TY-Nm; Tue, 06 May 2025 14:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCN20-0000qy-6M
 for qemu-devel@nongnu.org; Tue, 06 May 2025 14:28:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCN1y-00082L-F3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 14:28:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so8019762b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746556116; x=1747160916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JIk6SVxImrntMFBsckaOJQeFarCaDJS5vu2HKcsBsYM=;
 b=SlrDBQXgCYEU4Tz18XWhE2/b5XH9Mby+3TwhYstEtfrV4nBx7bzSbMYxWaSa5HLY1f
 Tj+qiDbmbGJYGY1A05Elx/DA2y6cbHrHFZ0bMa3+fUqfkkD2YE+qc+MNdGBvKIHL0a71
 06Fs06h5lFfCsfdD9zafwDkvkF4F+IenkVrohO7x4Bl1KVvrRB2ZsEVpjM+HBuXhXgJt
 bGaGyYB84zHt5WuUomfi/mwSwIElQ7Qhxt5t91F5RNa9Fxrd9+LR5WR4tH814zkTa5J+
 Ba9WqrUwJbP3M983PKdb0wTGYOhF50BCoTcccvOhLk6nUHF0QYZCx+HZHqYEiZTDGDeo
 hvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746556116; x=1747160916;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIk6SVxImrntMFBsckaOJQeFarCaDJS5vu2HKcsBsYM=;
 b=uhfPjKR2/LWHIZxROZH0Xzn95VJTwBChTwDVuNILVXoBkX1x0xhqA71heYf5SOFsXy
 tUTDqaX2CrR2QGi4PVxmCMuOdK+rSrqLhyDrE1D2WuXwdhF+u0Z9ErMYNN4EAxYeJt+M
 ZLsO6+zajPUg+iq6A3yv4BJHZLwkzj7g7079Z+jLhxSrkdGNA17MoHe7yub/itmxbTxd
 2jXqJQ4Z1N9iq3p12rKFoPqoyWve1Y0NlugeJGcuzWtwqyTFHfNtKjxTY5WKvaqqfk3j
 ap5+3wVrjemVH6UIfMPlmpYhNYGtnAkeqk6oLkQewwcw+fXBLMFVugGcCS8jPQRc5Sax
 CoAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhoWX+fzXUSTkp0f/aPnJwjHlxbVQGoennH+HLqeNshUtNLb0MAOuBW7o+/K593iAfohWVxLdF7qAw@nongnu.org
X-Gm-Message-State: AOJu0Yz6qyakjdmLM0z5cETI2BDIgWkfpft4BKfR7qZcfmwI9yq7/k50
 YhWekAVppJha6RprGiKrcm213hFuEmrRrFWsvLuvAczHgdB8t1XoPpRLVpZ++nA=
X-Gm-Gg: ASbGncuJq1nrrseFWNySo5gLXVzUatCSxthVejvcQiBRpBaXULsAp3Vv3XsyUBLWw4m
 F3ZYLYWDIh5WMdyQmGBJT4SGRQqW5nP4QeXmdLcyxfUcpAZp9QbGTptfc6P7AGS9s7KMMLwort0
 AZtefbjimp++a23rWuv5aoeQ+bHQgVP3VIEytXtu5FkcGLJNfPjjZLwpsppFqJtUvvynWuldmfu
 OE/jJB7mqR699LMoMmm6kqejlhHJMUtaXxDxEB42PfQheg80ddnTDuA58fAiNjexxdbpvC+RRom
 R5RCC5cC64+ILp6rPUqcYF0khyajWvm8LA6FNCUJ6Py6eF1dQMx1DqmDU/SWhSSZMHAeUtGYP1U
 IeA5fv4w=
X-Google-Smtp-Source: AGHT+IF7uHVIGyJf6y/eBUCqlim8FHfiprQgLwLXBYSbzZimLLRgxvu4uXHP+hdK0DYoYzjIZ2oWwA==
X-Received: by 2002:a05:6a00:450f:b0:73e:23bb:e750 with SMTP id
 d2e1a72fcca58-7409cfef42amr222768b3a.23.1746556116457; 
 Tue, 06 May 2025 11:28:36 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f7asm9246943b3a.150.2025.05.06.11.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 11:28:36 -0700 (PDT)
Message-ID: <4e9fb340-dafa-446d-9939-91614fc8191e@linaro.org>
Date: Tue, 6 May 2025 11:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix incorrect rounding in fnm{add, sub}
 under certain modes
From: Richard Henderson <richard.henderson@linaro.org>
To: WANG Rui <wangrui@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250506152600.2521399-1-wangrui@loongson.cn>
 <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
Content-Language: en-US
In-Reply-To: <f0c44965-e776-4450-859c-ef60b292fa48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/6/25 10:50, Richard Henderson wrote:
>> +    *(uint64_t *)&x = 0x4ff0000000000000UL;
>> +    *(uint64_t *)&y = 0x4ff0000000000000UL;
> 
>   0x1.0p256
> 
>> +    *(uint64_t *)&z = 0x2ff0000000000000UL;
> 
>   0x1.0p-256
> 
>> +
>> +    fesetround(FE_DOWNWARD);
>> +    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
>> +        :[x]"+f"(x)
>> +        :[y]"f"(y), [z]"f"(z));
>> +
>> +    assert(*(uint64_t *)&x == 0xdfefffffffffffffUL);
> 
>    -(0x1.0p512 - epsilon)
> 
> That really should have worked as-is.  I'll have a quick look.

The negate_result is applied early, so we're computing rounding on the -(1p512 - epsilon), 
and since that's negative, round_down produces -1p512.  Whereas what the ISA wants is the 
rounding on (1p512 - epsilon), rounding down to 1.fffffffffffffp511, and only afterward 
negating.

I'm thinking that the current placement of the float_muladd_negate_result test is 
incorrect, since we're not negating the result, we're negating the unrounded intermediate.

There are only 3 targets which use float_muladd_negate_result: loongarch, ppc, and sparc. 
I will use this test case to test those other targets as well.


r~

