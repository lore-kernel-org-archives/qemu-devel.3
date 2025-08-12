Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D58CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uldCS-0006bL-3c; Mon, 11 Aug 2025 20:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uldCF-0006aj-Kn
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:49:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uldC8-0002ha-3w
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:48:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2429d9d3755so46647255ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754959726; x=1755564526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=surpJ98tRaESk7K6ewenyJUSlUpmPKhBVFvRz3srkwU=;
 b=a+y9mFI5FOWO2I/iYq3cp3T/Bzq9fQPJhGQbfBwSaVw7WiYbsgLh+GYVSeXckEJtfJ
 eqhxwhBRJPs8i94er9VH/jDNJMRWsfhcXB6NZFt8QiwrHNwCl5VZywHFQcTZ6Gz9gd1N
 YS5l9Qjq61cCDd9oho6r1R3qKO9/57yuo13ovR+/jt+LyzhtR1g2jKPWR+XPrlAcewOp
 VWxoQ13qMLflk26ibc3C7C5b4ZQSuHVGAvlt6gt0dmWiSUbgh+bXIzVq2l7KHZX8f9Px
 Lylrup3nwnr6RwDXDm+CWUTkvm/300yV24DzsIHEIbAOWV6ydZGIMVkcz5tTz/dKieye
 M1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754959726; x=1755564526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=surpJ98tRaESk7K6ewenyJUSlUpmPKhBVFvRz3srkwU=;
 b=Ijq/quDPPTwtuAmg1It7C4OsI+XLlgcE/91LFy088fO+OHGM3IZz1bPZe/vWkB+OTj
 ZtsQNkWGIN1dBjA+w6FOhYX5k4g/F6Mm1fkaZ+zCy6AnYrCv6vJo1omYO4cSJmqLwZqz
 uKifWttxRPv/fXoNF2A+BypeWMQwslNIF/kSweAESW9UXFQ13u4/nyIqvAZWJGkFcKsr
 tdIGYiIzhX8uBRO8XBjz7QWULanPd76F/LYXTgyKTLhA963RsqAvNoZpirzAcVjWteOT
 /lX01TCOUrb8I6tzyw1UXfjw7ay+Y6tziK0J7VfstxfSI18qAUrqvRBgfW2jZc3xhxdY
 IC3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9MvhaXu6SWJttPD/ktRzI1BJZsZGbCrVU20dFNaty+9+cwpFQZloiKf9myHBjMWB3AzYxXjKEVrCT@nongnu.org
X-Gm-Message-State: AOJu0Yx7BedTXwMYufZFDEJgHUAUE7Tb6EJ9DdC6PIwODSdOMhAdnrE3
 Pwd13IzxnrXHaYqKd72DCyQBesy6AqENS+2LPMRNpyzHgQY/qe3YWMSFkEuzAW2DWcU=
X-Gm-Gg: ASbGncvNRnm6I6hKbEoHN4k88cxDD+87WFUEd5OlVNZ3DaR56rCGnT1dXACMSdMCGKi
 1clf7JgB8jCKpN/hAnkSpNHc3xCO5MK7tYaIjzSBmmnuys2fqbkoRHtYubwCwaywJ7MKynuvzOn
 bk/14DLIOrnlVp/Z8X1JFvybHMTK1HNnPy7E5s2VojtpNViZIoAs6hlh+lZoIhKPCLO93bbHvwl
 KYnnpqvI0i4xnAyi16zLBAU2v5elW5gR/YgHIJ8bn/WlLvDUV3Wod25q9Vu1tT57cg88VcJH/Xx
 PbM8gtkcAYKa6Z+P3TMidMvID8X30I3PdC9kEZt54j6ygv8cnEtb8rm1UiCBAq8EROoMQsN+yvy
 aQ0bGjCqQiBpbiS/5/cWH58QaIjNtvZLdRuegKMZKkw==
X-Google-Smtp-Source: AGHT+IH36nv5aftkZHvXUnHZVxdwgQ0piS8gs8U6mo1ksuQEVDfYmd+B+94Lg+Gbueb2VGnIBsgn6Q==
X-Received: by 2002:a17:903:1aac:b0:235:6aa:1675 with SMTP id
 d9443c01a7336-242fc371057mr20701975ad.52.1754959726287; 
 Mon, 11 Aug 2025 17:48:46 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aab53dsm283244775ad.170.2025.08.11.17.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:48:45 -0700 (PDT)
Message-ID: <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
Date: Tue, 12 Aug 2025 10:48:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> +++ b/target/arm/kvm.c
> @@ -288,7 +288,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                                1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>       }
>   
> -    if (kvm_arm_pmu_supported()) {
> +    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {

Why is false correct here?  Alternately, in the next patch, why is it correct to pass true 
for the EL2 test?

What is the purpose of the can_emulate parameter at all?


r~

