Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D527E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaRl-0000BC-Lr; Fri, 20 Dec 2024 05:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaRi-0000Aw-KI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:41:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaRe-0004Qy-5s
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:41:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so19149435e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734691280; x=1735296080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oxbLS2E6qrPReRP/tM4Wi4sv2ulQ8+yAeeeJ9OW464E=;
 b=yRG4PAoKYdVFtHKz7oWkAWbre7fbZoM6i9VMRZ0gnjsTrRTpG/nGg1umv/xuU29otU
 /exbwKQ7KoxyKP0M/bWrGSB2rV/qtiZ5rJuWxmuBcMoeNzSCc89syoQJC29uRLAGa17O
 qAj9cv8bj9CaRW50o2ifzeEsQKkXERG8A25iNvCAps01Dw3R71KknMI2UtVeS/HPDt6b
 ND/wA19jzFGDKEt6GdnBGW/vDKuCr3o46v1TDSpPm4vyE6M+FeuGdvMAuc4WotWt6VFG
 FmEsGzGTUIGrZh0cM1Gexxhd7T/bShBc2q4P9tNtN+Ap7k8FWlnqeVkYPiNmiuydoISD
 3G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691280; x=1735296080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxbLS2E6qrPReRP/tM4Wi4sv2ulQ8+yAeeeJ9OW464E=;
 b=h7FhhVaZEXCLsxkbOojzmCelEu6yO8tiptLk+l6aqWRuXzL5TWZgj9T8Fp0ExaVT7D
 2jfCK2nNZXB0EP1xrtqdE1Gx1vbcCN2Js8UJc+eqUQQbCm3mzocFzC1z0OY604LwPna6
 8gH11LCvWshWwJ4iQYeeBmET6pnPKo4Hx/Hau4RaKRdlcehc9oFd5ZGJ5AfZB6Z+W16S
 RLwE6LSJcJ2fpGlzdp2QNAPeBDb76Uk4YQFMC6wKAF2AiYo/dZ40lRQbOX5aBungNaOz
 B6+YVyBNUGFc/Wp/TERZTD2soqCAPYr96hk9ps4T1aEu6AFOHhioWADeQ3egVWl9L9AN
 4S0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHJKqITReLMjKOaJTknEumWx0vXfKtWVfnpyeixaq2nwhu8dV73HqOhmS1+hGdWa+GRQpoWVipQE4R@nongnu.org
X-Gm-Message-State: AOJu0YyaZaQddkYlPWTnOE678+jq5aALCDHQ23VFZptxveHlsEhOkq+g
 trQtuJOW2AVgxTWsvYR8eOzkqCFvMtn2xQSS5xBdhG5h6cBn2Jwc4SQ0FmW5qdk=
X-Gm-Gg: ASbGncuVAShmAuSEyJxG+Ef9mSpyzD7mJ3/AgJ/w1MUgDOF5Mr27yScXjvtPp6iNbQo
 lz4Sb/F57nlvkhwVQkfMntQDezy+VI0VG4aQFMTjkmZwem/g/P7I47w5+tal0OpK3vTTrtVS9Ze
 KctxocgG4BFqwIpi76FvQ+NQEOZKTB9FpwYTVS8PAmnaaCLnKd2/c7GnYswxRJMEPO4uxHxyYzY
 mb7Kq35s0vo1yccUutPWFGSZzfZXdxT4QXux6dy8B1vwmq7NUt9ztnbIFBUcUtEV2M4cP0=
X-Google-Smtp-Source: AGHT+IHdytWlAN9stTz/6Bcl4/8fNy5akhgQNKCfuT3OHq+Gw5Pvna4yMmTzb2LZbTihclc/KzfOdg==
X-Received: by 2002:a05:6000:18a3:b0:385:f60b:f5c4 with SMTP id
 ffacd0b85a97d-38a221f9f90mr2108409f8f.29.1734691280449; 
 Fri, 20 Dec 2024 02:41:20 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833149sm3688681f8f.39.2024.12.20.02.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:41:20 -0800 (PST)
Message-ID: <d295fb40-0af3-430e-ba66-ba72e9d6e614@linaro.org>
Date: Fri, 20 Dec 2024 11:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qxl: Fix race on accessing cursor in struct
 SimpleSpiceDisplay
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@redhat.com>
References: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
 <6119a51b8626575d1f5e6ac31630f88afa32eba9.1734633496.git.yong.huang@smartx.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6119a51b8626575d1f5e6ac31630f88afa32eba9.1734633496.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Hyman,

On 19/12/24 19:46, Hyman Huang wrote:
> Both the spice server and the qemu (iothread/main loop) context
> can access the cursor field in struct SimpleSpiceDisplay.
> 
> Add the mutex lock before accessing cursor in
> qxl_spice_reset_cursor().
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   hw/display/qxl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index ae2d983299..d1fbeb65cf 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -298,10 +298,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
>       qemu_mutex_lock(&qxl->track_lock);
>       qxl->guest_cursor = 0;
>       qemu_mutex_unlock(&qxl->track_lock);
> +    qemu_mutex_lock(&qxl->ssd.lock);
>       if (qxl->ssd.cursor) {
>           cursor_unref(qxl->ssd.cursor);
>       }
>       qxl->ssd.cursor = cursor_builtin_hidden();
> +    qemu_mutex_unlock(&qxl->ssd.lock);
>   }

Alternatively convert to use WITH_QEMU_LOCK_GUARD() from
"qemu/lockable.h".

Regards,

Phil.

