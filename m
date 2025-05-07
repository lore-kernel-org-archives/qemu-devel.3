Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CCEC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCleT-0005rO-5N; Wed, 07 May 2025 16:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCleR-0005ql-Oy
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:45:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCleM-000344-TE
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:45:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso353053b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650753; x=1747255553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dW8VxMVQtKK032gVZpGGhi7xw/ldWhEiLHhjvg55jgU=;
 b=dnpQlseMuuwSik63v6TzuHDV43bhTSk5p5r8zJsIYJWJZJavAmngq03WzT0v/Fve9m
 FtBupCDIN4sidykkoKSM1gcbYqFVt0rOp952vuVSzcxZ6MIsQ5jP51tW0l1VdmXj/inh
 nDsSItfcDsmCrjW7b5AGUbikkrml7kpjG7cJq7KN5ypBFn2O9w+G7PQ4xG0lm2/k5Nu1
 Q7Q6RTNxOEcjTPItuDjMxS1EpMzSA1o3xIEn3PgaRQrDRFspU0IUjVuRswQTWc92/BTS
 9Pmxzh7osrxB3ZLQpPvIQdiEYukcfflbH9uQTcxcDTYqeh+y/+ySfoiB7RXAdlKHm9W8
 iNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650753; x=1747255553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dW8VxMVQtKK032gVZpGGhi7xw/ldWhEiLHhjvg55jgU=;
 b=FRnqPrUOwCLARteV+OfeWizAtoW1CCWfaihTfw0lyu41OVDXLhHSSZTgSOEwL4e2A1
 gwN6ALd0pFGkB06P2+7WibkXbHl67APJmgTxSbdrjjjjd10qCBKe0BE6ZRC7xEWweTq2
 1sU8uSN+01IBeWbhgQm6duRJhQrfj9bPzUrJxHhBaVgtcdZ8zOvzsylXrZP2x9A9mKGU
 yC3Y6Ud1bW4x5uiKAwMg+hZDqYYyO6UnN2DiQjrMMzgDNafaNOCf/oPqsgf+NZjYBzhq
 sGzNaQbRa/i1zHgSzcvo/Xs8cgvW03vUf3r3zAbkhz/HcyJb3fYo8VNKqKHY78LBBm71
 viJg==
X-Gm-Message-State: AOJu0YyoWbggXppiV9cAH9zQCcLFopt8lp25njQNgMJRF4109RMDQW0n
 j+WdKjTBeyMo/yP2Dsn9eyQ4j2t5o74knEn8XTbrRr1Fhp7m7XCUcCSX5XndNjc8WNmUzlUKCMM
 9jCnHuw==
X-Gm-Gg: ASbGncvsf7fyyNT95AwmUyqx8zDcaIBJp+SckFFGKJdx5awA/qa6j+DAv+IWUBvwYS8
 /le/iiWFUXVdIq5Am/YAvaH6reMunKG0QDcaWqQn84TJqcV80I1L2dyFWD/bnaWwpCq4as/1PGk
 zH/XF6ScOwl4YUE0fPoPSUAnr1kUOCBUdNy+NSBd0UmIfyRE1FT+6PdIlZPNhiifN19a7vzqH5K
 fTqLPUd3Yg5HHp2JLV9w+1Z6kMZrmxzJy0FwYZKcGxa65g3HHgc8plteO/P2+aj+3EFFym9ZrOv
 54h0c/cJgWC6JMbXKRQyglzLJtZh9lUhMRG/H0rwz5JpSyNsMC1nEyBVOeSuJqUolxpgOyL02Pk
 4DSfeWZf4UtzmuQ==
X-Google-Smtp-Source: AGHT+IH+6ExCepLNLLdDv6FKHKw25SWUZElaBRk1dB+pq0S6lH3gKXLTKXhRvukvTitrFc8bCsJJMA==
X-Received: by 2002:a05:6a20:2d07:b0:1f5:8a1d:38fd with SMTP id
 adf61e73a8af0-2148b113301mr7344812637.2.1746650752900; 
 Wed, 07 May 2025 13:45:52 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7beb2sm11763443b3a.1.2025.05.07.13.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 13:45:52 -0700 (PDT)
Message-ID: <30351e05-b73a-4d97-aac6-246ef53607cf@linaro.org>
Date: Wed, 7 May 2025 22:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/hvf: Include missing 'hw/core/cpu.h' header
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal
 <m.ynddal@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250507204401.45379-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507204401.45379-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/5/25 22:44, Philippe Mathieu-Daudé wrote:
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

include it in hvf-all.c, otherwise we get:

../accel/hvf/hvf-all.c:61:54: error: unknown type name 'run_on_cpu_data'
    61 | static void do_hvf_update_guest_debug(CPUState *cpu, 
run_on_cpu_data arg)
       |                                                      ^
../accel/hvf/hvf-all.c:68:5: error: call to undeclared function 
'run_on_cpu'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
    68 |     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
       |     ^
../accel/hvf/hvf-all.c:68:48: error: use of undeclared identifier 
'RUN_ON_CPU_NULL'
    68 |     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
       |                                                ^
3 errors generated.


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


