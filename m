Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE08ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniai-0007sO-MZ; Mon, 09 Sep 2024 13:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniaf-0007Tz-BO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:54:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniab-000078-GA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:54:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so311828966b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904448; x=1726509248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IgttfWwyHsrLhV8Bk1VadSvyVR9BDE041SzLU+ej6yg=;
 b=FoXYerHQjxoGsM+Krab19htU8AKs3lo5gDVEiJhAfJ28lRIUslU4r0ZGp6KgTq0k+A
 8XpdcN5xkzOy5cZczHObbtodmfRVBulIGjkWCAhuZrlWQgwJfyofU8RHKxZhFwqqySZR
 1o/R0uuQxWHOePZRO9yhS4zM1vqGb1WUEVYol9isz0/afC1S5LYGIw1ka06uw6T/iC8q
 NgyPqUcAEkvbrkVpL3+CIICDAI+0TtpdkhrMn/aqKgpkZbnQrpq4fCoPfiXD3dJfDxyf
 YcJv7Z41WQQvdhUucsmWlemdNoqVqaC+5dPCDIkLnBzEnoB0QfEIbw/PGKFc29DYSz2F
 lY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904448; x=1726509248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgttfWwyHsrLhV8Bk1VadSvyVR9BDE041SzLU+ej6yg=;
 b=jdZEJGXItWeQ2LDp5UepmPKFv2ehhhWkincCQrln60FC3YBhdBdktC8Zs3GJVvObms
 0aBQISGoxzTTvjSfA6CIK5UOmn6O42usFvulJaWwPSntbQydFABgonWGgT4z98lypBhJ
 F23rcXjC0AyJ2u9JYesYJxL/4PuAgdVkkznFT/B/FIJolzMbgtz77aMt7KzWmwmXoPLx
 2pinK82HRTzvvWjFdc2+uqa1qnxuusxIUB0auVaNOC83mWez34WOMusdyeDJ0mrQ9fwz
 Nr3dDk4Q6oxhHpv3tDIoTtFoZSmjAdBZQeach/1/sFMoj9GUc4wDt8CYqm09AZXyJHBC
 u4DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE9dZbam1Jfd3LQQUa3+7/oBiX59tTz9LhnbadLUhKDV8DJlnhiRZYzB6UwH1MLUm2NTlmKlAjAYyY@nongnu.org
X-Gm-Message-State: AOJu0Yys4WjuS5PBzB65O7wuq5OD2YJNs04sgA+MMeZ6Ub0L8qEBdkTV
 JVjD2To+MWD6Ogoas9PfLfKP2PU/nNlshVAgEeZdCvZK5W95+4RcTyELzmSvWeA=
X-Google-Smtp-Source: AGHT+IFyZYv72veZOPjNm2TpBZeGQrsbUU0fzByt90Y788rxzNFjBKEY2YE2t/Bt8GT8BwdgpV12Iw==
X-Received: by 2002:a17:907:3da1:b0:a8d:3338:a48c with SMTP id
 a640c23a62f3a-a8d3338b6f2mr581275066b.7.1725904448058; 
 Mon, 09 Sep 2024 10:54:08 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25831827sm368292066b.20.2024.09.09.10.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:54:07 -0700 (PDT)
Message-ID: <42b4489c-61df-4fb1-a7a5-4a0a00398b24@linaro.org>
Date: Mon, 9 Sep 2024 19:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 43/53] hw/misc: Remove omap_gpmc
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-44-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-44-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The omap_gpmc device is only in OMAP2, which we are removing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  11 -
>   hw/misc/omap_gpmc.c   | 898 ------------------------------------------
>   hw/misc/meson.build   |   1 -
>   3 files changed, 910 deletions(-)
>   delete mode 100644 hw/misc/omap_gpmc.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

