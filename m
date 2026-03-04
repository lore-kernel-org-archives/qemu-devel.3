Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0648EB7EB8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkJo-0000me-OG; Wed, 04 Mar 2026 06:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkJi-0000mQ-NC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkJf-0001DO-Cn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772623377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xo3W1cRHp4zsDRrgPgVC6EcS4VmXWiNmHVj5tTAnKH0=;
 b=aSVypLOS/jFKf62zIvdEhizaWLmuo9e8nZVbkPzf68RfD6HGpj1P1LOxZjvCXAlhIjhZj1
 FAQxnqcwwtu6k6q54v+WAekhySA/OIRiDcySqydO5JX/A5j77LOA7EkanGSKrKVzHg53Eo
 4xAGfkyrXWzYH3OSt3blIZqmx6CdTOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-7eeqWVnEMcGPKeqo8rw5pQ-1; Wed, 04 Mar 2026 06:22:55 -0500
X-MC-Unique: 7eeqWVnEMcGPKeqo8rw5pQ-1
X-Mimecast-MFC-AGG-ID: 7eeqWVnEMcGPKeqo8rw5pQ_1772623375
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so69008275e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 03:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772623374; x=1773228174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo3W1cRHp4zsDRrgPgVC6EcS4VmXWiNmHVj5tTAnKH0=;
 b=riNGOHx9l/HIAIRwbxRrynZiFfvra8aVpuQSSZYzz8DeMJbi9nBeGUQlS6Lnjrbmkt
 RCxBclfNVMA4O9ExlbHjpVAbc3q3x9EjktN1W8iSVXN5RG/y24gaSMYXR9L5WJLx7mIy
 Q/m8l0bb/lgIvaBAe/UMVf8YkXVLpmmrNMEQ3OK3Miw7dvcKb62ZcL8D0r8crL288dYp
 179osDMoCYhRTb159UboSN8op67bYVEVgdGbgro5QvvgBKz+oydSJEd54W4GTO9u7MXP
 qfiZDIai+ASoPThPIAa0I8wPd1PX+wBDV6mZdOnxA1a7WjDlb8gsSyYQZYYQ2I+CYy5v
 rMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772623374; x=1773228174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xo3W1cRHp4zsDRrgPgVC6EcS4VmXWiNmHVj5tTAnKH0=;
 b=LchQ6/HptfTg1ArMexcMHmmjR+x2l4+h/Hd7X8BhI+VQ4ohA0zIvcQhG93SHh4XPUs
 9fcBWerT/nDhgCMmncMOPmKVvTgBp4lSRj5Exw17hgKTomOsYuK2Jw54NPXqLdtTQEr4
 rREYCIrzBQ2W/60oLYhZ7PyEFRcPweoczsHkEHRT4YzyXun4GKOGqHwznf51DPSiIdj3
 elzThLsouLfzCOSYJvoE8T4YNOJO/9Vcl1Pkphtyl/tIbyAElMJ050wC/wPDJkFk1cW7
 8Tj/27/QIS8q+RESEn8GZaCIn1eRdFdxLygdttUBp1T+56cXd0p3GyfHeKTbi+vmWCOF
 GQcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVInYDKeyc3Gn+PAnYd/bolDW73XZ2mxBuZKGCglsvlTD9sj18sEontDWgzux8QXrEh/eM3Dbnny4S/@nongnu.org
X-Gm-Message-State: AOJu0Yxpjfn0J7minMQ1gNpxyD/gfUUid79KCjO+GRf/T6t7LGWGpSwp
 YjjEUgDOdobDXo0K7z4ZWr7wVzqDkL3bDwrpW/b0tgs3YmVj6foRWomNyUQEdLByl6/J0Un+KdS
 C5gXVmHo1X+5H3dt3Wjdzrpb45f5jlrd0SPGKTSxBMpTEVIvDDCUjvrkJ
X-Gm-Gg: ATEYQzz/Yfg8vHS9g+5XrPw5hEtiaNmZCtXrzUhsBHAyGlH2cB49Tw1c9J5Eytjuh7Y
 hfEyGoPRrW1FBnV+4ROHzjDjPho6kHGbHnlAnCneSzDtdsYJfeWwFTsCCuJfhzOlhW7GnqjHI1k
 sb82Jm0yg1ytGoADSNJ42B1dEgAEU+6tyGPpbcMdF+5XEb1Gbn3XHIwiafgfPXs3rrIT1lC2Y0e
 c8jVgJjUsPBot8eRUaQcCywrsclnnMsQO9kp5w8u1xlsuMuRbfJHhKn5SiCyPaGG5bg9wfVdQVm
 WsivXn9QjZXBAFIj2lWiA4mZSsKQM2zbPYtf6XMdNu8S6bLqkODli2ifI5oZDcDOuWH2ts36jrK
 EGGO5rg==
X-Received: by 2002:a05:600c:8b53:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-48519895593mr25699625e9.24.1772623374455; 
 Wed, 04 Mar 2026 03:22:54 -0800 (PST)
X-Received: by 2002:a05:600c:8b53:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-48519895593mr25699085e9.24.1772623373924; 
 Wed, 04 Mar 2026 03:22:53 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a8aaa20sm17443995e9.2.2026.03.04.03.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 03:22:53 -0800 (PST)
Date: Wed, 4 Mar 2026 12:22:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Message-ID: <20260304122251.217cd93b@imammedo>
In-Reply-To: <20260227134611.1229390-5-mark.caveayland@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
 <20260227134611.1229390-5-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Feb 2026 13:44:58 +0000
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together.
> 
> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
> ISA serial IRQ is low true, edge sensitive and shareable, along with a
> corresponding _PRS resource so that the legacy serial ports also appear
> at a fixed address. This enables all 4 legacy serial ports to be used in
> Windows without conflict.

What happens if we just replace aml_irq_no_flags() with aml_irq()
(without compat knob and _PRS)

wrt _PRS could you elaborate some more why it's needed and what happens
if it doesn't exists?

> 
> Finally add a new x-acpi-shared-irq property to disable the ACPI IRQ descriptor
> changes for older PC machine types, and add it to the pc_compat_10_2[] array.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/char/serial-isa.c | 23 ++++++++++++++++++++++-
>  hw/i386/pc.c         |  4 +++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index a4be0492c5..1662da86bd 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "system/system.h"
>  #include "hw/acpi/acpi_aml_interface.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/char/serial.h"
>  #include "hw/char/serial-isa.h"
>  #include "hw/isa/isa.h"
> @@ -43,6 +44,7 @@ struct ISASerialState {
>      uint32_t index;
>      uint32_t iobase;
>      uint32_t isairq;
> +    bool acpi_shared_irq;
>      SerialState state;
>  };
>  
> @@ -92,7 +94,12 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +    if (isa->acpi_shared_irq) {
> +        aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
> +                                AML_SHARED));
> +    } else {
> +        aml_append(crs, aml_irq_no_flags(isa->isairq));
> +    }
>  
>      dev = aml_device("COM%d", isa->index + 1);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> @@ -100,6 +107,18 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>      aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
> +    if (isa->acpi_shared_irq) {
> +        Aml *prs = aml_resource_template();
> +
> +        aml_append(prs, aml_start_dependent_function(0, 0));
> +        aml_append(prs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,
> +                               0x08));
> +        aml_append(prs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
> +                                AML_SHARED));
> +        aml_append(prs, aml_end_dependent_function());
> +        aml_append(dev, aml_name_decl("_PRS", prs));
> +    }
> +
>      aml_append(scope, dev);
>  }
>  
> @@ -117,6 +136,8 @@ static const Property serial_isa_properties[] = {
>      DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
>      DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
>      DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
> +    DEFINE_PROP_BOOL("x-acpi-shared-irq", ISASerialState, acpi_shared_irq,
> +                     true),
>  };
>  
>  static void serial_isa_class_initfn(ObjectClass *klass, const void *data)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0dd3fd01d9..c0335b05ba 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -82,7 +82,9 @@
>      { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>      { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>  
> -GlobalProperty pc_compat_10_2[] = {};
> +GlobalProperty pc_compat_10_2[] = {
> +    { "isa-serial", "x-acpi-shared-irq", "false" },
> +};
>  const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
>  
>  GlobalProperty pc_compat_10_1[] = {


