Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B3FC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 23:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYuox-0003xY-SW; Mon, 07 Jul 2025 19:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYuov-0003kN-Pg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 19:00:21 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYuos-0003L9-MP
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 19:00:21 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735ae68cc78so2495787a34.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751929217; x=1752534017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U4dyTSqCBjLTAVmTQv1cHE2KynHbB74ReKkS6kQRaMY=;
 b=HqH29IZApLj8TM0raG/NITHNAXJL6ZekvAvUh4UeUVjH+Bq5NHZ52YQsjHPhZ0gtKg
 6zIKAaS11XjNfEve9O/uCgpbbQ1NM6n7NRJLfT4f5o+XW9TrLbdgky5ifdswaFOfRu0s
 7UpKztzLzI1FOZgvXAlXfqCUIV8mk1C5vUQg2wSfonSrFLOkzQgqpZMA3MSylESPaOQM
 YL6Opn51f44nYwvpBN5u34toEDSrpzVO6Ba2kVetDV/oma4F0OijE2xTEQ5bL2jRduNm
 1L1ytr1cZz4l4TgtkuwozNQS7OA/pbwXgzmQcOZd1rmYMj1vyk5umrRFPxxsBLaNn11R
 ZHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751929217; x=1752534017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4dyTSqCBjLTAVmTQv1cHE2KynHbB74ReKkS6kQRaMY=;
 b=s+IoDzw3k27c9WfZp7iF/ZjRL5KGJx79y4edgdLuGF8jX/K3VKA6MR+m+6vvL2hzrr
 0m5hC3N8q629wYyaZiTijjds7/4DDWCix9lvDNe1eiDRRWbLmQYqCLaVM0q26XRHTs5M
 D/bTWbb9dvbmyJXUmvygQkHb+3At5VJL2utebGOBf7nI7sNyrzTldCO4dpPmGXeNTyhm
 EPvk51RQ6shgRlixEw1iugmAhv7Npk1BXJyKlxidQoo/Oa1dQ0wZQ1GWzlsyUPbhvMhD
 EkbFIWbJ8js9y7pcZGXBzOSQtKpmZgW0nYXm2FFMWNIHY3O8Ynvz+kIxyk2WJ5tbluK6
 AdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhAb0nj7wSJkNoefqoFcHObof8iP3Bim9yy5ElEkB95AodIQ5TaAtZ0CCuTgjjMzJyB7xWayaMKM2n@nongnu.org
X-Gm-Message-State: AOJu0Yzrrvhvmh4GYiiH3yqgR7LdcLIHGtMwHCKcJCi7zr1c6zLLjK0W
 sBax/Leh8I9Jk11GYjPnF65TuQ8aj6fdSpuNtoFSN4OJs5MBaJ1wvwqNGSFQQrl9uxI=
X-Gm-Gg: ASbGncsZNIM2YD2hxuERdNgzVmVtb0rTuCnC/f3+zVHy1lQT6DNMl82ogqMJtk4COCc
 ceYsJKjEKiNJIggLAfLG0AIYuux6+IdVi9wI1UIp2oXT9ZqrUIf1mAU1cp8A2AIkxxYabYBbtjF
 BwosC1SYZsW4DlpjzyylhaMjT0kCtREcrR3MFRyUOv2y40f8I/F+ikVoLAzd+6hn5+eDdZsRwlH
 mjv0tjGziRox0ZaeMXTBl3xwyxJLu/NHhAuU+h1tb1hAp+impwRku3/dtHkPzWnSde6KUEFLFgX
 nmvnAjSEJUR5Fmf2MR6yRHcU3ZB+wB/XiKj9DWwEBvy9b+EvZf+2Q/cyTI/ZF85+7uXzdxwgsXt
 snkL86/8KwpiBRovRabssRxvDYcWz47WlFZrkIyvS
X-Google-Smtp-Source: AGHT+IEzPTFIRHpWuNG/w6XhrmJlbw9/1PG0zSJ5/lQ3iaFrOnshEH08Xe9uSB+puslEN1TX4TSB1w==
X-Received: by 2002:a05:6830:2786:b0:727:39d7:b0d5 with SMTP id
 46e09a7af769-73cd83e8768mr250877a34.15.1751929217270; 
 Mon, 07 Jul 2025 16:00:17 -0700 (PDT)
Received: from [10.225.72.227] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f98498bsm1746909a34.68.2025.07.07.16.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 16:00:16 -0700 (PDT)
Message-ID: <ef6b0922-6f11-4650-a2a2-c50085444c0a@linaro.org>
Date: Mon, 7 Jul 2025 17:00:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 12/14] hw/core: Allow ARM/Aarch64 binaries to
 use the 'none' machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707172009.3884-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 7/7/25 11:20, Philippe Mathieu-Daudé wrote:
> When we'll start to use target_machine_typename() to filter
> machines for the ARM/Aarch64 binaries, the 'none' machine
> would be filtered out. Register the proper interfaces to keep
> it available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/core/null-machine.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 3e03771d570..bd3ca6c7719 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -16,6 +16,7 @@
>   #include "hw/boards.h"
>   #include "system/address-spaces.h"
>   #include "hw/core/cpu.h"
> +#include "hw/arm/machines-qom.h"
>   
>   static void machine_none_init(MachineState *mch)
>   {
> @@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("none"),
>           .parent         = TYPE_MACHINE,
>           .class_init     = null_machine_class_init,
> +        .interfaces     = (const InterfaceInfo[]) {
> +            { TYPE_TARGET_AARCH64_MACHINE },
> +            { TYPE_TARGET_ARM_MACHINE },
> +            { },
> +        },
>       },
>   };
>   

Ought this use DEFINE_MACHINE_WITH_INTERFACES?

r~

