Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC9BD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRMs-0000l8-Ux; Tue, 02 Dec 2025 09:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRMq-0000k8-1i
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:28:36 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRMn-0006Ee-5g
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:28:34 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5dd6fbe50c0so2281326137.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764685710; x=1765290510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NnGRLN1IAzKCPze+12lgxpoZ8TR0UqxVjm0a5y3KkzQ=;
 b=juNnohKCqeYZO0cnGhn+6J+fP+tsTrVtEbRxj5wzVAIHxZj7kNzboYwFZUpDnxym+n
 uxZcRVAUEF7kqv22T3z1cLRh30wQaSP+8vPx/nKmiUYgeX+Z5suYmE0jPFlwe09RwCp7
 lZbhluJ0AoRhvx5Y7A+A/pD1Wv6hnextzyz6DiloR+Rj7W9xoXkrp+XAERgpnpZ4lScN
 LMBFETFbo0+umKUquU3wVFdLTGTpwtkCPKA9MG2E4AqevAVi8AFDsMpgZq/xkXp9PmM2
 1aRKn7nh/qJTDWFTbDFZqSczPwgF3dSi8sL6mQ/4c9wxTeLWMFbQsqShmPk+1IUTRoeT
 0ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764685710; x=1765290510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnGRLN1IAzKCPze+12lgxpoZ8TR0UqxVjm0a5y3KkzQ=;
 b=P1B5bkaSWBZYKUusUn/H95yJqFHUGMA1HHE6KmiAP+KTwfwsCh/ewFFOb2+RuiXG12
 CfvjsdlTH2H1qFb+qrF101obblWKGNjH/THvqj2mVQ9q+QTlYvtapf7pDKeIsXrjF/sL
 Zp42/dq9QUGes0a7W4DMCiNfRQ4e6fTwCBkmW2IuGloV5OozWlQO/P9sI/1sspcwLerA
 IUqx9hX8VaZYaa0j6ghBZMqXUPtGk+PxOIyb+jzkKhjWVamDyxCCXbvgVmmLsNN1UqFc
 J1/2P2vsZUw/bki/Wg+/jnUY4mIQ28l6SaPHAipPwWQml55rcbYGUyVOl6EbblUXnbAy
 cmyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWUo1C3w9YwKFFLibODS8izlRvBbrysRbPls5gwk4ehUXO2pcz0WKsHRizNmV4AJ3/1Vg2I18nRYlQ@nongnu.org
X-Gm-Message-State: AOJu0Yyl+StuP+mj9TAG+Noy9pxtjQc5FnbdbgefBs+GNEg3BqtenyB/
 NBmMzd8lvs6TCuTL0FUZyTToLsg3nIN7YL3KVGrzB60ieaOf9pHZq+VGMcAnfr+C0hQ=
X-Gm-Gg: ASbGncutzu2hp1PvIOI3z7EkCbVDhup7JFEdk2hhFRHfle++l5alYNXeCBfLmISQsvi
 Rf15dtxfSlc/AExdKFfpig7t82AjXmC62Gw41gbzGR0/djsHuGgn8q5FcXBfin/hK8ZPIvCRA9B
 x4MZeSK0MfrwBGPFnXSFrtkf+90b0MwoFQQVs25fM52U+pCFkTz+ErkEVdeXjhMUpi36KS5k9We
 g+QDPLMGZPc3EMcYt4s4I92CZSNTsEihkv57VcKz0/Zbpu0Y9y4gVh9vDds8jtjW8k/9zunzp5Q
 a30ntGZHvBEn5jY7NVQwJaf+AG6jJ+lf4AB2dnI7v2iG1lnntDRIqXGcbhQotVyXfUkwlwRKJZm
 DWVnlml1uGPCdsWN4UmfXAIDuSniURe+soqV1W4uaVUDtuXuLRuu1lZqt+1+2K5a8matHnVYtRM
 wE5p+FLkiuZ7sJGbPEMKbadQ==
X-Google-Smtp-Source: AGHT+IHkDKvcf3/7p/hecMtScclq20T3SeHyWf9XpplWr83COWp4RMbgp2fNXqeZ2j0G29dNSa1ldA==
X-Received: by 2002:a05:6102:5807:b0:5db:e297:2c6c with SMTP id
 ada2fe7eead31-5e1de4133c4mr15604974137.42.1764685710414; 
 Tue, 02 Dec 2025 06:28:30 -0800 (PST)
Received: from [192.168.0.102] ([177.139.2.175])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-93cd6c6806esm6663653241.1.2025.12.02.06.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:28:29 -0800 (PST)
Message-ID: <b6022dff-d1a8-475e-9403-e086ed93659b@linaro.org>
Date: Tue, 2 Dec 2025 11:28:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register.
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
 <20251202120250.763150-2-jim.macarthur@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251202120250.763150-2-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2c.google.com
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

Hi Jim,

nit: usually we don't use period in the commit title.

On 12/2/25 09:00, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-sysregs.h.inc | 1 +
>   target/arm/helper.c          | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c62..2ba49d8478 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>   DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>   DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>   DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
>   DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>   DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>   DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b..c20334fa65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
>                 .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
> -            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
> +            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
> -              .resetvalue = 0 },
> +              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
>               { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
>                 .access = PL1_R, .type = ARM_CP_CONST,

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

