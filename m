Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957EAC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8nZ-0007bF-4G; Thu, 20 Feb 2025 10:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tl8nW-0007al-Q0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tl8nU-00044F-RH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740066547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7efyDFq8ywl3rUi284rb4ybACQMMm9v6CDYnSM9dpQc=;
 b=bs3Aj5ERK+XAHn//+wXovtodht44DxSxL316PWGhs847A0JOZlGhZlU2RvPsLcT9hqlUV6
 qu5aQWgBbNCFb/GAoR9oQjN5ZUM2rOQcEFist1ie85xiv4TeIfrWIY3lQheBgB499KbUBq
 VMLaA5cMMalqQwqMgyORNqltvpL4Yjk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-__BGG8qVOGm0tFGjQ54FrA-1; Thu, 20 Feb 2025 10:49:02 -0500
X-MC-Unique: __BGG8qVOGm0tFGjQ54FrA-1
X-Mimecast-MFC-AGG-ID: __BGG8qVOGm0tFGjQ54FrA_1740066542
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-849e7868f6eso16661939f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740066542; x=1740671342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7efyDFq8ywl3rUi284rb4ybACQMMm9v6CDYnSM9dpQc=;
 b=T2est8DVamOyDCsoJIPovtysfrmMravAo1HFz/3l/s9820pIQoe3Sjdg1WC1btMhly
 gjGejbD60l/3od37IwlN9TzY3syguap01G/jTBx0yqY5CsucqDDF4Vn3ePaAm3/uIz8Y
 9rfd4fxKPRjAx4UuxZW86iIJEvGMa6fU5fKPdpLIie1e7D9UTZnhYgJSsaSsyU50bzxz
 7gzkTjuW2SN87oYVxO7rzKoiLnL1HPqdmpPUYLGHf0qtyhn/OHzZNH7Ywv5ZvCiHwV1J
 E1Sqvj1k/Gf7ayj97wzSzLwXM12vVJdfBykJSBBW1eXV6kaRTfbGqCWUFKSQFtOO0Y6l
 jtbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdTsqdSLb0GAFKTYiHllOmPo7Qwonj5GsbBrcfoRydXvZ594I9Dm+oHVYoOR4hskfQJtdduCFvY9q+@nongnu.org
X-Gm-Message-State: AOJu0YyxTcSoN5Ny+TOMeQPQjsgt7UyBIR28pLnj+pd5G4tUX9zeBNAe
 mf4rYNx0iaJawrzis1MS3JA3unFIET6BgKaXoTGJuQlinXCwYwXurSLq4FmznWJ2Dgj5F0iMEaf
 rZtHgrkfuofWhUlOMXq27GclxQM/OEij3Qng2qaDIDV0BCKWz2IIH
X-Gm-Gg: ASbGncvWXeihVyqt1PVbNHUYEOky5LdwHQXuLg1rw1d6/ACWJwc6/0bdWJScITq1rei
 JcqPJOrHygGlCGn3fjKbkn0War7iGXyU12gmkH+noXcOkHC4Zgn1sGJaa52kIPwqmTabtStcY7r
 R837baGXSGr6HrYe0y97p1LScahNKXYwvG9VR7YN1YsczcbrhStJMXXEEdh5CAkNqkz1/GdlbEv
 MXPUdqqZemMQSbzDMwX2dSoPTfJh05Pnp6+7gvTWHDm0lsRbZTDz4B6x72dOHmRxCzTCOpmBP8H
 btqzcAlf
X-Received: by 2002:a05:6e02:2181:b0:3d0:13f1:b47c with SMTP id
 e9e14a558f8ab-3d2808e4ca0mr47467915ab.4.1740066541874; 
 Thu, 20 Feb 2025 07:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJqAxgkT6s8dGLb7OGfOfi9O3JRnEbos48P1EA8RIfD8UKsCL6O6U2bWGwmGGFsbNdX2d86Q==
X-Received: by 2002:a05:6e02:2181:b0:3d0:13f1:b47c with SMTP id
 e9e14a558f8ab-3d2808e4ca0mr47467855ab.4.1740066541483; 
 Thu, 20 Feb 2025 07:49:01 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d2ae885b93sm12672815ab.68.2025.02.20.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:49:00 -0800 (PST)
Date: Thu, 20 Feb 2025 08:48:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 clg@redhat.com, zhenzhong.duan@intel.com
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Message-ID: <20250220084858.0bd25b3f.alex.williamson@redhat.com>
In-Reply-To: <20250220080723.2ee71a7b.alex.williamson@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <20250219141945.5e74c7f3.alex.williamson@redhat.com>
 <4b7cfa82-c730-43af-ab47-53f20131104a@redhat.com>
 <44a82e93-003a-4d70-a1f0-4bc3efd045d2@redhat.com>
 <20250220080723.2ee71a7b.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Thu, 20 Feb 2025 08:07:23 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 20 Feb 2025 11:45:35 +0100
> Eric Auger <eauger@redhat.com> wrote:
> 
> > Hi Alex,
> > 
> > On 2/20/25 11:31 AM, Eric Auger wrote:  
> > > 
> > > Hi Alex,
> > > 
> > > On 2/19/25 10:19 PM, Alex Williamson wrote:    
> > >> On Wed, 19 Feb 2025 11:58:44 -0700
> > >> Alex Williamson <alex.williamson@redhat.com> wrote:
> > >>    
> > >>> On Wed, 19 Feb 2025 18:58:58 +0100
> > >>> Eric Auger <eric.auger@redhat.com> wrote:
> > >>>    
> > >>>> Since kernel commit:
> > >>>> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
> > >>>> in D3hot power state")
> > >>>> any attempt to do an mmap access to a BAR when the device is in d3hot
> > >>>> state will generate a fault.
> > >>>>
> > >>>> On system_powerdown, if the VFIO device is translated by an IOMMU,
> > >>>> the device is moved to D3hot state and then the vIOMMU gets disabled
> > >>>> by the guest. As a result of this later operation, the address space is
> > >>>> swapped from translated to untranslated. When re-enabling the aliased
> > >>>> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
> > >>>> faults when attempting the operation on BARs.
> > >>>>
> > >>>> To avoid doing the remap on those BARs, we compute whether the
> > >>>> device is in D3hot state and if so, skip the DMA MAP.      
> > >>> Thinking on this some more, QEMU PCI code already manages the device
> > >>> BARs appearing in the address space based on the memory enable bit in
> > >>> the command register.  Should we do the same for PM state?
> > >>>
> > >>> IOW, the device going into low power state should remove the BARs from
> > >>> the AddressSpace and waking the device should re-add them.  The BAR DMA
> > >>> mapping should then always be consistent, whereas here nothing would
> > >>> remap the BARs when the device is woken.
> > >>>
> > >>> I imagine we'd need an interface to register the PM capability with the
> > >>> core QEMU PCI code, where address space updates are performed relative
> > >>> to both memory enable and power status.  There might be a way to
> > >>> implement this just for vfio-pci devices by toggling the enable state
> > >>> of the BAR mmaps relative to PM state, but doing it at the PCI core
> > >>> level seems like it'd provide behavior more true to physical hardware.    
> > >> I took a stab at this approach here, it doesn't obviously break
> > >> anything in my configs, but I haven't yet tried to reproduce this exact
> > >> scenario.
> > >>
> > >> https://gitlab.com/alex.williamson/qemu/-/tree/pci-pm-power-state    
> > 
> > it does not totally fix the issue: I now get:
> > 
> > qemu-system-x86_64: warning: vfio_container_dma_map(0x55cc25705680,
> > 0x380000000000, 0x1000000, 0x7f8762000000) = -14 (Bad address)
> > 0000:41:00.0: PCI peer-to-peer transactions on BARs are not supported.  
> 
> Hmm, I'll reproduce and debug further.  The intention here is that BARs
> for the device in D3hot would not be DMA mapped, effectively as if the
> memory enable bit in the command register were cleared, therefore I'd
> hoped the listener is not called for this range.

I forgot to mark the PM state field as writable in config space, so we
were always reading back D0 state.  Adding the following to
pci_pm_init() resolves it:

--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -445,6 +445,7 @@ int pci_pm_init(PCIDevice *d, uint8_t offset, Error **errp)
 
     d->pm_cap = cap;
     d->cap_present |= QEMU_PCI_CAP_PM;
+    pci_set_word(d->wmask + cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
 
     return cap;
 }

Changing this might cause a problem with migration, ISTR we validate
the wmask with the source.  Anyway, I'll post the series and we can
test further and discuss it there.  Thanks,

Alex


