Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C104C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN4x-0004bJ-DO; Sat, 02 Aug 2025 20:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN33-0002tR-4H
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:58:01 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN31-0007jP-Fa
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:58:00 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-301fb587dfeso1062725fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754182677; x=1754787477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cKEK/kE04Ik0XwVvN6TXPO+uWgbMVnMKI4k5LH4SCPw=;
 b=epHVBwarqMz/Zyo7JsF0gzhNbOrWvyZYQeWuA0W3LPuSSsp7NR0HE4V4KsNZtDShz4
 cs6m6ZoU73ZnfYbnwpOKa/YncLgRzmmrY/+onqjXHbRSX9lXPdzndhyq9vT2JQjN+IjH
 6re+HaZYzu57IaXP1C620KPdSpkFx2H572pp5IlWZNXDR0sjrI1BJpts8+QaXxdvyfq9
 2bZtazh3Ce3O06ha+2XO6SzH2CA9N2ltFhJwcKwVCmk/qEGxFrbqLziKybF+uXGIba3P
 gqNi2t9bPKVCf5cTVF0R2x8AVL05dXgkDRbmRR88zVIu0jXmXCWJv6eengBfVlsgkptX
 7NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754182677; x=1754787477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cKEK/kE04Ik0XwVvN6TXPO+uWgbMVnMKI4k5LH4SCPw=;
 b=opVG7Wc2LC2p+HG+pprQ8XU0d1a9fdVuq7OuWBmGzR8QqYjuMtKRgEE/Lay7586JAZ
 VfOO1kWw69kjTuQ3Rckcf5INuNOVcnREqREvwzt8dONXDR3AWNLHm13/gnr911Le3ZNi
 JYQYh7KtTnN0xnA2+r78Nak82j4aPw2XRL0pZ91AlEBFK8XgHb2zsRuB1zCvcWcTiSUU
 9j4vpASCCp+1fvvGsBTZtDf10EFh431/VFWTN+3vXibgkBarfLFpr1yrQX5SC4oeBawA
 KXuI2OJM/s+ayohs3X1JBgpN7qH43KF2NGnhponDY5w1jFb8RIsrMBNl6JNARCjrDWLk
 yEhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbVtG68+6NIKtBcETfpRaUcL+wfWJLOCWNZvaXJBmCk4P8xBkirxwyUkgE1+6YP3Mgb5x2MRVpx4cI@nongnu.org
X-Gm-Message-State: AOJu0YzE4kFlYqKTQIzAhExGfDcviZJfbk1t+HvyCq3MqyMDFQ2s3lcs
 hvlRuYDQYxijnH0umy65pToLZ/DsUh181giv4ZCImpXFrUMsHOSjYk+XJ0uODInUauInFsz/h3y
 9qgG2jCA=
X-Gm-Gg: ASbGncvfLaILjN2HAorGhku+3xDfQd7W75Zub1Re6xygnMuvL+unXkhmQHAukQ3n8nh
 yy1oIOqTbYRWqS7xoVXf/87FEhKdFe4PZvaIFyPk4JsX0lihDgUVD7DtERpa7Le1yWqBDEYwzIV
 0R9oFumUvsy51BhiTLl7BSKhO075WMpYrNtJQqKd5YQ4eD5b6UbLETQsyg6+u/gbo4JG99YyPf9
 +eDMo8uhCgh72VK/M2n+OBCM41zTbswynznDbat0r8jvja5YMoWjBieOr1UI1v3SN0RrTWVWGNM
 NSmSHYZGb1QjPoc4y+C/Y9CEqy9+2VZfwJh+XK4jSWFTgNXhHdkRdMno5QhEvDaka4aFGzKZ+Vq
 c1isE0Caj1GiJPvUAD8wO9CwXJnQgym1HvQrZxuFVsQKb31Xg5U8V70Fflsli4FZj
X-Google-Smtp-Source: AGHT+IGbflpv2/DBeapCKeZWk/NC73M0axzUzWZT1hl/12kVGBxxtFksedXRtJxLvMN97YQSjj+TSw==
X-Received: by 2002:a05:6870:c08f:b0:306:e3a8:a97b with SMTP id
 586e51a60fabf-30b678de3dfmr2523531fac.21.1754182677621; 
 Sat, 02 Aug 2025 17:57:57 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a717f0c9sm1803373fac.13.2025.08.02.17.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:57:57 -0700 (PDT)
Message-ID: <ca04f8f6-2735-464b-ad65-59d7487ec788@linaro.org>
Date: Sun, 3 Aug 2025 10:57:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-11-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> Windows Hypervisor Platform's vGIC doesn't support ITS.
> Deal with this by reporting to the user and not creating the ITS device.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 98a1c74c42..1c695c0642 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
>           return;
>       }
>   
> +    if (whpx_enabled() && vms->tcg_its) {
> +        /*
> +         * In the HVF case, inform the user that they can use the

Watch out for the cut-and-paste of HVF.

r~

