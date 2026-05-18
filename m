Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D45FCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzty-0007vx-IX; Mon, 18 May 2026 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOztw-0007vb-Su
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:29:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOztv-0001s4-Gt
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:29:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-835386ff122so2581824b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779118142; x=1779722942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teOCl3LvN1i0kvx3YQwhj9PLQixnZyE/wxqa3LyYTaw=;
 b=HXzWrnE25YZd7WJrO8xkZkk90t4CFX8PUWfzBvkGh7pGRKBh3uWDJUkssgBKdZ13Cr
 Xo4jcfTBIu8yofUc4j5AN648zpP/7TDC4GTyqKHHm8gHvJzOUv60ULmG4bHi7wsQJp+f
 gyOh1KPLSuuLVaZido/SWDVwhcqH70VDrfCQSnU1/mgzXc9u15V6D3GgdfZUJKtHKBme
 Sy7XVAnNh2Pyy/rAReYeP8YUZUwtJxT330Rp22h04/sME5g/hyR6xSl7/abZt/Hzi4/u
 gYaGQ1gMbXK7BFvB1m+deq7rBt7EOtOeWl6PwzC6t4SAmTDwHNsZVUnaDvmGgVmthGBH
 VS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779118142; x=1779722942;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teOCl3LvN1i0kvx3YQwhj9PLQixnZyE/wxqa3LyYTaw=;
 b=ZBhd3di4FNJfZnNSa+HMc8AOdHkSz2nX1XQ1+aXX8XrZKe1+xNK6XPBtoQZ5L9yaIW
 4mmcphvbGW9cHPJ+K9mClVu1vyUoVujS4g5wT/gGWrMdy/SMGDiWDNIGXoH+TZbhH4BX
 8ZnHyBnDGfuUHmDBOUfF2qm6jwKxO0LtCT2eJ9bp+addThdtoNHp1kVZWShQ8WVjCgVt
 BLX8/fTG70MtjXm7V3Kl/OCFiXiqWDJkPIhNurUG3BwJRlCmCMWDjCznM97DSHf27X+4
 WQR7GD9SLXkC0KL8JgJvITL1uIr+i37QZsNMGqUmuk7wKyocRNQZsWCxIOj1GedMsdY5
 c9lg==
X-Gm-Message-State: AOJu0Yyyjw5zfL5gRnpLLkFLXyVngFsGdP/ZtcJlvxlLok0zWKaCMFCb
 OycyRmHWb18q/k5BMhh4qPph8XWqa6+9YmNeuSazKFEiYudkewl/nqIrIFypD05P+ENQRHLkKV3
 s3Qk2By4=
X-Gm-Gg: Acq92OEARIxpkwl5TDl4qtICMArG7z5BEswWOwo3YFv0A4ClJyu0xtcyO0CONHsHUbE
 6VwHgUlsjHU6p7jeazjMkn1pM8KsO+xdGEZCYMkdVDyGny1ldzjR+FVofYrdLbol06lQDTar20/
 sw+UFJuw65PvgZaPA8W50JAaPns9VoN8aMLXUf/x9kckLKk+L9/pCr2WIf8j4eaWrEK+7PkT9EK
 KzKcVG/Zzj4kjXNzsCZaXQ2XyQC/CI+MHfyFX41V4ddDCHI3WZnTYEnNz8DY5D1GVkPYD/uDwLv
 hqBIXcyVaicUe8REe03+yTZKOW8FLnEV57fUSmiFpJfzKDhw/EKoyI69PUI3T03qHJ6W8QT7wv5
 9FaZiEqUuxXSnUkpQmRXR1ud/ZrcBL4GzXSsgdPQSyqDaY+DixOIfopdtFSqRxvYbQlAFgkq3Q1
 sAuK5J0e/OIGZRdPRXPa8i8DBwVTdiJTlIFnyE
X-Received: by 2002:a05:6a00:3990:b0:82f:1369:7268 with SMTP id
 d2e1a72fcca58-83f33c3b6bcmr15242976b3a.30.1779118142052; 
 Mon, 18 May 2026 08:29:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5b296sm13884049b3a.32.2026.05.18.08.29.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:29:01 -0700 (PDT)
Message-ID: <883b8217-00a4-4f87-8d49-17f0a373c050@linaro.org>
Date: Mon, 18 May 2026 08:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/14] target/arm/ptw: Flip sense of pmsav8_mpu_lookup
 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

