Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507CCCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 18:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEAUp-00085F-T6; Wed, 29 Oct 2025 14:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAUn-00084t-DB
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:02:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAUc-0007Ts-41
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 14:02:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so1190005e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761760900; x=1762365700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RU+DKa1AzAh0fxw0Ftt+P5hkeXWLgezjVsnTqgL3Bio=;
 b=v/cENkauBsN9+EIh/8+CGQ9EUITfgRtdAwMZXkuOieEcSYcI00OJEgyXgoXnVND22U
 8xC/qrQdf6NRnbOeCem4P23rnDSEYvn0+Vwg4lZd6OvOaLlbCyM4fvOdGn3lHDLvhPll
 5zzvmF9y+8ayq1jZl3uQXZijRMvLmVlMRcOzCTDS9/nL1JMZiyAEZ6GjAPGIQX/Badoc
 wyZgAQWQsCvHBB0s92DxTGjvhgK2bgH7ERztr0UryfqyP9giOmZSf1L8KZ3CgPGnu7+M
 g4BlwbH4e2JUJdNWhCEKx8nfpp5xwRI8o4/8BjPgFtfVxb1AAkn6E66DtlRGZ32s3BVu
 CU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761760900; x=1762365700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RU+DKa1AzAh0fxw0Ftt+P5hkeXWLgezjVsnTqgL3Bio=;
 b=mWMExOmRRsiD/slw8ptvBuP/EJ6J/RgSNHSukP8XqQ68rROSznmaIidXgA3dIk3Obk
 gpvfxiX/X/FuLF36RL4nXWdmmOIKk9n0+XMXv/q3noNtcKoVT9YAqtDP2Jrng+KTxFY0
 elsTF0MUCgylRn6pdy4W2Rpnd7o011fYChJB7QeZLJm8SigktLZYhTdT/6Vyc8neLYfT
 TRCGLdWf4EwtCIRnJF53ttDWpZmElrRMIp112q3ijWqN3rUd50Te26YSZfe24PRws3d7
 +kheuDdrh/Rnu57ft0zvO9vXQ3Jqpy4tTMkuzwu4Bp7KjlmPVH8NCny/o52km1gKxeg4
 +FFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdln4kF63f32lyVVRrGWzTG8FkXqWzRk6OpRJ1JpiiiQSBkzFGIlEXUFVWvF4YDQnC/Rq0XgRkLQuA@nongnu.org
X-Gm-Message-State: AOJu0Yzwy2iF9v2ZoXPyaO9EwcBEPdw1nsGQUDd+bF19+/OyxsVDTD0V
 mUZ6V9rumYXiw5vAOtS3fFv9yR/GSWFRoGobrlimiVAsCoi6In14gYqwTGa/Oc4SLTg=
X-Gm-Gg: ASbGnct37V/Z5Qslwwc9TbFEoAvTd3QFPV2dh0DrldIVsJ9hHYnPzEbcph4Ql2i6Pm6
 CXWvTfvvcLk7bHViDOBJHRiEASV2tevC/wJ+4/kUWUqH8vvo1zxsn3ZUocO2eCqfpbksTqqNaKZ
 5kpcDL8B6ZeUyZ9buLButpy1V5ojqjDFrTfma/PektRGkXe5Ede0ZVf3WzYzwg5XkL6c21srWvk
 YFdrR0A3Nrr2UH4bD7F7aiLARus9Mx09UtPVpnY+rK+agxOk5t60p289A1yVH/kjuYlWQv/+DE6
 G1DfnSrgiZsgnz0gBfNYg3h8Bw1CLkvMy4Zku9cDBBKLfjAEagB2Ggo8Ugji+yF4bs2eDihsrU9
 xFZBxVlF4UZCjFNUjwiBCCnrqPjo4mB2jIaIJWbaZsP7mGE4f7ATxVOjfSDzeoM/9Un3Bl/ySBC
 y4E+EqsUnCVsI5Tysdf4ilMMASkmcKY6sJSX7IOxN6V3o=
X-Google-Smtp-Source: AGHT+IHwv9qUNDV9082Pmxdo8bJzCqvtHpmA79TX3v/O9fLnmTc0smtFCjlUHcYpFMdTbgFP14B5vA==
X-Received: by 2002:a05:600c:4450:b0:46e:4a60:ea2c with SMTP id
 5b1f17b1804b1-4771e3ba5bcmr36607065e9.37.1761760900072; 
 Wed, 29 Oct 2025 11:01:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202093sm62701755e9.11.2025.10.29.11.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 11:01:39 -0700 (PDT)
Message-ID: <49e7ca69-3477-40c8-aad3-f799d848ce7a@linaro.org>
Date: Wed, 29 Oct 2025 19:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/riscv: Replace target_ulong uses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/10/25 13:35, Anton Johansson wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/riscv-iommu.c | 6 ++++--
>   hw/riscv/riscv_hart.c  | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe325..f8656ec04b 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -26,6 +26,8 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "qemu/timer.h"
> +#include "qemu/target-info.h"
> +#include "qemu/bitops.h"
>   
>   #include "cpu_bits.h"
>   #include "riscv-iommu.h"
> @@ -391,9 +393,9 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               const uint64_t va_mask = (1ULL << va_len) - 1;
>   
>               if (pass == S_STAGE && va_len > 32) {
> -                target_ulong mask, masked_msbs;
> +                uint64_t mask, masked_msbs;
>   
> -                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
> +                mask = MAKE_64BIT_MASK(0, target_long_bits() - va_len + 1);
>                   masked_msbs = (addr >> (va_len - 1)) & mask;
>   
>                   if (masked_msbs != 0 && masked_msbs != mask) {
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index c7e98a4308..65d2c92018 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -93,7 +93,7 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
>           g_assert(rc == 0);
>           csr_call(words[1], cpu, csr, &val);
>   
> -        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
> +        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
>   
>           return true;
>       }
> 

What about csr_call()?

