Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B01C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 00:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlH3i-0000K9-C9; Thu, 20 Feb 2025 19:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlH3f-0000JI-IJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlH3c-00044u-TM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740098298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTn1LCk4GJoiCgYp7w6Sb2gUH187SBZedw8U53PVVhA=;
 b=WhCDbQBZRkCOO/Ycbm4UrWWxtXbffcEwyphyMiMHJ6KLgsNLEWeMrTOuhox+2QreAo3x6S
 yuuoxIy9WCkuQ2vXTgrJ7mEJ64X5w9i345S78YNSsz//74NstpwzxPI+a92sJaToOksce1
 YcTAcF2qeCw3ZLAcetiXlPdxFhW6ojA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-bXXfE9tWMMieoZBU0RjVJQ-1; Thu, 20 Feb 2025 19:38:16 -0500
X-MC-Unique: bXXfE9tWMMieoZBU0RjVJQ-1
X-Mimecast-MFC-AGG-ID: bXXfE9tWMMieoZBU0RjVJQ_1740098296
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb8e0944bfso159189866b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 16:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740098293; x=1740703093;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DTn1LCk4GJoiCgYp7w6Sb2gUH187SBZedw8U53PVVhA=;
 b=b/uPHX+5CT9on/QhArrOXFuXYL0QRVyTBTYy/Apcf+nMrbL2UQj5gaUoLHE5caWR6d
 NLDs+IN9svJJSi/D/9FgEGoAjz+Ja/KLEo2RWpiLhgtQqmtFN4A2xiDDYZmwpEAJN2Vm
 NsCsUhpFvaacw4QglHcah3lKy7JDuTxC4kA1JC5cN5duDIs29fJRKIXpA8o1vjBQ3qNx
 61NvBW5AXZkU6Os36yUsyWb1j9QvoTWLbi/axXzAnMUtTd4Qs6LW+8KWmQEvrlXXamAM
 HX2hMltM+JDl9hBE96KuB7Y3/98Xd4xYfOmIsR0eyj6yColptq9G/2EmEUzxvVHyg2Uz
 IIPA==
X-Gm-Message-State: AOJu0Yw7fPl0eL5I3d2sCmjUjoO6yi1zQprjJJxGnO5OoVolkjO54Pr1
 8ZHm1jpG+72mjg7ijvodxu3VE5v3diEbSlHPOcl1RDXvcXx/VXBGNgaoMj6HaL+/PDHFtMYRgsS
 9/+vKfT5QhhWgaaFW5qHFDKFFDVYjINhqt+LyhTeyKmvRXEuvb+5b
X-Gm-Gg: ASbGncsjETFmNlW+oSDdRIoExPiPQFIhpukxbHg9wa/sOr6Ka79zCVhNCUsXhXb9T3D
 7DftiQK13Sh63AZ5T5hN/G3ukjGTYUxtEtrxWjuc5ttdn7PtXL2+O5eRU2DY/BYuGpfq1C4K0V3
 017tazKIsgk/0Lytk3qIGZv6A3gQieHgMNZvZb1AVEWdv/2LLkr2tOVi7lKa4YlXpruJgwPmjSl
 /q07QHM/MRrPo/+6jWGTnAM2HmqjTnTZhQPqArbXPlkfZo6in+W/Zb2T21Rr+uG5QI+RA==
X-Received: by 2002:a17:906:30cf:b0:ab7:d537:91cb with SMTP id
 a640c23a62f3a-abc099bc179mr113762566b.7.1740098292652; 
 Thu, 20 Feb 2025 16:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrZDtZAjXcbgai/8/Tb5Cbb2TeVjAErX3qnmlsZ4JlEA+OpoIupzba5AXHD+lxut0i61HrZw==
X-Received: by 2002:a17:906:30cf:b0:ab7:d537:91cb with SMTP id
 a640c23a62f3a-abc099bc179mr113761466b.7.1740098292217; 
 Thu, 20 Feb 2025 16:38:12 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb4d3ef3c0sm1200446466b.41.2025.02.20.16.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 16:38:11 -0800 (PST)
Date: Thu, 20 Feb 2025 19:38:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 bsd@redhat.com, berrange@redhat.com, joao.m.martins@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from
 amd-iommu device to allow full control over the PCI device creation
Message-ID: <20250220193726-mutt-send-email-mst@kernel.org>
References: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
 <20250212054450.578449-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212054450.578449-2-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 12, 2025 at 05:44:49AM +0000, Suravee Suthikulpanit wrote:
> Current amd-iommu model internally creates an AMDVI-PCI device. Here is
> a snippet from info qtree:
> 
>   bus: main-system-bus
>     type System
>     dev: amd-iommu, id ""
>       xtsup = false
>       pci-id = ""
>       intremap = "on"
>       device-iotlb = false
>       pt = true
>     ...
>     dev: q35-pcihost, id ""
>       MCFG = -1 (0xffffffffffffffff)
>       pci-hole64-size = 34359738368 (32 GiB)
>       below-4g-mem-size = 134217728 (128 MiB)
>       above-4g-mem-size = 0 (0 B)
>       smm-ranges = true
>       x-pci-hole64-fix = true
>       x-config-reg-migration-enabled = true
>       bypass-iommu = false
>       bus: pcie.0
>         type PCIE
>         dev: AMDVI-PCI, id ""
>           addr = 01.0
>           romfile = ""
>           romsize = 4294967295 (0xffffffff)
>           rombar = -1 (0xffffffffffffffff)
>           multifunction = false
>           x-pcie-lnksta-dllla = true
>           x-pcie-extcap-init = true
>           failover_pair_id = ""
>           acpi-index = 0 (0x0)
>           x-pcie-err-unc-mask = true
>           x-pcie-ari-nextfn-1 = false
>           x-max-bounce-buffer-size = 4096 (4 KiB)
>           x-pcie-ext-tag = true
>           busnr = 0 (0x0)
>           class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)
> 
> This prohibits users from specifying the PCI topology for the amd-iommu device,
> which becomes a problem when trying to support VM migration since it does not
> guarantee the same enumeration of AMD IOMMU device.
> 
> Therfore, decouple the AMDVI-PCI from amd-iommu device and introduce pci-id
> parameter to link between the two devices.
> 
> For example:
>   -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
>   -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \
> 
> For backward-compatibility, internally create the AMDVI-PCI device if not
> specified on the CLI.
> 
> Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>


breaks build:

https://gitlab.com/mstredhat/qemu/-/jobs/9202802751

	./hw/i386/amd_iommu.c: In function ‘amdvi_sysbus_realize’:
../hw/i386/amd_iommu.c:1616:18: error: unused variable ‘dc’ [-Werror=unused-variable]
 1616 |     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
      |                  ^~
cc1: all warnings being treated as errors



> ---
>  hw/i386/acpi-build.c |  8 +++----
>  hw/i386/amd_iommu.c  | 53 +++++++++++++++++++++++++++-----------------
>  hw/i386/amd_iommu.h  |  3 ++-
>  3 files changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 53b7306b43..e70eeaf577 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2333,10 +2333,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>      /* DeviceID */
>      build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(&s->pci), "addr",
> +                              object_property_get_int(OBJECT(s->pci), "addr",
>                                                        &error_abort), 2);
>      /* Capability offset */
> -    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
> +    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */
>      build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
>      /* PCI Segment Group */
> @@ -2368,10 +2368,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>      /* DeviceID */
>      build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(&s->pci), "addr",
> +                              object_property_get_int(OBJECT(s->pci), "addr",
>                                                        &error_abort), 2);
>      /* Capability offset */
> -    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
> +    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */
>      build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
>      /* PCI Segment Group */
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 6b13ce894b..0f552bafa0 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -167,11 +167,11 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
>  {
>      MSIMessage msg = {};
>      MemTxAttrs attrs = {
> -        .requester_id = pci_requester_id(&s->pci.dev)
> +        .requester_id = pci_requester_id(&s->pci->dev)
>      };
>  
> -    if (msi_enabled(&s->pci.dev)) {
> -        msg = msi_get_message(&s->pci.dev, 0);
> +    if (msi_enabled(&s->pci->dev)) {
> +        msg = msi_get_message(&s->pci->dev, 0);
>          address_space_stl_le(&address_space_memory, msg.address, msg.data,
>                               attrs, NULL);
>      }
> @@ -239,7 +239,7 @@ static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
>      info |= AMDVI_EVENT_IOPF_I | AMDVI_EVENT_IOPF;
>      amdvi_encode_event(evt, devid, addr, info);
>      amdvi_log_event(s, evt);
> -    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
> +    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
>              PCI_STATUS_SIG_TARGET_ABORT);
>  }
>  /*
> @@ -256,7 +256,7 @@ static void amdvi_log_devtab_error(AMDVIState *s, uint16_t devid,
>  
>      amdvi_encode_event(evt, devid, devtab, info);
>      amdvi_log_event(s, evt);
> -    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
> +    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
>              PCI_STATUS_SIG_TARGET_ABORT);
>  }
>  /* log an event trying to access command buffer
> @@ -269,7 +269,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
>  
>      amdvi_encode_event(evt, 0, addr, info);
>      amdvi_log_event(s, evt);
> -    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
> +    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
>              PCI_STATUS_SIG_TARGET_ABORT);
>  }
>  /* log an illegal command event
> @@ -310,7 +310,7 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
>      info |= AMDVI_EVENT_PAGE_TAB_HW_ERROR;
>      amdvi_encode_event(evt, devid, addr, info);
>      amdvi_log_event(s, evt);
> -    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
> +    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
>               PCI_STATUS_SIG_TARGET_ABORT);
>  }
>  
> @@ -1607,26 +1607,45 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>  {
>      AMDVIState *s = AMD_IOMMU_DEVICE(dev);
>  
> -    msi_reset(&s->pci.dev);
> +    msi_reset(&s->pci->dev);
>      amdvi_init(s);
>  }
>  
>  static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>  {
> +    DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
>      AMDVIState *s = AMD_IOMMU_DEVICE(dev);
>      MachineState *ms = MACHINE(qdev_get_machine());
>      PCMachineState *pcms = PC_MACHINE(ms);
>      X86MachineState *x86ms = X86_MACHINE(ms);
>      PCIBus *bus = pcms->pcibus;
>  
> -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> -                                     amdvi_uint64_equal, g_free, g_free);
> +    if (s->pci_id) {
> +        PCIDevice *pdev = NULL;
> +        int ret = pci_qdev_find_device(s->pci_id, &pdev);
>  
> -    /* This device should take care of IOMMU PCI properties */
> -    if (!qdev_realize(DEVICE(&s->pci), &bus->qbus, errp)) {
> -        return;
> +        if (ret) {
> +            error_report("Cannot find PCI device '%s'", s->pci_id);
> +            return;
> +        }
> +
> +        if (!object_dynamic_cast(OBJECT(pdev), TYPE_AMD_IOMMU_PCI)) {
> +            error_report("Device '%s' must be an AMDVI-PCI device type", s->pci_id);
> +            return;
> +        }
> +
> +        s->pci = AMD_IOMMU_PCI(pdev);
> +    } else {
> +        s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
> +        /* This device should take care of IOMMU PCI properties */
> +        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
> +            return;
> +        }
>      }
>  
> +    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> +                                     amdvi_uint64_equal, g_free, g_free);
> +
>      /* Pseudo address space under root PCI bus. */
>      x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
>  
> @@ -1663,6 +1682,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>  
>  static const Property amdvi_properties[] = {
>      DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
> +    DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
>  };
>  
>  static const VMStateDescription vmstate_amdvi_sysbus = {
> @@ -1670,12 +1690,6 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
>      .unmigratable = 1
>  };
>  
> -static void amdvi_sysbus_instance_init(Object *klass)
> -{
> -    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
> -
> -    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
> -}
>  
>  static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
>  {
> @@ -1698,7 +1712,6 @@ static const TypeInfo amdvi_sysbus = {
>      .name = TYPE_AMD_IOMMU_DEVICE,
>      .parent = TYPE_X86_IOMMU_DEVICE,
>      .instance_size = sizeof(AMDVIState),
> -    .instance_init = amdvi_sysbus_instance_init,
>      .class_init = amdvi_sysbus_class_init
>  };
>  
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index e0dac4d9a9..ece71ff0b6 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -315,7 +315,8 @@ struct AMDVIPCIState {
>  
>  struct AMDVIState {
>      X86IOMMUState iommu;        /* IOMMU bus device             */
> -    AMDVIPCIState pci;          /* IOMMU PCI device             */
> +    AMDVIPCIState *pci;         /* IOMMU PCI device             */
> +    char *pci_id;               /* ID of AMDVI-PCI device, if user created */
>  
>      uint32_t version;
>  
> -- 
> 2.34.1


