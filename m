Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D139ECCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG2LL-0005KE-8J; Mon, 03 Nov 2025 16:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vG2LI-0005Jp-5D
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vG2LA-00072O-5v
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762206221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+ZPml5iT5wAuhvOAdW7XwCu7EIbzYFpvwafYdzhyoo=;
 b=QMmwG1EoxZ3DiZjspalm9z0olu4GX2/YAfXCo6rqx3b/USWi/m4ePN3DpFhBPBx7BJfnxC
 PuvI7kO0QtkoEoZ1UND/H6c9w+bazz2fIraAf5wP/xOxwMvf97D8DoKqDYNlQVAK2/74ZG
 l7BWC7Iw5T7+mggfqfRUNPoMyPrLZWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-iZTeDxI7OIeN_szOlDIzMg-1; Mon, 03 Nov 2025 16:43:40 -0500
X-MC-Unique: iZTeDxI7OIeN_szOlDIzMg-1
X-Mimecast-MFC-AGG-ID: iZTeDxI7OIeN_szOlDIzMg_1762206219
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429be5aeea2so2010068f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762206218; x=1762811018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V+ZPml5iT5wAuhvOAdW7XwCu7EIbzYFpvwafYdzhyoo=;
 b=K6Sk2bP+lm+FNlT6v4rJ8vANVQUhbJ872f7YgSyfdcjoOPzA2fHcnyUaxLMB13sPUJ
 yB5PJAhOLZtZ1eaeKCdOdB18UanVJascx/Hn0545y3RnaEAN7meepN0I7w5cNbUqNHbM
 xl+fkpARQxHhH2ZXyNgd/R8IbyMZu3K9PSKXQGJIDPhNz7csqhEZY8G5oAKuZd6UYzb/
 2YnSVTWnCooAm4XGJLr01B5R26h31lYqCF2ywRi3jP834kWXdioeRkCQ3Y8h+ZEPpfol
 oxQXx+l9Rp9q7L2s+g9DdnA6wN0NLt/C3eatZATjDWvfUNDNt7P/EerCta+A2tIFKai0
 E/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762206218; x=1762811018;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V+ZPml5iT5wAuhvOAdW7XwCu7EIbzYFpvwafYdzhyoo=;
 b=I2KMv3N/LQL7bYRRVFaUuzyBBije5LSjUffTIhOhpII0DaSWPXLmO6dSiPzvJMKUbS
 FfQrC0nG98ea1dmF7EaXU8yk/ToKV2l265pal0E51GFfexwtDdyuw8A2bxKcv9hd8KtZ
 HnY/wKUFD29GR0uoW39JP5yumTS8Na9edKhysYB/x7InP+uOYMIrzScQFOTQwsCP8O29
 xSKRLunKFAXIyH//kcAeNK1l1cbz0EiZhHtWhccGcnap+ZPjGK7JKhFt2JEwMIWTUrk1
 ufFRBvryC02cwycr2K0l5nZsJ5JsPS8PFof8CDrSAN5rUOhD+68GLRrWDv1+f7PpWiGQ
 wYuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuAPNKaRAPgnqn1Yn59XFSvPEYl8rTQO+TzgR50OOGlUI8BNg597wS4QNh3XleB5YdY0dN0/BheROG@nongnu.org
X-Gm-Message-State: AOJu0Yy4XZzTEfo7pgA/3SJw6VtU5iHogZLsJWF5HuP77dMnSJznikvc
 +7UfqWewXdb/Dm6ZY5FirFRAcDloXgeyBcgBV2QdrwRd0Mvi8vmjiXalcUpOpMqbRVrI9vAjAxc
 BXOahAlhloJJOH9tMOxnqgS+4NtnUw1ESeN3IIX1ebMyeMS6xkE0TR+jYdlD/DEEk
X-Gm-Gg: ASbGncu5V7xH0qIP0uiBD9YaVxb9RT3YD/Sj0ROD/Tna0hbQ9HaiEpMzn2wnDJ8E/k7
 QjMuR128aPuLh9hBb6D5CuoxXhUKbF0ER2IvW58b4NQGTJD1f5WUHTwdadVBVv/Y1YwxA6suqsV
 9OrD6F53ueluhQBxJxpJAepl2tI0Bx/VHyGzLm5S2UUjyy1aElgK9SnVLc/rlYCPxfCCRT1Jnk7
 QxzRzXYu68LOhIjyRRaTuOkBg3T7pazrIHgbijCXoTL4fjghRw78meDVgH+2iPgs5/56hud2nwy
 D+xQQbX9BkT1EdGI21V6aor8yUaFEew57WybxPjFXU7KMIIWtaI1oZqgeIUZi5AXEoAMKc+CQGb
 oB4vGqtowbfKfgsFa5B4qs3t8QXm0U0fRpr9DlQ==
X-Received: by 2002:a05:6000:2387:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-429bd6b1fbemr12363030f8f.56.1762206218401; 
 Mon, 03 Nov 2025 13:43:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaqs6/a6p9FJBO+LofC3yX9PDpXY9/Jljv9twWtMF8rZmundSSDz3Ldhmnz/emMVbaTGLbhQ==
X-Received: by 2002:a05:6000:2387:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-429bd6b1fbemr12363017f8f.56.1762206217912; 
 Mon, 03 Nov 2025 13:43:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2ff79bsm175033615e9.6.2025.11.03.13.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 13:43:37 -0800 (PST)
Message-ID: <929c041e-4a00-472b-82a6-0fba9022153f@redhat.com>
Date: Mon, 3 Nov 2025 22:43:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/35] hw/intc: Generalize APIC helper names from kvm_* to
 accel_*
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-11-pbonzini@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251009075026.505715-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 10/9/25 09:50, Paolo Bonzini wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> Rename APIC helper functions to use an accel_* prefix instead of kvm_*
> to support use by accelerators other than KVM. This is a preparatory
> step for integrating MSHV support with common APIC logic.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20250916164847.77883-5-magnuskulke@linux.microsoft.com
> [Remove dead definition of mshv_msi_via_irqfd_enabled. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/system/accel-irq.h |  37 +++++++++++++
>   include/system/mshv.h      |  17 ++++++
>   accel/accel-irq.c          | 106 +++++++++++++++++++++++++++++++++++++
>   hw/intc/ioapic.c           |  20 ++++---
>   hw/virtio/virtio-pci.c     |  21 ++++----
>   accel/meson.build          |   2 +-
>   6 files changed, 185 insertions(+), 18 deletions(-)
>   create mode 100644 include/system/accel-irq.h
>   create mode 100644 accel/accel-irq.c

This change seems to introduce a regression with interrupt remapping
when running a VM configured with an intel-iommu device and an assigned
PCI VF. At boot, Linux complains with :

[   15.416794] __common_interrupt: 2.37 No irq handler for vector
[   15.417266] __common_interrupt: 2.37 No irq handler for vector
[   15.417733] __common_interrupt: 2.37 No irq handler for vector
[   15.418202] __common_interrupt: 2.37 No irq handler for vector
[   15.418670] __common_interrupt: 2.37 No irq handler for vector
[   15.419143] __common_interrupt: 2.37 No irq handler for vector
[   15.419608] __common_interrupt: 2.37 No irq handler for vector
[   15.420094] __common_interrupt: 2.37 No irq handler for vector
[   15.420556] __common_interrupt: 2.37 No irq handler for vector


CC’ingg Zhenzhong, Joao, Clement for awareness and their expertise
in intel-iommu and interrupt remapping.

Thanks,

C.



> 
> diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
> new file mode 100644
> index 00000000000..671fb7dfdbb
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
> index 342f1ef6a98..2a504ed81f2 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -22,4 +22,21 @@
>   #define CONFIG_MSHV_IS_POSSIBLE
>   #endif
>   
> +#ifdef CONFIG_MSHV_IS_POSSIBLE
> +extern bool mshv_allowed;
> +#define mshv_enabled() (mshv_allowed)
> +#else /* CONFIG_MSHV_IS_POSSIBLE */
> +#define mshv_enabled() false
> +#endif
> +#define mshv_msi_via_irqfd_enabled() false
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
> diff --git a/accel/accel-irq.c b/accel/accel-irq.c
> new file mode 100644
> index 00000000000..7f864e35c4e
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
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 133bef852d1..e431d003117 100644
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
> index 767216d7959..0cdc16217ff 100644
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
> diff --git a/accel/meson.build b/accel/meson.build
> index 25b0f100b51..6349efe682f 100644
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


