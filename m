Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA3C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 18:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMA4g-0006r6-EE; Mon, 02 Jun 2025 14:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMA4d-0006qW-Kj
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:39:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMA4a-0004jJ-BO
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 14:39:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b200047a6a5so4755494a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748889585; x=1749494385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=avIwfDFHWJSxmgv/nZT8jY0ikwd0WAxvHXwz5MZ28zE=;
 b=y5Zrurg9elC+24asmnjlosBJx4DZt9hBCZVIYDEiV4PLEgvy+ZoNj0INaMtw8UGnTF
 Qe50Ei5TRfLaYflNDKhaqjVzUjT/u6PPVgqv1vw1wfjFHLbBIn4ISuLpawg2kSTFo4gz
 IGNILgBEOMKu56fjUA369pDXAOXBwu2fUg8LeOusaT1ha0b6sxnfEhCJRnTQ1u41PBPD
 4BivPaVVSqW+pfowou6Wlh9jH+xU0loyPaCj36fgSj2tB7y0TAYVpNOf042bRvARICU0
 /72UYG0Wwxj9X6nkBv1fuWq5tlNVjxwJ30xJ3v7qCoJDkiwNf+iLp25PIXsqYmLuiSsA
 jQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748889585; x=1749494385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avIwfDFHWJSxmgv/nZT8jY0ikwd0WAxvHXwz5MZ28zE=;
 b=qgwBq8AzpcwReJ/lqzBIM06PPMOs9FvZMI7IlJsXIMMn9rxUz0aqUfFH6iKP5HQJB3
 aX5EqzrlU8Hct2Z/O2rk6tj0VR3jtxxGvx/oq9pDQ8c8JGV8Zv4SZKhnCLBJojtpR2vy
 VVgphgeLed9gLiUlQDdTwFTI7yNbWdwpgouZg944gv0wiaUnpVC6gmbEb9FsFDxTmIKc
 xISzevht3qQ6cgk0g/gUI1+4ZMoJF2PAby85j/4WH9f2y+Q40usPoMXxGWq25etn6i16
 bzHomF47YiOMq7fxC3VGMww4qeQiqZzqGfcmSZVsYn0jukgb45StOW5Uhvqix7Dp4xzp
 MEmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPsmWZslRJh5uFdOB+9y/8wk5fC1ma/mHSYlO6anqoROkpPdNM6NODEISQUBNrEOGyZHCPUStbrsqx@nongnu.org
X-Gm-Message-State: AOJu0YyxumLyo4pz/ixlqIfTzH+qSMz7X8FNtkKPHNB6xJ59WXciGv2/
 0knorOw/W9ebVJAgrWhOgiRtBCXj7v9ReIq5FnyHvW+I0as1KcMbdS3hhisOFdjuIZI=
X-Gm-Gg: ASbGncsacy9ZA+T6obTSAMu1mgp58mVhn7xnPQNmcLynzen3BYAxzj8B/62RVn3US7C
 e588JJlSgZB2+pkdeGKfKqxyqJvIl4gL4sa7K9oc2AamjsRfuJxJgnsqRFRu0JT8ViELoOSrLBa
 zjZWZPHL7o2nkIoTaQJ6zobYmdy0dmuCi0Uae9/VDGQXT9Bboj30xwnPUYgpiMdRyKSXgZpXfA3
 L+artB5wcCxPKac3IWMijGWMVZAiX1P8IlD8fBTgQXOXz41KkcJCdBEkr9uRXzpe/BdC/9miNcI
 8R228kmivokmNs5mPqW2xWL//PlD7zS0TVCVIPO2ii+cPP2Tic56x8VePD3aZbM9cs1rJ7ySAeI
 =
X-Google-Smtp-Source: AGHT+IGrBO8rxR4cW5YwZlMTQeGM8GQhIPqcBGLcaYZH0BrgHfs8jafqpJwfloa5XoHeZ76gA5yGmA==
X-Received: by 2002:a17:90b:1b44:b0:310:c8ec:4192 with SMTP id
 98e67ed59e1d1-312e44cbe7dmr539023a91.10.1748889583472; 
 Mon, 02 Jun 2025 11:39:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-312e522d4dfsm48452a91.1.2025.06.02.11.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 11:39:43 -0700 (PDT)
Message-ID: <b7e988ef-82da-43bc-8c57-3b49b3bf9529@linaro.org>
Date: Mon, 2 Jun 2025 11:39:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-3-pbonzini@redhat.com>
 <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Hi Cédric,

On 6/2/25 6:59 AM, Cédric Le Goater wrote:
> Hello Pierrick,
> 
> On 5/30/25 09:11, Paolo Bonzini wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Link: https://lore.kernel.org/r/20250521223414.248276-3-pierrick.bouvier@linaro.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>    hw/arm/meson.build | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index 5098795f61d..d90be8f4c94 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
>>    arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
>>    arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
>>    arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
>> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
>> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
>>    arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
>>    arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
>>    arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
>> @@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>    arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>    arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>>    
>> -arm_common_ss.add(fdt, files('boot.c'))
>> +arm_common_ss.add(files('boot.c'))
>>    
>>    hw_arch += {'arm': arm_ss}
>>    hw_common_arch += {'arm': arm_common_ss}
> 
> This commit breaks building these files on Windows:
> 
>       hw/arm/{boot.c,vexpress.c,imx8mp-evk.c,raspi4b.c}
> 
> Error is :
> 
>       fatal error: libfdt.h: No such file or directory
> 
> Thanks,
> 

Is libfdt available in your windows environment? If yes, is it in a non 
standard path?
On my side, it built successfully, so I first need to reproduce this.

Thanks,
Pierrick

