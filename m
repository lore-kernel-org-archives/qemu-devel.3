Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CB3D3C922
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMA2-0003rT-AI; Wed, 10 Dec 2025 10:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTM9o-0003nW-EN
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:31:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTM9m-0005sa-U7
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:31:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so60436765e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765380668; x=1765985468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Sc4AtS9u6yBKHE4TK7m4sGx5R+wbjyp/npRUrN/cwQ=;
 b=Vn3R4AI+i7uGPBp0Qh8XrLL1MRruSMIt9iVuCPBHgWO13D/27iXcUUWrXkdO+orDwR
 QIQ7UgSuANn7G1ALfPG491mpzZZU3yC1FtzsxxTKYA4O2TSfdqVYKKmawERnnopbZ1qY
 uvaOPq+xqGmwYh4dXC0YD0O3zNvaccxD5WDasXJYyhAkZunivYmAaT/8VPVKp7s8yV7H
 gUehlvpKOjqCLsPWXooUz9UntrPEL277qHk4D2rISxCUQHVJkSp7lbRALAjfeY50b9ax
 zxAu/YU6DODj7Rb3YHEjKvXBpktVRLywXSAby6b5AI4Gn3hKxQmkg+3atqwrc8ZEWH8I
 2DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765380668; x=1765985468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Sc4AtS9u6yBKHE4TK7m4sGx5R+wbjyp/npRUrN/cwQ=;
 b=jmXJ0NwbZmcrp/JQXJkPESbzIoWUKukKsU7CQdWw5hWQfGuTLTMltagHt9K7UtQjSN
 khBq7ZlZpPL2U2kEX8XJquL8WHlHyPDDuU/eVYDaeePPSetBUAAQUeAyKlejCP8bbwAD
 x4QOTXXtL8Wqz3MI6Roz/+vBP0evmEVPqWGh6OHmc20vTBh2gm8S08TGO00vW5MGG06U
 D6nJBRwo5GPHNZlipI1+Sjl+BbStp/Hq/YLFBfDn2TaDF2m2N8yYSHLyZp6HJHWbWN7r
 YwxsOvXYBXjTcp0aTmxNOkCBdR2lPfCASakWtscQbAcO6BJiIt3yLQGEFaMT7J+UFNL7
 avjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBqzHkOPM1y1bDhRWYzMkjNGfZ9np54gr2qNEETHdZSrxNFckSj9QXWdhMbeD2jNPsiU+EOjUj/2wl@nongnu.org
X-Gm-Message-State: AOJu0YzOAijA2XwTu9/xwhLuIEwuG9HzcKoJOOc9cQzQZeXiFjPRzWvR
 CAXuwxaF3A8WZOtG8b9rfucEqnPJ+JpOy+GceIzOUNe+RWithONuMkaXZzWTqToOwBk=
X-Gm-Gg: ASbGncsJ0yqSUiCglyrVeXpnVQptzj8jklg3KyPLAFrregsyU6jOdQki2j92k/smLio
 qC0/yThApCmlZhkLCiUEAgG1CAak4YqUj0TF4Wkxc9OWJSvLEBkvxO4NeaeUSE6TH+++mjRjcHX
 UyzgpkVL6Dn+bKQKyVfae2lyHZPQZNn8SWFwOyWcJK/sbEZa2clAD99CCjgwJkX6ayUqXLWse2M
 Dk9t+zhM42T3GQli+oLecuKurTjsu22oYRm9jqJjns89s4BrdSMbcmvwnjw9FEDMDygLudOtUPY
 DMKMBiae4RoIpwih8muREsdtD8PteKsJwPXs++LYAO/lVd9D7FbDYdiTX+m1betKrtBA+eujCnZ
 8tYpRw0f3bRNtdRb3pnLOa7b0sJrpdkr1Ew3t5muDh3O3+pNp73z1aCKL2QodsSPR5mZQyN3kae
 aG/QPUNq34+ZASPL5fpWcODVUdzKwNLk3MGQab+DfHeXq41/dxXgi5nQ==
X-Google-Smtp-Source: AGHT+IGT/5m7yxG541oMru0SryansrE8LIQajPD/mc0m2FI45JXbW7NySxxOQsY6J1/utEYOf+DYuA==
X-Received: by 2002:a05:600c:1e8c:b0:477:a977:b8c2 with SMTP id
 5b1f17b1804b1-47a83752c85mr23678655e9.13.1765380667914; 
 Wed, 10 Dec 2025 07:31:07 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d3a75a3sm44231165e9.6.2025.12.10.07.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 07:31:07 -0800 (PST)
Message-ID: <72945e3a-8616-4f61-b12a-a4cafa320a4a@linaro.org>
Date: Wed, 10 Dec 2025 16:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: Treat kernel_start_addr as vaddr
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251210132130.14465-1-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251210132130.14465-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/12/25 14:21, Anton Johansson wrote:
> Changes kernel_start_addr from target_ulong to vaddr. Logically, the
> argument represents a virtual address at which to load the kernel image,
> which gets treated as a hwaddr as a fallback if elf and uimage loading
> fails.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> ---
> v2: Updated callers of riscv_load_kernel() to use vaddr, changed return
>      type of riscv_calc_kernel_start_addr().
> 
> ---
>   include/hw/riscv/boot.h    | 6 +++---
>   hw/riscv/boot.c            | 6 +++---
>   hw/riscv/microchip_pfsoc.c | 3 ++-
>   hw/riscv/sifive_u.c        | 3 ++-
>   hw/riscv/spike.c           | 2 +-
>   hw/riscv/virt.c            | 3 ++-
>   6 files changed, 13 insertions(+), 10 deletions(-)

LGTM, thanks!

