Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D8C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2XVN-0005yw-AZ; Wed, 09 Apr 2025 11:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2XVK-0005y6-R1; Wed, 09 Apr 2025 11:38:19 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u2XVI-00069p-K4; Wed, 09 Apr 2025 11:38:18 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-736ee709c11so5853173b3a.1; 
 Wed, 09 Apr 2025 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744213094; x=1744817894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XwdPEA55gRWmTDe/Dpe4/FbyGo2tlkYGSVM3K9W0mc=;
 b=MzJCPWGBLX1e6R70BnFLJhgfOuNObsq0ONuXt2VuU//nbnGW9BrN2TWp6kWRhZ8bCc
 Cvs0qcVIK+kSYobZPVNAaOeErRygAp/BEMJxhqR1W2CIsA28UbV5/Xudwg+hA4sH0+Na
 KgytJG+PuMqPEzEODxIaJhhfDZUxSIfgf/lcYb71jOhkf7YOtxYJXeQCdW25eKEwn0ls
 eQcb9MuKxP2YQ732XQgjxZwLGzFVYHbEbV5hQMgJprByn/Vp4lEosWq1T3Wm1SFeSbEi
 XSzpmKH4+/cr60nnVLMr46axpIQuKd5203jHNdtmRvwOnSCziT76AXGz5dYW7nNzotch
 Y5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744213094; x=1744817894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XwdPEA55gRWmTDe/Dpe4/FbyGo2tlkYGSVM3K9W0mc=;
 b=TQ2n8YFLtEmGIqITXxnnFPbuMdI6jFELKmQB7/tzSduVQ+LNTRiwev1FVmRMqIa5Xv
 7E5UqEXsRC+urcgp6eFdmIULJXPbsrnXTdEO1qjEZht4wN7Hka3rgkq7vGcYP8Bmbv30
 cacGEgnJayyQUb1x7RWz/S1QsWphbsMurDUs2u3+IUGbBJ/Zr+q2UByn8cyj85+oJ1b8
 lH2JJHQJU4gKkKFmpZd1tj14bGVLpDU4XQTQuNyHJka6weykdNbZTbkT6ACwUjKqcI3R
 eicHAfBz5kQHehvMo/yzDrhQpKLeN3ZQT30sjnvrc/ghXMwEsLaZjsxtrLS0AU4xomc1
 G4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUds2QNripgnrz6keicY7L1zlSLNKZ4bl5a0UbtGagUF6a9qU2pcHVaSMbBTc7m1TpsnnbdrGLvbou8A==@nongnu.org,
 AJvYcCXS4de+M1SfFe1bb1icoKJuEi7hsCSltliSlDnInEzgNrOlFi+P3zYBiAWNTOGjjHlQGHVaptefvYWX@nongnu.org
X-Gm-Message-State: AOJu0Yyb59RT6yyQhN4I6MpqVS2sf+0byEn2MJrGwGB9LfRWXh/L2uYq
 3624UT54pMOehvEhaMjPkeTNXAVO/rsSkgSkbRutq4DhgJ3hGX4=
X-Gm-Gg: ASbGncvQkZ3sJK5+8vigRQr8/U8LwYocfDS3L5+J3+wX6f1vINgO8AuCP/8uq6Klw9J
 Jm2u6G++/JDXM+bPOWy4xehLy5Ooa1LN7aku0EgQSdq7U63589sv4B5mhHd9EP8er1uZfkNunWH
 q5n97sstLkuBc+UYJXjHgbRDeMWm/UEE5p8gEQaODd/jLOGTldT7y6Lr8Gy/fr33LBH3/6hbbhu
 g8Y2V87+R+GWJE7s8LvpH9ZSxdVg+dngRRd1t/HfL3815Gq5140yscbkBHq3YgbYQuQUUxKbpt2
 e+9KhwBEz5U6clEW+8866K+ASgE799+OMLEdyligS+DBYg==
X-Google-Smtp-Source: AGHT+IHIbsyiWlEoPEGKj6Yi31e8b57SVggfX1tuL4S1Ad2uW1UtoP0lcNwVt6o2HCzgCNGYMXYPAA==
X-Received: by 2002:a05:6a00:1a89:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-73bae4b562emr4922126b3a.10.1744213093960; 
 Wed, 09 Apr 2025 08:38:13 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e517c8sm1470760b3a.152.2025.04.09.08.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:38:13 -0700 (PDT)
Message-ID: <593da0e4-6e0b-4edf-a0ff-7ff066baf4b8@gmail.com>
Date: Wed, 9 Apr 2025 23:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] vfio: refactor out vfio_pci_config_setup()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-3-john.levon@nutanix.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250409134814.478903-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, John

On 4/9/25 21:48, John Levon wrote:
> Refactor the PCI config setup code out of vfio_realize() for
> readability.
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>  hw/vfio/pci.c | 176 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 94 insertions(+), 82 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 02f23efaba..81bf0dab28 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2963,6 +2963,99 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +
> +    /* vfio emulates a lot for us, but some bits need extra love */
> +    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
> +
> +    /* QEMU can choose to expose the ROM or not */
> +    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
> +    /* QEMU can also add or extend BARs */
> +    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
> +
> +    /*
> +     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
> +     * device ID is managed by the vendor and need only be a 16-bit value.
> +     * Allow any 16-bit value for subsystem so they can be hidden or changed.
> +     */
> +    if (vdev->vendor_id != PCI_ANY_ID) {
> +        if (vdev->vendor_id >= 0xffff) {
> +            error_setg(errp, "invalid PCI vendor ID provided");
> +            return false;
> +        }
> +        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
> +        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
> +    } else {
> +        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
> +    }
> +
> +    if (vdev->device_id != PCI_ANY_ID) {
> +        if (vdev->device_id > 0xffff) {
> +            error_setg(errp, "invalid PCI device ID provided");
> +            return false;
> +        }
> +        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
> +        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
> +    } else {
> +        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
> +    }
> +
> +    if (vdev->sub_vendor_id != PCI_ANY_ID) {
> +        if (vdev->sub_vendor_id > 0xffff) {
> +            error_setg(errp, "invalid PCI subsystem vendor ID provided");
> +            return false;
> +        }
> +        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
> +                               vdev->sub_vendor_id, ~0);
> +        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
> +                                              vdev->sub_vendor_id);
> +    }
> +
> +    if (vdev->sub_device_id != PCI_ANY_ID) {
> +        if (vdev->sub_device_id > 0xffff) {
> +            error_setg(errp, "invalid PCI subsystem device ID provided");
> +            return false;
> +        }
> +        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
> +        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
> +                                              vdev->sub_device_id);
> +    }
> +
> +    /* QEMU can change multi-function devices to single function, or reverse */
> +    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
> +                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
> +
> +    /* Restore or clear multifunction, this is always controlled by QEMU */
> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
> +    } else {
> +        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
> +    }
> +
> +    /*
> +     * Clear host resource mapping info.  If we choose not to register a
> +     * BAR, such as might be the case with the option ROM, we can get
> +     * confusing, unwritable, residual addresses from the host here.
> +     */
> +    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
> +    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
> +
> +    vfio_pci_size_rom(vdev);
> +
> +    vfio_bars_prepare(vdev);
> +
> +    if (!vfio_msix_early_setup(vdev, errp)) {
> +        return false;
> +    }
> +
> +    vfio_bars_register(vdev);

Probably we can also put `vfio_config_quirk_setup` here as it deals with
device-spcific config space.

I would personally prefer keeping `vfio_bars_register` in `vfio_realize`
so that it matches `vfio_bars_exit` at the end, just a minor nit.

Thanks,
Moeko

> +
> +    return true;
> +}
> +
>  static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>  {
>      PCIDevice *pdev = &vdev->pdev;
> @@ -3067,91 +3160,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> -    /* vfio emulates a lot for us, but some bits need extra love */
> -    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
> -
> -    /* QEMU can choose to expose the ROM or not */
> -    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
> -    /* QEMU can also add or extend BARs */
> -    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
> -
> -    /*
> -     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
> -     * device ID is managed by the vendor and need only be a 16-bit value.
> -     * Allow any 16-bit value for subsystem so they can be hidden or changed.
> -     */
> -    if (vdev->vendor_id != PCI_ANY_ID) {
> -        if (vdev->vendor_id >= 0xffff) {
> -            error_setg(errp, "invalid PCI vendor ID provided");
> -            goto error;
> -        }
> -        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
> -        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
> -    } else {
> -        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
> -    }
> -
> -    if (vdev->device_id != PCI_ANY_ID) {
> -        if (vdev->device_id > 0xffff) {
> -            error_setg(errp, "invalid PCI device ID provided");
> -            goto error;
> -        }
> -        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
> -        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
> -    } else {
> -        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
> -    }
> -
> -    if (vdev->sub_vendor_id != PCI_ANY_ID) {
> -        if (vdev->sub_vendor_id > 0xffff) {
> -            error_setg(errp, "invalid PCI subsystem vendor ID provided");
> -            goto error;
> -        }
> -        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
> -                               vdev->sub_vendor_id, ~0);
> -        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
> -                                              vdev->sub_vendor_id);
> -    }
> -
> -    if (vdev->sub_device_id != PCI_ANY_ID) {
> -        if (vdev->sub_device_id > 0xffff) {
> -            error_setg(errp, "invalid PCI subsystem device ID provided");
> -            goto error;
> -        }
> -        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
> -        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
> -                                              vdev->sub_device_id);
> -    }
> -
> -    /* QEMU can change multi-function devices to single function, or reverse */
> -    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
> -                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
> -
> -    /* Restore or clear multifunction, this is always controlled by QEMU */
> -    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> -        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
> -    } else {
> -        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
> -    }
> -
> -    /*
> -     * Clear host resource mapping info.  If we choose not to register a
> -     * BAR, such as might be the case with the option ROM, we can get
> -     * confusing, unwritable, residual addresses from the host here.
> -     */
> -    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
> -    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
> -
> -    vfio_pci_size_rom(vdev);
> -
> -    vfio_bars_prepare(vdev);
> -
> -    if (!vfio_msix_early_setup(vdev, errp)) {
> +    if (!vfio_pci_config_setup(vdev, errp)) {
>          goto error;
>      }
>  
> -    vfio_bars_register(vdev);
> -
>      if (!vbasedev->mdev &&
>          !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
>          error_prepend(errp, "Failed to set vIOMMU: ");

