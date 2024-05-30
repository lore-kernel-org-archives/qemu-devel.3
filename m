Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D1C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcaI-0002oX-8T; Thu, 30 May 2024 06:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcaF-0002ni-Rc; Thu, 30 May 2024 06:00:31 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcaA-0003Oy-Tj; Thu, 30 May 2024 06:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717063227; x=1748599227;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TtXu0VLto2q3SkPtsuFYXb+UPjylNzuI8i3aZhgLdgQ=;
 b=ByHehjyVOA+LbcJSKLC20nQU8DySoiEa40m58g8efxGI654wFWVx6nlo
 E02+22tJWP2e33La/9sWPrKNyz0CBe4fUP7j2kFvT8tu7yiQnTfxZBQ1e
 GfxP+vSlSmWzefjzK71A7fl7JEvUUnyjD1ARh8atF+yPq2n1ByuXVk9o+
 p9KQBtY4haQZY5FgLn3U3IUerMkowkGHvY9j0MurtKQWcN1MdC37K2+9Z
 AyobRmVrAnCI/fiS7fnpxAfW7rKUQnawyTY3Gh7vOra9ZTLzqihCSUGDj
 nrOsKbzFvAJvMlYHAmW1IfEV1Pz660kYf4vEMDFD+LCeFF6TqCH5PiGy0 Q==;
X-CSE-ConnectionGUID: aYbof6ipRsW4Y/gYcQv0pQ==
X-CSE-MsgGUID: ouvTfslYQPmIO3xkBac6rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="31032384"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="31032384"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 03:00:23 -0700
X-CSE-ConnectionGUID: EaFcev0uRfGNg3viRyapFQ==
X-CSE-MsgGUID: wfpIBVOWTnKtt7iwC5OZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="35704868"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 30 May 2024 03:00:17 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 0/7] Introduce SMP Cache Topology
Date: Thu, 30 May 2024 18:15:32 +0800
Message-Id: <20240530101539.768484-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

Hi,

Now that the i386 cache model has been able to define the topology
clearly, it's time to move on to discussing/advancing this feature about
configuring the cache topology with -smp as the following example:

-smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
     l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die

With the new cache topology options ("l1d-cache", "l1i-cache",
"l2-cache" and "l3-cache"), we could adjust the cache topology via -smp.

But in a recent discussion with Daniel, I think there's currently
uncertainty as to whether newly added parameters should have default
parameter values added or should be omitted by default...therefore, I
keep the "RFC" tag for this series.

For my difficulties with this OPEN, see the first section below ("Open
about How to Handle the Default Options").


This patch set is based on a little cleanup:
https://lore.kernel.org/qemu-devel/20240527131837.2630961-1-zhao1.liu@intel.com/

And you can find the RFC v1 there:
https://lore.kernel.org/qemu-devel/20240220092504.726064-1-zhao1.liu@linux.intel.com/

Since the ARM [1] and RISC-V [2] folks have similar needs for the cache
topology, I also cc'd the ARM and RISC-V folks and lists.

I've gone to explain the current problem much in the first section
below, and I appreciate your time your patience. Welcome your feedback!


Open about How to Handle the Default Options
============================================

(For the detailed description of this series, pls skip this "long"
section and review the subsequent content.)


Background of OPEN
------------------

Daniel and I discussed initial thoughts on cache topology, and there was
an idea that the default *cache_topo is on the CORE level [3]:

> simply preferring "cores" for everything is a reasonable
> default long term plan for everything, unless the specific
> architecture target has no concept of "cores".

The original purpose of considering *_cache_topo=core was to achieve
similar behavior like "parameters=1" supported by other CPU topology
options in -smp.

This way, even if machine doesn't support configuring cache topology (by
l1_separated_cache_supported/[l2|l3]_unified_cache_supported = false),
such a *_cache_topo=core can be treated as a valid parameter, except
that it will be quietly ignored.

This has the advantage of facilitating upper-level libvirt support;
currently, there is no way for cache topology support information to be
exposed to libvirt, so libvirt doesn't know which machines to give
support to for these cache topology options.

However, I have a problem here.


Problem with this OPEN
----------------------

Some arches have their own arch-specific cache topology, such as l1 per
core/l2 per core/l3 per die for i386. And as Jeehang proposed for
RISC-V, the cache topologies are like: l1/l2 per core and l3 per
cluster. 

Taking L3 as an example, logically there is a difference between the two
starting points of user-specified core level and with the default core
level.

For example,

"(user-specified) l3-cache-topo=core" should override i386's default l3
per core, but i386's default l3 per core should also override
"(default) l3-cache-topo=core" because this default value is like a
placeholder that specifies nothing.

However, from a command line parsing perspective, it's impossible to
tell what the “l3-cache-topo=core” setting is for...


Options to solve OPEN
---------------------

So, I think we have the following options:


1. Can we avoid such default parameters?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This would reduce the pain in QEMU, but I'm not sure if it's possible to
make libvirt happy?

It is also possible to expose Cache topology information as the CPU
properties in “query-cpu-model-expansion type=full”, but that adds
arch-specific work.

If omitted, I think it's just like omitting “cores”/“sockets”,
leaving it up to the machine to decide based on the specific CPU model
(and now the cache topology is indeed determined by the CPU model as
well).


2. If default is required, can we use a specific abstract word?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

That is, is it possible to use a specific word like “auto”/“invalid”
/“default” and avoid a specific topology level?

Like setting “l3-cache-topo=invalid” (since I've only added the invalid
hierarchy so far ;-) ).

I found the cache topology of arches varies so much that I'm sorry to
say it's hard to have a uniform default cache topology.


I apologize for the very lengthy note and appreciate you reviewing it
here as well as your time!


Introduction
============

Background
----------

Intel client platforms (ADL/RPL/MTL) and E core server platforms (SRF)
share the L2 cache domain among multiple E cores (in the same module).

Thus we need a way to adjust the cache topology so that users could
create the cache topology for Guest that is nearly identical to Host.

This is necessary in cases where there are bound vCPUs, especially
considering that Guest scheduling often takes into account the cache
topology as well (e.g. Linux cluster aware scheduling, i.e. L2 cache
scheduling).

Previously, we introduced a x86 specific option to adjust the cache
topology:

-cpu x-l2-cache-topo=[core|module] [4]

However, considering the needs of other arches, we re-implemented the
generic cache topology (aslo in response to Michael's [5] and Daniel's
comment [6]) in this series.


Cache Topology Representation
-----------------------------

We consider to define the cache topology based on CPU topology level for
two reasons:

1. In practice, a cache will always be bound to the CPU container -
   "CPU container" indicates to a set of CPUs that refer to a certain
   level of CPU topology - where the cache is either private in that
   CPU container or shared among multiple containers.

2. The x86's cache-related CPUIDs encode cache topology based on APIC
   ID's CPU topology layout. And the ACPI PPTT table that ARM/RISCV
   relies on also requires CPU containers (CPU topology) to help
   indicate the private shared hierarchy of the cache.

Therefore, for SMP systems, it is natural to use the CPU topology
hierarchy directly in QEMU to define the cache topology.

And currently, separated L1 cache (L1 data cache and L1 instruction
cache) with unified higher-level caches (e.g., unified L2 and L3
caches), is the most common cache architectures.

Thus, we define the topology for L1 D-cache, L1 I-cache, L2 cache and L3
cache in MachineState as the basic cache topology support:

typedef struct CacheTopology {
    CPUTopoLevel l1d;
    CPUTopoLevel l1i;
    CPUTopoLevel l2;
    CPUTopoLevel l3;
} CacheTopology;

Machines may also only support a subset of the cache topology
to be configured in -smp by setting the SMP property of MachineClass:

typedef struct {
    ...
    bool l1_separated_cache_supported;
    bool l2_unified_cache_supported;
    bool l3_unified_cache_supported;
} SMPCompatProps;


Cache Topology Configuration in -smp
------------------------------------

Further, we add new parameters to -smp:
* l1d-cache=topo_level
* l1i-cache=topo_level
* l2-cache=topo_level
* l3-cache=topo_level

These cache topology parameters accept the strings of CPU topology
levels (such as "drawer", "book", "socket", "die", "cluster", "module",
"core" or "thread"). Exactly which topology level strings could be
accepted as the parameter depends on the machine's support for the
corresponding CPU topology level.

Unsupported cache topology parameters will cause error.

In this series, we add the cache topology support in -smp for x86 PC
machine.

The following example defines a 3-level cache topology hierarchy (L1
D-cache per core, L1 I-cache per core, L2 cache per core and L3 cache per
die) for PC machine.

-smp 32,sockets=2,dies=2,modules=2,cores=2,threads=2,maxcpus=32,\
     l1d-cache=core,l1i-cache=core,l2-cache=core,l3-cache=die


Reference
---------

[1]: [ARM] Jonathan's proposal to adjust cache topology:
     https://lore.kernel.org/qemu-devel/20230808115713.2613-2-Jonathan.Cameron@huawei.com/
[2]: [RISC-V] Discussion between JeeHeng and Jonathan about cache
     topology:
     https://lore.kernel.org/qemu-devel/20240131155336.000068d1@Huawei.com/
[3]: Discussion with Daniel about default cache topology:
     https://lore.kernel.org/qemu-devel/ZkTrsDdyGRFzVULG@redhat.com/
[4]: Previous x86 specific cache topology option:
     https://lore.kernel.org/qemu-devel/20230914072159.1177582-22-zhao1.liu@linux.intel.com/
[5]: Michael's comment about generic cache topology support:
     https://lore.kernel.org/qemu-devel/20231003085516-mutt-send-email-mst@kernel.org/
[6]: Daniel's question about how x86 support L2 cache domain (cluster)
     configuration:
     https://lore.kernel.org/qemu-devel/ZcUG0Uc8KylEQhUW@redhat.com/

Thanks and Best Regards,
Zhao
---
Changelog:

Main changes since RFC v1:
 * Split CpuTopology renaimg out of this RFC.
 * Use QAPI to enumerate CPU topology levels.
 * Drop string_to_cpu_topo() since QAPI will help to parse the topo
   levels.
 * Set has_*_cache field in machine_get_smp(). (JeeHeng)
 * Use "*_cache=topo_level" as -smp example as the original "level"
   term for a cache has a totally different meaning. (Jonathan)

---
Zhao Liu (7):
  hw/core: Make CPU topology enumeration arch-agnostic
  hw/core: Define cache topology for machine
  hw/core: Add cache topology options in -smp
  i386/cpu: Support thread and module level cache topology
  i386/cpu: Update cache topology with machine's configuration
  i386/pc: Support cache topology in -smp for PC machine
  qemu-options: Add the cache topology description of -smp

 MAINTAINERS                    |   2 +
 hw/core/cpu-topology.c         |  36 ++++++++
 hw/core/machine-smp.c          | 146 +++++++++++++++++++++++++++++++++
 hw/core/machine.c              |  25 ++++++
 hw/core/meson.build            |   1 +
 hw/i386/pc.c                   |   3 +
 include/hw/boards.h            |  25 ++++++
 include/hw/core/cpu-topology.h |  20 +++++
 include/hw/i386/topology.h     |  18 +---
 qapi/machine.json              |  63 +++++++++++++-
 qemu-options.hx                |  50 +++++++++--
 system/vl.c                    |  12 +++
 target/i386/cpu.c              |  59 +++++++++----
 target/i386/cpu.h              |   4 +-
 tests/unit/meson.build         |   3 +-
 15 files changed, 422 insertions(+), 45 deletions(-)
 create mode 100644 hw/core/cpu-topology.c
 create mode 100644 include/hw/core/cpu-topology.h

-- 
2.34.1


