Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribns-0008Ob-5X; Fri, 08 Mar 2024 10:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ribnq-0008OS-S0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:06:30 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ribnn-0000Vw-OE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709910388; x=1741446388;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=S1lLvfwfWiUZB7ksaDxd1THBf9npT8bLhTIJUcP1pFw=;
 b=iyvK4vrc6fRX3IdwSDJAhnk2VyPniguFj6jsPPnuMKSDr/Q1HZXax95C
 woz41K48IEasuW7BdQ5o4Qgt86qFzSYRZxMEKjj0fGY5EKP9XryRDtBQL
 XpW9WpspObarr5fISDh5REEI8igncD9zUpq3COHU//fmOZVlrWyXRitrb
 xnLXKfFHzHwIr+tFbhXwwnu1ywIupeqRL5CGHdP6Suy5T7Kkjylgq8COE
 higgSgzUi233HEnOKRFd3iFX61s0zSFCIsFBwwhFQndq/NvY/mDXZvzQP
 P9LNIpGYFigAsOiUIVfxZo726/vunh+sOL2VunVTeaYQ3W5k5QiP2pwNc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8385060"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8385060"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="15149549"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 08 Mar 2024 07:06:20 -0800
Date: Fri, 8 Mar 2024 23:20:07 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
Message-ID: <Zessp6A8CBpjM9qC@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <Zd28YNJnUaJUtRlR@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd28YNJnUaJUtRlR@intel.com>
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Paolo & Michael,

Just a kindly ping, could you please take time to review this series
when you're free?

(This is also the foundation support of hybrid topology).

Many thanks,
Zhao

On Tue, Feb 27, 2024 at 06:41:36PM +0800, Zhao Liu wrote:
> Date: Tue, 27 Feb 2024 18:41:36 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: Re: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
> 
> Hi Paolo & Michael,
> 
> BTW, may I ask if this series could land in v9.0? ;-)
> 
> Thanks,
> Zhao
> 
> On Tue, Feb 27, 2024 at 06:32:10PM +0800, Zhao Liu wrote:
> > Date: Tue, 27 Feb 2024 18:32:10 +0800
> > From: Zhao Liu <zhao1.liu@linux.intel.com>
> > Subject: [PATCH v9 00/21] Introduce smp.modules for x86 in QEMU
> > X-Mailer: git-send-email 2.34.1
> > 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Hi list,
> > 
> > This is the our v9 patch series, rebased on the master branch at the
> > commit 03d496a992d9 ("Merge tag 'pull-qapi-2024-02-26' of
> > https://repo.or.cz/qemu/armbru into staging").
> > 
> > Compared with v8 [1], v9 mainly added more module description in commit
> > message and added missing smp.modules description/documentation.
> > 
> > With the general introduction (with origial cluster level) of this
> > secries in v7 [2] cover letter, the following sections are mainly about
> > the description of the newly added smp.modules (since v8, changed x86
> > cluster support to module) as supplement.
> > 
> > Since v4 [3], we've dropped the original L2 cache command line option
> > (to configure L2 cache topology) and now we have the new RFC [4] to
> > support the general cache topology configuration (as the supplement to
> > this series).
> > 
> > Welcome your comments!
> > 
> > 
> > Why We Need a New CPU Topology Level
> > ====================================
> > 
> > For the discussion in v7 about whether we should reuse current
> > smp.clusters for x86 module, the core point is what's the essential
> > differences between x86 module and general cluster.
> > 
> > Since, cluster (for ARM/riscv) lacks a comprehensive and rigorous
> > hardware definition, and judging from the description of smp.clusters
> > [5] when it was introduced by QEMU, x86 module is very similar to
> > general smp.clusters: they are all a layer above existing core level
> > to organize the physical cores and share L2 cache.
> > 
> > But there are following reasons that drive us to introduce the new
> > smp.modules:
> > 
> >   * As the CPU topology abstraction in device tree [6], cluster supports
> >     nesting (though currently QEMU hasn't support that). In contrast,
> >     (x86) module does not support nesting.
> > 
> >   * Due to nesting, there is great flexibility in sharing resources
> >     on cluster, rather than narrowing cluster down to sharing L2 (and
> >     L3 tags) as the lowest topology level that contains cores.
> > 
> >   * Flexible nesting of cluster allows it to correspond to any level
> >     between the x86 package and core.
> > 
> >   * In Linux kernel, x86's cluster only represents the L2 cache domain
> >     but QEMU's smp.clusters is the CPU topology level. Linux kernel will
> >     also expose module level topology information in sysfs for x86. To
> >     avoid cluster ambiguity and keep a consistent CPU topology naming
> >     style with the Linux kernel, we introduce module level for x86.
> > 
> > Based on the above considerations, and in order to eliminate the naming
> > confusion caused by the mapping between general cluster and x86 module,
> > we now formally introduce smp.modules as the new topology level.
> > 
> > 
> > Where to Place Module in Existing Topology Levels
> > =================================================
> > 
> > The module is, in existing hardware practice, the lowest layer that
> > contains the core, while the cluster is able to have a higher topological
> > scope than the module due to its nesting.
> > 
> > Therefore, we place the module between the cluster and the core:
> > 
> >     drawer/book/socket/die/cluster/module/core/thread
> > 
> > 
> > Additional Consideration on CPU Topology
> > ========================================
> > 
> > Beyond this patchset, nowadays, different arches have different topology
> > requirements, and maintaining arch-agnostic general topology in SMP
> > becomes to be an increasingly difficult thing due to differences in
> > sharing resources and special flexibility (e.g., nesting):
> > 
> >   * It becomes difficult to put together all CPU topology hierarchies of
> >     different arches to define complete topology order.
> > 
> >   * It also becomes complex to ensure the correctness of the topology
> >     calculations.
> >       - Now the max_cpus is calculated by multiplying all topology
> >         levels, and too many topology levels can easily cause omissions.
> > 
> > Maybe we should consider implementing arch-specfic topology hierarchies.
> > 
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20240131101350.109512-1-zhao1.liu@linux.intel.com/
> > [2]: https://lore.kernel.org/qemu-devel/20240108082727.420817-1-zhao1.liu@linux.intel.com/
> > [3]: https://lore.kernel.org/qemu-devel/20231003085516-mutt-send-email-mst@kernel.org/
> > [4]: https://lore.kernel.org/qemu-devel/20240220092504.726064-1-zhao1.liu@linux.intel.com/
> > [5]: https://lore.kernel.org/qemu-devel/c3d68005-54e0-b8fe-8dc1-5989fe3c7e69@huawei.com/
> > [6]: https://www.kernel.org/doc/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > 
> > Thanks and Best Regards,
> > Zhao
> > ---
> > Changelog:
> > 
> > Changes since v8:
> >  * Add the reason of why a new module level is needed in commit message.
> >    (Markus).
> >  * Add the description about how Linux kernel supports x86 module level
> >    in commit message. (Daniel)
> >  * Add module description in qemu_smp_opts.
> >  * Add missing "modules" parameter of -smp example in documentation.
> >  * Add Philippe's reviewed-by tag.
> > 
> > Changes since v7 (main changes):
> >  * Introduced smp.modules as a new CPU topology level. (Xiaoyao)
> >  * Fixed calculations of cache_info_passthrough case in the
> >    patch "i386/cpu: Use APIC ID info to encode cache topo in
> >    CPUID[4]". (Xiaoyao)
> >  * Moved the patch "i386/cpu: Use APIC ID info get NumSharingCache
> >    for CPUID[0x8000001D].EAX[bits 25:14]" after CPUID[4]'s similar
> >    change ("i386/cpu: Use APIC ID offset to encode cache topo in
> >    CPUID[4]"). (Xiaoyao)
> >  * Introduced a bitmap in CPUX86State to cache available CPU topology
> >    levels.
> >  * Refactored the encode_topo_cpuid1f() to use traversal to search the
> >    encoded level and avoid using static variables.
> >  * Mapped x86 module to smp module instead of cluster.
> >  * Dropped Michael/Babu's ACKed/Tested tags for most patches since the
> >    code change.
> > 
> > Changes since v6:
> >  * Updated the comment when check cluster-id. Since there's no
> >    v8.2, the cluster-id support should at least start from v9.0.
> >  * Rebased on commit d328fef93ae7 ("Merge tag 'pull-20231230' of
> >    https://gitlab.com/rth7680/qemu into staging").
> > 
> > Changes since v5:
> >  * The first four patches of v5 [1] have been merged, v6 contains
> >    the remaining patches.
> >  * Reabsed on the latest master.
> >  * Updated the comment when check cluster-id. Since current QEMU is
> >    v8.2, the cluster-id support should at least start from v8.3.
> > 
> > Changes since v4:
> >  * Dropped the "x-l2-cache-topo" option. (Michael)
> >  * Added A/R/T tags.
> > 
> > Changes since v3 (main changes):
> >  * Exposed module level in CPUID[0x1F].
> >  * Fixed compile warnings. (Babu)
> >  * Fixed cache topology uninitialization bugs for some AMD CPUs. (Babu)
> > 
> > Changes since v2:
> >  * Added "Tested-by", "Reviewed-by" and "ACKed-by" tags.
> >  * Used newly added wrapped helper to get cores per socket in
> >    qemu_init_vcpu().
> > 
> > Changes since v1:
> >  * Reordered patches. (Yanan)
> >  * Deprecated the patch to fix comment of machine_parse_smp_config().
> >    (Yanan)
> >  * Renamed test-x86-cpuid.c to test-x86-topo.c. (Yanan)
> >  * Split the intel's l1 cache topology fix into a new separate patch.
> >    (Yanan)
> >  * Combined module_id and APIC ID for module level support into one
> >    patch. (Yanan)
> >  * Made cache_into_passthrough case of cpuid 0x04 leaf in
> >  * cpu_x86_cpuid() used max_processor_ids_for_cache() and
> >    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
> >  * Added the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
> >    (Yanan)
> > ---
> > Zhao Liu (20):
> >   hw/core/machine: Introduce the module as a CPU topology level
> >   hw/core/machine: Support modules in -smp
> >   hw/core: Introduce module-id as the topology subindex
> >   hw/core: Support module-id in numa configuration
> >   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
> >   i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]
> >   i386/cpu: Use APIC ID info get NumSharingCache for
> >     CPUID[0x8000001D].EAX[bits 25:14]
> >   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
> >   i386/cpu: Introduce bitmap to cache available CPU topology levels
> >   i386: Split topology types of CPUID[0x1F] from the definitions of
> >     CPUID[0xB]
> >   i386/cpu: Decouple CPUID[0x1F] subleaf with specific topology level
> >   i386: Introduce module level cpu topology to CPUX86State
> >   i386: Support modules_per_die in X86CPUTopoInfo
> >   i386: Expose module level in CPUID[0x1F]
> >   i386: Support module_id in X86CPUTopoIDs
> >   i386/cpu: Introduce module-id to X86CPU
> >   hw/i386/pc: Support smp.modules for x86 PC machine
> >   i386: Add cache topology info in CPUCacheInfo
> >   i386/cpu: Use CPUCacheInfo.share_level to encode CPUID[4]
> >   i386/cpu: Use CPUCacheInfo.share_level to encode
> >     CPUID[0x8000001D].EAX[bits 25:14]
> > 
> > Zhuocheng Ding (1):
> >   tests: Add test case of APIC ID for module level parsing
> > 
> >  hw/core/machine-hmp-cmds.c |   4 +
> >  hw/core/machine-smp.c      |  41 +++--
> >  hw/core/machine.c          |  18 +++
> >  hw/i386/pc.c               |   1 +
> >  hw/i386/x86.c              |  67 ++++++--
> >  include/hw/boards.h        |   4 +
> >  include/hw/i386/topology.h |  60 +++++++-
> >  qapi/machine.json          |   7 +
> >  qemu-options.hx            |  18 ++-
> >  system/vl.c                |   3 +
> >  target/i386/cpu.c          | 304 +++++++++++++++++++++++++++++--------
> >  target/i386/cpu.h          |  29 +++-
> >  target/i386/kvm/kvm.c      |   3 +-
> >  tests/unit/test-x86-topo.c |  56 ++++---
> >  14 files changed, 489 insertions(+), 126 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 

