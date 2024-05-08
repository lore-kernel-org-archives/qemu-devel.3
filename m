Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB427C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4p2n-0001Mu-2G; Wed, 08 May 2024 17:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4p2l-0001Ma-PL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:41:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4p2k-0000MO-4c
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:41:43 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a599af16934so42798866b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715204500; x=1715809300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQLRzZVB5y+EtrJUjumGMzemKyn9Far6uFIyzgTKJ7Y=;
 b=ttyzGj8ZnHqlxFBdpvJxOVIDqNwrlmkykh0BWPbM9W3PpSzlNPqGUVeKNEQjcaLjmG
 7AGBS7p8kyS6OoOmFbbtt4R6FFeNvjaw91IlzvRONUZ8EAViGnFB/P0KMcFnnfrnYfMt
 ZzGrSRtfJtZ0H5Bym25I74wO4RYAcz+tjVhql5WpOnfJEEm832fPrcacRrNBJxUye8S4
 IrehiWR5W5YOSYfN7GkUAfklBDy2fjwMLtLD6G1cMAXMTLR+5nzRGlJ6lUqmmDN9c8u+
 9MYdIh54aBwxxpElM4Ls/jxdamcARmFCbbnlTEafer8T4ezZzAu4D8Z78rth0t9mj1zw
 mqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715204500; x=1715809300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQLRzZVB5y+EtrJUjumGMzemKyn9Far6uFIyzgTKJ7Y=;
 b=ClnRALAaucloaM/DV3ab3fTkVDVm1YIcTvupFv3h9AQiNWGLhgdJZVJZnbHYot84GH
 0IH+g6Y89yFxGN7+BVrgvIoxuxgzDMAfB12U6T9GrdCGxQ9IqW2SgBs8+uivG5HOEyLY
 GQO/n9bAyBCkPN959BuKBxWzay8soN9/F0Ofhe0BVwjdFjsY7b40R6AsXsbXr6gD/bpQ
 9Cmfs7j5W+LsBpVJqP37R63fvQQYOWyTX/Avt8r7BSNFzNIgb9RTFf4KCIaLR/JI5tYM
 PH7GOqSVbArYoR/p0MlUvOxk/JH2Ue4H4bg+ikwfvMwx1f2Xw5J8xs/CsQynWCYzXqmr
 gNGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaC6i34RX47fcxtALOUZV82DAZHbQCFrKT8B5kTZ5sg4Q/DZn6+5/vdL1Vtet2l3vTOPPd2hjaB8JE54PCRCYv/9GHm20=
X-Gm-Message-State: AOJu0YxUU4vFrtdaM3qLe7wLqJRunj2lKdIV3BWlcZPz2TjfcYe3YeDN
 my8AmIJDYdaXX4UlHqAmC0RsnNFXiWli6YovYP3eAvD0eL8TBzRxUCCVXXGoGQM=
X-Google-Smtp-Source: AGHT+IEzso1NDEvVXVFTEMOCb2YAdJo5u7Hnwg8ASt3rKA9ANrgWaJc1p3B/7ABHjEx2olp2Kq8dRw==
X-Received: by 2002:a17:906:1957:b0:a59:a977:a157 with SMTP id
 a640c23a62f3a-a59fb9f209dmr244556566b.73.1715204500146; 
 Wed, 08 May 2024 14:41:40 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d9dsm4085566b.132.2024.05.08.14.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:41:39 -0700 (PDT)
Message-ID: <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
Date: Wed, 8 May 2024 23:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 8/5/24 15:06, Jiaxun Yang wrote:
> Hi all,
> 
> This series enabled IPI support for loongson3 virt board, loosely
> based on my previous work[1].
> It generalized loongarch_ipi device to share among both loongarch
> and MIPS machines.


> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (5):
>        hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
>        hw/intc/loongarch_ipi: Rename as loongson_ipi
>        hw/intc/loongson_ipi: Implement IOCSR address space for MIPS

So far patches 1-3 queued to hw-misc tree, thanks.

