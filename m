Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCEC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WdS-0001Hx-Vd; Wed, 23 Apr 2025 05:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wct-0007Xb-Pn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wcr-0008Sj-QP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso59252685e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745401360; x=1746006160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pk0z//l7H5AQM3pFebl20YpP/76wc9xrCy7OKB46KV4=;
 b=p0haFd3uMHak0BpSrJh5GEKsMUS4i49RQuNtqn9EqPzRdY3sfnAgZuZVa4vzQ8aGjK
 BaFxs+m0bYUs6ptgMJORO7V022ZpxFgzkFQqIOaYqS+vJua+dQFdl7Fkg8CWlk+RGaP+
 k7vhmZz6aihnYvgdYN+kPRvELlEsXflp9YlhPi4p8jrM1tNv8HBtjUQwmvlF61w6PLjh
 Sfc3RtgyXha1DKNOGNIu17bDBQ+wsUYBI5xGRnnjTqZW4NCHIQIUOXqxupFv5LAtIKdy
 Nn3GkhektzfxbBsDguKayY7h15nopiNiUczMv/4HymU03jDVRSjtBhbvaursva4iS3Eu
 zfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401360; x=1746006160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pk0z//l7H5AQM3pFebl20YpP/76wc9xrCy7OKB46KV4=;
 b=CqgJ4jvsKkA1Zp2NzERZPMQX5AV8IjugKWFYjm0qRn1lY74EitCeBiXpN9FJsbTJNZ
 RKlm5SSq8vU4o+KVNNRu6ZHmD00bAyYYG3+1ebqBKqZms3nY4JAZU5dbq4mCVRwaPZZ/
 QjIA7TmEXMCpqv/X2EAjpMj1feo/0m/dxmHljpcFsxHTtit9ugA1IR0sepyY0aqQlXJP
 EnQE6PLBb2NBbItJ0RLWtSZ/wJja4YehmuCXx63ggDxUVqg2PNJqiIGdGpxNDb5VT/Xg
 Uk+0+YBLeLnmBIKZNVvnZlvtiEB3wPRkSke692suBAVqB6FTjpJg+y2kR1yHJR7g5ZeF
 qq2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJyJQWValKi5jQ8vRpoMD6UecQzogLB6zl7lbApj+mx7WTqid718iZsN0ZlbCKlMgA5N9+2YLCgmN8@nongnu.org
X-Gm-Message-State: AOJu0YycYK39aV3VIIVfmrugnWcUSKRWhFonqGq115jb1DahobXv5xeW
 SQzmuVfyurpg6x2OjXQYXk4xNpCPskhjlYgSVIElqqQbm9RSBXH8J0gYv7PIDg2c/D2AqVbK5L3
 x
X-Gm-Gg: ASbGncsDnMIfeBEOt9V/NLFYm+Qmw8eKzoVX8XALo3/kG8WYJvmMNj1tWLMBJJYtsQu
 uS/VzU9Yx76LpUj5as23UVRCDxcfgtRF7Zxn9z0H1x4Q6dESb27TUva9tInxR+U14B1a9G3/8Ng
 GwLO6uGfKy1bPiJDYPD+9LBcduoBciLq/Tca+7sIobYJ+McJOCwb5gFVjkDr5ExneOngFlk5dT6
 OaCDPrqwGOFzYDSf4kQzo+BYWh7ak6MF8+M0QrjsaBTALah2nOTNDVdyn8xPWJmarB4sedIK4YM
 LbexVdG/UnR0tAoldOH4c3jZ6TTfDnGp430DQ9rHDvYA1RUDVy1VZQly+qfJfA+LnJrRDonqMBi
 tlm1Fm3iKPLtWQVls/JU=
X-Google-Smtp-Source: AGHT+IEwy2r3JIiFCTKDfvFKRU2rXv3shfSCMfa3RwPSc6/yMuisdakn4o+ZFtOHjnBjyaWqZKZ9ww==
X-Received: by 2002:a05:600c:3d08:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-4406aba8457mr190215125e9.16.1745401359904; 
 Wed, 23 Apr 2025 02:42:39 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2d558sm19774475e9.17.2025.04.23.02.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:42:39 -0700 (PDT)
Message-ID: <a8abe93c-bde5-4f71-a2e5-711893634a0e@linaro.org>
Date: Wed, 23 Apr 2025 11:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 056/147] include/exec: Split out icount.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-57-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-57-richard.henderson@linaro.org>
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

On 22/4/25 21:26, Richard Henderson wrote:
> Split icount stuff from system/cpu-timers.h.
> There are 17 files which only require icount.h, 7 that only
> require cpu-timers.h, and 7 that require both.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
>   include/system/cpu-timers.h      | 58 ---------------------------
>   accel/tcg/cpu-exec.c             |  2 +-
>   accel/tcg/icount-common.c        |  2 +-
>   accel/tcg/monitor.c              |  1 +
>   accel/tcg/tcg-accel-ops-icount.c |  2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c     |  2 +-
>   accel/tcg/tcg-accel-ops.c        |  2 +-
>   accel/tcg/tcg-all.c              |  2 +-
>   accel/tcg/translate-all.c        |  2 +-
>   hw/core/ptimer.c                 |  2 +-
>   replay/replay.c                  |  2 +-
>   stubs/icount.c                   |  2 +-
>   system/cpu-timers.c              |  1 +
>   system/dma-helpers.c             |  2 +-
>   system/vl.c                      |  1 +
>   target/arm/helper.c              |  1 +
>   target/riscv/cpu_helper.c        |  2 +-
>   target/riscv/csr.c               |  2 +-
>   target/riscv/debug.c             |  1 +
>   target/riscv/machine.c           |  2 +-
>   target/riscv/pmu.c               |  2 +-
>   util/async.c                     |  2 +-
>   util/main-loop.c                 |  1 +
>   util/qemu-timer.c                |  1 +
>   26 files changed, 92 insertions(+), 75 deletions(-)
>   create mode 100644 include/exec/icount.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


