Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E75C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6I0j-0006pt-Ax; Mon, 14 Sep 2026 21:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x6I0c-0006pF-97
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:30:55 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x6I0a-0000MK-H5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 21:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789435852; x=1820971852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3UIufz+u1EznBYc8e0fT+S7hvsPTwXMo2JrfLZogTj8=;
 b=Qh3DQgDANwP13c0cVGBnbOsrns/0lZLLSVEq6oPYE90tj+AZycNjJ+yI
 xYIs0AhIkz5ozJYb++tvTTN1CCO3cIjM6oqHulUtmi0Yafzg95lqlVEPU
 VE2xLdGOkUfZUP0jWyKoCeYXDcDYL1GwcL2xHz+BoDWS1mxWMEP9j4sxp
 FHPZHICAj0AxN9OtVgJmWw6D4Iq/WAugr8E8AQp4Ic2Ntw4xVJH0OBr+T
 qWLFg5t1Qs9R4cjxhfZHVYXVID1zA5ODoEDYyRg46qGTwpmxflKqg9N99
 p+JNlLZZEcBEWp7JS8jVujmhxJCL1HrL3pUneKphh+FIbx19FcA3RdeuW A==;
X-CSE-ConnectionGUID: gxPgynqbQ4C/AmzJOfHCfw==
X-CSE-MsgGUID: OYxDeBviSDqqHXMhr55piQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93491753"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93491753"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 18:30:47 -0700
X-CSE-ConnectionGUID: evG5OCG+Twy8AlgRGdyfwg==
X-CSE-MsgGUID: 3CamE945TCSUrZEUa1CS4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="274744293"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 18:30:46 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Tomita Moeko <tomitamoeko@gmail.com>,
	Yuan Wang <yuan1.wang@intel.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Cedric Le Goater <clg@redhat.com>, bosheng.xue@intel.com
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
Date: Tue, 15 Sep 2026 09:30:37 +0800
Message-ID: <20260915013037.648161-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
References: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, 14 Sep 2026 16:41:58 +0800, Tomita Moeko wrote:
> Just curious, on host side, does the value of 0x1080C0 equals (BAR2 + 8M)
> on Meteor and Arrow Lake?

No.  Measured on Meteor Lake-P (8086:7d55, host i915):

  BAR2 (LMEMBAR)            0x4000000000, 256MB
  MMIO 0x108100 GSMBASE     0x70000000
  MMIO 0x1080C0 DSMBASE     0x70800000      (GSMBASE + 8MB)
  MMIO 0x108040 GGC         0x4c0           (GGMS=3, GMS=4 -> 128MB)
  config 0x50 GGC           0x4c0
  config 0x5C               0
  config 0xC0-0xC3          MSI Pending Bits (MSI cap at 0xac, 64-bit + PVM)
  config 0xC4-0xC7          0
  MMIO 0x138914             1
  /proc/iomem               64000000-787fffff : Reserved

DSMBASE is a system physical address inside the BIOS reserved range, and
DSMBASE + 128MB is exactly the end of that range.  BAR2 + 8M is the
aperture onto the same memory: i915_gem_stolen.c and xe_ttm_stolen_mgr.c
use either DSMBASE or LMEMBAR + 8M as the io base of the same stolen
region.

So with igd_gen() == -1, where no BAR0 quirk is installed, a guest reads
the host physical DSMBASE from 0x1080C0.  Given Yuan's point that the
GOP reads this register for its stolen base, that is a host address
handed to guest firmware, and something QEMU should fix.

> My concern is that if guest driver still uses (BAR2 + 8M) as DSM base, while
> 0x1080C0 pointing to the mocked region, will this bring any inconsistency?

The drivers map stolen on MTL+ with DM-flagged PTEs as offsets from
GSMBASE (xe_ttm_stolen_mgr.c; i915 sets PTE_LM for stolen-local), which
a region in guest RAM cannot satisfy.  Whether the GOP maps its frame
buffer the same way I cannot check from here.  Yuan, if the display has
come up for you with v2 and the stock GOP, that answers it; the variant
below does not depend on the answer.

> Having the register pointing to guest's (BAR2 + 8M) sounds more reasonable,
> but it would require more efforts, monitoring config space writes to BAR2 and
> changing the emulated value in QEMU.

Agree with the direction, and it is cheaper than that: a read-only BAR0
quirk can take pci_get_bar_addr(pdev, 2) at read time, returning BAR2 at
0x108100 and BAR2 + 8M at 0x1080C0.  Then the CPU-side address resolves
to real stolen memory through the aperture instead of guest RAM,
bdsm-size stays 0 as documented, and nothing in config space is
invented.

> Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914) to
> disallowed in QEMU, if the GOP driver code checks it, to enforce the access
> via BAR2 in guest.

0x138914 reads 1 on the host and is not quirked, so a guest sees 1 too.
Returning 0 there is a small addition and covers a GOP that checks it;
the DSMBASE quirk covers one that does not.  On the Wa itself: i915
already takes the BAR path in guests (i915_run_as_guest() short-circuits
i915_direct_stolen_access()), so that path has upstream precedent; we
have not measured whether the hang reproduces there.

The firmware still has to program ASLS.  The IgdAssignmentDxe build the
v2 commit message describes aborts on bdsm-size=0 before doing so;
VfioIgdPkg has no such check and programs ASLS for MTL+ as is.

I'll write the quirk.  It can go into Yuan's v3 or on top of it as a
separate patch -- Yuan, your call.  Either way it needs a run with the
stock GOP build on your setup.

Junjie

