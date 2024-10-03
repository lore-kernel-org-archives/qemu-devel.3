Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15402CF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOBJ-0000kZ-2u; Thu, 03 Oct 2024 11:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOB6-0000V2-GV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:55:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOB4-0004mf-3K
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:55:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cc5fb1e45so935514f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970940; x=1728575740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LcvxLvUuSJ/+4Vqu61S+TKGcuUJJdo6fzBIEzZfS48=;
 b=TiJIN0KrYraeceyJBh2qjKyf6zIT/oNPhtGMtud965VJI45gaKZ7hPlqTCy4+hVjtC
 kVPSP1Ditqh/NOdp/8t2i401jiNE0TIm0xYB5SF9Iy6csQ8vN/bhqqvQpT9Yqx1TaEgh
 i5jl5xBxncE1/ZkmrBV2tpyO7T2HvIrLqDCm1ZpnzgtHCNDDNAuZeUuqDCnuXTgENqSB
 o7vNzM+18aG0xkTwtD6QKCxmc3a5nPKOQBYxdfj48QCGqOMuadk0Z0ul1R7ehtbAeu/d
 dlQtwbAa5J4LIr0ArD/JT76Cyg5RtQ09VYNrGNA14+4SWqblvPULsLdtVVpPlP7iUo8L
 ja4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970940; x=1728575740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LcvxLvUuSJ/+4Vqu61S+TKGcuUJJdo6fzBIEzZfS48=;
 b=rY4CTxye83vwJbpP6+szRg9U3TZTFXcqZNYCx3Y1AvudolZ6hU7l8BeLWsXSX/gc6Q
 2IH8woLdiS/8kSJ7h/I+MxUYKlQyVOT9H8vOQPnoYBbL+xIijJ0TohWFw85i7/lFrjkj
 PzS69VuGDdid/Whx1PjQX1BaiJsQJioSEhYU08v8EFNq3zDfHb2YIN8xiQvXhOLww3Og
 a53Mk/CK0OEvA487BSIEcNHEzb64Pd/3JkId+BuRDbWdhEyt18Qh4eIFroqdHvkgSySL
 FGNy9OOK0Lm20UTpCVI2+a7SAgKGpHCOa+kWwqKGxo3aKxNO9mWgMIRCXIfqW6IGUnkc
 B4/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPEiV7MZO+yGbH8Zc3pHmu8XwwVSfWtX5TfD1+K7/hDEBggug/n3JiAEa5VDJn4nMkW31gDxJDxBw@nongnu.org
X-Gm-Message-State: AOJu0Yy8NWdBaV07Pxukokt/x2MyDEO+jh3G8U4aWQWYNQOVTCUe6oJI
 n31uCwzdZupKJ/OzmyF3Sf+SDEZRz103BUwHCv9NjLBpQ+Bh8PmA+wh9ayZM65w=
X-Google-Smtp-Source: AGHT+IGqRKwEJbPbcC+bqihg9GvRgQqmwy0OTbBkWtWjZDID9Cc3f5G87dFAuo1v1UoLYUH4Y6/r0Q==
X-Received: by 2002:a5d:584c:0:b0:374:c3e4:d6de with SMTP id
 ffacd0b85a97d-37cfba04c62mr6668172f8f.41.1727970940146; 
 Thu, 03 Oct 2024 08:55:40 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08226177sm1536397f8f.36.2024.10.03.08.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:55:39 -0700 (PDT)
Message-ID: <2a36635b-90ca-451a-b1f0-e69f6cbd9ca5@linaro.org>
Date: Thu, 3 Oct 2024 17:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A
 maintainers
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Jacob Abrams <satur9nine@gmail.com>
References: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 21/9/24 12:47, Inès Varhol wrote:
> It has been a learning experience to contribute to QEMU for our
> end-of-studies project. For a few months now, Arnaud and I aren't
> actively involved anymore as we lack time and access to the hardware.
> Therefore it's high time to update the maintainers file: from now on,
> Samuel Tardieu who is behind the project will be taking up the role of
> maintainer.
> 
> This commit updates maintainers and the list of files, and places the
> two devices in alphabetical order.
> 
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   MAINTAINERS | 41 +++++++++++++++++++++--------------------
>   1 file changed, 21 insertions(+), 20 deletions(-)


> -STM32L4x5 SoC Family
> -M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> -M: Inès Varhol <ines.varhol@telecom-paris.fr>

Thank you both Inès and Arnaud, it was a good experience to review
your contributions and see how you improved over time :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


