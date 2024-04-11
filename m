Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB0BCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupOS-00017S-Dg; Thu, 11 Apr 2024 04:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupOQ-000174-KV
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:02:46 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupOO-00031p-WA
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:02:46 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c60019eecaso1134489b6e.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712822563; x=1713427363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZjSSGpOHlSf6np+XiIunTqGmsycHzgHyHURl/FpD9x8=;
 b=oovuxFYnZ9dMCeC3Pq9kr7rcg4WQNOU43gk73pwhThvf9IfPEjS3qzll26rxtuQ0G1
 FbA13RsqlUWpiEGOKrlD0BhsXAkghEbVUqMdYPP+hHjk9NO2FWs7aNFP1Gp6lVHhlj2Q
 9HNJjilhrG7bki3FXn51FZpMI8K6iE38wSrJjRw64czojJ0OjbZ2OrnNJo1W3jrvxd7y
 01lR+e2Ti9OCx49doB9o7s9GI+104AA+h7vnDQJ6hlB6jq5W3bKaDemTdENI+7dCz5if
 chdmMVw+QK8PNWCVLytWQPM5kTho0OXM0ZFXhq+TKJdgb1RtD2s7zFFam6eYFzhun/8E
 WFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712822563; x=1713427363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjSSGpOHlSf6np+XiIunTqGmsycHzgHyHURl/FpD9x8=;
 b=YxI//RTt2Phff0YwNm+X+seUbAbLYYq//tmoZPz193U9ZPimPwkhhX2wLImD9FGG7X
 P4sDRUA2LWqhETcpi2kLDowtMswbhTGOXoZ9MKRxZN4rbIIDHBpsY+RbANQ34ECFUnYv
 QA5vE19GJiONcFqe4QwsHVT5BcVFLcYLg7RjYb2McLZQB6iKdOlXYYuuR3eBmlaGfE0M
 oSeOFfs36JNOtjhkPEzhKL2EmcklpwSViMTNqhdk+BCnfbGwX3zq8Td3XQfVkrp6UmMo
 KjaEtMjnze5jf4sQ/wUYBpL1e9E1QNb0dD9lKuB42oVonlKQDrmKacCpvtKv+14QXgVj
 6SBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy77Kb9Yu+v3urE2RLQY78GYrI0C0bMCtmlZkk5lDacA/hcYduIoltrcrCPaKHbeLj5GdZB7ejOFDixWLanO1tGV+SLUA=
X-Gm-Message-State: AOJu0Yy7U+DX8DBL2fSJ+zumodXDyx3Gl3jaIDxw1iHwTLL756BsqKGs
 HNXfSHUHJViVkHh2z6CbHNceHab3YsiwP1md3X5RicIxCQbEW7+miJb0es0jdR8DX1yZY86S2H7
 2
X-Google-Smtp-Source: AGHT+IExrVKSDCGBBzpTHzWggDwSz+E3J+qMbzg6BP7FDtA3k6dHV52TgpZpeFCoGvh/YGQVlXH8Gg==
X-Received: by 2002:a05:6871:8783:b0:22a:9d77:f654 with SMTP id
 td3-20020a056871878300b0022a9d77f654mr6002496oab.31.1712822563470; 
 Thu, 11 Apr 2024 01:02:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m23-20020aa78a17000000b006ecfd2ad4ddsm746656pfa.146.2024.04.11.01.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:02:43 -0700 (PDT)
Message-ID: <2b50017e-5e7a-4c13-b54a-9db9c79d3ade@linaro.org>
Date: Thu, 11 Apr 2024 01:02:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 14/19] target/i386: move BSWAP to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-15-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |  4 +++-
>   target/i386/tcg/decode-new.c.inc |  9 +++++++++
>   target/i386/tcg/emit.c.inc       | 11 +++++++++++
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index f3c437aee88..a1e6e8ec7d9 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -3209,7 +3209,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>   #ifndef CONFIG_USER_ONLY
>           use_new &= b <= limit;
>   #endif
> -        if (use_new && (b >= 0x138 && b <= 0x19f)) {
> +        if (use_new &&
> +	    ((b >= 0x138 && b <= 0x19f) ||
> +             (b >= 0x1c8 && b <= 0x1cf))) {

Tab.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

