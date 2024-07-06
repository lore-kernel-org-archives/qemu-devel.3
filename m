Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83846C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 13:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ5kb-0006Rp-Kj; Sat, 06 Jul 2024 09:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5ka-0006RX-Ta
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5kZ-0002Y1-1I
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720273609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI7oL77H2OxGrANkRenH/bPErLet3daUISM2dt/boU0=;
 b=U7WCV2E9pqVTVSASo82XTRjiKh2OQSv2FymC6P/OW7x/DEZGtKn9RiA8JTtlFdbrERnXJx
 JdWRE0lfMvToby7R1xdOcUNczsIPpiaI3N/xsDfTziZaHnzZev3vZUE9T4QccK/fHcRpZ/
 0wpjQvAYayO2xNEtJchJrkCuNVe5HXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-QcG3H4ZUNS-4KJJtmFZ1PQ-1; Sat, 06 Jul 2024 09:46:44 -0400
X-MC-Unique: QcG3H4ZUNS-4KJJtmFZ1PQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36794fcfdd6so1283691f8f.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 06:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720273603; x=1720878403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UI7oL77H2OxGrANkRenH/bPErLet3daUISM2dt/boU0=;
 b=NnU6pUDCR+3PeVMZLm4DhaFNB83QVr3icUm/PcSFhozYx+6RE7/dRMYjNTsJ/7NWx9
 5gvBDqvK5CVtSLDkh6hG1rFLXnFADAUvk1lA6QSmtJ5PsDIs5y3KeqdemTGbSjdPt97l
 7HRl0asPwfS+w43Gw3lVwE5QUOakQuiSNtk+VKrSkkOdhIfFgl8AbAm6xOU1CyCgjSwi
 aFv2tryo0m8XC3dY47Lp4dPivhjPFrnlgWatqQC/qea0CXBJ439HFXXT6RRK2FuzJ09b
 Mpur65YK3i5L56f1+VkpnRYN3QaLIbU8aAANG3SVsuCc9rJeVieColmhM1F4rJXzCL72
 7OzA==
X-Gm-Message-State: AOJu0Yw2Idxz40sVUhAlpSekvJT3sp5Og7JCHjr7ZWGY+V6X7ket6uai
 ebXQNONuuR3+d/df3zNpN3wRz1zcSOO/JzLR5xVXVXTg2MTZ0y/zRaRI9T1SPpAY4z1KlRulNP7
 cBBTL4JaKRpGw/uWHWvhHYipCPhLq9QFiHbOanoSy3TAmIbWBSUhc
X-Received: by 2002:a5d:458e:0:b0:362:3358:48d5 with SMTP id
 ffacd0b85a97d-3679dd65255mr4795507f8f.47.1720273603101; 
 Sat, 06 Jul 2024 06:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAZyp0MN4QZhXdaJmYE/No5U+WRA8wtS9Q855MZe1fVrPRMQ1e/rQ1PhXohARNHZocfWbwdA==
X-Received: by 2002:a5d:458e:0:b0:362:3358:48d5 with SMTP id
 ffacd0b85a97d-3679dd65255mr4795481f8f.47.1720273602616; 
 Sat, 06 Jul 2024 06:46:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679814a276sm7629625f8f.84.2024.07.06.06.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 06:46:42 -0700 (PDT)
Date: Sat, 6 Jul 2024 15:46:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <20240706154640.0a45c5d6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-4-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-4-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 7 Jun 2024 12:56:44 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
> _CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
> notified event by evaluating ACPI _EVT method to know the type of event. Use
> ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.
> 
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
>  hw/acpi/cpu.c                          |  6 +++++-
>  hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
>  include/hw/acpi/generic_event_device.h |  4 ++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>      return;
>  }
>  
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>  {
>      return;
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 69aaa563db..473b37ba88 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -221,7 +221,11 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>      const CPUArchIdList *id_list;
>      int i;
>  
> -    assert(mc->possible_cpu_arch_ids);
> +    /* hotplug might not be available for all types like x86/microvm etc. */
> +    if (!mc->possible_cpu_arch_ids) {
> +        return;
> +    }

if hotplug is not supported, this function shouldn't be called at all.

[...]
> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(sbd, &s->container_cpuhp);

> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);

suggest to move this call to realize time, and gate it on 
ACPI_GED_CPU_HOTPLUG_EVT being set.
Platform that supports cpu hotplug must optin, setting ACPI_GED_CPU_HOTPLUG_EVT,
while for the rest it will be ignored.

for example: create_acpi_ged() : event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;

>  }
>  
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce0214..90fc41cbb8 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>  #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>  
>  #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/ghes.h"
>  #include "qom/object.h"
> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -106,6 +108,8 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;


