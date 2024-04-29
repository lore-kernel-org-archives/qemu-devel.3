Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA1C10F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 00:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FFZ-0003is-DC; Sun, 28 Apr 2024 20:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FFV-0003hb-S0
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:52:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FFU-0004de-8F
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 20:52:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso3686440b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714351923; x=1714956723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mWw95iM9QYiHeT7UsSv+3A9FVgeBiBK+1iRsGtVnHxI=;
 b=Nam+DyzrJRFvEAzVeJuHxCrGMdL8s1VfPReLWdglAa6OiugtfRxD+fg4BvluOm3uv0
 21gOG7Wz+En9dNtc4iCwbUKbaIhGZIvmI8MAu5W9J5BROE9H0ncUfq99SvZCjeOXHrW8
 zhIOiqKH5J+8pFMso0utC99VG1Y3MeFlFw5PE6UJlRAvOdRSkkz23xGsYK8lbFhTrH+p
 Koj834a/2wjGn/BiQE49tDHDbvD/U0SF30+Rnjp/QDIfULlZUTYgnAfj9dLtQdhYxnqW
 mxSKiugAnkD/Qt9xcweEj5DXiqEtS1cE16MAx3HhEYZI3jmMbTQ/0erf5WSuV3gdFCMt
 vFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714351923; x=1714956723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWw95iM9QYiHeT7UsSv+3A9FVgeBiBK+1iRsGtVnHxI=;
 b=jPb6DRducR+3q3OnIEWmLkj6O1+ti3Yvbqv6ysi4SUT8vMmKLy5s8hPXHpiITVhATl
 2XtxmdNOidzZwR+gQj5h9vKZ3KN92tDg3QQ3NU4lYLGidRYbuxTiVFfErNgy8iMI9dGf
 H4OBG/juDBVC/kdRGo1IRcyzJW0LLfYDX9N6vC1zgR0ElKmPry0QtLVw3Cs6iJxaXJU1
 mBsOxQR694ghffGpkO/hriqCsT2BYuXO67I2EP+6giXDF1tX3Y7UBjo+ddg8AlnAb/g0
 iDnugu0e0VhKaaZIxMX6dwpLFFSsfRzUf1GaGG2ZDbKKWHxR/f4KdJmZfD3Ci6ko2FM6
 L7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVagjo8K95nuSvYBcmiOQ0FsUK8qvkgxvl3dr3Q3FB2e+yclgAzrjGV4Tu6KE0T34PO7Xr8RnO9OnR6Bo/gMzd8VEBpBE=
X-Gm-Message-State: AOJu0Yx74u35CV53jUHRkd3OZcIbQn3LYtQvJ+WuSsvtnuWBjPbWRWMZ
 mjBJ5Co0LwbkOJ4LgTBZPj5wYGs6PKWcTVovHMseYq0IImgvKOYAgMKYtW82+UG8hTw4BmRkF9q
 4
X-Google-Smtp-Source: AGHT+IHqu69PbU0CeVJ6ECpQuh3AZ0gqNHt3CRbgUdd2ubePxghWv7sazixeS0kZBsxhrd+6+tJBqA==
X-Received: by 2002:a05:6a21:99a6:b0:1aa:5e21:17ac with SMTP id
 ve38-20020a056a2199a600b001aa5e2117acmr11155365pzb.6.1714351923020; 
 Sun, 28 Apr 2024 17:52:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm19009393plb.296.2024.04.28.17.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 17:52:02 -0700 (PDT)
Message-ID: <856040df-95ff-4704-adac-f5dbe51736de@linaro.org>
Date: Sun, 28 Apr 2024 17:52:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] coverity: Update user emulation regexp
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> All user emulation headers are now under include/user/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
> index 91be8d1c36..1537e49cd5 100644
> --- a/scripts/coverity-scan/COMPONENTS.md
> +++ b/scripts/coverity-scan/COMPONENTS.md
> @@ -121,7 +121,7 @@ usb
>     ~ (/qemu)?(/hw/usb/.*|/include/hw/usb/.*)
>   
>   user
> -  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/exec/user/.*)
> +  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)
>   
>   util
>     ~ (/qemu)?(/util/.*|/include/qemu/.*)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

