Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81645C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrgs-0006jC-Vt; Mon, 08 Jul 2024 12:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQrgq-0006hy-Ns
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:58:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQrgp-0001AN-6j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:58:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so3108565e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720457889; x=1721062689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKXQoGJHy+ph39EqAz0WFsjbz/4rOW1h6XfVy2kMcGQ=;
 b=jVaxeD5CQdCYmF/I9+0Moj9Gtc22d0aYDq4XeBy5UxXlcu0aI/3PaGOLC94ENYn19L
 yBUiTMBz/gN6mriXzQqEJsEoke8AN644MaSGuTcgJYRYD9W79aDZXN1YxZIo/LABaLyP
 7QNibrZbarABZ7fgeGZTInf2Nd/jiMiS0fuLWhVmTv66D1AB65wb25Ko7qmRcnOTSVmV
 VF6clgtkrKPhZ8d6OsoLkCHCJMvzmpE+w9hw+LeY0cwleKx/UzvkC3F8Ib9YNMqeRHZW
 h9OAkgwQHOwGb6c5nn3/9v1qXsN9eL3w2meHt3lmGzK1XeFZXXkGGQeMy1a3DP44TW/2
 UpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720457889; x=1721062689;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKXQoGJHy+ph39EqAz0WFsjbz/4rOW1h6XfVy2kMcGQ=;
 b=u05E4rx4kQcK/WrKe5OPPpB83qhgZqjbxe9NBfju6+L374WMwv7J+9lcNziT0k6cEi
 AbhX9ndXXAOkCmuoNbf8mWK0Nc3NKgJPWA/VtM5l1NuIQ99UGvMtuLExNOkrGyF7dkRM
 /dVypcBuYVXEtctVnLWdcf8EYhdcHEYZ7ZzN/PIdaz48diQwIp7BxM8qVKu7Q49K7BAS
 kfvyhPQFwW8euRptk1Qlw7idPtj27o7o75qSMOXeQ/NssdqtkBLQXwoGPSWMpk+EsX7+
 pP/ShDvD3Oudrr5m7sSrrm/Kh3ACZpG4+Vc4+gk43YJhoB09kItzv+a1wzcxK4h5NY+j
 DhcQ==
X-Gm-Message-State: AOJu0YzCIUC2woDf2II4oM1qVK6yqXQo7ohQGsQEhwa28R4ISNVENyIL
 U5Yaq7tPU+AIei1IM7AT5ORRMpGi/RjwqM7P465Ht2AzCfMZ/n7ghW4yfwun5yu84fbJM99AJNF
 E
X-Google-Smtp-Source: AGHT+IEUTLeqxJTcNUqepbLQlXu0oAhyriee76r//zaWVU3JAPFkLkRWOyAnfOeW5xits2bpn3ohBA==
X-Received: by 2002:a05:600c:4a24:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-426708f2111mr1198795e9.30.1720457889101; 
 Mon, 08 Jul 2024 09:58:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.151])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f6fb9sm5524575e9.27.2024.07.08.09.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:58:08 -0700 (PDT)
Message-ID: <152d9c90-3e58-4706-b12a-6d2796681d0f@linaro.org>
Date: Mon, 8 Jul 2024 18:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v42 96/98] hw/sd/sdcard: Support boot area in emmc
 image
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Joel Stanley <joel@jms.id.au>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-97-philmd@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20240628070216.92609-97-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Joel, Cédric,

On 28/6/24 09:02, Philippe Mathieu-Daudé wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> This assumes a specially constructed image:
> 
>    dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
>    dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
>    dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
>    cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img

I'm not keen on imposing that layout to use the model (besides
so far we use 1MiB as constant). I'd rather use 3 BlockBackends
for eMMC (boot[01], user). This would scale for multiple sizes.

>    truncate --size 16GB mmc.img
>    truncate --size 128MB mmc-bootarea.img
> 
> For now this still requires a mtd image to load the SPL:
> 
>    qemu-system-arm -M tacoma-bmc -nographic \
>     -global driver=sd-card,property=emmc,value=true \
>     -drive file=mmc.img,if=sd,index=2 \
>     -drive file=mmc-bootarea.img,if=mtd,format=raw

(AFAICT we don't need that mtd anymore, correct?)

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/sd/sd.h |  1 +
>   hw/sd/sd.c         | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)


