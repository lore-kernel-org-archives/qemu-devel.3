Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605A2C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhN4-0003Sn-V4; Tue, 18 Mar 2025 20:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMg-0003BV-Gd
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:33:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMe-0003mJ-Og
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:32:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22349bb8605so139858275ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344375; x=1742949175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFS51koD2mHTvDb51LXYMlYbu6dRr7StWkhvsQrPRQQ=;
 b=x6QuOejAGO5RhpZ2b355fmowY45r6XgQ+VfPCoh9LPDOEB78V+DCeE6KFp8fXFgAvk
 GGXdEQCnrD36gIEBzG5UJcywojCq+IUTS/MLenGvxpmrmmorsKHGhrQ48/m0sw1pxxrU
 zUddOQPczr0b9ys1AeXm84eZu7x/8RFAmLWORH8YKS7Q6MY7u3U41wUstCsrdVlx4lpy
 LQzgbgJ2Hik+RdZ6TZ/CSK493UwPmiBs+IcOD4ggqhcWCtJfeG+CsNmD/Q27smR7Ll4k
 l12aySKzA3TBaIkfVJQP/aseLLjQiQUHB0xCRU6PPpOkNoSDOc4mf2Lcgrt5kANOS52R
 U7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344375; x=1742949175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFS51koD2mHTvDb51LXYMlYbu6dRr7StWkhvsQrPRQQ=;
 b=RyhfTKouSM/ZmapEYJJgTIsOKc7Zf4ZqnZtL/Y+pKw3/JGoLfxbhutHPs/uTdBCrnI
 Q3N8q6mMZ7FrH3HWNZ7f3jHRPqs5drUf+MjSrSfP9D6sCRQKMPOnmmvSDfdeRXBJ7WqA
 rug5dt+r1JiuETlZZXPwLj6rI7b+2wH279PeH2sFOdyCsHNTB99U4Ks38Eiv49wTm1/a
 gJfLwi7U4lK4FhI36Qx/ZodQTpJFrdA729Gry0EkeKRdsTejfRGDCOF9hFdxfbsgy7+A
 AtRpYEYORGDCV8tjlvoXj+sa4ae9bWpRwGj4s7piihjsmnvwik4HTTcC7AbPxwtyKDrU
 W5PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJH2PZEeru8wkitaQFn8slD1MPe5z9TDWFbCNINEoOGQjJldiS8utzTggkGDwZnjm05PWbTm3p8q/D@nongnu.org
X-Gm-Message-State: AOJu0YyTMlomiWAkieUMZajV0YTp9wv0Xkci+8viq/GnuoOP+N0KAQMI
 /9MjBVOZZq7huzlar37o08gL+SuwImO2iBddUpr3QHKLG6XljdmG23AJoZkqxI8=
X-Gm-Gg: ASbGnctq891udK3669H2GjHOlm1vFsM6GimuC9AapMXgXjPCBjEonCOXRSNzl0q2z6x
 JIsrf+5/Nd3qweJv+WKVxkpyaa3Kh0vtbVljGIYeHcvNFU2eWXDbVMajXrCm5EMW0+RXB60HcKc
 C5kJWWOeWWNLhraV+b2hd9EZOPvNFFQU7NPSVa2fJznYu3dp4QZpFPfofd1jhdZcOqv6YTrzc7C
 TdleqznuZbPM6iuziFHffP7oxoR7Vq2fUnGgPVRJqCOvIOJuJTX5aGMTAjLfPZ/l0Xek0jNRdVL
 ux5FPtvM7E5V7bxI59lM7N5EqhtYT2UUx1VfZPvS06s1SxyPs0fGuvoY6+VgE9tke/LG
X-Google-Smtp-Source: AGHT+IHTHe44AvXzw11mCmLziPibTsxi5wlrn82Dpq8yiLgsot6n2JDqA3/liRF9tYtriaqBqtSwmA==
X-Received: by 2002:a05:6a00:4b56:b0:736:7a00:e522 with SMTP id
 d2e1a72fcca58-7376d5f182emr1025326b3a.2.1742344375148; 
 Tue, 18 Mar 2025 17:32:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167dfa2sm10632279b3a.107.2025.03.18.17.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:32:54 -0700 (PDT)
Message-ID: <4ba2e1c1-b4ed-4e24-9a5a-a881b24c3078@linaro.org>
Date: Tue, 18 Mar 2025 17:32:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/42] plugins: Move api.c, core.c to libuser_ss,
 libsystem_ss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> Headers used by these files require CONFIG_USER_ONLY.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   plugins/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 3be8245a69..5383c7b88b 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -61,5 +61,8 @@ endif
>   user_ss.add(files('user.c', 'api-user.c'))
>   system_ss.add(files('system.c', 'api-system.c'))
>   
> -common_ss.add(files('loader.c', 'api.c', 'core.c'))
> +libuser_ss.add(files('api.c', 'core.c'))
> +libsystem_ss.add(files('api.c', 'core.c'))
> +
> +common_ss.add(files('loader.c'))
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


