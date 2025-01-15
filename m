Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096E6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvn3-0005Rp-Q9; Wed, 15 Jan 2025 00:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvn2-0005Re-73
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:18:04 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvn0-0006qg-Lw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:18:03 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so8614321a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918281; x=1737523081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JXrYw6jfVCKDEHJ2uVXX6ShNl/3kgGCg6ze+xfeisRo=;
 b=UlwmGDeJ+UE8iUAT6/y9xHZ0mMmA8nl0q+sWyqGL4Ki3TK98KXWn4Y7d03LjHXxsfX
 MJtGO9fSB+PsjcmaM7sWxCNhvpeJcByLWWokNqr7IBYm81EErSVAbC6sES8w8yYAR+sI
 8A314u6AWwEfKAGrUq4aRjsWuY9PqTZWlTzbzYK0R3oRE0YzXuuUSLYyN8RqKnbzXnFu
 eAngV2okOKXzzHtwssgRAINfx5xgyvfzT+5De0g8gG0mmnwprdaIDwv1hUU+p3vqhseg
 gkFs210GZgbAN10wbtXX8jbyppRJz076VakQOxEG7qckS4L7/K3LmI64EgUhs6M7OtFg
 rpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918281; x=1737523081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JXrYw6jfVCKDEHJ2uVXX6ShNl/3kgGCg6ze+xfeisRo=;
 b=rLbWdhZg/waxh+uloOCp7aOFoPUdKrBi/cWTDlZHm0LJziEdpz3VLSyK4ILiCGdKpz
 oOIFJUFh89uze3+m+2s4zT+qtp4QFDi/WV4syxkc7ZUVWZyVuDNQAboFiU1mhlUBZDVC
 tnhvgxejCeq0AWnlzPDpGYVFv+vqL165QYsY3QTcQMhGLI8OSZEUVZfyj8N/NxFhmaoc
 qPcxm0Exn6ueLyVrZFRt+9ORhefxGmMNunDlNxb96SrIQQvsov6Fc7ol0IVtK+CYap1w
 pV3XZ4+UsKLO9JJ74jKQ1TyVrrQ8jOBDWErk8unmTfslqN7MnxEIUS+tuIaMF4v/MFts
 a/aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbeGJOYKMq0qBxVuf2eumzf1TuGZ1e1s+7V4q7eyUZPXg42vgXM/61m0LrIkfEqhcf/7ufmPElL1iX@nongnu.org
X-Gm-Message-State: AOJu0YwVvBcfMDJ5E/1XTdZx9YA0b4JPnRoglk7E+DUsLJhQ+8KJiulm
 CX1HbyLyPhSGJXte9v14aSxKdixuHkgwELyB1IZC9KOwlmxdhVo4cjCrU7xOgQw=
X-Gm-Gg: ASbGnctSYfDEC7zCUtmqIle4ToAZvucODN9H/VyFIm7j4QcSyZ5Fe2cbLYTle36G8Y2
 MkTo5ppBSE4qsSm0Y6bhJjnhW+Ophmkd8FBSYDc733XG5pcrjuJAeycJh6t/bBQHPPVTgCSxvDm
 wWRwgct8WFaC5zAJuGqM0XUeJ7GM3DsGfRKo8m0/j9I5HHalZWXyDySmgRm8r/20wu/ZyjKNcoF
 IEpwjETT1XnUUN7udLbGx/CCzoASDvS0YhnwGBEzpRMEESasBtnzf0VyvA6u8/JmbhT3iu+Z0Wh
 xbmKz3mt6W3CuxOSwP+fKLw=
X-Google-Smtp-Source: AGHT+IF3NpRilI6czFz5YW43zZZFWdqtvd7EhxLE/8UuHtA1pzCMRz0o9gxko/xL3dxKXAfr28C2Xw==
X-Received: by 2002:a17:90b:2dc5:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2f548e9862amr36120945a91.5.1736918281290; 
 Tue, 14 Jan 2025 21:18:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c191e2fsm513833a91.19.2025.01.14.21.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:18:00 -0800 (PST)
Message-ID: <f7bde90a-e8f0-4a48-ab47-ad72603a8633@linaro.org>
Date: Tue, 14 Jan 2025 21:17:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] hw/mips/loongson3_bootp: Move to common_ss[]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> loongson3_bootp.c doesn't contain any target-specific code
> and can be build generically, move it to common_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index fcbee53bb32..31dbd2bf4d9 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -1,7 +1,8 @@
>   mips_ss = ss.source_set()
>   mips_ss.add(files('bootloader.c', 'mips_int.c'))
>   common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
> -mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
> +common_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c'))
> +mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_virt.c'))
>   mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
>   mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

