Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1647CCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMVQ-0000QH-RC; Mon, 27 Oct 2025 08:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMVO-0000ID-Pf
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:39:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMVK-0006ck-BG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:39:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso58902515e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568751; x=1762173551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Ql+hTPlUsTJ8wpJN0eJ1PP4FlTu6yxQu8J9nvXsbnI=;
 b=OfJoO3NHZU7zVdNKngmwpRXgmZlyFl+N4ueBIZc6x5wv1ATGzUBFd7svgKqZlQxU58
 liP0BLDR6wUKq+RjCCkDEGXsf9xLdNPeUF0cK+rEA/Zt58Kk9Rit7IQkwngpfURgxMe7
 g9Fv0G9WcGRaXrs2b+HeW4TPrT/8bHe1pFIJhH7TKbWiaoRKap5yOLr5JWJKbzjhRhpz
 uxHNaaLYqThcHbkfJEPJkx5K1IR2kV/03VeCAi6jk1WqWjGF3pSmePIIQ5ubN06S6/XP
 B9oB8t5ekDAJ9yL5nhNAiQbeOhs9krp9d1uQ4+9O+ptm/NliED/gCNfu4ShcGvriVNTv
 697g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568751; x=1762173551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Ql+hTPlUsTJ8wpJN0eJ1PP4FlTu6yxQu8J9nvXsbnI=;
 b=FK8Qghmdn/RnclrqQnP4cDTi3qtkehT6/RgA8hIcMIpNNoB4fcNrau90IAC5BGbcME
 n+pFCqoUh5Ierx6UjR2EwyUjq3rNu9cWEgUbuS3GeQqIf/tbZOliS1o3BtATwmOLJj/o
 CrVQ0ZvSSSXYlXhifaboFDpr9Bmm77ZD9XYNq21zNCrjBLjZPZ/JjWOojeWe6RyXCR+x
 9nHdHXDX7flu0ZHQTUqvJhKgryjA0dv57Ox2R6fPmTU0AxxruCozPDD7DDIctbfZdaRP
 KV33m1APVsUySHF9REGkLwQ5ODERF5Y6eFAkZu6p0sh5dj28ja+5Joa8g07IviUYLMhi
 FExw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGx0dRC0JU28N12MZwh0vkLP1hAiMW0tXa7+LMS6f9yM48RM9Waq2WrTexbTDpQkgMFoFp0h9323u5@nongnu.org
X-Gm-Message-State: AOJu0Yy/sVsH9y2giRGPKbKOt85V0mzCHR7Oik6oX9j8JG+l3yKzl9Jk
 xvuvuJyvp0KodvUAkr3+AtbspF5vE68lQRrLMFShCedryggyhb7RTO1AxjcdcysSJ0/FZ1q1Uet
 8EY6gXzg=
X-Gm-Gg: ASbGncscVNGsYqCyEze0+CdymK1ll3OBOBAcLVFQJdJVatrjLZ+KaKLWqA/dq21Gs5s
 k1Wmtr1scJe3VjdKpkgnTUJrRyE9gE7gWZbtnaHvysLRM18TC+48Rc9yjXvbNgsrw/gwlrSW2p4
 GS25vbrJ282opImtuyfJv5qz6mWUPbf/HuV1lCilKFmjne3RVlEFUmSAM77kT0eKTo53OsKNSjX
 7ci+Tergac2XuT1JaOPsRAp9bnI8q+Itexf1iO9d3eWN1+AgwrO1JrirCf3JUbDGe6xC8G3cVt6
 /oEFfZwewQu8a+3Yw7EqburTZG8vzrAPFCwGrCdPCb31AVdJsVkkC1jhLcxmdsTQ5Tw4tq8UQEt
 udcSUhU0fsP4bUWR1LzWg570oehmv6nPmRXtkAbJU1faNCsN2+N0zMWzTIyeNKom8IQT67iYC85
 ePzVYv5OVtDWVcoc0IBIRm7Debp7bO4O6edgHMv01gyr6+/DuTHSrpyQ==
X-Google-Smtp-Source: AGHT+IGfFu6QX3ft/2rvrwT+kLulJLqO3IbLvzkBTBOfxQgVFY1wbfCY932mekqDBXLdL/bvR7RKDQ==
X-Received: by 2002:a05:600c:4688:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-47117925eb5mr259473075e9.40.1761568751364; 
 Mon, 27 Oct 2025 05:39:11 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4924a4sm136957735e9.7.2025.10.27.05.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:39:10 -0700 (PDT)
Message-ID: <2d408ff2-5f5c-4de9-a33b-904a25496b8b@linaro.org>
Date: Mon, 27 Oct 2025 13:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv: Use generic hwaddr for firmware
 addressses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-1-44478d589ae9@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-1-44478d589ae9@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Typo addres[s]ses ;)

On 27/10/25 13:35, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/boot.h    | 20 ++++++++++----------
>   hw/riscv/boot.c            | 22 +++++++++++-----------
>   hw/riscv/microchip_pfsoc.c |  2 +-
>   hw/riscv/sifive_u.c        |  2 +-
>   hw/riscv/spike.c           |  4 ++--
>   hw/riscv/virt.c            |  2 +-
>   6 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 7d59b2e6c6..d835594baa 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -43,21 +43,21 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
>   char *riscv_plic_hart_config_string(int hart_count);
>   
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
> -target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> -                                          target_ulong firmware_end_addr);
> -target_ulong riscv_find_and_load_firmware(MachineState *machine,
> -                                          const char *default_machine_firmware,
> -                                          hwaddr *firmware_load_addr,
> -                                          symbol_fn_t sym_cb);
> +hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> +                                    hwaddr firmware_end_addr);
> +hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    const char *default_machine_firmware,
> +                                    hwaddr *firmware_load_addr,
> +                                    symbol_fn_t sym_cb);
>   const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>   char *riscv_find_firmware(const char *firmware_filename,
>                             const char *default_machine_firmware);
> -target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr *firmware_load_addr,
> -                                 symbol_fn_t sym_cb);
> +hwaddr riscv_load_firmware(const char *firmware_filename,
> +                           hwaddr *firmware_load_addr,
> +                           symbol_fn_t sym_cb);

OK up to here,

>   void riscv_load_kernel(MachineState *machine,
>                          RISCVBootInfo *info,
> -                       target_ulong kernel_start_addr,
> +                       hwaddr kernel_start_addr,

but can we have this single change in a distinct patch please,
so we can better describe it than "firmware address" and it
doesn't block the rest?

>                          bool load_initrd,
>                          symbol_fn_t sym_cb);

