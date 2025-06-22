Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ECEC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA7I-0002qU-4e; Sat, 21 Jun 2025 22:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA7F-0002k1-UR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:07:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA7D-0008RH-JL
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:07:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso279725b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558038; x=1751162838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=92+ZO0Z/gfxDVIJxoKZFOS3UpT0ghIlIn7Y0MrwF+pM=;
 b=imw0fOVETzsMyqDrURQlZHd4hwHLTrT8s2geKmAzOdv1ZVTVljNMvZT4W7Cb5tZvMy
 4qU815fci0Y4EagHaL7G5oIl1lc4NF4s8iIAQd5OeepL9WUU1270sDtupzUyxLWiDmDc
 X3Qmou/iKwG6fXJdYPH061aTD3C+PsC6ej2zkFtxoFpBLURQVHAySOyKcAPTHhIFtKbd
 nvHMVP5dAiXAC78+Fm0e+jtS+INfudvGpZcMz8eWkvyn7R0DTTTlLxUYRy+jTqWCpxyH
 /2COGFg+S+mTpAdGxu0QUCXDl1Vu8xWslhqq6rARGjwBQolP/LvGiPzUPBkddkQyAyxW
 whGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558038; x=1751162838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92+ZO0Z/gfxDVIJxoKZFOS3UpT0ghIlIn7Y0MrwF+pM=;
 b=jQR4XOwCvPOi1aN9gAl01ZMW5pzM1zirVOI1fZPkfNCKY3lFmKgfxU4mIH9PK5VtyE
 NGbXhwVgGw9o7ZJmbN20TdQNWeoxVQ/TCgptxjdiI2nxYT8kknCTnunD7hFHR/bKRYDo
 eIczKbf8/Wjy5HzYAnEnDxli4etMjJy5EwjVc2Eth64C4EKk9H/HVPBjwI2moyDVOUHw
 hn8wV5K0ZRG+Yyaz+W/qzu1csHeB3BmFbvox8cLgJVzxLh4uU52/PCAAWEbGQ3Da/I5b
 Bv1eKFVad+7cKZuk3pQ0s1HbOKKoUmKNdnQxngUkEcAz+nFn3VWE00BOVwCAacOlASXg
 0Izg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXApvY0d821xi1sczYM6dLROc9Wfn4LU4BeUxtdkfb6L2DYd+uH3kBtRRAGakTK/v3yMkmZfL+/BiCK@nongnu.org
X-Gm-Message-State: AOJu0YzTEKATX4Y1K2vKRRvIGjBa5EvsxjOoWxMtaw+lSjHt0IRIrk4M
 BpCl8cHiBoVu7WKolNmPxv6wXO43JlC1oWdxLDq/JMqwZ0C/HKrWJSAPexSfKgMGsNZq7BZ2u+M
 0JhLDCeM=
X-Gm-Gg: ASbGncsfA9btnegBBmDoeRnK91LWgl8x8hguQRULfjHYjTaoLLoLSR5P8sVnhRXkJtY
 p84rcY8KCIg76xjAMWTrr2Y612GInhgTEZFl4FjLlLOy0IoI6Bss1ljhSaa8iyboS/TDbjaj5f+
 IKX9Y6/JDOufLBFVCWxr5aDjYMJpy7MJRQSe5/VLW7iBp8LSCy0UCY4g49JGM+1CDQET3noCdYl
 uG3e5rdsvPJjL03v5cbljuk9IkkVgDXT7Ifn82maSaqTJKYOTSCAWFoYJDFH10hzK/eZvjfrkqz
 TubwYDvUQQX15Q8nbV3Yt6CnoHIRbuvqIWeGP79PrA21crF/S6iWzk7Lw6IT7SNgVw6UqLc4nda
 vZEyXSgkP1yGzYN/Ox+qEZgUNaz8DPoVyjRal1o8=
X-Google-Smtp-Source: AGHT+IGCfRMZEEiv7zVjHggpqysDwFm+zNbD3xWOB5lbSqEVU2+pplpMpkwKd1aqVvAvDvA6pqXtAQ==
X-Received: by 2002:a05:6a21:3418:b0:220:21f2:8dab with SMTP id
 adf61e73a8af0-22026ec3e21mr12304717637.21.1750558038326; 
 Sat, 21 Jun 2025 19:07:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a621cafsm5366865b3a.101.2025.06.21.19.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:07:17 -0700 (PDT)
Message-ID: <d5aadcb5-bb50-47ed-849b-2a0c33bdd242@linaro.org>
Date: Sat, 21 Jun 2025 19:07:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 38/48] accel/whpx: Expose whpx_enabled() to common
 code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-39-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-39-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Currently whpx_enabled() is restricted to target-specific code.
> By defining CONFIG_WHPX_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/whpx.h       | 27 ++++++++++++++-------------
>   accel/stubs/whpx-stub.c     | 12 ++++++++++++
>   target/i386/whpx/whpx-all.c |  5 -----
>   accel/stubs/meson.build     |  1 +
>   4 files changed, 27 insertions(+), 18 deletions(-)
>   create mode 100644 accel/stubs/whpx-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

