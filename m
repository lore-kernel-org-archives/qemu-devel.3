Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BE0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVvV-00082m-HX; Tue, 04 Jun 2024 11:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVvQ-000823-BV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:18:14 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVvO-0004dD-GO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:18:12 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b919d214cso3183488e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717514287; x=1718119087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6RleM3FcLuzVP9koeDnXmh4wXiBiuzwXlnl362eeDfg=;
 b=eQwctF5ZFTTWi3pab62qef531aBxIk5+TPC71Em3bjT4MKCAiG0AbZgnhbAxnu+hRe
 eFZ4BuGbDrDrSEE9eH6Y69hVu7PdJZtj1GdFoA+lYEiwBZ8xtQaZXdOm8Wb1y8JOTbLt
 3GtdtoKnjxwYY77qqDaYqWh2Y7ioH1KitO1fvtn1327iyY55xxtkZbAcYNETYby2/dLg
 ni6Lt1M/siCJx8wOor+EJPvxeLyAwcyzgH0aJABz9gWXklcF5bEVnov3JQB8zJcvMKwm
 +8OpOChOnT6zVyMbZbBcQQfGEttkTX/+fj+DcB2Paz03GPGPtpeJQ3n18ON9bdnyanmu
 40Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514287; x=1718119087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6RleM3FcLuzVP9koeDnXmh4wXiBiuzwXlnl362eeDfg=;
 b=EvedAtOyXQwOVfT5fj3KLpCHXxxSelFBnkpn/q4Rhdc053Sxla4eyvVHoYiQV2qs+h
 XuiLFj2DMqzMHo1Y74QcYVEcE587nIThhrbqkdtJCmI8VcE3QLnvARPmZiPvcULZCznM
 oxdoJx/BFfAzxepfHah62u9wL7kb9eUmtSDNpN4FSsVJghXjP6KqTNuMrZNHGjgfzbnJ
 WPAIGFGX0frq4njbKDlfcahqj+Y8kuHrNSv0ogTFCPqBdmOpIeW4elrYe9OOoTPXeyNj
 9cbewxmAytlM1ITdQqI5vq/MMsY8yBMXTNsO7ktlq9bf1UkzsFDIsx0iU5EdA8NrauLg
 wO3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84odIEvNSXtopiKoZd5qoz4k5ShXx5+FDutMPfBCvv7fSYSCxO47Bqs5rFuVUJ/td/qd0IisNpDybpDKu4VzNaDK+Fe4=
X-Gm-Message-State: AOJu0YyeWvBoe3lbimzaME31hNcb9LjS8DAYgtAgOuLQawWzeDVeB3fI
 7eEHh+Ok9dGcZ2/gU/folVgsuEvWvFojH0JekvGbDuZwdPq2Uk4H1wyW/aynpeg=
X-Google-Smtp-Source: AGHT+IG9LXGUQrHpBVZx5nH6CROl136TLOEGpn4TCaX+v/5WrhIVoxd7TfoxXoy3Lsx+teFYzfrQjg==
X-Received: by 2002:a05:6512:3b81:b0:52b:8877:30f3 with SMTP id
 2adb3069b0e04-52b896dcc9bmr10349611e87.64.1717514287347; 
 Tue, 04 Jun 2024 08:18:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68a1dc4e8csm532665866b.225.2024.06.04.08.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:18:06 -0700 (PDT)
Message-ID: <94d45d2d-40cf-4644-87a4-094ea85e8943@linaro.org>
Date: Tue, 4 Jun 2024 17:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] scripts/coverity-scan/COMPONENTS.md: Fix monitor
 component
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
 <20240604145934.1230583-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604145934.1230583-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 4/6/24 16:59, Peter Maydell wrote:
> Update the 'monitor' component:
>   * qapi/ and monitor/ are now subdirectories
>   * add job-qmp.c
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



