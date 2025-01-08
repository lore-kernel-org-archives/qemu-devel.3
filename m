Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF1FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYjK-0007QS-Sb; Wed, 08 Jan 2025 11:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYjF-0007PM-V4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:16:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVYjE-00043d-5K
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:16:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so176402605e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736352978; x=1736957778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=na32BzO6ErjreppDgZ2XzihSeqPD0G5hqkKqej+Ta5g=;
 b=vLGOraKvvLXmOav9qNESkU2CwKS7qnLua/mrenI7drp8Dnu4VpcOoAR0BUpSV2Mmx4
 6LGayWcPMlgd4oEMmKKBa5KBWJU0DP8qUdMbr5+jRExncxFcwGtI5R7AKAxrju2f4c+e
 8NPG/owEf+UZ8bcUuESeKcDGSTt5J3voPurHKpwSCVGKyCQGgTMK2lUG7iFunr2LUFI8
 5ifTP8JJ82YO8dBiwqO0X7GMcHoPprM08Bey68IK/Uwiirwvj3u5yXtKw4Du2YrXiCGz
 Z17JZV1DirujiBNripUYtBZbJZrQAlu2+2poWDArSXzOe0K1ZMp+xqzY7c1lhjjm5Oru
 P23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352978; x=1736957778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=na32BzO6ErjreppDgZ2XzihSeqPD0G5hqkKqej+Ta5g=;
 b=JjSgTLB/9OGq1AeUe6uzJwhE+pdR4/lgb5madBr/CMhYx6vNU/sDLiScwZ01nJzGkn
 y52Kwej7Bwor7r6wanAzYNVJZyviVSf03pfNoOMjhYTTsozRSzVFi+PHDNyby7xRycUN
 AvGD3Qz8LQyuuxrBz8V3tms4u+DiG8xrPJab+WHuPC7r4zSE6b6wvVfxrWfg8Rwh5Y7t
 ckktDtVtP84JtfkAajyEdGt/lSyoeriLGNhtVbL9Ne+mJkmJ8agMBnbWPNgt2S06rkoj
 RN9u9A9j+c6o8DmyKLNhGz8BQ5QWbogpMF9PoCvqmnkERLxXs7LU3VsUecE5W1iRHgxO
 GYFA==
X-Gm-Message-State: AOJu0YwrjGGP9JhMz76gQ5HMmlBCqxwMoDl95JCx+u4oTqnvE/HzBb8U
 AXGEo82r9kTO8wSsg+EFugc5U8lYaBqyA65RBWx3u3GbddwFcNe6oVjR/SBETEk=
X-Gm-Gg: ASbGncvzCZjk+GFXPJhDun+8FE342op7/9i+TcbLeTksc9ZTFEb/d1LpoDuUGMW5PBC
 5XUGmL2Yzf+wTGQm1B6M5dRU/5wxs6Ow16oeQnjpTIjIoJ8iV3Pa+frNICSlcO0XZlW+39mq75S
 N9+7/pCgjE1yOv9Yu7m3OnhJj0WUP/wDAz/q4N/icDFMzBUCwJ5MO3IYVDEisU/rpOod6ZR0H/+
 eNyARnxhWpgif80hlACGsinnGnY+cphKS5p65wFJHiU+vvGhdHyWdhTx4JB812u7yM4Bp/+T6eV
 3NDE7sT2AOYSUvpd0ciz62qg
X-Google-Smtp-Source: AGHT+IEXQDxG1LLbj+edqryY9AOUx85ejUS5YN5zaEgiQhHaId3HFIQU1Vl0ZdLYRneuhKPEr1Fn6w==
X-Received: by 2002:a05:600c:1e83:b0:436:713b:cb31 with SMTP id
 5b1f17b1804b1-436e267f65fmr28104975e9.3.1736352978244; 
 Wed, 08 Jan 2025 08:16:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89de4sm25274775e9.34.2025.01.08.08.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 08:16:17 -0800 (PST)
Message-ID: <281928da-0465-433d-8398-4965f3e30e78@linaro.org>
Date: Wed, 8 Jan 2025 17:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/14] hw/pci: Rename has_power to enabled
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
 <20250104-reuse-v18-1-c349eafd8673@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250104-reuse-v18-1-c349eafd8673@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/1/25 08:52, Akihiko Odaki wrote:
> The renamed state will not only represent powering state of PFs, but
> also represent SR-IOV VF enablement in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pci.h        |  7 ++++++-
>   include/hw/pci/pci_device.h |  2 +-
>   hw/pci/pci.c                | 14 +++++++-------
>   hw/pci/pci_host.c           |  4 ++--
>   4 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index cefeb388bde5..c1e897f44143 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -674,6 +674,11 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
>   }
>   
>   MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
> -void pci_set_power(PCIDevice *pci_dev, bool state);
> +void pci_set_enabled(PCIDevice *pci_dev, bool state);
> +
> +static inline void pci_set_power(PCIDevice *pci_dev, bool state)
> +{
> +    pci_set_enabled(pci_dev, state);
> +}

I'd declare it in hw/pci/pci-internal.h to avoid moving it later to
"pci_device.h". Also I'd not inline it, implementing it in pci.c.


