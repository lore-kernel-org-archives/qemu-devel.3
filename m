Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A4AFD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM0H-0003pD-HV; Wed, 25 Feb 2026 16:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvM0G-0003ou-G5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:01:04 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvM0E-0006TE-QX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:01:04 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so110206b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053261; x=1772658061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8bZpsD4C/f1+7AkSEN+2MjbOt3liQMWo50+H+E72uVQ=;
 b=MiKB9IUbhyxtMBjH0BTsg6EGVZ/T5DKjYdMIwFD+WI4YLU7GZmUAjRhgL1D4pPTjaI
 4wFuI9A3mdH4ZaCwsYa1UPoV0Fazxkc4MPWuC/LqA5ueumw0M2ikqZYNB4PS+kuQ+3GQ
 JlYivl+6FPOqy772hVLEbnR/rffCV1qA4FWLFwYfdfJRHewTxrRYMduW6wurBU0f1CDY
 jOKkvievAPlBNOdv22vDSJ+fX7TC+4387z3kQRePqeLhDSr4UvQHKYRIS/8DbpLe7877
 AGjZx1N9U4u4SYCnPMCfwwZHIcGxrKJpKQiYsKg2WGpBmaFTXLdlrwDVYrQwqFnoM3Ve
 9S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053261; x=1772658061;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8bZpsD4C/f1+7AkSEN+2MjbOt3liQMWo50+H+E72uVQ=;
 b=CYbKQKR66a97Y7oKzQwSwplPyI4ejhFjpMo9qKD+nWVGogySRW/wjEIwF8A62qFKsC
 iUOatc4OoU627vjruAIzUsNFaMQmAASeQ6aAdwfPlRVde26xCx1pHEyXXtOc1hWREDEb
 EdR9TI5PKl2WY+sh/xT6HduhslSLjqNAmDes9WlgFWg2Md8snHG4X6m8ZOJjbxXfxOi/
 TW7REaR0WRV7QlomCMcGczj464WHUUCV+Hby6kNl77V/6gJmQnmv0cOFlWwRytzPjzxB
 5an1ujrXljHR9c7OEYi1dESjoLr2iCtHTEHvNr0mriawMKaH1EV1xFBGKvaUO+GWgbV4
 zmuQ==
X-Gm-Message-State: AOJu0Yw5bzDHFb2qtqz+Yg/2nD9Wm6HIaGnNanVSLS8823KBk+zmC/yt
 JtL9GX/EXtTUNrkeRlA8MXBQxupr3A4r4k6Dz3XLmfau10gJw1acPJEtnt/yB2kxkgE=
X-Gm-Gg: ATEYQzyguyIa5u6oe9egFRXWhX2UaM4kI+lp9kjrU2fayhYsNC7aMgVSJOGnLgF09Xz
 dNL1y0lhqw0g2Ykq6YkBKd2+lmTTRMtjmEwbVjwo+K6oC8B76pSzYcqJosyT2yFHtxbaJyZpdXy
 5nsm4C59MTir2VAFN8Jgkx+ABJhJ6/ZRPHMv6vk1djQMa47cHi8SOm7aGH82EFaSSRBQR+tYvdq
 l7mC02LniGy1HAnv66DAvhuxAVHSf9gbKkMerjAcu/QixeO1GbRWgcvRRVjF/wChEflKeaM1kZO
 KeDhGr7zYWM0/ZpBBeJ2N15FVIB1LVoeGW2rCMghGvYb18/miPY3xctMu9EisazcZqY4w3dUo9v
 D9p+/4OF6hg7+29fFIbnR1Pqw6UQ3O4A/GwrbFkouzXT5ig8GS6sBQjJYyLCE2UonzOuq/5/biS
 aycdKjrviDKEIQErXg5LE7mEwdbFv4OsRegcLvkmcI+JuQHehPMZRhFYeqGNYVHojDXtfvcEHa2
 raPPaM=
X-Received: by 2002:a05:6a00:994:b0:7fb:cf05:93cb with SMTP id
 d2e1a72fcca58-826da8da4dbmr14107717b3a.1.1772053260974; 
 Wed, 25 Feb 2026 13:01:00 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4c9b5sm151260b3a.9.2026.02.25.13.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:01:00 -0800 (PST)
Message-ID: <ff593a94-78d0-445a-93ad-2fb09f418448@linaro.org>
Date: Wed, 25 Feb 2026 13:01:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 10/31] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x443.google.com
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

On 2/21/26 2:14 AM, Tao Tang wrote:
> Adapt the configuration cache to support multiple security states by
> introducing a composite key, SMMUConfigKey. This key combines the
> SMMUDevice with SEC_SID, preventing aliasing between Secure and
> Non-secure configurations for the same device, also the future Realm and
> Root configurations.
> 
> The cache lookup, insertion, and invalidation mechanisms are updated
> to use this new keying infrastructure. This change is critical for
> ensuring correct translation when a device is active in more than one
> security world.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
> ---
>   hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
>   hw/arm/smmuv3.c              | 13 +++++++----
>   include/hw/arm/smmu-common.h |  7 ++++++
>   3 files changed, 58 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

