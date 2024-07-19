Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F6C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUhrP-0003cz-4K; Fri, 19 Jul 2024 03:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUhrK-0003bx-Ny
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:16:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUhrH-0002cb-96
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:16:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4267300145eso10464425e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721373409; x=1721978209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MKfbJy0MW5kV+1ASjHsq05nIgwNUP0Qw3BvpxM/z/kI=;
 b=fULhPw5ugKuNZFEBPWaXGd0ADKEsOakicfE8QERMsl1eEmItCxJeSMI9C1nPlW+3tY
 3X4QPQK52gtI2Tl7x2OzCErmm2/cV/ip60lyhWOQ5REDR9bQRJu/joV9DCXcag98z2aJ
 Pf4yuBAS1CDuvtXkbFYAl4ZjADwy0ntv5E1QXFFnJpHmvUh1CvwTVtA6gzllqmm4qARU
 RpwJODaEa4AR4Z1cfdyA6aIyPGVwGBdqYEpEfx16h2ennG8hzyFWAIWvekrBRfZkN/yT
 V6hyORiG7YRLU5w0rcjvrSDSCQIdB0e3qzoC36TxrDrTBylWYPad0Sk46D0zRWMXYnOe
 zkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721373409; x=1721978209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKfbJy0MW5kV+1ASjHsq05nIgwNUP0Qw3BvpxM/z/kI=;
 b=an/CDUYMvsQ5Jt5Q1COtsthugjK4gDr873BriUQITIPT+GsAn+xMbeR+q0tAToolOb
 KhI4QCQSOXHOiauiZ97cbb0yKCA3VhQGDfgKq80YZd0TtY8Zc4+93o3w8Qh2hqICMppn
 3ozJUbEy7i5qoo18qsH9oFNfATDUrWICAast0u7OiOTLyDEhNKqVapvY29XUa2KPSzYa
 Vu8dweNhyy+3KTHzxcdXigSltralbCMh2xZG1wNhHzwINS0HXCUDBIKNKoQPPdmboAUR
 Co/bN1kYJxghkUFEil7wD8bFKgBYqjDKiKUx1UzU4lUKaDBXOF0LtucuiCJPuHahAzcJ
 Df4A==
X-Gm-Message-State: AOJu0YxJikxQ1xMOuNl4jteHXCEC9gji+xLZiq/ggbrYGL2kiIrYRNHK
 NApHhjb92hbEdmXfqDLibcyPrcNByvG/5CeVMiG1zTM+8RWaFHk1yjQnlZU8CVY=
X-Google-Smtp-Source: AGHT+IGO+oCc5PUPL52Ase6MXsE9hGSalsZyfPhKNV3MOXYWIPookDtIIR+S3zt1Gwy+LXKWwJtclA==
X-Received: by 2002:a05:600c:1547:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-427c2cc90dfmr61926545e9.19.1721373409097; 
 Fri, 19 Jul 2024 00:16:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69019a5sm13499685e9.18.2024.07.19.00.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 00:16:48 -0700 (PDT)
Message-ID: <49538c5c-3a35-46f8-93ec-e71961c329dd@linaro.org>
Date: Fri, 19 Jul 2024 09:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mem/cxl_type3: Fix overlapping region validation error
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240719012807.70715-1-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719012807.70715-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/7/24 03:28, Yao Xingtao via wrote:
> When injecting a new poisoned region through qmp_cxl_inject_poison(),
> the newly injected region should not overlap with existing poisoned
> regions.
> 
> The current validation method does not consider the following
> overlapping region:
> +---+-------+---+
> | a | b(a)  | a |
> +---+-------+---+
> 
> (a is a newly added region, b is an existing region, and b is a
>   subregion of a)
> 

Cc: qemu-stable@nongnu.org
Fixes: 9547754f40 ("hw/cxl: QMP based poison injection support")

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> V1[1] -> V2:
>   - Use ranges_overlap() to improve code readability
>   - Replace the ASCII extended graph to ASCII basic in comment.
> 
> [1] https://lore.kernel.org/qemu-devel/20240718090753.59163-1-yaoxt.fnst@fujitsu.com
> ---
>   hw/mem/cxl_type3.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)


