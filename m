Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99638CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKJQ-0001WI-9Y; Tue, 04 Nov 2025 11:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKJM-0001TR-3G
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:55:12 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKJK-0006FP-CJ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:55:11 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640b9c7eab9so4228161a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762275309; x=1762880109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k58nC+Qs5KCxc0xAl3JDLw2EGWrHyqBNes9ykhTTOSM=;
 b=Z3JIlcXimQAvyGPho+XZgdFTB86Kygox6F4vQ/Ew5ZPDGgBANGr++F8NCu17i8/O11
 U0Mr05wgBVTQR5Wn2rqaJWb2J5XVAGUCssV4QloYP34jxyF8pXLu8zpF+IuL6kx8x3Mb
 uJoHsfNot35H1FEiDBR4GEVr0pqFUb5k8WxLGSlJAMXhg0LTSMOpF+jAzsMw15pnTfqV
 Wc2nhsEdBvAfzp4OebXi8KLvoHpzHPhpybKQqcgvWugHyezLs4EJTIbVH5wkSaW29Q7o
 B21mrPqrZSy2/fQblaT2wdiKBiXX/P9wHWeksa5PBsU4v78tytpgT6ZTorDX5O9WkeaC
 oYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275309; x=1762880109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k58nC+Qs5KCxc0xAl3JDLw2EGWrHyqBNes9ykhTTOSM=;
 b=ltNtK3HOTHISZT44T5IzsmXiM4YRre6yplCV9m5J86pQXDCf/PmnTo2YgO6UY5Ap9e
 mRWhFKpiE4pdqXLuRPinouNtslRNb+QBuuIngQQPdVi8116PSEib6pmCmPyoRWp2kctX
 hAyy+vVKsyp0vJ3QnZP6FM7dD6LNIWtXacxftjSr4d+w776SNrPZNIUSzos2QISg/1fL
 f4dEv+9G3dcJUc5lAN/TXarsyn5cf84TmjZ9Z42CIaElPFnXyJZhCi3POapBoIQcunC7
 NP3gLrqA8Xcq6nYwm8Mey/ou5+fp+yBW27HJmuweLJmkOFha0vxdehf4zFKQMqIc7G0A
 tbjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7cVOpRJpUT0fW20YiEuiKFdDWLXa0ljtj2LRg1gqJ4vk2D2FekeMgGI53fbwDPm7H5WzqDM/cpm72@nongnu.org
X-Gm-Message-State: AOJu0YxkgkcpTTiPTu1nNbihpWFj52Qcv4lrVHtKbAEOMTkn6fsL3mBJ
 /Je2tM2HbnyyP6vrmPjWwg3Qgw5Q+5KEBU0cRy9GFRyLigb9XkVgmwDI/14nEshrr6Jkzow2UGz
 n9ld9LSryGA==
X-Gm-Gg: ASbGncvX4Y5i/dz2LrPYP8m7BaizRMJdzSdatWboY7qD84baGIIHcgf4r0Ud929Ocqm
 3hypcVa8goCBwuDlGLo0wAWTHgUfm0rYqvSri0/qzu6lPaIHygeyveetmvKLa1gTUwKieMAR98L
 D4gH998u0nEJqqD0Zk4HEiqTorQZoOEoILMxI1YtxiwwVG4qUswsp+qfBMHRt2R1qcN1ByF6OQl
 m+FcFCaxfpisVB40ZX6mMgr4nkz9zxZwMtLaWzGEpvD1J1y2stG9HeAMCMCtlLnUABaFXvyldMM
 dqTh+e5hEpO/JnUWtyX4hC7b8tf3cvUYhuH2n223fDNeutxWl0iqyrg9gx5ZJ1/0rHZn643Rmxi
 qwGdjMZQetZbV9EV3ys1hk19+90hTsW/zgoW9IzKHprowhZFWHicg4yhecImArwKYfNYVxUn5f3
 30QZT8U4rIURS1GSm3EoY=
X-Google-Smtp-Source: AGHT+IEP5zyPlzzTcbnbPhUmZg7hfL4X7eX9DhWx3SjXRmDuRhTe9QMslhm+2efTyut2fRgkZjKPkA==
X-Received: by 2002:a17:907:7ea0:b0:b70:4757:eb01 with SMTP id
 a640c23a62f3a-b70705ee87fmr1881137266b.32.1762275308701; 
 Tue, 04 Nov 2025 08:55:08 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e06edsm264927066b.47.2025.11.04.08.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:55:08 -0800 (PST)
Message-ID: <48efe021-614f-4c77-8770-bdb7b5e3cfdc@linaro.org>
Date: Tue, 4 Nov 2025 17:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 5/6] scripts: Add helper script to generate eMMC
 block device images
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
 <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 4/11/25 15:45, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v6.1:
>   - address BSD shell portability issue of stat -c
> 
>   scripts/mkemmc.sh | 219 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 219 insertions(+)
>   create mode 100755 scripts/mkemmc.sh
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> new file mode 100755
> index 0000000000..45dc3f08fa
> --- /dev/null
> +++ b/scripts/mkemmc.sh
> @@ -0,0 +1,219 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Create eMMC block device image from boot, RPMB and user data images
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.
> +# See the COPYING file in the top-level directory.

Failing CI with:

ERROR: New file 'scripts/mkemmc.sh' must not have license boilerplate 
header text, only the SPDX-License-Identifier, unless this file was 
copied from existing code already having such text.

Do you mind if I drop these 2 lines?

