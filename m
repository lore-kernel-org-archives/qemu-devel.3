Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98C5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxHz-00007f-BT; Tue, 11 Mar 2025 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trxHx-0008VA-Lg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:56:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trxHr-0005qS-1C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:56:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39127512371so2959382f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741690596; x=1742295396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YE+ZDF6UAZoVlD98S7SWWUuJGHiCd8738dOU83mR/Cc=;
 b=M6CITMOH4kB5hs0TI+87+hNtEQjaJVAslLQ2qDgKGMNSBH0QW7MPHaznC7Qo2Ds+Yl
 pthpwpStzJ/Ju0iPbWCySs+l4OPvd+jcnK9Ftx97zwGahSHHhVeo33nPhmVUB5reOdp0
 H9O61nScAAGmDKp0XCDdm3E8R/4JDqhbe9OeWfAt/GtBK0WG1I9KEckafAyETk/AKvGL
 wXsOA/RRusl6hJc77Tc4pFhy9W+dESnEG5QyzelXwZEj2GW3xagmHCj33pMlmd3ueFza
 IK6nGKRiDKcjOE//95CIsgBbQ1c9euZP0RAp4EBkTQ/dK9YEdvjEIxtDXYhxGFzLn5ew
 3vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741690596; x=1742295396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YE+ZDF6UAZoVlD98S7SWWUuJGHiCd8738dOU83mR/Cc=;
 b=CoMI/E/rqaccwHuN9i4KeQGPfuxERkexVPjJc5CU8/ny6PVlhFn6A/6EpxaIZORgcL
 WXFLAxpTF9QxM5bTg66WNENz8+GlwSmvJRrsOebOrlLk0YaRhpPRnNFaQ1Z8dREUJggW
 DVnH6sX/dwU8SJxgE2I0YsPhaK439YHFAzzpMdDmSQcocx015Bvtqgh+OjfO+C1PIvcs
 QMY/Pf9kJG6PFISlfEAjrcSseU9e/udXrhNpngJ5XM7/dxa+ro+SDqlgPCjwx6FXNl9P
 wo3IlrC+DSZSjdzuzI/Hf+2JA0t+vXXNV85VvY4Yh/9yyV/axLV1PPXY1XT+JlwxKdKz
 dWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMeu9fIeeiGbQiboJw++eAizQhun5VzazretLLVELruDJsvZMkqi8Y345pIWAF47Sqw6/oXjHGUr/N@nongnu.org
X-Gm-Message-State: AOJu0Yw8dFhcWFqFcH76hu+RaJCgWArPRfzA9AT/ma6uV+5+UbDRcgsY
 PzTf7CgFOenuKOm+hBvo67K/7lxDOZoh6MqLHOTQxwjOTZ9t6OD6kb2ALhV+krI=
X-Gm-Gg: ASbGnct9jajydgLfVbghEjFJhFz3E9V2u4bH7HPhAvJsdcjY3BHhF/kdDM2msEYpJ91
 /FQhXf4bac69N5bxSXMBXQUpcnGPXA7mGU0UrdfrTeYrtiToMkibkI1mxLSJOS480sM+N6m9a27
 7V25cs4EUoil4QPddrk02I4DBlUXJnPb5nxqhbIIdzSO/+t1d9f5pTaXrSMiSlUOCVNswsI1IkK
 fcMJv2uv6R2M1egxTmkoqjYKoS39sg9Mci4eikFjKEF1hUx9VQCnbfvoTNV0g1loFDEhGgDnV06
 9gr8t6FH77YiurBJHokLRFeFvq9s5S1gI1bCX0uL4pHm4LYy2PWaNExPIXRGDTrQwBpGP6YJ/ou
 Gzd3PKkymcaRp
X-Google-Smtp-Source: AGHT+IEfFQo5yqJYnsT3jVMpIM3e8b6Do1ohtdVtCSLPVaZxpMT8QXqqbhyW7LqUP30GRU6N1HSDwA==
X-Received: by 2002:a05:6000:156a:b0:391:3fd2:610f with SMTP id
 ffacd0b85a97d-392641bcbfcmr4022361f8f.13.1741690595884; 
 Tue, 11 Mar 2025 03:56:35 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1030cfsm18089026f8f.90.2025.03.11.03.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 03:56:35 -0700 (PDT)
Message-ID: <29acae00-8bf7-4347-b803-d86caee26e76@linaro.org>
Date: Tue, 11 Mar 2025 11:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] hw/qdev-properties-system: Include missing
 'qapi/qapi-types-common.h'
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250310000620.70120-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

+Markus

On 10/3/25 01:06, Philippe Mathieu-Daudé wrote:
> DEFINE_PROP_ENDIAN_NODEFAULT() macro uses ENDIAN_MODE_UNSPECIFIED
> which is defined in "qapi/qapi-types-common.h".
> 
> Fixes: 4ec96630f93 ("hw/qdev-properties-system: Introduce EndianMode QAPI enum")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/qdev-properties-system.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index b921392c525..49a3825eb46 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -1,6 +1,7 @@
>   #ifndef HW_QDEV_PROPERTIES_SYSTEM_H
>   #define HW_QDEV_PROPERTIES_SYSTEM_H
>   
> +#include "qapi/qapi-types-common.h"
>   #include "hw/qdev-properties.h"
>   
>   bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,


