Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF00C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZw90-0001QJ-2C; Thu, 10 Jul 2025 14:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvUL-0007ab-Ns
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:55:22 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvUK-0005PQ-4l
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:55:17 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73cdff9a27aso299744a34.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752170115; x=1752774915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixUYbPFhJgJDHiiXUXa7CcYTS+QNrsgIDhV2HktqNTA=;
 b=w5Ts0Qjm18ErASwj1/ThiAv2dhKui2R3aK0BBkxL5HZrCVRR2mq7YMRS8M/z6/yz0C
 UvSCDb+NsEbys55EQyokyK3sE5E+oAUaRAEgVKElWEB7UXRT56ewHOVg/X65ExzOyIW+
 OS8B7EWIr9ILCwbh6K0oW0G7TBFEDMbR7zTsuFVsiIELqLhx7cV/taVPm1Ii+ATe7hY+
 BOBAHiiSL+nDtu46WfndernaoYnnFzodC5nbn066luizhAi93iY/LpjE3M5MIAov/jJP
 OvyvHva5x38IQRIXEDPjb1F2PuxOGtDixecFSkQCLlQnH1AKFsOV+xuMvvVWtAAWcQau
 Eizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752170115; x=1752774915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixUYbPFhJgJDHiiXUXa7CcYTS+QNrsgIDhV2HktqNTA=;
 b=qd27+zCo5AvLzZrXkIQxZ4VB6eMMsOt91jRrAGHf+ZVM87U47xfa2eTvYpROoRzEQC
 BhX6Lorhv1JXY5lKBYvOI0R8xI6vkQwHNNL1rT+rqdOXYdemm6pEOv9wsu4ir6+FHSYE
 26jhgBIZpx8jqTKzxfoOBXMQTV++HT3tDFu29tPZWacQce5SBMvg2gDGYVc19i5ZzePp
 rlt4xSh5buWpwT9x0Bob56oGPg7NbvQQPoBPrBL/zWEuIAH04Nh3lCmjmsxTkkipDDgl
 LVkyd27SWj5mL8UlexBinHsN/ihsBceF8MJO6EsubzT6J8N2oPrJpOWHVPj6aJssRuSw
 hrRQ==
X-Gm-Message-State: AOJu0YzxHgThKrvozCMFZqDXYok7/6oKr7B4Ejf+TrPqq39goCXoEuzi
 ZKibfZJ9gbUczmO0mOCLRvh2duj7NRFuDSU2xxqqk9OqXvP3qX3Nl+qHFOM3L/zS9N+Y8F0gPhA
 Smqu1YK4=
X-Gm-Gg: ASbGncuYsAocockinUZKC1D78+ou62fEXBXLIiRD7CK2RLSY79/AdhrrMLSYJtJGJqC
 dOEDRSix/ck/NWsz/ZjVBbCL/hXTi2NE6Wzg1EjSab6s6awk8zZsWh3EFaPixAz3GhonSwick71
 Bhvjup8vU9NNSA0V5g+OHJAvohvwiYptkexvtKPq5ik1Op22qq6TaX+7lZAyGWWrBAqnPXpcztY
 JHNJ/qEzzbLjgbBqkpFdWyivkdqAIdt6At54ZjMk0ifecuVsLffvZj4euYZoXdjLko1uMCJ605+
 E5y9Q0RMxnPnVj2eQXd13yVoCNcQigcONdsRvjGwY+MNaxAp4lfdtFsM2pGY8C7jE0ppZOll+h+
 G81s=
X-Google-Smtp-Source: AGHT+IF+ZnZcOBSbKDc2UqLeTHhrWvYEAsrMuN7/KqvMJjsEnws9EOoEZfxiKCSNy996VF4CyKstEA==
X-Received: by 2002:a05:6830:8209:b0:73b:bd5:b9d9 with SMTP id
 46e09a7af769-73cf9de52dfmr327309a34.10.1752170114732; 
 Thu, 10 Jul 2025 10:55:14 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10a5ba3sm281474a34.24.2025.07.10.10.55.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:55:14 -0700 (PDT)
Message-ID: <a78641f8-72ba-498f-a231-bb8adea9e072@linaro.org>
Date: Thu, 10 Jul 2025 11:55:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Check for EFAULT failure in nanosleep
To: qemu-devel@nongnu.org
References: <20250710164355.1296648-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710164355.1296648-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

On 7/10/25 10:43, Peter Maydell wrote:
> target_to_host_timespec() returns an error if the memory the guest
> passed us isn't actually readable.  We check for this everywhere
> except the callsite in the TARGET_NR_nanosleep case, so this mistake
> was caught by a Coverity heuristic.
> 
> Add the missing error checks to the calls that convert between the
> host and target timespec structs.
> 
> Coverity: CID 1507104
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested via the LTP nanosleep tests, but they don't actually exercise
> the EFAULT codepaths...
> 
>   linux-user/syscall.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc37028597c..c600d5ccc0e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11630,10 +11630,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>       case TARGET_NR_nanosleep:
>           {
>               struct timespec req, rem;
> -            target_to_host_timespec(&req, arg1);
> +            if (target_to_host_timespec(&req, arg1)) {
> +                return -TARGET_EFAULT;
> +            }
>               ret = get_errno(safe_nanosleep(&req, &rem));
>               if (is_error(ret) && arg2) {
> -                host_to_target_timespec(arg2, &rem);
> +                if (host_to_target_timespec(arg2, &rem)) {
> +                    return -TARGET_EFAULT;
> +                }
>               }
>           }
>           return ret;


