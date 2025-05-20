Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BBBC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 18:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSAw-0007Tw-7X; Tue, 20 May 2025 14:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAt-0007TB-EF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:51 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAr-0006wW-70
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:51 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4e2900db5f1so883684137.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747767527; x=1748372327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BghkL5YTYyzBopr8l6K7Nfeo1AvLqxr9rgJv299vPXQ=;
 b=v7cNDeG/G9XWHujpiMrwz/UrSTiNm7xxciQJ31/PguNrMMpVJ4HG5IjBwEQETpa47A
 ZbYjf/jTdhlqMyrnIJ/w1NbJwwZ0AvUYcMtDnm2qahTSfJ5bZJ/BdfxgBRGqv8/jWTnA
 +8V/rXjdmCobmcnISXQMMrYs0CvKPBGAppf1qnrJrreEvba9wJnnIbhKKGVrBWxFjq3b
 f/6bRofOeFJy/5QmHCQ2cNnpcAya/Si+oSfTROHgdSJetJtsVlPkXUDAvDvsG7j4tr4b
 SMKBncjCakXLpAb0/p0uFAkE1rj1S/03WUnP6RUn8eDIa+OVscYsEzG2RlABk+U71YH/
 k6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747767527; x=1748372327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BghkL5YTYyzBopr8l6K7Nfeo1AvLqxr9rgJv299vPXQ=;
 b=swuFKY/3MVHEtRsx1r1eshT8HLb30lH6LqaqsdQmAWsJB8mCNsgB/FwyGO/D84qnFA
 IuzHuGPGWj5xThsaaNVpb7F3JDQI8nMk/AuW1sgaYHzVwSafMsyqJ/OHEvrpoEmh9WMY
 sAOSCTOqVeK6jujgkvGkwLh39SS9O2JloPwWij8zC9sk7ujBNN6YEpZBMuxxscad0lKQ
 Kvk3YSBboDjOwYT9KuNkPpeJvimCc8BVTiHDxnIOgym5xIkhttZPB96hwMVKJTMLl5/C
 lM/5IiEKxMG9YyjJ4w1b83yAz/4seNsPbZbELhKQVlVK0ilUPA4Z9dswprcx7pPmHMsA
 Z/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGcQ0GeU+YroX7cIL74aIaeXIFgi4x2qJgG+vXvn9oJTYaBRSyxY7Wk7etwGcWRlayZxYs58RaraHt@nongnu.org
X-Gm-Message-State: AOJu0YyEGhIsRDLrswp91Zm09sCUeGLlXhVORfNagd6u2duOEMi7BqgE
 h235yDgSvJ6Vn7nvORuMm7wIa5dIxtBRtq/Wl3u0fLaVHgdSaAC7X0nESSmtoMo4VoCzUm34vFE
 /QTLKxgk=
X-Gm-Gg: ASbGncvkd7ImOPGU23Y+8Bas9qnmE4zZeWkT7AKsJ+WbKYy9HpP0V8MPspZ0NggW6Mf
 E8l530G6xTYNjggfmx2+x2hxVI6TnfO0dEjZQAGnlaBRBQ1r2pR5Wa0gaM8RGVGR0HYS3rr9Q4B
 cCmEbvZpn/vHHbeElhE/s+XkPDw7TjEukDWWR6b2GQ/7GyqFFHrFQJ2eQecont8IBxuHgsjz40x
 4eGZcfvl/1VqQZrpoE8rcVKxz+kuBmh7qxymWeMfWp6KaH/tA6zYV9GtqUCTlYJORt0fEnUA6Hy
 J3VULxzm/ahwPwftk4lnkRWEsrHS1UKswUneC8KB0fhHGPh8mJXDDHU35zctKNyfmW/1UvxXhLu
 BvlFXjtmwKuPKC8vtlnABCKKBKewhaw==
X-Google-Smtp-Source: AGHT+IFP3xWUOLlBXSUZJzKMDorlmnTksyW9/fDcIFigyRu9oFpjKg5so1tfEf6j9EOyY5rNyY7Ijg==
X-Received: by 2002:a05:6102:b0f:b0:4e2:a132:c50c with SMTP id
 ada2fe7eead31-4e2a132c627mr6833556137.2.1747767527256; 
 Tue, 20 May 2025 11:58:47 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec155e21sm7834268241.17.2025.05.20.11.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 11:58:46 -0700 (PDT)
Message-ID: <fef4807e-a407-49ac-8e52-5767f9e1f6cf@linaro.org>
Date: Tue, 20 May 2025 15:58:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] hw/i386/acpi-build: Move
 build_append_notification_callback to pcihp
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-12-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-12-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe32.google.com
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> We plan to reuse build_append_notification_callback() on ARM
> so let's move it to pcihp.c.
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pcihp.h |  1 +
>   hw/acpi/pcihp.c         | 58 +++++++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c    | 58 -----------------------------------------
>   3 files changed, 59 insertions(+), 58 deletions(-)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 525e61a2a9..7c5d59243f 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -78,6 +78,7 @@ void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
>   void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
>   void build_append_pcihp_resources(Aml *table,
>                                     uint64_t io_addr, uint64_t io_len);
> +bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
>   
>   /* Called on reset */
>   void acpi_pcihp_reset(AcpiPciHpState *s);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 310a5c54bd..907a08ac7f 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -39,6 +39,7 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "qom/qom-qobject.h"
> +#include "qobject/qnum.h"
>   #include "trace.h"
>   
>   #define ACPI_PCIHP_SIZE 0x0018
> @@ -705,6 +706,63 @@ void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
>       aml_append(scope, dev);
>   }
>   
> +bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
> +{
> +    Aml *method;
> +    PCIBus *sec;
> +    QObject *bsel;
> +    int nr_notifiers = 0;
> +    GQueue *pcnt_bus_list = g_queue_new();
> +
> +    QLIST_FOREACH(sec, &bus->child, sibling) {
> +        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
> +        if (pci_bus_is_root(sec)) {
> +            continue;
> +        }
> +        nr_notifiers = nr_notifiers +
> +                       build_append_notification_callback(br_scope, sec);
> +        /*
> +         * add new child scope to parent
> +         * and keep track of bus that have PCNT,
> +         * bus list is used later to call children PCNTs from this level PCNT
> +         */
> +        if (nr_notifiers) {
> +            g_queue_push_tail(pcnt_bus_list, sec);
> +            aml_append(parent_scope, br_scope);
> +        }
> +    }
> +
> +    /*
> +     * Append PCNT method to notify about events on local and child buses.
> +     * ps: hostbridge might not have hotplug (bsel) enabled but might have
> +     * child bridges that do have bsel.
> +     */
> +    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> +
> +    /* If bus supports hotplug select it and notify about local events */
> +    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> +    if (bsel) {
> +        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> +
> +        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> +        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> +                                     aml_int(1))); /* Device Check */
> +        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> +                                     aml_int(3))); /* Eject Request */
> +        nr_notifiers++;
> +    }
> +
> +    /* Notify about child bus events in any case */
> +    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
> +        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
> +    }
> +
> +    aml_append(parent_scope, method);
> +    qobject_unref(bsel);
> +    g_queue_free(pcnt_bus_list);
> +    return !!nr_notifiers;
> +}
> +
>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>       .name = "acpi_pcihp_pci_status",
>       .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 87bb3d5cee..f08ce407c8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -563,64 +563,6 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>       }
>   }
>   
> -static bool build_append_notification_callback(Aml *parent_scope,
> -                                               const PCIBus *bus)
> -{
> -    Aml *method;
> -    PCIBus *sec;
> -    QObject *bsel;
> -    int nr_notifiers = 0;
> -    GQueue *pcnt_bus_list = g_queue_new();
> -
> -    QLIST_FOREACH(sec, &bus->child, sibling) {
> -        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
> -        if (pci_bus_is_root(sec)) {
> -            continue;
> -        }
> -        nr_notifiers = nr_notifiers +
> -                       build_append_notification_callback(br_scope, sec);
> -        /*
> -         * add new child scope to parent
> -         * and keep track of bus that have PCNT,
> -         * bus list is used later to call children PCNTs from this level PCNT
> -         */
> -        if (nr_notifiers) {
> -            g_queue_push_tail(pcnt_bus_list, sec);
> -            aml_append(parent_scope, br_scope);
> -        }
> -    }
> -
> -    /*
> -     * Append PCNT method to notify about events on local and child buses.
> -     * ps: hostbridge might not have hotplug (bsel) enabled but might have
> -     * child bridges that do have bsel.
> -     */
> -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> -
> -    /* If bus supports hotplug select it and notify about local events */
> -    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> -    if (bsel) {
> -        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> -
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> -        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> -                                     aml_int(1))); /* Device Check */
> -        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> -                                     aml_int(3))); /* Eject Request */
> -        nr_notifiers++;
> -    }
> -
> -    /* Notify about child bus events in any case */
> -    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
> -        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
> -    }
> -
> -    aml_append(parent_scope, method);
> -    qobject_unref(bsel);
> -    g_queue_free(pcnt_bus_list);
> -    return !!nr_notifiers;
> -}
> -
>   /*
>    * build_prt - Define interrupt routing rules
>    *


