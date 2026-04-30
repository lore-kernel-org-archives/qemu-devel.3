Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102DFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISLj-0005X3-76; Thu, 30 Apr 2026 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISLZ-0005OK-IQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:26:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISLV-000885-N1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:26:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso12311165e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777559187; x=1778163987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oQrxJFithfa7ZiRsILH+SyS0m+kPPzBVUSj1/8QSdA=;
 b=tRB7Ui+MchOqHK6PuZzfK0LiybtWb37ov/KeznHcj+ffIdtlDMjDoOCAx7HbnUhShQ
 AIl+Nw6KQfWHRci4yAgqje7lZRtpSJZUkh9ZRkYSKpi3xcckhtkdX9f3Njzog7xy3z/q
 E+XLaLTiw2al41eAMlZ4SSAgzsVwXdXeSHx3hmuqMYGKaKOOjXUEIITwSU7yMAtvliL2
 RZ89gnGWbMg0ZSpkdaAfyCPFDstmNWRvtqJVxrE9Fm+gwmesAo2iIoYefy1JMFeDcZub
 c/1uBH1GNBBCEPig2quWn5M0mK1tbbK7huYvsaRfsk6GznTDyTs5cfe2gwBNb+/W/nvF
 a9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559187; x=1778163987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9oQrxJFithfa7ZiRsILH+SyS0m+kPPzBVUSj1/8QSdA=;
 b=KYVAVNA6sWooVmT+1HhPpEj8Qa/IRnGTcHDClzvRwok1JvXx4m5JFy3AOlwSOzo697
 g8Vq7sKa/4gIrZjOS0V0qUoDL990ZhPu9iEFDEqaCBudA+kHu0GpVg2CjOmi+SAW1c02
 aBSo/m4AqWdG9zAeMwxVYLjBnFQWn/KS9ehQ0aUZOampBmDqTlNqV78PvyF1yncRinGu
 PpgXT4E+TKgvwIlTRiGBOP+V9eM5T0IYgkILd7H8S0kUA0+qI99ougdNtrk2AqFf+Zt+
 02zi/u466UE6JO4tXT066O1+Oq3zRSWuz0OWICU6wAcF5gWMeaUxyXYCpRUpkW6AQCeo
 DeAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xXUEIXpG5I5JKuTVqATpQJ91QZhLZ5OPkAxfZ7djh4m8C8Oljf+GMAZPAMSvmgpOAEsFkktsg45Kc@nongnu.org
X-Gm-Message-State: AOJu0Yzq6CT/Dll/ZNrWE27ff9ifFKWCjwR0Bhzg7e68oVRSsIsiGSS1
 bhcTOSnsZY9BZ0KdloUjelqdqGxvfmdaKyvgUZ5PGcRkir9h+yrJNnJGPlBDGGU2Pq4=
X-Gm-Gg: AeBDiesT8mUhjZokYKcC6Pply2iG63mPfG/KosPC+pRkFcBelsAC2WucKvp3AcQUyTQ
 BOxbAQ+ob6DO8mDLHLAbd6w3ET0oyN4l142txXKSHdLsxwZhxaSGVt9IKSy0/tBYLqjmH3h73YY
 oTek6eZIwU9pFYgS+9f88d2rGOOADAcmx4LrH3XFpUSKVuulZBLzUhOzh8BG+gymZ30iaffuLcp
 R/VIg5MKN//PxqJy4XYQkjmncBzbTIwHJKZc5U21+uExgMbNBfNliIz0cxdK5mY310OfBNWVCTK
 FilCJTJfNmHAQ+IweFDhKHBhdXBCtbsVaI1FMef5QBM3seosxUXo3IDqBRAjPE6tGDgAcB3QJrj
 r6en0zi1ApruN+7jXsH+jA6+muiEac2HwbgXH7bXxq7NAwhz7hrrnvWz8zCHxgTvfL/wSOSjvCQ
 JFilM0c1qyOXarqUfBQ/rRxk9qiWE/93w8Q8Y8if4WPpH1mthbxLda9DPah4AimGADui+0dy8iS
 oWW
X-Received: by 2002:a05:600d:1b:b0:48a:592c:e642 with SMTP id
 5b1f17b1804b1-48a844458d8mr42920925e9.18.1777559187138; 
 Thu, 30 Apr 2026 07:26:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31f1ddsm41055275e9.29.2026.04.30.07.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:26:26 -0700 (PDT)
Message-ID: <25eddf26-8216-4a8e-93fb-7c3f062df7f3@linaro.org>
Date: Thu, 30 Apr 2026 16:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/65] hw/intc/arm_gicv5: Implement CoreSight ID
 registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-33-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-33-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> The GICv5 register blocks all implement the usual Arm CoreSight ID
> registers; implement these for the IRS.  Although we only have one
> callsite at the moment, the ITS config frame uses the same ID
> register values, so we abstract this out into a function we can reuse
> later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)


> +static uint32_t gicv5_idreg(int regoffset)

Maybe rename gicv5_idregl to match config_readl, anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


