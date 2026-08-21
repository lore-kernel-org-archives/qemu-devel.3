Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62D5C5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSK1-0006pG-F0; Fri, 21 Aug 2026 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSJz-0006og-7x
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:42:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSJx-0000Gw-7e
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:42:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso993331b3a.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787330539; x=1787935339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jiDq9Sjg8w37YwEYI2mQKZPRps4DynLEhMIzcvZp48o=;
 b=FbP9doB0nZ855DwzJ4VzZa2y+GZnXOdr/VNDLH7UpX+Bb00lv9AAZ4rE9Y2JP3+YSn
 SOvuTE0t7yH8agYtHREoXq5BLchHczostLOKrzI/zSvL1adr8wr0cix+5B/zACREtGdW
 L01p/fY3QcZA0Z/HxOJsesU6WV8/pI70OnjXAkr+zH6NYftVGwAQlDi23YzRsxuesHqZ
 l1cWztJJ1Erd/0L4uh1HwPOHwyj8b/7Rfk+N45ArjkXZ/SsMl3XyfEj3PZjL2lguHUBI
 wpXV1bo09OuP78EmaOqvZdg7Yw4xsg62Ts3oNJaX5Qg29XWTEVzvsHAQm2bZT9ZrGi51
 vPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330539; x=1787935339;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jiDq9Sjg8w37YwEYI2mQKZPRps4DynLEhMIzcvZp48o=;
 b=BZYn3y3eU2yrXxwDOyI0oSMMlos9U0EBCFS0EVPs4zYqcb/KOIzLO/zbKAUpIU5BfD
 XJ1k4gFeE9l0612EmWHOsoIiRkkEDXwrP6sfKMqwvOn8CCeoRSZL9E5kvcMwiSx4f964
 hlyKGHRT1Ctkuld4kOzUsCMyGKueiMgVQNxkZEaEpjWDHsmUgRhmTL6QIuXYPIA33eAH
 NpTjIfxR4bOQONZ7yP8uqv3xRsdgg+ey1UDMsY7dyQcE1mxvpv79T1F/oTPmKN4W2toD
 8Sl5KtG/UIDE2f7FVY2yGFuN6lGhbugRQfiDwP7DYma6kD8hWe5FsP6NrQBrJm2DbJ9Z
 V2bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU3Cd0frj4MDknnA6asS2FnehlkSngJS4ludTGT6I9BjB5jn+1lIcSOsf9dtvWt34jVtLdTlFaywka@nongnu.org
X-Gm-Message-State: AFuF++kHGuTdaq+76qCl8hnYAWAq69IiBN7tu31emXQQF8ePh++Ko7k7
 5IRM+Wr/0pvIjzg2AR8hJzAulqKxALCTRqpAfKKOwpa/kNNxFObVoqWs/oFqLA5Db6A=
X-Gm-Gg: AR+sD11A6uAlyWabTekJgdE1TKztAr0EAd17BN0IMEwogi4FttFeb0InjAlKjwXgyWW
 B9WuA/ggXHae9aiPRlGcJAtl+NU/R/g/Z6+ig94ZjM+USPmIbafpB0MhP+JPENvD+QRha4e1eI0
 YQZXPtUhXWhTcUc4m8vVMT0vJda1xev2bUd7YNkOqJ3WR+LKraVx+gUXIFxk/Hf2/8okDmC38eF
 apkzyM775Rx/gad7PWozCuu2txPtPjeWyual60b09KbOV+v3UUO9hXif9jvpKW5AmwfzjWIKu/8
 LDH0m/U4myqJjv8tm/unHYrI1BKzUyEeF2WvuRHzIp99Km2GIc7tDJVwfGe6amazOy/myQ7GKql
 Y9/TKr6nYJSxlSfQkjruFseP0XudrOVBaea8JRhutji0t0GIJ2eTYROCz9uS8E3b5OLSez9q37q
 +ZaO0R1beGbZpdNvO/maQcW2SL14Muo3y7yPjm8MWrUS09uMNmT+YzWVsvhIN6QIYCWTJTc4JnE
 KtG
X-Received: by 2002:a05:6a00:4605:b0:845:cad1:d691 with SMTP id
 d2e1a72fcca58-851df8f64a9mr14309266b3a.5.1787330539494; 
 Fri, 21 Aug 2026 09:42:19 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3617548sm3133539b3a.34.2026.08.21.09.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:42:19 -0700 (PDT)
Message-ID: <80fb0662-cbc6-4423-9202-81c9583f1113@linaro.org>
Date: Fri, 21 Aug 2026 09:42:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
 <20260821104950.32108-16-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821104950.32108-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/21/26 03:49, Philippe Mathieu-Daudé wrote:
> All functions called by target has_work() handler take a const @cpu
> argument. We can now fulfill the comment added in commit c2804566f6
> ("target/arm: do not clear halting reason in has_work helper"),
> qualifying the handler const to denote its idempotency.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 4 ++--
>   target/alpha/cpu.c               | 2 +-
>   target/arm/cpu.c                 | 4 ++--
>   target/avr/cpu.c                 | 3 ++-
>   target/hexagon/cpu.c             | 4 ++--
>   target/hppa/cpu.c                | 2 +-
>   target/i386/cpu.c                | 2 +-
>   target/loongarch/cpu.c           | 2 +-
>   target/m68k/cpu.c                | 2 +-
>   target/microblaze/cpu.c          | 2 +-
>   target/mips/cpu.c                | 4 ++--
>   target/or1k/cpu.c                | 2 +-
>   target/ppc/cpu_init.c            | 2 +-
>   target/riscv/cpu.c               | 2 +-
>   target/rx/cpu.c                  | 2 +-
>   target/s390x/cpu-system.c        | 4 ++--
>   target/sh4/cpu.c                 | 2 +-
>   target/sparc/cpu.c               | 2 +-
>   target/tricore/cpu.c             | 2 +-
>   target/xtensa/cpu.c              | 4 ++--
>   20 files changed, 27 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

