Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB0C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqB9-0001zH-NB; Tue, 27 May 2025 05:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJqB2-0001yP-S8
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:00:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJqB0-0002yo-TR
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:00:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so42743095e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748336448; x=1748941248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUxGAa1RGBs7P/A67C3rZhqFuFMxhvGERAvJoihvuwI=;
 b=lc+77JdcMFMJoaxI0+7C8QtAP5oK3Rk+zhZ2w1Tg+pQmnOc4CA2Rc8XvAwwdiHsG2o
 vw6G0NNjMwrHaFKHu/6JbzvhIpnGGMBqJ2auv9F79r+OWVXSlbiufovEGjma9KFSnuvL
 4c1KVLTyhokb3W7LK21d2abTGdkqTMpyYOVW9/yv9I8L2ECaeJOmwWqg9KMXmp9Og4FO
 bjdWFUdC1NVsbIJCLa8LPMhqz6hbZUJNBcQUhJSICOkHcElE4zbhD2q56VIhLuSEYFYk
 X4WjXVIHzDSpyG6Gc/PmqnbduYR00mSUg3NrTpJGwK0PuvzT71ZQvOgxJJKKoJ9HPCus
 VzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336448; x=1748941248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUxGAa1RGBs7P/A67C3rZhqFuFMxhvGERAvJoihvuwI=;
 b=ZDg/L3k6i16+Kzrr2nIlH2anurZFECuv7bc7R93lrcXZwo4CpuUE5zbvC6Wz8Xv3U4
 kyem6YGh304WtIoLXvOdciMipT0OsIOtRBighgv70fsQ5ef7dMPxJYpa/pe1//KZmyAf
 +ZZ/lbGYwcheZ3+5Xq3/ItQ1Da3/9gPiLJZ8a59rGdZDMlrxqLHAeGqfq1mDeu292jR+
 WI6nW71mtPvE8aLXbI837U1zcUQTbuvLCS6RmFyr9MZRWKb32tLBX3+oaWQJh/ClkS5T
 1A22/1ZxHNpRMKR1w+FCy99A1EevH8h1s6Qi/qY/75PXrjAHDKlFMeDgoLBUqwSMx6ya
 Ehag==
X-Gm-Message-State: AOJu0Yyyw1nmSBL9WQCM6QoJA3ssWhVzz1Xkq1T3HWSY0qnB4qOJ4tAI
 jJ0NIUIZSXLB74iEaFVzr4wOSy2Vlf/44uzkh3WbgBiq8TzblV+s9Z0UTQGHCPeiJFWZKd/s7ZR
 5ML0DXLrrJA==
X-Gm-Gg: ASbGnctuZqFVbcgPcAipEJ7IoIjTtsENCQuJM53Sy5UWNF53Ty35ErZgvM4efS8sr/q
 ySDAF59bJteP65cGIWoV4U9G4vY2mSe1KC9DOAPRuyRovXs1Wu3y51yOzNIJTO2p+GzvcorzNDZ
 1NQRrtEcOrVBMpIyC8Jo1iZWgbxeD9O9ZD/q20fsDF9Cw9PIH6s2323SQCejaXUqVbio2oJN4ZR
 brwBIDQZKQxk+4j/ywVxKCYGaC7Zg8WOSIqxLLJQ37pUEDy4tUlcxnqgr/tDFXndZBEiW4ucqts
 lt7+f3fVPb0vGU3vaIMv8HUAHKxUoM5oR3CTIJ1txbbJEa1ob/IKs3Dnjx3IzUzA2Q==
X-Google-Smtp-Source: AGHT+IGHkP5ftYZfoavsboZJHTF/+VyHcoTRQKMNGpQbyrL1Hf2PPHa+WEPTEyABd9mUCGKg+rQj7g==
X-Received: by 2002:a05:6000:2408:b0:3a4:d0dc:184f with SMTP id
 ffacd0b85a97d-3a4d0dc1cfcmr8181879f8f.39.1748336447929; 
 Tue, 27 May 2025 02:00:47 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37fb452e5sm19630010f8f.20.2025.05.27.02.00.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 02:00:47 -0700 (PDT)
Message-ID: <aa2b9b07-3a5c-422e-8b8b-c6e82f3ab2a2@linaro.org>
Date: Tue, 27 May 2025 10:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: implement pgid field of /proc/self/stat
To: qemu-devel@nongnu.org
References: <mvmfrgzcr4m.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmfrgzcr4m.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/20/25 15:07, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8820ca4dfd..5536e364dc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8235,6 +8235,9 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
>           } else if (i == 3) {
>               /* ppid */
>               g_string_printf(buf, FMT_pid " ", getppid());
> +        } else if (i == 4) {
> +            /* pgid */
> +            g_string_printf(buf, FMT_pid " ", getpgrp());
>           } else if (i == 19) {
>               /* num_threads */
>               int cpus = 0;

Queued, thanks.

r~

