Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B07C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqU8-0003x1-V3; Fri, 16 May 2025 04:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqU7-0003to-AD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqU4-0005VB-PD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vqbgzsRFs/hVjVY5vfx6qnmRA+yGkjStzq9t9PBDKPM=;
 b=ITXQPkoTdyOLYs4aniWSvrdpv4RGhA/NxfngLejpmovicfncUbjX+pTNwJHNTTd5izqeK3
 KnU/zMiItwZERd8QC3FUCId2d+0MjvUqYVUQwJ8+qcq59t2lmwKILsMDQ+j+6kk9T036RV
 D1Dlvdfxcb+M8gj0cchKVuE2WVlIHKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-8kqcVdywNN6X6aGanHjnmQ-1; Fri, 16 May 2025 04:31:49 -0400
X-MC-Unique: 8kqcVdywNN6X6aGanHjnmQ-1
X-Mimecast-MFC-AGG-ID: 8kqcVdywNN6X6aGanHjnmQ_1747384308
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b1798d69so987741f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384307; x=1747989107;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqbgzsRFs/hVjVY5vfx6qnmRA+yGkjStzq9t9PBDKPM=;
 b=lZ+yKQkeU/DEvb2nzlgeEMlXTShps5OlYFG2JIFGKTGo0OFOx/s9MoFOf/UhoiBbTv
 dwAiJatyLQFcuP66srp9bcGKNZwnuZgO2pbTVaGNcm7b7C2Nv/QDsesRr5TESd9p1Oiu
 IMJs1C9eg41xvlLqK7NpTIxnhIPT2fbw/DOHTj9pFR2N7mNMgSCNHu/JBNBDZrlltQUL
 8Ua0wXxR3hp61HXGcbAlgR4FSnrblpJna3ppY4hLqX72SqAhtu+pQy+cmfrNqcWE0EDu
 V1srEnMhoLmt3tK9eDAYbraKJpQ5qK9rwk9MnKBLy/hT3TPUXo3e5UO3eiX9Psll9Mms
 hg9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsI/6NDwC2iC49xkgcFB0QYTBhoACqtZkDEQ/ZCpHUzAKgqX9OWvlyNiDFKq1DP7erC71XvkZKO9AT@nongnu.org
X-Gm-Message-State: AOJu0YyZmqjqROieasR/7vFsspsLPcrXA+scEMtbpB8R3f2H/qkgVL6r
 NMdYjyUCKlXqFAGo9tuSdudHCurjAwTqMs8CeI77a5Qox/bJpbQlL5tdhgdbN5+RRBiwQybujCK
 PimHfOZq+XnQdV1gv85QbVUjTji1D2hmOI6htBX+x/fXbW70bSrSrlBuD0IVVRnCDIbk=
X-Gm-Gg: ASbGncvjzvFFOfjlIpekZCqtIX5+B9axHycYzQs62YBqQ/G020VWD65DUTzxONBDD6h
 xolE26bi51C19vPhxnlNaBE8Ng+DhKjgHU9RDOueWt6ccKKyAK0eJPO++RuZpJZB0woiDoduL6o
 LS7x3JFbMyyiSr6fqev+WmTypPB1Yay4wkLfVvdzkA5Vt4PBf9brq3S5ETf6YpNxNZ5Be7hG2/I
 Kcjx9TOxyNdvR3RTJ8pnS7OLU8oXQ0lDm/jHGvSd0pSdptFK6irloiHwxtvIznwamtv/neQoG57
 t5fxSWd0IhbNo6BM7Z0mVRsN249P2WaCWK0rl7Sjx01pZPnT9w==
X-Received: by 2002:adf:f444:0:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-3a35c84458emr2140327f8f.31.1747384307438; 
 Fri, 16 May 2025 01:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFetSPltEpEH9j6qnPda1GufxWx/VlcxyIoZAgrSYUBJ7xn3hTpxGqmsTTE53UxFpIQm0Ckrw==
X-Received: by 2002:adf:f444:0:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-3a35c84458emr2140298f8f.31.1747384307027; 
 Fri, 16 May 2025 01:31:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm1732388f8f.44.2025.05.16.01.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:31:46 -0700 (PDT)
Message-ID: <c5696d3e-cd21-4d90-9e30-676434c1020c@redhat.com>
Date: Fri, 16 May 2025 10:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 21/42] vfio/pci: export MSI functions
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-22-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-22-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/12/25 17:32, Steve Sistare wrote:
> Export various MSI functions, for use by CPR in subsequent patches.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Please rename this routines with a 'vfio_pci' prefix.


Thanks,

C.



> ---
>   hw/vfio/pci.c | 21 ++++++++++-----------
>   hw/vfio/pci.h | 12 ++++++++++++
>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d2b08a3..1bca415 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -279,7 +279,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>       vfio_intx_update(vdev, &vdev->intx.route);
>   }
>   
> -static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   {
>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>       Error *err = NULL;
> @@ -353,7 +353,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>   /*
>    * MSI/X
>    */
> -static void vfio_msi_interrupt(void *opaque)
> +void vfio_msi_interrupt(void *opaque)
>   {
>       VFIOMSIVector *vector = opaque;
>       VFIOPCIDevice *vdev = vector->vdev;
> @@ -474,8 +474,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>       return ret;
>   }
>   
> -static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> -                                  int vector_n, bool msix)
> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                           int vector_n, bool msix)
>   {
>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>           return;
> @@ -529,7 +529,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> -static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>       PCIDevice *pdev = &vdev->pdev;
> @@ -641,13 +641,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       return 0;
>   }
>   
> -static int vfio_msix_vector_use(PCIDevice *pdev,
> -                                unsigned int nr, MSIMessage msg)
> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg)
>   {
>       return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
>   }
>   
> -static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> @@ -674,14 +673,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       }
>   }
>   
> -static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
>       vdev->defer_kvm_irq_routing = true;
>       vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>   }
>   
> -static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       int i;
>   
> @@ -2632,7 +2631,7 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>       return OBJECT(vdev);
>   }
>   
> -static bool vfio_msix_present(void *opaque, int version_id)
> +bool vfio_msix_present(void *opaque, int version_id)
>   {
>       PCIDevice *pdev = opaque;
>   
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb9..c892054 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -210,6 +210,18 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>       return class == PCI_CLASS_DISPLAY_VGA;
>   }
>   
> +/* MSI/MSI-X/INTx */
> +void vfio_vector_init(VFIOPCIDevice *vdev, int nr);
> +void vfio_msi_interrupt(void *opaque);
> +void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                           int vector_n, bool msix);
> +int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg);
> +void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr);
> +bool vfio_msix_present(void *opaque, int version_id);
> +void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
> +void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
> +bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);
> +
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len);


