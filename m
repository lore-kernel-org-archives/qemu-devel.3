Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A168C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrVN-00045K-58; Wed, 19 Feb 2025 16:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkrVD-0003vf-NM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tkrVA-0001a7-TO
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740000061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrVW92jt1gRceo133ItBkVRsIJzgOqkZv8gKQbPQZ2Y=;
 b=N8fXWifhSf69X7Io5apeJVMOGS2ksCLfG94ahUskmXlkcHDIwVJk8fR4b07NgzCvkIHjvS
 Izw28grQqyfQE16IfMq52QS41/fYmSvYNh4D8ksNJJSC3NrEjTm6MZy/Kx+oZCo4iaSHxu
 5FBTtpKm+14wUT/AqAsW1qTulAQtKCc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-jhVX6Ib6OLSZCpOLB19vlw-1; Wed, 19 Feb 2025 16:19:51 -0500
X-MC-Unique: jhVX6Ib6OLSZCpOLB19vlw-1
X-Mimecast-MFC-AGG-ID: jhVX6Ib6OLSZCpOLB19vlw_1739999990
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-84990d44b31so2972739f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999990; x=1740604790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrVW92jt1gRceo133ItBkVRsIJzgOqkZv8gKQbPQZ2Y=;
 b=WvVpUI2JjOuHiCK7Cwvuw0pU9OUjQ8ZfeClPytHW72mTloYodlqKH1A4OUYJnvtymP
 1yQlS4B9gpJztYLBXZTNQopNx05udizt4iVvFQ7WMnW+L6JuyEqdJUuFEdW3zAhxfvsv
 NPUBT98VK/8rpb34CphLN+I1Z8fCX/uM3d3D+1j0S+yGSV8LskBCYqULefNNyiUHoZgM
 92SJ1J4Bfd/tmV4w7S5c9kdQwmuVcMXxV5et6lWf19yzpd0k9TA4VAI7eJXi4y2JTaVT
 Qy5C8pJYD09qboZngrLNohRiFWVB4XS+doHNyRcUdP3ghZPmLlr57FHraWlR/7xKHMRh
 XBlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyaSQuzIDOk2YU9LMKd444oH49CRkVEzPtD3F4ocWhucihIeyd1VhWbBPkmSeXzcUa2MvLpFKahPlf@nongnu.org
X-Gm-Message-State: AOJu0YzbA8q8CQ309FKZm3hSEEGpV8e8eq7y1/VIwRqFou9Q/5+m3Z3T
 NV4Q7if5S8UKGb9MG+PN6+jptQKUJX3c/xXEII6Qt5R706SgCzMCljPTlvUUl6ve6KfxczL4zCI
 cJ+duOiouETHqbs5rUxnsw9+vtT+NNv3hdQSMlAI/E+IR0h3+fg4l
X-Gm-Gg: ASbGncs34CV5gb8cscaDwALjJ6wrcdpAxcxNwqBHVz3gknmU9v0+4c+RevoNdJhOrWV
 rXhFD4jdE3wa8BSAiG+Wq5F1837xeH1/Gyu1ScWH+N6DYjGKuDhNFU2Ek1At20Sk0zhVee1E9w5
 21AoBrFnmgwtAn126vXejXt41DXYULM2qgQdOtV6oOhQVg9fpYaYTq1Vt6vnGeKRocve1DMLJjy
 Mo8SD/xVWwUiq4S9Jt/g7b9y2V9hReqj7O9SXs74XaHPGz9QhZNBf58smMD2PbLRxyqoQ9VOgEH
 jnNB0duc
X-Received: by 2002:a05:6e02:1fc3:b0:3d2:b5f8:87a6 with SMTP id
 e9e14a558f8ab-3d2b5f88ab1mr15195075ab.7.1739999990252; 
 Wed, 19 Feb 2025 13:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcpecwwSjIPDqVFjPe09SyTChGQKKTnrV9FxdjFX16NWlHkhiYe1YHNi8k7pgfldw0MkpV4Q==
X-Received: by 2002:a05:6e02:1fc3:b0:3d2:b5f8:87a6 with SMTP id
 e9e14a558f8ab-3d2b5f88ab1mr15194995ab.7.1739999989882; 
 Wed, 19 Feb 2025 13:19:49 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d2bc19dbe3sm3203025ab.9.2025.02.19.13.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 13:19:48 -0800 (PST)
Date: Wed, 19 Feb 2025 14:19:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, clg@redhat.com,
 zhenzhong.duan@intel.com
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Message-ID: <20250219141945.5e74c7f3.alex.williamson@redhat.com>
In-Reply-To: <20250219115844.062c5513.alex.williamson@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On Wed, 19 Feb 2025 11:58:44 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 19 Feb 2025 18:58:58 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Since kernel commit:
> > 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
> > in D3hot power state")
> > any attempt to do an mmap access to a BAR when the device is in d3hot
> > state will generate a fault.
> > 
> > On system_powerdown, if the VFIO device is translated by an IOMMU,
> > the device is moved to D3hot state and then the vIOMMU gets disabled
> > by the guest. As a result of this later operation, the address space is
> > swapped from translated to untranslated. When re-enabling the aliased
> > regions, the RAM regions are dma-mapped again and this causes DMA_MAP
> > faults when attempting the operation on BARs.
> > 
> > To avoid doing the remap on those BARs, we compute whether the
> > device is in D3hot state and if so, skip the DMA MAP.  
> 
> Thinking on this some more, QEMU PCI code already manages the device
> BARs appearing in the address space based on the memory enable bit in
> the command register.  Should we do the same for PM state?
> 
> IOW, the device going into low power state should remove the BARs from
> the AddressSpace and waking the device should re-add them.  The BAR DMA
> mapping should then always be consistent, whereas here nothing would
> remap the BARs when the device is woken.
> 
> I imagine we'd need an interface to register the PM capability with the
> core QEMU PCI code, where address space updates are performed relative
> to both memory enable and power status.  There might be a way to
> implement this just for vfio-pci devices by toggling the enable state
> of the BAR mmaps relative to PM state, but doing it at the PCI core
> level seems like it'd provide behavior more true to physical hardware.

I took a stab at this approach here, it doesn't obviously break
anything in my configs, but I haven't yet tried to reproduce this exact
scenario.

https://gitlab.com/alex.williamson/qemu/-/tree/pci-pm-power-state

There's another pm_cap on the PCIExpressDevice that needs to be
consolidated as well, once I do some research to figure out why a
non-express capability is tracked only by express devices and what
they're doing with it.  Thanks,

Alex


