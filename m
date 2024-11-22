Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0CDE69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXUR-00019d-Im; Fri, 22 Nov 2024 12:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXUO-00019V-Pr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:30:40 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXUN-0001yP-2w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:30:40 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffa3e8e917so17433401fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732296637; x=1732901437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCOEFkCfIx6XecVH5AdGIl5HyPk1/GoEj7JrUsfI3wg=;
 b=IMfwT/V0O5cf1CuFbZ8QcNENc2/upgpxPt/yy5PsRNe+Mahr9B9TPRjRfh/6wG0VA1
 QJVsnpT9rn6fdyVEJoh2QHLkeAzUqwyMSmfTF4Lz+GQqUTXIcdXAIFofrZtHTeCfgLLV
 lNZgn6qgXaOUgnK0OnYQw9IGHCZJvFIY4zAYw5DX5YCl2wVHA5DLy6EbEwrWVJidC7/M
 Ov2SbZpR9aCuTp87v4E5P6Uqjvum2BJGIRc5yw4htv1TP2GnO/rEKzFQVTWZHNZ4rYvq
 JE/edJuERLdu499Z4cFr8T+9my50eMVaG+7ihyuGBSvTlX+vkR0hTwpmds26cA8kJSzr
 h4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732296637; x=1732901437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCOEFkCfIx6XecVH5AdGIl5HyPk1/GoEj7JrUsfI3wg=;
 b=Qq/yLEB2AAgZ79FhASGCUTVG3c0gejEul8y/QCxEI7sq5Pb+DM87kEFe+0kXL3rrXb
 i9xVCCy7Qf4bjVXHh5KXHPf8R7/qsXaCo0Xsy9nKpApjm2qEmg+BR2+lDVyz/LhVQ5qT
 tOjC82h3WLkgYyrVrDnk5/OIzfIW58GwYvV9l6trnJAyAlqI59vKIgMxb1vxOicQCy2T
 EwZ84cRM1oqLkUS5xD/zaGPkN4hVFeMg2WH6VC9erykHXqqpjFBEmGqkl7pTQXiHGb9i
 +DlKuFsjXacJwd/YaWNIvlhrTD6jj1Ca8ntBigU5NwzukBgxWuA+EpFGjPOGGdT3xJkd
 neGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEP0zSDFpF4Shshe8xjayrNJjqGnxccWEh1JLVKdJX5t4FvPwer0AqQ7hLZ8nod+ec48xL9YBha+z7@nongnu.org
X-Gm-Message-State: AOJu0YzxbRuMCedaznfCjSJbNCrQPdSR9cApkAz1s6uw70arreo4LL+W
 JuKDHHJKs4XRgTfUtwtseMF6roVCgRz8FrCrCV6Y6qik15pVaXwDIN3FbZiL+BV57NbS8tbZCtg
 67rE=
X-Gm-Gg: ASbGncsM/8biTPZycJh9hHUOBsWcnx8215Si6rKYnpi9ms3e4rqRN3ocn9urxTVFAeQ
 QKDzonQa5G4Ml7XUy1PxGdQKByFh1ay9o9JyvYR6aMKAKfmHU7GmRQjvLxcNnB9SEXaehZdysbk
 I1dOb97bLDAWhztveyZ/4VhJZDvWlUq0peR18hxNqhAu782DHdS4KNgcPPTWscuyGegXmMwDXv6
 JB22Yt2TQiUvCIKz5OQxANSrYsCMsHZScTm/iWcfiFTgJbvLxEVjY9v9+0HSmrl8gw6
X-Google-Smtp-Source: AGHT+IGZEsL2mT0sYqo9w1gYPNM/WUdGxicZ+6mUb2AW3owWvSezB3QW7jTP0DlGrTx5fQHUd+VNVA==
X-Received: by 2002:a05:651c:2228:b0:2fe:f8e1:5127 with SMTP id
 38308e7fff4ca-2ffa711e015mr22997001fa.9.1732296637128; 
 Fri, 22 Nov 2024 09:30:37 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa4d17149sm4335771fa.2.2024.11.22.09.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 09:30:35 -0800 (PST)
Message-ID: <c478cbc8-6684-4a8d-bd88-724d48098c36@linaro.org>
Date: Fri, 22 Nov 2024 11:30:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/43] Add option to enable/disable helper-to-tcg
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-2-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds a meson option for enabling/disabling helper-to-tcg along with a
> CONFIG_* definition.
> 
> CONFIG_* will in future commits be used to conditionally include the
> helper-to-tcg subproject, and to remove unneeded code/memory when
> helper-to-tcg is not in use.
> 
> Current meson option is limited to Hexagon, as helper-to-tcg will be
> included as a subproject from target/hexagon.  This will change in the
> future if multiple frontends adopt helper-to-tcg.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   meson.build                   | 7 +++++++
>   meson_options.txt             | 2 ++
>   scripts/meson-buildoptions.sh | 5 +++++
>   3 files changed, 14 insertions(+)

Looks ok.  Could probably stand another set of meson eyes.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/meson.build b/meson.build
> index e0b880e4e1..657ebe43f6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -230,6 +230,7 @@ have_ga = get_option('guest_agent') \
>              error_message: 'unsupported OS for QEMU guest agent') \
>     .allowed()
>   have_block = have_system or have_tools
> +helper_to_tcg_enabled = get_option('hexagon_helper_to_tcg')
>   
>   enable_modules = get_option('modules') \
>     .require(host_os != 'windows',
> @@ -3245,6 +3246,11 @@ foreach target : target_dirs
>         'CONFIG_QEMU_RTSIG_MAP': get_option('rtsig_map'),
>       }
>     endif
> +  if helper_to_tcg_enabled
> +    config_target += {
> +      'CONFIG_HELPER_TO_TCG': 'y',
> +    }
> +  endif
>   
>     target_kconfig = []
>     foreach sym: accelerators
> @@ -4122,6 +4128,7 @@ foreach target : target_dirs
>     if host_os == 'linux'
>       target_inc += include_directories('linux-headers', is_system: true)
>     endif
> +
>     if target.endswith('-softmmu')
>       target_type='system'
>       t = target_system_arch[target_base_arch].apply(config_target, strict: false)
> diff --git a/meson_options.txt b/meson_options.txt
> index 5eeaf3eee5..0730378305 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -374,6 +374,8 @@ option('qemu_ga_version', type: 'string', value: '',
>   
>   option('hexagon_idef_parser', type : 'boolean', value : true,
>          description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
> +option('hexagon_helper_to_tcg', type : 'boolean', value : true,
> +       description: 'use the helper-to-tcg translator to automatically generate TCG code for the Hexagon frontend')
>   
>   option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
>          description: 'tweak required x86_64 architecture version beyond compiler default')
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index a8066aab03..19c891a39b 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -13,6 +13,9 @@ meson_options_help() {
>     printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
>     printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
>     printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
> +  printf "%s\n" '  --disable-hexagon-helper-to-tcg'
> +  printf "%s\n" '                           use the helper-to-tcg translator to automatically'
> +  printf "%s\n" '                           generate TCG code for the Hexagon frontend'
>     printf "%s\n" '  --disable-hexagon-idef-parser'
>     printf "%s\n" '                           use idef-parser to automatically generate TCG'
>     printf "%s\n" '                           code for the Hexagon frontend'
> @@ -341,6 +344,8 @@ _meson_option_parse() {
>       --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
>       --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
>       --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
> +    --enable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=true ;;
> +    --disable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=false ;;
>       --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
>       --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
>       --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;


