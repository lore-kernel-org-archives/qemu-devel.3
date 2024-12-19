Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB12CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCRx-0007U7-Aa; Thu, 19 Dec 2024 04:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCRv-0007Tf-O9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:04:03 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCRt-0003Lh-M2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:04:03 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-728d1a2f180so430842b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734599040; x=1735203840;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vm7RnWARqYVimKjJK3+U1vshDc2M7wMMPA3QHKSpLA0=;
 b=Mpes+J/I3fn2ugKdOYP5Pgh8IGsbyCxuRi5+gvBXnwnjRdU0p+ej38MFzatXhch8BQ
 yI2d1sN7gN3F0hoqV3LwjqOxcnes2VYP52QEkhW5mCUZ4Gg4b72fCUTB/SU+nXGhdGL3
 nAAtIt7QocYXuhBaC50PWH8vb510koImG3g4QtXSHEwa2dYm13+99ZAcaA6mKbaeJdFz
 fh0bXBp3IkEGE7P3V+jg5RGw16uq6bD5OcZhn9bl8u2LbIRHGdAQRZZ4cdAsEodgwfwd
 qawKbO/TUZaHWeIFEl3cX4WGfKtSXI3oCQ5bUqFVWEv6lLrqoKETjqH3IcspJJyeAN0N
 2+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734599040; x=1735203840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vm7RnWARqYVimKjJK3+U1vshDc2M7wMMPA3QHKSpLA0=;
 b=kKE8zUzYvZeYSiwf9GJlpLyOX546Ns1ucFzpEgbJk6XsYAFUR+1qSvK2sqGKUYQIrG
 dmIEuyQ909DgJSVS37q6XWYij5F4oLAtHG+X8LNF4TKdK+CRhSv0wTRBXCq/p/VEGwWO
 Wj2k8fPrO8Hs/kpmG6Vze8qH2bZxui4NX9TfMVLhSaY+DWlsiriEeP8S4433RmnJneTp
 vtKBhkKBdHup2o/jF8FROEB8JPCzuQMtkyB2faZz5d7stbiNB899FlbCEpFhN6Ae7ljZ
 q3eGK5rAjKhAFRmR33LXpJP4yM5Tg8e2CYEnsR/0BkGOHy2UI0bHu1aHAluGJ+zZlj1F
 VaFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7TFBSCKO2hgpAvzxuFLfir0LtNsymWim98eJs6fQlsriasfwU7qRWTBB7AbCMEhRNppdVjJm7A80q@nongnu.org
X-Gm-Message-State: AOJu0Yw8EE8B6rX2d3qpiSdc/ZY1YV2KbNrn6TjPlbT4DCkCccGuLClw
 0XlQAzbFU2C2VcvIoaUXYBQ97eFDSrjrxCsRUWLBvIW4fuNvudNTXg3vLbmYBbs=
X-Gm-Gg: ASbGnctg9SF5As4n+6zXPd3K9+rkcxHrlVdkt41g6itZTMPXlqorXDb530NOWrIZPlX
 ivFMBSy/cHOs0Ld3o4GamHhAhpWVrWTrNJx186770peO/euuHz+rpZTL2GunHz+OHHhbnaoUmTW
 5lWy4RnSsvg9S4TSSo2mN3wRvAP02TAI4DtFRllb9+0r3bPgd7hB281oaF7wnV56gGbq/VvLpxf
 8saQziJn1J/pOpO6LHkFftYgNTdnhhsLLghdulHGt5DwpuWDpbN4iM2onT+8Cr4vdU=
X-Google-Smtp-Source: AGHT+IHJ9UaAUeRbjqIzEmygf/aYpfw/+kH7NUh2TAw2YvfqQVeiAf091KLLNfT4zV8k9NDWFYoO+Q==
X-Received: by 2002:a05:6a20:258a:b0:1d9:d5e:8297 with SMTP id
 adf61e73a8af0-1e5c70305a7mr3590102637.6.1734599040145; 
 Thu, 19 Dec 2024 01:04:00 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9ed3sm713142a12.80.2024.12.19.01.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:03:59 -0800 (PST)
Message-ID: <b62ada7c-4c0a-4b57-978c-77f9f1f363e0@daynix.com>
Date: Thu, 19 Dec 2024 18:03:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qtest/pci: Enforce balanced iomap/unmap
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-2-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241218074232.1784427-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/18 16:42, Nicholas Piggin wrote:
> Add assertions to ensure a BAR is not mapped twice, and only
> previously mapped BARs are unmapped. This can help catch some
> bugs.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/ahci.h       |  1 +
>   tests/qtest/libqos/pci.h        |  2 ++
>   tests/qtest/libqos/virtio-pci.h |  1 +
>   tests/qtest/ahci-test.c         |  2 ++
>   tests/qtest/libqos/ahci.c       |  6 ++++++
>   tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
>   tests/qtest/libqos/virtio-pci.c |  6 +++++-
>   7 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
> index a0487a1557d..5d7e26aee2a 100644
> --- a/tests/qtest/libqos/ahci.h
> +++ b/tests/qtest/libqos/ahci.h
> @@ -575,6 +575,7 @@ QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
>   void free_ahci_device(QPCIDevice *dev);
>   void ahci_pci_enable(AHCIQState *ahci);
>   void start_ahci_device(AHCIQState *ahci);
> +void stop_ahci_device(AHCIQState *ahci);
>   void ahci_hba_enable(AHCIQState *ahci);
>   
>   /* Port Management */
> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index 83896145235..9dc82ea723a 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h
> @@ -65,6 +65,8 @@ struct QPCIDevice
>   {
>       QPCIBus *bus;
>       int devfn;
> +    bool bars_mapped[6];
> +    QPCIBar bars[6];
>       bool msix_enabled;
>       QPCIBar msix_table_bar, msix_pba_bar;
>       uint64_t msix_table_off, msix_pba_off;
> diff --git a/tests/qtest/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
> index f5115cacba2..efdf904b254 100644
> --- a/tests/qtest/libqos/virtio-pci.h
> +++ b/tests/qtest/libqos/virtio-pci.h
> @@ -26,6 +26,7 @@ typedef struct QVirtioPCIDevice {
>       uint64_t config_msix_addr;
>       uint32_t config_msix_data;
>   
> +    bool enabled;
>       int bar_idx;
>   
>       /* VIRTIO 1.0 */
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index 5a1923f721b..b3dae7a8ce4 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1483,6 +1483,8 @@ static void test_reset_pending_callback(void)
>       /* Wait for throttled write to finish. */
>       sleep(1);
>   
> +    stop_ahci_device(ahci);
> +
>       /* Start again. */
>       ahci_clean_mem(ahci);
>       ahci_pci_enable(ahci);
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index 34a75b7f43b..cfc435b6663 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -217,6 +217,12 @@ void start_ahci_device(AHCIQState *ahci)
>       qpci_device_enable(ahci->dev);
>   }
>   
> +void stop_ahci_device(AHCIQState *ahci)
> +{
> +    /* Map AHCI's ABAR (BAR5) */

I think you meant "unmap AHCI's ABAR (BAR5)".

> +    qpci_iounmap(ahci->dev, ahci->hba_bar);
> +}
> +
>   /**
>    * Test and initialize the AHCI's HBA memory areas.
>    * Initialize and start any ports with devices attached.
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index b23d72346b6..a42ca08261d 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -93,12 +93,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
>   {
>       uint16_t vendor_id, device_id;
> +    int i;
>   
>       qpci_device_set(dev, bus, addr->devfn);
>       vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>       device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>       g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
>       g_assert(!addr->device_id || device_id == addr->device_id);
> +
> +    for (i = 0; i < 6; i++) {
> +        g_assert(!dev->bars_mapped[i]);
> +    }
>   }
>   
>   static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
> @@ -531,6 +536,8 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>       uint64_t loc;
>   
>       g_assert(barno >= 0 && barno <= 5);
> +    g_assert(!dev->bars_mapped[barno]);
> +
>       bar_reg = bar_reg_map[barno];
>   
>       qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
> @@ -574,12 +581,35 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>       }
>   
>       bar.addr = loc;
> +
> +    dev->bars_mapped[barno] = true;
> +    dev->bars[barno] = bar;
> +
>       return bar;
>   }
>   
>   void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
>   {
> -    /* FIXME */
> +    static const int bar_reg_map[] = {
> +        PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
> +        PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
> +    };
> +    int bar_reg;
> +    int i;
> +
> +    for (i = 0; i < 6; i++) {
> +        if (!dev->bars_mapped[i]) {
> +            continue;
> +        }
> +        if (dev->bars[i].addr == bar.addr) {
> +            dev->bars_mapped[i] = false;
> +            bar_reg = bar_reg_map[i];
> +            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
> +            /* FIXME: the address space is leaked */
> +            return;
> +        }
> +    }
> +    g_assert_not_reached();
>   }
>   
>   QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
> diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
> index 485b8f6b7e0..2b59fb181c9 100644
> --- a/tests/qtest/libqos/virtio-pci.c
> +++ b/tests/qtest/libqos/virtio-pci.c
> @@ -304,11 +304,15 @@ void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
>   {
>       qpci_device_enable(d->pdev);
>       d->bar = qpci_iomap(d->pdev, d->bar_idx, NULL);
> +    d->enabled = true;
>   }
>   
>   void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
>   {
> -    qpci_iounmap(d->pdev, d->bar);
> +    if (d->enabled) {
> +        qpci_iounmap(d->pdev, d->bar);
> +        d->enabled = false;
> +    }
>   }
>   
>   void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,


