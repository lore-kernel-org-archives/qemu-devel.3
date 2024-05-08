Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E94C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ofT-0005Zj-5B; Wed, 08 May 2024 17:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ofA-0005G1-Mk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:17:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4of9-0007gC-7L
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:17:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so94462f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715203037; x=1715807837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ELB5hR0l6aboTYnfPTbapdrQNwpmH5dSlohL3kD+byQ=;
 b=Ayk3SNxjqPy2UMjCiuFnUudNxmyYMEo6FxWNN70KKu68ZdHmsP7Zkj6z6HuLAEj/6G
 BJOtrW1MopqZRPSST/twURJO5Hy2bNh2JE3xXESulHLU8r3nTJN8J2NVbm9oR2ft96vw
 hE+bcRmd6JSbt7uXI5KCsY1XmAC0G+risKBTFUGRsh4C+y0WOrnyRoHh6XODMo1kh/rg
 Uwe0OQ6nBpmqs4bD6bDX9MXkuj1OYdvQ5Z0aXj5B4tUAQsYvoHmRJCJ2OGR6NE7SMAs3
 bGRRtOYNAimNLYOUOwmDA1dOj80LxJ1UOeSGQZgxxN4KWXnJNZ1WWd1VEtzK4j9gmbc/
 ZvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203037; x=1715807837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ELB5hR0l6aboTYnfPTbapdrQNwpmH5dSlohL3kD+byQ=;
 b=TFTVUIdcBY1jupjMY9InWdCUtCLjEVsgtF+QLCcFKhcVlQcN/MXNYKGl7RxcteEZeH
 9PfU8plQ+uyTjhRsGzxp3i/9FdqqRxU/pjuL2JS6uVgc17YNDw2jl2UsK02O3P3K0eia
 UsC7gdoJBzWRuz6j90vDyiR3TKkaPpaG4u5zELd6oO4e1wUvFRrTma9oDBjSC4FM1Foh
 /X+4UCuO22nf0kdCjdRCr4qCmpTMFxbXfsUDO5IE1fd/z3AHoqa3h+QmTfhnMVVSnNyP
 njK7PnHrDEwJVZ2AxI8prmElb0y9coFM3eyu+X6fAY4lD6bpFZCBen2atikM5nsmKoMA
 IAmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5oMhdkJ6jArg2tdO52i2xkV3bSSZFf70R/1Zy/0Zfikv6PrUq0HCrTihM15inWxt09dxv9kolXHylot5HTzFigpxI4CE=
X-Gm-Message-State: AOJu0YzKJh/1VvV953BUNu3NKIXy4Au3dIj9HVaTL9pHV1xlhCZrw/qt
 AzJlLZL/2sr5z92QnNrCqSc6mUHHKVmUoD095J8c3xX079PyXCCAj7NWafMT0o8=
X-Google-Smtp-Source: AGHT+IGl5eX+fx9wZ0BNh7aSz5boecsPMS/37d1P6P2yUCA33rIF7DQ7Q9UMJR/To3nzP6i1uHKssQ==
X-Received: by 2002:a5d:4884:0:b0:34d:ad05:7d7e with SMTP id
 ffacd0b85a97d-34fcb3a9277mr2676895f8f.43.1715203036753; 
 Wed, 08 May 2024 14:17:16 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d620a000000b0034ddb760da2sm16410867wru.79.2024.05.08.14.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:17:16 -0700 (PDT)
Message-ID: <7a56d91a-364f-4e2f-a239-1e8931770149@linaro.org>
Date: Wed, 8 May 2024 23:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc: Deprecate 'ref405ep' machine and 405 CPUs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240507123332.641708-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507123332.641708-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/5/24 14:33, Cédric Le Goater wrote:
> The 'ref405ep' machine and PPC 405 CPU have no known users, firmware
> images are not available, OpenWRT dropped support in 2019, U-Boot in
> 2017, Linux also is dropping support in 2024. It is time to let go of
> this ancient hardware and focus on newer CPUs and platforms.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   v2: fixed header line
> 
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/ppc/ppc405_boards.c    | 1 +
>   2 files changed, 9 insertions(+)

Thanks, patch queued to hw-misc tree.

