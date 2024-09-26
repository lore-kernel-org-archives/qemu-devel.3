Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F8ACDE006
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 14:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stpA7-0003JU-UL; Thu, 26 Sep 2024 10:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stpA7-0003J1-6c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 10:08:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stpA5-000445-Aw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 10:08:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20afdad26f5so12649895ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727359683; x=1727964483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c8an33t8WnW3OG/S0ndXCh81yZ3ULbThzuC8jmxCoNo=;
 b=csC0LTW41mP7PYSVxpbv8CnPZNC8zbcLE++9YoXRMQcadWo7H2akimHKMcEWk0BGiS
 idr5Ba0p0YowKNv6qQRFaQ8LShO23rOVeBuKt6YbUTr2wEwEIzfCdXPMzuoD4HjZPDlt
 SjXPakpJSqNObdQQASMxkGEBuD+jIhy9le7B/jNNqs8J/DDavfm5O+GLub5WUiyp54Mq
 XFoCkfCfY3Iw9l/iTD9nJrZ4JAWpeCzB/fZ0ISBzjsueKZy5F6P2+vcLxxm924zHpWsN
 GTm7HXGQPQErfTigM/VL6MB2BLRxbYZ+BQH6cDfjebJKsNpP1/qkIEk0ptzWTxHr9mQu
 7E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727359683; x=1727964483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8an33t8WnW3OG/S0ndXCh81yZ3ULbThzuC8jmxCoNo=;
 b=uBAp/WDMmmKToEJS1v5UjpCzNbaB2AKpDWVXd+p/QWF/GtKxyB+5zW+KX+3Hl6TroU
 pW1+eIXQceYzDtFpV/ofNABZJtHc+IPhF+bbfxS4Dgs+8PnroHAjZJbZiq4Shd5RZK2Y
 8y69KkRrLRKAw8qN+1B1YACZFAjgi0EwRh6nJ5zWJEO+Vgh6x/ThmtSV+cZugPjUAh/z
 TNRbUbN4TdpsL7VCeN+5ZV1GybSr3h3jtK6zl3o8Ss3L6be9Sy5SpVVwDh3AKN7axWly
 o2liUvan1cunasp1C/pzEnitcLSMbhN7b5lFytMJDH7wgdLfOXWKve6K/uPhHEOJaoCx
 AB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+B/RddYPPrwsNK5NytG3iyzbDKlZmE5akpDQmX0RcO6YonSYfbKuoZ6fTxFLj1P7VP5YS3lg9DAQG@nongnu.org
X-Gm-Message-State: AOJu0Yz4QDjSq/Ka9z+Hf0EPZpsfB9o1R4h5I0Bt5jtuwg9ys02LUYqi
 4vQkSWNGCoEpWBrXD3R/rNCcg8OhKcRt3GIZqBeQcFaF87ToygQNLtArMNCNCsaIMCoX9TyliJA
 j
X-Google-Smtp-Source: AGHT+IFml6Du7u/xK2UBPkEtpvB69McRY9QnJ6H9nngdASH2B0Rzm5OGcNeO/XNjRg9MRqMU/j6UEQ==
X-Received: by 2002:a17:902:f651:b0:206:cfb3:8c81 with SMTP id
 d9443c01a7336-20afc5f10b7mr101536205ad.55.1727359683153; 
 Thu, 26 Sep 2024 07:08:03 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20af1818fdbsm39018885ad.186.2024.09.26.07.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 07:08:02 -0700 (PDT)
Message-ID: <a775ef63-749f-4974-9246-fce932e9e3ea@ventanamicro.com>
Date: Thu, 26 Sep 2024 11:07:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of e500 machines
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <20240926075948.2343-1-shentey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240926075948.2343-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 9/26/24 4:59 AM, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffacd60f40..0a191a03db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1430,8 +1430,9 @@ F: hw/pci-host/ppc4xx_pci.c
>   F: tests/functional/test_ppc_bamboo.py
>   
>   e500
> +M: Bernhard Beschow <shentey@gmail.com>
>   L: qemu-ppc@nongnu.org
> -S: Orphan
> +S: Odd Fixes
>   F: hw/ppc/e500*
>   F: hw/ppc/ppce500_spin.c
>   F: hw/gpio/mpc8xxx.c
> @@ -1446,8 +1447,9 @@ F: include/hw/ppc/openpic_kvm.h
>   F: docs/system/ppc/ppce500.rst
>   
>   mpc8544ds
> +M: Bernhard Beschow <shentey@gmail.com>
>   L: qemu-ppc@nongnu.org
> -S: Orphan
> +S: Odd Fixes
>   F: hw/ppc/mpc8544ds.c
>   F: hw/ppc/mpc8544_guts.c
>   F: tests/functional/test_ppc_mpc8544ds.py

