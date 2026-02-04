Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77D6E95386
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnao9-0007Ef-MF; Wed, 04 Feb 2026 06:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnao8-0007ER-5B
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:12:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vnao5-0005Nn-3T
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:12:27 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5d2X1KytzJ46hN;
 Wed,  4 Feb 2026 19:11:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C38640565;
 Wed,  4 Feb 2026 19:12:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 11:12:04 +0000
Date: Wed, 4 Feb 2026 11:12:02 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Davidlohr Bueso <dave@stgolabs.net>,
 <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
 <venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe
 Flit mode)
Message-ID: <20260204111202.000051d2@huawei.com>
In-Reply-To: <20260203153759-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
 <20260203153759-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 3 Feb 2026 15:39:22 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 09, 2026 at 02:45:04PM +0000, Jonathan Cameron wrote:
> > Lightly reworked version of Davidlohr's v4.
> > https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
> > 
> > Whilst I have several other series posted for merge this applies fine
> > to upstream, so no dependencies.
> > Davidlohr, please check I didn't mess anthing up and perhaps give tags
> > for the 3 new patches.  
> 
> applying this on top does seem to conflict.
> let me get rest merged then this can be rebased.
Hi Michael

So I assume this is your v01-04-02-2026 branch.

I tried rebasing on that and ran into some issue.

Looks like you have a stale version of 
[PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/all/20260119111542.788389-1-Jonathan.Cameron@huawei.com/

Markus had some comments that needed a new version.
Mostly updating a few more version numbers in the comments to keep things consistent.

Not sure that has anything to do with the merge conflict.

> 
> > v5 changes:
> > - Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
> >   I was carrying that is not ready for upstream just yet.
> > - Update the CFMWS flags directly as the patch doing restriction control needs
> >   some more thought.
> > - Bios tables test data updates.
> > - Don't provide flit mode control for gen_pcie_root_port as we don't need it
> >   for the rest of the series which is all about CXL.
> > 
> > The following allows support for component basic back invalidation discovery
> > and config, by exposing the BI routing table and decoder registers. Instead
> > of going the type2[0] route, this series proposes adding support for type3
> > hdm-db, which allows a more direct way of supporting BI in qemu.
> > 
> > As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
> > add support for enabling that for CXL components. Negotiation is handled
> > via an equivalent of what we do for link speed.
> > 
> > Davidlohr Bueso (3):
> >   hw/pcie: Support enabling flit mode
> >   hw/cxl: Support type3 HDM-DB
> >   hw/cxl: Remove register special_ops->read()
> > 
> > Ira Weiny (1):
> >   hw/cxl: Refactor component register initialization
> > 
> > Jonathan Cameron (3):
> >   tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
> >     relaxation.
> >   hw/cxl: Update CXL Fixed Memory Window ACPI description to include
> >     Back Invalidate support.
> >   tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
> > 
> >  docs/system/devices/cxl.rst               |  23 +++
> >  include/hw/cxl/cxl_component.h            |  87 +++++++--
> >  include/hw/cxl/cxl_device.h               |   4 +
> >  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
> >  include/hw/pci/pcie.h                     |   2 +-
> >  include/hw/pci/pcie_port.h                |   1 +
> >  hw/acpi/cxl.c                             |   2 +-
> >  hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
> >  hw/mem/cxl_type3.c                        |  15 +-
> >  hw/pci-bridge/cxl_downstream.c            |  10 +-
> >  hw/pci-bridge/cxl_root_port.c             |  11 +-
> >  hw/pci-bridge/cxl_upstream.c              |  18 +-
> >  hw/pci-bridge/pci_expander_bridge.c       |   2 +-
> >  hw/pci/pcie.c                             |  23 ++-
> >  tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
> >  15 files changed, 313 insertions(+), 97 deletions(-)
> > 
> > -- 
> > 2.48.1  
> 
> 
> 


