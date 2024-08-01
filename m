Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3912C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV7h-00014X-GE; Thu, 01 Aug 2024 08:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZV7g-0000yu-2c
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZV7e-0004CT-2o
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722516093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9QOfUWGkFHk3ovuTvNOTwPFQmQaxZ6Tc0fImyqase8=;
 b=RDobteVwrrtHWrODFWifVhuXr/7LLmdHMd4duiBfOa4hbwCfOXEXXG9730pQm8m+FWo1gR
 AwrW/o/iVgstztBWJEvOorBUJ8VQjuTaNk0JvmH1LRoKYZwp8Z1SSz53KgNCubTF+V/d5x
 UuBCT9ODaqEBnAREQpUpC9r+dmPNvVc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-kz985YCmO_ex4FwiynAwSg-1; Thu, 01 Aug 2024 08:41:30 -0400
X-MC-Unique: kz985YCmO_ex4FwiynAwSg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7a822ee907so674075066b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722516089; x=1723120889;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9QOfUWGkFHk3ovuTvNOTwPFQmQaxZ6Tc0fImyqase8=;
 b=TQ8mw+lLFAcTrCrw2M0nx0gSlb16fE7+1X+Z3Qhjkk/YoT/yIUWt3ta7V2Toq/D6Ul
 A/OJ6PinVv0wNCUamGyHC1McjohMnP3W76miNoBkEAqAibdHUuyn+P13tNke8MFTZoKg
 oajNdouwId8a7Uiw3T69WKn9t8w6rP0BMU6iCk3wHEdk8zNB+J9FoIcqjPGFqpjJfBoi
 8ZZwkrWMPBCJBW0UsUuSEToS+XnMRcuVpIZSLI0CtPk7IzAEiQ9ybMMYGcf5VPwkP1mJ
 Q1e3sYo4juMqfrW9hDqluKu/AXTB07Glv+OO4a1VlU3UnSclBzodELtZhwzuF98UQfDE
 XgVw==
X-Gm-Message-State: AOJu0YxyuVSX9e5rNQbFiVP5s9Sdsaa20AOBPYdostSi9u5UBzxPAl/q
 xYk+urI4vnKK6gc23V04L5xZmqY1/W/+alK2MwYfRMpD/cR12A2ykBBUXs136YhUH0Jhut3yDgx
 xnHGsCS3HcJF84jAn6RIF2U963PAmHUv1exmWUGETe/pMdr7nnclU
X-Received: by 2002:a17:907:9484:b0:a77:cf09:9c5f with SMTP id
 a640c23a62f3a-a7dc5014ddfmr1764866b.37.1722516089523; 
 Thu, 01 Aug 2024 05:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9W7ySyNzeeYG0HO0kvyzoI0hF3QY0nrd1JCWN7tT7+Ok6otX+xRKw+6C+0MJWhjElJvEqDw==
X-Received: by 2002:a17:907:9484:b0:a77:cf09:9c5f with SMTP id
 a640c23a62f3a-a7dc5014ddfmr1762266b.37.1722516088763; 
 Thu, 01 Aug 2024 05:41:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab5c8fdsm894749766b.89.2024.08.01.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 05:41:28 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:41:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1?] hw/pci/pci-hmp-cmds: Avoid displaying bogus
 size in 'info pci'
Message-ID: <20240801084004-mutt-send-email-mst@kernel.org>
References: <20240801100742.50312-1-philmd@linaro.org>
 <20240801062632-mutt-send-email-mst@kernel.org>
 <3b2c64bd-33b4-48bf-9afa-ac5b138b901a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b2c64bd-33b4-48bf-9afa-ac5b138b901a@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 02:36:11PM +0200, Philippe Mathieu-Daudé wrote:
> On 1/8/24 12:27, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2024 at 12:07:42PM +0200, Philippe Mathieu-Daudé wrote:
> > > When BAR aren't configured, we get:
> > > 
> > >    (qemu) info pci
> > >      Bus  0, device   0, function 0:
> > >        Host bridge: PCI device dead:beef
> > >          ...
> > >          BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
> > >          BAR5: I/O at 0xffffffffffffffff [0x0ffe].
> > > 
> > > Improve logging to not display bogus sizes:
> > > 
> > >        BAR4: 32 bit memory (not configured)
> > >        BAR5: I/O (not configured)
> > > 
> > > Remove trailing dot which is not used in other commands format.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
> > >   1 file changed, 18 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
> > > index b09fce9377..8421c3f74a 100644
> > > --- a/hw/pci/pci-hmp-cmds.c
> > > +++ b/hw/pci/pci-hmp-cmds.c
> > > @@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
> > >           monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
> > >           if (!strcmp(region->value->type, "io")) {
> > > -            monitor_printf(mon, "I/O at 0x%04" PRIx64
> > > -                                " [0x%04" PRIx64 "].\n",
> > > -                           addr, addr + size - 1);
> > > +            if (addr != UINT64_MAX) {
> > > +                monitor_printf(mon, "I/O at 0x%04" PRIx64
> > > +                                    " [0x%04" PRIx64 "]\n",
> > > +                               addr, addr + size - 1);
> > > +            } else {
> > > +                monitor_printf(mon, "I/O (not configured)\n");
> > > +            }
> > >           } else {
> > > -            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> > > -                               " [0x%08" PRIx64 "].\n",
> > > -                           region->value->mem_type_64 ? 64 : 32,
> > > -                           region->value->prefetch ? " prefetchable" : "",
> > > -                           addr, addr + size - 1);
> > > +            if (addr != UINT64_MAX) {
> > > +                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> > > +                                   " [0x%08" PRIx64 "]\n",
> > > +                               region->value->mem_type_64 ? 64 : 32,
> > > +                               region->value->prefetch ? " prefetchable" : "",
> > > +                               addr, addr + size - 1);
> > > +            } else {
> > > +                monitor_printf(mon, "%d bit%s memory (not configured)\n",
> > > +                               region->value->mem_type_64 ? 64 : 32,
> > > +                               region->value->prefetch ? " prefetchable" : "");
> > > +            }
> > >           }
> > >       }
> > 
> > what makes bar unconfigured is that memory space is disabled,
> > not that it has a special value.
> 
> I tried to add a PciMemoryRegion::enabled field then realized
> unmapped regions are advertised using addr = PCI_BAR_UNMAPPED
> (which is UINT64_MAX):
> 
> typedef struct PCIIORegion {
>   pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
> #define PCI_BAR_UNMAPPED (~(pcibus_t)0)
> 
> OK if I respin this patch with s/UINT64_MAX/PCI_BAR_UNMAPPED/?

ok


