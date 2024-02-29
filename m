Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAE8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfphh-0005fB-B0; Thu, 29 Feb 2024 18:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfphb-0005dn-I4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:20:37 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpha-0001rs-0q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:20:35 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so1381901a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709248832; x=1709853632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6COM1MC9rUSv2H45BWoHYXE5IVjCLgCxq76Q7GO/s8w=;
 b=AMlkRuvJAVzs3aOTgEP8ROMirfXIFUBBUOCLgHsoy4sUGns30TXRE4MTS+1Q78DV6d
 qE98gCcvWRRQKdAMadNe7IZS6PiZHrN/qMLkvwQRABULzQFCTlpm/WRMe8wu3Nk5TInf
 VlkxeVnPexEj5mBkDGFaefPQ/440YUZsyTv0R5fcCTQSTHKFJOfPbLOflKQptbYHK2UA
 Hkhr9EXkZ02O5pLf/XUeAeYTi9RF1I8HnJ4FIUbWjc+JcviNNnJWnVkDfWNI//AYvh8T
 mVUE2QDgexJSmtVA/uPxEuINnQJoR1mboMyRqVeeINGoaHwVKSRrOdiBkQRdZPuQ46Kb
 VuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709248832; x=1709853632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6COM1MC9rUSv2H45BWoHYXE5IVjCLgCxq76Q7GO/s8w=;
 b=EoV4N1b+scfQ5j1MbLJwItaERpfEmxaWkV4l8j6YOeBkvlJjKimASqyfLYaWnI2FGe
 3GZBC69AWuNBmZ41yn9fT088tA9kZZQtGi/qV1cLvnXdL6S8XEMm83McEK4NL+8tBkJA
 kttebUN3uOMhnUI2xHxodyEbTzOENjEo2enUSA3mIEAMTIz8LPxhSXoKjqD2Qi4Uzhg7
 IRKqadz83EVm4i2nl83Lwp9IkskmFSo2G9+MjNw3tf2bgfErREHjDo8AArdK/M/2tYsZ
 5R12LJ+jz/I73km82ipBk0rXohmgPbvQAf27Xf3yAkINESfdYevs/JZHCUquxiRLLo0m
 /T7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHm8NFeAOnop+Z6bElGD9IzCrbG4bWm99330zaC4jrIINkPTD8TGBbAhxlQZy6xFrXfADHneNO7jr4GRWiym64Ypwfyls=
X-Gm-Message-State: AOJu0Yw4a3kABG5MScug4xneffnDt80XHqx4dhLa+Y5fohp/YGx0mjPq
 BYRQR86v4UrW+mFZy/DR1+bTpJwlSAD302XhNyFqxdXqNviMZvQ8hZboF7hgprU=
X-Google-Smtp-Source: AGHT+IGJJ8NVgo71Mq+o3gL08Cfihb67j99rLDlmbgE2u3g1hEdgjB41AHwIgOw+tnVezlVJ/O8oPg==
X-Received: by 2002:a05:6a20:9f87:b0:1a0:6c85:b48b with SMTP id
 mm7-20020a056a209f8700b001a06c85b48bmr4390933pzb.0.1709248832480; 
 Thu, 29 Feb 2024 15:20:32 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p8-20020a63e648000000b005d68962e1a7sm1874596pgj.24.2024.02.29.15.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:20:32 -0800 (PST)
Message-ID: <6a04120d-a26c-4473-8196-bf9a9b814d15@linaro.org>
Date: Thu, 29 Feb 2024 13:20:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 20/22] hw/intc/arm_gicv3: Report the VNMI interrupt
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-21-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-21-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
> In vCPU Interface, if the vIRQ has the superpriority property, report
> vNMI to the corresponding vPE.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 14 ++++++++++++--
>   hw/intc/gicv3_internal.h  |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

