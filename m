Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CFBE77188
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 00:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUEyo-0004rZ-Gh; Sat, 04 Jan 2025 19:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUEym-0004rE-9j
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 19:58:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUEyk-0007y7-Mm
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 19:58:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163dc5155fso184056115ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 16:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736038733; x=1736643533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApbwMEeSPLE0lo59eyfcF6YvfFB6Nskvw3GslQLCDdA=;
 b=TSJXArIqjyP/hIm9Et+TTGJhhKM8kFrSueVQthPHKa/6+jgPFOBDQti5aOSC9saWWc
 sfoIXCIJNg3KzJPmemumWIyo/avu68anbGGyQl3Srd/QeYW1WMXeHytGGxC9ORIhofph
 Fzi7lzwUCmAWpvKuxRGlwd3lDtQDsm1PytFeVRJ6AInHI/io9q42r0oiRtqfiKWHfNq2
 xsYPXVrubu79sdjXXlvfwVpeUEaKXAxHRv7ZIUF8QsjYeOeOL/PAJ/nAjplLyKB2Mn/t
 2Smm/7J7QZVQ8CG0bICPL6vamYLLvYfxsJCxBJP5Nwrs3zSjlX/R2R/WfZgiDI1Jq6Lr
 Czug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736038733; x=1736643533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApbwMEeSPLE0lo59eyfcF6YvfFB6Nskvw3GslQLCDdA=;
 b=Tg8wWZHA6vaKDbLLLXxkddTTzNJc8vmlN07sZBFA92YFBYaf4l+xohnyqXmw3NEuHC
 OmtrkIxiOUUvjVQ548fGMHmEPTyeMZZocL6c9Y47qI1xpXX2Y4PMWkIHVIl9gZEeTwmz
 a9isKRuuh4a3U/xungVYBb/XRUZkQyBxRxV0EBKKrIXHmsv0/2EnbQJ0nYfM9Ye3KOmZ
 Efrw1Qpt8nq8OxZ13knz+YViw4pJWbzQH760vavbZsKirkJaOLzivzRPniOOMgd3M9ht
 dvJNRybYTZ0nwU/j34art0XT2D187QkZX35nIEMVkKYrI/um/TSXiTqICNdR8lR1k9Vy
 pNHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/t7j2m/Nx09dAPcmngFeJYFDg71eh0dd67coBD5zd7KxXNtOkl2Z/PacLQWte/RAVEQEU7wndUXBR@nongnu.org
X-Gm-Message-State: AOJu0YxG1uAFEU/nuVqU7VJI7MdYcMRx9GcOpQPTWXdpqbTa3atMRNNw
 1EA7kgf2WBNHEdVAjQrJCTHALlKQsCyUjy+oWhV7y6TVO5DlSzd51QqCMJmZMYE=
X-Gm-Gg: ASbGncu7N6Ct4G+1INjt23vxUiHzqFCiVyO/fPpKsPD65XoxWMtxutXyxE45Z2DXWsT
 IdDNzETEZyfXQGnm89keEzBkrC9hrSzJRPsH+8W+kP5PtUtveom6cGbLc/FPPP8YbJnRsMkH3dE
 VNyqTikn5qcs3ukmAcwH44D5zwiE5SOJkyqnMEpttP0VCWBxfsX901bWm5iQjOJ8uiyuZAzKRsL
 QPs/pGvJ/Ab+0IzOX82l69l9ukDyJPzVGreVC0fuMQgwbFUH/wugq7NqhwOzUjGgVW+NDPRxSkB
 HQWBfpcMS/39zXWquwxQw+AJrETeWAI=
X-Google-Smtp-Source: AGHT+IEhNuD64/L6vatxqc2VFA2n+AOV7sV/MRnWW2peeEzecnt0D/UyWwlZGPgFa5OHaWzNc8Hncg==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-72abdd9603cmr92770793b3a.8.1736038733529; 
 Sat, 04 Jan 2025 16:58:53 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad834cffsm29623137b3a.67.2025.01.04.16.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 16:58:53 -0800 (PST)
Message-ID: <9aa6172d-40bc-4086-9abb-4a11c2a4dc80@linaro.org>
Date: Sat, 4 Jan 2025 16:58:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] target/xtensa: Move xtensa-isa.c to common_ss[]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103231738.65413-1-philmd@linaro.org>
 <20250103231738.65413-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250103231738.65413-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/3/25 15:17, Philippe Mathieu-Daudé wrote:
> The Xtensa disassembler (selected with CONFIG_XTENSA_DIS=y)
> uses methods defined in xtensa-isa.c, so this file has to be
> compiled when the disassembler is linked.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/xtensa/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
> index f8d60101e3d..68ebfe2582d 100644
> --- a/target/xtensa/meson.build
> +++ b/target/xtensa/meson.build
> @@ -12,9 +12,10 @@ xtensa_ss.add(files(
>     'op_helper.c',
>     'translate.c',
>     'win_helper.c',
> -  'xtensa-isa.c',
>   ))
>   
> +common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa-isa.c'))
> +
>   xtensa_system_ss = ss.source_set()
>   xtensa_system_ss.add(files(
>     'dbg_helper.c',

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

