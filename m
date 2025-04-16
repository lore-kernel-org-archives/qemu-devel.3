Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D06C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wHO-0001U5-Kc; Wed, 16 Apr 2025 02:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wHM-0001TQ-3R
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:29:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wHK-00080e-1N
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:29:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so34891985e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744784984; x=1745389784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKNZDPkdYN45C03Ar7jz8q/Zu8xstH50YzPI+0PaZHM=;
 b=s8cvvIurqp0lzol+ipKhNq7+x3yMgaylPh9i8v6gazVHmH4lSRaJrF0J8v0tMQGLWb
 mCKtbvtHyBYGu+SV92m/xHSOTXSfgLbzklpi809q8ClY/1k/nU9s50+1WbLntnczHaq5
 pYjA0dXOUfQz+vAkdq22v5wwYjCoSoyloZ09E53YEAUUoU6QYOnoKVjP0EgrgyHbf9wP
 836ajx0fHfkgyqkQlgZ3dIcoSmyARMtQZKT+fU7K+NOuSlbEV+jHA5HHSjy/6sSfgveQ
 jhS5GFmas1CLyqYEQNZ7v4UDXaWB6U9+IogprUeskziVU6boS7hguXVWSXmaAlZrBEdm
 P6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744784984; x=1745389784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKNZDPkdYN45C03Ar7jz8q/Zu8xstH50YzPI+0PaZHM=;
 b=gavsUa2jvDmNNaIXgAO+nafFsxBBMhnZP+ePcs99j9vY8kXvx5H5PhlAKY+d+x4zcm
 rK5NJ2/IvyYW28PtXflmsi/jxKWy7sSNfaowsfmXoC5jvSRFzgCOFT2mMu3FE6x+ptT4
 n3vZKxkaHYenGZSmQIZw1G0yYID4pY3z8wlLJgoc/HTNwcrvqr1my7R1ha1v1zvOWx7Y
 kSomT1j94CgPj3WrrMUkIwPwODH2S2UQ4Hc36Ncot30BUY7v8195FKDWssybUukL0vOy
 vQ39PSSyALrG4nTCDyHrQ5mbTmtGrvpynpW0oXrIFpJ0HM32PiBa+K7ZBGPnSHJbvWHe
 uxog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQxTzXNJfXyPf/vceiXDW2w6CVBTRhxMhDzA5KKLZiyueWeJF9KWkzfRoNYq44g3K7UXKNXDKFbBSG@nongnu.org
X-Gm-Message-State: AOJu0YxDGxNjZ4hv9D8cIPnOhr4RqCv84OmYM1rORUmvzqV49O/p0omm
 SQvu2P27nciDBBnVKccdEhNqik5idY8vOtNqb8T3ytU0vQW6EG0r6/MIbzXj2eE=
X-Gm-Gg: ASbGnctfFUJoO8cbT/M94hZTgT0ZPKsST+aftvFjHxUOQ+RYw2KW0h0I+ydHcd9PPHt
 meyop3Ar80o5toMl3xUJtdju/B+lNKqO9NuKc0PYoiyfYR/rqNt+3Y+HfOS2wO5fYUlo8P/ybwv
 mrQS3z1daSnOO3eLp3xV0enBtTU5sBHhzfzwocgbzlHU3/j/t8dtbyvL7SgELb9hiHo7IDNNGwf
 dzho6hMgHMxCFnRznjVqy8dUPNwmswiRocUpYD1GmKUdNKqrU0wJQG1Kto9bjAogI6DpYGUaO66
 9E30CvrWSXXRWTMuF3uJtaLADdbWDRH8y6Ik90oRxwcJGdVDHdoMSm30eIjJTZTy8PSQSkd2YK1
 KCUksMA==
X-Google-Smtp-Source: AGHT+IFl+1CalyIyAc93DoOapeLwaA2Ptr2zf4oUVAyl7wFw1I3fwrQYbAOkx5joX3n6UeJ6HEAQIw==
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4405d5bdb1cmr5153745e9.0.1744784983801; 
 Tue, 15 Apr 2025 23:29:43 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445737sm15899803f8f.88.2025.04.15.23.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:29:43 -0700 (PDT)
Message-ID: <0d3ae936-7013-418d-a478-48d14b5b8e70@linaro.org>
Date: Wed, 16 Apr 2025 08:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] tests/qtest: Fix virtio msix message endianness
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20250415081914.378236-1-npiggin@gmail.com>
 <20250415081914.378236-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415081914.378236-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Nick,

On 15/4/25 10:19, Nicholas Piggin wrote:
> msix messages are written to memory in little-endian order, so they
> should not be byteswapped depending on target endianness, but read
> as le and converted to host endian by the qtest.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/virtio-pci-modern.c | 9 +++++++--
>   tests/qtest/libqos/virtio-pci.c        | 7 +++++--
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
> index 4e67fcbd5d3..67aa2af0bd7 100644
> --- a/tests/qtest/libqos/virtio-pci-modern.c
> +++ b/tests/qtest/libqos/virtio-pci-modern.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>   #include "standard-headers/linux/pci_regs.h"
>   #include "standard-headers/linux/virtio_pci.h"
>   #include "standard-headers/linux/virtio_config.h"
> @@ -136,12 +137,16 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
>           return qpci_msix_pending(dev->pdev, msix_entry);
>       }
>   
> -    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
> +    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
> +    data = le32_to_cpu(data);
>       if (data == msix_data) {
>           qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
>           return true;
> -    } else {
> +    } else if (data == 0) {
>           return false;
> +    } else {
> +        /* Must only be either 0 (no interrupt) or the msix data. */
> +        g_assert_not_reached();

This distinct change belong to a different preliminary patch.

>       }
>   }
>   
> diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
> index 002bf8b8c2d..6b421a4d859 100644
> --- a/tests/qtest/libqos/virtio-pci.c
> +++ b/tests/qtest/libqos/virtio-pci.c
> @@ -131,12 +131,15 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>               /* No ISR checking should be done if masked, but read anyway */
>               return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
>           } else {
> -            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
> +            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
> +            data = le32_to_cpu(data);
>               if (data == vqpci->msix_data) {
>                   qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
>                   return true;
> -            } else {
> +            } else if (data == 0) {
>                   return false;
> +            } else {
> +                g_assert_not_reached();

Ditto.

>               }
>           }

Splitting in 2:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       } else {


