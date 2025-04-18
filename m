Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411D6C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 22:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5tpO-0007PC-VJ; Fri, 18 Apr 2025 18:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5tpL-0007Og-Of
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 18:04:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5tpK-00051U-22
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 18:04:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso26914295ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745013888; x=1745618688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tp4Zvd8l8nlmF/KU4FpsLvofGXwguJWFSscxZJbkJsw=;
 b=XSniFa588q76aZ5ti11oIab4OnTg9VOoP5uIm0FGAdVR8zkP3fqIMzax2ePdKoMF6u
 LXZlR7DpEceUwFOER+S/qOnMlXsAH76yz9o8u53WFQZPDvdvVzm1MBlOC+xHhhnb4Eio
 htAOPHT9iKZg9oAlN4lEHPsgLD9yJnkXxVfLJH+qR6K+RIm9/HsO1xQ2EyCuJH4WkL71
 yymYvTGQhTzBX+r6rzqxpxAAiydOvd75SkmLDoov3lZZRHoSKdF2qKAF8ob/IgP6SVBq
 9KDjC3uMFFFJI7wN7hRvNuG00G+lzXfiToIIVDqa6Ukm64N58e3p55ytYutHATvoXyp6
 9VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745013888; x=1745618688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp4Zvd8l8nlmF/KU4FpsLvofGXwguJWFSscxZJbkJsw=;
 b=KeVdPc8jEpjcKDH/goLB1s9mLsymldWvY8wPstngT4dGFeEtPaAJlOu0+rS2L2SgDj
 Y+9luRMQlFJ6YtlKHwdv5TThz2d5H8dWR79IBy7kaQ1CdSxL5yNtBJp2ebGPTWwSeX7y
 3Jk6ZsLaPNHPnMWFyF1+9ZmjSo1oWI6B7E0duNyO/EF4nzr4YCViKH93e4ou8sxNVCwQ
 3N2wkQ604GsALjwGRKry86gcDibNZpev4tLIFo0R7G7Tm6Tz+hlOo5o9Tv22XGIfoRWN
 EHWD07RWE0wPDzlSaHxDDuw7VuljhBCuRRwSxqp7ZtEDYUIlKzd1HUPbJGaLNvnodHGc
 Js3A==
X-Gm-Message-State: AOJu0Yzc5U7tdgk/wNSygD12sXjD5M9ivBXnyxMd1OdAMlG72+3fWl5G
 5btLW2HT7WZrxTEE56Ktg91WyCXV2mhJ5m9ikVVzSDrv+YbkogH0Fko+oVLNfoI=
X-Gm-Gg: ASbGncuHEFb1mC1wK9yok3GFPUjl7Q2G5iGy5pQq0XNY/cWzg/6e2MGHaZlsu7uVJhb
 eakp7OWamQp8cl2SSYyUi4lpeYyuy873UrSsB9pGG4NI2GHDUuDDk+C1njkRJ4BbF3qxY4elVaS
 zefIQAcVhR8KcHN0Hv7rv/tuo4V5yekURfrVCf3wxOEQDtMJO6ELcdSJXlWcFiEnTVKis5NaDqD
 5/iH0XR67iVEHh041d6MEyvG6J7Uyfnkd1pGMJhblbvk1T7WdvWBD+kOIlPXoPZY4h8P9ZoSgMF
 YgiCBqlOL7CxO9wPAs+Ijr5vQu5D2J4pN09+ti2MgeSL5gg4zxJI2tKycSHurX1deZ6wHWxBpKl
 j759DYuU=
X-Google-Smtp-Source: AGHT+IEHq3fmJbs7penfZaPywOxdHivFxSI3Aw2VqqagZmg+NLmBrQIq977FioNyGiF03Khk+1RZBw==
X-Received: by 2002:a17:902:ce88:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22c5360bdedmr56005955ad.39.1745013888081; 
 Fri, 18 Apr 2025 15:04:48 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda5csm21798615ad.44.2025.04.18.15.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 15:04:47 -0700 (PDT)
Message-ID: <24331d39-c856-445c-8f17-9fb990d400bb@linaro.org>
Date: Fri, 18 Apr 2025 15:04:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common-user/host/riscv: use tail pseudoinstruction for
 calling tail
To: Icenowy Zheng <uwu@icenowy.me>, Riku Voipio <riku.voipio@iki.fi>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20250417072206.364008-1-uwu@icenowy.me>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417072206.364008-1-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/17/25 00:22, Icenowy Zheng wrote:
> The j pseudoinstruction maps to a JAL instruction, which can only handle
> a jump to somewhere with a signed 20-bit destination. In case of static
> linking and LTO'ing this easily leads to "relocation truncated to fit"
> error.
> 
> Switch to use tail pseudoinstruction, which is the standard way to
> tail-call a function in medium code model (emits AUIPC+JALR).
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> P.S.
> It seems that moving it to common-user/ makes the file out of the
> MAINTAINERS section of "RISC-V TCG CPUS". I Manually added the
> maintainers there, but the MAINTAINERS file seems to need a change on
> this.
> 
>   common-user/host/riscv/safe-syscall.inc.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv/safe-syscall.inc.S
> index dfe83c300e..c8b81e33d0 100644
> --- a/common-user/host/riscv/safe-syscall.inc.S
> +++ b/common-user/host/riscv/safe-syscall.inc.S
> @@ -69,11 +69,11 @@ safe_syscall_end:
>   
>           /* code path setting errno */
>   0:      neg     a0, a0
> -        j       safe_syscall_set_errno_tail
> +        tail    safe_syscall_set_errno_tail
>   
>           /* code path when we didn't execute the syscall */
>   2:      li      a0, QEMU_ERESTARTSYS
> -        j       safe_syscall_set_errno_tail
> +        tail    safe_syscall_set_errno_tail
>   
>           .cfi_endproc
>           .size   safe_syscall_base, .-safe_syscall_base


