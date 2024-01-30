Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484AAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmg1-00065F-IE; Tue, 30 Jan 2024 06:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmg0-00062x-0b
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:53:16 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmfy-0000Tf-BY
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:53:15 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a350bfcc621so416825366b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706615593; x=1707220393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xACOu8w65Myng4aOci7Em7bTuJ0Oe/mzT/yApVWi6yM=;
 b=bgIPo1JPi3UTBQeb+5152JLSyLtGJTN7iNZo82aVdmF/tfSf7ZU76FgcMp3zWfWuXQ
 UW9mAqRZLHJWxuw0gxfPtpR7gFGLnQ0wlmkRNqwFBAzLqG8zNjUl6OnK4QV46ETBzDWA
 yg26zN59QgfzQTM+ja93IgoMIYMDk1H9wGAReT2TJRf+yI+WcAHUvDCiOZ/8I2TwUgNq
 XfU1pVNBUaOnXMRzTZCIf4mmLgwYZKO0DFkpH1rYq3BQxA0UdAYyBFsvDML1bA/XihNL
 AX+2ADLr+Jv2UmSqrJkgBM4eNlHwCbBRFj0Cdmo3iSTOLGy1oiEJAMVILRpOx1hZFVZ0
 wXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615593; x=1707220393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xACOu8w65Myng4aOci7Em7bTuJ0Oe/mzT/yApVWi6yM=;
 b=MUaPZp/9tYKsuv5gvsvUYyVjFKaSFDkCSTfyHhQWLQXl6RkXR9L+7VTexJFSzSxJJ4
 BICrrM0Nkm31v2S2zgnxLBvehfKYbgcocrdo8Svp/XEVclqfQnCVeu4Make5u41y91ta
 YyN5aQJkPNdqgMhRiwlI0rUtoETNvU91I9/Nvun2c27YbBW1Cjt+3vkbup1DgTzytohC
 wFpXLkBYr67QPK7NM3sIcnq5AGxg5FFeyCpBQX4pSKFibarNJeLu26mHBUdJlZAPgtJy
 jR1IzTtCNRKejfvSR2vc7bhvfu2iSolvODPmWj26YGpUA1LSN9fgnGwe0+drPnnL2q/I
 yknQ==
X-Gm-Message-State: AOJu0Yzodjz0GV0dO2m2Ae32xg5Nk+wToNJHOuR2bXG2Ur7VEwojJKrl
 WuDA3Ijs+n7/sTvVYy+HpbdgCJ6+Ytpyh0c5+Ew1ACQiDqtxEcMc2ZKE3ZW+nFM=
X-Google-Smtp-Source: AGHT+IE+/vQeaAI7b+BJUUpfX7/AeBCtU1quxZL1IUDQXuTV0LYgc5mnfzsvvF16Z6K/dIGqdhI/jg==
X-Received: by 2002:a17:906:3413:b0:a35:9c88:f937 with SMTP id
 c19-20020a170906341300b00a359c88f937mr4639230ejb.20.1706615593065; 
 Tue, 30 Jan 2024 03:53:13 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 hd10-20020a170907968a00b00a35cd148c7esm1872893ejc.212.2024.01.30.03.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:53:12 -0800 (PST)
Message-ID: <898124ff-880d-4bc5-beaa-ada1bc9439d3@linaro.org>
Date: Tue, 30 Jan 2024 12:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] intc/grlib_irqmp: implements the multiprocessor
 status register
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-4-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-4-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 16/1/24 14:02, Clément Chigot wrote:
> This implements the multiprocessor status register in grlib-irqmp and bind
> it to a start signal, which will be later wired in leon3-generic to
> start a cpu.
> 
> The EIRQ and BA bits are not implemented.
> 
> Based on https://gaisler.com/doc/gr712rc-usermanual.pdf, §8.3.5.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c | 35 ++++++++++++++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 3 deletions(-)


> @@ -325,6 +345,8 @@ static void grlib_irqmp_reset(DeviceState *d)
>   
>       memset(irqmp->state, 0, sizeof *irqmp->state);
>       irqmp->state->parent = irqmp;
> +    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT)
> +        | ((1 << irqmp->ncpus) - 2);

Indentation off, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }


