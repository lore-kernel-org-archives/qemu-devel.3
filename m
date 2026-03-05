Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58929F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy88s-0008Ot-1w; Thu, 05 Mar 2026 07:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy88o-0008OV-Qa
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vy88m-00048l-Ml
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772714959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKa/uYwe7FzEpkB8Ki2op6B+BxhKs0XUF7f90olM6qA=;
 b=Lah7OEKK0/srdz5FT4AazhJceR9AA+cDifM4pGDvgaMY8zZCgLEwaJLhks80q/gVYbRFBG
 ul7AvLUDWYh9eRd94J6nM7hgzQYKLiHX+GYk2jfgjoZq0ad/KxDbICgC+vyqc23iWB6Fq/
 3p3VmFDjXxnPwaE3f6lw70JaTV3Ip1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-6ZbzMLueNVSHQZP9290T3Q-1; Thu, 05 Mar 2026 07:49:17 -0500
X-MC-Unique: 6ZbzMLueNVSHQZP9290T3Q-1
X-Mimecast-MFC-AGG-ID: 6ZbzMLueNVSHQZP9290T3Q_1772714957
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so1757391f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772714956; x=1773319756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKa/uYwe7FzEpkB8Ki2op6B+BxhKs0XUF7f90olM6qA=;
 b=rTcZj0u1Sy9e0GAvxcH973oxxbPDJ2hPdA9XGvT5HxxLS3v2Y7U9fRbiwZnxKjxMuN
 gfEiFdlE7CcjIDWEMJhGBulKEk3fYSaM2HlBLdZ8yRwDniXfbnkBhQteNb2/omYGqBkN
 zNHDm9q11YFpnaVRg1K0pAjsEXP+0+ZqaKKDZ9DcEh1KOKxKw7OunE+4+Fe3z0TraZ5F
 Jqh0h3L4ig7pOgLU4FngK0/HSHOW4yftCHwquY5svAMveCraJeAcBMzCQvi4lp09KK5f
 I99B40PZ4eJxWht+hV2l0JG+wU4fDFs9j0zEdjvJWJ7a6NyPrb/RlwkmUuHSNXU94QsL
 W0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772714956; x=1773319756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKa/uYwe7FzEpkB8Ki2op6B+BxhKs0XUF7f90olM6qA=;
 b=C4JPxmQNfGD1pnnEzfzxmhQ9ng0PL7nLwNu7AJHRxAu58OGZW1lAuQqtYo+Ucly495
 XZoryFx67nDzEESiaiV5msC+hX+p2Y+sZOOAUy8puRA8a+rPMs5GSYg3bVba1T1XkXYh
 +mCuGM17xxm9wcpUhb/B8vFXqRP52/0ODC3X2JqG7g8+24WYCwgOe5Sa9IEIMdWqzMAF
 vK/BtKDUZ/0Jb6IzzCrmYF6FY1XPmL24WP7r49A8Oj0lX2NdIsJFB60ZCBYCwDLM2fYB
 4bLRBDBgRvEkZjewzvjKpk9NLKacQCgVJ4WzgA/gFja4G64bXDg16/K6M2htbk6Hz0gr
 33HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfpO+f9KkF/qvof0mxUlc+Xay5as+rv6aHdsmFqAxESk5aOgRFRMDom6VgFA83xo6j1Lq9SO598Q/t@nongnu.org
X-Gm-Message-State: AOJu0YygWIbvwBtzwbrvtUJcmfwxNWCAX1Z2S0MoBqjTJBsmSPpilNvj
 R7COoytdT8e05E7fEjgxNU2/K56duC1id9fCH6LoLWaQn+V8owG/rOi2m5HK1TtT0f6OF0ZwNrG
 TKfhMwBa6E4lM3ONOmQ67XwyeYJQhhzUbCZYcjwHWzJjacfa7XAeoinek
X-Gm-Gg: ATEYQzwn5DCqLx4zH3FuyzDvEylyoki06XNKcEZZSdSy9n+M7mjy7QO7ZLpU9h/T4LQ
 xyZg5q3zqnuNlHJa7bzxFyJEj3+My6t58x/GEoRDHgg1WCNr/JZ9HZCk3trdYV4ALnEaO1dAtC+
 15HMWxx/ZUtwb4JCf3UuEoZBk+qCNqjFAcDqMLC6buv9x/kgGFV+2ud8mcUjS2sx9yFHr/aSRNA
 XSJvBqzkCj/hZCOq5CJDRhPQD404ylUwSex1Es5Cyyw6QHNxcn53Bk0JQjLVwbsQv7CsxzQhnlY
 03cyeE6I7pEPAAWSokd0TLq99F9uvmQ58pVg9S35sYj8el1fa3HWVnLYvJsh4KzKCCZvcxJmOug
 3z84lIw==
X-Received: by 2002:a05:6000:268a:b0:439:ae82:6aa7 with SMTP id
 ffacd0b85a97d-439c8008fb9mr10291830f8f.30.1772714956467; 
 Thu, 05 Mar 2026 04:49:16 -0800 (PST)
X-Received: by 2002:a05:6000:268a:b0:439:ae82:6aa7 with SMTP id
 ffacd0b85a97d-439c8008fb9mr10291772f8f.30.1772714955899; 
 Thu, 05 Mar 2026 04:49:15 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm36445902f8f.28.2026.03.05.04.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 04:49:15 -0800 (PST)
Date: Thu, 5 Mar 2026 13:49:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Message-ID: <20260305134913.78e63dd0@imammedo>
In-Reply-To: <c578ab0a-d8b8-4474-8d5b-538a26a85c85@nutanix.com>
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
 <20260227134611.1229390-5-mark.caveayland@nutanix.com>
 <20260304122251.217cd93b@imammedo>
 <c578ab0a-d8b8-4474-8d5b-538a26a85c85@nutanix.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Wed, 4 Mar 2026 14:36:14 +0000
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 04/03/2026 11:22, Igor Mammedov wrote:
> 
> > On Fri, 27 Feb 2026 13:44:58 +0000
> > Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> >   
> >>  From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> >> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> >> Descriptor is used then the interrupt is considered to be high true, edge
> >> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> >> an IRQ then if more than 2 serial ports are added, Windows indicates a
> >> conflict in Device Manager and these combinations cannot be used together.
> >>
> >> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
> >> ISA serial IRQ is low true, edge sensitive and shareable, along with a
> >> corresponding _PRS resource so that the legacy serial ports also appear
> >> at a fixed address. This enables all 4 legacy serial ports to be used in
> >> Windows without conflict.  
> > 
> > What happens if we just replace aml_irq_no_flags() with aml_irq()
> > (without compat knob and _PRS)
> > 
> > wrt _PRS could you elaborate some more why it's needed and what happens
> > if it doesn't exists?  
> 
> Good question. I based the implementation on the technote from Microchip 
> at https://ww1.microchip.com/downloads/en/DeviceDoc/00001879A.pdf and 
> found that it worked fine here on Windows 11.
> 
> My concern from deviating from the document would be that any changes 
> would work fine on Windows 11, but then fail on older versions of Windows.
> 
> I can try and locate a copy of Windows 8.1 internally if you still think 
> that is worth pursuing?

with _CRS present, I don't think we need _PRS especially in absence of _SRS
and means to actually changes used IRQs/IO.

What I'd like to avoid is adding not needed code and compat logic
if it's possible.
The later unfortunately achievable only by tedious testing of
the change with older Windows versions (the older it is,
the more loose spec interperetation).

> 
> >> Finally add a new x-acpi-shared-irq property to disable the ACPI IRQ descriptor
> >> changes for older PC machine types, and add it to the pc_compat_10_2[] array.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >> ---
> >>   hw/char/serial-isa.c | 23 ++++++++++++++++++++++-
> >>   hw/i386/pc.c         |  4 +++-
> >>   2 files changed, 25 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> >> index a4be0492c5..1662da86bd 100644
> >> --- a/hw/char/serial-isa.c
> >> +++ b/hw/char/serial-isa.c
> >> @@ -28,6 +28,7 @@
> >>   #include "qemu/module.h"
> >>   #include "system/system.h"
> >>   #include "hw/acpi/acpi_aml_interface.h"
> >> +#include "hw/acpi/aml-build.h"
> >>   #include "hw/char/serial.h"
> >>   #include "hw/char/serial-isa.h"
> >>   #include "hw/isa/isa.h"
> >> @@ -43,6 +44,7 @@ struct ISASerialState {
> >>       uint32_t index;
> >>       uint32_t iobase;
> >>       uint32_t isairq;
> >> +    bool acpi_shared_irq;
> >>       SerialState state;
> >>   };
> >>   
> >> @@ -92,7 +94,12 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
> >>   
> >>       crs = aml_resource_template();
> >>       aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
> >> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
> >> +    if (isa->acpi_shared_irq) {
> >> +        aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
> >> +                                AML_SHARED));
> >> +    } else {
> >> +        aml_append(crs, aml_irq_no_flags(isa->isairq));
> >> +    }
> >>   
> >>       dev = aml_device("COM%d", isa->index + 1);
> >>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> >> @@ -100,6 +107,18 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
> >>       aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> >>       aml_append(dev, aml_name_decl("_CRS", crs));
> >>   
> >> +    if (isa->acpi_shared_irq) {
> >> +        Aml *prs = aml_resource_template();
> >> +
> >> +        aml_append(prs, aml_start_dependent_function(0, 0));
> >> +        aml_append(prs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,
> >> +                               0x08));
> >> +        aml_append(prs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
> >> +                                AML_SHARED));
> >> +        aml_append(prs, aml_end_dependent_function());
> >> +        aml_append(dev, aml_name_decl("_PRS", prs));
> >> +    }
> >> +
> >>       aml_append(scope, dev);
> >>   }
> >>   
> >> @@ -117,6 +136,8 @@ static const Property serial_isa_properties[] = {
> >>       DEFINE_PROP_UINT32("index",  ISASerialState, index,   -1),
> >>       DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
> >>       DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
> >> +    DEFINE_PROP_BOOL("x-acpi-shared-irq", ISASerialState, acpi_shared_irq,
> >> +                     true),
> >>   };
> >>   
> >>   static void serial_isa_class_initfn(ObjectClass *klass, const void *data)
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 0dd3fd01d9..c0335b05ba 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -82,7 +82,9 @@
> >>       { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
> >>       { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
> >>   
> >> -GlobalProperty pc_compat_10_2[] = {};
> >> +GlobalProperty pc_compat_10_2[] = {
> >> +    { "isa-serial", "x-acpi-shared-irq", "false" },
> >> +};
> >>   const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
> >>   
> >>   GlobalProperty pc_compat_10_1[] = {  
> 
> 
> ATB,
> 
> Mark.
> 


