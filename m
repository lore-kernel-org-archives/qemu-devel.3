Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558D1CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbCj-0001bj-8I; Mon, 08 Sep 2025 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvbCh-0001at-7N
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvbCV-0004Tg-SW
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757335343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bgaBYfnTnYSV6QhtfxttrMEUO3w8uPCjBbvnP8YPABg=;
 b=SIsQHkIGDOaTdt6vdQODtfrl9BCfSteW5FJeRoPdicMPyFlp91RlGxIrDoscLftToU2HRz
 mepkrAnmltOQzuzO5PYChjd9bNlrVBew7j2I6bu4FV5E2t7vTzInJYc5ioLPSSJKnsR6dX
 7yPMd7A1OvDmE0lf/q16X7zLekR6t4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-B3ad8W9UMAiu8J0Cq4t4Dw-1; Mon, 08 Sep 2025 08:42:22 -0400
X-MC-Unique: B3ad8W9UMAiu8J0Cq4t4Dw-1
X-Mimecast-MFC-AGG-ID: B3ad8W9UMAiu8J0Cq4t4Dw_1757335340
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45de87c778fso4018675e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 05:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757335340; x=1757940140;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgaBYfnTnYSV6QhtfxttrMEUO3w8uPCjBbvnP8YPABg=;
 b=dH2DysRYG4v3z5CjWSCeuO/PXVdWXJTzsnKWfD8du9PtthVugdng42TU4d2osiZAPa
 rAjcs23YYpW9bMVjK17DS7EbleuAIhVMmw4jP+sTEMWt7cfGVt/TfeybuY/8dHtDFnvy
 AZa0YvNFga9vol8RhcVtpNgLjyYHjxNqOOFBf2X3SFHlo8UahVVbcDiR1/PpV8jzt63Y
 JoNsdl2Sm/uAO4rws29E38pNVylYfeVfnmI9/NVcqdETgrmM/LXq58YkEbgzT69pkvvH
 RAyZXvz+xuLfYvyvxWqxuVC3gDUpqLiA5YAQX/ke5w7E3xYyUXSaQ1wGakDm0NmJ5kf1
 zBdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSg1aey9isqCfkXVAcpwCoCu8VeSHuOWF/Ds2PZax54opMi258auz1vcKI9NxdzvttOXbFbcIlo5Zz@nongnu.org
X-Gm-Message-State: AOJu0YwBHRqEGiDDVTDhkaauiZR/k6NRkd3O1D344KEp/5vpl/BXaWoB
 j4mrI0/eHK7ryJ7E1/NAaqzOdZbCzT8pP5kMWyqYHcAE/BIp7oKBLsA3lHG4K1IUkUEMREr/XN/
 rpxKgirIme5T7t7KkuWAVn3LaYMwFQVXc8ib7VxsZUc8x9IipXgd9Iyqk
X-Gm-Gg: ASbGncuXOLbWs8DVk1Q+Lf8gLHqZvWzVCipEXDVg5VVmPBLHBgnldm1EwCtDNxNXgi9
 TdcgapvDIDkQmXj8lq8iQZGyyoUrwQL+0Tun20qPrdQie7Wqmyt5aVTuqM5b/9t+WgPSxOE1HXr
 uj66evI3MMBdD0Zd7VP6PAlbuvZPYANGl+FUF4NyElZYOaIgvtjYbqXnw+rXQwbaFAZlDCdnMys
 hxFA4rjOYL/53lNYiG9fYYYr0TxJ1/MySafsF0qwrzf0SLJSRmfQGWh02SUOuPmRGtGKwK1ClX7
 GJojuQ/j9rIljCvOwwwotZpsfyVGs4HEkWH5IrCdZh1DIipWnHvjL9fmTMrQT0pcyIanJVJmQR6
 D1O8=
X-Received: by 2002:a05:600c:c177:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45ddde92f00mr69365495e9.11.1757335339322; 
 Mon, 08 Sep 2025 05:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSB6DAq0hJ/F4fODXmdzw1HOUYu7FvKjDWboobrzsiAIYVvXgnvSBlPa3vQx0XWYxG0e3XEg==
X-Received: by 2002:a05:600c:c177:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45ddde92f00mr69364985e9.11.1757335338626; 
 Mon, 08 Sep 2025 05:42:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e06dbde2d2sm17919056f8f.12.2025.09.08.05.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 05:42:18 -0700 (PDT)
Message-ID: <7f3cea08-5185-4c3b-905b-fed1692b1c3f@redhat.com>
Date: Mon, 8 Sep 2025 14:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] vfio/pci.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-17-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-17-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
> accessing pdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

( Updated vfio_sub_page_bar_update_mappings() )

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 202 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 120 insertions(+), 82 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28df7..fb9eb58da5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -119,6 +119,7 @@ static void vfio_intx_mmap_enable(void *opaque)
>   static void vfio_intx_interrupt(void *opaque)
>   {
>       VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       if (!event_notifier_test_and_clear(&vdev->intx.interrupt)) {
>           return;
> @@ -127,7 +128,7 @@ static void vfio_intx_interrupt(void *opaque)
>       trace_vfio_intx_interrupt(vdev->vbasedev.name, 'A' + vdev->intx.pin);
>   
>       vdev->intx.pending = true;
> -    pci_irq_assert(&vdev->pdev);
> +    pci_irq_assert(pdev);
>       vfio_mmap_set_enabled(vdev, false);
>       if (vdev->intx.mmap_timeout) {
>           timer_mod(vdev->intx.mmap_timer,
> @@ -138,6 +139,7 @@ static void vfio_intx_interrupt(void *opaque)
>   void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       if (!vdev->intx.pending) {
>           return;
> @@ -146,13 +148,14 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>       trace_vfio_pci_intx_eoi(vbasedev->name);
>   
>       vdev->intx.pending = false;
> -    pci_irq_deassert(&vdev->pdev);
> +    pci_irq_deassert(pdev);
>       vfio_device_irq_unmask(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>   }
>   
>   static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   {
>   #ifdef CONFIG_KVM
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
>   
>       if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
> @@ -165,7 +168,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
>       vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>       vdev->intx.pending = false;
> -    pci_irq_deassert(&vdev->pdev);
> +    pci_irq_deassert(pdev);
>   
>       /* Get an eventfd for resample/unmask */
>       if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
> @@ -243,6 +246,8 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>   {
>   #ifdef CONFIG_KVM
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
>       if (!vdev->intx.kvm_accel) {
>           return;
>       }
> @@ -253,7 +258,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>        */
>       vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>       vdev->intx.pending = false;
> -    pci_irq_deassert(&vdev->pdev);
> +    pci_irq_deassert(pdev);
>   
>       /* Tell KVM to stop listening for an INTx irqfd */
>       if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
> @@ -309,7 +314,7 @@ static void vfio_intx_routing_notifier(PCIDevice *pdev)
>           return;
>       }
>   
> -    route = pci_device_route_intx_to_irq(&vdev->pdev, vdev->intx.pin);
> +    route = pci_device_route_intx_to_irq(pdev, vdev->intx.pin);
>   
>       if (pci_intx_route_changed(&vdev->intx.route, &route)) {
>           vfio_intx_update(vdev, &route);
> @@ -326,7 +331,8 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>   
>   static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
>       Error *err = NULL;
>       int32_t fd;
>   
> @@ -344,7 +350,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       }
>   
>       vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
> -    pci_config_set_interrupt_pin(vdev->pdev.config, pin);
> +    pci_config_set_interrupt_pin(pdev->config, pin);
>   
>   #ifdef CONFIG_KVM
>       /*
> @@ -352,7 +358,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>        * where we won't actually use the result anyway.
>        */
>       if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
> -        vdev->intx.route = pci_device_route_intx_to_irq(&vdev->pdev,
> +        vdev->intx.route = pci_device_route_intx_to_irq(pdev,
>                                                           vdev->intx.pin);
>       }
>   #endif
> @@ -392,13 +398,14 @@ skip_signaling:
>   
>   static void vfio_intx_disable(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int fd;
>   
>       timer_del(vdev->intx.mmap_timer);
>       vfio_intx_disable_kvm(vdev);
>       vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>       vdev->intx.pending = false;
> -    pci_irq_deassert(&vdev->pdev);
> +    pci_irq_deassert(pdev);
>       vfio_mmap_set_enabled(vdev, true);
>   
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
> @@ -422,6 +429,7 @@ static void vfio_msi_interrupt(void *opaque)
>   {
>       VFIOMSIVector *vector = opaque;
>       VFIOPCIDevice *vdev = vector->vdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       MSIMessage (*get_msg)(PCIDevice *dev, unsigned vector);
>       void (*notify)(PCIDevice *dev, unsigned vector);
>       MSIMessage msg;
> @@ -436,9 +444,9 @@ static void vfio_msi_interrupt(void *opaque)
>           notify = msix_notify;
>   
>           /* A masked vector firing needs to use the PBA, enable it */
> -        if (msix_is_masked(&vdev->pdev, nr)) {
> +        if (msix_is_masked(pdev, nr)) {
>               set_bit(nr, vdev->msix->pending);
> -            memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, true);
> +            memory_region_set_enabled(&pdev->msix_pba_mmio, true);
>               trace_vfio_msix_pba_enable(vdev->vbasedev.name);
>           }
>       } else if (vdev->interrupt == VFIO_INT_MSI) {
> @@ -448,9 +456,9 @@ static void vfio_msi_interrupt(void *opaque)
>           abort();
>       }
>   
> -    msg = get_msg(&vdev->pdev, nr);
> +    msg = get_msg(pdev, nr);
>       trace_vfio_msi_interrupt(vdev->vbasedev.name, nr, msg.address, msg.data);
> -    notify(&vdev->pdev, nr);
> +    notify(pdev, nr);
>   }
>   
>   void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
> @@ -488,6 +496,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       struct vfio_irq_set *irq_set;
>       int ret = 0, i, argsz;
>       int32_t *fds;
> @@ -530,7 +539,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>            */
>           if (vdev->msi_vectors[i].use) {
>               if (vdev->msi_vectors[i].virq < 0 ||
> -                (msix && msix_is_masked(&vdev->pdev, i))) {
> +                (msix && msix_is_masked(pdev, i))) {
>                   fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
>               } else {
>                   fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
> @@ -550,12 +559,14 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>                                  int vector_n, bool msix)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
>       if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
>           return;
>       }
>   
>       vector->virq = kvm_irqchip_add_msi_route(&vfio_route_change,
> -                                             vector_n, &vdev->pdev);
> +                                             vector_n, pdev);
>   }
>   
>   static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
> @@ -624,7 +635,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
>   void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       Error *local_err = NULL;
>   
>       vector->vdev = vdev;
> @@ -713,7 +724,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       clear_bit(nr, vdev->msix->pending);
>       if (find_first_bit(vdev->msix->pending,
>                          vdev->nr_vectors) == vdev->nr_vectors) {
> -        memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> +        memory_region_set_enabled(&pdev->msix_pba_mmio, false);
>           trace_vfio_msix_pba_disable(vdev->vbasedev.name);
>       }
>   
> @@ -764,7 +775,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   
>   void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
>   {
> -    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
> +    msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>                                 vfio_msix_vector_release, NULL);
>   }
>   
> @@ -791,6 +804,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   
>   static void vfio_msix_enable(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int ret;
>   
>       vfio_disable_interrupts(vdev);
> @@ -807,7 +821,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>        */
>       vfio_pci_prepare_kvm_msi_virq_batch(vdev);
>   
> -    if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
> +    if (msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
>                                     vfio_msix_vector_release, NULL)) {
>           error_report("vfio: msix_set_vector_notifiers failed");
>       }
> @@ -845,11 +859,12 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>   
>   static void vfio_msi_enable(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int ret, i;
>   
>       vfio_disable_interrupts(vdev);
>   
> -    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
> +    vdev->nr_vectors = msi_nr_vectors_allocated(pdev);
>   retry:
>       /*
>        * Setting vector notifiers needs to enable route for each vector.
> @@ -942,10 +957,11 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
>   
>   static void vfio_msix_disable(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       Error *err = NULL;
>       int i;
>   
> -    msix_unset_vector_notifiers(&vdev->pdev);
> +    msix_unset_vector_notifiers(pdev);
>   
>       /*
>        * MSI-X will only release vectors if MSI-X is still enabled on the
> @@ -953,8 +969,8 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
>        */
>       for (i = 0; i < vdev->nr_vectors; i++) {
>           if (vdev->msi_vectors[i].use) {
> -            vfio_msix_vector_release(&vdev->pdev, i);
> -            msix_vector_unuse(&vdev->pdev, i);
> +            vfio_msix_vector_release(pdev, i);
> +            msix_vector_unuse(pdev, i);
>           }
>       }
>   
> @@ -991,6 +1007,7 @@ static void vfio_msi_disable(VFIOPCIDevice *vdev)
>   
>   static void vfio_update_msi(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int i;
>   
>       for (i = 0; i < vdev->nr_vectors; i++) {
> @@ -1001,8 +1018,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>               continue;
>           }
>   
> -        msg = msi_get_message(&vdev->pdev, i);
> -        vfio_update_kvm_msi_virq(vector, msg, &vdev->pdev);
> +        msg = msi_get_message(pdev, i);
> +        vfio_update_kvm_msi_virq(vector, msg, pdev);
>       }
>   }
>   
> @@ -1164,13 +1181,14 @@ static const MemoryRegionOps vfio_rom_ops = {
>   
>   static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
>       char *name;
>   
> -    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
> +    if (pdev->romfile || !pdev->rom_bar) {
>           /* Since pci handles romfile, just print a message and return */
> -        if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
> +        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
>               warn_report("Device at %s is known to cause system instability"
>                           " issues during option rom execution",
>                           vdev->vbasedev.name);
> @@ -1199,7 +1217,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>       }
>   
>       if (vfio_opt_rom_in_denylist(vdev)) {
> -        if (vdev->pdev.rom_bar > 0) {
> +        if (pdev->rom_bar > 0) {
>               warn_report("Device at %s is known to cause system instability"
>                           " issues during option rom execution",
>                           vdev->vbasedev.name);
> @@ -1218,12 +1236,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   
>       name = g_strdup_printf("vfio[%s].rom", vdev->vbasedev.name);
>   
> -    memory_region_init_io(&vdev->pdev.rom, OBJECT(vdev),
> +    memory_region_init_io(&pdev->rom, OBJECT(vdev),
>                             &vfio_rom_ops, vdev, name, size);
>       g_free(name);
>   
> -    pci_register_bar(&vdev->pdev, PCI_ROM_SLOT,
> -                     PCI_BASE_ADDRESS_SPACE_MEMORY, &vdev->pdev.rom);
> +    pci_register_bar(pdev, PCI_ROM_SLOT,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY, &pdev->rom);
>   
>       vdev->rom_read_failed = false;
>   }
> @@ -1496,6 +1514,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
>   
>   static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint16_t ctrl;
>       bool msi_64bit, msi_maskbit;
>       int ret, entries;
> @@ -1516,7 +1535,7 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   
>       trace_vfio_msi_setup(vdev->vbasedev.name, pos);
>   
> -    ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
> +    ret = msi_init(pdev, pos, entries, msi_64bit, msi_maskbit, &err);
>       if (ret < 0) {
>           if (ret == -ENOTSUP) {
>               return true;
> @@ -1709,6 +1728,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>    */
>   static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint8_t pos;
>       uint16_t ctrl;
>       uint32_t table, pba;
> @@ -1716,7 +1736,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       VFIOMSIXInfo *msix;
>       int ret;
>   
> -    pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
> +    pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
>       if (!pos) {
>           return true;
>       }
> @@ -1808,12 +1828,13 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>   static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int ret;
>       Error *err = NULL;
>   
>       vdev->msix->pending = g_new0(unsigned long,
>                                    BITS_TO_LONGS(vdev->msix->entries));
> -    ret = msix_init(&vdev->pdev, vdev->msix->entries,
> +    ret = msix_init(pdev, vdev->msix->entries,
>                       vdev->bars[vdev->msix->table_bar].mr,
>                       vdev->msix->table_bar, vdev->msix->table_offset,
>                       vdev->bars[vdev->msix->pba_bar].mr,
> @@ -1845,7 +1866,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>        * vector-use notifier is called, which occurs on unmask, we test whether
>        * PBA emulation is needed and again disable if not.
>        */
> -    memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> +    memory_region_set_enabled(&pdev->msix_pba_mmio, false);
>   
>       /*
>        * The emulated machine may provide a paravirt interface for MSIX setup
> @@ -1857,7 +1878,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>        */
>       if (object_property_get_bool(OBJECT(qdev_get_machine()),
>                                    "vfio-no-msix-emulation", NULL)) {
> -        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> +        memory_region_set_enabled(&pdev->msix_table_mmio, false);
>       }
>   
>       return true;
> @@ -1865,10 +1886,12 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   
>   void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
>   {
> -    msi_uninit(&vdev->pdev);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
> +    msi_uninit(pdev);
>   
>       if (vdev->msix) {
> -        msix_uninit(&vdev->pdev,
> +        msix_uninit(pdev,
>                       vdev->bars[vdev->msix->table_bar].mr,
>                       vdev->bars[vdev->msix->pba_bar].mr);
>           g_free(vdev->msix->pending);
> @@ -1929,6 +1952,7 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
>   
>   static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIOBAR *bar = &vdev->bars[nr];
>       char *name;
>   
> @@ -1950,7 +1974,7 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
>           }
>       }
>   
> -    pci_register_bar(&vdev->pdev, nr, bar->type, bar->mr);
> +    pci_register_bar(pdev, nr, bar->type, bar->mr);
>   }
>   
>   static void vfio_bars_register(VFIOPCIDevice *vdev)
> @@ -1964,6 +1988,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
>   
>   void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       int i;
>   
>       for (i = 0; i < PCI_ROM_SLOT; i++) {
> @@ -1977,7 +2002,7 @@ void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
>       }
>   
>       if (vdev->vga) {
> -        pci_unregister_vga(&vdev->pdev);
> +        pci_unregister_vga(pdev);
>           vfio_vga_quirk_exit(vdev);
>       }
>   }
> @@ -2049,8 +2074,10 @@ static void vfio_set_word_bits(uint8_t *buf, uint16_t val, uint16_t mask)
>   static void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
>                                      uint16_t val, uint16_t mask)
>   {
> -    vfio_set_word_bits(vdev->pdev.config + pos, val, mask);
> -    vfio_set_word_bits(vdev->pdev.wmask + pos, ~mask, mask);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
> +    vfio_set_word_bits(pdev->config + pos, val, mask);
> +    vfio_set_word_bits(pdev->wmask + pos, ~mask, mask);
>       vfio_set_word_bits(vdev->emulated_config_bits + pos, mask, mask);
>   }
>   
> @@ -2062,8 +2089,10 @@ static void vfio_set_long_bits(uint8_t *buf, uint32_t val, uint32_t mask)
>   static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
>                                      uint32_t val, uint32_t mask)
>   {
> -    vfio_set_long_bits(vdev->pdev.config + pos, val, mask);
> -    vfio_set_long_bits(vdev->pdev.wmask + pos, ~mask, mask);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
> +    vfio_set_long_bits(pdev->config + pos, val, mask);
> +    vfio_set_long_bits(pdev->wmask + pos, ~mask, mask);
>       vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
>   }
>   
> @@ -2071,7 +2100,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>   {
>       struct vfio_device_info_cap_pci_atomic_comp *cap;
>       g_autofree struct vfio_device_info *info = NULL;
> -    PCIBus *bus = pci_get_bus(&vdev->pdev);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    PCIBus *bus = pci_get_bus(pdev);
>       PCIDevice *parent = bus->parent_dev;
>       struct vfio_info_cap_header *hdr;
>       uint32_t mask = 0;
> @@ -2087,8 +2117,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>       if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>           pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>           pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        pdev->devfn ||
> +        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>           return;
>       }
>   
> @@ -2132,8 +2162,10 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +
>       if (vdev->clear_parent_atomics_on_exit) {
> -        PCIDevice *parent = pci_get_bus(&vdev->pdev)->parent_dev;
> +        PCIDevice *parent = pci_get_bus(pdev)->parent_dev;
>           uint8_t *pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
>   
>           pci_long_test_and_clear_mask(pos, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> @@ -2145,10 +2177,11 @@ static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
>   static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                                   Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint16_t flags;
>       uint8_t type;
>   
> -    flags = pci_get_word(vdev->pdev.config + pos + PCI_CAP_FLAGS);
> +    flags = pci_get_word(pdev->config + pos + PCI_CAP_FLAGS);
>       type = (flags & PCI_EXP_FLAGS_TYPE) >> 4;
>   
>       if (type != PCI_EXP_TYPE_ENDPOINT &&
> @@ -2160,8 +2193,8 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>           return false;
>       }
>   
> -    if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
> -        PCIBus *bus = pci_get_bus(&vdev->pdev);
> +    if (!pci_bus_is_express(pci_get_bus(pdev))) {
> +        PCIBus *bus = pci_get_bus(pdev);
>           PCIDevice *bridge;
>   
>           /*
> @@ -2193,7 +2226,7 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>               return true;
>           }
>   
> -    } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
> +    } else if (pci_bus_is_root(pci_get_bus(pdev))) {
>           /*
>            * On a Root Complex bus Endpoints become Root Complex Integrated
>            * Endpoints, which changes the type and clears the LNK & LNK2 fields.
> @@ -2261,20 +2294,20 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                                  1, PCI_EXP_FLAGS_VERS);
>       }
>   
> -    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
> -                             errp);
> +    pos = pci_add_capability(pdev, PCI_CAP_ID_EXP, pos, size, errp);
>       if (pos < 0) {
>           return false;
>       }
>   
> -    vdev->pdev.exp.exp_cap = pos;
> +    pdev->exp.exp_cap = pos;
>   
>       return true;
>   }
>   
>   static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
>   {
> -    uint32_t cap = pci_get_long(vdev->pdev.config + pos + PCI_EXP_DEVCAP);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint32_t cap = pci_get_long(pdev->config + pos + PCI_EXP_DEVCAP);
>   
>       if (cap & PCI_EXP_DEVCAP_FLR) {
>           trace_vfio_check_pcie_flr(vdev->vbasedev.name);
> @@ -2284,7 +2317,8 @@ static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
>   
>   static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
>   {
> -    uint16_t csr = pci_get_word(vdev->pdev.config + pos + PCI_PM_CTRL);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint16_t csr = pci_get_word(pdev->config + pos + PCI_PM_CTRL);
>   
>       if (!(csr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>           trace_vfio_check_pm_reset(vdev->vbasedev.name);
> @@ -2294,7 +2328,8 @@ static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
>   
>   static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>   {
> -    uint8_t cap = pci_get_byte(vdev->pdev.config + pos + PCI_AF_CAP);
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint8_t cap = pci_get_byte(pdev->config + pos + PCI_AF_CAP);
>   
>       if ((cap & PCI_AF_CAP_TP) && (cap & PCI_AF_CAP_FLR)) {
>           trace_vfio_check_af_flr(vdev->vbasedev.name);
> @@ -2305,7 +2340,7 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>   static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
>                                            uint8_t size, Error **errp)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
>       if (pos < 0) {
> @@ -2327,7 +2362,7 @@ static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
>   static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>   {
>       ERRP_GUARD();
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint8_t cap_id, next, size;
>       bool ret;
>   
> @@ -2413,17 +2448,18 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>   
>   static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint32_t ctrl;
>       int i, nbar;
>   
> -    ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL);
> +    ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL);
>       nbar = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
>   
>       for (i = 0; i < nbar; i++) {
>           uint32_t cap;
>           int size;
>   
> -        ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL + (i * 8));
> +        ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL + (i * 8));
>           size = (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
>   
>           /* The cap register reports sizes 1MB to 128TB, with 4 reserved bits */
> @@ -2461,7 +2497,7 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>   
>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint32_t header;
>       uint16_t cap_id, next, size;
>       uint8_t cap_ver;
> @@ -2555,7 +2591,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   
>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>           !pdev->config[PCI_CAPABILITY_LIST]) {
> @@ -2572,7 +2608,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   
>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       uint16_t cmd;
>   
>       vfio_disable_interrupts(vdev);
> @@ -2789,7 +2825,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       pcibus_t old_addr[PCI_NUM_REGIONS - 1];
>       int bar, ret;
>   
> @@ -2837,6 +2873,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
>       int ret;
> @@ -2893,7 +2930,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>                             "vfio-vga-io@0x3c0",
>                             QEMU_PCI_VGA_IO_HI_SIZE);
>   
> -    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
> +    pci_register_vga(pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
>                        &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
>                        &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
>   
> @@ -2902,6 +2939,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   
>   bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
>       struct vfio_irq_info irq_info;
> @@ -2953,7 +2991,7 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   
>       vdev->config_size = reg_info->size;
>       if (vdev->config_size == PCI_CONFIG_SPACE_SIZE) {
> -        vdev->pdev.cap_present &= ~QEMU_PCI_CAP_EXPRESS;
> +        pdev->cap_present &= ~QEMU_PCI_CAP_EXPRESS;
>       }
>       vdev->config_offset = reg_info->offset;
>   
> @@ -3156,16 +3194,16 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>   
>   bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t config_space_size;
>       int ret;
>   
> -    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> +    config_space_size = MIN(pci_config_size(pdev), vdev->config_size);
>   
>       /* Get a copy of config space */
>       ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
> -                                     vdev->pdev.config);
> +                                     pdev->config);
>       if (ret < (int)config_space_size) {
>           ret = ret < 0 ? -ret : EFAULT;
>           error_setg_errno(errp, ret, "failed to read device config space");
> @@ -3233,10 +3271,10 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>                                                 PCI_HEADER_TYPE_MULTI_FUNCTION;
>   
>       /* Restore or clear multifunction, this is always controlled by QEMU */
> -    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> -        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
> +    if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        pdev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
>       } else {
> -        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
> +        pdev->config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
>       }
>   
>       /*
> @@ -3244,8 +3282,8 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>        * BAR, such as might be the case with the option ROM, we can get
>        * confusing, unwritable, residual addresses from the host here.
>        */
> -    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
> -    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
> +    memset(&pdev->config[PCI_BASE_ADDRESS_0], 0, 24);
> +    memset(&pdev->config[PCI_ROM_ADDRESS], 0, 4);
>   
>       vfio_pci_size_rom(vdev);
>   
> @@ -3262,7 +3300,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>   bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       /* QEMU emulates all of MSI & MSIX */
>       if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
> @@ -3275,10 +3313,10 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>                  vdev->msi_cap_size);
>       }
>   
> -    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
> +    if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>           vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                                vfio_intx_mmap_enable, vdev);
> -        pci_device_set_intx_routing_notifier(&vdev->pdev,
> +        pci_device_set_intx_routing_notifier(pdev,
>                                                vfio_intx_routing_notifier);
>           vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
> @@ -3290,7 +3328,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>            */
>           if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
>               timer_free(vdev->intx.mmap_timer);
> -            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +            pci_device_set_intx_routing_notifier(pdev, NULL);
>               kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>               return false;
>           }
> @@ -3440,7 +3478,7 @@ out_deregister:
>       if (vdev->interrupt == VFIO_INT_INTx) {
>           vfio_intx_disable(vdev);
>       }
> -    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    pci_device_set_intx_routing_notifier(pdev, NULL);
>       if (vdev->irqchip_change_notifier.notify) {
>           kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>       }
> @@ -3472,7 +3510,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>   
>       vfio_unregister_req_notifier(vdev);
>       vfio_unregister_err_notifier(vdev);
> -    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +    pci_device_set_intx_routing_notifier(pdev, NULL);
>       if (vdev->irqchip_change_notifier.notify) {
>           kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>       }


