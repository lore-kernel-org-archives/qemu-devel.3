Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E991AD637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfaG-0005r8-Q2; Tue, 16 Dec 2025 19:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfaF-0005nk-8r
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:40:03 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfaD-0008WJ-HH
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:40:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso39271915ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932000; x=1766536800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OsJv/t6JXK8mzVugX2aooTmyytBaqQ6CjDFOSLCtGjM=;
 b=BKC/FWz8qw7gsQYooZvzvtIHJZC2D1qITgCDqdM0EqiGZIPQKKkgYif/zwC+8Sp7P6
 ASLR0w21UwoYLEbW2QrBRPJrKF6BrGvYDdkKY4o3uDfyeH16tWRBmD1zCoPmTYcMY/uR
 jJvSQbhm8FkOiXMSVYSt+kVe7Gi0VkXh2LIDLOffcYUsfjWy01oQbGhNl7ltVH1sA0UQ
 4+FtwndkASn2IzRuQXywc1DSSXn7MRqMX0HddvxvPvanRawU0bvUbDvUQB0tBTnYLA2e
 SBpKFNphzs3jBsfPGNpG6lxpEZ9+YghiUc7a5LRSR6+HwFFfBWI1ZalQU/HOv5hcd935
 GJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932000; x=1766536800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OsJv/t6JXK8mzVugX2aooTmyytBaqQ6CjDFOSLCtGjM=;
 b=sA7QQKwjOt6LSbbeG+XaBWtaCSvTDkwMcKeUS5IUjnug3dhdCcRE0SbxsoiWTuKtQs
 pkpXItnPWFglSBhNPf6/nnrLtJ7toKUAVtNt0LCC67iN3hVjZX9538oQkQRR9jub0y1Q
 Hc6MYE/uo1kBUpYA0Cnj1hAovKjizYgkgoK+aYTuKLo5rE3bNeSPMo/UrY7jMOvdbTM1
 o/MmdfS8PruNp4WVPbw45Q8/lshxlmLdcuUUna+3uy8l6VB+mvRC9v7NgKZ2pwmZ6I5d
 O+rvP4y3q3Efpd2qOIW9+uq4mNErF3hWTqbPPAzaFmiSy00BMRXvGNsS1WoCuoNGUcJb
 3yPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGEzma4j8Pka9eTZkN/oV6Jm5/A4XaY4mOPj59Cq5I508WSTk0To//xidlTzsilGUF3D2bzOdjXlRV@nongnu.org
X-Gm-Message-State: AOJu0YzIjOQkNKVzbm0Wblh2Ob7dx3e7FjuDBcgikSEokcd1nFqkbKRR
 bljbg5E1TS4sjitTNwS3J1SRP2g7d/8AN8TZPAFFanWMqORbNnCsq9pEx/yrzjoqahE=
X-Gm-Gg: AY/fxX7bZLqugPSE+l2aa1t4pNwmZqePHEgYmxXK+B1poEegTaZYLvapKFLC8AOJ9a6
 476aKwvCwGPW/06Fn4iC2Hn1ySRLYgjnFqSP18A3Wr3OtWqbU7V40xt1zYmjk9E0IW5ZCc4UiSu
 Jv3q5OqAE4FG9iM98RDjnGmlKJN/DlMTlcKVLU6b9pN3mjQ/kYjk3J1NDYHk6A5Kv6O5Tpepyvp
 wXLiW45tdFx502Oanymn/xkgF8W7pTbKk/auCn6z02vn4sFak9BFV+lCXq6UWEWjrU+1U2dKstv
 4pENpvgakMnpOxrIZcHfZgz4kNOrcAeuCklktefLsDQHaRV2U4x5nljLnphD0QN+n3BeyszmHQa
 9YMkNznxVUf831WZG6vu5rIHtIaudUZzCOuA1FM811MmmiynwVnvikwDlJcDkMqQdqvy1k7+Xcv
 wT3Ne/oXJXqJrlO19vOJ0S3Ztd8mNxp12uMQoMAFe5MBoNXHTHbklPm4U=
X-Google-Smtp-Source: AGHT+IFXUgN5QtcfuvUY+Q9r2XishTa4T/HwH7CUX44DpnklD5eLz1ovqUd9vMu9Tn2jmHOO/a9JJg==
X-Received: by 2002:a17:903:1b23:b0:29a:2d0:c1b5 with SMTP id
 d9443c01a7336-29f23b6aed5mr184215045ad.22.1765931999859; 
 Tue, 16 Dec 2025 16:39:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29f301bf609sm131981075ad.23.2025.12.16.16.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:39:59 -0800 (PST)
Message-ID: <72480685-f451-496a-a3c7-03d8d82a58fb@linaro.org>
Date: Tue, 16 Dec 2025 16:39:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-7-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-7-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> TYPE_RISCV_CPU_BASE is used only to initialize the correct default
> machine for 3 machines. Replace it with a runtime check.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/virt.h         | 11 +++++++++++
>   target/riscv/cpu.h              |  6 ------
>   hw/riscv/microblaze-v-generic.c |  3 ++-
>   hw/riscv/spike.c                |  3 ++-
>   hw/riscv/virt.c                 |  2 +-
>   5 files changed, 16 insertions(+), 9 deletions(-)
Using directly class->default_cpu_type instead of callback 
class->get_default_cpu_type() works here compared to hw/arm/virt because 
default cpu type does not depend on accelerator used, and we already 
will know what would be the runtime target at this point.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


