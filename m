Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C0CC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBXN-00084Q-6r; Fri, 12 Apr 2024 03:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rvBXD-0007y2-HB
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:41:21 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rvBXA-0008SP-AU
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712907677; x=1744443677;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=fkT160FcodsgHreutSD9b+4ZNNdZN9OPIOXEmSJsNE0=;
 b=DIyk+rrJii+YxuNdFAzO2xFvqmT9IrE2lank6z8JmSg6SkpiGI/qm5LC
 5o/g3VHZB5cR8IX31lbuNjrE/ZRvWbAbTxDKb2IthL4S9/m5dOKlVC5ZX
 mH4CUSArKOeE4Tv3rzIEmd1wr/oeLqBfm1kCM2gx8/HHUb9r7BOKI5d4/
 AJKB/lGs6mhxuC3QUzKJuhm/9SvlI5vz5vq9vUfD5DePQUhnhU4jk/nwy
 e8WVMklw1Ufflmwu8EtxQ2Apxc/VFd8DTDMPsTLrOGpm/isY9BMgZpRY1
 vQT/vjwFC/4yB1mnVEnNmPfMomBdjjiJ7HXCZ3b1kaqILJRJQLdPxA1kG w==;
X-CSE-ConnectionGUID: wVK3meNFT76n9aKAL0Zjdw==
X-CSE-MsgGUID: DUkntrdNQwCt1lbPxRSypQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19505248"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; d="scan'208";a="19505248"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 00:41:13 -0700
X-CSE-ConnectionGUID: XHVRESQPQEikUULHY6yOmQ==
X-CSE-MsgGUID: pO6oeWWtTR+iT2W0x4aLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; d="scan'208";a="25825579"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com)
 ([10.238.208.55])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 00:41:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>,  <imammedo@redhat.com>,
 <linux-cxl@vger.kernel.org>,  <linuxarm@huawei.com>,  Markus Armbruster
 <armbru@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 0/6 qemu] acpi: NUMA nodes for CXL HB as GP + complex
 NUMA test.
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Wed, 3 Apr 2024 11:29:21 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
Date: Fri, 12 Apr 2024 15:39:16 +0800
Message-ID: <878r1j58t7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=198.175.65.13; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> ACPI 6.5 introduced Generic Port Affinity Structures to close a system
> description gap that was a problem for CXL memory systems.
> It defines an new SRAT Affinity structure (and hence allows creation of an
> ACPI Proximity Node which can only be defined via an SRAT structure)
> for the boundary between a discoverable fabric and a non discoverable
> system interconnects etc.
>
> The HMAT data on latency and bandwidth is combined with discoverable
> information from the CXL bus (link speeds, lane counts) and CXL devices
> (switch port to port characteristics and USP to memory, via CDAT tables
> read from the device).  QEMU has supported the rest of the elements
> of this chain for a while but now the kernel has caught up and we need
> the missing element of Generic Ports (this code has been used extensively
> in testing and debugging that kernel support, some resulting fixes
> currently under review).
>
> Generic Port Affinity Structures are very similar to the recently
> added Generic Initiator Affinity Structures (GI) so this series
> factors out and reuses much of that infrastructure for reuse
> There are subtle differences (beyond the obvious structure ID change).
>
> - The ACPI spec example (and linux kernel support) has a Generic
>   Port not as associated with the CXL root port, but rather with
>   the CXL Host bridge. As a result, an ACPI handle is used (rather
>   than the PCI SBDF option for GIs). In QEMU the easiest way
>   to get to this is to target the root bridge PCI Bus, and
>   conveniently the root bridge bus number is used for the UID allowing
>   us to construct an appropriate entry.
>
> A key addition of this series is a complex NUMA topology example that
> stretches the QEMU emulation code for GI, GP and nodes with just
> CPUS, just memory, just hot pluggable memory, mixture of memory and CPUs.
>
> A similar test showed up a few NUMA related bugs with fixes applied for
> 9.0 (note that one of these needs linux booted to identify that it
> rejects the HMAT table and this test is a regression test for the
> table generation only).
>
> https://lore.kernel.org/qemu-devel/2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com/
> https://lore.kernel.org/qemu-devel/74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com/
>

Thanks a lot for your work!

I need this to test some memory tiering kernel patches.  I found the
following git branch,

https://gitlab.com/jic23/qemu/-/commits/cxl-2024-03-05/?ref_type=heads

Can I use that branch directly?

And, can you share an example qemu command line to setup Genport, CDAT,
and HMAT?

--
Best Regards,
Huang, Ying

