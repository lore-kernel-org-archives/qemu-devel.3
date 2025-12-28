Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCDE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZnsm-0005Kk-HO; Sun, 28 Dec 2025 05:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnsi-0005KP-SP
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:20:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnsg-0004XB-Ef
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:20:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1339640f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766917207; x=1767522007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xoB1Tk9mhOkJCBFi3HNkXDKt8ra40NHnDZKM6ldxTSA=;
 b=MOoj79bbKsa6HngbS40x/SeYJ6xX6j/MAhKcBiA+MOvcFXZwoLRNmP342wN4Tc/ZdA
 XzVjnyxf9afAmnUsJlhpTHI5kqxvMtiDn1DcWPPIPHsB+PlBGfkbSam3hdqeZlp3X/81
 tSLqoM2K2HZJnGITByPexxUnX/z4ZFKNiSNMZs7TRrXvtRU22eVP1fVnjqG689T7xpqw
 oY3wB6+ZRK4UfDORjm3a14iSSDWugjH42zu2RGID/7fJmGqaIZ2Fnq5c0kGxpDb7A1RY
 BkiHwxsWiyXF4J4tiC+k6kkh0Kyfy6X8+xv7+3twdO41JM78VEYQZLJmHMWokBhan1Xm
 9wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766917207; x=1767522007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xoB1Tk9mhOkJCBFi3HNkXDKt8ra40NHnDZKM6ldxTSA=;
 b=gryWGPYcu7QfWnb1xU0rj5iE8GGzRJMdIDL3RZKbKsIX4jfUpsLAuVgTymUhXYVk/2
 vPHTKbxDnxyfb9BPKnaVs39LkvRv5jsQgI0XT2uyXM5gdTFP93uWbx8xyIbazHP5pSTV
 NggRTn/7JlobDdTvgPiSH8JE5BSHesx5vsUBmrEcwMA8c1OKXmuHwZiIlGcphtOAf0f0
 /EB/tZyg6YUr3lT/3ec2xGmJxl5vlOEXOb1LfAo5kgALLmsSf/lQYeAxwv0w3xhTkOmh
 gY9MSHb0B/VEslQ8mjompJr9UZAGm7cMCd0TgftDFA7syLqlAPIp7AoH2eAgKBa1HYjs
 bUjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRDcvooiFdi975BX6u96T4HluJtz1q3cbAI4jOw4+M2X7uyqE0cjRxEFuWZAY2ZYoNaB0SHifvs0dL@nongnu.org
X-Gm-Message-State: AOJu0YzOnpqqROx+cjPL55Uj62E6+Qn+7Md682rk5HXJ7e7DR4hF8Vi9
 A4SVhakFgnu36bdATMjWwwIFvN0Y+kNE/odklt1mI+qaNNs1zYGLKXptataQB+VXjdo=
X-Gm-Gg: AY/fxX40E+NJuET25Fa0l9yH+h/xwekjdKMF+ASre25V2qxZGitnXty2D7eQcLbeBnW
 cUZIcf0fSjYfb2PlXvnbqKQzZ8LAcbDMK5ObFxXa8OaoCDGsNZGuLbLVmZ65yjg5WHBrdHID3YX
 R2zLro3Mogq8uLBDVv969VcBHM6Jt+xEIIVFfOSzuSw5JTaqmdnabbbiHnOOuldrz5YeSVH/z/k
 9qWwd9ogsoaIGnXTPsTZ3R4XeypQIq4nO6827HQtEKcJPsdyr0ykeomZUGKyWYP0XFw2PJzIPXz
 WE2AQYBOTDn81ozDn8bxmiBELL7N9boQjYLDpMYWcxKG/pecMMPnPXoeySUvBYbFwrNoQTQOKhm
 OJ//BWMonru6Loq8tqbP/CbmR5mfPrS76QO7ErWO82etpm49RKQRuZoPD3ciTjcr5CyB4uypqiD
 4jOf5DsKH8Jf9SDaJdVdhdJ91dDzU+d+MKP9+xGj2RojMQDeEcHxEyr00sFqBuIw==
X-Google-Smtp-Source: AGHT+IGOFQn8LpNx4yilxAv/Hi8uKyU2933ZQZRlSfmGK0VOdMEtEjciqRMjqPOxbB12P/TTZrluow==
X-Received: by 2002:a05:6000:230c:b0:430:fd9f:e705 with SMTP id
 ffacd0b85a97d-4324e4d3e9dmr37555492f8f.27.1766917206643; 
 Sun, 28 Dec 2025 02:20:06 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325d10cc48sm46332218f8f.16.2025.12.28.02.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 02:20:06 -0800 (PST)
Message-ID: <50d860e6-beaf-4a0a-9439-ac6c7e06aa09@linaro.org>
Date: Sun, 28 Dec 2025 11:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change email and status of TriCore
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: kbastian@rumtueddeln.de
References: <20251227132135.4886-1-kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227132135.4886-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 27/12/25 14:21, Bastian Koppelmann wrote:
> I'm no longer employed at the university of Paderborn. This also means
> my time available for QEMU has reduced significantly. Thus, I'm dropping
> the status to odd fixes.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
> I'm losing access to my kbastian@mail.uni-paderborn.de account with the 01st of
> January 2026. So I'm kind of late. Who takes this patch into their tree? Do I have
> to send a PR myself?

Thanks for your work with TriCore!

Patch queued.

> 
> Thanks,
> Bastian
> 
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..fc9a67c410 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -419,8 +419,8 @@ F: include/hw/xtensa/xtensa-isa.h
>   F: configs/devices/xtensa*/default.mak
>   
>   TriCore TCG CPUs
> -M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> -S: Maintained
> +M: Bastian Koppelmann <kbastian@rumtueddeln.de>
> +S: Odd Fixes
>   F: target/tricore/
>   F: hw/tricore/
>   F: include/hw/tricore/


