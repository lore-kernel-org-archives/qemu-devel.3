Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB13C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 05:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcdKW-000792-IG; Mon, 05 Jan 2026 00:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcdKU-00078C-AY
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:40:34 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcdKR-0000yN-Um
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:40:34 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so506166b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 21:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767591630; x=1768196430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+5BH4fcZ3Ixv3MmLyderUKyxA2MN7ARdKHKTrsFSsM=;
 b=g0Ni/BpfdC0nuvRZozknO1tGXhmXxZ8FLvJtOLX2to/uZ6qvbXICo8TGIc0CfpXj+t
 wWDV2/2wbv+cx6nepmOOjqpUXCXVlVKmzo/a7rTvRGBMvSl9X2T90mmYcbdZ1RUd64VQ
 uW7hA/AY6rIKxIlzuHSZSkTsK/3P3jvd7whW+Sji/0pRATwb6z4p+o6zvnsvF1E6DBMY
 jXV/DjF4IN9eFbdGdQGI6J0HN2bEwMnShAH8f0LBAIeg7svZ8qG4QxTYvlU5I4GWuLOA
 0BbW7TcRNDf3+Xo9cMZUyawSKnLKhmRyh6Irp2ginZNufIQ1GeFzfT/noyJ3B5BK7oHN
 fAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767591630; x=1768196430;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+5BH4fcZ3Ixv3MmLyderUKyxA2MN7ARdKHKTrsFSsM=;
 b=S0XognE7BM/2vOTyMPMkuqhrxOd3aPPFwhARvAC4H6zMaYW5VvdKskIR16aWOUWh+0
 qjG+TAfygac2LQssRFJcoOGD7Fjq000txSfff8Nub96K7ZpnazUzWptL5wRjzHk3DOz7
 ZZvc9x9BnOKe/6MdQYE3NX4plWk6dbuelujE596Ve8aucSO+eYDFx5FX5e4xgz3OVEDs
 8hvsjEBU4ChHUj8b7TrIwLmhUtyJeu3JroBQyOMPCJMWzYLXYHOQKEO9vH6/9cqHPkwZ
 C4aIbZv5RQo/woUfwU/1ttw3u0EcGpUS4tLjRxN2flkH2TTp/xgmTpKlmFG5vGPrA5nX
 o6xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC49v0EqnacH08qIcOIZzW33kP5QHJOEPe03lPgK5cY9F2c+VM4vmQ8eFlfATAl+lLrrFH6YEhwzyu@nongnu.org
X-Gm-Message-State: AOJu0YxU6HyPxdDZQXtdX5vIplq8yVRqJG4q/h9BgO4hq/DMZRzh0l2w
 nWShn3cCb9WB49j2SPqQnxdBUhjZkDLRNPwiJRdckS9JiptrjhSZCgPpNwpUb1aNCrM=
X-Gm-Gg: AY/fxX4h3H00wYQdrTxHJQaR9FMWbs4u3mPK9lY/p17wJnhwqpGTprYs9Ivw8nNBN2n
 1oglfhsVT4lLWKYQQ0CF64WG42m2/Jmd7/VRjsTtbddpXrdxwNoHlRt0KFVydl6cAmSRtQpK5pk
 nNONdzLrEP9CExkZ0jfwIWPer7UuGs607Rv7+rEtOEuOIUy3E8GpBrpBg+roo26varw2KRh5/Uv
 DRs4SPBWE8F6hn8uXDu/c1spcz5shBaXRm7GDagkx9d1zV/fhd8l6H+a3+UM6Hzf1FNfo9zI6eE
 TPiKH3ZfNLo1Ii06FhMo81w6H4nENjFas876onhNojjZqAi9P1MqwN3p3JQXNrlhv6kirSoBFQz
 lJ1env8VTxfaJlw4x3cUjVdOo1kBbmt9HqfzQ4pU1RpJ9d7gatuI6ztdnTGsc3yNkf1mEHBxjGn
 fOogjDyhoMo4G97ESlimfoIi7k/1XYzfHdi7c7d6iN
X-Google-Smtp-Source: AGHT+IFzqoyQKmSF9/P6104vvTmAaCjd5K+Flt8sM8BWqlSZaAXIA1GEwvPzAVMzTuhJioDHTb4Vhg==
X-Received: by 2002:aa7:8c05:0:b0:77d:98ee:e1c5 with SMTP id
 d2e1a72fcca58-8148a846e53mr3407056b3a.15.1767591630202; 
 Sun, 04 Jan 2026 21:40:30 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e8947a1sm46361077b3a.67.2026.01.04.21.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 21:40:29 -0800 (PST)
Message-ID: <40954ada-f7b5-4709-b5ac-a6711d503015@linaro.org>
Date: Mon, 5 Jan 2026 16:40:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v2] arm: add DCZID_EL0 to idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251127170657.3335112-1-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251127170657.3335112-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/28/25 04:06, Cornelia Huck wrote:
> This requires a bit of care, since we still have to handle the EL
> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
> via a wrapper working on DCZID_EL.BS.
> 
> KVM currently does not support DCZID_EL0 via ONE_REG, assert that
> we're not trying to do anything with it until it does.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> Changes v1 -> v2:
> - use extract64/deposit64, tweak helper names
> - assert that we're not using the reg while running under kvm, instead
>    of providing an incorrect dummy value
> ---
>   target/arm/cpu-sysregs.h.inc   |  1 +
>   target/arm/cpu.c               |  2 +-
>   target/arm/cpu.h               | 14 ++++++++++++--
>   target/arm/cpu64.c             |  4 ++--
>   target/arm/helper.c            |  5 ++++-
>   target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
>   target/arm/tcg/helper-a64.c    |  2 +-
>   target/arm/tcg/mte_helper.c    |  4 ++--
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.h     |  2 +-
>   10 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c6234..7f3aa8b991aa 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -39,3 +39,4 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>   DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>   DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>   DEF(CTR_EL0, 3, 3, 0, 0, 1)
> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 39292fb9bc1f..557af43a9709 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2184,7 +2184,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>   #endif
>   
>       if (tcg_enabled()) {
> -        int dcz_blocklen = 4 << cpu->dcz_blocksize;
> +        int dcz_blocklen = 4 << get_dczid_bs(cpu);
>   
>           /*
>            * We only support DCZ blocklen that fits on one page.
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54deb..32f003705551 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1111,8 +1111,6 @@ struct ArchCPU {
>       bool prop_pauth_qarma5;
>       bool prop_lpa2;
>   
> -    /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
> -    uint8_t dcz_blocksize;
>       /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
>       uint8_t gm_blocksize;
>   
> @@ -1178,6 +1176,18 @@ struct ARMCPUClass {
>       ResettablePhases parent_phases;
>   };
>   
> +static inline uint8_t get_dczid_bs(ARMCPU *cpu)
> +{
> +    return extract64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4);
> +}
> +
> +static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
> +{
> +    /* keep dzp unchanged */
> +    cpu->isar.idregs[DCZID_EL0_IDX] =
> +        deposit64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4, bs);
> +}

Given that dzp is always computed, I don't see the point of this.  Or... is the point that 
KVM *will* eventually support DCZID_EL0, and we won't be computing DZP along the KVM 
trap-and-read path?

You could usefully split this patch, introducing the get/set helpers before changing the 
representation.

r~

