Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A2EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl89G-0000Eb-1h; Thu, 20 Feb 2025 10:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tl89E-0000EJ-KE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:07:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tl89C-0005td-KT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740064048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3EjDxfi/7+WOWvOUOkl0i+GTBccy5vNTBMEO74wUiw=;
 b=izZ1pf1q5ggMrSAmjd0BUb/FTEQQgWKCL3mrfCB1+8y6u1SXkZCyYJxif2jTb7npyTxzGk
 NHfE+kZTmkgK4XEE7jTbV4FBvvStCYEY3YADm9MaPojLFsSjoq7cN6o1VRm7TwuAeE7y3N
 YuPWup3zjMhj0crnuxFwcjmvONit35s=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-sujMi67oNXqIF1plY8azYA-1; Thu, 20 Feb 2025 10:07:27 -0500
X-MC-Unique: sujMi67oNXqIF1plY8azYA-1
X-Mimecast-MFC-AGG-ID: sujMi67oNXqIF1plY8azYA_1740064047
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-855a922b214so14520439f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740064047; x=1740668847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3EjDxfi/7+WOWvOUOkl0i+GTBccy5vNTBMEO74wUiw=;
 b=Wq4o7N/YyryvfK9B9nmLwyhzMue9Hbkd0lGz2mNwG5qBean1gWQXzXt9eeZWEt9xl7
 SSQ8gvZWTBEL43C3RNP4MMbpUznbbbK+wawvH0Ien8Rbsj355hGoSQYAaAnK29xd05zD
 yyWeM0yEF1ZBk6aN571e0DzyYPYL3CzAYqda343Zt3LLzyHhw8kT5O5RrSRDivztG1g5
 SZ7S4PL64wG2JkXClWcIoLNHJoEePRFZP6vC78YlCOQxbA0tKJP7fSsf6RQpBwkO4ajb
 iFyxvQPDKk5HdE5VO1iWj58aGJmaXrUHu5RSe0PugB7J2e9Dy7oOhKcgpIGR9eL+BlFg
 gUIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwVnmG8s3nKr5KHteG4FtohjGHkK8AL+WYDGjvLBDydq7naWK38L/1JNxKG0LJaJoRLd9SIq3uuSo1@nongnu.org
X-Gm-Message-State: AOJu0YwAKqthmssyrvqKqTjvMkCi6GOrZuIGBrY78CdjNvlfHdVANja/
 7bBNoKbhGgh/JEyCzWkSEXsP4zkFKj/Cs1ake4VqHTnRtiOylMY/wgbUdb1bfS+QI36t54Wqt+m
 vadKWtUYEeMfn57zKfrHxBZxjZ+Tbdf6xh2fWm9oo0vgygaM4rUFb
X-Gm-Gg: ASbGncv77Q7+jnjb/NBz0JJgyQ13htzWNxaKe0W72XEjGBSZ0OIV3UJzvvQXDzAPKBj
 uwXmD9RblnH6NAeWPP2t4JhJnmjcl4tVZjip3rRAAed5GzEfqHLIBCiO2nkU8/5Yg3mVCdRAeG3
 Ndjr3+4OGGAsGU7onCpOi/24STcpQN+f2jEnVVHyAtpDFSePLp5aAS4LPUJ2CQ67vO24dlYHqEY
 XQ5n5gEUpn8h6TtGZCJFJDNyXAggIurXca9OMXusdq/DxSF+8J0a6JZMU1itlS29K6faqr+iXLs
 woBiWp1r
X-Received: by 2002:a05:6e02:2181:b0:3d1:889d:815e with SMTP id
 e9e14a558f8ab-3d2808c6846mr45465375ab.4.1740064046729; 
 Thu, 20 Feb 2025 07:07:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFefekDVXJpon3jbkwuueu4i0vVDOLQbeO4EUq4FDFDHnBB6pM0kAYHJ5R8hNycDj3yCj7GEw==
X-Received: by 2002:a05:6e02:2181:b0:3d1:889d:815e with SMTP id
 e9e14a558f8ab-3d2808c6846mr45465185ab.4.1740064046194; 
 Thu, 20 Feb 2025 07:07:26 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ee8ddf0332sm2361030173.93.2025.02.20.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:07:25 -0800 (PST)
Date: Thu, 20 Feb 2025 08:07:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 clg@redhat.com, zhenzhong.duan@intel.com
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Message-ID: <20250220080723.2ee71a7b.alex.williamson@redhat.com>
In-Reply-To: <44a82e93-003a-4d70-a1f0-4bc3efd045d2@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <20250219141945.5e74c7f3.alex.williamson@redhat.com>
 <4b7cfa82-c730-43af-ab47-53f20131104a@redhat.com>
 <44a82e93-003a-4d70-a1f0-4bc3efd045d2@redhat.com>
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

On Thu, 20 Feb 2025 11:45:35 +0100
Eric Auger <eauger@redhat.com> wrote:

> Hi Alex,
> 
> On 2/20/25 11:31 AM, Eric Auger wrote:
> > 
> > Hi Alex,
> > 
> > On 2/19/25 10:19 PM, Alex Williamson wrote:  
> >> On Wed, 19 Feb 2025 11:58:44 -0700
> >> Alex Williamson <alex.williamson@redhat.com> wrote:
> >>  
> >>> On Wed, 19 Feb 2025 18:58:58 +0100
> >>> Eric Auger <eric.auger@redhat.com> wrote:
> >>>  
> >>>> Since kernel commit:
> >>>> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
> >>>> in D3hot power state")
> >>>> any attempt to do an mmap access to a BAR when the device is in d3hot
> >>>> state will generate a fault.
> >>>>
> >>>> On system_powerdown, if the VFIO device is translated by an IOMMU,
> >>>> the device is moved to D3hot state and then the vIOMMU gets disabled
> >>>> by the guest. As a result of this later operation, the address space is
> >>>> swapped from translated to untranslated. When re-enabling the aliased
> >>>> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
> >>>> faults when attempting the operation on BARs.
> >>>>
> >>>> To avoid doing the remap on those BARs, we compute whether the
> >>>> device is in D3hot state and if so, skip the DMA MAP.    
> >>> Thinking on this some more, QEMU PCI code already manages the device
> >>> BARs appearing in the address space based on the memory enable bit in
> >>> the command register.  Should we do the same for PM state?
> >>>
> >>> IOW, the device going into low power state should remove the BARs from
> >>> the AddressSpace and waking the device should re-add them.  The BAR DMA
> >>> mapping should then always be consistent, whereas here nothing would
> >>> remap the BARs when the device is woken.
> >>>
> >>> I imagine we'd need an interface to register the PM capability with the
> >>> core QEMU PCI code, where address space updates are performed relative
> >>> to both memory enable and power status.  There might be a way to
> >>> implement this just for vfio-pci devices by toggling the enable state
> >>> of the BAR mmaps relative to PM state, but doing it at the PCI core
> >>> level seems like it'd provide behavior more true to physical hardware.  
> >> I took a stab at this approach here, it doesn't obviously break
> >> anything in my configs, but I haven't yet tried to reproduce this exact
> >> scenario.
> >>
> >> https://gitlab.com/alex.williamson/qemu/-/tree/pci-pm-power-state  
> 
> it does not totally fix the issue: I now get:
> 
> qemu-system-x86_64: warning: vfio_container_dma_map(0x55cc25705680,
> 0x380000000000, 0x1000000, 0x7f8762000000) = -14 (Bad address)
> 0000:41:00.0: PCI peer-to-peer transactions on BARs are not supported.

Hmm, I'll reproduce and debug further.  The intention here is that BARs
for the device in D3hot would not be DMA mapped, effectively as if the
memory enable bit in the command register were cleared, therefore I'd
hoped the listener is not called for this range.

> > So if I understand correctly the BAR regions will disappear upon the
> > config cmd write in vfio_sub_page_bar_update_mapping(). Is that correct?
> > I will give it a try on my setup...  
> >>
> >> There's another pm_cap on the PCIExpressDevice that needs to be
> >> consolidated as well, once I do some research to figure out why a
> >> non-express capability is tracked only by express devices and what
> >> they're doing with it.  Thanks,  
> > I am not sure I get this last point though.

I added a patch to my branch that removes the redundant pm_cap from the
PCIExressDevice.  It just wasn't clear, and really still isn't, why
this cap offset had been cached on the express object rather than the
conventional PCI device object.  Regardless, it can be consolidated.
Thanks,

Alex


