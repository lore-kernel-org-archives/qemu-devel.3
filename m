Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C03C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDSr-0001an-FT; Mon, 31 Mar 2025 07:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDSp-0001Zo-9E
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:37:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDSn-0007L7-KW
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:37:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so25932165e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743421076; x=1744025876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URxh9O5s6QWqgIB87zWOJQPCBxWsmzRFdOKzUerBOf8=;
 b=aKiwLSAuTWxVlBimHR/wuObhtto9jUV+urgOHtDm4G8ZHOLm17Xfda0HhlTYszhnxj
 8A/ndbaCzjeUPSAhUcRj2HZ9QbO88LB2TZtHQuMiJnLk/ffG7B9SlA02TmFEaaBNKwig
 qoEfaQ/isdUNKJYaWpKMoxT3XszGefpLvBwq7TFs/jvYuDEthiZ9jSC6qD66csUac0VT
 t16eJaOq+hOBLrJSYv2MQf98ONZNJ3Ju6t4cPs5jfQIY3gB5NaolPiwYYRTZChZpUBdm
 7Y9JxEEbJSRK4sPhrPkYKW67SBOp9K2ZSH+ALky5Ntv+6fqMgu5keHev9O7gjYVNZMqI
 ifSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743421076; x=1744025876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URxh9O5s6QWqgIB87zWOJQPCBxWsmzRFdOKzUerBOf8=;
 b=O3AC/ZCXP7OHehHhlrJaMNzj48KWoEf8RfgSnHWg7hPhv9ozAPIPv2yPbjzYjqWkBQ
 iLipBWEfrITwrf6qHOw4DE+j2RPcz5JBJd3+3hSHR0HZ6DQhHiRDfMfBHL+XvGT5mkk+
 m8J/p+H6UKvvqMPy+qMgxLjv4XbXctSdRb+orZIIwzjLkIPLdijBBRT8JpC6o3Q85T62
 ucGshHDihZdTiftaijvHGy6Oyn6WHbyE6u+qLc9qVtoP0P8SkSkQOogqh0eUNgyC2g1L
 oc1JhxEY2tlBnJp6nj01LAn/fY5bWI92MqOr/pPyZjMASx1yrA40qqylD9VqgCh2e0Vz
 iu6Q==
X-Gm-Message-State: AOJu0YyHnm929Rozx1S0NEjLix7rDXkn1816oqU1FLLTHSMeWkIUwCPz
 PgA1fSd83kAfDOz7nA6A3F8sJsNcvYhVigRwtckNFUWTxB/0aqpL2t8IM90+T7k=
X-Gm-Gg: ASbGncsRB5sAyV+RERdhpSGABfKjMgKX+ayZ3UvqnRgPt2ezbUwPrfbZ5T/hEEwvRJF
 hLAT4M2HPlE4PmW5ml8WPMI5GHD0DQIT2LRuE5Rr7qySeIf2h07LDYlzNaZQQoWzPCQr7TImrwN
 iB81u5UwlpJUdP9cNxosI9bkV1onBvEgZE0BunoB9ifLeK409NBO/brWA5BRhEFwphkTd3P5upi
 Rc/8AVjk484eFRqWKokA7omKVY4TmlAavqreR81rZN0p8sncuRD1AmzeEcAlNgaCrxZJJ8EfjLq
 xCrbPzvE8xjboiMeFtayrAO1UXGRe+wv9W87zu6cE5A8Jp8W+HUH/gwNyK+HqsVUodxPJ8Sveni
 jRweD+Lr3RXLS
X-Google-Smtp-Source: AGHT+IHmUp/PUQu8lzZ4lAEin72dCkK3GNsdtrHDaq3Z9T8J4dFcf1OAqueXY43ySWBKMSCRiozuAA==
X-Received: by 2002:a05:600c:378c:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43d910185a9mr97657095e9.2.1743421075954; 
 Mon, 31 Mar 2025 04:37:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662c11sm11200491f8f.31.2025.03.31.04.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:37:55 -0700 (PDT)
Message-ID: <805a75a4-07c9-41f2-9456-d74b414ddf89@linaro.org>
Date: Mon, 31 Mar 2025 13:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250330211012.2932258-1-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250330211012.2932258-1-adityag@linux.ibm.com>
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

On 30/3/25 23:10, Aditya Gupta wrote:
> Power8E and Power8NVL variants are not of much use in QEMU now, and not
> being maintained either.
> 
> Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
> 
> Deprecate the 8E and 8NVL variants.
> 
> After deprecation, QEMU will print a warning like below when the
> CPU/Chips are used:
> 
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
> 
> Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
> --cpu ?':
> 
>      $ ./build/qemu-system-ppc64 --cpu help
>        ...
>        power8e_v2.1     PVR 004b0201 (deprecated)
>        power8e          (alias for power8e_v2.1)
>        power8nvl_v1.0   PVR 004c0100 (deprecated)
>        power8nvl        (alias for power8nvl_v1.0)
>        power8_v2.0      PVR 004d0200
>        power8           (alias for power8_v2.0)
>        power9_v2.0      PVR 004e1200
>        power9_v2.2      PVR 004e1202
>        ...
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

> ---
>   docs/about/deprecated.rst |  9 +++++++++
>   target/ppc/cpu-models.c   | 20 +++++++++++++++-----
>   target/ppc/cpu_init.c     |  7 ++++++-
>   3 files changed, 30 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


