Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C565C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0QvA-0000Cp-A7; Thu, 03 Apr 2025 16:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Qv9-0000CR-78
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:12:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Qv7-0001DC-Ff
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:12:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so12898415e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743711131; x=1744315931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=laMCqX+EXB5z2rpnk/b0GZ4oiQrnw6iJxhPH7Wa8cJ8=;
 b=P724panNWiT1NjZfgD7Fu10/HdH9i+p4szqk0DBDkjt91n6a/YShtKd2PLWezpy5D2
 bKOp0ybjr1bLWnw8JSM3GzmGpG7hAWdz+tynzrYMcUZGIYX/eBr0Aa2oC6mICC0gDE4g
 vNmfFyl/s/gkVuT6aCrxS0mgQXKqnqjPySKe1mCi5LB5t/ObdIeIW4ub4EfAFGCVixuH
 xKhd3xHdiBp93oZqBykb97Bue+AwiDIbP51olQPf1G8pBJGGT50JmEbK1l2iqdx3pGys
 /spzdvDKXx//NBjW8Du/4pXHbrjPuyAW+bnIUImQjM460E9cXQJMe6vaPxGTsjBRkIQc
 0gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743711131; x=1744315931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=laMCqX+EXB5z2rpnk/b0GZ4oiQrnw6iJxhPH7Wa8cJ8=;
 b=rRINzhAMKNFGll/IzdHzwrB1SV4BXFF01S6X4fFzUL34WE2rPFhAsFuhWsgxizAAqt
 AYnu4EakPraYmeZEqeAb1gPYoAvl6c1kI8PjENHSrnBhtvlQf+YZBwkXTNLRwKfRUDXc
 QUPbwSDoBvQhKyzhLCYO6H40UBJOL2sY9xlTBzB8sD6F+jxOPvZ67nADEmKKcQjSPhQT
 N6c2wxfU4tAykyNx4C745KrhwjzXy5FhARhhA802W6iP9+nIlgwGhOt3JBXKLvdDzkRE
 LO2jaCMnJi4DJlFVqwC/qhP0e/aM5NnUekeK7GZgdRWAwHdKDmZ3UF7uefXZEwkeflUY
 SAXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM9vbw0U7QAaQuZDzWlk++0PbKopWx4c6jchGbi7TCKMPjjHGPaE7eCUmaTc3WCMqlQgJRjSoE7nfn@nongnu.org
X-Gm-Message-State: AOJu0Yy3uVsUwXWa45amxRW1cu44Rgzyy+Fi4qKPG+l0vDqASrrsY5sc
 VEq+H43JJ0UMzPG114iNysL8N4D3wa05w3/5Zg8hEZQl6qboQA7pcFk9Yw+oEag=
X-Gm-Gg: ASbGncu0HFelz2JFThud1BG71DHmOa1aYqqsPN0NiqQrHOOA8lRNMpH4qwyb7fOOaOm
 yNsgVfyOiGGt7vDjVB0h0x0GvPeOS20InV3Kj5kD3BccVxUl7vaJbdUMKPHkKh6O0YUQC7xSkYD
 Cb3vNR99afHldHojx+B27Rc4e5f5MSZyHiUQ2SzPWRfZzPr44xklkvBNNGAOR+qVc8hVt3YKyBn
 3LdGKpW2qU0fbOUPkaqZ113f4+RznOiDaOEvNRFwroRMb9kkR7ban4j69/ZOFRNoK1KD/wQRsFV
 KeImgZdvwZPVut+gSfM47W2pEUsIZVJMM424l6C9kVB/pQkc3acjmWZMaZee0aaVVf/ijwBn+ss
 HNDjgjdwOKYPigP2TRQ==
X-Google-Smtp-Source: AGHT+IFvRF/YE8zcTl54isoBV9V3vOprW2d5OHPYusU3ZZVAm43uXdDMKW1yFNalJAzWFpTQbTOsfw==
X-Received: by 2002:a05:600c:5246:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43ed0db363bmr978585e9.29.1743711130967; 
 Thu, 03 Apr 2025 13:12:10 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0d06sm30804185e9.35.2025.04.03.13.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 13:12:10 -0700 (PDT)
Message-ID: <4ec2d770-67e6-4d07-baa4-db056c47b26a@linaro.org>
Date: Thu, 3 Apr 2025 22:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: hvf: fix lflags_to_rflags
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>, qemu-stable@nongnu.org
References: <20250403194752.103264-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250403194752.103264-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/4/25 21:47, Paolo Bonzini wrote:
> Clear the flags before adding in the ones computed from lflags.
> 
> Cc: Wei Liu <liuwe@linux.microsoft.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/hvf/x86_flags.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
> index 32772c359e9..31d76c067bf 100644
> --- a/target/i386/hvf/x86_flags.c
> +++ b/target/i386/hvf/x86_flags.c
> @@ -284,6 +284,7 @@ void set_SF(CPUX86State *env, bool val)
>   
>   void lflags_to_rflags(CPUX86State *env)
>   {
> +    env->eflags &= ~(CC_C|CC_P|CC_A|CC_P|CC_Z|CC_S|CC_O);

CC_P is twice, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       env->eflags |= get_CF(env) ? CC_C : 0;
>       env->eflags |= get_PF(env) ? CC_P : 0;
>       env->eflags |= get_AF(env) ? CC_A : 0;


