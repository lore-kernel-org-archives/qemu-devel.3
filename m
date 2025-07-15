Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49819C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfUM-0002Sc-Of; Tue, 15 Jul 2025 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubf1a-00089V-Oz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:44:46 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubf1S-0004WG-0m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:44:44 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2edec6c5511so1276546fac.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752583473; x=1753188273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EebbW5dnlct8UgzYIk3wm160IkmReDGnHtxLEvdnmpM=;
 b=kaeJcMnKyXbVhfaSR3E9VfmYRQHyM7gdzTrw6jRAkclQEwAlBlS1wQO9zeAwhOYVaI
 VO8SuTg1eWxZ1eXoqleTf6IH+XVsUcT4gZ6vyGwDbH9MzqATixijxdaTFBXrbokEevUB
 Lcwq9tcG703/RGdsMp9R3O6J9ijILjyv78Z8RJuxGEOP8RsXXaRRhllC7P+64qyFBQFt
 6RP03CnKRlkPqWPzMv75/E8zXSddJVcsmCPNckyVi3YZ1pzCoVcPgrtVZdSgF/3UcoMC
 tYSDIxL5hi//nAo7IBQXJIMKP5+oOZe/wKFtxyByTHawxj0/7itKUu8PLaONiI5Zv6DA
 6Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752583473; x=1753188273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EebbW5dnlct8UgzYIk3wm160IkmReDGnHtxLEvdnmpM=;
 b=uumy3dDEYEQDcZJAEVAEaTP01Le24a2xH8FMymMAvoOLjOXOoabAe/CGSaNZstykuB
 J3ildmdrTSHHkLEjt/ZjBsr1lXdM9yX9w2hRG1ZFOIVcV7xfiNEJQvq+a75OcW3Ow5Y+
 cPwiDAbi3AlDtmX6Z1EiSOEcEsljw5q7kpKtfNO89vDC5EMT9X38htaqw83zlZKhqjga
 zrwRXiKhr3BC4GDytyWI+oTM3o9LMLsVZ9OaVTxo6yLn1nPe3f+OFs7YPyCKpDbWH7Tm
 BxPcxzB48EzeHesEHG2lP34IfZX4jX3xfe+jJJ1EC69HFeEhrjw28qktHi4FpK9TFAtn
 4wUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuj+G1uwksdHipBQRWHR5cQv2JuW4XFQJjnChJADFkL6hu0YAFmNDpiImFsxMzoMG8H7nqbGXG6dvm@nongnu.org
X-Gm-Message-State: AOJu0Yzz76jcKamv6pJ4EOzTEbG+j4Ji6uiMlfUrs+NII+tk9hcaTtn7
 YamCToHWoGa2b58RGdp7qp5WV8bAFlq1chVqjpdLGbE7IDYwC5C4TXwEFfszGJ+2hWQ=
X-Gm-Gg: ASbGncsrH4yxAi+QmnnKS0XrLlDrDzLpXbrIxawEjYxgpCUVjNIu9M/e3t05zERAkVk
 NgTGuYoNFS4yOKwMr8dysQ3c1cI3Mk01RUFsvvFtXIFsRCLMY2/SkJsdhJIsQEddId57Il/25r2
 8dzWTQQJ9MvUkEuCEzYmS1BNu8HICZJNVpj3JW7Otq+JfB9cJjJXTaKt2IFeuFPLMfi71xxn/pZ
 ka5bnu1m8MBQUlF0Ob0P/qNJvYqxDXPsSz0KNAMSPHaNNDekgWMWIJXfmEChhwTaAYN/SHhEaZa
 biQLN8UWN2eXRA3oKcw5q6D2R3ryJdvHWdFi82yQno97aMPIJFQa+0KYSIBtudyuSa8yauZrqcN
 6KYcWU93xHrPSSdDRamommXERu2I60WWGiBn1gJdTxzS7LWh/TZ82iZPI9cjOWIjsKeL2EI+hUq
 wi
X-Google-Smtp-Source: AGHT+IGAHdUAq1f21a82ux23xwr7ROdX5r/PfChV/uULUgwsVBijiZqMQmKjfDkEMRVm5JgcFYrxTA==
X-Received: by 2002:a05:6870:7048:b0:2ff:9953:42f7 with SMTP id
 586e51a60fabf-2ff99548b81mr965353fac.35.1752583473126; 
 Tue, 15 Jul 2025 05:44:33 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e58fac0b8sm461555a34.38.2025.07.15.05.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 05:44:32 -0700 (PDT)
Message-ID: <1b0f0b9a-76e0-4529-abde-d6692730fe6d@linaro.org>
Date: Tue, 15 Jul 2025 06:44:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 2/7] accel/tcg: Extract statistic related code
 to tcg-stats.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715104015.72663-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
> Statistic code is not specific to system emulation (except
> cross-page checks) and can be used to analyze user-mode binaries.

But it's not callable from user-mode.  At least so far, and within this series.
So, split out the new file if you like, but ...

> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 575e92bb9e8..002aa8f4588 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -11,6 +11,7 @@ tcg_ss.add(files(
>     'tcg-runtime-gvec.c',
>     'tb-maint.c',
>     'tcg-all.c',
> +  'tcg-stats.c',
>     'translate-all.c',
>     'translator.c',
>   ))

... leave it within system_ss.


r~

