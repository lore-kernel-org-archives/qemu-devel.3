Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EEFC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOl2-0003sq-Qd; Thu, 31 Jul 2025 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOkt-0003Ua-5M
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:35:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOko-0000jx-9P
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:35:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so445639f8f.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950907; x=1754555707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QywGxJNZ4VTid3oB9MjvOy3N3cJadd3yLdq4Ty9rhu0=;
 b=qisIq/OK9h1P1uk1DER2Tv1lzZ5UqMa7d561sKFxiKYiO94domVgO3+q0qzvjYsW5m
 4mks7ZJQxY4bDuhGy7wh0O5iG8ZlUVpN3C8ZNZhUvi6FXe4FhVRvHT2+YH65noywcauR
 g0Xx8yngqYJL0CPiA/OzangUsF8mGrOWZMJzPysLv2kSNY3JMsMAoyGZOTSocKrSnBQN
 oea7dz79rpJHFwrALQZOPdQHw/ehhWyo2tRtJ3GrmqmoB08WXEElqpvQ/887mnclrqqm
 wtJXYvpobkgGzh9zXdF055DDsuPgvzbIazV/+mC8FHD+z2wF1TzbW0hmKza6CiCI7zBl
 wzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950907; x=1754555707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QywGxJNZ4VTid3oB9MjvOy3N3cJadd3yLdq4Ty9rhu0=;
 b=GzEtb/YDhc/qQxrm06xeymZtznGkGiij+J4m7B7W6RRc9mmq+Js0QuAg87OTIVmWfR
 1V93vJEEFUAq5yR+pmbEe4rH9sAq26ykRKCbu8udXKLxmM9xmbenY6J4POpJdU6E383D
 SA+naGOVAt8V527cG5vacIJ6kZjSkghPH7ArrAhsxC1wt7EVeA7J3WcurcmWZflvZZuw
 0StavI3Qokc1ktsB9KaAB0Evmvqs3qAdigH5mEEz2Q/7PYMWRG7LkuhMxnlhuFylqRth
 HqSmg50kXDKLcdnZGj95a9krlOZH8gv39R38l9fbKaWYAD9xbw1y+7KP8e3bp1Iw4bLI
 FE4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsPVIO4P91i1lj7Jy4AH4SCTKxuS4qNsTTr0vRFQl5cjXLafN1OphYGpO3fT6T+g7Zs3NXCJRNDFjb@nongnu.org
X-Gm-Message-State: AOJu0YzmUWbJnXpiAuswtzZKJ3e+HJesrPaEEIDTYwIS3qQwsO4QALq7
 6mgtOKq0dGbhiSBkJsnHzCzvSWjZwQ36bG504Z6s08moAiF86bNZ5LJC9actie4iNJE=
X-Gm-Gg: ASbGnctuAlCuJlDNKUKqWaj6f5IP1lI4uTd8fwGsZpRNydq5UDoZfX4M3vohC0n0fjo
 I/017jniKKWkG/LmymcYWhjUSy7uHvxj1LfRQsuWHOtqLS49+B435Z9/4E7tUSg1A1W8zwl/uSD
 KvUPY5zU24SBeX7uifrKR4Cpq1zQGB0OVLaPzVRYwuchZRSiaOOcxEcJmPDvH0G0uRz5ODKuch6
 p2zGcmE4LiVn99WouKNRfX2McL4uoTVjLF7eKgcc5RLTAYVWBpVa9SFH9YF4Ga5OBVIl71ak4tT
 BzxKg77sQpEMhAmV4zRoFiqhd/lhcUWy11KTnEoZYDzY210BNlQ6P51Ssgjrekm8Mp+JX0DIvm9
 TQDXfzVNAOM7gGWXhMyYQfd2xPmFeXSlhdzpO5yQIR7qTqNMijCJmPVOOe7Div7AxNg==
X-Google-Smtp-Source: AGHT+IFY+JC0kb6nyLzhx8wFcAmxM0vkFfnEwiABAj/ZgVV2ppPZO6UTjNyj3UMksuhLPAHssho0lQ==
X-Received: by 2002:a05:6000:26c6:b0:3b7:8362:fed8 with SMTP id
 ffacd0b85a97d-3b794fc19dfmr5218069f8f.2.1753950907269; 
 Thu, 31 Jul 2025 01:35:07 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abedesm1634542f8f.3.2025.07.31.01.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:35:06 -0700 (PDT)
Message-ID: <2945e4b1-09c6-43ab-8640-6b7b9cab4a17@linaro.org>
Date: Thu, 31 Jul 2025 10:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/9] hw/virt: make Qemu aware that WHPX has a vGICv3
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-6-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731052753.93255-6-mohamed@unpredictable.fr>
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

On 31/7/25 07:27, Mohamed Mediouni wrote:
> WHPX is a vGICv3-only target without vGICv2 or user-mode irqchip
> support.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f..4996c2075e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -49,6 +49,7 @@
>   #include "system/tcg.h"
>   #include "system/kvm.h"
>   #include "system/hvf.h"
> +#include "system/whpx.h"
>   #include "system/qtest.h"
>   #include "hw/loader.h"
>   #include "qapi/error.h"
> @@ -2058,6 +2059,8 @@ static void finalize_gic_version(VirtMachineState *vms)
>           /* KVM w/o kernel irqchip can only deal with GICv2 */
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           accel_name = "KVM with kernel-irqchip=off";
> +    } else if (whpx_enabled()) {
> +        gics_supported |= VIRT_GIC_VERSION_3_MASK;
>       } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           if (module_object_class_by_name("arm-gicv3")) {

Should this patch be the last of the series to avoid breaking
git bisectability?


