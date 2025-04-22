Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F4C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GHh-0006HM-B8; Tue, 22 Apr 2025 12:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GHW-0006A7-T4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:15:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GHT-0006UM-Q2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:15:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so71705e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745338527; x=1745943327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwQ2pU1yHtXZW0k861UiUgQi1z7mpZW7oqvBaDy6lTI=;
 b=Ioe7b3LpdMfikcluw13cFepw9z0gEbnf8Qs+vlkVqFVosV6Hy4qkeELC8K/2dzk+2v
 WEmrosNGwMCg7mq9Rp5xfXgNlPrx1vqNGPSGP0RnKmTRRejR3vihY0DFeRLyNKhkUz4h
 Qw8AZ/u58WleSETNC/BRTneEX9dYCEN17O00TQVjP5hF3ckBfppceL4qBQs4QBjlIqlK
 BvdJas/CLjqdDBIvEdiz3Uut9nxoQruDcGnaD3PlDLaW31oPhbjsdKTje4yLniweKT+N
 6KwRmSv6gcDBCXj+ahBXRabUc5JSi7FIkD2QVKNtaTTGwbB05fCL2r4c1IR7qDUZwCJ0
 NKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745338527; x=1745943327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wwQ2pU1yHtXZW0k861UiUgQi1z7mpZW7oqvBaDy6lTI=;
 b=H9u+cl7e6ZxB7LiKpQHUKA+PznebFS/P2iFJJ9OX4rtWcXye97HbYmLOHOUo1JzTRw
 LiYx9dyT6775dl9rz49DyQ01FG2YGMVkG5Qzy/Ir4JmeeB+AwHsgic8MAope69Nx/CAT
 CxKN9NSERqSs926iKRmDxUTSSocQikJbrDlA1kTfDG/hiZ8Rcov3xRFEmuLYqh3QdBPd
 eg2hwwIQbUc7KJ+jeCAwwxa9UBGyAwov/+1qBKumxGEf4kky9sySW6q7Ieb2DveivuEx
 oPvkesDsa5cqAWmxIxLmqQha5aNksxVhED79rdKpgC3DpEal1XqT1FqRxQpDlWYjJNR6
 tmEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg69NJWC6y6mNdJZyw4/yv7qtq+bA69kPZZqsarA4kXK7yiLMBS4CRE/R7ueUlk2zm2VYVEGa/Ks4u@nongnu.org
X-Gm-Message-State: AOJu0YzMvHRBQkimpcSjB8GMO7AcP6GeFAAbxnzui9v6m7XFIvbggtir
 TjuwFV8A4Yp4znZlpF/CgxyO3FOFnqTWXWeO0iGCwhYic0DJZ3lzTxuaOroeOZSoNihsm38AEib
 z
X-Gm-Gg: ASbGncujOrwl/AlCyOe68W78V+izbBVbGKRvVCtjmnUGvS72D1DYGBfNzEX2gtN/PzU
 K5NyRK4pZcDRMz1GJcEDl2xNKnXpxkooa4LSdDfo+gxZHyPhvd6HiF8KHAyD7uKXSo2S95YIqPw
 3vv64znk+noZD9DPNY4xjEhZV5IUU4L23Vgf3xNokn0Xkkfre8iMUJNcuOxyIJQHIeQQHM4+2SV
 nkhyC7X45YOlLcMLSdNpVFihHf7V0q0hCs1SUhc7iH4NCVp+zEt/5gkq0zwVJcvpepLpqVj0uKe
 79a04Rdcxe6pyEqNULaZiddsbOD20AFG9Olz7rZTJdP3luZSX37vdjH/gKWevC7z56oTHTmK8N3
 11I4BzpUz
X-Google-Smtp-Source: AGHT+IElTLScD4Ff9IKMqIx6eu517f1jCB/vsWHlyYcm6wa982l3AeDKggv3HBKgGYJjyQTmRztnFw==
X-Received: by 2002:a05:6000:43cc:20b0:39f:c05:c220 with SMTP id
 ffacd0b85a97d-39f0c05c2camr4274298f8f.22.1745338527628; 
 Tue, 22 Apr 2025 09:15:27 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa42082csm15616522f8f.3.2025.04.22.09.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:15:24 -0700 (PDT)
Message-ID: <1c7729f1-a9b5-4918-af45-95ff178edd2d@linaro.org>
Date: Tue, 22 Apr 2025 18:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 124/163] target/arm: Use tcg_gen_addcio_* for ADCS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-125-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-125-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c |  8 ++------
>   target/arm/tcg/translate.c     | 17 +++--------------
>   2 files changed, 5 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


