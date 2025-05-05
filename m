Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE48C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBo1U-0007gL-8E; Mon, 05 May 2025 01:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBo1L-0007fL-H9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:05:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBo1J-0005ou-Bc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:05:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso5162928b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746421536; x=1747026336;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=stE+/AiEKyjjD1tUSI7CGsFvAxc9dfIPuDs0LN0vXgM=;
 b=Vg/bLHYSOzSfBe7i+N+QmtUbGQ0rAe+ZsbNHbrl6t8mtZShQptS++pnGaOgE1jEhra
 Ru/KK6L29P1x6h+K9emrXA3qF6f54kpjZxYpxNU4h4w71OrjOoU6NIVC4PF1wI5ob1Kn
 fJ4M8rhNGagZ4Jy9iUBxbJNDZjVPwk/5cUx1BiOawNQmVd1AfMgoxSBbkypWLmVi5x7S
 +9beJQ25yfTRyx3a8wnJvrotIj88SrE+PubBn/l+pBNEY0Un5amZJPRZPwxz5NMt9SoJ
 YhCe6VpXJNgMJBo2kbKAD/PkAIMwmCD+c1y5lgcN9tUXpluvOY6dOICPeFki8OC0xQjp
 sTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746421536; x=1747026336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stE+/AiEKyjjD1tUSI7CGsFvAxc9dfIPuDs0LN0vXgM=;
 b=oEGH/81mocCpWAziHsY5giqQLHOW4DwCOA7hWiKv0tPOZGSWYhqX+Mnb1cM/HvSfTo
 OJkkcE4WwoM4wC5VTN06gzSxegA//7pFK35ougueTE7WBR3AwKSNC9QwVwhsE/ccHjjh
 O0PReAHqpdBPLFhUNlvWZUKXU1tLNgwHiqMU76Rn/kFSUMz4EYh+woBGVp62fT7V8no3
 6IC01Pj7YN3jkf4GPe3ZSyd4nSwTFGwzrwpCiCFhtpZSGwGJhO4dC2YE9d2qswZrC/6N
 GiiTjC2/USpA0tsuSBNwyTrDRZkietQe2qFf0qJnmee0ROdXQE2FD3e7n3ghTNLjhdOD
 gZzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKIpDKMPh71ylpwuHLixPy97jCQ95PhN7Z09dWdESJRQosdlvK06zlteezA8GFeZDGbqe8ze6mbP2w@nongnu.org
X-Gm-Message-State: AOJu0YyllJaOSDKWgLBabUXA45aHNlY3Q9AsY9U/wAPRHlf27xLgObJk
 zLCRxtGoXPQeZYLLWBIGgnWcdzMorVFyB/wemdH+HMSIH4T+lIgm1fTHXBhYWmE=
X-Gm-Gg: ASbGncsH4uchMxFt/dHnUtAQfm/x8sc3oXAm2vri/Osjmzj/YjZB5t9OKzrjbL8HIQ5
 hGn37nW6RSY+IDidLW8nTGsrvoGcm3ta6E7iLb84Dknj8nf/QfJ9XlHzG7I0sxz+nO7B5L2GIir
 RMZNVDFGwdDJJXmQCO0ZOA5Nxh6BEIE0ZnarHrUF9q/ggwwty2aJaqQy+75eCwJ+vrymmyR/IGf
 MX/y/RiDzZbir7Us1q3skSEEKGuigtpz27bEtOhExHaJf7AAiOPqePaO2vpnF09NrDPrVjiM56v
 HFelrwLVokJkSMblUdgP5Cw2VgcJZkFY+7qyCtljzwXepuzG350=
X-Google-Smtp-Source: AGHT+IHowApGNlkda80oWOgCyD6b7Tzpyr+hu17UgAtZ54zKmuLdW4vV/F5Td0e/ikjLcK3/CCnPkg==
X-Received: by 2002:a05:6a00:448a:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-7406f18768bmr8068733b3a.18.1746421535796; 
 Sun, 04 May 2025 22:05:35 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbbcd0sm5952798b3a.63.2025.05.04.22.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:05:35 -0700 (PDT)
Message-ID: <00cf719b-4387-4e48-b9f5-eceb0f58f2e2@daynix.com>
Date: Mon, 5 May 2025 14:05:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] tests/qtest: Fix virtio msix message endianness
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-3-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502030446.88310-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/02 12:04, Nicholas Piggin wrote:
> msix messages are written to memory in little-endian order, so they
> should not be byteswapped depending on target endianness, but read
> as le and converted to host endian by the qtest.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
>   tests/qtest/libqos/virtio-pci.c        | 6 ++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
> index f31b3be656d..5dae41e6d74 100644
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
> @@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
>           return qpci_msix_pending(dev->pdev, msix_entry);
>       }
>   
> -    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
> +    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
> +    data = le32_to_cpu(data);
>       if (data == 0) {
>           return false;
>       }
> diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
> index 102e45b5248..76ea1f45ba9 100644
> --- a/tests/qtest/libqos/virtio-pci.c
> +++ b/tests/qtest/libqos/virtio-pci.c
> @@ -131,7 +131,8 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>               /* No ISR checking should be done if masked, but read anyway */
>               return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
>           } else {
> -            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
> +            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);

It may be a bit nicer if 4 is replaced with with sizeof(data).

> +            data = le32_to_cpu(data);
>               if (data == 0) {
>                   return false;
>               }
> @@ -156,7 +157,8 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
>               /* No ISR checking should be done if masked, but read anyway */
>               return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
>           } else {
> -            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
> +            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
> +            data = le32_to_cpu(data);
>               if (data == 0) {
>                   return false;
>               }


