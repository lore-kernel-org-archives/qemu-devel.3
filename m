Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80DDC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPgN-0002Vf-Ii; Mon, 11 Aug 2025 06:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPgG-0002UR-3w
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:23:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPg6-0001WP-K1
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:23:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so2541982f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754907772; x=1755512572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+uRJ5isQa37UtSKIOFcfP+gYth5pmL5+1EhBiCLBmg=;
 b=WcvuWrulHfubw3Av82zD+VgWXVeSpm/CZ25qabVtL8auY9tH8lIXggBQ0dCdayYxcA
 FmNUgggbrb0FZIBBWih3ZIgeQ/SPQgUWjJVyktDMtGH+w06x/iVMBd9HtdHYZv69nDLI
 wSXjTvWcU3zSDfxXFLSfZTyVov9vVDBvcqLAyr/9kJBB/iYmWqq6jzHnzoXPHmWDfxgO
 kXMabDAngURXqkpD7dHt/vKG5bppfcWqJ/AM4B/9CabaZpzW92nX8/dBeXGW5NR6STfY
 PWsnQb+UWXkNAlKgTszAk5zp9V1/z3KH5Yd1ZsAYq1f3qC3LxrHdGoYqvdV3d70hPjfy
 0EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754907772; x=1755512572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+uRJ5isQa37UtSKIOFcfP+gYth5pmL5+1EhBiCLBmg=;
 b=k3lL2TO4fssWkU2WV9rL2C9uCJyFzYarOo6Vq35aaoADEHsvWV4EQ4sPi0uljJBJ/4
 KeLxv9Y+lviqCopWJ+tvveJwkg6XBbGq8295ARRQm2plrylmvKwV8K3qAw7csbNk6/U5
 lGF4c3SszU2tlBUa4bYIpW4FVKoroX7ExuLAPNjGqg43pcj5UuYlbTdX1SsY4r0ZmVcI
 LEJdXA9t828c3LAd7tR2flh1WOQeIclhIawhzQCaJnia+Hv4JZzkva+DCWWqsut8RSgd
 6N43ObezeVaYG7ffUbXShUJUu7FHp1wskNOns3BM8bmuYeQOdffGBvNTDflCqqKgkajK
 6+Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKSZvpqAVYMsU852jYiWJWJg6vqTbARNVuUXsQJp6+X7qfyeCFYfNC+cBMDRvims6T4Blfzwm0qa+@nongnu.org
X-Gm-Message-State: AOJu0YxEiB1nKsVFUPP97ISV1r8iqg8rNBApRKTqkCX58cAh/Jzv2t8k
 S7XW/RMAaLmVJJy5c5DSDB4xO43AI1Kf0M+B50V7CLBBaAD4RJB2IMM0LbvV4FASKXIvviqpLsc
 YzLvt
X-Gm-Gg: ASbGncvQY6SvuiSZNoq8dlE7aQ1feokRWxLkh56xzul9rHyYaey9uC8oUqftWRDo9Wl
 l0UmusnE2+yllqYgTx3WkQt6ZaVEoAoLG2O2DZ37Qw5OACDR2lgVMz19u5a2ZkWFzu44EApUw1j
 BkNoqmtiv8xofpU59Nu8YQ/PkTd6amuNwqxklT+HdE//ulwE4Bj4DxiSAYyk5zVCMFaFoNB4qHd
 AIGc0nw/MyMe12GvSIdFoas01v7RqDoV3KLnmvGv69jaxvhOWYIABcjgCANWXyJc2nSfTAmBfm7
 0D765gdRGBNmRP3YTpkWZJH1QKhL5OZlAdLvm7wui7rlthYIrbx+5r41Ein1OgPwi9GNq0SwVGC
 zQP8pr9GSzJ67qshndv6HrqtCUq5cxyb/Xc6aa2VA56QzorBu/+U0Dnk7j1dMaEfpzA==
X-Google-Smtp-Source: AGHT+IHlEPf2hWigdHsj2Kv5bryJ+oAIbC3o/XGZNVS1BVklk10Dhi0PfO+Wyl+v4uC9az8ktgLExA==
X-Received: by 2002:a05:6000:2908:b0:3b8:d082:42a with SMTP id
 ffacd0b85a97d-3b900b5509amr10164177f8f.45.1754907772142; 
 Mon, 11 Aug 2025 03:22:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5873c43sm268065205e9.22.2025.08.11.03.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 03:22:50 -0700 (PDT)
Message-ID: <5a955f10-88bc-4590-9887-ec0f95af3e17@linaro.org>
Date: Mon, 11 Aug 2025 12:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/11] hw/arm/smmuv3: Introduce secure registers and commands
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-2-tangtao1634@phytium.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250806151134.365755-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi,

On 6/8/25 17:11, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers and commands for
> managing secure transactions and context.
> 
> This patch introduces the definitions for these secure registers and
> commands within the SMMUv3 device model internal header.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3-internal.h | 57 ++++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/smmuv3.h  | 23 ++++++++++++++++
>   2 files changed, 80 insertions(+)


> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..72ad042514 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,29 @@ struct SMMUv3State {
>       qemu_irq     irq[4];
>       QemuMutex mutex;
>       char *stage;
> +
> +    /* Secure state */
> +    uint32_t secure_idr[5];
> +    uint32_t secure_cr[3];
> +    uint32_t secure_cr0ack;
> +    uint32_t secure_init;
> +    uint32_t secure_gbpa;
> +    uint32_t secure_irq_ctrl;
> +    uint32_t secure_gerror;
> +    uint32_t secure_gerrorn;
> +    uint64_t secure_gerror_irq_cfg0;
> +    uint32_t secure_gerror_irq_cfg1;
> +    uint32_t secure_gerror_irq_cfg2;
> +    uint64_t secure_strtab_base;
> +    uint32_t secure_strtab_base_cfg;
> +    uint8_t  secure_sid_split;
> +    uint32_t secure_features;
> +
> +    uint64_t secure_eventq_irq_cfg0;
> +    uint32_t secure_eventq_irq_cfg1;
> +    uint32_t secure_eventq_irq_cfg2;
> +
> +    SMMUQueue secure_eventq, secure_cmdq;

Note, we could also add these fields as

       struct {
           uint32_t idr[5];
           ...

       } secure;

With some IDEs it allows to only expand which set you are
interested in when debugging.

I then since it is mostly the same banked set, I wonder why we
don't extract the state and bank it:

       struct {
           uint32_t idr[5];
           ...

       } state[REG_NUM_BANKS];

I haven't looked at the rest, but this might simplify the
implementation.

Then maybe we can use the ARMASIdx enum as index.

>   };Shouldn't we add a subsection for these new fields in vmstate_smmuv3?

(If using banked state, then this is greatly simplified IMHO).

Regards,

Phil.

