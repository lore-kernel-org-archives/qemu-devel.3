Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A724E98FDC
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlsp-0001YJ-M8; Thu, 09 Apr 2026 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlso-0001XP-2e
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:41:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAlsm-0001e8-C2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:41:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so9749615e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775727663; x=1776332463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5nYDmYgKSlz8Cdbt2udVqydHBlMo/5r0CRBZdvjimg=;
 b=k/mSWxj+C1Y+0e3aBmBMj/JWRF67JKHt/xk3hv0fF1US9eD8uuDKMnUXbWbVRb+Pjk
 lPZRNcRIL7mzOT2FXNfUUN8D0EnSEGb7dHcB5xQ3zU0pk/NI9tNGmwiUF3gpjxkoSxXN
 4d0V1h40GQMgNQePp4/1a5eI9rOYzkTbhoSvzp1DFXCLDqF5csIimXCD0ftuYsex7A0W
 4zAZyxFifeFqUJ7YMJwkiaz72MEXaHKXCvuoXMN5aFnUn5zVjStT1/b+Fuqu9RUHuInj
 yN+DZgTx2EdXcC/Ehe1xtqhxnXSyrRL2JrpaID1+I0aUgEY7eWmvQMoiQVYK3PfOBf0n
 wewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775727663; x=1776332463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5nYDmYgKSlz8Cdbt2udVqydHBlMo/5r0CRBZdvjimg=;
 b=jk1icKrthjp1zWdloJpawmrEV8j9Jgnic1aCWH/u7C3TUGsVFmDHBP4iLrkedHMByX
 6frsd89Mgvs+U67spALPo8SpEZmJNAHn7zIUCadCuYuMKgAIWRpnJ75ekJqZXy0JjpFu
 PKGSLxLs3tVu0W5opdf8mm6J3eqC/613KTMOKAinzTqeL2CUH5s6cSG5fcwc7ijKIp3X
 /GJXGnL0Mu+oxU3S9FI567WERroB85exLxhtW2/nhf5qtV5JJdl/OKDkzznVrMWlawWf
 0v7zjSYnc477AW2ttvY3QI8TXbbBk3XReRSnfLjZ3Q4QdHO5b89xfN5CH67m/CqmZmsY
 82ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSN9jbHmUOyBCqcgBzMIYT3/1FMweec72+pakgm6jMV5BLhBUBzBHAajLGR8RSUegzd6C30WiDVvcx@nongnu.org
X-Gm-Message-State: AOJu0YxKmANZxJx/JTUGfTPN81+1/40lBB0we1VhXnACMjDRPAYiT1ZS
 nEJUO6Un2ojRzuacehR8Bubbo9gJbgaGu0uprL7A5GpUSLb14wJmIvNObJ9lh6oA6Ag=
X-Gm-Gg: AeBDieue7s8R3ZnpRhxC2p9DlJk78wK/UX/0gOmctCS+pyXBH5KDF7e2zU6VBxbeq5u
 r1bbPh+zwVcjI45ZdVJaSpNR5mmm9Kx5dQAeECG27NwSL5FxVPyxSP8rVhL0TXyJyoxvqSpXDuj
 jp9u+hNGHougIOaPHNukxXhcVljAau8dJ6vLJTUGW74pH+U4d1jzgNdhZxR7AD62a9eSNcGgmVz
 Q+j6mXuGUhz/Nz6MP6zXXtuVhOkKbx/C4DkcW76s8dWwOvyAyrOhtSwpl/jWdd236SAkTG8QUYW
 qsnHCkzNenPU59ue+GWlzq18Rs5PtKLKitOmTc0B4KdYbjNLtJQo0KuC9TEppQ4E0uo1DZVBvC6
 f61vborUs3v/ZN/HUdkzVR7jpN1ODUTL4fYwqxTVSXMzM/twhR9jNwiu/xHEnd57IgMgwhwaau0
 krh8vjT9X3KwBZvFBVz9OFK6DFo1op4ft2rWia3Mg6Fq6/9SIKOHsbPZsEVGUELuxo4g==
X-Received: by 2002:a05:600c:3492:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488b14fb9e4mr222692255e9.0.1775727662930; 
 Thu, 09 Apr 2026 02:41:02 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c50a7sm65497555f8f.15.2026.04.09.02.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 02:41:02 -0700 (PDT)
Message-ID: <eee8b4fb-4028-46c6-9bc8-03cdb8a42b9a@linaro.org>
Date: Thu, 9 Apr 2026 11:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/mips: Use hex unit addresses in FDT CPU nodes
Content-Language: en-US
To: Vivian Wang <wangruikang@iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-3-946840930af2@iscas.ac.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260409-fix-unit-address-v1-3-946840930af2@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 08:40, Vivian Wang wrote:
> These unit addresses should have been in hex, not decimal, as per de
> facto convention [1]. Fix them.
> 
> Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   hw/mips/boston.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 4579df23eb..9ef3f6c814 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -542,7 +542,7 @@ static const void *create_fdt(BostonState *s,
>       qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
>   
>       for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        name = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        name = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);

No need to cast to unsigned explicitly, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

