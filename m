Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8288DCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtMe-0006AC-GR; Fri, 15 May 2026 10:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtLp-0005ju-Cd
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtLn-0005wH-I1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:17:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so109135155e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854631; x=1779459431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZAy0iPWtEK+N/8YGdj5CCpPG9mfI8mA7mgKUeHvll0=;
 b=vNM4To/wbeYRfUuhmRjwrk9tihavp8OdqeYbw+POd8CdQpJjuTLx/3TQDqerlbyAIz
 OsysICrfVGOvPNKpd823O6/fWOuW6Jho8sX8eP33NlaZRywkqXxr3REpLiKo3uy6i77z
 ExGc4ZzHlZfQMmjTlkoh7v8r0ktCyNa4YXT9Zh/dVyMNMXGT81eWK79xxUv/LmjAuZa3
 ncT//8AjWUqB/0qOsRlQYt4l+Rgnk2xa93UbhDSKT0UXtgl5gKtS7L4beHzvS5HHNI4O
 8NxR4zotIzh5f9nPx7pboLmi01DkOK7Zis2rDA+nkj7dbXLr4MrKb+lao4D62GhO2rmd
 amRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854631; x=1779459431;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZAy0iPWtEK+N/8YGdj5CCpPG9mfI8mA7mgKUeHvll0=;
 b=DFwJtotWgJdgYd7BYKr189mc5p/LCJi9IAeqw/q/t/k711QF8yIy6S+WY77kfYRNTi
 7s4YazPO+bKX7okB/FzS6ScNP1pcTEVEHZTUdHhriiDDm5KZGOt58XN3bq5DAQujZuZE
 XUUCb2PcoyA2GyYV38awUxcfyNq/U891XX9MGh0/hQsIYt1557biJe28sziek+aGM2+e
 M8ymboW5b3O1pArxCq9Ghu8bQ7O+mm/Zr3S4S/wzpw7R7REgnEwZSpVbauJZ/tMomIvV
 rYDBF441BPrCfXI477azTkeMLWphlrdGcA95sD66S9HFBudmZUgAmnU8tkC/eFQjNmKG
 yLFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KCG+df2RWZuV12lPbF3rVd/37s1l/i151Aq5R9fjRzPGgyLQp97d62aOiwSwYnQQTxw0tgX2SNIZJ@nongnu.org
X-Gm-Message-State: AOJu0YzjpNKZbml44L/OHqNjsjgO5p2N+gLCLa58SdMj7z9SW6tP1TCI
 AggwUKvpYmpjEmRfPvuIfEdXnt7W/T7qiHZgd0FFLGHrfExwqsD7fScNifTfGvAcdVtgXe6mMUj
 FbYwzhBY=
X-Gm-Gg: Acq92OGLhqk8Yfodpt5v+F3Pq/7WgWTrcpeR6+00RTVHLB8ZWcZNw6Cf5SE+ngCYSqC
 BSqhqDkUlOsmO3gaBswSCEtavMSjiSJqmp9REk3sh6JcnF7k3T8Zli1aqI4yTHXf3oJqNX67nRX
 JdKF2MICxiybSfT1s+nD11gz7eSQQq7iduntUySd3UrOW9P8fxhy9LLRIudiW0kTVUoDU5C0lvC
 pcro2NsFhNWigSn/00PVwqWNDXT4H6mV3C7g+DM60pL9k7pmzEiwTB2WDc6lsfJTTKbt8w3WYJ2
 HIssdXsUcsaMv508J9JQ8eC8ctNQLd5q6qOvTWez/Ohpebi/n5Af8/AXA/oZlvbdztwvPBrejfC
 VdaSaPNdB9o72NlVz0Yh71UoyEGkuC5nI/CjqCDqAbo/mttfr8Monu3kPeIIDOCac4/xCF+vLAz
 vwfHyiuS2IDpcZSbwtaHQhDIp+prmBj3Zuq2yA82VM0uSz8cc3TbGiW3Vf8VU8wfmHpw==
X-Received: by 2002:a05:600c:848c:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-48fe60e52c1mr64203245e9.4.1778854631523; 
 Fri, 15 May 2026 07:17:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe66544sm14680525e9.23.2026.05.15.07.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:17:10 -0700 (PDT)
Message-ID: <ecc4b7e9-aa28-4951-82e0-5eaa6e98e642@linaro.org>
Date: Fri, 15 May 2026 16:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Set debug in attrs in translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260515131245.366240-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515131245.366240-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 15/5/26 15:12, Peter Maydell wrote:
> The translate_for_debug method is supposed to return attributes
> that include the debug flag being set. We forgot this when
> implementing the method for Arm.
> 
> Fixes: abefca8e7f957 ("target/arm: Implement translate_for_debug")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8706dd59dd..0693d2867e 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3961,6 +3961,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
>           /* translation succeeded */
>           result->physaddr = res.f.phys_addr;
>           result->attrs = res.f.attrs;
> +        result->attrs.debug = 1;

I missed that because thought we'd set it on success in
cpu_translate_for_debug(), but we only do it for the fallback
case. Shouldn't it be safer to set it there instead?

Otherwise I'd expect the bit set in arm_cpu_translate_for_debug().
not in arm_cpu_get_phys_addr(). WDYT?

>           result->lg_page_size = res.f.lg_page_size;
>       }
>       return fault;


