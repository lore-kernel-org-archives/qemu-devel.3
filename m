Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E049FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClex-0006P4-8k; Wed, 07 May 2025 16:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uClet-0006Kz-FH
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:46:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCler-000361-MC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:46:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so391447b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650784; x=1747255584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znLRp2OaQO+XQyL1geF9Vad6Q7qGDrE7+18ABJuo5EA=;
 b=E/nS9DbIMN11YLFkUHr4iovC26SqLSXhbDfjBFPeRrZyUcknufz8/q6qXAffg5rijY
 1dPTfaqFH3jcJVEpzcohMuB7pto6KkRbQm3ukWy3QMptwOzAP4slsqJXUVlMWEH31vkH
 TEcfnItF4v0IRfZzajf83OHsK06oe2w5nCOrLtl6/nol1kmkFZYojaekE9xeBNEzxYi1
 q/2vgK9sjwjwVG2UaOCSCnYduQKAfgV61gi8rOlMQyyhSR2mSbb32TfYsH81nbikto9R
 Z86LfoKywxeRByvDoapxQ2mPF3nhhJ6xEnhCtApGXj2UXU465MkdsYya6+lCeDIXrTWI
 38lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650784; x=1747255584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znLRp2OaQO+XQyL1geF9Vad6Q7qGDrE7+18ABJuo5EA=;
 b=rE5utu+3zr87hpBTpJFDbYvdjAgqVgxPex4+GwzLLi1rU6NvOK/B68vxYAxq9g1FT/
 4ETwalYKYFBBbo11YFbPPxtKqk6OU+Jn6oV+VPWpoRR6EpT/pSF3hRoqbEw7i2wucGZV
 ul8vN8dKO3kO7GL/6zsr+LDWNoT5odZ08o2YDQggu/fVtp1jA25KLdZDSuJMx90v1uqs
 vvLJcJzjbSzsvW7IiDMQw4JfyTDSXPAA2ElquNLvjVjCTNUqunFW3l9tODXkTN236Ehp
 HIgBJBTVs1kb3ZCX/7TQHI3ekO9qZHlNHgvIojIuK8E5E0VRAPDOzzSaJ+3QkFVRIhdI
 +pcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTd7GvGIvI0z8KpKsRrzFb3oH0O+TE6YB/i8RjqbRCNf9IQ7HOsSw2NGadkI8FHNm6jVMRL23XNREE@nongnu.org
X-Gm-Message-State: AOJu0YyHXhGynW590WnAOYetsNTCkgWhT/kSUTF5t3ElzC9ySjuNVKVv
 AF9EXEq2MIOl0Apkr9tmrqjWMvBB9SvnppJcaWhSFLmt0DkrONafdYmcdLyHpDg=
X-Gm-Gg: ASbGncu15jVNapvR+T8lSBy45vayzAJ5DAuiIyZaBBdxtKcEWQwNHN8fAGcCrFQ6298
 ZR4wmz0mFeUcaAX/hgDbimuqpj8cGqLDjchqgkqdfqqZJVPGVJmE0BEUZry8X4KdTvjeZOIu8T3
 AAua/jOlGyCcFEyJhlxIKLvcWy68br/PxDkMgu0GF1HZ2do/TmgaDoXjrxwcnHTZONPsSHMT8oI
 NAtwQK+tsNyOcYg2Ov/SpnCa83kyzBS+tALo2ZbfvxlIqMr94OopzyQRK6tknbGkWN2ujyk0i1B
 cAPqeZZpjfzk+TN2j0+T5YJ1V4EqKtaHbwb8ZmhpdvMhZg9inPhFys6QW3i58P8w
X-Google-Smtp-Source: AGHT+IF72mumXjYa2HKlpWWqae/xjBNEHG2EjQGG6+K6aRHVIdiz8Q1bmn7hSFxSjGwma8xXZD0GYA==
X-Received: by 2002:a05:6a21:3510:b0:1f5:7c6f:6c96 with SMTP id
 adf61e73a8af0-2148c40dd17mr7330092637.22.1746650783874; 
 Wed, 07 May 2025 13:46:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059065768sm11747647b3a.154.2025.05.07.13.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 13:46:23 -0700 (PDT)
Message-ID: <90178b05-9d5d-4834-a241-3f465573d314@linaro.org>
Date: Wed, 7 May 2025 13:46:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/hvf: Include missing 'hw/core/cpu.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal
 <m.ynddal@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250507204401.45379-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250507204401.45379-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/7/25 1:44 PM, Philippe Mathieu-Daudé wrote:
> Since commit d5bd8d8267e ("hvf: only update sysreg from owning
> thread") hvf-all.c accesses the run_on_cpu_data type and calls
> run_on_cpu(), both defined in the "hw/core/cpu.h" header.
> Fortunately, it is indirectly included via:
> 
>    "system/hvf.h"
>      -> "target/arm/cpu.h"
>           -> "target/arm/cpu-qom.h"
>                -> "hw/core/cpu.h"
> 
> "system/hvf.h" however doesn't need "target/arm/cpu.h" and we
> want to remove it there. In order to do that we first need to
> include it in the hvf-all.c file.
> 
> Cc: Mads Ynddal <m.ynddal@samsung.com>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-all.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 3fc65d6b231..8c387fda24d 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -12,6 +12,7 @@
>   #include "qemu/error-report.h"
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
> +#include "hw/core/cpu.h"
>   
>   const char *hvf_return_string(hv_return_t ret)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


