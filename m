Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80011C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 03:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKUwG-0007Ms-Fm; Thu, 20 Jun 2024 23:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sKUwE-0007Mi-Ok
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 23:27:46 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sKUwB-0007lv-0Y
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 23:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718940463; x=1750476463;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=17fw1GTBVOWHxEJoAbWu7804W8yc+O3OGKrAhzVIM98=;
 b=JtRAi6TqiU1yNazsNLDist+9cJcdwRU5uuC9EXIB2XQsSsoJR+LgTd2Z
 Q9t3c1vYgodK4DTJmfdBX4el26F5XocBxoc6nLx32PZmbXKIVN8NZssuK
 KSMuvxT7KHE8CwrwZSQipaAp5edZ+crp6y4CkqATGdJUEbWByygB8pHu2
 wI6tyXqcISVJ5xV1jbyIJMR1zmw56VCrsgTdqdSo9+XknKcyZMPhcsWuf
 31/2nQKssbXy0tbt7srSZm2uD9KJf2xBMcQPa1qgE+53f2Wj21Cw5wfbZ
 jdxBHPcuLvljsgSu/Zq8OEn7gCn5gKwLX/BFWHgjedond1aV2EKNEYa7K Q==;
X-CSE-ConnectionGUID: zfKn3D/2Ru+cUcA0C1ArfA==
X-CSE-MsgGUID: 2HYiEG1/Tgapp718jafISA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15790548"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="15790548"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 20:27:39 -0700
X-CSE-ConnectionGUID: bEA1P2dtShC0IpkoRsdbLQ==
X-CSE-MsgGUID: y7ZKXGvVSnO7AvN2dVbO7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="47391227"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com)
 ([10.238.208.55])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 20:27:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <imammedo@redhat.com>,  <mst@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  <qemu-devel@nongnu.org>,  <ankita@nvidia.com>,
 <marcel.apfelbaum@gmail.com>,  <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  <linuxarm@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>,  <linux-cxl@vger.kernel.org>,  Michael Roth
 <michael.roth@amd.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 qemu 00/11] acpi: NUMA nodes for CXL HB as GP +
 complex NUMA test
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Thu, 20 Jun 2024 17:03:08 +0100")
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Date: Fri, 21 Jun 2024 11:25:44 +0800
Message-ID: <87jzij0yfb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=198.175.65.19; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> v3: Thanks to Richard for help debugging BE issue and to Igor for
>     finding a bunch of other thing to improve via the context in
>     the fix patch.
>     
> - Fix the big endian host/little endian guest issue in the HID being
>   written to the Generic Port Affinity Structure ACPI Device Handle.
> - Fix a bug in the ordering of bus vs devfn in the BDF field which is
>   reversed in the ACPI table wrt to QEMU's internal handling. Note the
>   fix is minimal and refactored later in the series.
> - Move original GI code to hw/acpi/aml-build.c and hw/acpi/pc.c as
>   no need for a separate file and this keeps the SRAT entry building
>   all in one place.
> - Use properties for the pci bus number and the ACPI UID to avoid
>   using pci internal implementation details in hw/acpi.
> - Drop the GenericNode base object as much less code is unified with
>   the new approach to the aml building and that approach did not bring
>   sufficient advantages to be worthwhile after other refactors.
>   A little more duplication occurs in v3 but the code is easier to read.
>
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

When developing the Linux kernel patchset "[PATCH v3 0/3] cxl/region:
Support to calculate memory tier abstract distance" as in [1].

[1] https://lore.kernel.org/linux-cxl/20240618084639.1419629-1-ying.huang@intel.com/

I use this patchset to test my kernel patchset and it works great!
Thanks!

Feel free to add my

Tested-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

>
> Jonathan Cameron (11):
>   hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
>   hw/acpi/GI: Fix trivial parameter alignment issue.
>   hw/acpi: Move AML building code for Generic Initiators to aml_build.c
>   hw/acpi: Rename build_all_acpi_generic_initiators() to
>     build_acpi_generic_initiator()
>   hw/pci: Add a bus property to pci_props and use for acpi/gi
>   acpi/pci: Move Generic Initiator object handling into acpi/pci.*
>   hw/pci-bridge: Add acpi_uid property to CXL PXB
>   hw/acpi: Generic Port Affinity Structure support
>   bios-tables-test: Allow for new acpihmat-generic-x test data.
>   bios-tables-test: Add complex SRAT / HMAT test for GI GP
>   bios-tables-test: Add data for complex numa test (GI, GP etc)
>
>  qapi/qom.json                               |  34 +++
>  include/hw/acpi/acpi_generic_initiator.h    |  30 +--
>  include/hw/acpi/aml-build.h                 |   8 +
>  include/hw/acpi/pci.h                       |   7 +
>  include/hw/pci/pci_bridge.h                 |   1 +
>  hw/acpi/acpi_generic_initiator.c            | 132 +++++++++---
>  hw/acpi/aml-build.c                         |  84 ++++++++
>  hw/acpi/pci.c                               | 226 ++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                    |   3 +-
>  hw/i386/acpi-build.c                        |   3 +-
>  hw/pci-bridge/pci_expander_bridge.c         |  18 +-
>  hw/pci/pci.c                                |  14 ++
>  tests/qtest/bios-tables-test.c              |  96 +++++++++
>  hw/acpi/meson.build                         |   1 -
>  tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
>  tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
>  tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10849 bytes
>  tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
>  tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
>  19 files changed, 597 insertions(+), 60 deletions(-)
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x

--
Best Regards,
Huang, Ying

