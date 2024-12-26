Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7676E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvPa-0002eu-7O; Thu, 26 Dec 2024 16:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvPY-0002eg-UJ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:28:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvPX-0003vS-C5
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:28:52 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216395e151bso57850315ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248530; x=1735853330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s5gf5xpwlwHGl2nl9b2gBbgcAQs1N65Vg3xSdZt9Bks=;
 b=r3Je8ZN3DIm7n6GkTRMJ51YYbuP87bMK8aGVnJZchdRY5Hrlgxcpnf4JyBnX+bI4IU
 m0faJvtjD/YuoYq+8aqHdhMlWMiZDre0lgi3CWNIEEs6PU7a4Rcydwmhi3VmbMyCxGAU
 vqhzghbrf+sQQtadInMqH3IjjtAfnJFTAJkHykWmdT+ufDkMw1IMLhMqbLCLvTIxYH09
 1cxrZPxOnwsJaoQa64+04PtsJq7gC3LWy3qW9njRFpRUhJdEjEvw4FIKiO/Y+NAF6uS9
 yq8UxwP0n7hETOxL4pFWLHMGU1eNtyLhrX3S1f5qnhQjOy5suLsDqhJFmkaCAs+k0IhV
 2V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248530; x=1735853330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s5gf5xpwlwHGl2nl9b2gBbgcAQs1N65Vg3xSdZt9Bks=;
 b=hdtHArQQSnF/EyERCIR6Tk3CNWqZNtDtsrAr5xWbXVFp21858JucIeVa3a8usrDchZ
 J2Ad6yRQ+5Ss1bI90gwFaxHsMNaWh+K5aTXfLEFTf+bdekdqWFUo3GgjdsEeK1siSyla
 /gFMut2PSAaRE07JAtlyQRymsJBJLE9974MFKZgDJWpJJITDmxMZFqOShWK/n2DUyWyz
 3cLIK0GWGJ6cLgZECnIOC/jFkrXxejCwDDcFEpkioCpP1ouQll18Fjvp9Yb2KspI9M9P
 GNhhahqA11V5fY6yoFERNuRFupm3QJhQduxwBOweOeMakHmvBUGBki37upA5xzPLeZXD
 RCKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeevcvrJ8mlT4J7EOeG4k1WIQw6NIaDlayU54iGR4Z8gkA59iP+tcnjRdl0+ehxEHiE/T9Ce65bJ+9@nongnu.org
X-Gm-Message-State: AOJu0YxH1fNP5HjWUpoVVeS7w0wkc+lbkCmXF5AEN4+VRr4IfHKkx7iy
 tWt3XuDqjcHoS2KfEX8qih+DrPPo7mwNnLMf8E/ldE1t8PC3vEzCtMcpg+7Aogs=
X-Gm-Gg: ASbGnctSxqAWaIAol+xrE21Dkmdu/iTmTMbZEjXTCXu1wN2JA1lL6KF4iif3uUxF2Ff
 PsNxn3tPQVycR6htP2owBbqpCaifCEyQRw28uKPvuyDK1DjKfbgXgyYTVmy6sEM/UP18KKSGlzb
 l1q08ud839kBNXx6VDxokR+Gat6hXZ8qTY8sDX+v3acXy1+x+CKm0LPpsMz2fkOOfpFQQlRQFAZ
 rDxFET8nlyaaGh0qsNXdwVdQLCiQb0wab/CCgXdTsIDmYKzGbWWAsMHB6K7wcS/xODAEVYI8I1C
 t5WK9ij++P6tt3i71mNHmPiv29wWWJ0MfC94Ed0=
X-Google-Smtp-Source: AGHT+IElURb9m96jorsAeYf5xvC/b7lt8+ElhhQI4xrDskbNuStPpWI8DpuqWR3iVpl8dtMt6roUhA==
X-Received: by 2002:a17:902:da8f:b0:215:98e7:9b1 with SMTP id
 d9443c01a7336-219e6ca6e4amr319144075ad.5.1735248529937; 
 Thu, 26 Dec 2024 13:28:49 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d447fsm120282415ad.128.2024.12.26.13.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:28:49 -0800 (PST)
Message-ID: <ad24fab8-4958-451e-b690-44f3eee5bcc8@linaro.org>
Date: Thu, 26 Dec 2024 13:28:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/23] target/loongarch: Cast address to 64bit before
 DMW_64_VSEG shift
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-7-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-7-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> Avoid compiler warning on 32bit. This code path won't be taken anyway.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/cpu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 580362ac3e9ffbe6c8523cf57902dcda018ceed5..b8da136eb0554ba661a15e3069ee0d6bae61af86 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -196,7 +196,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>   
>       plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
>       if (is_la64(env)) {
> -        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
> +        base_v = (uint64_t)address >> R_CSR_DMW_64_VSEG_SHIFT;
>       } else {
>           base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
>       }
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

