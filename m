Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB7C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAFA-0001JF-D3; Fri, 28 Jun 2024 07:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sNAF2-0001Ik-8q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sNAEz-0001nZ-N7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719575888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEfstQABPqKvB1S1Gl8bwJoQoa3c+s2N0zFlX7e5uSE=;
 b=S43jrmTu03cqJ3Q5xX8cciPEe7OowXc57DcwZTpsq3hlu3cGzi5Atgql/JBCjqnOvGf7K4
 njs7el8n4RMLl67o0Ll9Ryagc5HqLsT4X0j5M7Ayecf5hcsd0W1fkK9swdxEmlYzLsHqz0
 Zi9ini1jEvW2M43ZrXS+6Au989UrOkM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-k0cJEjywOE-9-43_hZpVKA-1; Fri, 28 Jun 2024 07:58:07 -0400
X-MC-Unique: k0cJEjywOE-9-43_hZpVKA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-366e84fbd4bso525039f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719575886; x=1720180686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEfstQABPqKvB1S1Gl8bwJoQoa3c+s2N0zFlX7e5uSE=;
 b=kwHZwT65EihleXMvePE1eDKwxy6f5g53v4o13pYueGB06kqevvhs1TcFkWVmXdpXuI
 iKCOTOdgcclifU06egma09dJYr8U1tgRVWTvCCyEb2GIMUVbGit+sAG8qsOOmj+bmLWl
 MdmyfEj93BI+K7kM5J4cmLGVwiVYeMbzaXjHcE+KCKZpdkSqCF8evrWrudt+VkrIuz6c
 ljkeg99P82VBv1+8Cg9QbcPePQ1Moql66R6Wig7vZ07Gu7O+DmDj5YPIKfxpBifZ6Ary
 QXkM/e7O3Ft8v4hb29vL76VeRuOz9LPT3Yyv8GPDYhrtYnJ8mtEt/wHVwhbGGd+TOyzz
 JNmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSvOdBSYcA9fMrx1ipYA49bI6T1DgFOBN1HvH/N7Zgz92CXmch61lsJJu0JohlwvOFTjYdxB1fjV5cFJneAKjwSsQFJrU=
X-Gm-Message-State: AOJu0YyB8lNaM3QHRfzzEwWfePjhS/nzariq1P/17mlHBV5LhKw7gWYS
 qMWTQVgGzt/uv72If9aBvzcN2LA+wy8nyTSk0ozsmXrYbog4LcoIqZLJn2MSOpNVQAQ/6udyPBr
 iW/TOYewnEcxD38NnnnXjyum3MflLCBR97XiLbJCSw3RuSUAVq0TP
X-Received: by 2002:a05:6000:1886:b0:366:e90f:3763 with SMTP id
 ffacd0b85a97d-366e90f38bfmr13864834f8f.8.1719575886267; 
 Fri, 28 Jun 2024 04:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwbs7bpE3ojA+ickRy/M98hlMD9uB6cmDG5H5mROkctUFckzPhlywwpHrz4/d52B/f7ubDsg==
X-Received: by 2002:a05:6000:1886:b0:366:e90f:3763 with SMTP id
 ffacd0b85a97d-366e90f38bfmr13864816f8f.8.1719575885840; 
 Fri, 28 Jun 2024 04:58:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9f9dsm2104409f8f.41.2024.06.28.04.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:58:05 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:58:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
 <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

On Thu, 27 Jun 2024 15:09:12 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:13 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Using a property allows us to hide the internal details of the PCI device
> > from the code to build a SRAT Generic Initiator Affinity Structure with
> > PCI Device Handle.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > V3: New patch
> > ---
> >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> >  hw/pci/pci.c                     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 73bafaaaea..34284359f0 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -9,6 +9,7 @@
> >  #include "hw/boards.h"
> >  #include "hw/pci/pci_device.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> >  
> >  typedef struct AcpiGenericInitiatorClass {
> >      ObjectClass parent_class;
> > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >      MachineState *ms = MACHINE(qdev_get_machine());
> >      AcpiGenericInitiator *gi;
> >      GArray *table_data = opaque;
> > -    PCIDevice *pci_dev;
> > +    uint8_t bus, devfn;
> >      Object *o;
> >  
> >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >          exit(1);
> >      }
> >  
> > -    pci_dev = PCI_DEVICE(o);
> > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > -                                     pci_dev->devfn);
> > +    bus = object_property_get_uint(o, "bus", &error_fatal);
> > +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> > +
> > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> >  
> >      return 0;
> >  }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 324c1302d2..b4b499b172 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >  static void pcibus_reset_hold(Object *obj, ResetType type);
> >  static bool pcie_has_upstream_port(PCIDevice *dev);
> >  
> > +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> > +                             void *opaque, Error **errp)
> > +{
> > +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> > +
> > +    visit_type_uint8(v, name, &bus, errp);
> > +}
> > +
> > +static const PropertyInfo prop_pci_bus = {
> > +    .name = "bus",  
> 
> /me confused,
> didn't we have 'bus' property for PCI devices already?
> 
> i.e. I can add PCI device like this
>   -device e1000,bus=pci.0,addr=0x6,...

to avoid confusion, I'd suggest to name it to 'busnr'
(or be more specific (primary|secondary)_busnr if applicable)

>   
> 
> > +    .get = prop_pci_bus_get,
> > +};
> > +
> >  static Property pci_props[] = {
> >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    { .name = "bus", .info = &prop_pci_bus },
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >    
> 


