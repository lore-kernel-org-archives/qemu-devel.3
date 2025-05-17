Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59492C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 15:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGJ5x-0007RN-15; Sat, 17 May 2025 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGJ5u-0007RF-SD
 for qemu-devel@nongnu.org; Sat, 17 May 2025 11:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGJ5t-0006sB-4D
 for qemu-devel@nongnu.org; Sat, 17 May 2025 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747494296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3NnW1IQAaaezyethWBsSbiz2eIkJHaI3u2jV0b56TQA=;
 b=i0mwxw6euMy0MsFhtW7r1O/htCY13vFpSJzTqXFgVKeIzI5i7INyHHYTzzcY0wRln27Tld
 295JAnDn+biQvSIs1Nx0orOuRTP1fSUQKGmyhXAGEvHOz26fkd8UwOUacc3+EPHtVcF1aC
 9nyPSEoHIoM7+D01X5LXVB90pPP2orM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-M54AK3iPNGySlq_zDs76bA-1; Sat, 17 May 2025 11:04:54 -0400
X-MC-Unique: M54AK3iPNGySlq_zDs76bA-1
X-Mimecast-MFC-AGG-ID: M54AK3iPNGySlq_zDs76bA_1747494294
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f8cb4b1861so6280626d6.3
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 08:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747494294; x=1748099094;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3NnW1IQAaaezyethWBsSbiz2eIkJHaI3u2jV0b56TQA=;
 b=YOX8PJS3Ngq4UBYks/20BPiZF6XIBb8AZvVBGjwlpHhN3h23bTcoR3M8edzZf0m/px
 aiAVH7PDxRt26DjIK7gxBiT190nOzPxr5jbEPQWIu32FitKszfokZpTi0SrPZFp1UZ6q
 7tDfn15slgic1R+Lp8/UXsraGrX5cD68jcCnE0/mabjzE+ys/gXFkFP/ot2SMJxKfGNe
 QZgBZzgYNElM5YtniHb5UNzQ7RgvUcPgsYIUqCyXdnnb6rOFRZQIaqsHL8ynVUzmhe4f
 JcEdybUCb6XVDs3qybAanmxRFFNnQxLUhrOwSFh7yRMCYBATgYgAHiEP2RR75Juz94ys
 Ja7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGrV7FxQzjK/rAXns4EsggipzQ0rFA5GkByeWBEM9ZjIgpYk8agGFeWPQXWMHfVfpmAbT3T2bnf1X9@nongnu.org
X-Gm-Message-State: AOJu0Yxw1p2sGpnan9mw7e7QU0YXg6pFp0ZhI8C/cv1LVhevMH+6vXb8
 kRCJg4LaQXEqR6puN+LRY2CKP2O4dXIdjZGP2YC186opUZuyeFXbyczMjEUOxiT89JFCnGFzGPS
 /SY3AJVxHWEvqJ/YVZcvC4oDuWk5g27eeUYZmEs/1vldJ2Ar986c7eIDe
X-Gm-Gg: ASbGncvSpQ7AjPg+1xFZRLPGUGIwLU5DZsM8WyPmuqSxo/Tuhk5NwHFqMZTbygmmSZ/
 H+TGP9ib1WC2ORokoW2xp0UkQHFVn8Wk7BMDZwYFsOysbYd6D+5wVoLYlDGpXFE8V9vmXKCvstW
 XfzkKjs7ix2z0qie5A98Z5xfOgPTJvyBPvd7uJvEWsP7TzO0gaQoQvwtF3YCzSDkGk94vm5Ru44
 FzdY99FgLHaebXJyhRWi4QVckS8OlavxpwgMXVz3PKHDbjmX8hBGXVwun46gc9uSfzpCCQNfLZI
 kRjqBVAw6Y6o6Hx2Ig==
X-Received: by 2002:a05:6214:cc2:b0:6f8:ac64:64ca with SMTP id
 6a1803df08f44-6f8b0828750mr104570216d6.6.1747494292650; 
 Sat, 17 May 2025 08:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErxVrvh1nBicO6qCchtWqjXISTAGWlFdFxn9lNYaMaMHGSIdGAibrQNaGX/9XLQ6gYspgj4g==
X-Received: by 2002:a05:6214:cc2:b0:6f8:ac64:64ca with SMTP id
 6a1803df08f44-6f8b0828750mr104569716d6.6.1747494292069; 
 Sat, 17 May 2025 08:04:52 -0700 (PDT)
Received: from [192.168.21.214] ([69.164.134.123])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f8b097a3dbsm26350946d6.101.2025.05.17.08.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 08:04:51 -0700 (PDT)
Message-ID: <6f741951-c322-4b0a-8723-a354d6547c84@redhat.com>
Date: Sat, 17 May 2025 17:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] meson: merge lib{system, user}_ss with {system,
 user}_ss.
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-6-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250516052708.930928-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/16/25 07:27, Pierrick Bouvier wrote:
> Now that target configuration can be applied to lib{system, user}_ss,
> there is no reason to keep that separate from the existing {system,
> user}_ss.

The reason would be that previously you wouldn't have 
-DCOMPILING_SYSTEM_VS_USER defined for the files in system_ss/user_ss. 
I don't think it's a problem, because it's usually clear if a file is 
common QEMU infrastructure or specific to system emulation; but it's 
worth mentioning it in the commit message.

Paolo

>                            c_args: ['-DCONFIG_USER_ONLY',
>                                     '-DCOMPILING_SYSTEM_VS_USER'],
> -                         dependencies: libuser_ss.all_dependencies(),
> +                         include_directories: common_user_inc,
> +                         dependencies: user_ss.all_dependencies(),
>                            build_by_default: false)
>   
>   libsystem = static_library('system',
> -                           libsystem_ss.all_sources() + genh,
> +                           system_ss.all_sources() + genh,
>                              c_args: ['-DCONFIG_SOFTMMU',
>                                       '-DCOMPILING_SYSTEM_VS_USER'],
> -                           dependencies: libsystem_ss.all_dependencies(),
> +                           dependencies: system_ss.all_dependencies(),
>                              build_by_default: false)
>   
>   # Note that this library is never used directly (only through extract_objects)
> @@ -4121,7 +4119,6 @@ libsystem = static_library('system',
>   common_all = static_library('common',
>                               build_by_default: false,
>                               sources: common_ss.all_sources() + genh,
> -                            include_directories: common_user_inc,
>                               implicit_include_directories: false,
>                               dependencies: common_ss.all_dependencies())
>   
> @@ -4135,10 +4132,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>     inc = [common_user_inc + target_inc]
>   
>     target_common = common_ss.apply(config_target, strict: false)
> +  target_system = system_ss.apply(config_target, strict: false)
> +  target_user = user_ss.apply(config_target, strict: false)
>     common_deps = []
> +  system_deps = []
> +  user_deps = []
>     foreach dep: target_common.dependencies()
>       common_deps += dep.partial_dependency(compile_args: true, includes: true)
>     endforeach
> +  foreach dep: target_system.dependencies()
> +    system_deps += dep.partial_dependency(compile_args: true, includes: true)
> +  endforeach
> +  foreach dep: target_user.dependencies()
> +    user_deps += dep.partial_dependency(compile_args: true, includes: true)
> +  endforeach
>   
>     # prevent common code to access cpu compile time definition,
>     # but still allow access to cpu.h
> @@ -4154,7 +4161,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>           sources: src.all_sources() + genh,
>           include_directories: inc,
>           c_args: target_system_c_args,
> -        dependencies: src.all_dependencies() + common_deps)
> +        dependencies: src.all_dependencies() + common_deps + system_deps)
>         hw_common_arch_libs += {target_base_arch: lib}
>       endif
>     endif
> @@ -4168,7 +4175,8 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>           sources: src.all_sources() + genh,
>           include_directories: inc,
>           c_args: target_c_args,
> -        dependencies: src.all_dependencies() + common_deps)
> +        dependencies: src.all_dependencies() + common_deps +
> +                      system_deps + user_deps)
>         target_common_arch_libs += {target_base_arch: lib}
>       endif
>     endif
> @@ -4182,7 +4190,7 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
>           sources: src.all_sources() + genh,
>           include_directories: inc,
>           c_args: target_system_c_args,
> -        dependencies: src.all_dependencies() + common_deps)
> +        dependencies: src.all_dependencies() + common_deps + system_deps)
>         target_common_system_arch_libs += {target_base_arch: lib}
>       endif
>     endif
> @@ -4358,12 +4366,12 @@ foreach target : target_dirs
>     objects = [common_all.extract_objects(target_common.sources())]
>     arch_deps += target_common.dependencies()
>     if target_type == 'system'
> -    src = libsystem_ss.apply(config_target, strict: false)
> +    src = system_ss.apply(config_target, strict: false)
>       objects += libsystem.extract_objects(src.sources())
>       arch_deps += src.dependencies()
>     endif
>     if target_type == 'user'
> -    src = libuser_ss.apply(config_target, strict: false)
> +    src = user_ss.apply(config_target, strict: false)
>       objects += libuser.extract_objects(src.sources())
>       arch_deps += src.dependencies()
>     endif


