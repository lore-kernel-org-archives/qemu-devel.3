Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D905CEE35D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 21:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLT8P-0006Zi-DC; Tue, 18 Nov 2025 16:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLT8H-0006Yg-C7
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 16:21:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLT8D-0001qx-QH
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 16:21:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so25249925e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763500855; x=1764105655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xy2p6YX/MWZURx/WwU0Mbv6ROkO9za+nYxSRJzOQpTE=;
 b=x/EGGsRyMZLS3pA38lQwxMjMXg7IGO/DRjRtiqSqnc54K/XsxuCmF1k4yob9TNzWxV
 1RvOkTxjzHiW4AMLNxRsLg3X5zY386kB8ggmQLziD3wETzw+pHdK9ZYiq/hr38qCSg8g
 YJXsSXcNR4kTO/ogyg/TYQxEapLrfS0s6+mO1XpOYccSa7h8lj9itlddKnb+S17AhdZv
 ir+nMx0/oLgN/FSE/UWrrtHWbKJzH6wPohuOYvGEkd+Q7cBe4jEt1+Vvjk8p/Uwur7iX
 y60m1ejQfGCAEnV8maVRsGJqgOzJdNHuH6ftX5jJBuEN1SHHnqfS+Pucadxl6Ej9xcQy
 AFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763500855; x=1764105655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xy2p6YX/MWZURx/WwU0Mbv6ROkO9za+nYxSRJzOQpTE=;
 b=CMz4DxrjGmM28XBwWejYj0tAohny327wWbaCTkoZZoKiM5UAaxupicy7WSrem02f+o
 CrYBGgIuf+fVPgzVCQgeAgxemtZVlPeo/kkkOiuNiGswOJImLHmSyb7zCiQ1s7ywdpe7
 Dz8vVwLk569yCKV4AYD5Yl3j7YCJaovek6vF9clRrVeRxNrcUiByshdIzN8YF51yRoP/
 ksTFW8uG202hX3SdZwCPvsBF4g8mxDgKLiZIIpnV6bhhlgIUgKNYnoHSx4GXjwOf/yvx
 cHX3nybZqr6284WklE4jnBtWW83q8yrzvAOVa8tRlfIZlHCcSLCHL/8zqA8r+MiTNTf9
 /EpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEKR09eTW8+89/8KoJEOtmJnVjuZdSXsHp87fh9UHFKR5totGWnp8q364+H8LXOPt49IWd3Y3l7gVf@nongnu.org
X-Gm-Message-State: AOJu0YxPa1z4VnRxfV9em6OoqyHAaBTRA67PzHngF6w/XLoCPYbCDqjW
 pHZG+05yQHqgqn1DByyrBK3sMaVe6JdiwgOiZjNy4ngmoFRFApEelRAr//lu3uBoRCo=
X-Gm-Gg: ASbGncs8e7IiTmvis8WQWcUGXljzRRG5nAvqPZk8qH05f4vzsAwlc7vhhVThw6bxNFH
 4LTNWomEntgmgZglgltktBw/xt60Qg/LFOAsPkzNk4R6Lv6NlCznpaqYoJt1/Pw0S2nx1GDJYep
 FHB0njppue1BvzFhCnL57OZXRbRKO2GueCo6X0UwXLeCBXlqGtOxtG4WVZrwXTwd1NLkK4KRf/F
 unm4MOohuYXz3kUA6qgkFRKJoPjox9DTkbFQ58KW6VplxfUEMcC+fdjYtnO4PLTf+U6+v11ptrG
 NHCyU0c+tco3ONLCuyOP8uYUSMl8cMpsPuhcOMjXUIznFXQqmaeouFzeEBO17nnaZP6plWpJIMT
 Lh2uYMESsV2zMhCd4CSLOD42FCQ0Xh+5Kw93sWvPzJ4st2tk/XZFAYDYlXeeiCX5hkqgEzdwQhW
 P6ahpIM3379XxmGzNrG4/DoIFlhTnSJrofvwadFE2K8pmhs4MaTbpZjv6M9X569aNn
X-Google-Smtp-Source: AGHT+IG/LJZM1o0EoVC+a8HWlUQZ2gdJYeLdf7LT9vn1Uayqf0+C/fMPyzYLrRVw6VpP/JueOgvi6g==
X-Received: by 2002:a05:600c:8b8a:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-47795418dcbmr161046525e9.16.1763500855153; 
 Tue, 18 Nov 2025 13:20:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17291sm34262337f8f.32.2025.11.18.13.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 13:20:54 -0800 (PST)
Message-ID: <e41075a7-52df-4a90-ab3b-421a0ed701ef@linaro.org>
Date: Tue, 18 Nov 2025 22:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only
 build
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251118200752.39950-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251118200752.39950-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 18/11/25 21:07, Bernhard Beschow wrote:
> Fixes make check failures on an aarch64 host:

when QEMU is configured using '--enable-kvm --disable-tcg':

>    qemu-system-aarch64: unknown type 'arm-gicv3'
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 0cdeb60f1f..7877506384 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -623,7 +623,7 @@ config FSL_IMX8MP_EVK
>       bool
>       default y
>       depends on AARCH64
> -    depends on TCG || KVM
> +    depends on TCG
>       select FSL_IMX8MP
>   
>   config ARM_SMMUV3


