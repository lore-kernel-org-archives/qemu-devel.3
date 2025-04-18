Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DEBC369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 11:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jmQ-0001Vh-HN; Fri, 18 Apr 2025 07:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5jmN-0001Uu-U3
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:21:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5jmJ-0004Gx-R0
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:21:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so1111825f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744975259; x=1745580059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0fyHi4MxlMblE1+LGOB6BAVM0lFHznNuqWxWOGClhA=;
 b=GHP63cpbVElLchaAvmUXOy80tZVLKgNmo1GKwtFDfQXHea1wAYj5PZ0C9BCWY9pP7L
 S8UeJIeDnJunumzrGgI8T2fUic3Gq8J+8CxeLpgi0oIoQ2u/2ZxOlSNGZHtTN604phOn
 W8yY1pDoCAkQtB2oxB5siONXkovz6xUWXvMi78P9kND/o4McPPWWlogC0rpdu9QJUDwQ
 jKpw6GrrS1rGW1MX+ZpffKhbv7jl0BJH+7E3KGTRKKVsiJaDuasrEMBCbuOx54cco1fu
 jtajAAKFftBT+EMnRSW7UMS3ucweVV6x0vF3fCJ0Hyk3f9uOSjGodETiKNasqRbEisq2
 nj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744975259; x=1745580059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0fyHi4MxlMblE1+LGOB6BAVM0lFHznNuqWxWOGClhA=;
 b=XNQvi6z8VeFonbTJQmcUmZV8Xco0S00undsHBwAcT4N98J4qvwVJN8AnblczftMr/u
 646Aj83F0MjQPBThBPpU9gbvNGGY0FSEQVrNbwZNw2Tdgozrf7vMr1Fd90N5573P7euC
 2MLUkxTCDb4ZLtetDL+CmlxlnBILVdLKUUaFTMt6KjTs3w/xK3Qf5dfEFLQOsStlbMlc
 sR6CSo4j4YDmudPir63VKzWB4QfRDfloJaaJFYw+EcLiq28z0+cVoRl+9ZqOIzahQmVc
 qoW10peVdMZCy9G1pCV2yUE02Wx8COUKbIiKagMRXKfdt09eBZvX3Na1lXWzKNrgtOPx
 TI5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU58763gEo0sQNnw+v85RVwcIy3QysHECJB9Xn/l06INpHOc5PLGEwleCCyVHJb4EirNKZHpQ+qycFt@nongnu.org
X-Gm-Message-State: AOJu0YyQk5qqAoprPSZPD22QDONn69kMtBp+lc3tT97p2HedcQkAje8F
 1HX2+CY+O+bg0VTsrC4uUuqxKGXdSisvo3dj3zzBQnocJGVFXOVuUhe2X7lABSU=
X-Gm-Gg: ASbGnctAnrIP6k4uItNWB9MUdHKniUE0SsszRyAuEMyURWMHXZcFNPoV1/Cz2E5qols
 qtdb3Ub25CE3ZSM3J7x/x3f4H20LMiZn3RR+zuPXf96OJ0JL09BCfZHPe5PnsU1qqM2z9ApiAVn
 ytlEsNalu0VBc7saNot3CQDxzQS7BlN5d06KcqvLvAb7PMFKEaRrLk/8t4sNKyLzTOCWwJ2TJIR
 s5nAYFeZ4N7rmaTEnm2rAqrr7kXtcA5YCZVnaY3ozUuFO0cug4oVycZy3VHSQaeaaTt86cIAUsa
 3/gemI3spg4zy52XpYnlE+pdK6dYuA4cEyqwphjGofbcQHWRdt01jhBX83CFXNDI/1F4Incx+Nn
 fKr2Y1b3C
X-Google-Smtp-Source: AGHT+IEXcl6JieJ7CpKZ6MYN9I5XLxbZG+UcMXvt8DlXf/cDyoAlPng0vLpJSFY8O34V6cXrF0nB6Q==
X-Received: by 2002:a05:6000:178d:b0:39c:c64e:cf58 with SMTP id
 ffacd0b85a97d-39efbaf20ccmr1721061f8f.55.1744975259110; 
 Fri, 18 Apr 2025 04:20:59 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4cd0sm2515462f8f.90.2025.04.18.04.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 04:20:58 -0700 (PDT)
Message-ID: <cb64ac38-4ead-4dac-b885-bf107cafa606@linaro.org>
Date: Fri, 18 Apr 2025 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/11] config/target: Implement per-binary
 TargetInfo structure (ARM)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-9-philmd@linaro.org>
 <7bcc10f7-43b5-48f4-8546-3169e2be4fcd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7bcc10f7-43b5-48f4-8546-3169e2be4fcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 18/4/25 06:02, Pierrick Bouvier wrote:
> On 4/17/25 17:50, Philippe Mathieu-Daudé wrote:
>> If a file defining the binary TargetInfo structure is available,
>> link with it. Otherwise keep using the stub. Implement such
>> structure for arm-softmmu.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build                   |  7 ++++++-
>>   configs/targets/arm-softmmu.c | 22 ++++++++++++++++++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>   create mode 100644 configs/targets/arm-softmmu.c
>>
>> diff --git a/meson.build b/meson.build
>> index 168b07b5887..da24cc2ba41 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3809,7 +3809,6 @@ specific_ss.add(files('page-target.c', 'page- 
>> vary-target.c'))
>>   common_ss.add(files('target_info.c'))
>>   system_ss.add(files('target_info-qom.c'))
>> -specific_ss.add(files('target_info-stub.c'))
>>   subdir('backends')
>>   subdir('disas')
>> @@ -4272,6 +4271,12 @@ foreach target : target_dirs
>>       arch_srcs += gdbstub_xml
>>     endif
>> +  target_info_c = meson.project_source_root() / 'configs' / 
>> 'targets' / target + '.c'
>> +  if not fs.exists(target_info_c)
>> +    target_info_c = meson.project_source_root() / 'target_info-stub.c'
>> +  endif
>> +  arch_srcs += target_info_c
>> +
>>     t = target_arch[target_base_arch].apply(config_target, strict: false)
>>     arch_srcs += t.sources()
>>     arch_deps += t.dependencies()
> 
> While this works, it would be better with a dictionary, so it follows 
> the style of existing meson.build.
> 
> As well, two advantages:
> - we can move configs somewhere else in case we decide to split them in 
> every folder later
> - We avoid calling fs.exists for every target, but it should not really 
> change anything to configure step time.
> 
> ---
> 
> diff --git a/meson.build b/meson.build
> index 81afa63853e..7fca3c5c4dc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3228,6 +3228,7 @@ config_devices_mak_list = []
>   config_devices_h = {}
>   config_target_h = {}
>   config_target_mak = {}
> +target_info = {}
> 
>   disassemblers = {
>     'alpha' : ['CONFIG_ALPHA_DIS'],
> @@ -3823,9 +3824,9 @@ specific_ss.add(files('page-target.c', 'page-vary- 
> target.c'))
> 
>   common_ss.add(files('target_info.c'))
>   system_ss.add(files('target_info-qom.c'))
> -specific_ss.add(files('target_info-stub.c'))
> 
>   subdir('backends')
> +subdir('configs/targets')
>   subdir('disas')
>   subdir('migration')
>   subdir('monitor')
> @@ -4286,6 +4287,12 @@ foreach target : target_dirs
>       arch_srcs += gdbstub_xml
>     endif
> 
> +  if target in target_info
> +    arch_srcs += target_info[target]
> +  else
> +    arch_srcs += files('target_info-stub.c')
> +  endif
> +
>     t = target_arch[target_base_arch].apply(config_target, strict: false)
>     arch_srcs += t.sources()
>     arch_deps += t.dependencies()
> 
> diff --git a/configs/targets/meson.build b/configs/targets/meson.build
> new file mode 100644
> index 00000000000..140386e932c
> --- /dev/null
> +++ b/configs/targets/meson.build
> @@ -0,0 +1,3 @@
> +foreach target : ['arm-softmmu', 'aarch64-softmmu']
> +  target_info += {target : files(target + '.c')}
> +endforeach
> 

Thanks for showing the dictionary variant!

