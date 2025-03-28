Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16F3C3600C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGYu-0004oI-UG; Fri, 28 Mar 2025 16:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGYs-0004nP-TQ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:44:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGYq-0004ov-EJ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:44:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso26514475e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743194655; x=1743799455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1fhdZIg8Bi6/9e5SfxEjlLeTz0e7FHLJzyLveaXoOhI=;
 b=rXyE8a97MJf4F0j74nPuIefQpjg9b4UcfH1/CJ/IV3+GF+fGqmtUQQniB2p7fu1GdC
 3ADK+jLvWu74wara0NM8ArjZNYkEgBV7skvK3HFuN9VJsk8q9WGCTolhElQaF6lVVdpF
 ZDoQs5ZbAQK3ps99HvjuMnBcAjv4W2fZge2qH92vmo/2iFRJceUXcnMv6CDkpv+cbKBI
 k97Ly04Rg8el3FCZTa46XulK257ka+IlvV3AjvXhyVPYBuVPxqjT12Nu+UsHjwpSKdiD
 Q8nPldWTRv5tXSigzGJkJp0aaqeMfWDIrADFrysvtbk8bMLUOdWnJ6i2n33YdnsI+RUM
 sz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743194655; x=1743799455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1fhdZIg8Bi6/9e5SfxEjlLeTz0e7FHLJzyLveaXoOhI=;
 b=KTdgfyoxmbjZZZHo1qg2tXBXk4FTgnxjf9IpxrCfXJoeBHxfB7ygvM1C82yhOofeWv
 VAPpH7Ldo//lLqOEc/ob4l9skCHDYyWMsKovsoPYWOgw8Wu/FIxGEcz0ZrNTufgvAz+m
 bjXMlhcC0RbTBqTYGWGmf6nd7Nd05lIlBaD+j/NcC+SLhjuf5YCsAllRXteDpW4ObiN6
 9cIA9m+IAF9+1QWYtCpwn/kyWePV1yXnZR2PvqwmyjTbZL5AVOibx4UcAJgkZTe/4oci
 FUn9DMX8KnyBtU9fFoRwOKjd3wn2HASiyeSoG35e3NR9Hte7c3nfPD7tN7GYyYa1h6TS
 sGtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0w1LDp8JCXnyN8NdiD5HzcKtPYUyC6ONKu/a6kzDuvS9Dny0yGbPB+BgFfvZQeEgiy5WW6yQkUKmq@nongnu.org
X-Gm-Message-State: AOJu0YxmYyzLg7VtxcjbkDKaMfSgFtKEXL5SBwvD4hpoDtDHzhTJzQNu
 mw/ULtnbThoH6zhP+6dZJAovKBw+KzHB7GH0j6UjT/rCDYMat4rSzbOOaXyf9bI=
X-Gm-Gg: ASbGncu4B4DN7PvR6ueDzwA93Y0qFT92kjdVC2XVmA+v9XqrHIYHe5ARfdtlNMl8ux/
 Q7otojZs0KL2uB7b+79Nz4CkYF+gtcE0AuvkxAIG8bit4n8KzJ473t5j0OMtqpgD1F7MNo9lWyH
 bcD1tjhtMtCePhRVVPN54y1j54+lyIBFX7zxtBZdIdV9s1Dr+XVekIwIpuCEzTL+oJFDNwvl3uj
 rzr8w5AADZwSSwGSxXrHGxSMES45alI2sOBfDE6qYqmHCTk7G6M0UL9sQHXjQouSHjD3dSDpsfK
 2AHkwOKqgwwLrAIjqfw+3Rat7Y+q4CKxAe1N1RnJD3tbguveux/xqJrjvENByQx1lr6JWNoaF3P
 TQRGBErRhl7Aa
X-Google-Smtp-Source: AGHT+IGgP7gXxkmq5Jxf6HBLF99Iec86oKcTnIrWY0CdmZhPAOCK9OfUNmvXEoq5CzZdoj3WM8ZSAA==
X-Received: by 2002:a5d:5982:0:b0:39c:e28:5f0d with SMTP id
 ffacd0b85a97d-39c120e33cfmr446437f8f.25.1743194654756; 
 Fri, 28 Mar 2025 13:44:14 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4498sm3710618f8f.99.2025.03.28.13.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:44:13 -0700 (PDT)
Message-ID: <b6b45e60-026e-4228-a5a1-451bbccdd7dc@linaro.org>
Date: Fri, 28 Mar 2025 21:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328190627.3025-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 28/3/25 20:06, Farhan Ali wrote:
> Add a generic QEMU API for PCI MMIO reads/writes.
> The functions access little endian memory and returns
> the result in host cpu endianness.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
>   create mode 100644 include/qemu/pci-mmio.h
> 
> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
> new file mode 100644
> index 0000000000..2ef92455b1
> --- /dev/null
> +++ b/include/qemu/pci-mmio.h
> @@ -0,0 +1,116 @@
> +/*
> + * QEMU PCI MMIO API
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_PCI_MMIO_H
> +#define QEMU_PCI_MMIO_H
> +
> +#ifdef __s390x__
 > +#include "s390x_pci_mmio.h"

Does this ifdef belong to the header instead?
Otherwise remove?

> +#endif

