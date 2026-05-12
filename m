Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA64CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhxR-0004HX-2H; Tue, 12 May 2026 03:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMhxM-0004HA-Ky
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMhxJ-0002R4-0I
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778572503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vLKEKJEwYVbNz983RdsXFGBzWtTwzRaX1gUQhPe2HQQ=;
 b=MHz4C5yoVmNVJVQX7x0tgpEwsYNCITD+3myGzXC28siygpIx7OTb9xI78lHLTUoVdHRv3a
 xubQJ5/Hy5Io5s3bJxZDH4VALHcAAkRLBr/uL+snZwuE3QyejLPQXdRxvw8hJVuZ9zeeHg
 QQmZTpAXur+szy52vTgLW7wu5mc7V/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-NeiFEgIWPuyv7spMtpG4sw-1; Tue, 12 May 2026 03:55:02 -0400
X-MC-Unique: NeiFEgIWPuyv7spMtpG4sw-1
X-Mimecast-MFC-AGG-ID: NeiFEgIWPuyv7spMtpG4sw_1778572501
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44bf1ac8893so4633098f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778572501; x=1779177301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vLKEKJEwYVbNz983RdsXFGBzWtTwzRaX1gUQhPe2HQQ=;
 b=f9tvyv7L15LO3b8N+lUKsjnY3KFhhMCGNnNEZw2F65njFwgseETpWKSewWYjmvY8kF
 pVoDMOFgGl4lxsSTwTmTOAYEe5d+jfZvydoeBsuIfJPxOX4O3PUM3u8TGENrNJIBB0jX
 7cRTomYsVmDv9YgnYoAyy/qkkYH/rKZVp+UI+MxVMKdj/2m0kAHb/MHGPY4y2CqBc8f4
 kRUlPtKoTfAlQFMDELFAIEEdBXxHqQ5XvLv7WEnis1kx+H/1BqN4PW+u8pXGBOGCaWfl
 xqNNAU2iwNyU8lCkxD6PnT+xazrSNjB73aIuL/jtWq36bJbFgYsptLWN22pCoTnA2f8L
 p5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778572501; x=1779177301;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLKEKJEwYVbNz983RdsXFGBzWtTwzRaX1gUQhPe2HQQ=;
 b=DuNRIpKJ3+5ojT54lg1EL7S6McwrPok8RP5/O2wtu5l7Dbp2wYL0KzMEmhmBUQ/Vyg
 x2QVY5f7THzh/unJuK/TKRyI5C4XXW3Y+mA5DAmHSYW4CLve2IvkDEyuOkfhrieaEw3K
 hMKGH9mQaWia1drwIOaFRpru7FaYJFcs0ffKoMPOcCykwbraNAtpr1Z2JKI6xxKx7PAH
 B1Xqt2FWTFBW3f8F5Ck+YNi5P3IkVOcHsqcVWsKtlqDJgz4PsT0wCA29fiQqfvlFXfXh
 qiF98I615XtH9oQ+og+eLyMaLr2sPytIKnxAy8Cu2Ar2zPyEgspZzFnLrsjHCd5N/KKH
 BzrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TaRYWFkUuvcRIGakWd3/psfElYRHFNshVtDYSHRIjliQerenGquMyuABcJXW5eqf8XqCSb4CqNxBi@nongnu.org
X-Gm-Message-State: AOJu0Yz/ExmWce6hRBzTJyNdK1AnWZxIgNwU09hYMfaLBVQjujR9d1ls
 ubfiLVHt1u9dL24lKFz70NdpwoSE/hzIxJff9R6w6P6jJF/euOKSU28UeNPOBE9erNmVd+jPeO6
 73UTGsSAYE/aGg1h/QQQvUSxp0u+4EfHbgIL3Yxs/KKkaRtr8B1KRqU1d
X-Gm-Gg: Acq92OG3BjQywroXoQdz4FcBtIQQ5Ch+Sat0JKdlxxy7YSX56YzcbP2oVNUaCnZ1ObT
 /iiI49Y33Vv7SM64KWq8+De5OudpRgCifPqzacCAhdA2iFVf3y7XOCY/YVRw6MJFFXhk2tE5W7k
 9k+Y9uAfK/+XGNzT5wbOIz9TatT2AlLebQDxsZj+9TwFjIvhnn/0cHq/CwySPr0buueYqhYmRBP
 Xka6eorJK/nxPywIy/SeOrQ9JHNXGY+A6x34TXglA6FM4uxFSlKGHo6I/ewxZCaMK2MaAxG+MLK
 Aj45E7LDN4FEidL5criiHH8Jt4JZ59+jIxOh8TYMwFpbuLkStGs5rVxMInoOJ1nc1nNGD8p11Ku
 ksosYaK14aw7L+K6qMRCn6hTJGj7zz6pShS3zYWnwhLOIwgZh4JcR4gwnqeXd
X-Received: by 2002:a05:6000:2910:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-4515d3dc459mr44296898f8f.30.1778572500938; 
 Tue, 12 May 2026 00:55:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2910:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-4515d3dc459mr44296858f8f.30.1778572500445; 
 Tue, 12 May 2026 00:55:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm32501210f8f.31.2026.05.12.00.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 00:55:00 -0700 (PDT)
Message-ID: <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
Date: Tue, 12 May 2026 09:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/ppc: Rename spapr_pci_vfio.c to
 spapr_pci_vfio_eeh.c
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
 <20260512071112.9675-6-nnmlinux@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260512071112.9675-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+ Pierrick, Philippe

On 5/12/26 09:11, Narayana Murty N wrote:
> The file spapr_pci_vfio.c contains exclusively EEH (Enhanced Error
> Handling) related functions for VFIO devices on sPAPR platforms.
> To better reflect its specific purpose and improve code organization,
> this commit:
> 
> 1. Renames spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
> 2. Moves spapr_phb_vfio_eeh_reenable() from spapr_pci_vfio_eeh.c to
>     spapr_pci.c, as it's a general PHB operation not specific to
>     VFIO EEH error injection/recovery
> 
> After this change, spapr_pci_vfio_eeh.c contains only the core VFIO
> EEH error handling functions, making the file's purpose more focused
> and clear.
> 
> This is a refactoring change with no functional impact.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   hw/ppc/Kconfig                                    |  2 +-
>   hw/ppc/meson.build                                |  2 +-
>   hw/ppc/spapr_pci.c                                | 14 ++++++++++++++
>   hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} | 12 +-----------


There is a CONFIG_VFIO_PCI in this file that could be replaced
with stub definitions.

Thanks,

C.


>   include/hw/pci-host/spapr.h                       |  1 +
>   5 files changed, 18 insertions(+), 13 deletions(-)
>   rename hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} (96%)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 347dcce690..886ce71ef8 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -6,7 +6,7 @@ config PSERIES
>       imply PCI_DEVICES
>       imply TEST_DEVICES
>       imply VIRTIO_VGA
> -    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
> +    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio_eeh.c
>       select NVDIMM
>       select DIMM
>       select PCI
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 37aa535db2..7cf0226b5e 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -35,7 +35,7 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
>   ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>   if host_os == 'linux'
>     ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
> -    'spapr_pci_vfio.c',
> +    'spapr_pci_vfio_eeh.c',
>     ))
>   endif
>   
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b00f71d92a..fcb7b850c0 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2215,6 +2215,20 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
>       tcet->def_win = true;
>   }
>   
> +void spapr_phb_vfio_reset(DeviceState *qdev)
> +{
> +    /*
> +     * The PE might be in frozen state. To reenable the EEH
> +     * functionality on it will clean the frozen state, which
> +     * ensures that the contained PCI devices will work properly
> +     * after reboot.
> +     */
> +    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
> +}
> +
> +
> +
> +
>   static void spapr_phb_reset(DeviceState *qdev)
>   {
>       SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(qdev);
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio_eeh.c
> similarity index 96%
> rename from hw/ppc/spapr_pci_vfio.c
> rename to hw/ppc/spapr_pci_vfio_eeh.c
> index ed0b22a84a..c00cf1d24b 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio_eeh.c
> @@ -131,21 +131,11 @@ bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>       return vfio_eeh_as_ok(&sphb->iommu_as);
>   }
>   
> -static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
> +void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
>   {
>       vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
>   }
>   
> -void spapr_phb_vfio_reset(DeviceState *qdev)
> -{
> -    /*
> -     * The PE might be in frozen state. To reenable the EEH
> -     * functionality on it will clean the frozen state, which
> -     * ensures that the contained PCI devices will work properly
> -     * after reboot.
> -     */
> -    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
> -}
>   
>   static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
>                                         void *opaque)
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 417d1f6c31..5ca122a5f1 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -125,6 +125,7 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
>   int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
>   int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
>   void spapr_phb_vfio_reset(DeviceState *qdev);
> +void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb);
>   int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
>                               uint64_t addr, uint64_t mask, uint32_t type);
>   #else


