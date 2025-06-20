Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6977C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSb18-0002mj-9v; Fri, 20 Jun 2025 08:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSb0s-0002ji-8O
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSb0n-00016K-5A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750423107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3bLo7hIKrLc57/oF3Sb/Ap/DFpOsCGkOd7xZprMPlc=;
 b=eQZF6FrWc+E2maccU3ghI1bC+n8zm51xykpK7tVFwHCOGLiClrQRuCunUzCx387/gy2ha3
 BduAAc4IxzCvOZ5kSXcVtLWxo5uRCd2eQwAF+3y8nyuRZC81N1kDjznnUadsZxXd2XB2zE
 WfuaaBnYjqZSSSms89uIkabe0XzLswU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-q2A306TxOV6S7PVWEfUejw-1; Fri, 20 Jun 2025 08:38:25 -0400
X-MC-Unique: q2A306TxOV6S7PVWEfUejw-1
X-Mimecast-MFC-AGG-ID: q2A306TxOV6S7PVWEfUejw_1750423105
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450787c8626so15319215e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750423104; x=1751027904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3bLo7hIKrLc57/oF3Sb/Ap/DFpOsCGkOd7xZprMPlc=;
 b=dHmFmCQOIS5xLE/JRyyzJBadsWywHm9Pt/eaD9ZeHy2mUeM7q+Ilnasu4tAp9B7C1a
 An8Y8usnPK8R+RDVHMLhJWzOEZIe9oBZFQG8/xHlgqI7EZEWHUTP9Owfe8QGLfNvI/QO
 Z+KJQe0ezdJHXYQdcRNxoTqYWAx3n54fK0EerdU0TWWHKdX0fN7B2HlCT52wwPVCPqOU
 klC49K9HT9lqRwsosLQp6O6wfmN9pFAW2PmEzKp/8CtH52g6DRdp9w4QvyyhwntGfypf
 lS2Qcm2RyYAiql6XedmNiXf8rRjIJVwn/VHKSubJdhPrls0fJKo+mw2v/PlDfTKaSlIB
 is2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKq8G3X20bMXoscj4pFVgOVV3AW5dLQQd/Tft204EhDkzG2Crn492uzFQ/qY47K/vERoWsusZwd26r@nongnu.org
X-Gm-Message-State: AOJu0YwHQIOfZHDYWu/nP9O5rxq377Y6bTi8Cq0zVCDtQvFzwwrL5wqL
 Md54PuykfAVlFSMVH9PJC5F6Q4tvGl+CU2fw++gMTpWkJxc3KfGSL/ZRLdYbROq+HAc6O/ZXUmH
 RjM9C0x/C+qMURrlMHdSxYp5/ZPtZPkEyahyiLP/HOVXGIr9dToXdBNsv
X-Gm-Gg: ASbGncvZLwC8Q4zq8Q6wk8G5QvxS9XxuulGXOTpU1QDFccqzqIZllWJ/HVq9r9zpmS5
 /taD425S+EBD6PqZYVLFG9fJviool0neLLrgQSToSvTaogJG/QANErrmPDmjUwvXaDsk/t9WR2D
 cPUpYgZzX8v5uwxzUqe2IBB7dOuYARY2neNNRWV5h54GWnEV35iaPrddqPaw3f3VTdbzht3DSk4
 avc24dHkswv08UJ6pE4pHw7CZd9aDE/lvns9zQaW9MXwTKrbuVJDTb7Jt8qhFhkHnGLH5yXLEs9
 zwHinsFzMhgP
X-Received: by 2002:a05:600c:314f:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-453656c313fmr22699805e9.28.1750423104510; 
 Fri, 20 Jun 2025 05:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFra9AlbK03qy26v8AN5rp2vztQmrbKOoHAeJlXPdJgSGbsH3P58/OnXTVWLfftXEUndWqYiA==
X-Received: by 2002:a05:600c:314f:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-453656c313fmr22699495e9.28.1750423104075; 
 Fri, 20 Jun 2025 05:38:24 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d133175bsm1975804f8f.92.2025.06.20.05.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:38:23 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:38:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 17/29] hw/arm/virt-acpi-build: Modify the DSDT ACPI
 table to enable ACPI PCI hotplug
Message-ID: <20250620143822.7ab69038@fedora>
In-Reply-To: <20250620103538.000021c1@huawei.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-18-eric.auger@redhat.com>
 <20250620103538.000021c1@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 20 Jun 2025 10:35:38 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Jun 2025 11:46:46 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Modify the DSDT ACPI table to enable ACPI PCI hotplug.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > 
> > ---
> > v2 -> v3:
> > - use ACPI_PCIHP_SIZE instead of 0x1000 (Igor)
> > - use cihp_state->use_acpi_hotplug_bridge  
> 
> pcihp_state
> 
> Takes a bit of searching to find the various bits of the
> same support on x86 but this seems to match up.
> Exactly when things are built does vary but not I think
> in a way that matters.  e.g. I think on x86 the
> EDSM stuff is built whether or not we have pcihp enabled
> whereas here you've made it conditional on using acpi
> hp.  Perhaps a tiny bit more description on that would be
> useful if you do a v4?

edsm should be built regardless of pcihp
(well intention was there, whether I messed it up or not I don't know)

idea is that non hotplug ports can have a static acpi-index,
so it doesn't depend on pcihp.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> 
> > ---
> >  include/hw/acpi/pcihp.h  |  2 ++
> >  include/hw/arm/virt.h    |  1 +
> >  hw/arm/virt-acpi-build.c | 22 ++++++++++++++++++++++
> >  hw/arm/virt.c            |  2 ++
> >  hw/arm/Kconfig           |  2 ++
> >  5 files changed, 29 insertions(+)
> > 
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index 5506a58862..9ff548650b 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -38,6 +38,8 @@
> >  #define ACPI_PCIHP_SEJ_BASE 0x8
> >  #define ACPI_PCIHP_BNMR_BASE 0x10
> >  
> > +#define ACPI_PCIHP_SIZE 0x0018
> > +
> >  typedef struct AcpiPciHpPciStatus {
> >      uint32_t up;
> >      uint32_t down;
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index 9a1b0f53d2..0ed2e6b732 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -79,6 +79,7 @@ enum {
> >      VIRT_ACPI_GED,
> >      VIRT_NVDIMM_ACPI,
> >      VIRT_PVTIME,
> > +    VIRT_ACPI_PCIHP,
> >      VIRT_LOWMEMMAP_LAST,
> >  };
> >  
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index d7547c8d3b..a2e58288f8 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -34,6 +34,7 @@
> >  #include "hw/core/cpu.h"
> >  #include "hw/acpi/acpi-defs.h"
> >  #include "hw/acpi/acpi.h"
> > +#include "hw/acpi/pcihp.h"
> >  #include "hw/nvram/fw_cfg_acpi.h"
> >  #include "hw/acpi/bios-linker-loader.h"
> >  #include "hw/acpi/aml-build.h"
> > @@ -809,6 +810,8 @@ static void
> >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >  {
> >      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> > +    AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
> > +    AcpiPciHpState *pcihp_state = &acpi_ged_state->pcihp_state;
> >      Aml *scope, *dsdt;
> >      MachineState *ms = MACHINE(vms);
> >      const MemMapEntry *memmap = vms->memmap;
> > @@ -868,6 +871,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >  
> >      aml_append(dsdt, scope);
> >  
> > +    if (pcihp_state->use_acpi_hotplug_bridge) {
> > +        Aml *pci0_scope = aml_scope("\\_SB.PCI0");
> > +
> > +        aml_append(pci0_scope, aml_pci_edsm());
> > +        build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
> > +                               memmap[VIRT_ACPI_PCIHP].base);
> > +        build_append_pcihp_resources(pci0_scope,
> > +                                     memmap[VIRT_ACPI_PCIHP].base,
> > +                                     memmap[VIRT_ACPI_PCIHP].size);
> > +
> > +        /* Scan all PCI buses. Generate tables to support hotplug. */
> > +        build_append_pci_bus_devices(pci0_scope, vms->bus);
> > +        if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
> > +            build_append_pcihp_slots(pci0_scope, vms->bus);
> > +        }
> > +        build_append_notification_callback(pci0_scope, vms->bus);
> > +        aml_append(dsdt, pci0_scope);
> > +    }
> > +
> >      /* copy AML table into ACPI tables blob */
> >      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> >    
> 


