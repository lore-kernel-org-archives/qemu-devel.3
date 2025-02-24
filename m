Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06DDC021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdO6-0003Gw-6z; Mon, 24 Feb 2025 13:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdLk-0000t9-Uy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdLZ-00063m-UC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740422304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fr8GdGe++pcsO6ZFAgzAm1P/51UJIBp1RCbGpOM1ij8=;
 b=HchNzRz86cbpTQkEoQvMh/Y9N44IWA/5EFaC+8v6BmEAptcXjkxBbLTo4of1+PnSKZmnS2
 T8E4KCXXWLjo706UOkc5O+ToKMvujUuqY2h5cQfiv+m42grIfREfG9texZPM8Ygqe7sW9j
 ACwYihvRGmfqqO3lY1j5uimfDmvCDj8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-MR1da-_NPXGQdJk6dyqbnQ-1; Mon, 24 Feb 2025 13:38:22 -0500
X-MC-Unique: MR1da-_NPXGQdJk6dyqbnQ-1
X-Mimecast-MFC-AGG-ID: MR1da-_NPXGQdJk6dyqbnQ_1740422301
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso39717655e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422301; x=1741027101;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fr8GdGe++pcsO6ZFAgzAm1P/51UJIBp1RCbGpOM1ij8=;
 b=mTd4LVMUK/TpRGHwogC1qB5/e8mqZOmvUsiMQBPHI3xeCJDZ+dZz5c6F8yHDrHaHK3
 imvNaMutOqMqZpOEsIHTKu9lLIMm7eJkgo6vQt1XF1jKgiIHLZ+m0IiY3BRcMrM1uTkC
 jVDqL///1AWddrmM7n6zud9FQNI1zszkqQYEWmPNDm1bCNXRImG95qkKuj8Zl6vFKgpk
 UwJNlNs9AYzL5137U/YoLVGJkJRRPfXxMU26SS6uCZU1YL3M7VKACQJwnhEkesZU8oKG
 AXI6dnMV7Eg1i32aKZrmdHtsTcDla8aU99PlcJ1yIqft50/QTsYj2eqKb225cU5jMNxQ
 sJFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4E8LFzG55DlXopJjDeSFAabdlR7hK4c8Afh0FxrA5EwaabzW8t+wL6pwfUAnp0j1AuK2uvy8AZQ2t@nongnu.org
X-Gm-Message-State: AOJu0Yzd6WYZ2OgadIar8f2pHQJiwRLhzHGycA3tBAMJoArHIOcN/T3S
 wPD2lpT3fhlYRV+gdOI2BOW9hRH5DYCzqWEaZJDeJYvO4J9KqCdCdSqKC9QSlBh2wSoDbCjPXwE
 KKlF9YDzgwJ3rHBeBSd8QJg1OUuGfRhP8iFCXU+tfCNSmlMVn7/OX
X-Gm-Gg: ASbGncul7PkHXDiulIahFU8DBxgbCYBJBJNsmsJ50ZVDFQcuTXIw7+l8kV0S+hWgmJq
 rmPLOVu9EDp0pJYiM5fkczMAnVEn89hSvLvq/64aplRODHft2MO2kDbUWn5BVZnM8cyFTdPeD0m
 gaBkFn9jiyCzb7yspY8MhwyIP/1/LFugATlk5sHy9OS5AfYAHeTcJjYaeAIAas4NXD8RWCmNDIa
 1QRkfagGnsYgFKQvjrck7CjKT6Il9NmmVDYjprYCaM50lrBl+ifDcIE7XILpnSK+Laq/dnhbfJE
 ryca5gJ8sRaj9QigCtQvNois/p5QEqVsmpwjdjvNmclWJgfTAYbV+RKAcznxU54=
X-Received: by 2002:a05:600c:5117:b0:439:8829:aa69 with SMTP id
 5b1f17b1804b1-439aeb3556cmr122653985e9.17.1740422301303; 
 Mon, 24 Feb 2025 10:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKozGiEg7ZwWNFHjIGQlhyWEIWDv7Z46gBnNgLbW+ByO7GPv2nZPWj/VdIRsJbLMA1ehhllA==
X-Received: by 2002:a05:600c:5117:b0:439:8829:aa69 with SMTP id
 5b1f17b1804b1-439aeb3556cmr122653835e9.17.1740422300954; 
 Mon, 24 Feb 2025 10:38:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b434fsm32848903f8f.16.2025.02.24.10.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 10:38:20 -0800 (PST)
Message-ID: <8a6606e0-0ac5-43ed-879d-d94ddc56733c@redhat.com>
Date: Mon, 24 Feb 2025 19:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] vfio/pci: Delete local pm_cap
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-4-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220224918.2520417-4-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/20/25 11:48 PM, Alex Williamson wrote:
> This is now redundant to PCIDevice.pm_cap.
>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/pci.c | 9 ++++-----
>  hw/vfio/pci.h | 1 -
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6903f831e45f..ba4ef65b16fa 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2215,7 +2215,6 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>          break;
>      case PCI_CAP_ID_PM:
>          vfio_check_pm_reset(vdev, pos);
> -        vdev->pm_cap = pos;
>          ret = pci_pm_init(pdev, pos, errp) >= 0;
>          break;
>      case PCI_CAP_ID_AF:
> @@ -2407,17 +2406,17 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>      vfio_disable_interrupts(vdev);
>  
>      /* Make sure the device is in D0 */
> -    if (vdev->pm_cap) {
> +    if (pdev->pm_cap) {
>          uint16_t pmcsr;
>          uint8_t state;
>  
> -        pmcsr = vfio_pci_read_config(pdev, vdev->pm_cap + PCI_PM_CTRL, 2);
> +        pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
>          state = pmcsr & PCI_PM_CTRL_STATE_MASK;
>          if (state) {
>              pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> -            vfio_pci_write_config(pdev, vdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
> +            vfio_pci_write_config(pdev, pdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
>              /* vfio handles the necessary delay here */
> -            pmcsr = vfio_pci_read_config(pdev, vdev->pm_cap + PCI_PM_CTRL, 2);
> +            pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
>              state = pmcsr & PCI_PM_CTRL_STATE_MASK;
>              if (state) {
>                  error_report("vfio: Unable to power on device, stuck in D%d",
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 43c166680abb..d638c781f6f1 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -160,7 +160,6 @@ struct VFIOPCIDevice {
>      int32_t bootindex;
>      uint32_t igd_gms;
>      OffAutoPCIBAR msix_relo;
> -    uint8_t pm_cap;
>      uint8_t nv_gpudirect_clique;
>      bool pci_aer;
>      bool req_enabled;


