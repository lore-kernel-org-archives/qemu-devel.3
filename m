Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A1E9128B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuWR-0003G8-6Q; Thu, 05 Feb 2026 03:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuWG-0003EY-Rz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnuWE-0003us-Su
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770279318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bc1BOQ3rsAm6eCmXX67HOx5s1L4t7ZLDykW/kGCNqLQ=;
 b=JHONLMsXy0qaZM0eqqF4AyGcFuYhFzmHMeYMwAjhMwIb8CqBEijAhE5P3dM111/bIX3pa5
 ghmz3WqgfgiTqZ20NzgJLItVpQuTSBK8B+Sq3MatFFYWknqEPSVe5nzjL46d0L+ow/KdyG
 4943DpNx0LehmuafcRQOyzLoNosA48k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-uk3__rXHOr6AQJMvk2O7CA-1; Thu, 05 Feb 2026 03:15:14 -0500
X-MC-Unique: uk3__rXHOr6AQJMvk2O7CA-1
X-Mimecast-MFC-AGG-ID: uk3__rXHOr6AQJMvk2O7CA_1770279313
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fb1c2c403so404162f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770279313; x=1770884113; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bc1BOQ3rsAm6eCmXX67HOx5s1L4t7ZLDykW/kGCNqLQ=;
 b=doM5PZbaKQ0STCXMLIJ02WABhpqJ95V3KhRStjbBR0e7Ax9dfbXoLNGMWuP7Q6uB1t
 EWc8W82zufkrJmW/GAtX/YE7IuY7eXoUX5SVw5wbkJEpaaYprSBG9ug1hEPNTaygCRz7
 TjqtHOic2587mS/zNp1V8XBYkaG5tAGR+FcwXBO0cR2o3xW4RCswLX0rwZXk3UAy5Qa7
 OdZEFpn0FExapgswvlWee0dQOjlWEcJdykUwBnEmS28ZkdycMA79zIZXPyLuVCTnsBPk
 i9tTFwZWMXM3WATluHCgYilpR+kK1fV+SO1iI10yXZE4MBs/TN7l05agkFNd44lE9fJP
 7IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770279313; x=1770884113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bc1BOQ3rsAm6eCmXX67HOx5s1L4t7ZLDykW/kGCNqLQ=;
 b=CA+pLFcl3mD5ESXEFOB4ZOLznHp3zAXSWjsq6UM64vBFlYxe1J6Kxd1oWfoDEHO+zj
 3Sv0w5vYrMaWH+UCi5b0hgwW00OLhwJdGtv/zMF8wUU88p6xhsn9V8RLZ+/iXjmvhqoT
 JZOB/B3XB07/9P9cPFj6iLAnEF6b2LQuVdB4anTn2WpGISE/7rfYXwQtsDXknjl7+M0p
 3UUc/UFLXNrVg3r5a1eA/YS79jhtx1RPO5Xszvv4fnosgSIL6QUApyLRNNB4DFz/6Uqa
 rGyWZl7+z/LhwtKc1XI3Os5Dlaby99zftEP62ECRUWDa3KP+UfKpHkmKrX0wX5gen2LD
 f8JQ==
X-Gm-Message-State: AOJu0YyskL3QiGHgkh6IiJP1t1PRrLkj04BX0BEco4yKOnhmzu9sf7s6
 whOBCiMExJzgrPiPXnN5/WDw6aiRTWFUwKdbaFTidoA4AkjaT4r7r+5rilmQZk8LYXSy2waGCek
 je9fcRIjqw7fdK4DRO0+TnXTpu3JRm4kTv3MnTYt6yT1saiSM4B+0mmZU
X-Gm-Gg: AZuq6aJzy8ZPQkofRZhnrFwakcoqTUXTffi2Y7dh+QTQE5JFbFGLMWwZWH3B30TCuPx
 xGV6vNdQg6qXfZ5kP/+qr0x1MaGLwkCS/Rxgo6D5JuA5WUHAYg8a0snHIIRu3Ntnjn74DU6kGuA
 8kdTBvLIuEnpUxfcaJxJ1BNuvwH828qdAAK5B2GLdmFWjrNGt/mAjIYJ5CQ1xNeD8hVSYsLW2U3
 VMaNqUPkwY+Q8/PUXWa05YBJ6IHckzkwZ55nMQqe0losvW5YpkkHiGyPbYg6NzuM9Y8hJr50Bhp
 XgNAlozk59FX+d8k+srDLWR0hdTDgeLyip7nTQMq8g1rZ/rGK3TxIpviXAeG09zXsL9ng9+D2Io
 S8kVk5FL2//0XkUs1DC3q+6I9wcp5CFAznQ==
X-Received: by 2002:a05:6000:2912:b0:435:9653:e151 with SMTP id
 ffacd0b85a97d-43617e3459emr8453208f8f.3.1770279313141; 
 Thu, 05 Feb 2026 00:15:13 -0800 (PST)
X-Received: by 2002:a05:6000:2912:b0:435:9653:e151 with SMTP id
 ffacd0b85a97d-43617e3459emr8453044f8f.3.1770279311148; 
 Thu, 05 Feb 2026 00:15:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805edcfsm11518408f8f.35.2026.02.05.00.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 00:15:10 -0800 (PST)
Date: Thu, 5 Feb 2026 03:15:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit
 mode)
Message-ID: <20260205031426-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
 <20260203153759-mutt-send-email-mst@kernel.org>
 <20260204111202.000051d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204111202.000051d2@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 04, 2026 at 11:12:02AM +0000, Jonathan Cameron wrote:
> On Tue, 3 Feb 2026 15:39:22 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:
> > > Lightly reworked version of Davidlohr's v4.
> > > https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> > > 
> > > Whilst I have several other series posted for merge this applies fine
> > > to upstream, so no dependencies.
> > > Davidlohr, please check I didn't mess anthing up and perhaps give tags
> > > for the 3 new patches.  
> > 
> > applying this on top does seem to conflict.
> > let me get rest merged then this can be rebased.
> Hi Michael
> 
> So I assume this is your v01-04-02-2026 branch.
> 
> I tried rebasing on that and ran into some issue.
> 
> Looks like you have a stale version of 
> [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> https://lore.kernel.org/all/20260119111542.788389-1-Jonathan.Cameron@huawei.com/
> 
> Markus had some comments that needed a new version.
> Mostly updating a few more version numbers in the comments to keep things consistent.

Right and *that* now has review comments so  it looks like there will be
v5 ...

> 
> Not sure that has anything to do with the merge conflict.

> > 
> > > v5 changes:
> > > - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
> > >   I was carrying that is not ready for upstream just yet.
> > > - Update the CFMWS flags directly as the patch doing restriction control needs
> > >   some more thought.
> > > - Bios tables test data updates.
> > > - Don't provide flit mode control for gen_pcie_root_port as we don't need it
> > >   for the rest of the series which is all about CXL.
> > > 
> > > The following allows support for component basic back invalidation discovery
> > > and config, by exposing the BI routing table and decoder registers. Instead
> > > of going the type2[0] route, this series proposes adding support for type3
> > > hdm-db, which allows a more direct way of supporting BI in qemu.
> > > 
> > > As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> > > add support for enabling that for CXL components. Negotiation is handled
> > > via an equivalent of what we do for link speed.
> > > 
> > > Davidlohr Bueso (3):
> > >   hw/pcie: Support enabling flit mode
> > >   hw/cxl: Support type3 HDM-DB
> > >   hw/cxl: Remove register special_ops->read()
> > > 
> > > Ira Weiny (1):
> > >   hw/cxl: Refactor component register initialization
> > > 
> > > Jonathan Cameron (3):
> > >   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
> > >     relaxation.
> > >   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
> > >     Back Invalidate support.
> > >   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> > > 
> > >  docs/system/devices/cxl.rst               |  23 +++
> > >  include/hw/cxl/cxl_component.h            |  87 +++++++--
> > >  include/hw/cxl/cxl_device.h               |   4 +
> > >  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
> > >  include/hw/pci/pcie.h                     |   2 +-
> > >  include/hw/pci/pcie_port.h                |   1 +
> > >  hw/acpi/cxl.c                             |   2 +-
> > >  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
> > >  hw/mem/cxl_type3.c                        |  15 +-
> > >  hw/pci-bridge/cxl_downstream.c            |  10 +-
> > >  hw/pci-bridge/cxl_root_port.c             |  11 +-
> > >  hw/pci-bridge/cxl_upstream.c              |  18 +-
> > >  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
> > >  hw/pci/pcie.c                             |  23 ++-
> > >  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
> > >  15 files changed, 313 insertions(+), 97 deletions(-)
> > > 
> > > -- 
> > > 2.48.1  
> > 
> > 
> > 


