Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3vt0-0006IZ-Da; Wed, 01 Oct 2025 08:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3vsw-0006I7-DP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3vsi-0000Fw-Fm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759321461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LyZ0fRAdKlSnCt7b5iGW3u0zcJDrTe+vk1kpPr0kBVE=;
 b=XbL/p+U+JZ3rn6469FIre+puIgpgFzpAA7qc9S1MRRtxvMzUds4s8XQpanm5aBoiXe2uvA
 SBgGXnyq2tmX/AwP3fLDuQ4XAEr8O+Yo3BTleGU00bzm3PDk5nQ0jgAQheGMZgLIZ1siM6
 +o3yut1JjMZv++a7xsMcraFD9Jq9PxQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-axbS70SNOk6f7I1cNPTbFg-1; Wed, 01 Oct 2025 08:24:20 -0400
X-MC-Unique: axbS70SNOk6f7I1cNPTbFg-1
X-Mimecast-MFC-AGG-ID: axbS70SNOk6f7I1cNPTbFg_1759321459
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb78d5c35so109858766b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759321459; x=1759926259;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyZ0fRAdKlSnCt7b5iGW3u0zcJDrTe+vk1kpPr0kBVE=;
 b=QsBFRQCqtNV7AVDPr5hnL/+SBrd1Qbj5v85pC1N83XsovG1vrh7sFXKRQSn1FjGoSw
 +4SYIqQ5Dw0s7XUASSG4bhXdjoxTslUxjtbrVIoMaNHNOFm6npqveV3F6m9MGCgy8sbS
 BE9xEH7LlpTOPVovNEOpuJ+qH5jEjn4LuhQn650/tC+USZvRqH2Ah7iDu/6+T6+yEHcf
 qLYTA7A8VugW2MoN3F1lZYVVRPOz3GnEjy/kNqePOX9PRmvHkOT5s9/3N4RK3zXIOVqF
 VofwpJp4/bAIZiTP3jxZ/APCpIiJKc0oZaS8/ar1dnZeUInXL2EBLKjNCdZDB/9rqd1R
 TJHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhx76pldauedgriffxAqDN9uFw0sPZYL3qS7fcuJjCSucXcEI9E8Vbu5r/XMnUF838oASALgM809i8@nongnu.org
X-Gm-Message-State: AOJu0YzozlXw5WERRaxfnmGOvN0FuSBvN46fOIHVYsE8IzIhrF645Ssq
 I5GaNGWBslTbt42GvM887nMHbrHGlc9JRCEnJN0Z0Nw1gnsvQ2ftlj2F13dFXNkNyUDTzNxdNqs
 Fr0aLIZQlmPl0NETPyMrI+qbpKIySUlVIBkciEe31unf3y7AByVMgO3Vw
X-Gm-Gg: ASbGnctuUV0bI0D2Z/1VmEvDtLROOgQJGXe2CyXy6D5+BFSBci1Vj03ohc0h/q2Q2W3
 pncuuwYIP4ufyLHMstNy1pWV3Pr2+UHDRY2VMt8PVZ0BivOQb1/2UQzO2uQ/eX9JDqREXb6SU23
 esLZ60P791gEAV7KSNQfsacSZU8VhPxUoVHE0YlxiqEzgbY9X6aH7M8+HjjER6hzdYUeHqantp5
 KSQB/GBUb2+PPRSaB3e1Uh+prRXXdA/VxCkkrGwDkTtWNF7MtE5NrndesF6Ss+wQlZDABqBgsLF
 cMQ5rGIahw6IvPo75mPGWHGos7kqkkW34oSzqgfKFMJ+RYxtvYqK3WxAWr4oWN4m+3NCVPXPpoh
 V3+yKo9q9mdUXoNmmyzX5chW5iXimw6c418UDq19m+zx1sAZkEgA=
X-Received: by 2002:a17:907:86ac:b0:b3e:26ae:7288 with SMTP id
 a640c23a62f3a-b46e47a946dmr387156166b.8.1759321458760; 
 Wed, 01 Oct 2025 05:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESYICjE2YU4PRYf3ZvvbjJh6MSl6TAp6ZZSc82H0I6pfV7oJwLR/8IeKQgeQEBBTpESi4yKg==
X-Received: by 2002:a17:907:86ac:b0:b3e:26ae:7288 with SMTP id
 a640c23a62f3a-b46e47a946dmr387151366b.8.1759321458110; 
 Wed, 01 Oct 2025 05:24:18 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b3b74cb1e9asm890069766b.98.2025.10.01.05.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 05:24:17 -0700 (PDT)
Message-ID: <68032792-85a6-42e9-9711-2bbb1fef22df@redhat.com>
Date: Wed, 1 Oct 2025 14:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/27] hw/intc: Generalize APIC helper names from kvm_*
 to accel_*
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-5-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250916164847.77883-5-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/16/25 18:48, Magnus Kulke wrote:
> Rename APIC helper functions to use an accel_* prefix instead of kvm_*
> to support use by accelerators other than KVM. This is a preparatory
> step for integrating MSHV support with common APIC logic.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   accel/accel-irq.c          | 106 +++++++++++++++++++++++++++++++++++++
>   accel/meson.build          |   2 +-
>   hw/intc/ioapic.c           |  20 ++++---
>   hw/virtio/virtio-pci.c     |  21 ++++----
>   include/system/accel-irq.h |  37 +++++++++++++
>   include/system/mshv.h      |  21 ++++++++
>   6 files changed, 189 insertions(+), 18 deletions(-)
>   create mode 100644 accel/accel-irq.c
>   create mode 100644 include/system/accel-irq.h
> 
> diff --git a/accel/accel-irq.c b/accel/accel-irq.c
> new file mode 100644
> index 0000000000..7f864e35c4
> --- /dev/null
> +++ b/accel/accel-irq.c
> @@ -0,0 +1,106 @@
> +/*
> + * Accelerated irqchip abstraction
> + *
> + * Copyright Microsoft, Corp. 2025
> + *
> + * Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
> + *          Magnus Kulke <magnuskulke@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/msi.h"
> +
> +#include "system/kvm.h"
> +#include "system/mshv.h"
> +#include "system/accel-irq.h"
> +
> +int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        return mshv_irqchip_add_msi_route(vector, dev);
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        return kvm_irqchip_add_msi_route(c, vector, dev);
> +    }
> +    return -ENOSYS;
> +}
> +
> +int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        return mshv_irqchip_update_msi_route(vector, msg, dev);
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        return kvm_irqchip_update_msi_route(kvm_state, vector, msg, dev);
> +    }
> +    return -ENOSYS;
> +}
> +
> +void accel_irqchip_commit_route_changes(KVMRouteChange *c)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        mshv_irqchip_commit_routes();
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        kvm_irqchip_commit_route_changes(c);
> +    }
> +}
> +
> +void accel_irqchip_commit_routes(void)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        mshv_irqchip_commit_routes();
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        kvm_irqchip_commit_routes(kvm_state);
> +    }
> +}
> +
> +void accel_irqchip_release_virq(int virq)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        mshv_irqchip_release_virq(virq);
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        kvm_irqchip_release_virq(kvm_state, virq);
> +    }
> +}
> +
> +int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
> +                                         int virq)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        return mshv_irqchip_add_irqfd_notifier_gsi(n, rn, virq);
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, rn, virq);
> +    }
> +    return -ENOSYS;
> +}
> +
> +int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
> +{
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +    if (mshv_msi_via_irqfd_enabled()) {
> +        return mshv_irqchip_remove_irqfd_notifier_gsi(n, virq);
> +    }
> +#endif
> +    if (kvm_enabled()) {
> +        return kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, virq);
> +    }
> +    return -ENOSYS;
> +}
> diff --git a/accel/meson.build b/accel/meson.build
> index 25b0f100b5..6349efe682 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -1,6 +1,6 @@
>   common_ss.add(files('accel-common.c'))
>   specific_ss.add(files('accel-target.c'))
> -system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c'))
> +system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
>   user_ss.add(files('accel-user.c'))
>   
>   subdir('tcg')
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 133bef852d..e431d00311 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -30,12 +30,18 @@
>   #include "hw/intc/ioapic_internal.h"
>   #include "hw/pci/msi.h"
>   #include "hw/qdev-properties.h"
> +#include "system/accel-irq.h"
>   #include "system/kvm.h"
>   #include "system/system.h"
>   #include "hw/i386/apic-msidef.h"
>   #include "hw/i386/x86-iommu.h"
>   #include "trace.h"
>   
> +
> +#if defined(CONFIG_KVM) || defined(CONFIG_MSHV)
> +#define ACCEL_GSI_IRQFD_POSSIBLE
> +#endif
> +
>   #define APIC_DELIVERY_MODE_SHIFT 8
>   #define APIC_POLARITY_SHIFT 14
>   #define APIC_TRIG_MODE_SHIFT 15
> @@ -191,10 +197,10 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
>   
>   static void ioapic_update_kvm_routes(IOAPICCommonState *s)
>   {
> -#ifdef CONFIG_KVM
> +#ifdef ACCEL_GSI_IRQFD_POSSIBLE
>       int i;
>   
> -    if (kvm_irqchip_is_split()) {
> +    if (accel_irqchip_is_split()) {
>           for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>               MSIMessage msg;
>               struct ioapic_entry_info info;
> @@ -202,15 +208,15 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
>               if (!info.masked) {
>                   msg.address = info.addr;
>                   msg.data = info.data;
> -                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
> +                accel_irqchip_update_msi_route(i, msg, NULL);
>               }
>           }
> -        kvm_irqchip_commit_routes(kvm_state);
> +        accel_irqchip_commit_routes();
>       }
>   #endif
>   }
>   
> -#ifdef CONFIG_KVM
> +#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
>   static void ioapic_iec_notifier(void *private, bool global,
>                                   uint32_t index, uint32_t mask)
>   {
> @@ -428,11 +434,11 @@ static const MemoryRegionOps ioapic_io_ops = {
>   
>   static void ioapic_machine_done_notify(Notifier *notifier, void *data)
>   {
> -#ifdef CONFIG_KVM
> +#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
>       IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
>                                           machine_done);
>   
> -    if (kvm_irqchip_is_split()) {
> +    if (accel_irqchip_is_split()) {
>           X86IOMMUState *iommu = x86_iommu_get_default();
>           if (iommu) {
>               /* Register this IOAPIC with IOMMU IEC notifier, so that
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795..0cdc16217f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -34,6 +34,7 @@
>   #include "hw/pci/msi.h"
>   #include "hw/pci/msix.h"
>   #include "hw/loader.h"
> +#include "system/accel-irq.h"
>   #include "system/kvm.h"
>   #include "hw/virtio/virtio-pci.h"
>   #include "qemu/range.h"
> @@ -825,11 +826,11 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
>   
>       if (irqfd->users == 0) {
>           KVMRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
> -        ret = kvm_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
> +        ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
>           if (ret < 0) {
>               return ret;
>           }
> -        kvm_irqchip_commit_route_changes(&c);
> +        accel_irqchip_commit_route_changes(&c);
>           irqfd->virq = ret;
>       }
>       irqfd->users++;
> @@ -841,7 +842,7 @@ static void kvm_virtio_pci_vq_vector_release(VirtIOPCIProxy *proxy,
>   {
>       VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
>       if (--irqfd->users == 0) {
> -        kvm_irqchip_release_virq(kvm_state, irqfd->virq);
> +        accel_irqchip_release_virq(irqfd->virq);
>       }
>   }
>   
> @@ -850,7 +851,7 @@ static int kvm_virtio_pci_irqfd_use(VirtIOPCIProxy *proxy,
>                                    unsigned int vector)
>   {
>       VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
> -    return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, irqfd->virq);
> +    return accel_irqchip_add_irqfd_notifier_gsi(n, NULL, irqfd->virq);
>   }
>   
>   static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
> @@ -860,7 +861,7 @@ static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
>       VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
>       int ret;
>   
> -    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, irqfd->virq);
> +    ret = accel_irqchip_remove_irqfd_notifier_gsi(n, irqfd->virq);
>       assert(ret == 0);
>   }
>   static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
> @@ -995,12 +996,12 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
>       if (proxy->vector_irqfd) {
>           irqfd = &proxy->vector_irqfd[vector];
>           if (irqfd->msg.data != msg.data || irqfd->msg.address != msg.address) {
> -            ret = kvm_irqchip_update_msi_route(kvm_state, irqfd->virq, msg,
> -                                               &proxy->pci_dev);
> +            ret = accel_irqchip_update_msi_route(irqfd->virq, msg,
> +                                                 &proxy->pci_dev);
>               if (ret < 0) {
>                   return ret;
>               }
> -            kvm_irqchip_commit_routes(kvm_state);
> +            accel_irqchip_commit_routes();
>           }
>       }
>   
> @@ -1229,7 +1230,7 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>       int r, n;
>       bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
> -        kvm_msi_via_irqfd_enabled();
> +        accel_msi_via_irqfd_enabled() ;
>   
>       nvqs = MIN(nvqs, VIRTIO_QUEUE_MAX);
>   
> @@ -1433,7 +1434,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
>                                     uint16_t new_vector)
>   {
>       bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> -        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +        msix_enabled(&proxy->pci_dev) && accel_msi_via_irqfd_enabled();
>   
>       if (new_vector == old_vector) {
>           return;
> diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
> new file mode 100644
> index 0000000000..671fb7dfdb
> --- /dev/null
> +++ b/include/system/accel-irq.h
> @@ -0,0 +1,37 @@
> +/*
> + * Accelerated irqchip abstraction
> + *
> + * Copyright Microsoft, Corp. 2025
> + *
> + * Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
> + *          Magnus Kulke <magnuskulke@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef SYSTEM_ACCEL_IRQ_H
> +#define SYSTEM_ACCEL_IRQ_H
> +#include "hw/pci/msi.h"
> +#include "qemu/osdep.h"
> +#include "system/kvm.h"
> +#include "system/mshv.h"
> +
> +static inline bool accel_msi_via_irqfd_enabled(void)
> +{
> +    return mshv_msi_via_irqfd_enabled() || kvm_msi_via_irqfd_enabled();
> +}
> +
> +static inline bool accel_irqchip_is_split(void)
> +{
> +    return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
> +}
> +
> +int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
> +int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
> +void accel_irqchip_commit_route_changes(KVMRouteChange *c);
> +void accel_irqchip_commit_routes(void);
> +void accel_irqchip_release_virq(int virq);
> +int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
> +                                         int virq);
> +int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq);
> +#endif
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index a971982b52..a358691428 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -22,4 +22,25 @@
>   #define CONFIG_MSHV_IS_POSSIBLE
>   #endif
>   
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +extern bool mshv_allowed;
> +#define mshv_enabled() (mshv_allowed)
> +#else /* CONFIG_MSHV_IS_POSSIBLE */
> +#define mshv_enabled() false
> +#endif
> +#ifdef MSHV_USE_KERNEL_GSI_IRQFD

Stupid question, who defines MSHV_USE_KERNEL_GSI_IRQFD?  In QEMU 
generally we prefer to probe capabilities at run-time, so that you can 
build with version A of the headers and run on version B.

If there's no interesting setup where MSHV_USE_KERNEL_GSI_IRQFD is not 
defined, it would of course be nice to assume that it's enabled.

Paolo

> +#define mshv_msi_via_irqfd_enabled() mshv_enabled()
> +#else
> +#define mshv_msi_via_irqfd_enabled() false
> +#endif
> +
> +/* interrupt */
> +int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
> +int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
> +void mshv_irqchip_commit_routes(void);
> +void mshv_irqchip_release_virq(int virq);
> +int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
> +                                        const EventNotifier *rn, int virq);
> +int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
> +
>   #endif


