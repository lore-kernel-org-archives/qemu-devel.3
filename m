Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336D9C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkbG-0006DD-EA; Sun, 01 Jun 2025 11:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkau-0005xH-Rf
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkas-0004jx-O4
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bxW5Pl0frDqlsjh1ynzQs2scdOn1Ov3jHe+OemikXz4=;
 b=RMrTmInDAl2Ukg8F+AiAW2Y6xLmrjh70oS0TLGhquVMb/iD5MLQMsZwPT5jWNjIfDchAA6
 TdDDtFxi9yUXwXTFZO4hiM4c4yJeYRJ9hdaM0q0meS9tXZx2Z0L/JBniRcMlXBkoqGqFlF
 eQwcOibR6ZnYTKOBFbvov7306QPTHWQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-YsPC8fUDPxK24IY7tLz6vQ-1; Sun, 01 Jun 2025 11:27:24 -0400
X-MC-Unique: YsPC8fUDPxK24IY7tLz6vQ-1
X-Mimecast-MFC-AGG-ID: YsPC8fUDPxK24IY7tLz6vQ_1748791643
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so837493f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791643; x=1749396443;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxW5Pl0frDqlsjh1ynzQs2scdOn1Ov3jHe+OemikXz4=;
 b=cNV8Jzei9AOC++TesTjiAcVagWlwzGwAASrM3qc8Y8t+m0KEq/t88vH/qeeRNUVvja
 Ja4rXVVfB9OwytH7v2i5nykQBAP55BQdD+Rxa5FeU1Ie5If+wNJIDaXQRg75KfApFRWi
 4/pyU1DqhzpmZdJQkps5ARxFp+yjZwCGZ82sxbuXsqGAoyQw8v+BKA6Mk0I/f7Lbwcqj
 uMANlHDrIs7SY8rtHYoTa4nwO9oRl98FbWng5OmTkDMYB0od0/Na/fMkGQshJavV74lX
 OZ71zd47zJm1ebzM6Ou6MwVgr48HY7Sc8sGUpA95a0yxff7s6oJDq9+1scv2y5SAUyod
 c1hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeRlukJLeaygT14G65EYiibOmoKHhNVcBqsyLWYPtPk+5FGjbTiz9s4BhQ84QKzHiTEm/VCk1uZCBB@nongnu.org
X-Gm-Message-State: AOJu0Yyc3No3HsUfA1X0/qOskjBYzkhhHuBn9UtH3Bd4uw/BE1ZxfC4s
 qd6b1Xa362Z21a1AE+sh3zoD7o1CVb0X+lYVxfSVdVZTht8InK8SAN8BtU0Cg12E5Bzo7LTh6B/
 krBlLVsfbCMqFb8OvIk7sIGsnQkkCc45EUWRbmCHJZ3EGslZ10ltahAeM
X-Gm-Gg: ASbGncuopWtAcd0U9BhGivX/WRD/dnTaHLNsKK70nj9T5VGkWMuQqfAqwoF9YZlCGCn
 nUaQP0gcYyVvKa+iOrUVLFUqke8fDevyh+HQGlPImlW/sPOD21SUt9JFgiz/q/kUs94r8uunOdp
 zLRJdZoelR4dyxaE4Ugo05EEDLM2U9a/Ls0FER63I+llaEsr4PuHuw2x6Wp95McjiZke0lNf3Ey
 lr2nTbQxP7/mI9H0YE0okAjSkB/M9Hv8B84HMAv1MfOSqLwdfRAoOvukUxZ0gNCv8qjEuHYBxPb
 joH39ukvHWQOoCekhCOjC+7gK3SusBnXW6aFHCnmm1t8m3iCpg==
X-Received: by 2002:a05:6000:2c13:b0:3a4:d994:be7d with SMTP id
 ffacd0b85a97d-3a4fe17ba55mr3752272f8f.23.1748791643037; 
 Sun, 01 Jun 2025 08:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVd+vxYHyXbPFVv+nCzzIfiZbJROZrmRj8+jRWF0TeAAfhKRl838CAQsZ4qAQ9TX4QxRyZJw==
X-Received: by 2002:a05:6000:2c13:b0:3a4:d994:be7d with SMTP id
 ffacd0b85a97d-3a4fe17ba55mr3752256f8f.23.1748791642601; 
 Sun, 01 Jun 2025 08:27:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c79dsm11582618f8f.25.2025.06.01.08.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 08:27:22 -0700 (PDT)
Message-ID: <369d06c2-3207-470c-b1a4-72c0f09b793b@redhat.com>
Date: Sun, 1 Jun 2025 17:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 23/43] vfio/pci: export MSI functions
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-24-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-24-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/29/25 21:24, Steve Sistare wrote:
> Export various MSI functions, renamed with a vfio_pci prefix, for use by
> CPR in subsequent patches.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.h |  8 ++++++++
>   hw/vfio/pci.c | 29 +++++++++++++++++------------
>   2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb9..6e4840d 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -210,6 +210,14 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
>       return class == PCI_CLASS_DISPLAY_VGA;
>   }
>   
> +/* MSI/MSI-X/INTx */
> +void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
> +void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                               int vector_n, bool msix);
> +void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
> +void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
> +bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
> +
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6aa37fe..13d7c84 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -351,6 +351,11 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>       trace_vfio_intx_disable(vdev->vbasedev.name);
>   }
>   
> +bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    return vfio_intx_enable(vdev, errp);
> +}
> +
>   /*
>    * MSI/X
>    */
> @@ -475,8 +480,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>       return ret;
>   }
>   
> -static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> -                                  int vector_n, bool msix)
> +void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                               int vector_n, bool msix)
>   {
>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>           return;
> @@ -530,7 +535,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> -static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
> +void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>       PCIDevice *pdev = &vdev->pdev;
> @@ -580,10 +585,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       } else {
>           if (msg) {
>               if (vdev->defer_kvm_irq_routing) {
> -                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
> +                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
>               } else {
>                   vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
> -                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
> +                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
>                   vfio_connect_kvm_msi_virq(vector, nr);
>               }
> @@ -676,14 +681,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       }
>   }
>   
> -static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> +void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
>       vdev->defer_kvm_irq_routing = true;
>       vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>   }
>   
> -static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> +void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       int i;
>   
> @@ -713,14 +718,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>        * routes once rather than per vector provides a substantial
>        * performance improvement.
>        */
> -    vfio_prepare_kvm_msi_virq_batch(vdev);
> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
>   
>       if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
>                                     vfio_msix_vector_release, NULL)) {
>           error_report("vfio: msix_set_vector_notifiers failed");
>       }
>   
> -    vfio_commit_kvm_msi_virq_batch(vdev);
> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
>   
>       if (vdev->nr_vectors) {
>           ret = vfio_enable_vectors(vdev, true);
> @@ -764,7 +769,7 @@ retry:
>        * Deferring to commit the KVM routes once rather than per vector
>        * provides a substantial performance improvement.
>        */
> -    vfio_prepare_kvm_msi_virq_batch(vdev);
> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
>   
>       vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
>   
> @@ -788,10 +793,10 @@ retry:
>            * Attempt to enable route through KVM irqchip,
>            * default to userspace handling if unavailable.
>            */
> -        vfio_add_kvm_msi_virq(vdev, vector, i, false);
> +        vfio_pci_add_kvm_msi_virq(vdev, vector, i, false);
>       }
>   
> -    vfio_commit_kvm_msi_virq_batch(vdev);
> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
>   
>       /* Set interrupt type prior to possible interrupts */
>       vdev->interrupt = VFIO_INT_MSI;


