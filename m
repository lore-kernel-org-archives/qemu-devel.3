Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B2FD6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJFk-0006Gf-UI; Thu, 18 Dec 2025 14:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJEp-0005ps-5q
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:00:42 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJEf-000114-I2
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:00:29 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7bc0cd6a13aso641002b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766084424; x=1766689224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXwuZWgX1qLHCChO8eo2XcgVStKZKjX6dmnvvioUo8Y=;
 b=nU8k0waM4JVSzv5G57ftKBYb0qcL4RhYC5b2gVJf2L+tQRPkP3urfKnRaqYPWQHurN
 GQJErvs/2VXn0Y+pXIYW7b7sM2VTtd0SDG62EhFF9K20ig3JvS3DeO6NshaMU1QymE3h
 UygUVctxd5mpbWU80wkWJu71TH2THEyCZIvrCmnlSVMlU5berIBqAW7Cx16/lCpFrmAV
 HatWPgYnXwdk19cIHhaYN7/5z8TPkuuvBfN2FME42CAE11/uWH3qJvNKBmFFn7a9hteB
 vESVTxP/kp8Hn/cLIBGMKX1+RwuifP5aa9PiZMmhTYCoTi/ZSX/YnyCr27+dkiUuHQk1
 iBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084424; x=1766689224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXwuZWgX1qLHCChO8eo2XcgVStKZKjX6dmnvvioUo8Y=;
 b=viPwVZryf552QJ+Db1P3TYE5kSmaVXFVlf5gn45SarubLIYFqDCqZ7WisvU0bkqmsy
 BPZhz7Y9gTwtUmyNaCwyuPW4v4G8BCOzQNAkyREJLqKYlQ8GfUrCmkNmSoOgS6EXD3jS
 8VoMAsmB81k1LxhPeLUmHjIiV2V8kToHCivxYFxwR6mw52JrC9LMaZ0s8m0CUrNs9Xuo
 TvngacXq6dfLpB7G0XvjoVkdHBAvsi0ZF51bd3/Mfsb5JBauDZY1ykpD39WOxl+sz5CX
 gk5d/6798AmVIAc5unh+FbobpgWgLExnzU2OqpbHvi9aHGAUasUaj5U4kYZazCsV2LUf
 iDag==
X-Gm-Message-State: AOJu0YwD6dBNV2Q7IrJJsd6XON9R8VCSmDHDgPqeikd4019ElDXFfnJc
 mNXuIzJ8TVyN73grp8IREpibQdF4nVeptHX9dwanxNZhA6uNpA1CKQ0WrRgGXuLbFOPVeTTy99f
 D6s0WmbU=
X-Gm-Gg: AY/fxX7nSB/fr9clp78rcggIsvHW/draa1z4migjYf3Bv9yzPu1hCHBEt9vfGxDkySV
 bAgJujcsTT5+M+YLx9o5Kb4cqFNSwvo4jBu9RO7QqYnyYWccncZka9lFp3IzbNK/H/PR6u2S+iJ
 bj93PW8txsPAza9vAAAopdsFaNcsLO3ncY56adxmGXa4uca5bn0HRAJi1BFrK290UNEksfIU6Kf
 zovKzThCMt8AfLAN40WueGTzGxN3hxLYfZRuqsjs2YWI59D0fKUNcnCPy0e8SER6qqFHsk6GWUN
 cjqbXV/r/QGFF8JK8VDlfIMP3RdoCfwT40IBTTHsknJys6213OBTedhjMgR637G956FxEjQoikn
 xOjaY0qglpndPRrB5WeD1miw/SVqxCG6tMw/GaualET3ygEpJ8A9RBGTogYXnkN/VREt7JHXSmy
 aGoKtrFGalL86iSp5S2AJSCo44rdoipw==
X-Google-Smtp-Source: AGHT+IH1P55pS1wdDf+JfUbByPvCx1HMjEt5ixz00odrcsz98LHGrBykirY1vPaXwxNxEYj2QAMEAg==
X-Received: by 2002:a05:6a00:7415:b0:77d:c625:f5d3 with SMTP id
 d2e1a72fcca58-7fe0b73a4e8mr2650109b3a.1.1766084423421; 
 Thu, 18 Dec 2025 11:00:23 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e197983sm44523b3a.33.2025.12.18.11.00.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 11:00:22 -0800 (PST)
Message-ID: <7b229cd4-a961-421a-932b-c6c60893d188@linaro.org>
Date: Fri, 19 Dec 2025 06:00:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/timer/hpet: Mark implementation as being
 little-endian
To: qemu-devel@nongnu.org
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218181812.58363-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 12/19/25 05:18, Philippe Mathieu-Daudé wrote:
> The HPET component is only built / used by X86 targets, which
> are only built in little endianness. Thus we only ever built
> as little endian, never testing the big-endian possibility of
> the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
> the little endian variant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/timer/hpet.c                  | 2 +-
>   rust/hw/timer/hpet/src/device.rs | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 1acba4fa9db..bfad626d5e1 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -648,7 +648,7 @@ static const MemoryRegionOps hpet_ram_ops = {
>           .min_access_size = 4,
>           .max_access_size = 8,
>       },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
>   static void hpet_reset(DeviceState *d)
> diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
> index 3564aa79c6e..4f4be84115e 100644
> --- a/rust/hw/timer/hpet/src/device.rs
> +++ b/rust/hw/timer/hpet/src/device.rs
> @@ -708,7 +708,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
>               MemoryRegionOpsBuilder::<HPETState>::new()
>                   .read(&HPETState::read)
>                   .write(&HPETState::write)
> -                .native_endian()
> +                .little_endian()
>                   .valid_sizes(4, 8)
>                   .impl_sizes(4, 8)
>                   .build();

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

