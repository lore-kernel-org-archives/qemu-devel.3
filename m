Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DF5E63F32
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 07:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrt1R-0000qs-Ap; Mon, 16 Feb 2026 02:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrt1P-0000qk-Lg
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:27:55 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrt1O-0007wM-7n
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:27:55 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso1379113b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771226872; x=1771831672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9bM0D+0h/RJm4CYvudbWeupqxuHiioSrGUMG+xIyaE=;
 b=g/A248WgnTffNz6pto/LHauoBffbrxAfKvYBG8WkATmNkAE8+TiD3rgzfhuPSv0PB/
 qgn/IXZQu7eLCGUHb6PhkmU3eW+mGTZWy/ujpxSz+02L4wo4M0F84Df5pbev1HRu57bU
 a2NiwQDNtNOzVsIEF4YL/GTy77c1xENk00n3+4vppTDqZMQ0cHUSvU8/W6P6YcwuPZmw
 uIGMi0IK23+Xqujvndrr6GfiRWhYbKDHao/xL/pZPncjAvc/Ra0t3ZQ4QkTpqJOseh6Q
 pHJo/P/4FVnSOOzx6rgJrAQEHE5gAiDAZgYdbBs6Ttn1+jU775GQjVJZiB26cNvTKJsD
 H/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771226872; x=1771831672;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h9bM0D+0h/RJm4CYvudbWeupqxuHiioSrGUMG+xIyaE=;
 b=hWt6HTCC9MloaZpIvs5VJmidmhONHJEbx8reI8XvU5UpywVhiaE5epJt2g5tEyMXC/
 8QK0f8S1ErO4YZ0RrKdNusFbKvTcasIQUlIpvfzLQ2QJ0YuglTkNfmlXijqu+ksc7Dtf
 OaHrnDqNEG8Lr5ATQSqOrtmib+Hf+NprxChieUwUMpSH+1x/Q6KBtJffJuW4sfKLHImi
 wX3sZdZyxmoJcBbSbqw8slBCb4hKV50so/hob0kn6aanTf+ivHPjDUZ1IZ1VvbItjKIn
 yzl83EY0H6BnPYfYx6R3+qzgcxCTVyH45y/0lpxbCiIuKRYBlfUqfKNdlJLxVnE6bZKH
 nINg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSS2sF9SpvvWaVAMyEc8smLi3fCl13GGjPpIFtt0ImqtH/Oe3+oFQNhj54lbNMnuHkodiaZcSssrhT@nongnu.org
X-Gm-Message-State: AOJu0YwvIXW2ya+A5obxTuG7ZmIZuj/+38Ep0+kJkEWluf3REZEHBIDW
 9Ls94GJNEmo2RXCT8bizt6/Q+lVzwMhKqC0Znb/gqcQYf6YX2aYw2UFIL/dif4tNXj8=
X-Gm-Gg: AZuq6aI8CmQa4AO+XF6dgKE33Wqf5iGl7v4Ura+iKb8xX1cKicW/M4sosWRBYugFixj
 Fi2Yhay9pKmzLLAiD+nO8tqt1IN5WXKFPwLJ6qyKX6WIIiS0kCNCdd/UydCLjHNjt1oPUPR5DGg
 IjfshzaYcU1jUZwnA/xxYvLLMYlJ2sLPGUoxpZnRxvwy0Ta9QhyMboSRVgWM0XCcumzmoRr2ccT
 Xs+YFnjNH2OJobnXgq5jVenSdtfUV9lwNP6UIO1jOLMCsvQg9/pir59Phe2vv2GV8hZgdQOLh4T
 myICSyybJ6QQsheM6/pVodeW3SqcaS8KGMiY4qd2nVcK/yrhgwizPI/9PYWklTHFPZuuzEf6OEV
 iafVOyOaWphVXA0rGnlugjDprHo/LZ0QHEcpA13C/se/uuJMWPcln2Zt63fA64pSE5i7q7x2u+G
 aNsE1NAGoFKDqOBaYbsXtHHC2D7uRlnhBCaNPYfWzzjshN477OIzNS/9wCbLeZJQWe5uXeNEDMY
 JORJECpego+GzZiEtUM3A==
X-Received: by 2002:a05:6a00:228e:b0:81f:4675:c2a6 with SMTP id
 d2e1a72fcca58-824d94d00a0mr6433443b3a.2.1771226872154; 
 Sun, 15 Feb 2026 23:27:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:4a1:428a:70f2:5844?
 ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a62c48sm9525281b3a.29.2026.02.15.23.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Feb 2026 23:27:51 -0800 (PST)
Message-ID: <600adf7c-2c6a-43df-9214-144ed03f8f11@linaro.org>
Date: Mon, 16 Feb 2026 17:27:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] page-vary: Build set_preferred_target_page_bits() as
 common code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/14/26 04:27, Philippe Mathieu-Daudé wrote:
> Allow common code check TARGET_PAGE_BITS_VARY at runtime
> via the target_page_bits_vary() helper, then use that
> in set_preferred_target_page_bits() in order to build this
> method once as common code.
> 
> Philippe Mathieu-Daudé (5):
>    qemu/target_info: Add target_page_bits_vary() helper
>    page-vary: Expose TARGET_PAGE_BITS_MIN definition
>    page-vary: Use target_page_bits_vary in set_preferred_target_page_bits
>    page-vary: Build set_preferred_target_page_bits() as common code
>    page-vary: Inline set_preferred_target_page_bits_common()
> 
>   include/exec/page-vary.h          | 15 ++++++++++++++-
>   include/qemu/target-info-impl.h   |  2 ++
>   include/qemu/target-info.h        |  7 +++++++
>   configs/targets/aarch64-softmmu.c |  1 +
>   configs/targets/arm-softmmu.c     |  1 +
>   page-vary-common.c                | 29 ++++++++++++++++++-----------
>   page-vary-target.c                | 25 -------------------------
>   target-info-stub.c                |  5 +++++
>   target-info.c                     |  5 +++++
>   9 files changed, 53 insertions(+), 37 deletions(-)
> 

This patch set moves code from page-vary-target.c to page-vary-common.c, based on the new 
target_info hook.  But since TARGET_PAGE_BITS_VARY is still used, I don't see the point.


r~

