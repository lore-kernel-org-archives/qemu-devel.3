Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33181D25028
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 23:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veiFs-0005pX-1J; Sat, 10 Jan 2026 18:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiFq-0005os-7V
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:20:22 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiFo-0000s4-H1
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:20:21 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so36841985ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768087218; x=1768692018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HURgAcqgFmAnO3WqF5p1DIsRzFEdhjZY5Wvc+14O/M=;
 b=XRL8zdXEBIgAXxSxQrwKjnRGfbo2quJvUSB78JC92sQcACHDf+C7t+zlHTkE5R4Hw8
 TXEgdMT2sY3gBGcd4N+w+cYg0OC2AIOnYjIcwJTJBv180JpQG9ZVdB8LseAEHGj4a57n
 nF2LKQFPvZKQhjFdOegPobSBBqCVV1/N5BF594xnXh9KRkrnxdE67URcIFLvI0NIc8VQ
 Wj4pUmsAenpBqlH5NrBLmPfAwu9+yP78CIGG2rAR5gf+VF7tG647ju0U23dPE4YKSzo0
 4mg3A7h8uW9881+gnxICCcB472OPjlJosc0aK8w1upzZmfNkAadfy2+jflg+1RCvbQ/+
 HobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768087218; x=1768692018;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6HURgAcqgFmAnO3WqF5p1DIsRzFEdhjZY5Wvc+14O/M=;
 b=Mjm4H4zycaqIFlTusccVAZ4i/75/W2qCxw2FxvacYBROW4MlI/JTnAb1n6RRAuaMIe
 9q17Hcvzu272D0zaLAJLUATGmsMaw9RCoKPO8mIHi2DpN4+gOhGwjp+2xchrVh6GEcvJ
 XvMUV3rdTjZmoVa5joxSRSFDAaup5Ds8DEIJaRNjz/apgoYNClNjMNh1LfHJ1uRxWvYc
 oF1x1s3oveUq3ZbZDYPMQqsaerqb6Seh+Et4qsCz5FkICMk8ySCTIgqb2AQ2cW3i4yoT
 IQAm+1gSz1i7QRBWmobnq6MbgYSvKCxCTmV//1cYDBDOVb+XgIHmwMILIIUlKZUzsvPY
 48sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJiVVnD/M5QEKd3JAUho30YzaiIMYmL2Grbup3TgQncYrd4LodPEJhipgukE93dmRcL4C08M51T7HR@nongnu.org
X-Gm-Message-State: AOJu0YxLiyNLhwy7qubCoPHIeX5ebAuzztu5mI5rR/Wmi9kOjOsHDlBe
 m4A2/IRwgJsQKODD5NX3xMxECIvcH6jZF0H1FbfHjy0+bDZyWdMTAyMDRhttspnmhy+dn1ueYCn
 PlO9vKPw=
X-Gm-Gg: AY/fxX5ZD+vu6btjGTLmRaa88ym9bLiTsEnW+FWhpw4xSCtbsXVlOxSc7dP/9E+0xXy
 ZMCuEpKG2lDCkf6zGcYFvr4OHdEXuHoHSUc0Oj5HJqS8Z7CzXrLOyHi9DpLH9/rRTBT0HzxyyTQ
 Q96zybJS0YrmOE3gcipKV2fvmOuDkDigj82KC9eQwlUgpTksVMS4RSVkqF4i4YCdzm6FyTNaB8F
 H8xIPfVABbm4ZnrL4AJKHYt2/2Uufkp9YmFKIbWFBan2eoAjLM0yDJMfSLytGlM/jlVKEI5AJ95
 0y3tJxOODbIxTI+V6cxCYohQ+5jIKpB0UFFR6dOTCdHGTvAZ8bd5AIUEwgtbzmuTqvn0wyrGvXF
 M1XEvehP8XD2gPEbBykkswVm6sTLhkCjlE0AAmUpA2TtV7TTSZrIK4i8xiwtDr+nEE+TwJv4901
 FH7AUjY/iZjuqncVlpVs88e884Ug==
X-Google-Smtp-Source: AGHT+IFLCxLQt1N0HloX4o7jjXiBaifJkzELOrHhOaFllAexiZLDMNXaoFUxV3LjiSy9ZKK84rRWAQ==
X-Received: by 2002:a17:902:cf01:b0:2a0:acf6:3de9 with SMTP id
 d9443c01a7336-2a3ee4c293emr131186715ad.58.1768087217699; 
 Sat, 10 Jan 2026 15:20:17 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc8888sm135952135ad.76.2026.01.10.15.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 15:20:17 -0800 (PST)
Message-ID: <44e74d67-b32d-45d9-98e2-ba452bdf69ae@linaro.org>
Date: Sun, 11 Jan 2026 10:20:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] linux-user: implement epoll_pwait2 syscall
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109090937.599881-1-mjt@tls.msk.ru>
 <20260109090937.599881-3-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109090937.599881-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/9/26 20:09, Michael Tokarev wrote:
> epoll_pwait2 is the same as epoll_pwait but with timeout being
> (a pointer to) struct timespec instead of an integer.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3210
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d89c36382e..8f41cdb94b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -708,8 +708,11 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>                 size_t, sigsetsize)
>   #endif
>   safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
> -              int, maxevents, int, timeout, const sigset_t *, sigmask,
> -              size_t, sigsetsize)
> +              int, maxevents, int, timeout,
> +              const sigset_t *, sigmask, size_t, sigsetsize)
> +safe_syscall6(int, epoll_pwait2, int, epfd, struct epoll_event *, events,
> +              int, maxevents, struct timespec *, timeout_ts,
> +              const sigset_t *, sigmask, size_t, sigsetsize)
>   #if defined(__NR_futex)
>   safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
>                 const struct timespec *,timeout,int *,uaddr2,int,val3)
> @@ -13619,12 +13622,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>       case TARGET_NR_epoll_wait:
>   #endif
>       case TARGET_NR_epoll_pwait:
> +    case TARGET_NR_epoll_pwait2:
>       {
>           struct target_epoll_event *target_ep;
>           struct epoll_event *ep;
>           int epfd = arg1;
>           int maxevents = arg3;
> -        int timeout = arg4;
> +        struct timespec ts, *timeout_ts = NULL;
> +
> +        if (num == TARGET_NR_epoll_pwait2 && arg4 != 0) {
> +            if (target_to_host_timespec(&ts, arg4)) {
> +                return -TARGET_EFAULT;
> +            }
> +            timeout_ts = &ts;
> +        }
>   
>           if (maxevents <= 0 || maxevents > TARGET_EP_MAX_EVENTS) {
>               return -TARGET_EINVAL;
> @@ -13644,6 +13655,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>   
>           switch (num) {
>           case TARGET_NR_epoll_pwait:
> +        case TARGET_NR_epoll_pwait2:
>           {
>               sigset_t *set = NULL;
>   
> @@ -13654,8 +13666,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>                   }
>               }
>   
> -            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
> -                                             set, SIGSET_T_SIZE));
> +            if (num == TARGET_NR_epoll_pwait) {
> +                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
> +                                                 set, SIGSET_T_SIZE));
> +            } else {
> +                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, timeout_ts,
> +                                                  set, SIGSET_T_SIZE));
> +            }

This second test needs to be vs pwait2, lest you break epoll_wait.


r~

