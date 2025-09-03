Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7ECCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmEO-0004sA-GQ; Wed, 03 Sep 2025 08:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmDJ-0004XR-Lk
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:03:45 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmDH-0002IB-TA
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:03:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso11116548a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756901017; x=1757505817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=algJ480OcxSO7wlz2vQBELrWBE2zSJqUfbtVSEJ4UyE=;
 b=dV/2uYWVRSntWyMV70hoc8i4VHl8I4dLZSBENZ53OiL27P0Y0OU702cuf3Zz2kxdwr
 a+8ig4L45B/CGNFuqmN5pODTTfXL/TrndI8JFQgS4aVl0+zQZUG6DWJx3/EUWWvRwPgT
 z4u0BC3+eke+6eWjWuJJPhPEKdd5DnZkeRIhJ1l9T1MEDA4MadMyewHcubtsogKf+9Gk
 42dYq5UnezT+17qn8UZOOdRkc4wKXH1uhI7HuxTePTPokmBet+7mAkybZcVarpR1Z5HL
 rA28bZYBLDk2ZcfzdVok1XvrKtyOlUn24v2hoAeq/f6Sw027hYx4+O8UrvugHlo7/Q7r
 3TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756901017; x=1757505817;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=algJ480OcxSO7wlz2vQBELrWBE2zSJqUfbtVSEJ4UyE=;
 b=DR4WQwmgMS9XCfVnrWTQ1JH7lVO2L/h7b+VSJlF3rNw+kVVozr1vSft/1x7k274eGo
 UrYcBGK7zOFk/qbTa/aVNCWxk40sa7v96c2ghkTVNRw2Vv+gSWGXO6QKDhoVGSgB0AFQ
 d/G0wYaWPgSz0XCTHmh4RiHZGdxR3GFDEDLwN9c5dPQWaJ0IuCzHKtby45hB8HaI7yb2
 LwiCojxWwEcFH7xmQhOFPXHDu6u6x7KGsEP44khkU5oW4fJM5/0L5v60HwRa/bySE7u7
 RIbB6wJLgHx9aHWhARQvQ23Yrr3ym6TNPDpYNFO1W8UxpNERymgLMmPxKH6HDcUV/FN4
 5+rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtzVeMjfGxweCDQZv4+DQCNETIWbyi0gWTM3FqzHW16UaMuhu58zdGFQUeVmNbGNng0grDUJ1JyK/s@nongnu.org
X-Gm-Message-State: AOJu0YzqZjz+FvErLzH6Q9OZ0sWml7vIltXl3sHOyoStWI+4uUKBsjse
 Xq3rkbXaeQECyVUGPHinSnOjOOEhwuWeRg4yBf3i3oQzr8QkpNjABaf9EaT6RP1pigg=
X-Gm-Gg: ASbGncuRET0Ceh1ISGhMBRvVmCAFQIiINFEBzz73z8lYq7Sr1P6jvAtV7P1gmmRgi9+
 qCZ8/WftyYaxGX/PiNKQ2vLC1GNaRZEwTRwUFm0dK+42q3gbQLZoFI9Tdm2rgMgMov1MQZCpLtg
 PHJZlwQZBfNGRcXlcWUBg5Ll+j8MsqAtaY6HopoICZg7vXgftTNK4D8bPTB3jRrXAm3yYThvcGJ
 KNCsNBCjvuVtWfeJPKibP4IxSAj7fEmoN+pSzAvUwPGOddX4mT4KjZ3Mwxw/pL+6O5+jfnv7waZ
 Gr3WPQPkYuQXtWBWPfe8meQjiJn83tUP42ZSfQL6k7e1TsM9CaBQoIvkemh4VHrpn+ySlMP3pth
 nSBEQDSl5CkbUsHahNX5TD8mdUcBGf/t5UN1xbRxiUUhEUWAKjGCUZPCPuPRBU9PIvXh6wwU=
X-Google-Smtp-Source: AGHT+IH5FueLXJi635PAj3vemL/fFpBhdAeNlPFyjhrfLDpYHyzIip8SLYQncJNtUHR+UP1PeybJ3g==
X-Received: by 2002:a05:6402:5243:b0:61c:6386:5398 with SMTP id
 4fb4d7f45d1cf-61d269974f5mr13761959a12.5.1756901017505; 
 Wed, 03 Sep 2025 05:03:37 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7dfesm11909648a12.7.2025.09.03.05.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:03:36 -0700 (PDT)
Message-ID: <30d20299-1797-4e49-8dba-5ce3ed00162e@linaro.org>
Date: Wed, 3 Sep 2025 14:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] target/arm/hvf: switch
 hvf_arm_get_host_cpu_features to not create a vCPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 3039c0987dc..fd209d23c1e 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -869,24 +869,25 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>   {
>       ARMISARegisters host_isar = {};
>       const struct isar_regs {
> -        int reg;
> +        hv_feature_reg_t reg;
>           uint64_t *val;
>       } regs[] = {
> -        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },

Versus the original, I suggested that this should be

	{ HV_SYS_REG_ID_AA64PFR0_EL1, ID_AA64PFR0_EL1_IDX },

etc, so that the data structure could be static const.


r~

