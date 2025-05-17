Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E431C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 19:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNIj-0003iZ-IQ; Sat, 17 May 2025 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNIh-0003i7-QK
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:34:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNIg-0004qU-5C
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:34:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-231fc83a33aso8498375ad.0
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747510464; x=1748115264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Deut954jNhBmbdvzdKZ7KYt6VhpP4eoRH02IiNoi0jo=;
 b=y/xOUnNHmUmDxYYlNFJ1t+LWIdjp4WA+ACmdTrASRyVAeXBNNz9YrdIX91Rix9ARqk
 05V4t6YWOEy/oifOYsMcz6/IYDrafLpA9BdDnnvOS08/8r7M5Zv1cDLKOsoZvKRLFigq
 quG1qThkmab+QXvTQrf3KF6BDnZkkXUOgAGqzMxGHgOt9+9C12/CXsxQIJ+JWGYRuiEm
 WBHvkvYpS81Nxa8zmPXm/iAHt02OiJGD/0ItGry9UUUXcCbIpL6PzAoaecEolTcCCINQ
 VXkyXJUV9IurHSt27xK2xeYPILt0ChslTpdMv+8+35VbWebR8uPV+gjYkbMRefVwQW+7
 IMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747510464; x=1748115264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Deut954jNhBmbdvzdKZ7KYt6VhpP4eoRH02IiNoi0jo=;
 b=rPOj4s3nMSNNKLVNO/ouDejOCWfXGTusgTPbtzW7jMSe2S5e9JigHUwhL4x42MAg2h
 TWdvE7VQ1WX0VekmNzkFv8P4aBBI0Qvcq3u2lea44nA+F8whxdN0QDK3Tc6gG2HLHVey
 4/UAeo1qlafQLjjkmA+6+qk+0ENVk7CaXwsYa1ngkwopEo+7fC0LhzHN+/Fa/0hwodZL
 /eGAqDmQt8t5qzCCCCj6KnYKFzYoDgkSEyoCDNjhT2UzbzkFfSA4bDgv3hB75KEtZH7f
 9sj2PnVChxZvekGZY8D8piEz/cTR5GX/Yv4m4KigsEXzR2sMeIUL5d4DwoPdK5HGNnx5
 F5nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW8q0KRnfTTH/b39CYGy7Ze5s2Cy/s6PSMpbnpB0w1vsbWVWzyqRXi/hswtiFDQCk0fJqsqs0OWO46@nongnu.org
X-Gm-Message-State: AOJu0YxALxzVvtgORz2TRKg/XDY25M6+uRMGtIvfG+qWXfgjlzwcM32f
 Ka7XljwiKCkWUQazh7Ls7HlGFQa2jEauYOHoleW5tjCsncnLs2UjU7VsotUEhbAdtaE=
X-Gm-Gg: ASbGncuxY3Iu4WDP+T/DRWt7WsHL82nCmQfOTuZavlNEQ5neSblJfQbbSlT88CKQxUw
 na6z1b7TgK/eH/XHqQenG8t18zKTrgqZmLWXCTSEpTOiEeamO9C4Xnj0ef0AZOKxXSn4BNcnoc+
 vQt2sRu69Sr3UOAn/ZAqBhayQI7/gGjren2Xte4O2P+JsbA4CiZvizXJMGF0JOW42sXe5vZ4JnJ
 6xx1kvb5wT5/16F13uOp77z3ppDcUTKVcSlIEcmNVCPpd87O6FnDBK7K1FFMZqo6deJwBh6qohc
 k3gmL2YL0qjUWuGUIJm8Yx5mTGYAz5CGpQXywS0/Tgu4qktqQg652kB/XbjRhQzm
X-Google-Smtp-Source: AGHT+IHYRkJ3k3pU119z942lcoiSzD1qzE1CnrZ0nnmgKjE5pzbNtCT7Yu7lnKd000N/QndIUEispA==
X-Received: by 2002:a17:903:22ca:b0:22f:c530:102 with SMTP id
 d9443c01a7336-231de376f89mr99192545ad.31.1747510463961; 
 Sat, 17 May 2025 12:34:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabdasm33785975ad.185.2025.05.17.12.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 12:34:23 -0700 (PDT)
Message-ID: <90aa40b9-6f6f-48f7-8c17-5f5bb74e4191@linaro.org>
Date: Sat, 17 May 2025 12:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] meson: merge lib{system, user}_ss with {system,
 user}_ss.
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-6-pierrick.bouvier@linaro.org>
 <6f741951-c322-4b0a-8723-a354d6547c84@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6f741951-c322-4b0a-8723-a354d6547c84@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/17/25 8:04 AM, Paolo Bonzini wrote:
> On 5/16/25 07:27, Pierrick Bouvier wrote:
>> Now that target configuration can be applied to lib{system, user}_ss,
>> there is no reason to keep that separate from the existing {system,
>> user}_ss.
> 
> The reason would be that previously you wouldn't have
> -DCOMPILING_SYSTEM_VS_USER defined for the files in system_ss/user_ss.
> I don't think it's a problem, because it's usually clear if a file is
> common QEMU infrastructure or specific to system emulation; but it's
> worth mentioning it in the commit message.
>

Yes, sure, I'll add it.
Indeed, it's not changing much, just unpoisoining CONFIG_USER_ONLY and 
CONFIG_SOFTMMU.
The only difference this change make is that existing system/user files 
now can eventually use those defines, which should be harmless as they 
were not using them before.

> Paolo
> 
>>                             c_args: ['-DCONFIG_USER_ONLY',
>>                                      '-DCOMPILING_SYSTEM_VS_USER'],
>> -                         dependencies: libuser_ss.all_dependencies(),
>> +                         include_directories: common_user_inc,
>> +                         dependencies: user_ss.all_dependencies(),
>>                             build_by_default: false)
>>    
>>    libsystem = static_library('system',
>> -                           libsystem_ss.all_sources() + genh,
>> +                           system_ss.all_sources() + genh,
>>                               c_args: ['-DCONFIG_SOFTMMU',
>>                                        '-DCOMPILING_SYSTEM_VS_USER'],
>> -                           dependencies: libsystem_ss.all_dependencies(),
>> +                           dependencies: system_ss.all_dependencies(),
>>                               build_by_default: false)
>>    
>>    # Note that this library is never used directly (only through extract_objects)
>> @@ -4121,7 +4119,6 @@ libsystem = static_library('system',
>>    common_all = static_library('common',
>>                                build_by_default: false,
>>                                sources: common_ss.all_sources() + genh,
>> -                            include_directories: common_user_inc,
>>                                implicit_include_directories: false,
>>                                dependencies: common_ss.all_dependencies())
>>    
>> @@ -4135,10 +4132,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>>      inc = [common_user_inc + target_inc]
>>    
>>      target_common = common_ss.apply(config_target, strict: false)
>> +  target_system = system_ss.apply(config_target, strict: false)
>> +  target_user = user_ss.apply(config_target, strict: false)
>>      common_deps = []
>> +  system_deps = []
>> +  user_deps = []
>>      foreach dep: target_common.dependencies()
>>        common_deps += dep.partial_dependency(compile_args: true, includes: true)
>>      endforeach
>> +  foreach dep: target_system.dependencies()
>> +    system_deps += dep.partial_dependency(compile_args: true, includes: true)
>> +  endforeach
>> +  foreach dep: target_user.dependencies()
>> +    user_deps += dep.partial_dependency(compile_args: true, includes: true)
>> +  endforeach
>>    
>>      # prevent common code to access cpu compile time definition,
>>      # but still allow access to cpu.h
>> @@ -4154,7 +4161,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>>            sources: src.all_sources() + genh,
>>            include_directories: inc,
>>            c_args: target_system_c_args,
>> -        dependencies: src.all_dependencies() + common_deps)
>> +        dependencies: src.all_dependencies() + common_deps + system_deps)
>>          hw_common_arch_libs += {target_base_arch: lib}
>>        endif
>>      endif
>> @@ -4168,7 +4175,8 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>>            sources: src.all_sources() + genh,
>>            include_directories: inc,
>>            c_args: target_c_args,
>> -        dependencies: src.all_dependencies() + common_deps)
>> +        dependencies: src.all_dependencies() + common_deps +
>> +                      system_deps + user_deps)
>>          target_common_arch_libs += {target_base_arch: lib}
>>        endif
>>      endif
>> @@ -4182,7 +4190,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>>            sources: src.all_sources() + genh,
>>            include_directories: inc,
>>            c_args: target_system_c_args,
>> -        dependencies: src.all_dependencies() + common_deps)
>> +        dependencies: src.all_dependencies() + common_deps + system_deps)
>>          target_common_system_arch_libs += {target_base_arch: lib}
>>        endif
>>      endif
>> @@ -4358,12 +4366,12 @@ foreach target : target_dirs
>>      objects = [common_all.extract_objects(target_common.sources())]
>>      arch_deps += target_common.dependencies()
>>      if target_type == 'system'
>> -    src = libsystem_ss.apply(config_target, strict: false)
>> +    src = system_ss.apply(config_target, strict: false)
>>        objects += libsystem.extract_objects(src.sources())
>>        arch_deps += src.dependencies()
>>      endif
>>      if target_type == 'user'
>> -    src = libuser_ss.apply(config_target, strict: false)
>> +    src = user_ss.apply(config_target, strict: false)
>>        objects += libuser.extract_objects(src.sources())
>>        arch_deps += src.dependencies()
>>      endif
> 


