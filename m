Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01887D6554E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 19:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0nn-0000aB-GT; Tue, 26 Nov 2024 14:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0ne-0000Zm-47
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:00:38 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0nZ-0002an-6w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:00:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21260209c68so513585ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732647631; x=1733252431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2+dndJ0t3VSQhAZJRnWUFG6Waw3jVTx3nmo8KHY8G4=;
 b=jSudjasYY0kykqB2OslEhwwERT7bmQiCJhzY1uqPI+Qo3Gei6eD5tNvJnOd+kJYxQj
 R4p6HeMUTWWcuMRX9zppB5JmB5T6KlpYHFk+SB0b3NphuSIjdJTeA9gkojhlOdG+DyQT
 ycTR3v7aRUWO7fzUiyaFWAD8qbHu5VFZ1Y9uxzCHBbs/gtJlcvWonneFYvXuvQPMDXdt
 kLJscvviBCYKeU5zk5h8DA8uc1RxZN39VpYw2NX4bu5oo1WhsbGV5yqI6JTirjICdz4b
 TItwxKXIBQezrlwvpx7dvDaXwR2pTMTZRcU7KA1q61qVF62iNEmIVh7OUZ5r8Z6HBarU
 IquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732647631; x=1733252431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2+dndJ0t3VSQhAZJRnWUFG6Waw3jVTx3nmo8KHY8G4=;
 b=NBgy+mxe8DQNp9Ko4iqePUUVhyLdge9KGMWxiBD0q7Xtchu0CA3bTWJqI4qOXwEAab
 W9aNaOg1khYc1jxxiqWPriac8gpvYWr69kufsMNOXCpSteOWi8yTZq0sXfpBQ9/TOT6G
 eypvv7ZadzlHaVEsFUBwB+Gx7JcLbM8oqOMV9Jl0Ur2mqiPpdOK17ukfK3HCVLB4KUh/
 RfjjY9jrES5XAut3FtLuj4WwNLYuM37ToGfmyGAgrCdVxX/BQCxeND9d55qzwyNR3IyD
 6166VUrQ80H678tL42DNckHQSV5c8tjgcR+Hw8Qdr2UQIEEk4uXydmpJuz0qGOcixce9
 sjxA==
X-Gm-Message-State: AOJu0YwohjRlblLjYadOfolmWtwnavtbVGxZV6NCGpK05p7DeXoaERNc
 VnTXHuTzozkMFJgnfZ3PwPGFPOyXpbM208SnNjoU6HZ9VbwU9GYMfdwdu/+OiVelliKS4u3x0aL
 aAbM=
X-Gm-Gg: ASbGnctfQFgBrprbcgdUjN7f2bc/IgGhYYd83T3cfp1WGBDCU2Sb0vyY1ahP1G82RyY
 ESUuL3xqgj7G2YCV8H4lCHqZddazKH3WBLzsYK7J7vfqCQWiqcNAzP4aTj4gfyG138I2LFqTbYE
 XCRE1BKrMCKpogd1ykZsGb/6Yls9NOKO8q+aNl2q2FBg7Fe4nPoEix5mPXbwOytMSP/8qgLHLNZ
 Qt4YWwkuU+vJDFzyZM6ii0ONCJhsPXMsxUp0cl012oBRYoDfhWBa84nCNOgWturLiwbgiK6edR4
 Gs7NYI3QkiAneg0b73gyWw==
X-Google-Smtp-Source: AGHT+IEy/9Z2dNSS2e1vxHCFDpvC+hzGUsVHx5n1dcg5rnZ8rxRNyXlFQ2AOzoD6oxxUQqlb7XKgjw==
X-Received: by 2002:a17:902:d2c9:b0:20c:d71d:69c5 with SMTP id
 d9443c01a7336-21500f410bfmr5353595ad.4.1732647630869; 
 Tue, 26 Nov 2024 11:00:30 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc22a4asm88178695ad.261.2024.11.26.11.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 11:00:30 -0800 (PST)
Message-ID: <c18bc538-2036-49ad-b629-ae40486934cc@linaro.org>
Date: Tue, 26 Nov 2024 11:00:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] docs/system/arm/orangepi: update links
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/22/24 14:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/orangepi.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index 9afa54213b0..db87e81fec4 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -119,7 +119,7 @@ Orange Pi PC images
>   Note that the mainline kernel does not have a root filesystem. You may provide it
>   with an official Orange Pi PC image from the official website:
>   
> -  http://www.orangepi.org/downloadresources/
> +  http://www.orangepi.org/html/serviceAndSupport/index.html
>   
>   Another possibility is to run an Armbian image for Orange Pi PC which
>   can be downloaded from:
> @@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi P
>   board and provides a fully working system with serial console, networking and storage.
>   For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
>   
> -  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
> +  https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
>   
>   The image requires manually installing U-Boot in the image. Build U-Boot with
>   the orangepi_pc_defconfig configuration as described in the previous section.

Regarding our conversation on IRC with Peter, is seems that google 
reference www.orangepi.org only through http, and not https.
As the host is currently down, I'm not sure if https really works or 
not. So maybe it's better to stick with http for now.

