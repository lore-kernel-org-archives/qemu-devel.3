Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC6CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1W5-0001FY-0P; Fri, 29 May 2026 14:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT1W2-0001BN-4Z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:01:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT1W0-000633-C7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:01:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c8584e80bd3so54347a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780077658; x=1780682458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uqzK3vb0aNEfUMqd2la0L6KNLj/p3wCjMxPIbPFO2g=;
 b=INVG1JwEqndX1XGIRoFTLR+/iGerxXO6ijZ3XhmXOsjfdp50648MxRuVYlaSuDRRd7
 nMz1v9wVK09ur8M0xTcLOMlUgRSnzNW4DO3uHT0AXn4tyugFHP831jK4B2Aq1214xh7N
 1TnwH3x2h1PmeXKMjrt9s1jHvE2TbWGPgywWPe0byqGEcZ3cibp8q1mUnr4Rj2Zcsefu
 Pj6xxRQt03cUJGDLnUGPdvG8xrADk41LJPodxL71cZaKpxEBLHeqjCc0n/ynkt9xlMj7
 tnEdKMg/FZU9vRKh/7q+gUwtCGFzbXTfL2YEvgTo8OIGbwoBglvVAsZ4yNV03/OlyUjJ
 a6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780077658; x=1780682458;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2uqzK3vb0aNEfUMqd2la0L6KNLj/p3wCjMxPIbPFO2g=;
 b=XpvJL4//xUvVlHAsgBWl/vBEnOy5m1ClgX8tP2bu57MxvFHUBSRpURajGFb+QhdQwJ
 0fuFdhFOno8cYia8zczYEmoKBycmvlRHu6Zu3FZAhPAWyCbJEhaNu3TJ3YfpSt2ZkBoT
 5NRXy6zZ5WI2VjXTHsfvkXgwEwldF0iNo3S4Pd7voeWblCZ2THuW7WmyZizR6aBJW4nR
 BzPWaAjkj/TD4/Mf8yhVyjUWYYrUGil2V+PaNOcR23O3XlBYEdmbejDxyAVHZs4Kg581
 oVpBXh8aLSs6D9ojvxr0QfibIyBiqSBZS9GMjWF5IhGsJEBbKWt1VxkEkwqQfioT5sW/
 KRuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vFuSWUtoNhU86p7Soa12vv4Y0UljU89+PZOFDhDT03Mi2bgqd2aQOBg5U653JfuuDwdTK47L5tX35@nongnu.org
X-Gm-Message-State: AOJu0YzxRzuKXbY/+xmMg0VupoSAJS24pEV96ZOqqEit4VdhhfAXOIET
 ZnrFXmj8wNJg84gS/QVCA8DzOumYpKjFUPLU54XVdU5B667TerYnNaXKJf/kLGjWNn1/J9leTKH
 xDmPiyvs=
X-Gm-Gg: Acq92OHsz/hXBmXXAloKVFd9iV1/vz45YE0sqMyBeF05gaV/brm0FRX+EnLt+l2LP1a
 pkjHYa3TUnc/8i7syK1fNZ2TUGNWChSGjyjSxSFkvxTzfxyxD0K4TShiLk4PmpzAb8t66a+PPUG
 EPFEEESRd9qpc7XMhAdNXzG8UqrYg43aF1rvnGLRhvRxrj5X3/2XowQewpa8C7VH+QiqIiNocG0
 Wh3u62BYjsU2KV1XJLPT26jhnKMlkG9Stm+PbqECW0KsXjZoL2Lw4SAOZEao4HcEOURLHLqtH5s
 M8sVeILh/AR87BYJ3JGZnG6Vy/dp+yWQDtOzhtJRy9f+ElcW3HejDa+1OFdGwfB4Bk5oiVPgrZp
 g/gvRPkEp+mn0160fcgQx+unE6RH/Kw8Nv8j+cB9eLvelpK0o6TfRXJOAWInIvUUhf9rftHJaAC
 R48d/S2kbX1Ut5pbkfXEVc6l5BRgD6NXB0r75S52V3LFQnmAw=
X-Received: by 2002:a05:6a21:489:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3b42823a7e2mr294181637.22.1780077658321; 
 Fri, 29 May 2026 11:00:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214ce9cebsm2440248b3a.52.2026.05.29.11.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:00:57 -0700 (PDT)
Message-ID: <07a10d55-3133-4a91-8953-91cd8cf938c7@linaro.org>
Date: Fri, 29 May 2026 11:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] accel: Rename AccelOpsClass::cpu_target_realize()
 -> cpu_realize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 5/29/26 07:24, Philippe Mathieu-Daudé wrote:
> cpu_target_realize() is misleading, we simply want the host
> accelerator to realize its things on a vCPU. Rename more
> generically.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/accel-cpu-ops.h | 2 +-
>   accel/accel-common.c          | 5 +++--
>   accel/hvf/hvf-accel-ops.c     | 2 +-
>   3 files changed, 5 insertions(+), 4 deletions(-)

I guess this is a new addition, and the next two patch descriptions need updating?

r~


