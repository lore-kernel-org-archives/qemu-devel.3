Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242B3C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 05:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkykq-0003K7-8Y; Thu, 20 Feb 2025 00:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkykn-0003Jx-P0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkykk-0001OS-Ox
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 00:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740027933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MtX1jOfbHNFB4zbOu1jQitMrXY1457sgnPh2gu6kYQ=;
 b=PQLvrmUhf21M1zDQdikKlNOa10fqOpve3lg75JkM9XuuYt/PfAF0r16Z1AGseivA7hcJF7
 B5Mk2e48w+d7OZIehSxl9dU8OlvkfHic94+Pj+usDWLxXwzqTt7za0qj4cr1Vcg0fNf0zT
 gE1yrT3AiNYx8KbPTMcypMAmSoBk90k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-VMcOKO3JMTiV9ZNMXTTZEA-1; Thu, 20 Feb 2025 00:05:31 -0500
X-MC-Unique: VMcOKO3JMTiV9ZNMXTTZEA-1
X-Mimecast-MFC-AGG-ID: VMcOKO3JMTiV9ZNMXTTZEA_1740027931
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-849cc81984eso6585539f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 21:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740027930; x=1740632730;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0MtX1jOfbHNFB4zbOu1jQitMrXY1457sgnPh2gu6kYQ=;
 b=SXrw8SMOlrE3EpDMYnCL0csgqvxT17J97QuuXLcESMddSBIR156/a7zIjdcKg+frI8
 0w4Dl5t6uCVXCn3LxGmJ4a8OQA9KyZ2P2UIihOMwCTeKnt/uQlEX5O1YV87KkrOYYGZ8
 cX4W8GMXlwhHSj2LNZc7AAiU7zhr7MscjZ5lcxm9+N7CYghiXUHvD0/JvpkRl3KX1ggc
 5/FHuhaVX2UYHu5/5UhXQqIczckmjWyWHB+9WgH2E32UYJ7Ai9yy8ZQ24/EBQKOd5piI
 hvmDXtBKPa4CFtAvpxblXnEOu5hOUke6pxuFQ+LALQEvBO1OpRCxe2CcZBCQMR2ByCmT
 XrjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgPCjYd+5Jaho4XgN+QqLkclftPkZDYmxOcgPhyZrwHfhda4meb9sZULtX84QwihuZ2acUEbdFz3LP@nongnu.org
X-Gm-Message-State: AOJu0Yw2gQ7j/omyP2nf28q9QqYgc48yIqfo98sYN+1gDsbXoBuk5xLY
 Lqf3/MbwUUIs/30WS7k6yGU/PdJrqi9ZrF6k2v7WGZjDS8XnNLutIX8tA1IrN6FDHpMUW7QfIlk
 dwn8z3OaOCrcaLKRtjw4x65AgPAPI/paKeU80qCJ0mvMGK6T4Edkd
X-Gm-Gg: ASbGncu3VEcK5Zpieca1ZsH+fPwNOo9tsvu/XJdV0eO/XFPYsnsJvuYF1m9QGngOBX/
 GKgKOP44K8TQ0T6/h/LNRPWJz1S2uaaEMCoatzSZmeiCi0A+FKzkau1OhkG0TkRWS/FLIBpsc0n
 qOfmf9/hj7QkwFNFdWprUwoDWVBv4NjOlKF/mWS313ze0/6KZJxvaIlP7sbWn2mNpV1dEJ2CdA1
 1YIRby6oZkgdXsxj8SM5wtaDabU5gt5Nr+QZ9w170xcMdNRAUsqxDLlNfIVq+hTv3lVtnmpaUKk
 XpBxbVKU
X-Received: by 2002:a05:6e02:20cd:b0:3d1:936d:1e22 with SMTP id
 e9e14a558f8ab-3d2807655e4mr46574255ab.1.1740027930319; 
 Wed, 19 Feb 2025 21:05:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxZfADHRMVrzGII6l9RqWeSsKGu95FWKvvrQ2x8OXicZMKdXxqB+v7hHpY67NOmvL7y1S1Jg==
X-Received: by 2002:a05:6e02:20cd:b0:3d1:936d:1e22 with SMTP id
 e9e14a558f8ab-3d2807655e4mr46574185ab.1.1740027929716; 
 Wed, 19 Feb 2025 21:05:29 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d2ab66feadsm11085755ab.34.2025.02.19.21.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 21:05:28 -0800 (PST)
Date: Wed, 19 Feb 2025 22:05:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Message-ID: <20250219220525.08d39475.alex.williamson@redhat.com>
In-Reply-To: <SJ0PR11MB674418674B2374371F2AA24692C42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <SJ0PR11MB674418674B2374371F2AA24692C42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 20 Feb 2025 04:24:13 +0000
"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:

> >-----Original Message-----
> >From: Alex Williamson <alex.williamson@redhat.com>
> >Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
> >d3hot state
> >
> >On Wed, 19 Feb 2025 18:58:58 +0100
> >Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Since kernel commit:
> >> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
> >> in D3hot power state")
> >> any attempt to do an mmap access to a BAR when the device is in d3hot
> >> state will generate a fault.
> >>
> >> On system_powerdown, if the VFIO device is translated by an IOMMU,
> >> the device is moved to D3hot state and then the vIOMMU gets disabled
> >> by the guest. As a result of this later operation, the address space is
> >> swapped from translated to untranslated. When re-enabling the aliased
> >> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
> >> faults when attempting the operation on BARs.
> >>
> >> To avoid doing the remap on those BARs, we compute whether the
> >> device is in D3hot state and if so, skip the DMA MAP.  
> >
> >Thinking on this some more, QEMU PCI code already manages the device
> >BARs appearing in the address space based on the memory enable bit in
> >the command register.  Should we do the same for PM state?
> >
> >IOW, the device going into low power state should remove the BARs from
> >the AddressSpace and waking the device should re-add them.  The BAR DMA
> >mapping should then always be consistent, whereas here nothing would
> >remap the BARs when the device is woken.  
> 
> If BARs should be disabled before D3hot transition, isn't it guest's responsibility to do that itself?
> Just like what have been done for FLR which calls pci_dev_save_and_disable().

Nothing requires the guest to clear memory and IO from the command
register before entering a low power state, nor are we going to get
very far arguing that it's the guest's fault for triggering an error in
the hypervisor.  The PCI spec indicates that memory and IO BARs are only
accessible when the device is in the D0 power state.  On bare metal
accessing the BAR for a device in a low power state would generate an
unsupported request.  Therefore why should QEMU map BARs of devices in
low power states into the address space?  Thanks,

Alex


