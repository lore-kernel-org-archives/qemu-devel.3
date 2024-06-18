Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF2C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJX3E-0000Jv-KI; Tue, 18 Jun 2024 07:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJX3B-0000JI-Jh
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:30:59 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJX39-0000Of-DC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:30:57 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec17eb4493so62313311fa.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718710253; x=1719315053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWjl3BkBA3nZ9xIrKeLkmaaFdlDreyvGISwFG6IW7IM=;
 b=XUYnajkctj4y0SCeaXY+q7STCyjsP6T+2FdmRTNS8uzf19VPxKcsUqIZSXD9jWjoYo
 Y2IiQbHsjARfpl1Ir8lJa9VfTPbbh47DFOFMV0CYzF7dtCs4vNwR4RTStTG11Nrm1BoH
 R4gN33Edk0JIw8yQUVenz1ek8lWbeu8I00CE0YQj6bri5oDu/NKAGQNX0wEwx9Zx/I9E
 lw99X00TNcIAzXNfRWB6ZccFYelnCwJIMwHUDVqSK5rxTVwAY0zcqoBi/9xk+9yZ3DsZ
 L+yCYDSbcANmsPHLRob3JOTtq91oRVvSPaSv5mBrAuVb2iK7jBeVtliWugVtdkAGMbPH
 OaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718710253; x=1719315053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWjl3BkBA3nZ9xIrKeLkmaaFdlDreyvGISwFG6IW7IM=;
 b=iJFsYk9XStSChRwg1ltWZ7QjVzkC6po3nVdgeWkjIYScgvuprHtEmUFxHilHf5d/Dh
 VPdE6nRFs9nkmpUNFSrNdfLrS+bPjkGJzQ+rdCtIZhcl927YjA9WqbHPIOUg04Kkmu3D
 9mToJdIjhrkyeCaXu3GkbUh+7J+eZXe7zqcsB2+7qgfoO6xnDsMXxSiKuXzxZjoJ0Itu
 FO8NyWxepV8swwHoRz2KFeUAiHk8zqLKGcrg5VdVo8gBumEnyHgJgoLl/Q2VJmdgn2GI
 Q0yQQrrqpL1V892BIQRT65d3fN2tv6LRnNovUdUbM9KJBjMMM5dClJ0tDbNU0a0lfw9f
 EBIw==
X-Gm-Message-State: AOJu0YwZInaZjYRweqM9OreQ5iXgJVIsW/BwGYOvg8qO0Sqtbb0ih26a
 +Au1WxY5KhN6OZCMMQ+l2Yt1v+wSmF7TLhSYP6F9qgI27OwTIk5+OSrBqMujx5Tl7/HYYTzMgDt
 fgBY=
X-Google-Smtp-Source: AGHT+IFZ588u1dt8NOy9nq/Snw8P+iQjo72aJSomCdG6K5JEf5Q0rRZF+DD/RxaVYevi76sI226c4A==
X-Received: by 2002:a05:6512:616:b0:52c:c97:b591 with SMTP id
 2adb3069b0e04-52ca6e6e321mr7757416e87.32.1718710253084; 
 Tue, 18 Jun 2024 04:30:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db620csm612238766b.71.2024.06.18.04.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:30:52 -0700 (PDT)
Message-ID: <09880cd7-2bf3-4b89-bb55-941d61e2c57a@linaro.org>
Date: Tue, 18 Jun 2024 13:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/pnv: Introduce pnv_chip_foreach_cpu()
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240617111956.78414-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240617111956.78414-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 17/6/24 13:19, Philippe Mathieu-Daudé wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> This helper routine uses the machine definition, sockets, cores and
> threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
> with it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20240424093048.180966-1-clg@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Rebased
> Based-on: <20240610062105.49848-1-philmd@linaro.org>
> (Since Nick reviewed it, I plan to queue this patch for my
> own maintainer convenience).
> ---
>   hw/ppc/pnv.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 37 insertions(+), 13 deletions(-)

Patch queued, thanks.

