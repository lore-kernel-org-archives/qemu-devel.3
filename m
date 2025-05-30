Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A65C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyUk-00077C-II; Fri, 30 May 2025 08:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyUh-00074s-I3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyUK-0004ak-2m
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748606720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KgZGfKxKfVm7q1uhDmdW51xf0DVEF0x0J06xjlB0mA=;
 b=egj5ImYIAEkm321/UcXZSZ4Kt3/rLf3UujZD30FP96mv8b9h1ttodUmibI0zUwSWo70hB8
 OZa2nAzcRc7IN4b5nSu4TXJffWFWjdPllkV/4VAQQP7naaS4NG8VxIHVPwhbv4XroeBOmn
 434E5yI2MoLmJOJ6AQ8GO/kdOcwetiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-at6chlEcOxC2mhE-UreQJw-1; Fri, 30 May 2025 08:05:19 -0400
X-MC-Unique: at6chlEcOxC2mhE-UreQJw-1
X-Mimecast-MFC-AGG-ID: at6chlEcOxC2mhE-UreQJw_1748606718
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso11808725e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606718; x=1749211518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KgZGfKxKfVm7q1uhDmdW51xf0DVEF0x0J06xjlB0mA=;
 b=YQFwz+nBNGhywUc4UjQ6GN7nmhjUOEGgsrHschJASIzlOF3xAB8qs0G2JeoK76xDzh
 MtgQrcPh/mkfejDgHm8kP56WNBHqm+Sx1HesqVmti6rc+EVUDYhHfYn5el9z/N2i8gav
 SgfwDJQqfUPz/7xP3mmtSqMIcWkoNWFNNncD2T7g3K6VecEFng3hQivomRxNU/1od2nn
 KOJEqy25kfRAYtq8gCSFrkFXA/en/XSoWEZYU5fiSXrIGjUXWnJ6ib1wp14p+pheSMxr
 SSOKqDRcuqLgneZQrC8mIffj8W7kYuaitwvpoIhMcvrlpNV1ZnzAUWwGg8ubsgEQa9cj
 2SlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVecsLqjaBc/T1L4gE58VQ7oH0/70LTbExNHHFcelkRJoQgh84LzP2/RUFtgQVciD8JGqSoJp8vbyFP@nongnu.org
X-Gm-Message-State: AOJu0YxMBprMfWIsdrNm6mcVreTZdR+pgxdkmwgbYazxLdZhrktCCOoq
 DLMIYaDpy9efBVMtKaWZO6CnzczuVgUroVj6HGf2UBO9x5+GWNorGL+5jKFGaMavEQFQ0tCspuf
 mxHnuuGEuw7Bd8BC2z9y5OswGShHAS9E1F+oenm7ZgsBkHDyMiiD9IAyY
X-Gm-Gg: ASbGnct9IipAbEZKrJ1I8CxE6dg1NVl0QkyDt5vZqf0qWR0p2q/sVlQf5Dy1ydgnjmd
 hkybO8e9QJ2Bv0BZuGU6TqzSZqonqR5sYtMCpXyNNyZvPvdYVvsfnEzeeueoLBZdgUBLMDlOxf6
 JgS88FdsxBQhGA3hldxHFFtMKAxECyYeoqkXwfyvTl7tP1IRJqan83Pw3EMe4KHeeJ7S4WhyYIC
 QWdt+EmLHjk+PAbDTPVBbXUvDuDlS43yszqAwUdjuSOQiAjShC918YYqlSNBBIpi9LJtNhIXVib
 zRzIQFHjYw/QJ81AwT6JUY7Yfc52Cd8Y
X-Received: by 2002:a5d:4ad0:0:b0:3a4:f7ae:77e8 with SMTP id
 ffacd0b85a97d-3a4f7ae78f2mr1973364f8f.15.1748606718082; 
 Fri, 30 May 2025 05:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiTxHsoj5mzsZMrCuVAA6hNFZFSXff9Z1UpU4uC2n3i466dPIeBqm0CpeKabbRJGIZNBzg3w==
X-Received: by 2002:a5d:4ad0:0:b0:3a4:f7ae:77e8 with SMTP id
 ffacd0b85a97d-3a4f7ae78f2mr1973323f8f.15.1748606717624; 
 Fri, 30 May 2025 05:05:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00971e4sm4699834f8f.65.2025.05.30.05.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:05:17 -0700 (PDT)
Date: Fri, 30 May 2025 14:05:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250530140516.35db4d52@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250530110227.00003341@huawei.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
 <20250530110227.00003341@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 30 May 2025 11:02:27 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 27 May 2025 09:40:07 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> > it appends the _OSC method but in fact it also appends the _DSM method
> > for the host bridge. Let's split the function into two separate ones
> > and let them return the method Aml pointer instead. This matches the
> > way it is done on x86 (build_q35_osc_method). In a subsequent patch
> > we will replace the gpex method by the q35 implementation that will
> > become shared between ARM and x86.
> > 
> > acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> > both the _OSC and _DSM methods.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>  
> 
> Makes complete sense. I've had local equivalent of this on the CXL
> tree for a while as without it we don't register the _DSM for the
> CXL path (and we should).  However, can you modify it a little to
> make that easier for me?  Basically make sure the _DSM is registered
> for the CXL path as well.
> 
[...]
unless CXL is root host bridge, current _DSM shouldn't be added to it.
read on comment below.

> > @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> >      byte_list[0] = 0;
> >      buf = aml_buffer(1, byte_list);
> >      aml_append(method, aml_return(buf));
> > -    aml_append(dev, method);
> > +    return method;
> > +}
> > +
> > +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> > +                                              bool enable_native_pcie_hotplug)
> > +{
> > +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> > +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));  
> 
> These two declarations seem to be very much part of the _OSC build though not
> within the the method.  I 'think' you get left with them later with no users.
> So move them into the osc build here and they will naturally go away when
> you move to the generic code.
> 
> They end up unused in the DSDT at the end of the series.
> 
> I ran a quick GPEX + pxb-pcie test and we do get the odd mix that the OSC for
> the GPEX say no native hotplug but the OSC for the PXB allows it.

It's fine for each PXB to have it's own _OSC.
Also current incarnation of ACPI pcihp doesn't support PXBs at all,
it would be wrong to enable the on PXBs.

Thus I'd avoid touching CXL related code paths from this series.

I'm working on extending ACPI pcihp to PXBs
(for the same reason as Eric does for arm/virt, i.e. enable acpi-index support there).
I can add CXL bits then if there is a need/demand for that in CXL land.

[...]


