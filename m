Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A13CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohyJ-0003Ly-TZ; Wed, 20 Aug 2025 08:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohxQ-00034x-3I
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:30:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohxN-0002ud-H1
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:30:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9dc52c430so3274392f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755693019; x=1756297819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nuuc7lpR+hOx7mlCMzaenxMc/SuZ/aErgHzx/AwYUCc=;
 b=yfwRD3J3jXS92nWXxCRJdla1+BhQM0M1v0BRSv3WDJreUnLhuXvlpHzE8fnVUXgV6v
 qfL2vLlAykfHz91dh0yC642naTveniUFbPue60gmo2mVKUDsDAxSonYOsAweMGjPOcPE
 YhTWTWbLgtaVH17m/ZiA44C9on/ZD1hUxyzpuedR0z4a2vnAR0Yxvco2CsZ4CFpwyRF1
 9awSQ36VGNLzixOIVvg5Fi2/TByPqt61vSlxCjA0pLH2YgM4e4xTuc/CPiUz05H+ClDU
 v1MRgjJOdE0aaIvS7B2+SBmO8k73brnbMfY7CBdjGVdwnxQ9CaUHSqtZGwobXBpGNR/5
 zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755693019; x=1756297819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuuc7lpR+hOx7mlCMzaenxMc/SuZ/aErgHzx/AwYUCc=;
 b=MtOzBqmxIBY8E9ZwYZgh+a0G7ecLP78XDpad2B0RzGF10laAf3lDQ6dKEm0/3/I/FO
 J+mLgIkb9vjEz/YfRkwjP/2SUIGwEP8Gg/Z5L5WmoRuxqOCI5PfilA8EVBlBNt7RySNz
 iApYrlsW90ei6VGtaId7fvJ7zJafa8YoEwZVORhIyEQ4MawQ2HSh3peXYzGx1cqfGJnJ
 ZGAdEJwxfiBtjm8X+RATxqAyveXJZLMnNqPo2jIkYcDMTrvDpP6RdKz9HF7VnLZ0SDEC
 zgIAP7P08jMx529+N/zGkMI/V+RIJj0p3x3GVX8pOnBayGu4XVhnuNsr5+EyCwg0k6jS
 1SKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYy23rtVKdU478j8HuNamAeVFNA4sNYjYcQ4SjR8cAxFYVtmXufjthmCPcf+bXTUSFrNDqlp2uf6Ek@nongnu.org
X-Gm-Message-State: AOJu0YzAhBwXPwE0BKocNwMh/nexQtFym+A+QilcDkvu4iLSe9XfebIZ
 zoKLhyOi05BNaqWB3HG19DwF1Pp3vq8IDe8IEtfoKfvE7sMx9BJxElWiwfg7Tw1eOPg=
X-Gm-Gg: ASbGncvcjJXan+spc7JCFX1DWSWkY+qIWJOTjrRXJBpBMfCLboLMCMcR5fkHcIapDpS
 9dC8p/KXXlU+0gKRDHvw5ws6YTET53dv9JWKgmodfVuuNqDS77sO6s/xdT+IdYGjNhIMS71Pr/d
 9FvQ7ppbIK2z6Cy7cPvDhxGC1tfP732M408quOpTDS0afhsksEUp2KS8d2z0HdQa2pbP4IZvnKO
 dE6Pa7kIYxMIQn4pVReAKxfu6JoctZaZm4U+qjSXFDu2DV5dvn+Ga7Lg95O+V5ISKU6/SZoT5+5
 VAEquY4MFSIkbPxaYa/AfET9mnMYdtZ5eyC6jWjM7/Ut2xXxcIhEUzMqzZszDf1E5lNJ2Sd9JMA
 dUiNQpLVr/w+Wh7Nc4pVi0tmF0EKPmb61fkE8//9l4YZuuC03FYcjYRugmANWx13+tFEyA1U=
X-Google-Smtp-Source: AGHT+IHHN5wTmuWxeU1gF6ZOOcjvSxrbRh++kDhXWGUVVWbMQpSiHbDjjNgZVGIKsDBwI3309C7XCg==
X-Received: by 2002:adf:efc5:0:b0:3c3:973a:fe40 with SMTP id
 ffacd0b85a97d-3c3973b03b0mr1297084f8f.58.1755693019216; 
 Wed, 20 Aug 2025 05:30:19 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777884e8sm8224084f8f.45.2025.08.20.05.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 05:30:18 -0700 (PDT)
Message-ID: <a6a9b8ab-9de5-4d2f-a9eb-7ae9a638df36@linaro.org>
Date: Wed, 20 Aug 2025 14:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/47] hw/arm/xlnx-versal-virt: rename the machine to
 amd-versal-virt
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-42-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250820082549.69724-42-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/8/25 10:25, Luc Michel wrote:
> To align with current branding and ensure coherency with the upcoming
> versal2 machine, rename the xlnx-versal-virt machine to amd-versal-virt.
> Keep an alias of the old name to the new one for command-line backward
> compatibility.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   docs/system/arm/xlnx-versal-virt.rst | 26 +++++++++++++++-----------
>   hw/arm/xlnx-versal-virt.c            | 11 +++++++----
>   2 files changed, 22 insertions(+), 15 deletions(-)


> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 0f114ade652..4495b20ee1c 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,7 +1,7 @@
>   /*
> - * Xilinx Versal Virtual board.
> + * AMD/Xilinx Versal Virtual board.
>    *
>    * Copyright (c) 2018 Xilinx Inc.
>    * Copyright (c) 2025 Advanced Micro Devices, Inc.
>    * Written by Edgar E. Iglesias
>    *
> @@ -24,11 +24,11 @@
>   #include "hw/arm/boot.h"
>   #include "target/arm/multiprocessing.h"
>   #include "qom/object.h"
>   #include "target/arm/cpu.h"
>   
> -#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
> +#define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")

While the alias works, can you also change the machine name in
tests/functional/test_aarch64_xlnx_versal.py in this commit for
clarity?

