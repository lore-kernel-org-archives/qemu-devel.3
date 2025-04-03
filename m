Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F1C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NPT-0005e3-2e; Thu, 03 Apr 2025 12:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0NPQ-0005d7-MF
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u0NPO-0005ig-U0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743697632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIfRPTZ8v0N1Jji5qTeVIwsFluHEji8dNEblb/Alr5I=;
 b=VbbKtMenUg6LLhar9InsfSE2dPqcPu5v6jUkHnU+fHhcnpb4NA+Pee+1xWshkfk55eOXhV
 X9T5fGUlKcGcf0USttqfqWWzKejMtBGMEqSU6Re+oEogDdCvm0WVNhcC001M47/3NU2ZLV
 jOfXASi8qdyNXUVTRVE+1pAxlbkHfmU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-45C0uT0xMsi9fH-AgXR5TA-1; Thu, 03 Apr 2025 12:27:11 -0400
X-MC-Unique: 45C0uT0xMsi9fH-AgXR5TA-1
X-Mimecast-MFC-AGG-ID: 45C0uT0xMsi9fH-AgXR5TA_1743697630
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b5c68c390so6676739f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743697630; x=1744302430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIfRPTZ8v0N1Jji5qTeVIwsFluHEji8dNEblb/Alr5I=;
 b=mA0eUD5+l1js6IGHncYPPEMMkbhevATnmzvTOiDZDWQlGDyK8t8XO6HbsDx5M8MLdd
 jVF81q4RIXsjZigmh678H2JBH1XPsl+Qquy9+knBng9KN837oMy4zkUbN4QAbMeZSEKR
 M+bGVD46bHN1l/IcKZUd364B0jcP01twzjaitZWtWkZanvBu3hRzMSB6WRUSrFxsF/xN
 oaHzLaMII9256PqGQVbR0QuSHa/Tlo9JCoCDllDj/jR3o88VX7gZKVQqeVNeO0ubDH7U
 Pa7DYqlQpR5XTzITekQIJU0yA/Y4mhmvk54Ozjk6XyquT8BsF7a/o2R1voSDFoftMgDt
 CzUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlYOqHx5rClpn5/H31HCYA3Zzk4P2HPXPEjxz+wtpPXNOgryaTmwGx8poO4dMPHo5HBwsN5qvrVeZP@nongnu.org
X-Gm-Message-State: AOJu0YywwAEKCYdFN34H4xieala4LAgOnFoP1HCFwE5Ahbw/J4LTq3mQ
 JiQcNsqN2gejZgHtLiAprFmxmla/r6mqd8jAhELJMyIugzawvZsrV+J5AmmXKqruSUalcE8D7Av
 5bbzB3g9pl3G/1NDQj6JGAfgoCcLcMCPV+ktwiwWXgeb4agtsEw6w
X-Gm-Gg: ASbGncujGNhUeCxvDxrxuIPEvxoQJUKY/XN8QCJqugzb084EqAlB9IFvvzgBNp+jNkw
 j1ADSzZoj/n/BfPlnPPyrBjZUERAL1SIiZuXyJ7XeiwMY4nXE2VFy5ssP/lCHGW/Y1QIYF+CCMH
 LNMD4r37rwOZ4ovkbw3fgkDPqxg17tFt5F3H3HOb/lJUXoXlyf/nGoI4ebeiTTa4A8k5GHf295K
 w3EkQFzVzPebgYzNeHaeGCPEK1z/P54CeGhVahupQ0+6XjviVJkao22mNqxQW9afFZQEqSgs3bM
 3CTJ7wi71L5/28DMORg=
X-Received: by 2002:a05:6602:1489:b0:85e:5cbc:115 with SMTP id
 ca18e2360f4ac-85e9e858109mr648890939f.1.1743697630577; 
 Thu, 03 Apr 2025 09:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1JzoB13d6O+1vJIAVj9z7BCq8lE4Jg0pFIgTCTuQDroGBNxR/7JnMN30gRgILm0hFwZ6bVA==
X-Received: by 2002:a05:6602:1489:b0:85e:5cbc:115 with SMTP id
 ca18e2360f4ac-85e9e858109mr648888339f.1.1743697630236; 
 Thu, 03 Apr 2025 09:27:10 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8611125faecsm27421339f.3.2025.04.03.09.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 09:27:08 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:27:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com,
 mjrosato@linux.ibm.com, Farhan Ali <alifm@linux.ibm.com>, =?UTF-8?B?Q8Op?=
 =?UTF-8?B?ZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
Message-ID: <20250403102704.7e1f4452.alex.williamson@redhat.com>
In-Reply-To: <20250403154442.GA349582@fedora>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 3 Apr 2025 11:44:42 -0400
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:
> > On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:  
> > > On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:  
> > > > Hi,
> > > > 
> > > > Recently on s390x we have enabled mmap support for vfio-pci devices [1].  
> > > 
> > > Hi Alex,
> > > I wanted to bring this to your attention. Feel free to merge it through
> > > the VFIO tree, otherwise I will merge it once you have taken a look.
> > > 
> > > Thanks,
> > > Stefan
> > >   
> > > > This allows us to take advantage and use userspace drivers on s390x. However,
> > > > on s390x we have special instructions for MMIO access. Starting with z15 
> > > > (and newer platforms) we have new PCI Memory I/O (MIO) instructions which 
> > > > operate on virtually mapped PCI memory spaces, and can be used from userspace.
> > > > On older platforms we would fallback to using existing system calls for MMIO access.
> > > > 
> > > > This patch series introduces support the PCI MIO instructions, and enables s390x
> > > > support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
> > > > on the patches.
> > > > 
> > > > Thanks
> > > > Farhan  
> > 
> > Hi Stefan,
> > 
> > the kernel patch actually made it into Linus' tree for v6.15 already as
> > commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
> > for ISM devices") plus prerequisites. This went via the PCI tree
> > because they included a change to struct pci_dev and also enabled
> > mmap() on PCI resource files. Alex reviewed an earlier version and was
> > the one who suggested to also enable mmap() on PCI resources.  
> 
> The introduction of a new QEMU API for accessing MMIO BARs in this
> series is something Alex might be interested in as QEMU VFIO maintainer.
> That wouldn't have been part of the kernel patch review.
> 
> If he's aware of the new API he can encourage other VFIO users to use it
> in the future so that you won't need to convert them to work on s390x
> again.

I don't claim any jurisdiction over the vfio-nvme driver.  In general
vfio users should be using either vfio_region_ops, ram_device_mem_ops,
or directly mapping MMIO into the VM address space.  The first uses
pread/write through the region offset, irrespective of the type of
memory, the second provides the type of access used here where we're
dereferencing into an mmap, and the last if of course the preferred
mechanism where available.

It is curious that the proposal here doesn't include any changes to
ram_device_mem_ops for more generically enabling MMIO access on s390x.
Thanks,

Alex


