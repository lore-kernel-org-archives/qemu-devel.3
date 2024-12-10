Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A821AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4uq-0005FA-NQ; Tue, 10 Dec 2024 13:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4up-0005Ev-AO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:24:59 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4un-00045k-O2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:24:58 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4674c597f2eso19048981cf.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733855096; x=1734459896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=avG0maLTivqn17JPLerqmYoayLajjpceisSK0FKqNyc=;
 b=gMkMBDYn1aeIp3ssqlTg3vZxp985ySye2FkfyMWtU5brwIvaqLBtBPg2/7Phs2aZjp
 naqv+evsJ8q7UoYrW1Nag+U1gVde2jRIigRuSQur4NN3eN2a7K4rxHbXIvP3V8S+vxmb
 dqs04+BJTW5sL4jGyU7iTCj52l5Kvm+dwxYDV1wyuvJ51+8mFNDxvmvjBNzZHQr101og
 7VB1CEVMJgdGf5dc4AgndwW+L78Aqc56sJmtwa2Or6dm4/r6dh3/zbaTC5nwNLNnxo31
 4FDuBhu2EfWO3pBxcQycSwANGAx18HZz5VoXqIsHQk9/f5QeGl7RLqHejeZkwp/9ccdN
 8czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733855096; x=1734459896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avG0maLTivqn17JPLerqmYoayLajjpceisSK0FKqNyc=;
 b=lgySdapshIjUrgZd1/equDD92m93K7zVQ/xKfI3vp6ql1qEywFurijkLvlWWNPsrBE
 eO4eqaWbr8NoEuLJK8z8Os4rk5NJ6WpirYp3PnQXssS63dKO2gIrFfJhM42/ToNfoH6t
 LCdGiSPu6QAqvEUYL5yPRJs64IDIdTx3qsQOq736MN5NC1Dgn1q5f5L5b2P6AmIS1bSb
 OD0+t2c0stT6oisjwZv2ZyzW8OsMv4pZdegCmA8UWDT6yBZJrJSVYp+ehFUmqzGRC9XJ
 V/WLEJ236LwDh2srqhAa691gawOBRgawQPAmbg2cfcVOfkgHniD1BEjdJKaQEpylVxvd
 HJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHIfr/ZMHc5HYjv3FRr5dQGKsySUhEj4f5Q9uQixrKX0XoFQNd2iJE8LwaRIzp6LAhh8YoV30RD3G5@nongnu.org
X-Gm-Message-State: AOJu0YzcRyDJpamneoouZ+sfh3pQHZtNDy2cs5B/IuUFVYXCEiUNGaJD
 Oo84RkYZoz+8o8r3dV1PHBH6UkXf3uOmxAieXk4oOiU3NcTIa98CQh0JvFuV2Pw=
X-Gm-Gg: ASbGncvNDTlmbciN+tPNZ+IgLD59r6ayS6Hzd1mrox01HLF2gch5TGP9/BXBTdUfYIt
 vVR5uawr7Kiq0l80eZNSRG/HvOndOXKbfbDWbLR9v+4rzrokZA9tehaBcrJzZyAtTd5oHtRc/as
 28GaEo0emTz4stsBit9s5l7p8DOZq9K9DcgFyMbzbZ82l0J7OCRn7sp7dRJePn1gr4eqhorEitj
 YfjPALZmaPX+f6EMkYvMhlkinfK8V7D0W66Anvid2YkCy8AtqCi2/oqBsJX2njjmwySnuQ=
X-Google-Smtp-Source: AGHT+IEABMngpYfXS6vQL4T72Np0Pt/sRiqSwIucMxTjLm6NkdkPF4k/vpIFA36bFDgeRVD6fj59UA==
X-Received: by 2002:ac8:588d:0:b0:467:65d4:7e07 with SMTP id
 d75a77b69052e-46765d47f21mr129898321cf.53.1733855096522; 
 Tue, 10 Dec 2024 10:24:56 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4674360170fsm42879371cf.0.2024.12.10.10.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:24:56 -0800 (PST)
Message-ID: <d766b2d2-de38-480f-9a66-1ef20e929a3c@linaro.org>
Date: Tue, 10 Dec 2024 12:24:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] target/arm: Simplify condition for
 tlbi_el2_cp_reginfo[]
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> We currently register the tlbi_el2_cp_reginfo[] TLBI insns if EL2 is
> implemented, or if EL3 and v8 is implemented.  This is a copy of the
> logic used for el2_cp_reginfo[], but for the specific case of the
> TLBI insns we can simplify it.  This is because we do not need the
> "if EL2 does not exist but EL3 does then EL2 registers should exist
> and be RAZ/WI" handling here: all our cpregs are for instructions,
> which UNDEF when EL3 exists and EL2 does not.
> 
> Simplify the condition down to just "if EL2 exists".
> This is not a behaviour change because:
>   * for AArch64 insns we marked them with ARM_CP_EL3_NO_EL2_UNDEF,
>     which meant that define_arm_cp_regs() would ignore them if
>     EL2 wasn't present
>   * for AArch32 insns, the .access = PL2_W meant that if EL2
>     was not present the only way to get at them was from AArch32
>     EL3; but we have no CPUs which have ARM_FEATURE_V8 but
>     start in AArch32
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

