Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A02C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujc42-0007p0-0W; Wed, 06 Aug 2025 07:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujc40-0007na-Sj
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:12:08 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujc3y-0005b9-QV
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:12:08 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55b8248e77bso6976161e87.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754478725; x=1755083525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wHdp+bAX61MlQuOBvRTforIZ8wEOaFX2lLAkurfSvs=;
 b=MiRZE/iO8qyJVORCCLWL3G6TrNzAwRQK4JbeQE5b4AOwSWt2E81glJ0Zd99aW858x3
 rqfnsNk1D4j9SYdqZjCuIkQ/5QRWBtoNONNmPHpfsmO/Wplks+HPaOf9sjLjz9EIvApM
 FA73buixv7wT/NDrR3jcYgrBG/lGf/EtMUH6c4HTulOXLeFPEJB8I/q/Y+l58idC6AaR
 Rm/zwXewOpxEKY6twaYhVJ8IxFqh8wNj3eLmTMDDLn/eEQQ9KparuzyFzNFwbbLg+0/7
 +XP2mXQ9rj42zsUsEbT0q41QrGQLwt823HckqN/a+GyvHJtq3ryGSyQkcmrib0pcoFyg
 yqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478725; x=1755083525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wHdp+bAX61MlQuOBvRTforIZ8wEOaFX2lLAkurfSvs=;
 b=nPU+KTUHk/jlXCAfItZNnmMPuCWioeDmTMjS25mCC8MTXwTSkQ39Gls4pR07isQqNv
 386s6hwA5W6gnyUwn67hfKMrvALeVvcNlgw8aCyGh6E0dKaKRFMviuCJbbSwVUfw1qHs
 /KeG9GtjphO48xe9kQyaU0yid6nX+MMKXRTSyDZjJrHqi4FJTjZB3JACDSWc2YowNW4a
 jYq4wifJnMFIQ+SQU67xSRxTsd/lpn7Rkr56cf5nIKkt5qQDKURrGFoikbJ9g+iZOYKT
 lh8AZRcAixQ/o4VYno2s4PHlDaP81d61OVJ3ZFdh98/D3EEliYAbmBKUuJ38BqlFal28
 788A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX341WflNMcSjsQISUZQ+UrhmxO5c3X6ODsRbSrjnyIor7stFKkSXxWTKlXk6WX+Jtl/zqwftyGMcda@nongnu.org
X-Gm-Message-State: AOJu0YxyPJVQ6b5y0jT5XOpbNIeIFgRkDk8EpUkcVQjXczYwl/hON8Vo
 D4MSwwRfzroUT6L9S37ZcCkUu9FStqu9rmc2bSay1l0H0r8zQh5HcsVoHozpc9gKBGQ=
X-Gm-Gg: ASbGncuWOGGk5CR/14f8ELuGUe4xVIdSvuMVhWB7NUQOa5UWzy/dBkNlhhUwYJXESza
 hQOTT5hkXyTQ8PDUqpOP30N7zZNHO5K06pgZk/Pz3trZCf5A+kp1XdTEBN856FApOUmjS6L4KQT
 iuH/RMx0YdE6isx02XzV9RlJFP0iWwCtReVsTaehAGfSqF6joqYUSTAcgCZXLxdI9AMNbutw99C
 1Et0ZEziS+NrxWB8/bA4hDQbzJ4oZ+r2H5LNFeCgykFqxoUOcJVAphStrW4PCZ7e/uGdsdGV4Sx
 HAami9C5aQUA2dLapSeN9qPSqsMxlAwDQONhaUBcB8T4O9v92Dp5wp1VLFEZmYmHaksqx1nSsnX
 0T0XTtJxvLvPPmkewLpWTPE7N7JS0/RUMpLsxpiQKs5jvAoytbAxYJr6c9kp+b3qyKjt5bMF+vJ
 MH
X-Google-Smtp-Source: AGHT+IFO5wMLnhduDm12k9gUzqJXgFzMmrcF69veQ2O/RpXc3GMhQVYCefM1hoSWr45ADSiA8pUaAQ==
X-Received: by 2002:a05:6512:a8e:b0:55a:2f6e:99bf with SMTP id
 2adb3069b0e04-55caf398371mr791454e87.37.1754478724590; 
 Wed, 06 Aug 2025 04:12:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b8898bb3dsm2299712e87.28.2025.08.06.04.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 04:12:04 -0700 (PDT)
Message-ID: <3f25ba10-8153-4b0f-a2d9-224856e6d263@linaro.org>
Date: Wed, 6 Aug 2025 13:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] hvf: switch hvf_arm_get_host_cpu_features to not
 create a vCPU
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov
 <imammedo@redhat.com>, qemu-arm@nongnu.org, Alexander Graf
 <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728134114.77545-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Hi Mohamed,

On 28/7/25 15:41, Mohamed Mediouni wrote:
> Creating a vCPU locks out APIs such as hv_gic_create().
> 
> As a result, switch to using the hv_vcpu_config_get_feature_reg interface.
> 
> Hardcode MIDR because Apple deliberately doesn't expose a divergent MIDR across systems.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 35 ++++++++++++++---------------------
>   1 file changed, 14 insertions(+), 21 deletions(-)


> @@ -891,17 +891,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                        (1ULL << ARM_FEATURE_PMU) |
>                        (1ULL << ARM_FEATURE_GENERIC_TIMER);
>   
> -    /* We set up a small vcpu to extract host registers */
> -
> -    if (hv_vcpu_create(&fd, &exit, NULL) != HV_SUCCESS) {
> -        return false;
> -    }
> -
>       for (i = 0; i < ARRAY_SIZE(regs); i++) {
> -        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
> +        r |= hv_vcpu_config_get_feature_reg(hv_vcpu_config, regs[i].reg, regs[i].val);
>       }
> -    r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
> -    r |= hv_vcpu_destroy(fd);
Could we add a comment explaining this magic value?

> +    ahcf->midr = 0x610f0000;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


