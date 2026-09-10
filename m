Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A1DC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kl9-0000w7-Kw; Thu, 10 Sep 2026 15:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kiD-0000Q4-0k
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:45:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4khr-00006a-QK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:45:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2d91ff7d9acso405875ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069510; x=1789674310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GqivVmMpwc2GZW2PB0TD+5B8CidEcEzCnFULwWTubzQ=;
 b=vAVUSUQgtshHz/TL6gs3zyj3M9D/3W8D9o5l20wK0Bvqh0ry0IN6ZbugY2vVybi3Aw
 UWSKY4Cj4H/RC+ooUjBrjSZcaAsodx1rHid0+wOTpBSkmCEnkhNYfiC+3OWQdY/1Q3B+
 Oiwtl4r4zE0myxccZl3BMe/ooeBWYvrri9n1kNpR8RYamr3gV3jYc9xPUqz5i0HmolWN
 1O4cYPzFUjHFSr4OWD1YBfi/POGNRHwQT16f8+FZsO6E2DSsc7Z2VM98jzIfsNtw6CTU
 GnrWpQm36D88AIG9333T+yq1mZXMVV0vG5xeFMPmGSFZmAcRMUkLePrgQA3+rpqCjeqY
 iiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069510; x=1789674310;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqivVmMpwc2GZW2PB0TD+5B8CidEcEzCnFULwWTubzQ=;
 b=KgsYQByfptAq4kiHRJk/HBNuu0tF2q8iDYSsoPX8xYP7zWO27I9Y7jRH3pGCaQUfFY
 oLcdDT9OY7ATAW6Wjz4GLcHJvGVOwC+W74oEuqwLLwltZdcoXX0cqi71QxrxrhdMyT56
 /+zkRoqrxjHl40E0lHEV6KWsnHMYXSEwEbx920LQxEhvpR0virNRer3A46Jes83TCmO6
 rlIWbZqRWNe1l+0XiLQPnWcsBQj6IddZDuXRfCw5ws4+w6NBzA7k9UHKUxmmptGpNhJB
 zcXHeJ/mfQcEGrVGdSa3p8bqTF7kEbSeZNvcXgiKfhoaVHt72YxMB9LM4XTAGYmRm6ot
 T7dA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiRMpVuDTblOHpWIG55ZieT1nvnc4JmrKjh8u7ZX/xS9QbgTvYJkBokiWSu2uby13x6i6agxqjIrOk@nongnu.org
X-Gm-Message-State: AFuF++lgwtInFegeXKEj0Lv4nwcea06IcyH4BMJcYmyTfDe/zsx+sJf+
 0x6cRf6Q9p1sia3YsBr3ZJVhRKpdd3DwuvmEKOhza646VZkZtUTP4LNP+pFjEdU1XA4=
X-Gm-Gg: AYBFou1+0/R939omwRzw+aLtsZBMBzs1KmbJGVHy2e69w1pVQQ+hs8pRQs6ZRiOF8p9
 vP2ic0YbdNu5sFFnEKLeApCjBlo8Y+F5AptDRYZYIVFcr1vShex9iWyMhri5DJwmrJWtgTmm3w3
 BaMfKoec6dzyOIAQxTHIPyvC5VjLjxXkdP76siCZBcO3PoDX8yz8CS0iVh3t90S6Ut7BaIOeIof
 FDxKwCILwKgREcLNW6PpeqpD4LS1FaNG9bcVA31h0itfsHjkvLXTzMS/BXm4IQXPPw8M/oFaR/p
 3dhNDBFIByAhjONQoVFJ9LwVlBXepI1h3ZY5292yZ1sWJIjFkwDaGioIEQxdOfDIwHWAbl52jnQ
 ylx4NAoHatjtu7UhRC5j1HAxX/Do592uuABeifdCMpWy+7gk27z+BfKSojMwMvQrxtWj+xjqL0I
 4VgHcMJE9aSW64iSnusGFBMgGM238R1u//3rNZOoUney+CEYuuA3aAw4athtuHFbvOyT8Gca9CU
 dnVkfeS9W+Gti4=
X-Received: by 2002:a17:90b:518f:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-39d9c1bef27mr469736a91.13.1789069509651; 
 Thu, 10 Sep 2026 12:45:09 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8f1f7sm714469c88.11.2026.09.10.12.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:45:09 -0700 (PDT)
Message-ID: <c21f39f6-d6db-45ad-81a2-c03771206705@linaro.org>
Date: Thu, 10 Sep 2026 09:45:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/21] target/i386: Constify CPU*State for
 cpu_*_interrupt() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> x86_cpu_pending_interrupt() and x86_cpu_interrupts_enabled()
> only read CPU state without modification, add the const
> qualifiers to CPUState and CPUX86State parameters.
> Simplify directly using cpu_env() in x86_cpu_pending_interrupt.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   target/i386/cpu.h | 4 ++--
>   target/i386/cpu.c | 5 ++---
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



