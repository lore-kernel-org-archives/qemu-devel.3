Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AA8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9pHT-0004WH-T1; Tue, 29 Apr 2025 14:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9pHR-0004Vy-Of
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:02:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9pHP-0002eX-Ky
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:02:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso56554205e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745949721; x=1746554521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5tX6znmzbpd+MNtjGZbGG6rcM/3SSGVVvBfmXACpsrY=;
 b=ftZhZoXV3S4+kiatPBENrzQBx/ydiFpy6hW4D2NS5rPKRvJS2+xCsYuCu4HpqGdZND
 LasMe63Yr0u3LOBG87zNl8Z1rueVzXQ6lu6evZY1C5aqKyJfSwZvLYtnJv9pEoIKuZZl
 rOggjA6kFjTk1yjJTUtXZgnFDAWURDjpzdqN3MR00OyRBZM2YCrAsd+u8jns/qNLIdta
 IY/EgEmYLCOu5Gm/ebn3zUdcyMyXF/uLhM1XBHmTiwQk/R/PCrXENfKO8DqQnvfq4Kqa
 j4U9AIS8t6nnBksvTsI1LTMI6wFrkIJiXJ5dnGAGWS6LD2vjL10EAObwUAD4Tm7OZvyT
 I4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745949721; x=1746554521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5tX6znmzbpd+MNtjGZbGG6rcM/3SSGVVvBfmXACpsrY=;
 b=rVBgwXmCtZG7cU+AfLF4ZdTLO3LVLm/2ip+iGqSfiuZQz7HwB68OBOe3utskTELk0N
 t7uG1b0Q+MNHNJ6mFlCJnIlR00rRhfD96wLh3CXswmBtDrx7QipxDtvySQk9vACQ1j04
 xrhYsAObXvFY+79pruh4qWTnWjexlL/9GaqNnva8yZU2A6OX5zHK0gAgkIXF9H9eU6nA
 U5IpMczkahtskjc15ZlOox60sjBYOnL7Z9+stYMfT3FsHuE0toLdI9AqDgVbNmx1UpUX
 nTFmRqF3lUtkPYVJp5407ZHF3O++2uWw51y9V/UUJMrxm4R75sEUAg2iNYI97I+SXToG
 cEpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq2XJ+sOmlQW/RAnQ6mUhbjRT7w0Ab9Ln9HEVYMdfGnQxtqC0e8pllPmtPvg2wT4kWgO9lg1ZMjMyp@nongnu.org
X-Gm-Message-State: AOJu0YzsiwOTTsThACaP6YXJR+0cIxYWiUt18SjUaSthgzk4L1kPc03j
 cVKuPaBGEH/nLEJPqU321LRYhbiEZ+DzEbwd4phwdBqy7iu4nGSS53Kbqe9BegE=
X-Gm-Gg: ASbGncsAolbmknz7CvbA4sIfzNx50zIrr57s5MnoLVYkXrc4zh2QuA+MK3XQls/9IDw
 sjrchBGjK0jiWt2jZHCeRZe8xKC9wvMsuCuadQ1wQ7U2MAd8W7v3dU2qYYc1MJqHH5kwR0B5Vlf
 BmT5oIiyrB+RXuH832qvwfIjRULFloqPhJUV6dCQa/6mMQj+oq5vOSAKjpaS7K5KH82lyAGnikv
 CJcFFwHo832N1y+yvUe0uOI4jLxTFuHyS2eukXt+NRyBO097IMT/mCazhLm0SZjapXJ+dndphRn
 B82Opt4KUH7RcPbOd6gswkl4jq/3YOHQ6CVs2CxIGHHUtbcy85T9sVWamsmkRQJjNH6IGv5Fi4K
 YWXrXwLM/HWJJKQ==
X-Google-Smtp-Source: AGHT+IGfaI23NYF76B479Bp7eKq+GJV/N5yaJymdVdvVphglf8imvkiZbjfj4oSEsp2KqhUsCvYy4A==
X-Received: by 2002:a05:600c:3844:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-441b1f32cb5mr1737775e9.7.1745949720801; 
 Tue, 29 Apr 2025 11:02:00 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ae456d7dsm15945095e9.1.2025.04.29.11.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 11:02:00 -0700 (PDT)
Message-ID: <fd70e4f4-29b8-4027-a70c-747729172ce5@linaro.org>
Date: Tue, 29 Apr 2025 20:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] meson: add common libs for target and target_system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429050010.971128-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Pierrick,

On 29/4/25 07:00, Pierrick Bouvier wrote:
> Following what we did for hw/, we need target specific common libraries
> for target. We need 2 different libraries:
> - code common to a base architecture
> - system code common to a base architecture
> 
> For user code, it can stay compiled per target for now.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 61 insertions(+), 17 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 68d36ac140f..7b2cf3cd7d1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3684,6 +3684,8 @@ target_arch = {}
>   target_system_arch = {}
>   target_user_arch = {}
>   hw_common_arch = {}
> +target_common_arch = {}
> +target_common_system_arch = {}
>   
>   # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
>   # that is filled in by qapi/.
> @@ -4087,29 +4089,59 @@ common_all = static_library('common',
>   
>   # construct common libraries per base architecture
>   hw_common_arch_libs = {}
> +target_common_arch_libs = {}
> +target_common_system_arch_libs = {}
>   foreach target : target_dirs
>     config_target = config_target_mak[target]
>     target_base_arch = config_target['TARGET_BASE_ARCH']
> +  target_inc = [include_directories('target' / target_base_arch)]
> +  inc = [common_user_inc + target_inc]
>   
> -  # check if already generated
> -  if target_base_arch in hw_common_arch_libs
> -    continue
> -  endif
> +  # prevent common code to access cpu compile time definition,
> +  # but still allow access to cpu.h
> +  target_c_args = ['-DCPU_DEFS_H']
> +  target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
>   
>     if target_base_arch in hw_common_arch
> -    target_inc = [include_directories('target' / target_base_arch)]
> -    src = hw_common_arch[target_base_arch]
> -    lib = static_library(
> -      'hw_' + target_base_arch,
> -      build_by_default: false,
> -      sources: src.all_sources() + genh,
> -      include_directories: common_user_inc + target_inc,
> -      implicit_include_directories: false,
> -      # prevent common code to access cpu compile time
> -      # definition, but still allow access to cpu.h
> -      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
> -      dependencies: src.all_dependencies())
> -    hw_common_arch_libs += {target_base_arch: lib}
> +    if target_base_arch not in hw_common_arch_libs
> +      src = hw_common_arch[target_base_arch]
> +      lib = static_library(
> +        'hw_' + target_base_arch,
> +        build_by_default: false,
> +        sources: src.all_sources() + genh,
> +        include_directories: inc,
> +        c_args: target_system_c_args,
> +        dependencies: src.all_dependencies())
> +      hw_common_arch_libs += {target_base_arch: lib}
> +    endif
> +  endif
> +
> +  if target_base_arch in target_common_arch
> +    if target_base_arch not in target_common_arch_libs
> +      src = target_common_arch[target_base_arch]
> +      lib = static_library(
> +        'target_' + target_base_arch,
> +        build_by_default: false,
> +        sources: src.all_sources() + genh,
> +        include_directories: inc,
> +        c_args: target_c_args,
> +        dependencies: src.all_dependencies())
> +      target_common_arch_libs += {target_base_arch: lib}
> +    endif
> +  endif
> +
> +  if target_base_arch in target_common_system_arch
> +    if target_base_arch not in target_common_system_arch_libs
> +      src = target_common_system_arch[target_base_arch]
> +      lib = static_library(
> +        'target_system_' + target_base_arch,
> +        build_by_default: false,
> +        sources: src.all_sources() + genh,
> +        include_directories: inc,
> +        c_args: target_system_c_args,
> +        dependencies: src.all_dependencies())
> +      target_common_system_arch_libs += {target_base_arch: lib}
> +    endif
>     endif
>   endforeach
>   
> @@ -4282,12 +4314,24 @@ foreach target : target_dirs
>     target_common = common_ss.apply(config_target, strict: false)
>     objects = [common_all.extract_objects(target_common.sources())]
>     arch_deps += target_common.dependencies()
> +  if target_base_arch in target_common_arch_libs
> +    src = target_common_arch[target_base_arch].apply(config_target, strict: false)
> +    lib = target_common_arch_libs[target_base_arch]
> +    objects += lib.extract_objects(src.sources())
> +    arch_deps += src.dependencies()
> +  endif
>     if target_type == 'system' and target_base_arch in hw_common_arch_libs
>       src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
>       lib = hw_common_arch_libs[target_base_arch]
>       objects += lib.extract_objects(src.sources())
>       arch_deps += src.dependencies()
>     endif
> +  if target_type == 'system' and target_base_arch in target_common_system_arch_libs
> +    src = target_common_system_arch[target_base_arch].apply(config_target, strict: false)
> +    lib = target_common_system_arch_libs[target_base_arch]
> +    objects += lib.extract_objects(src.sources())
> +    arch_deps += src.dependencies()
> +  endif
>   
>     target_specific = specific_ss.apply(config_target, strict: false)
>     arch_srcs += target_specific.sources()

Somehow related to this patch, when converting from target_system_arch
to target_common_system_arch, emptying it, I get:

../../meson.build:4237:27: ERROR: Key microblaze is not in the dictionary.

4235   if target.endswith('-softmmu')
4236     target_type='system'
4237     t = target_system_arch[target_base_arch].apply(config_target, 
strict: false)


