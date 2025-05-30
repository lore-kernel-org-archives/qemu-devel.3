Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC1C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyaY-0001SS-19; Fri, 30 May 2025 08:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyaU-0001Qu-FS
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyaS-0005IA-IE
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748607107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOXFNxEr+Ox+OIhSNnPCM7SMU40zVSyxunLTDAFk2og=;
 b=A4AIa8tWoQV423vtSOE/uZWP36Gw0GuJAc6m7mID+qqAgt9NGj5Mm3tRbu+E5U7SOIJCyT
 oTatI/wYtskORrQQ7LVZDq1X2k+8FlT4U0kkJJh2ac7/Ivmrv0KoDNwrpiDkGEOiG5bIKs
 Rkw0DozU3qErUrFTsuo+zNY2IO5JeM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ouvNxY_LMtSH_p5Jn1_4uw-1; Fri, 30 May 2025 08:11:46 -0400
X-MC-Unique: ouvNxY_LMtSH_p5Jn1_4uw-1
X-Mimecast-MFC-AGG-ID: ouvNxY_LMtSH_p5Jn1_4uw_1748607105
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cec217977so12784275e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748607105; x=1749211905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOXFNxEr+Ox+OIhSNnPCM7SMU40zVSyxunLTDAFk2og=;
 b=Jqnm55dWJsHZhUWIFJi7p/NFQVUFt1mqEld6h5zLziK/UmpRfjQe+wg+vfLCYCrQLT
 s5PRUH00+Yq54aERJm4jjIkPwzj7fh0/1jJVw0JN/NZ8B4JBeJOWYdCVzgCV9ZIhVNp1
 RJdJD4Bm42QBpy6enmSRQvSuYdU6bMSqcl5e08NQeuwNQZCRAgHDwxN70Xu+zv7chibI
 e7fGXYWpzX/Rx5Dc/j5Q5MdmwnsijTg/03xv8BrKltqtLz+VqEqBaA/ELxx8Yh3vQMFh
 H6628e2cHaDq+lVaqj+W29WjGWN7ZZmdWY+zCfxNAPuAMvDd055uQbPCgiOZ6QRnab8P
 wOmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTKRtp69J3J/LdGuCzjDT0wHxpKGziH4iIRC5SRkUSP8JBr5fYDoiZmM4Et1vWVthUEKGun7LwX/X1@nongnu.org
X-Gm-Message-State: AOJu0YzM67ZjyB2+8o96G7Ac3wM5WWb5s3kLrL7oYcuO9beepXAXh2Y4
 Ms3K3X7yr1/wxPYfcaJ+OzuTJ7f7Ce6pkwXWJrRiCjGYQCRJhWNuGzKnQnSfTSCAhqiHgL8p5gb
 L5E/Y53eC7BY/4RPhbAWlwcNJVyxXvj0UKdO+e9oMyxJCbPXIDnKgRA3D
X-Gm-Gg: ASbGncvy6eVgGVVKHGKgeFts0QxxY/6oefTL8NXQczsKq/ofopTKdGBtGyRb24QrcX5
 p0NN4xfFBJaO0IctLPVNfUwHQpaUw0s1W3suYWFcnC3nIMAKgz8gYf/aTV4kXNRSKAbeB5J4AGJ
 7mHo2o9/sWroRucNx4xFReU1x7vObNI2iQcEeU3qsISJm11xt8gZ+7aZOO7pjnM/P2t8a7YSwLS
 83yJLch8BsCN4oQrJY5nQCa/ad4Va9oFlIGnrAh+LRO92u4Ol8qJNSxmL/Fhze/9t+PQtH0rrKi
 Yq77iLR8T1O351IOZ5YoWc77QThvhXrL
X-Received: by 2002:a05:600c:3b0f:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-450d884c411mr19886665e9.15.1748607105313; 
 Fri, 30 May 2025 05:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2CgH1TRjUUcnzhKpGV6wb4WRMQ5d9T6p9MjJfBE8JPzbIqJTRJwOVFP1thHl8M9NjFjC+Eg==
X-Received: by 2002:a05:600c:3b0f:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-450d884c411mr19886335e9.15.1748607104885; 
 Fri, 30 May 2025 05:11:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e3esm16552325e9.22.2025.05.30.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:11:44 -0700 (PDT)
Date: Fri, 30 May 2025 14:11:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 06/25] hw/pci-host/gpex-acpi: Propagate hotplug type
 info from virt machine downto gpex
Message-ID: <20250530141143.6b13376b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250530111413.00003c66@huawei.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-7-eric.auger@redhat.com>
 <20250530111413.00003c66@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Fri, 30 May 2025 11:14:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 27 May 2025 09:40:08 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Propagate the type of pci hotplug mode downto the gpex
> > acpi code. In case machine acpi_pcihp is unset we configure
> > pci native hotplug on pci0. For expander bridges we keep
> > legacy pci native hotplug, as done on x86 q35.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> > ---
> >  include/hw/pci-host/gpex.h | 1 +
> >  hw/arm/virt-acpi-build.c   | 1 +
> >  hw/pci-host/gpex-acpi.c    | 3 ++-
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> > index 84471533af..feaf827474 100644
> > --- a/include/hw/pci-host/gpex.h
> > +++ b/include/hw/pci-host/gpex.h
> > @@ -45,6 +45,7 @@ struct GPEXConfig {
> >      MemMapEntry pio;
> >      int         irq;
> >      PCIBus      *bus;
> > +    bool        pci_native_hotplug;
> >  };
> >  
> >  typedef struct GPEXIrq GPEXIrq;
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 7e8e0f0298..be5e00a56e 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -129,6 +129,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> >          .ecam   = memmap[ecam_id],
> >          .irq    = irq,
> >          .bus    = vms->bus,
> > +        .pci_native_hotplug = !vms->acpi_pcihp,
> >      };
> >  
> >      if (vms->highmem_mmio) {
> > diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> > index 1aa2d12026..f1ab30f3d5 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -204,6 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >              if (is_cxl) {
> >                  build_cxl_osc_method(dev);
> >              } else {
> > +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
> >                  acpi_dsdt_add_host_bridge_methods(dev, true);  
> 
> This is awkward but explains why my CXL cases weren't causing trouble.
> A mixed config is counter to the recommendation in the PCI firmware spec
> 
> "It is recommended that a machine with multiple host bridge devices should
> report the same capabilities for all host bridges of the same type and also
> negotiate control of the features described in the Control Field in the
> same way for all host bridges of the same type"
> 
> I guess if any OS isn't coping with the mix then they can request native
> hotplug.

guest should be able to cope with mixed configs,
ACPI pcihp is a crutch and works only for coldplugged bridges,
while hotplugged bridges are handled by native hotplug.

> 
> 
> 
> >              }
> >  
> > @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >      }
> >      aml_append(dev, aml_name_decl("_CRS", rbuf));
> >  
> > -    acpi_dsdt_add_host_bridge_methods(dev, true);
> > +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
> >  
> >      Aml *dev_res0 = aml_device("%s", "RES0");
> >      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));  
> 


