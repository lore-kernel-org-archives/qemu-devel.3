Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED3BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafvu-0007j1-KA; Thu, 15 Feb 2024 12:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafvt-0007ie-OD
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:54:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafvs-0000XB-37
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:54:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-411e71d8a2bso8298265e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019638; x=1708624438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7D3W3q0hxEsxgAn47lR7TzgEK+IPMcBeno3/WStGTbE=;
 b=LSwtTYQ1G2RDfEfaJTAwVrmGPHcbELbBPm3kQXIoklawKMaNXKItq8i8som7BnMKZl
 cEep1HpYG8HXMeBTfUoRxJd5gQhSj+KLMJIGlzXUqWnEGMp19ILUEUJq5g3Rd0AWUt9a
 lK2Jl9r572dayuzRuD99/OKGgsZedxVlwrVJEBVLP+Kr66fgRy1A5hhxTI+kvUxqP7ww
 8XqSVdmO+B7wNSOUyfkdc8HOv9kNs+4OQH+k8ettQP381Spu3QXjhfg8gF4BQuZ6myUK
 DS0ZdWC5qTDR0k0Ko98IkxZLpCi7UfVvKvRSAGIVv/+afQFoK04pup1DvhejGIq0v2bo
 E3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019638; x=1708624438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7D3W3q0hxEsxgAn47lR7TzgEK+IPMcBeno3/WStGTbE=;
 b=lKae/XVZmAtN0sbk18cM2A6WJdX7ZVvY4xa25yK4CDCoSEr9es3uBTGXCN6NApBvKs
 h73oEvF3oaZQb8jhGD+HPOnbgevboUao1yMw2rnCKjD8dZiVfvBjGZYbCH4/lX1DUmdI
 8o1+z9ZUIFO46yvXFOan9Lis6jrRKJb6X8aWfZ4YePpmI6JplOIidtLb0EWSRl49gN4h
 YOSFCUqjtHZSFkZGIssWzYNE3BSfwTFWfPIyW0bxIChmvZ7G1UO+SFfLFjfVbJucOAzs
 CkUbHlSkeHPxQnFKSRhFztbjLn5mW9Vox9eowW6lQNJwNtBbOv/fDvyfVK2i1vcn+DMX
 +iIA==
X-Gm-Message-State: AOJu0YyU3AWYSFkzHiz3mmEYkw3g7cK81+zPEPDok21ShAbjBKCoS982
 z3GGpVOAUjdorfIOhaIGDSXsDtdMJeiXNpogt0lZhEcYphFP+TNaZxfv8ya8Rwp5eZ4A71H4g3v
 4vxI=
X-Google-Smtp-Source: AGHT+IGmQe3IeZ96sYtMMJY+OSvJ1g/Fnb+hsj8CSnRdv0fA/MD3GmHvjd8jLtwfk01Y+U8BX2d6UQ==
X-Received: by 2002:a05:600c:5486:b0:411:eb73:243b with SMTP id
 iv6-20020a05600c548600b00411eb73243bmr1984378wmb.5.1708019638148; 
 Thu, 15 Feb 2024 09:53:58 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c044e00b004104bc8d841sm5680826wmb.13.2024.02.15.09.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:53:57 -0800 (PST)
Message-ID: <b8592713-6992-4641-bf92-6749c94a5d0c@linaro.org>
Date: Thu, 15 Feb 2024 18:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [dubious RFC PATCH] target/mips: Allow I6500 CPU to access CP0
 SAAR registers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240209085347.8446-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240209085347.8446-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/2/24 09:53, Philippe Mathieu-Daudé wrote:
> Desperate attempt to enable access from ITU to SAAR registers, by
> taking missing part of commits c9340491cc ("target-mips: implement
> SAARI/SAAR registers") and c1af807054 ("target-mips: add I6500 core
> configuration") from [*] which were partly committed as 5fb2dcd179
> ("target/mips: Provide R/W access to SAARI and SAAR CP0 registers").
> 
> [*] https://github.com/MIPS/qemu/commit/c9340491cc.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I can not test this. We don't test the I6500 anyway. Besides this
> CPU lacks DSPRAM support which was never merged, see:
> https://lore.kernel.org/qemu-devel/1566216496-17375-2-git-send-email-aleksandar.markovic@rt-rk.com/
> and:
> https://github.com/MIPS/qemu/commit/a4c1477c84#diff-5362bb61a4a73490270458b19e452bac9b3b907f4efd59ece6494ec19d033a81
> so I doubt it is really useful in its current incomplete state.
> ---
>   target/mips/cpu.c           | 1 +
>   target/mips/tcg/translate.c | 1 +
>   target/mips/cpu-defs.c.inc  | 1 +
>   3 files changed, 3 insertions(+)

Patch discarded in favor of:
https://lore.kernel.org/qemu-devel/20240209090513.9401-1-philmd@linaro.org/

