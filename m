Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E7C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 21:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twpEL-0007Ye-6i; Mon, 24 Mar 2025 17:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpEJ-0007Y0-P1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:21:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpEH-0004xx-K6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:21:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2264aefc45dso81744055ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742851264; x=1743456064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8KoheoYm5HA8VcAgE260OGydvMzV1ButV3Mzz5BT064=;
 b=j5P3CvxxNnJ4Kdvzl/tQW3bBIUTeARknnIr6dHCDmTpIkULqBsoctmBSNoU820YYF7
 vkPcPIuMCFJ2SZD0C+6rkNJZGlsav03GAOAwlNgiFofv9fyxA8roGhlpw98aopHCCoQd
 bfHwCjokmA9ole2JW5OWRw/RfbtDlIISbdnGWozYoGsXDLiqv93HjXioJnNUpdcX5GHE
 P3yevxSxNr5SPl6b/HYJf1JMK9CWRyhgguldUh9BWfzdYbxl6nBQ5rPzEqg6IGGpWR5k
 tJaR+Tt8mh+zpecy4AGKX3kIZwPfYtFiNHTlstvm520T9Zi6RD/lNL3Vf260FzXDllbz
 oyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742851264; x=1743456064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KoheoYm5HA8VcAgE260OGydvMzV1ButV3Mzz5BT064=;
 b=NwZItVtOhwiKpvHxDFwJp7bCMUCaSc4l6yctuervOp4PwNWNgXGHVlI8zXMpK/l0Mk
 lNpjSEmJE69TFk5yR33q4hS7EdBK/NWuInYJN/EYgdaALAF3g/6T5ZRcD9tg/a+dyeDv
 1dmtuLxzhM3BkBVefGMGC16YcIOo2wuW858LA633E/lNBhE0YUi12uUEyDONZJNfPijg
 HqYUvKOP4pIqf1wVEkR+nPhkd2+h/yFGE3ISEk8I6YlOmVf51ts8uiSPad1mKb/imVge
 YOhruXqc/yMv1Mkuktbwwg7lzO2h2XWaT5zes15sM+M2xXhG3pXZgML+BCB/wbgI/971
 H8Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcZNcVBMvhdLCIfTphP5nP5m/gFvHWwe8+Db42GVIBUC4RrvJpN6J1uKzhUgToPn/IKX4vZN7bTULS@nongnu.org
X-Gm-Message-State: AOJu0YwTauA4ptll9n5vgEkRJvZe1+8KB15Qz+0RUnUqIdb7b2tN15Tq
 gegfSiUj7fKnBxegXWp0fm4BjJHpYzDv2oFjqq8qtdcIkrNqoR2IFmgxHOEYmBM=
X-Gm-Gg: ASbGnctgJwdW5+oYAYlRnFW2D62zNVFIWevrZ3b7i5WLxC2azc6VPHAPXMReEGkSOJy
 jcHUzPMsf9swBGtKl/pyqO1Har7QaW0yr9nLfa6rfoyVctqZkNA31MjVbglvU7RLDz9X1Rbwh/R
 me6rEpwfaLqIBjZUuBWhwIg1GjME3Umc96hSP9MjIkVWRdRXEJ0+Xk/vxesLbUtTY8gQTuLMqml
 kyH/l9JChUDttZimB1dTMBDVQ2JSpyyV3Fe8C5S/dxp97fczHd2a+V3Og3IMg3KZrCU4vFFzr7+
 izTGGG1fpCxysA5lF6dIXLoZw93+lDPmQ6UfYqf9eURcqqmZi50HLrf4dQ==
X-Google-Smtp-Source: AGHT+IEf4rgByTR4aUAXXQim/ntEXH4+OOahy31CtY4lDoOHPzpvMBWbyGzjrmwJx01AD+FrvarBrQ==
X-Received: by 2002:a17:902:f648:b0:224:fa0:36da with SMTP id
 d9443c01a7336-22780c7c06fmr193333595ad.18.1742851263523; 
 Mon, 24 Mar 2025 14:21:03 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3c0sm8504961b3a.89.2025.03.24.14.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 14:21:03 -0700 (PDT)
Message-ID: <231d6e5a-f8c8-4b16-a455-44e9bb8dd011@linaro.org>
Date: Mon, 24 Mar 2025 14:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/30] meson: add common hw files
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-25-pierrick.bouvier@linaro.org>
 <2650a767-a829-4544-99f9-42e23b131da3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2650a767-a829-4544-99f9-42e23b131da3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/23/25 12:58, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> Those files will be compiled once per base architecture ("arm" in this
>> case), instead of being compiled for every variant/bitness of
>> architecture.
>>
>> We make sure to not include target cpu definitions (exec/cpu-defs.h) by
>> defining header guard directly. This way, a given compilation unit can
>> access a specific cpu definition, but not access to compile time defines
>> associated.
>>
>> Previous commits took care to clean up some headers to not rely on
>> cpu-defs.h content.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build | 37 ++++++++++++++++++++++++++++++++++++-
>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index c21974020dd..994d3e5d536 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3691,6 +3691,7 @@ hw_arch = {}
>>    target_arch = {}
>>    target_system_arch = {}
>>    target_user_arch = {}
>> +hw_common_arch = {}
>>    
>>    # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>>    # that is filled in by qapi/.
>> @@ -4089,6 +4090,34 @@ common_all = static_library('common',
>>                                implicit_include_directories: false,
>>                                dependencies: common_ss.all_dependencies())
>>    
>> +# construct common libraries per base architecture
>> +hw_common_arch_libs = {}
>> +foreach target : target_dirs
>> +  config_target = config_target_mak[target]
>> +  target_base_arch = config_target['TARGET_BASE_ARCH']
>> +
>> +  # check if already generated
>> +  if target_base_arch in hw_common_arch_libs
>> +    continue
>> +  endif
>> +
>> +  if target_base_arch in hw_common_arch
>> +    target_inc = [include_directories('target' / target_base_arch)]
>> +    src = hw_common_arch[target_base_arch]
>> +    lib = static_library(
>> +      'hw_' + target_base_arch,
>> +      build_by_default: false,
>> +      sources: src.all_sources() + genh,
>> +      include_directories: common_user_inc + target_inc,
>> +      implicit_include_directories: false,
>> +      # prevent common code to access cpu compile time
>> +      # definition, but still allow access to cpu.h
>> +      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
> 
> Oof.  This really seems like a hack, but it does work,
> and I'm not sure what else to suggest.
> 

Yes, it's the best (least-worst in reality) solution I found.

Initially I simply tried to add them to libsystem.
However, it has some problems:
- Impossible to link arch files only for concerned targets (or you need 
to add when: [TARGET_X] everywhere, which is not convenient).
- They need specific flags (most notably header guard -DCPU_DEFS_H, to 
ensure we don't rely on cpu compile time defines), which is only 
achievable through static lib hack already used in our build system. So 
another library needs to be declared.

> All the rest of the meson-foo looks ok, but a second eye couldn't hurt.
> 

If someone else has a better idea achieving the same result (maybe 
Paolo?), I would be happy to implement it.

> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


