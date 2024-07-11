Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B3C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuzV-0001C9-QS; Thu, 11 Jul 2024 10:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRuzU-00014F-0X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRuzQ-0007WM-VA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720708904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQvG4bHvdLuTzyeLIYzaG6MgAA4ua50MU08OE3lP1uA=;
 b=DZVTbgAN2nyaS3gecAKXGx7m7WhaGNHN7a82zL67dXi1uU0IY17Z61VDCGWVmd9NQqONyx
 dUQRJ6DAka1Gctv39bak3mhyUp3hRV7T7+Bp26t1quHyoqiDxm5RCIhP5LErHuoJ77vW8C
 RRzbW4aWsFCmwYjlqsXfxB0hBrjLHtc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-6WJVeGIPMjC1Avkm8NZTBw-1; Thu, 11 Jul 2024 10:41:42 -0400
X-MC-Unique: 6WJVeGIPMjC1Avkm8NZTBw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77af33ce50so86834466b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 07:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720708901; x=1721313701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQvG4bHvdLuTzyeLIYzaG6MgAA4ua50MU08OE3lP1uA=;
 b=tCEDk/hcGASmTbUtvtZ0kISk/L97aY2f0Pqijav6n9jXjxTEbIHJnrz9JDNnf1GTqP
 Zh6Yw85IPmCuatvalsTIqs1aqUgAfN12zpgypmxGoT9rc/i4H3AGmn6pkMdaGjfCKxn+
 IMas3knSpFXYNcMavWmuMkHWa9yLYBnvWDTUR45VDJO8NIZ0tdTSARXXMfCf5R+zav5I
 yqL1knwhvoojfeDhGdMU0u6LKgRJ/xdTOGdbADN6AiO97ystm1Q9DOH8X838ZNo/ZHYj
 JAmx5nTYtbpJfeQAVKLI/YNC+G4GeuJ2katk03kZSytiiZQyRZ+Jn4tCjOCrg+I2kSRj
 q6uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3mxuK0oWpGzrwcb+UdgtQtmnnOU4QRDzMZ05EjQJx6bpUOBpbHLI+6FlTkXBPBMOVc76h7Lbnw2s8oGipXQ/kjAIc4Fw=
X-Gm-Message-State: AOJu0Yx9vEhLykQkvlxB3Uvo6w6P5i48VtabXhq475GxKyjlHHm4S/lz
 891CVKO5NehZ4K3nOWSxUw0jfsGpUQ3ru1zIWA/OYpFXhRDFhm2mbRtsTkM8QLQC4ZBqcmk0RhD
 Ylbbcvgy5caSqWnAp6RD1uAxCtoh0z8b+X+JH8A2dlScrPSNRi3s3X0EWv9QR
X-Received: by 2002:a17:907:9492:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a780b6fd821mr861637966b.37.1720708900993; 
 Thu, 11 Jul 2024 07:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE50NxOxvL5/kH9awC5NL7GRlfLUOsz5YIl8AcS5rvyvHH/AeM+sONK/25m2M/Bklw1eIOQ4Q==
X-Received: by 2002:a17:907:9492:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a780b6fd821mr861634966b.37.1720708900435; 
 Thu, 11 Jul 2024 07:41:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6bcc2esm260656466b.8.2024.07.11.07.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:41:40 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:41:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/riscv/virt-acpi-build.c: Update the HID of
 RISC-V UART
Message-ID: <20240711104031-mutt-send-email-mst@kernel.org>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-3-sunilvl@ventanamicro.com>
 <20240711152512.5e2fac36@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711152512.5e2fac36@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 03:25:12PM +0200, Igor Mammedov wrote:
> On Mon,  8 Jul 2024 17:17:34 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > The RISC-V BRS specification [1] requires NS16550 compatible UART to
> > have the HID RSCV0003. So, update the HID for the UART.
> > 
> > [1] - https://github.com/riscv-non-isa/riscv-brs
> 
> it point's repo with a bunch of files,
> please make it easier for reader to find
> aka point to concrete document + title (for when link goes stale)
> and chapter. (similar to what we do for when documenting ACPI code)
> 
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/virt-acpi-build.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 87fe882af0..939f951e45 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> >                      uint32_t uart_irq)
> >  {
> >      Aml *dev = aml_device("COM0");
> > -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
> >      aml_append(dev, aml_name_decl("_UID", aml_int(0)));


In fact, adding the link to the document here would be best.
Pls link to the earliest version that lists this id,
cite version and chapter in the document.
Thanks!

> >  
> >      Aml *crs = aml_resource_template();


