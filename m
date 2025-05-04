Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF809C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRwb-0004lP-ET; Sun, 04 May 2025 01:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRwJ-0004Bi-Vx
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:31:03 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRwI-0004tL-0f
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:30:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b074d908e56so2460258a12.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336656; x=1746941456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KTAcWJ13xp5uQrxG2Jl/+OuSInS0YWXgC8gF3pCHPk=;
 b=I1HhTL/A076SL0UTTRUzMQxj0ATCwhu8meZjtrxgsxzinhisuNgI+HPc9JbxX29LYm
 igkUj/0ns1Tp45WP+E0hu6pu+fq777hAoaB61awi6ebgCi5H4+l2arZR+4xSIYvO1V4a
 frtK4Gg6QtV8UZdVLReCThhVDqd/1YTAS1i6MaQ1EFegZ/vYVgETz9gg098MKo3BcsTN
 bd0dy1ZI73zhwcFc462ZE2AFUl+1jqwtCvMVYaeNo+fOgHfH3uOuSao89H7Oy5Z2fCrY
 1FXdr+nn23Db1png53p0xyPFi82ohEDgIVdoDMn15vCZapjuxmErFTIE5r6BVN9laPAu
 kxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336656; x=1746941456;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KTAcWJ13xp5uQrxG2Jl/+OuSInS0YWXgC8gF3pCHPk=;
 b=uNxH3ZJtwhtWuLKJTzrYPnsfjMD5SrpxYZllKX6a6owacwbHWYekP8fe+tbcGOvDcP
 l8xtY+zF5oHL+GzR+dXxMlHw3dGXtVKajHrnR5jlVRcfCJ8g3ARlt038Z3wfo9WOwdPC
 q6NUinJmVyKH23npHM7SA3iHLWaV6IDJxQSVnuOH5U/3StijUrtoW2VOYXXkTCgR8kj0
 in9LBHxid+cRRwDJGvl5RqS7WryQYEomTwEojfHyXJj+J/hNRZtxji6rhiKsKH5wZjpa
 fbdvzdodhoJcaqh7veFHF2I6jryg5UCkpoJUTapJZ+ToUTx/b70iraJuXMqHkkpLhGgs
 Ys0g==
X-Gm-Message-State: AOJu0YwhL4ssdRn53A92hULxSUlQ4aHWtYWS8XQ8rZPaxKfqdk8N5PqZ
 XSYbCYxUB5KHSCiVoiNFyZyvfcrNwQrENBlb2lcWigQ2CBfGH/mhrMhfkLKLBv7IpdP4WLweFuK
 3XLc=
X-Gm-Gg: ASbGncveFZDB8LVF8j3Gxu/AYXAyGtlQ2SGA6YqFNHq+TK8eOBAQrjqlgORyWrtq/C+
 jc3Rx/VTMbV6wJ6+NnN7B/Aye5D4PiL8Lni2ItXPBQozTa4DSGJPr+4ZAdm7DQm3yKd9ZdfTqc2
 YN3caDyRCxlJKX0/LdfLM1Vr23fAlujRmt8/NLi7xhXFGsEXElOJSNwaV4AE8WYKUv00eWXfqPx
 3mltD0rIT0+54Krwyy57pC/kNNu69P61TGLoIn8MgBClw2n6ttcFegRbWIW1Mbx5xDLKz5dZaJb
 WbisVt/WilelGM3YxO2bbuYYd+eIEEXd1sL39wQGPDlI2SFf/9dWRCbfs9lcOFcy
X-Google-Smtp-Source: AGHT+IFG3Fh3OmK4nyyMWaj/8CJF8m2OKT56xa6Rlm7TVxCw3VLXdVuw4KrYDmvPYL2Yqr7Q05OW6Q==
X-Received: by 2002:a17:90b:3505:b0:308:7a70:489a with SMTP id
 98e67ed59e1d1-30a61a49176mr4616861a91.30.1746336656291; 
 Sat, 03 May 2025 22:30:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152291e3sm32237285ad.202.2025.05.03.22.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 22:30:55 -0700 (PDT)
Message-ID: <e060e797-306f-4541-907b-7fdd8ae7781d@linaro.org>
Date: Sat, 3 May 2025 22:30:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/40] meson: apply target config for picking files
 from libsystem and libuser
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-5-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250504052914.3525365-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 5/3/25 10:28 PM, Pierrick Bouvier wrote:
> semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
> However, this is a target configuration, so we need to apply it to the
> libsystem libuser source sets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 6f4129826af..59c520de359 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4056,27 +4056,19 @@ common_ss.add(qom, qemuutil)
>   common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
>   common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
>   
> -libuser_ss = libuser_ss.apply({})
>   libuser = static_library('user',
> -                         libuser_ss.sources() + genh,
> +                         libuser_ss.all_sources() + genh,
>                            c_args: ['-DCONFIG_USER_ONLY',
>                                     '-DCOMPILING_SYSTEM_VS_USER'],
> -                         dependencies: libuser_ss.dependencies(),
> +                         dependencies: libuser_ss.all_dependencies(),
>                            build_by_default: false)
> -libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
> -                             dependencies: libuser_ss.dependencies())
> -common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
>   
> -libsystem_ss = libsystem_ss.apply({})
>   libsystem = static_library('system',
> -                           libsystem_ss.sources() + genh,
> +                           libsystem_ss.all_sources() + genh,
>                              c_args: ['-DCONFIG_SOFTMMU',
>                                       '-DCOMPILING_SYSTEM_VS_USER'],
> -                           dependencies: libsystem_ss.dependencies(),
> +                           dependencies: libsystem_ss.all_dependencies(),
>                              build_by_default: false)
> -libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
> -                               dependencies: libsystem_ss.dependencies())
> -common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
>   
>   # Note that this library is never used directly (only through extract_objects)
>   # and is not built by default; therefore, source files not used by the build
> @@ -4315,6 +4307,16 @@ foreach target : target_dirs
>     target_common = common_ss.apply(config_target, strict: false)
>     objects = [common_all.extract_objects(target_common.sources())]
>     arch_deps += target_common.dependencies()
> +  if target_type == 'system'
> +    src = libsystem_ss.apply(config_target, strict: false)
> +    objects += libsystem.extract_objects(src.sources())
> +    arch_deps += src.dependencies()
> +  endif
> +  if target_type == 'user'
> +    src = libuser_ss.apply(config_target, strict: false)
> +    objects += libuser.extract_objects(src.sources())
> +    arch_deps += src.dependencies()
> +  endif
>     if target_base_arch in target_common_arch_libs
>       src = target_common_arch[target_base_arch].apply(config_target, strict: false)
>       lib = target_common_arch_libs[target_base_arch]

@Philippe: this is the patch you need for semihosting (+ previous one).

