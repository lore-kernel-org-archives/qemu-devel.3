Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ABDF531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQ8T-0001iz-Nz; Mon, 13 Apr 2026 18:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQ8S-0001i1-7J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:52:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQ8Q-0001RH-PR
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:52:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso45883355e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776120721; x=1776725521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dp1GHXH81rNWu1q/QBFUnT9SH/LOjcwKwTU5lDHcEhI=;
 b=eti+DPTwtBlyjbcQlJ8UcoKQNHa4xBJJ2gM4FLMjO4yGsf5WRmZ7HEBgYQtycSAQuK
 rzAPd0MyvqpyHC/0rHbzS7QBaN086OvqCTES9b0cRg2aBC1tgL0YClk+sh9JJkVYEB+y
 xhmvQJQENjReZV7L2UcSuTSMX8l0xEezO6FV6mQpF3QmlpQPX5Xj+s8YIeMHolZk9QVa
 ZrzG6gZ+SSW09wiWiB1zEnM7R/v3bkoR3PuRJIPh6bF3tfgyRv5CJMPXzYN8yoWXitVx
 GdIqhThRXy4ib8ud81HxQtHzZwL27LUU2TKG2fxINDrZn64hO6upMYp4fX+QZNN1WJmK
 p8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776120721; x=1776725521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dp1GHXH81rNWu1q/QBFUnT9SH/LOjcwKwTU5lDHcEhI=;
 b=NGrYDtPnk7KaVVq9m/zIglnhYVxGbRJFn1wNyvKzN1ExmyU+PB7vb5Di1l8oZ4zuBP
 HyvSCQYWmN76XTNee8yD8IjT3Bz77d2LC7wNFz7SVD2t/htzV7laoOdaDPpbBO8Ajrog
 rDYk2FLCHiyQk4XX8a6hGfRPveUJn0p9cPcmF7xOTTOKUjNz9mO5CvCJIJogBLvUW+GX
 BdhqYDGq0yLI9BIOiC9JzCziVkR4wOk1DTvIu4n3D5kbDuusbWPUGA5GHYmyQrZM9t2y
 YXTue+4p/AuJG9NVkHIcgKz4eIfd0snKJjIeKOv1/XbDWuXNUBnFHgmQIhRcjnNbH9/e
 G0Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h71RGGL27AoTEJ7lenJQNMrxN1wj2yeOc1sh6/BJLHNdl2mgnYnpeudiNizz3la/Jo+Kyoqtly2nr@nongnu.org
X-Gm-Message-State: AOJu0Yx321PlSMhW9lYZd4ARQg2cmsYnxnF+LCD8bcP6HAjDdgeCyocw
 AzA+0Mo+MFcNB51e2UmPcyvrygh1y4AvcrAoRUkvkurGpp88R2lzrfT6ILNfl6A4N4vioKP4cBE
 r2hUA7kU=
X-Gm-Gg: AeBDieuS9vpRea667r7BhOTcvmy6O0TeQ1iBryPqBT72W/WoPxE4thSu7cWrVPt7goB
 t4/IZiq+HBgmkAIpVQzhxqP6fbCdv7z2PByFXQ5/rvQukgkW0WnJ2pSSiD5NQ2fE0XSBSLifb2r
 SGxcURuFQmHl7X1viuUdTALRTFy7yygdvDJbh0LE8qnvtDqyDiO7Z1s6QPKJ8MLsn9Kos0HOIim
 jTArb1sGAhLK3SEoVHQ1sakpM4uIKem1wkwBM31cwhyPlzBm3guzrFYmgrGg/bbExANu3VzMrxK
 kgI926ha/XZdZk3whc1AxtbM+UuzTPnvsA7NxFyD+rZUZyxIUsZS/egmr5+mjK4eB4i7R9aKSwg
 zsky/uuE6j4nPYXMThoFMxSEZYKKshpNEusA7kgC8+njZF1u3OeAGyp/abiNhsbVSbhfAdPYRcZ
 YhzMURQ6zG3KwOxOxxF1DGuzlWyDbU2Cg2Zf6U1SGGFcG1D6PX4ltLljD+43Ag069AVA==
X-Received: by 2002:a05:600c:19cd:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488d67e3671mr203455795e9.10.1776120721102; 
 Mon, 13 Apr 2026 15:52:01 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019d9bsm772695e9.14.2026.04.13.15.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:51:59 -0700 (PDT)
Message-ID: <9b125b69-1df7-413a-8e69-dfc6fb438c55@linaro.org>
Date: Tue, 14 Apr 2026 00:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/65] hw/intc/arm_gicv5: Make gicv5_set_* update SPI
 state
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-25-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-25-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> The GIC CD* insns that update interrupt state also work for SPIs.
> Instead of ignoring the GICV5_SPI type in gicv5_set_priority() and
> friends, update the state in our SPI state array.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c                | 64 ++++++++++++++++++++++++++++++
>   include/hw/intc/arm_gicv5_common.h | 40 +++++++++++++++++++
>   2 files changed, 104 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

