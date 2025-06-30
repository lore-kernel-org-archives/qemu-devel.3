Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2170C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHuv-0004Gi-OG; Mon, 30 Jun 2025 13:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHug-0004Ev-Nw
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:03:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHue-0002A1-VL
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:03:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234f17910d8so44285515ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751303002; x=1751907802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrwSuaD+VoYFdUIXCegGF1YB386Md8D+3yHN0v09ydk=;
 b=aijQHZWK6Dk8lQFRqeVSifLYIhRGZF1Y8X7voAQtc+WOtMgmlGBtb/4aSiboWuafX+
 fSPAif5jYxJXQU2U9h3DAeMuWFaiLtwBKGOfy+c0H2eGnZUIUrvGWteP3sTrkj/AR91O
 Gjqrh0jyIyHe1d0Nmoa4ZTb7I7Xfu36/mBamGvzUu0QEY0z9KruLbmAWDegpsiOWjFaX
 l4eU5mBTpo3JHNCV1YYZvZGgUbhK1rtcVtIZx7zSnsdQelpqJUGpS2Mm0dCECLtgCbam
 wVg8g9Xh1VAAUih1jJQFEpiaW4045k5OcknPU13n2JRqbBVg5R+SfxMsr7andKSizGQh
 /uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751303002; x=1751907802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrwSuaD+VoYFdUIXCegGF1YB386Md8D+3yHN0v09ydk=;
 b=nHQXNbeZxYygKP86jA65/0a6WVFNqHDvMeLytATzAebqtqCeelhOyRaOAF0CA178bK
 hmR3V9zeqxa7qDHCK7JhjbbErltTq+Dh7CWrraWGZ8gTBskSCKnj/Ltc4W5TAF36qLQe
 w9TXNJQuhIjMQHWP9UQukS1a2w1fgwL805/NiNzTJNRrGJ3e8wJSLe5R/vbyVvdyouCO
 0wCCk45r4uxsxlxjeXYdUUViC1AWcHiX3m2ib8NU236SBy3Gsw6T05YPwnLyhd+EML08
 0eqB3Zo5L05jHEao3FaUy2re5Bzosm+fR/o95/Hi0yCy1AP+VSBThBhMkRNuXG64n8Zu
 p0yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKhQmK0kfcKA/QqPC3J2Q2RsZAPLM+VdH66HUIIag/IdUHmSlLjFSIzxP05qLKqHIG1EvzIMfW85t3@nongnu.org
X-Gm-Message-State: AOJu0YzQKPvJKpo+YqDIFLvfXorv+6skqy03a+QRYpFmhfYa1xqbmbqS
 u5bqbzf9CwFddNjkeJktNCoLgLv+QHhv4qZWLb21iYfLemWAynhD3lk4hQlVbU8Vnj4=
X-Gm-Gg: ASbGncu0wzHvvbyxh8iRxH5R9a5tZsXxc29UpJ+epFNm/JRTH/v+S3KZ2ttOSr8lgSz
 b89ztcH5BWRYcxeJ3sDtoxwSY6+k3E31YFeEvA7vsFxCDhlOnjHYjQUuwmFj8USHniS+hYEkyBu
 Puwsad6HxhJZcMKtPC1xRf+7uJNgLqWgLvn3lj22sjwj8FLyLJHfUSq7aF+usa4/QRdTiSNem8H
 0ddztsg0IYtEZ+r4Mmt8uqM5chUvCwpm/jfEfXIFffCOPfRVh/VC2NtyOewUdZ9iQf6dDM5SUin
 B/TZ5EVNKL1cTSrdsNUWZwUBBKGVGz4cdNksVGDgAYYFa2VNtMd/H5MkWUY/tPjBCSPNRSY+Z+U
 =
X-Google-Smtp-Source: AGHT+IF7jwW8bH4WMwCcHfVMsj33+s3MLF/FcAce/QU9etIlvWhRLQ36FSx2NDLSAyyjMwT9gF+1XA==
X-Received: by 2002:a17:903:f8c:b0:234:bfcb:5c21 with SMTP id
 d9443c01a7336-23ac45e4467mr223746585ad.19.1751303002164; 
 Mon, 30 Jun 2025 10:03:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3d27dbsm83852835ad.256.2025.06.30.10.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 10:03:21 -0700 (PDT)
Message-ID: <66593af9-0d9d-462b-a170-f4e81ffb7429@linaro.org>
Date: Mon, 30 Jun 2025 10:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/arm: Better describe PMU depends on TCG or HVF
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
> (ignoring QTest, because vCPUs are not available there).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c     |  2 +-
>   target/arm/machine.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index b6a8ba83a46..0311ff315fe 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2352,7 +2352,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>       if (arm_feature(env, ARM_FEATURE_PMU)) {
>           pmu_init(cpu);
>   
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled() || hvf_enabled()) {
>               arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
>               arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
>           }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index e442d485241..baa7ad25ca9 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1,7 +1,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "qemu/error-report.h"
> -#include "system/kvm.h"
> +#include "system/hvf.h"
>   #include "system/tcg.h"
>   #include "kvm_arm.h"
>   #include "internals.h"
> @@ -853,7 +853,7 @@ static int cpu_pre_save(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_start(&cpu->env);
>       }
>   
> @@ -888,7 +888,7 @@ static int cpu_post_save(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_finish(&cpu->env);
>       }
>   
> @@ -921,7 +921,7 @@ static int cpu_pre_load(void *opaque)
>        */
>       env->irq_line_state = UINT32_MAX;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_start(env);
>       }
>   
> @@ -1013,7 +1013,7 @@ static int cpu_post_load(void *opaque, int version_id)
>           }
>       }
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_finish(env);
>       }
>   

If I understand correctly, this is supported for tcg and hvf, but not 
kvm, right?
I'm just a bit confused by commit description mentioning "simplify 
logic", which is more "make it explicit".

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks,
Pierrick

