Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35FEC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0aj-0003d6-NW; Wed, 30 Apr 2025 02:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0aX-0003ZJ-Jm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:06:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0aV-0002Gt-Gl
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:06:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso4673536f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745993189; x=1746597989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VaK0UyE1mFBNKIjhFBbQsGXEj6TCL5MtPpa0p8PsSEs=;
 b=Vnjnsv+gEGQTK0Tw2aETxBVd2HqP4hz+anaWwh4SS05nGGel44OQ0wfIgcvbRPGDM4
 T6NquNlqj7+coQdfYLHp+BZRqAXqQp3PB5UBCRUOYjtySjrVCfIkBW8Bghh8LX+Fxx3f
 TFjtGKH4u8XObrwlja2dBNs8Ei5i0or3qCo0DdD3SK0VDRlLLlJkq5B05ml1ljVxtgn9
 LED5hINvuQAwy/J1XSnDs6PT7eXrGl5mzH48zRdjyHA0SoDNn0VC78A04cCKQ7BaGjxB
 0n/AKaP6TVH+i378/eUcdz8k8YHS9yeStlwlKx0aqy4xbcK3ui1apnewkl5qtQAcLOM9
 eCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745993189; x=1746597989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaK0UyE1mFBNKIjhFBbQsGXEj6TCL5MtPpa0p8PsSEs=;
 b=bwQJdcanbvOC6amPrQKyRlSdGjZDnIrBf4GhmSSICJuNNKPqUO1ZZJgpTOejyxt+MJ
 KGE0tD+x/EM959MVrZqaFJNRjKLUATtxsuzeIRcqxJoGvXPm1efafpnBZnENSVkQrgFF
 4Y7m0XxiQcETYyo1BTivup5c1H1ukfE4oPZslvltWNdtNhDqr4D21BI16Be2XPL4zJvy
 w83oYR+BfJMOX1g+dOIOVkZ9qWtasgTbsy86jltmwm47mC056yQ1kQrhqoa3w7lUBLZL
 EsJqbYTKFDdAQoPSNrSAVzzzrb1Se0cBCqhEqRw5wxQgaADfnO9bHykZ+y11QXYaexkR
 hN6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6BIjLdG4N4TB1luCPajKcDKnXyPT0B7V9joDElN2Z8kjAktwXfdiiMfAwDWU9RiyxjISk4InpI8yY@nongnu.org
X-Gm-Message-State: AOJu0YxZ6h+XMOJmGuTYISFsPTkwoLrUbpGU6NVxnt3ks63TkrI5CZ9s
 Bz0BnQpoRCB/nJEHjKMl6RcRckbdX+s19cxUCWhnyCYoH394yYNw7KldGux+Yyg=
X-Gm-Gg: ASbGncuPFaLxeEvXsiCVNvEnzGlDEeSCniOisEynVEPjemU4TEfz5lntYkdkh1jRFBO
 1EcRRqeG6Ain8uZb+rZfNSNB1P+wXB1auoZEfsQikPV5Drkaag1cQ1yzhUZSeRdWAk62tS7P/Dq
 eS218Cwpm/H5rTxcJagmpTIt7q4XrSMF3h0BCP1oYiVkydFfP4aCAu/RuGOdhpn2PYgQuP9OovK
 dChuDCozZFiT5QdsY2qYUuABpyT9vTQak2Ftbu7Et/THQDZJbdybpXyTa9Tjv9Lc23tVl9V/D1v
 2hf+F3vqk0ytUuyJ5nGYgP62OYg2ln0xHnILwvJyi5733TvtqpzBpGJ2SYuhAOLaBM1URjNp/9K
 Nq4w0aDgt
X-Google-Smtp-Source: AGHT+IFqY2wyvF3cR961CoTKkr0CDZXR/0s85Nwqd83veNOjb0gavDaD/XgV16EoOIwhK0OowJ6D0g==
X-Received: by 2002:a5d:64c7:0:b0:39c:1257:c96e with SMTP id
 ffacd0b85a97d-3a08ff55599mr664270f8f.58.1745993188968; 
 Tue, 29 Apr 2025 23:06:28 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461bfsm16159104f8f.79.2025.04.29.23.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 23:06:28 -0700 (PDT)
Message-ID: <f5a5e439-ed3a-49af-a3f2-da8a6f44ae83@linaro.org>
Date: Wed, 30 Apr 2025 08:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] meson: add common libs for target and target_system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, anjo@rev.ng,
 richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-4-pierrick.bouvier@linaro.org>
 <fd70e4f4-29b8-4027-a70c-747729172ce5@linaro.org>
 <12579394-7bce-4b9e-ba66-00ce1dff43d1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <12579394-7bce-4b9e-ba66-00ce1dff43d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/4/25 23:11, Pierrick Bouvier wrote:
> On 4/29/25 11:01 AM, Philippe Mathieu-Daudé wrote:
>> Hi Pierrick,
>>
>> On 29/4/25 07:00, Pierrick Bouvier wrote:
>>> Following what we did for hw/, we need target specific common libraries
>>> for target. We need 2 different libraries:
>>> - code common to a base architecture
>>> - system code common to a base architecture
>>>
>>> For user code, it can stay compiled per target for now.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    meson.build | 78 ++++++++++++++++++++++++++++++++++++++++ 
>>> +------------
>>>    1 file changed, 61 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 68d36ac140f..7b2cf3cd7d1 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -3684,6 +3684,8 @@ target_arch = {}
>>>    target_system_arch = {}
>>>    target_user_arch = {}
>>>    hw_common_arch = {}
>>> +target_common_arch = {}
>>> +target_common_system_arch = {}
>>>    # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>>>    # that is filled in by qapi/.
>>> @@ -4087,29 +4089,59 @@ common_all = static_library('common',
>>>    # construct common libraries per base architecture
>>>    hw_common_arch_libs = {}
>>> +target_common_arch_libs = {}
>>> +target_common_system_arch_libs = {}
>>>    foreach target : target_dirs
>>>      config_target = config_target_mak[target]
>>>      target_base_arch = config_target['TARGET_BASE_ARCH']
>>> +  target_inc = [include_directories('target' / target_base_arch)]
>>> +  inc = [common_user_inc + target_inc]
>>> -  # check if already generated
>>> -  if target_base_arch in hw_common_arch_libs
>>> -    continue
>>> -  endif
>>> +  # prevent common code to access cpu compile time definition,
>>> +  # but still allow access to cpu.h
>>> +  target_c_args = ['-DCPU_DEFS_H']
>>> +  target_system_c_args = target_c_args + ['- 
>>> DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
>>>      if target_base_arch in hw_common_arch
>>> -    target_inc = [include_directories('target' / target_base_arch)]
>>> -    src = hw_common_arch[target_base_arch]
>>> -    lib = static_library(
>>> -      'hw_' + target_base_arch,
>>> -      build_by_default: false,
>>> -      sources: src.all_sources() + genh,
>>> -      include_directories: common_user_inc + target_inc,
>>> -      implicit_include_directories: false,
>>> -      # prevent common code to access cpu compile time
>>> -      # definition, but still allow access to cpu.h
>>> -      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '- 
>>> DCONFIG_SOFTMMU'],
>>> -      dependencies: src.all_dependencies())
>>> -    hw_common_arch_libs += {target_base_arch: lib}
>>> +    if target_base_arch not in hw_common_arch_libs
>>> +      src = hw_common_arch[target_base_arch]
>>> +      lib = static_library(
>>> +        'hw_' + target_base_arch,
>>> +        build_by_default: false,
>>> +        sources: src.all_sources() + genh,
>>> +        include_directories: inc,
>>> +        c_args: target_system_c_args,
>>> +        dependencies: src.all_dependencies())
>>> +      hw_common_arch_libs += {target_base_arch: lib}
>>> +    endif
>>> +  endif
>>> +
>>> +  if target_base_arch in target_common_arch
>>> +    if target_base_arch not in target_common_arch_libs
>>> +      src = target_common_arch[target_base_arch]
>>> +      lib = static_library(
>>> +        'target_' + target_base_arch,
>>> +        build_by_default: false,
>>> +        sources: src.all_sources() + genh,
>>> +        include_directories: inc,
>>> +        c_args: target_c_args,
>>> +        dependencies: src.all_dependencies())
>>> +      target_common_arch_libs += {target_base_arch: lib}
>>> +    endif
>>> +  endif
>>> +
>>> +  if target_base_arch in target_common_system_arch
>>> +    if target_base_arch not in target_common_system_arch_libs
>>> +      src = target_common_system_arch[target_base_arch]
>>> +      lib = static_library(
>>> +        'target_system_' + target_base_arch,
>>> +        build_by_default: false,
>>> +        sources: src.all_sources() + genh,
>>> +        include_directories: inc,
>>> +        c_args: target_system_c_args,
>>> +        dependencies: src.all_dependencies())
>>> +      target_common_system_arch_libs += {target_base_arch: lib}
>>> +    endif
>>>      endif
>>>    endforeach
>>> @@ -4282,12 +4314,24 @@ foreach target : target_dirs
>>>      target_common = common_ss.apply(config_target, strict: false)
>>>      objects = [common_all.extract_objects(target_common.sources())]
>>>      arch_deps += target_common.dependencies()
>>> +  if target_base_arch in target_common_arch_libs
>>> +    src = target_common_arch[target_base_arch].apply(config_target, 
>>> strict: false)
>>> +    lib = target_common_arch_libs[target_base_arch]
>>> +    objects += lib.extract_objects(src.sources())
>>> +    arch_deps += src.dependencies()
>>> +  endif
>>>      if target_type == 'system' and target_base_arch in 
>>> hw_common_arch_libs
>>>        src = hw_common_arch[target_base_arch].apply(config_target, 
>>> strict: false)
>>>        lib = hw_common_arch_libs[target_base_arch]
>>>        objects += lib.extract_objects(src.sources())
>>>        arch_deps += src.dependencies()
>>>      endif
>>> +  if target_type == 'system' and target_base_arch in 
>>> target_common_system_arch_libs
>>> +    src = 
>>> target_common_system_arch[target_base_arch].apply(config_target, 
>>> strict: false)
>>> +    lib = target_common_system_arch_libs[target_base_arch]
>>> +    objects += lib.extract_objects(src.sources())
>>> +    arch_deps += src.dependencies()
>>> +  endif
>>>      target_specific = specific_ss.apply(config_target, strict: false)
>>>      arch_srcs += target_specific.sources()
>>
>> Somehow related to this patch, when converting from target_system_arch

"Somehow related to" ~-> "pre-existing issue exposed by"

>> to target_common_system_arch, emptying it, I get:
>>
>> ../../meson.build:4237:27: ERROR: Key microblaze is not in the 
>> dictionary.
>>
>> 4235   if target.endswith('-softmmu')
>> 4236     target_type='system'
>> 4237     t = target_system_arch[target_base_arch].apply(config_target,
>> strict: false)
>>
> 
> Patch 12 introduces an empty arm_common_ss and it does not seem to be a 
> problem.
> Feel free to share your meson.build if there is a problem.

Empty arm_common_ss[] isn't a problem. What I'm saying is
when I move all files from target_system_arch[ARCH] to 
target_common_system_arch[ARCH] I get an error because
target_system_arch[ARCH] isn't expected to be empty.
I suppose due to:

   target_system_arch[target_base_arch].apply()

Yes, I can keep/add an empty source set but it makes meson
files review more cumbersome (unused source set, but if you
remove it then the build fails).

