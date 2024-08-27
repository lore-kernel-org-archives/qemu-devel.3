Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA64C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siygf-0005pP-PA; Tue, 27 Aug 2024 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siygd-0005oF-5K
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:04:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siygb-0006dB-AG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 12:04:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a868b8bb0feso624580866b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724774687; x=1725379487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLgYrO+LxLYPBwlvFfZXKsYxR1A6Frn/XmRDlRmyWqg=;
 b=PgJMI+YLCtn8Z4GE4XBIM6/q2tfKDq+itM503sbOCG9eZWA0nnqQCop3SKPT4jLu5O
 b3jE5wuHADT99fNQ5CC6fFYEEisH25HtFvK754oFKBejwBTiT6p2dS5v7LxYSyeT4+1N
 DbX4bV07bxPqWr0Wk+QlPHJF/MO/dJb50OAjv5vxyu3IL/+M8SgotQX8fcHnz3igCHEF
 e2fcdb/a4htCif6ADOjk0QzId9dVinj5AsWMNlATYplQBZn545y/eApzNiACvP8jj+oB
 FS6ZMdF1vBtGOgcZvqpKAg2ARMHQMTNtvGHbQ54PyJAo9f/Wz2p4+C7VvtaHhXQszr7X
 6wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724774687; x=1725379487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLgYrO+LxLYPBwlvFfZXKsYxR1A6Frn/XmRDlRmyWqg=;
 b=cpaTF3IgLL4t4Cg/fMIWkMkN8KT+nQDZNd6CY79NkruceMQWNRezPhFIgrYUy82Jk0
 bn1z+2opZg6IwFKuhtH72G5kgDLizc/gRJXt2uH2QxdtxQrQn7lo8Pga2nZOW6+XYBF8
 6jlwJPo2W77bMkjpCyFlV60YyiG4YK3JreHwTjjxyXarKerR/HjwLz4wvRX7ludzUdZK
 dl/jzmxBf07JaQFUrrtzpiahtMWaj2m8cqvjBVr0IUXYMO+MNiB+lPRDYJ122tPJYDLI
 iFxt0/3IaPl+BkWapUjoAWvODl1bGVgBpGPAnvg+RbRtGfu8N562OjVv1h5AOS8LD+Zl
 E3hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgvNjUqTHUelet7343OgxPXzv9mUTlkMgC/6GlSYb1aGysD+HbZHnat4mqErSERGz4i6HuwsTOdIuf@nongnu.org
X-Gm-Message-State: AOJu0Yx1olt33jMFvRlbqkwyOugmVKzhlADsdhONk9ubS7Tr4TCftCJA
 636zkcGgxKPjO4m9KPeuW3SKK8N6SC0DLZOlEsh/jypd8mMh/ldcEUIbbdVk/1o=
X-Google-Smtp-Source: AGHT+IEOEvzzqKR0s+Pc/AA+Bf0Y8GxFaBmS3T4VJuojtEIhvYKsiv62oom1GISydMwYCM3kEdRnLQ==
X-Received: by 2002:a17:907:6d02:b0:a86:968b:e9c1 with SMTP id
 a640c23a62f3a-a86e398df85mr314137866b.5.1724774686937; 
 Tue, 27 Aug 2024 09:04:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5484f10sm125827766b.22.2024.08.27.09.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 09:04:46 -0700 (PDT)
Message-ID: <bbed40a1-fe6c-4f3d-b891-e9138f9d2fe9@linaro.org>
Date: Tue, 27 Aug 2024 18:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 12/24] hw/arm: add basic support for the RT500 SoC
To: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr,
 alistair@alistair23.me, thuth@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, lvivier@redhat.com
References: <20240827064529.1246786-1-tavip@google.com>
 <20240827064529.1246786-13-tavip@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240827064529.1246786-13-tavip@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/8/24 08:45, Octavian Purdila wrote:
> Add basic support for the RT500 SoC. It supports enough peripherals to
> run the NXP's microXpresso SDK hello world example.
> 
> The patch includes an automatically generated header which contains
> peripheral base addreses and interrupt numbers.
> 
> The header can be regenerated with the svd-rt500 target when the
> build is configured with --enable-mcux-soc-svd.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>   include/hw/arm/rt500.h     |  44 +++++
>   include/hw/arm/svd/rt500.h |  63 +++++++
>   hw/arm/rt500.c             | 335 +++++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig             |   2 +
>   hw/arm/meson.build         |   1 +
>   hw/arm/svd/meson.build     |   4 +
>   6 files changed, 449 insertions(+)
>   create mode 100644 include/hw/arm/rt500.h
>   create mode 100644 include/hw/arm/svd/rt500.h
>   create mode 100644 hw/arm/rt500.c
> 
> diff --git a/include/hw/arm/rt500.h b/include/hw/arm/rt500.h
> new file mode 100644
> index 0000000000..66ec82436b
> --- /dev/null
> +++ b/include/hw/arm/rt500.h
> @@ -0,0 +1,44 @@
> +/*
> + * i.MX RT500 platforms.
> + *
> + * Copyright (c) 2024 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.

IANAL but think these 2 lines can be scratched, as we are in 2024.

> + */


