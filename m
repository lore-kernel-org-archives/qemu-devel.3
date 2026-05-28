Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5865DCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdQV-0000Qt-Jx; Thu, 28 May 2026 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdQT-0000QR-N3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:17:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdQR-0002Ie-M8
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:17:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8571a0d6c0so16801a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779985058; x=1780589858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iz54acVPKLfvPVFjcnhKUvcRH7YQSpaz5PN0fG9pe0E=;
 b=H9BDK1Ozl0C0jE7B6fQzBqFS0V6JptxW5KUbfz3btkfm7Dz9d9xCY6OJeMrqihmmFu
 2rdRhRQIWqJl2L9+bBDgduTgU6xYobHi1pwr+EEmE72rGVag0W0PnbCvaUgGILIfvPvy
 z5TwhLNd857+t0aJOOkKZAoFOp3z7A6bsPV2AdysWo2jwWND7EZNKNVQcaAiPGx0YYis
 uSrxygJY49EQRhfDx1RgzI9s1C1i/XVDQgEluilFUZe2SWqUjmRaR58F4kwIUiVB2KIf
 CG5bJOJussYtokWctYDcmxaIBAmnyAQUPiyJgC6OElJk/YTS18TIfphOp3LCokYiSdMK
 kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985058; x=1780589858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iz54acVPKLfvPVFjcnhKUvcRH7YQSpaz5PN0fG9pe0E=;
 b=XFJEGdL3A6V1D02eADAAynBtvMyPGpJeQCW27qfhSmNQkkUHJPJGTmuWEHvWR6IM6k
 +nU158w8WMnVKSTPDXhy12UgOzn6hC+9zGwvyVzRMQD49AxhL77fni9JS/mJ9pHlaFCa
 NbKtkkJgiATu7Yk/Y1SOn8d01S+anaZ3XBTLUoD/0ge616aGdiWijNv0evI14pQRSyyw
 BI4N618ftHBcecr62JyYRhU/d8Vm+Ud1o9cn+qlySD+i6LAP5TKIUFLqNCZId6MSqZyt
 43sqxZTttx55aOn2fAtmIK6SHVeM+yVdJCWiGtQOB0iEOtmfrxKXA+ippCqwBXSeVzx+
 UABg==
X-Gm-Message-State: AOJu0YwN/Pd8nXwoLAfLNW+HLP3i1SDlxB6HSZqtVSBkCCvLdchLPagq
 wQFy3VSCOyrgy4/WuAbW96+09JDFvBwMuRGX0K99n3HCgt93Ajyjm0SVyzdqMrNS7+/Qd+cg3u4
 RSIdAn/U=
X-Gm-Gg: Acq92OFUPsk97ujPkf11FiOCKtUO5mPYfLmOspJXdSuDUU6PP7B6n9QOTJvlkH6M7Ao
 1d7xdd7TUEx+PssnzJdSrRepbLaKSsSWVdTkaurpZ3jykkPjUuCPT68nAfvZmJIuZxMZJIM+DM0
 N9at/fDVkC81dJWzf8Q7QBVoEoRKchBEvNHXBZS+ld2YorGRkUuNo3yO9b0JgQk23q2TEClMft6
 g63lW3iiG9Tx9duc8YVYulbznKzSCLay2+JW2cCYfF8INor1bCaeKTLMfSFdUL9jZGPRiF4LhYI
 96jMjPNxgMdxItT2ohuSQ6AmD0068LDuEwgREiG8MvpkHZ6MbijBMSxKzWEhJNFL9rVJ8seYqrb
 +4tXzrCJIHjbnsSsPjfBWI9TekhW2I7wVAgg3l1ZFdliLOmuMs8TSKe4v7kEwTSn6LNnqWCq9A0
 JkEvOeiTEnwAoM7eeC/KrjLijaiBhyo/eOzFuaRnlmNVZZIS0=
X-Received: by 2002:a05:6a20:244c:b0:3a2:7ef4:81d9 with SMTP id
 adf61e73a8af0-3b328ed4a60mr28784371637.44.1779985057746; 
 Thu, 28 May 2026 09:17:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852056d767sm15147290a12.25.2026.05.28.09.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:17:37 -0700 (PDT)
Message-ID: <2565a0c2-7a3d-4f3f-be3e-ecb9523486e0@linaro.org>
Date: Thu, 28 May 2026 09:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] target/arm: enable event stream on WFE instructions
To: qemu-devel@nongnu.org
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
 <20260527114320.1581552-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260527114320.1581552-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/27/26 04:43, Alex Bennée wrote:
> Two generic timers (K and H) are capable of generating timer event
> stream events. Provide a helper to calculate when the nearest one will
> happen.
> 
> Now we can calculate when the next event stream event is we can re-use
> the wfxt_timer and configure it to fire as we enter a WFE that is
> going to sleep. Reverse the M-profile logic so we can enter a sleep
> state in both profiles.
> 
> To avoid issues with QEMU's incomplete ldst exclusive handling causing
> potential deadlocks in common WFE enabled locking patterns we take
> advantage of the architectures flexibility and treat being in the
> exclusive region as a reason to exit.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - merged target/arm: add gt_calc_next_event_stream
>    - update to use halt_reason
>    - made arm_wfxt_timer_cb atomically consume halt_reason
> v4
>    - skip sleep if in the exclusive region
>    - update commit message
>    - remove the CF_PARALLEL guards so we work in smp
> v5
>    - use env_archcpu for ARMCPU rather then expensive QOM cast
>    - rely on cpu->wfxt_timer to guard event stream leg
> v6
>    - use atomic_xchg to consume event_register
>    - remove extraneous target_el calculation
> ---
>   target/arm/cpu.c               |  13 +++
>   target/arm/tcg/op_helper.c     | 142 ++++++++++++++++++++++++++++-----
>   target/arm/tcg/translate-a64.c |  10 +--
>   target/arm/tcg/translate.c     |  16 +---
>   4 files changed, 139 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

