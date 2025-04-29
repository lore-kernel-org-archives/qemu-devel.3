Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25233C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sF8-0005Cl-PF; Tue, 29 Apr 2025 17:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sF6-0005A6-W4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:11:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sF4-0004q4-DI
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:11:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso79218745ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745961109; x=1746565909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+vBxbVVL0iKGPcc8hbFY6P4N8NFA8CDBAgRz2WbbHH0=;
 b=jTwBvOKNycWgEunZw92IgYg/08HgVvhJF5qzW31fEwtHgJp5b39n1PF5VLOl1TRSr3
 d+sbD/xecdk2sas4LoVtQT/qe38bFudyQATGix76bIJ8tmOZoUpcNgpoSYnyVrpMOgyU
 58pOVaYovzLCGP3w+Ud1YRYeSuXPF/Ahw7lsfkbAp9Y90LvjErCfaEemzFq1TxMuMKRc
 TDfGFG8iVIQxAahGXPw8XNdLnWr6zpQzT8hvkhVB2RTfQp7O3UYLt1iIQRfg3N+sVyDX
 QD4oLJ6/WHlwb5i46WbYcM1TuR+qE6vgQXhvyecuRY2YoIPP15upko9LGIp7mBdFp4wI
 OGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745961109; x=1746565909;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+vBxbVVL0iKGPcc8hbFY6P4N8NFA8CDBAgRz2WbbHH0=;
 b=eOcFSV4LTmpJwJoIUxt6ExXizSIXassoXxgQmR1H+Ci9ztPiAF5fJlnE9n1Zw7rotY
 bJqHtV7KjXuKvOW7j0OD5iuHhzHQs13xfznPqZst2yieprabwlfhYxq6MeKXNqLEAoSd
 JFDNPVvKQ5TJ3eLU+MOYQCq7AFj5lIGWcWKVFCEW+IkXDomWWgH4g6oAexKd5T2GyMYS
 GImG2UCbFlQfpJLkjV8nflerdMZAfUiFSugwfiGZYQZLOyrNFKEA6aa0QquC7+6SxfpK
 VriiERhMF/dg5yHevyTMk4UhifRCoGbXKEyHGZMPdyZGyfwxcQ6frvy+5YM60g84rRQ0
 1RbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUwx4wA0txlbqTR5H3hmzYU0m1FBGZZTJKNGMIfh4A3v+g9Fi6afaJvMwf8kCYrWmsAQtnZFcddAPc@nongnu.org
X-Gm-Message-State: AOJu0YwgNGqlbUmcMctpVWFVLBLiVi5MoOd8PwzQsXlieWvNJFbM8d0e
 vQ2BgDXWS+I1ZRZ+KPzkWHS4HDPxZBA3+4Q+9HosdROVh+hGfo6YkJikS1ADlJk=
X-Gm-Gg: ASbGncsR7J7URveUQPvl5FCA7SBoMmmfwqFb+Jzsmty/r24yUzKcUJHg0bp22tEMlsv
 cKOKsxPND4D/SvhjwdOcGvFhWjHvFcQvkQjLp5t0j0UJs/wKXPCRmvi5XIwhGbjPJoPyWjdTMZt
 7EX2/NijztXbRE2ePBR9yehc2q2sITO+ANYH7RUw2478bKSYFLBisId8jQHpXCo6YvJp4ZSGK34
 A1f00zSwuj9XySiNRFSpR3NOhvFwrKt1/5wgBAO5hP61Phe+UqjYRtQY4WxrmP/LkGUPg3f7g9N
 3ltziFqd4wBbTtIJm2GbkhQ1105MBsNBmS7tbDi+tk/uJOx/EGW2UQ==
X-Google-Smtp-Source: AGHT+IEFmAHBbO2wKdGpPUmlZ7vzYIs7H2Tc0jXj+u7tbNw7KX5eQru8f502ZH9woOgYHKduUx5NSg==
X-Received: by 2002:a17:903:8cd:b0:223:6657:5003 with SMTP id
 d9443c01a7336-22df35700b2mr14256935ad.32.1745961108795; 
 Tue, 29 Apr 2025 14:11:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5102d31sm107976365ad.198.2025.04.29.14.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 14:11:48 -0700 (PDT)
Message-ID: <12579394-7bce-4b9e-ba66-00ce1dff43d1@linaro.org>
Date: Tue, 29 Apr 2025 14:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] meson: add common libs for target and target_system
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-4-pierrick.bouvier@linaro.org>
 <fd70e4f4-29b8-4027-a70c-747729172ce5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fd70e4f4-29b8-4027-a70c-747729172ce5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/29/25 11:01 AM, Philippe Mathieu-Daudé wrote:
> Hi Pierrick,
> 
> On 29/4/25 07:00, Pierrick Bouvier wrote:
>> Following what we did for hw/, we need target specific common libraries
>> for target. We need 2 different libraries:
>> - code common to a base architecture
>> - system code common to a base architecture
>>
>> For user code, it can stay compiled per target for now.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
>>    1 file changed, 61 insertions(+), 17 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 68d36ac140f..7b2cf3cd7d1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3684,6 +3684,8 @@ target_arch = {}
>>    target_system_arch = {}
>>    target_user_arch = {}
>>    hw_common_arch = {}
>> +target_common_arch = {}
>> +target_common_system_arch = {}
>>    
>>    # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>>    # that is filled in by qapi/.
>> @@ -4087,29 +4089,59 @@ common_all = static_library('common',
>>    
>>    # construct common libraries per base architecture
>>    hw_common_arch_libs = {}
>> +target_common_arch_libs = {}
>> +target_common_system_arch_libs = {}
>>    foreach target : target_dirs
>>      config_target = config_target_mak[target]
>>      target_base_arch = config_target['TARGET_BASE_ARCH']
>> +  target_inc = [include_directories('target' / target_base_arch)]
>> +  inc = [common_user_inc + target_inc]
>>    
>> -  # check if already generated
>> -  if target_base_arch in hw_common_arch_libs
>> -    continue
>> -  endif
>> +  # prevent common code to access cpu compile time definition,
>> +  # but still allow access to cpu.h
>> +  target_c_args = ['-DCPU_DEFS_H']
>> +  target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
>>    
>>      if target_base_arch in hw_common_arch
>> -    target_inc = [include_directories('target' / target_base_arch)]
>> -    src = hw_common_arch[target_base_arch]
>> -    lib = static_library(
>> -      'hw_' + target_base_arch,
>> -      build_by_default: false,
>> -      sources: src.all_sources() + genh,
>> -      include_directories: common_user_inc + target_inc,
>> -      implicit_include_directories: false,
>> -      # prevent common code to access cpu compile time
>> -      # definition, but still allow access to cpu.h
>> -      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
>> -      dependencies: src.all_dependencies())
>> -    hw_common_arch_libs += {target_base_arch: lib}
>> +    if target_base_arch not in hw_common_arch_libs
>> +      src = hw_common_arch[target_base_arch]
>> +      lib = static_library(
>> +        'hw_' + target_base_arch,
>> +        build_by_default: false,
>> +        sources: src.all_sources() + genh,
>> +        include_directories: inc,
>> +        c_args: target_system_c_args,
>> +        dependencies: src.all_dependencies())
>> +      hw_common_arch_libs += {target_base_arch: lib}
>> +    endif
>> +  endif
>> +
>> +  if target_base_arch in target_common_arch
>> +    if target_base_arch not in target_common_arch_libs
>> +      src = target_common_arch[target_base_arch]
>> +      lib = static_library(
>> +        'target_' + target_base_arch,
>> +        build_by_default: false,
>> +        sources: src.all_sources() + genh,
>> +        include_directories: inc,
>> +        c_args: target_c_args,
>> +        dependencies: src.all_dependencies())
>> +      target_common_arch_libs += {target_base_arch: lib}
>> +    endif
>> +  endif
>> +
>> +  if target_base_arch in target_common_system_arch
>> +    if target_base_arch not in target_common_system_arch_libs
>> +      src = target_common_system_arch[target_base_arch]
>> +      lib = static_library(
>> +        'target_system_' + target_base_arch,
>> +        build_by_default: false,
>> +        sources: src.all_sources() + genh,
>> +        include_directories: inc,
>> +        c_args: target_system_c_args,
>> +        dependencies: src.all_dependencies())
>> +      target_common_system_arch_libs += {target_base_arch: lib}
>> +    endif
>>      endif
>>    endforeach
>>    
>> @@ -4282,12 +4314,24 @@ foreach target : target_dirs
>>      target_common = common_ss.apply(config_target, strict: false)
>>      objects = [common_all.extract_objects(target_common.sources())]
>>      arch_deps += target_common.dependencies()
>> +  if target_base_arch in target_common_arch_libs
>> +    src = target_common_arch[target_base_arch].apply(config_target, strict: false)
>> +    lib = target_common_arch_libs[target_base_arch]
>> +    objects += lib.extract_objects(src.sources())
>> +    arch_deps += src.dependencies()
>> +  endif
>>      if target_type == 'system' and target_base_arch in hw_common_arch_libs
>>        src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
>>        lib = hw_common_arch_libs[target_base_arch]
>>        objects += lib.extract_objects(src.sources())
>>        arch_deps += src.dependencies()
>>      endif
>> +  if target_type == 'system' and target_base_arch in target_common_system_arch_libs
>> +    src = target_common_system_arch[target_base_arch].apply(config_target, strict: false)
>> +    lib = target_common_system_arch_libs[target_base_arch]
>> +    objects += lib.extract_objects(src.sources())
>> +    arch_deps += src.dependencies()
>> +  endif
>>    
>>      target_specific = specific_ss.apply(config_target, strict: false)
>>      arch_srcs += target_specific.sources()
> 
> Somehow related to this patch, when converting from target_system_arch
> to target_common_system_arch, emptying it, I get:
> 
> ../../meson.build:4237:27: ERROR: Key microblaze is not in the dictionary.
> 
> 4235   if target.endswith('-softmmu')
> 4236     target_type='system'
> 4237     t = target_system_arch[target_base_arch].apply(config_target,
> strict: false)
>

Patch 12 introduces an empty arm_common_ss and it does not seem to be a 
problem.
Feel free to share your meson.build if there is a problem.

