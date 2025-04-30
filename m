Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4849BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0gz-0007Ks-3H; Wed, 30 Apr 2025 02:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA0gw-0007Jb-6V
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:13:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA0go-0003YY-1M
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:13:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b45cso97702885ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745993580; x=1746598380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qOz704mUFzAP7PczY6/TxPRr5rC31uzEdcNBaAx4x6U=;
 b=ig1sQIBqTmcP9wxHxcbFfM9mF7pZ0cZg1y5TfGS2+GAs3K5goFSIIlouPREn3m2l5e
 Wcb1G3G+2AhicmLjyclz19ol8is4ZcgLTH0PZ79GYkAWPYiQbrP68XlZRz+MAx3oJW8Q
 5B0TsdDUbEerVhF6FCGKhRttIN+lp/I8tQnieVhDNl8V0vuf4QFyEGSgpyV8ZZrS1N4R
 Wg24TfKDQagsvxSe+Om71vZVETEjOjejUq/1oQxiVbyzi3Rikv2Exap5CvIYdv3gfAce
 /pfJnEcy1ZLq0Jvxl3+LEPtnlpQgkIceCZUhfZj+OHk8NlIj8IsoQi618ew/6yueyQ7C
 b1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745993580; x=1746598380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOz704mUFzAP7PczY6/TxPRr5rC31uzEdcNBaAx4x6U=;
 b=f2uVcNQ8dM8rFmlitafjFch6fzad5tt1C/2I9X0HsPxaSCXnvqCDAd8Nn8TFHXLjpC
 H4Tuz+Zkh1kTcSl6bpJklGHEhMu+I5LfwpwIE0r540CQiz3bxs5LiNbQJJslvF+IvOUG
 slRUjGWJxMPbUHrM0zMdnciq7elQ5ELmL++24DO2aVf736OgifMihbaMc6vopTKYgKG4
 P5ZCOv/bu8mGYwbPWYtXlF/c5LC6gqbbTa64O6FVWO1UD7coEbrrkBfhDbSH69HHUySC
 6L+yD3miXyds3xIcCl4/0sgJSUVHi0mOtuB5H8D9hbuaGsj+2TqYexW0/nZzlzzmEMW9
 Wrsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEky+p6AHrwIBZEva7KoB5aSPjjgWZh7oqvpo2CWGJq9t4CiPm1LVR5yRz0Cf2fgxBgh/nMxWANnhY@nongnu.org
X-Gm-Message-State: AOJu0Yy8MK0NYc4Yt7hUIIlCuL7v1z3/Wx5Ejy6w8XeBqc88/LhSwfn4
 4vgnNdl/499qs+SYsgTUGi7rOAGXlqV+ymlO4pXb8cI9qMDweBrj6OpNbdKI+pU=
X-Gm-Gg: ASbGncvmESUI5U4rfw5fd58bnLc/XzJbCJXAfM+zx5R28pBtRjJg22/irwuTjoG2YbP
 mgqAwA8MhwbZDQBubuktnhysZCVwPD56zHS7PhERbq/yl4OAw54Hd9jVvqNbDQuLOegzauDWjkz
 y0OOXVypTE1ZJlV1elGLEb5pQOq3kKx0JKJMm0bpBEzqDaEb5yZRtncxWBwppH4grLd2iNYyyMf
 TIRJUhRoN2c1WMheR8Ypyx0hly8sWDLRciUqSl4hBl54YTTx4BHPcHqw7buF8pWbkSYKXijJmNE
 6qDuceExbkhX73JwV763uytDLMCuriUsUCELq6dY7Oje+20X4a6dkw==
X-Google-Smtp-Source: AGHT+IGDqECtzVQiyvob42K+wWVkyDgAiBwFIiXNIl3yGzVgEww+Lj75qqTlHArlcv9m3haBR7C2Bw==
X-Received: by 2002:a17:903:22ca:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22df5764863mr19101975ad.11.1745993579899; 
 Tue, 29 Apr 2025 23:12:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216bb0sm114355105ad.235.2025.04.29.23.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 23:12:59 -0700 (PDT)
Message-ID: <71d2f4ba-6bbb-42de-b460-bea1ef979b68@linaro.org>
Date: Tue, 29 Apr 2025 23:12:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] meson: add common libs for target and target_system
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, anjo@rev.ng,
 richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-4-pierrick.bouvier@linaro.org>
 <fd70e4f4-29b8-4027-a70c-747729172ce5@linaro.org>
 <12579394-7bce-4b9e-ba66-00ce1dff43d1@linaro.org>
 <f5a5e439-ed3a-49af-a3f2-da8a6f44ae83@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f5a5e439-ed3a-49af-a3f2-da8a6f44ae83@linaro.org>
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

On 4/29/25 11:06 PM, Philippe Mathieu-Daudé wrote:
> On 29/4/25 23:11, Pierrick Bouvier wrote:
>> On 4/29/25 11:01 AM, Philippe Mathieu-Daudé wrote:
>>> Hi Pierrick,
>>>
>>> On 29/4/25 07:00, Pierrick Bouvier wrote:
>>>> Following what we did for hw/, we need target specific common libraries
>>>> for target. We need 2 different libraries:
>>>> - code common to a base architecture
>>>> - system code common to a base architecture
>>>>
>>>> For user code, it can stay compiled per target for now.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     meson.build | 78 ++++++++++++++++++++++++++++++++++++++++
>>>> +------------
>>>>     1 file changed, 61 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 68d36ac140f..7b2cf3cd7d1 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -3684,6 +3684,8 @@ target_arch = {}
>>>>     target_system_arch = {}
>>>>     target_user_arch = {}
>>>>     hw_common_arch = {}
>>>> +target_common_arch = {}
>>>> +target_common_system_arch = {}
>>>>     # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>>>>     # that is filled in by qapi/.
>>>> @@ -4087,29 +4089,59 @@ common_all = static_library('common',
>>>>     # construct common libraries per base architecture
>>>>     hw_common_arch_libs = {}
>>>> +target_common_arch_libs = {}
>>>> +target_common_system_arch_libs = {}
>>>>     foreach target : target_dirs
>>>>       config_target = config_target_mak[target]
>>>>       target_base_arch = config_target['TARGET_BASE_ARCH']
>>>> +  target_inc = [include_directories('target' / target_base_arch)]
>>>> +  inc = [common_user_inc + target_inc]
>>>> -  # check if already generated
>>>> -  if target_base_arch in hw_common_arch_libs
>>>> -    continue
>>>> -  endif
>>>> +  # prevent common code to access cpu compile time definition,
>>>> +  # but still allow access to cpu.h
>>>> +  target_c_args = ['-DCPU_DEFS_H']
>>>> +  target_system_c_args = target_c_args + ['-
>>>> DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
>>>>       if target_base_arch in hw_common_arch
>>>> -    target_inc = [include_directories('target' / target_base_arch)]
>>>> -    src = hw_common_arch[target_base_arch]
>>>> -    lib = static_library(
>>>> -      'hw_' + target_base_arch,
>>>> -      build_by_default: false,
>>>> -      sources: src.all_sources() + genh,
>>>> -      include_directories: common_user_inc + target_inc,
>>>> -      implicit_include_directories: false,
>>>> -      # prevent common code to access cpu compile time
>>>> -      # definition, but still allow access to cpu.h
>>>> -      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-
>>>> DCONFIG_SOFTMMU'],
>>>> -      dependencies: src.all_dependencies())
>>>> -    hw_common_arch_libs += {target_base_arch: lib}
>>>> +    if target_base_arch not in hw_common_arch_libs
>>>> +      src = hw_common_arch[target_base_arch]
>>>> +      lib = static_library(
>>>> +        'hw_' + target_base_arch,
>>>> +        build_by_default: false,
>>>> +        sources: src.all_sources() + genh,
>>>> +        include_directories: inc,
>>>> +        c_args: target_system_c_args,
>>>> +        dependencies: src.all_dependencies())
>>>> +      hw_common_arch_libs += {target_base_arch: lib}
>>>> +    endif
>>>> +  endif
>>>> +
>>>> +  if target_base_arch in target_common_arch
>>>> +    if target_base_arch not in target_common_arch_libs
>>>> +      src = target_common_arch[target_base_arch]
>>>> +      lib = static_library(
>>>> +        'target_' + target_base_arch,
>>>> +        build_by_default: false,
>>>> +        sources: src.all_sources() + genh,
>>>> +        include_directories: inc,
>>>> +        c_args: target_c_args,
>>>> +        dependencies: src.all_dependencies())
>>>> +      target_common_arch_libs += {target_base_arch: lib}
>>>> +    endif
>>>> +  endif
>>>> +
>>>> +  if target_base_arch in target_common_system_arch
>>>> +    if target_base_arch not in target_common_system_arch_libs
>>>> +      src = target_common_system_arch[target_base_arch]
>>>> +      lib = static_library(
>>>> +        'target_system_' + target_base_arch,
>>>> +        build_by_default: false,
>>>> +        sources: src.all_sources() + genh,
>>>> +        include_directories: inc,
>>>> +        c_args: target_system_c_args,
>>>> +        dependencies: src.all_dependencies())
>>>> +      target_common_system_arch_libs += {target_base_arch: lib}
>>>> +    endif
>>>>       endif
>>>>     endforeach
>>>> @@ -4282,12 +4314,24 @@ foreach target : target_dirs
>>>>       target_common = common_ss.apply(config_target, strict: false)
>>>>       objects = [common_all.extract_objects(target_common.sources())]
>>>>       arch_deps += target_common.dependencies()
>>>> +  if target_base_arch in target_common_arch_libs
>>>> +    src = target_common_arch[target_base_arch].apply(config_target,
>>>> strict: false)
>>>> +    lib = target_common_arch_libs[target_base_arch]
>>>> +    objects += lib.extract_objects(src.sources())
>>>> +    arch_deps += src.dependencies()
>>>> +  endif
>>>>       if target_type == 'system' and target_base_arch in
>>>> hw_common_arch_libs
>>>>         src = hw_common_arch[target_base_arch].apply(config_target,
>>>> strict: false)
>>>>         lib = hw_common_arch_libs[target_base_arch]
>>>>         objects += lib.extract_objects(src.sources())
>>>>         arch_deps += src.dependencies()
>>>>       endif
>>>> +  if target_type == 'system' and target_base_arch in
>>>> target_common_system_arch_libs
>>>> +    src =
>>>> target_common_system_arch[target_base_arch].apply(config_target,
>>>> strict: false)
>>>> +    lib = target_common_system_arch_libs[target_base_arch]
>>>> +    objects += lib.extract_objects(src.sources())
>>>> +    arch_deps += src.dependencies()
>>>> +  endif
>>>>       target_specific = specific_ss.apply(config_target, strict: false)
>>>>       arch_srcs += target_specific.sources()
>>>
>>> Somehow related to this patch, when converting from target_system_arch
> 
> "Somehow related to" ~-> "pre-existing issue exposed by"
> 
>>> to target_common_system_arch, emptying it, I get:
>>>
>>> ../../meson.build:4237:27: ERROR: Key microblaze is not in the
>>> dictionary.
>>>
>>> 4235   if target.endswith('-softmmu')
>>> 4236     target_type='system'
>>> 4237     t = target_system_arch[target_base_arch].apply(config_target,
>>> strict: false)
>>>
>>
>> Patch 12 introduces an empty arm_common_ss and it does not seem to be a
>> problem.
>> Feel free to share your meson.build if there is a problem.
> 
> Empty arm_common_ss[] isn't a problem. What I'm saying is
> when I move all files from target_system_arch[ARCH] to
> target_common_system_arch[ARCH] I get an error because
> target_system_arch[ARCH] isn't expected to be empty.
> I suppose due to:
> 
>     target_system_arch[target_base_arch].apply()
> 
> Yes, I can keep/add an empty source set but it makes meson
> files review more cumbersome (unused source set, but if you
> remove it then the build fails).

Oh, I see.
Then, you just need to add a conditional
"if target_base_arch in target_system_arch" around this spot, and remove 
the dictionary entry set in target/microblaze/meson.build.

- target_arch += {'microblaze': microblaze_ss}

This target was much quicker than arm, it's nice :)

