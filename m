Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18375E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVd8l-0007rD-2q; Wed, 08 Jan 2025 15:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd8i-0007qi-W1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:58:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd8h-0007e0-KT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:58:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso3171775e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736369934; x=1736974734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7S47hoLIyKl+KrJuSUB1HnHz4bXqqCf4do967BLa44=;
 b=otjlYB0d0txz9CdIvGdvJsWVPP/C24SPE0i/nffX2z9L4RyB6DLJ73rT8KpmjifzM4
 nbIFciX3et+hKE9sVVf+j4f/hmo5Qgko2bRXmIkh5vXkA29+Kq4+jQ2LU5zVazmqZHX3
 5SIWBnXsGp7s1ZQc897qyObI0TBwn9ENyZv+3ke5d/+zGzXHZR4Atf19tcxAo0CwHuX1
 jfl7LMfFYB4F9WG6msLZI6FiJnW1KIunTlsqgwJduIMSv30faEOqIgalf1IS17q5gY54
 PGDcgpbCux5AGksJE7eh7//eze/zDhZM/JazjpiY3/W0CI+VbORIltDpUcEo9hG1wGcQ
 9aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736369934; x=1736974734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7S47hoLIyKl+KrJuSUB1HnHz4bXqqCf4do967BLa44=;
 b=QHAJPqfwTkzJvs/l41uFpRFLJ3kp5blk8/m2OUkEApW48Q7E4SCe95YiruJ1OQOZe8
 ZhDpt+ee1E2UixT+uEpMfl/hz2yeI7p98LV7ZVmZwaLL5Lg8aNTbBWO8Xy5c/y2bDVtD
 beIohVhmJcrn51/iCvfrusR7AQF+llfTh7cW61fjZuctKFToP0M7X9nEe5hLoSVnY3uP
 GklqE5dKyEf5iuTe/iYW+2Kh75br8eri55mN6XH1PVkRGW+EZ7BU2gG5qgS4kvTP4hFa
 too/AT8Ne+eeyArv6ahHME12NjDD2f6L9BxV+uE/vi0dHStFD/gTqqsRbxc1VU67hLcZ
 v/mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXb1Q+Fldx81J7COEPm+RnyEQXNiMChDy8gNjORO7aFUiEj0oyJkx31s6yPEyMCzoLvNGZsxJv7xao@nongnu.org
X-Gm-Message-State: AOJu0Yy5ytw994tRAb/On1+4bM6gTuMvecJKVz7OtF26UW17JbeLC9w4
 50gkkuclzjIULZeQyZu9jx9mMzclaZV3oRUZeWP72a9iVltEF7eUwmGiBMkutSM=
X-Gm-Gg: ASbGnct42bXJe+DDXmOCZ5rgmdH21Q40eaIqLm3S0IdRWAQ0E/r2KWR/tEHBlULiq6J
 svKdcP7Hkjr9EBBWjBkSIFr1Xtd1FfvaODww160h73Y9VzHnEG99NevXbISDOtnuTXiEk85TM1V
 4qplNtFjw7aDSODIoOjVUYdlPky9V5KxLJmneUUAhOfsJp2zeaR51c7b5tOWG88BZt/fP7XeCUW
 s0t59MiFzSC0PAqhp5y49WUSBYFQtTCjgpqryDNmvvW3ThSxy8GAaNc0kBrXkll4IHCD48MC3c3
 tvgbSmzcXamzvRyZzPSWXJFM
X-Google-Smtp-Source: AGHT+IEtA1BVNXRI0NBW1ktUUzUMT1slllNBYz+0axY2NEDy5U5TpiX8kCWcGtU/165czmhspEhT8A==
X-Received: by 2002:a5d:64cb:0:b0:386:399a:7f17 with SMTP id
 ffacd0b85a97d-38a8730cb2bmr2991343f8f.24.1736369933982; 
 Wed, 08 Jan 2025 12:58:53 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08bbsm32505615e9.12.2025.01.08.12.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 12:58:52 -0800 (PST)
Message-ID: <7d676164-0062-4c65-acee-2f74c34f2d4b@linaro.org>
Date: Wed, 8 Jan 2025 21:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 61/81] tcg: Merge INDEX_op_or_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-62-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-62-richard.henderson@linaro.org>
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   target/sh4/translate.c   | 4 ++--
>   tcg/optimize.c           | 6 ++++--
>   tcg/tcg-op.c             | 4 ++--
>   tcg/tcg.c                | 9 +++------
>   tcg/tci.c                | 5 ++---
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 15 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


