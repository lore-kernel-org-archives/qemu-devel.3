Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963E7CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA8m-0004Pe-MS; Thu, 19 Sep 2024 01:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA8k-0004BZ-9C; Thu, 19 Sep 2024 01:55:42 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA8d-0007JU-RC; Thu, 19 Sep 2024 01:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725336; x=1758261336;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PP14MTETZAEuYjWGx085fi3OdTPqIiN84cU4cQZb8Eo=;
 b=Tx5UVJivG9CHe43QxmChUrlepNTz/YG4yEt/u1cvhSGuNJUpqzGWjJR5
 /5jR//aI+YZP+sNkdRExqxpKvO6NhnZXESYAxf291vXQpiCdaKyayPBFh
 mCYszNn14EatsTJdJUYde5zpmj/QyoStY+IlFovZVzuH6MbVlJHnZ60pM
 FyRcQIVIzQe0fRu0hoBJ8/RUhVJcCOuyAaSNn6adECzyQA1T+l7gvH6dK
 HwTblBNS1YI1AWytUAYrzjeq4rUPIePdgt478TLaUIq58iJjQ89w5ppgs
 f87aJ0bTlQey7ciQrYB+WX8pa+PfofZgfMJv6A5bobaQ1qyqTtU4VKieT Q==;
X-CSE-ConnectionGUID: HttEcJCFQ4GXVvwVVaMWoA==
X-CSE-MsgGUID: v1FHhgejSVukpK/u4YDbVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813418"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813418"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:55:31 -0700
X-CSE-ConnectionGUID: zWu8KgaJTxSF9BuQDcV04A==
X-CSE-MsgGUID: MEiInIrHSAyTNt8ZxgEoGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418595"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:55:24 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 00/12] Introduce Hybrid CPU Topology via Custom Topology Tree
Date: Thu, 19 Sep 2024 14:11:16 +0800
Message-Id: <20240919061128.769139-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi all,

This our v2 RFC trying to introduce hyrbid (aka, heterogeneous) CPU
topology into QEMU. This series focuses on the heterogeneous CPUs with
same ISA, like Intel client hybrid architecture.

Comparing with v1 [1], v2 totally re-designs the topology architecture
and based on QOM (CPU) topology [2], unleashes the ability to customize
CPU topology tree by -device from CLI.

For example, a PC machine with 1 Intel Core (P-core) with 2 threads and
2 Intel Atoms (E core) with single thread can be defined like:

-smp maxsockets=1,maxdies=1,maxmodules=2,maxcores=2,maxthreads=2
-machine pc,custom-topo=on \
-device cpu-socket,id=sock0 \
-device cpu-die,id=die0,bus=sock0 \
-device cpu-module,id=mod0,bus=die0 \
-device cpu-module,id=mod1,bus=die0 \
-device x86-intel-core,id=core0,bus=mod0 \
-device x86-intel-atom,id=core1,bus=mod1 \
-device x86-intel-atom,id=core2,bus=mod1 \
-device host-x86_64-cpu,id=cpu0,socket-id=0,die-id=0,module-id=0,core-id=0,thread-id=0 \
-device host-x86_64-cpu,id=cpu1,socket-id=0,die-id=0,module-id=0,core-id=0,thread-id=1 \
-device host-x86_64-cpu,id=cpu2,socket-id=0,die-id=0,module-id=1,core-id=0,thread-id=0 \
-device host-x86_64-cpu,id=cpu3,socket-id=0,die-id=0,module-id=1,core-id=1,thread-id=0

The example above has some difference from the v1 qom-topo example [3]:
 * new max* parameter in -smp and,
 * new custom-topo option in -machine,
 * no "parent" parameter to create child<>, instead there's a bus to
   specify parent bus of parent topology device.

The design of such command line is related to the machine/CPU
initialization process, and I'll explain in more detail later the
reasons for this (pls refer section 2. "Design Overview").

This series is based on previous v2 QOM topology series [2].

Welcome your feedback and comments!


1. Background
=============

About why we need hybrid CPU topology, pls refer the cover letter of
QOM-topo v2 RFC [2], "What's the Problem?" :-).

With CPU topology related devices introduced by QOM-topo v2 RFC [2],
then we have the chance to allow user to customize CPU topology from
CLI.

There is no need to deliberately emphasize the hybrid topology here, as
the custom topology can be either SMP or hybrid, and custom-topo is
generic and flexible enough.


2. Design Overview
==================

2.1. How to Initialize possible_cpus[] for Custom Topology from CLI
===================================================================

At present (QEMU master and QOM topo v2 [2]), possible_cpus[] is
initialized with -smp parameters.

For user custom topology, a previous attempt (in QOM topo v1 [3]) tried
to create topology devices (CPU/core/module/die...) from CLI in advance,
and built a complete topology tree, then used the globle topology
informantion (something similar to smp.max_cpus/threads/cores/sockets...)
to create possible_cpus[] and initialize archid (for x86, it's APIC ID).

Figure 1: Previous attempt to create topology devices before
          possible_cpus[] initialization (in QOM-topo v1 [3])
                                                         
    qmp_x_exit_preconfig()                               
    │                                                    
    ├───(?)qemu_create_cli_base_devices()                
    │    │                                               
    │    └───(?)Create CPU topology devices              
    │           including CPUs                           
    │                                                    
    ├─── qemu_init_board()                               
    │    │                                               
    │    └── machine_run_board_init()                    
    │        │                                           
    │        └─── machine_class->init(machine)           
    │             │                                      
    │             └─── x86_cpus_init()                   
    │                  │                                 
    │                  └─── mc->possible_cpu_arch_ids(ms)
    │                                                    
    └─── qemu_create_cli_devices()                       

The "(?)" marked qemu_create_cli_base_devices() (added in previous
approach) would create topology devices.

But this approach has the drawback: when topology tree is completed,
especially for the levels higher than possible_cpus[], it's impossible
to hotplug other topology devices (higher than possble_cpus[]). This is
because the length of possible_cpus[] is computed by those higher
topology levels and this length cannot change at runtime.

This would prevent future support and exploration of larger granularity
hotplugs.

Thus, in this RFC, we create topology devices after possible_cpus[]
creation.

But the question that arises is how to get the topology information
needed for the initialization of possible_cpus[] and its archid.

The current -smp parameters (cores/modules/clusters/dies/sockets/books/
drawers) require the machine to create a corresponding number of
topology instances for SMP systems.

This does not accommodate hybrid topologies. Therefore, we introduce
max* parameters: maxthreads/maxcores/maxmodules/maxdies/maxsockets
(for x86), to predefine the topology framework for the machine. These
parameters also constrain subsequent custom topologies, ensuring the
number of child devices under each parent device does not exceed the
specified max limits.

The actual number of child instances is determined by the user. Maybe
user defines a SMP topology, or maybe a hybrid topology.

Not only can the length of possible_cpus[] continue to be defined via
-smp, but its internal archid can also be set using max parameters. In
the case of x86, the bit width of the sub-topology ID in the APIC ID
will be determined by these max parameters. In fact, actual x86 hardware
uses the similar approach, including hybrid platforms.

Setting SMP max limits for custom topologies is semantically meaningful.
Regardless of how heterogeneous the CPU topology is, there will always
be a corresponding superset in the SMP structure.


2.2. How to Address CPU Dependencies in Machine Initialization
==============================================================

A coming question is whether the machine continues to initialize the
default CPUs from "-smp cpus=*", when the user needs custom topology
from the CLI.

In qom-topo v2, machine creates a symmetric topology tree from -smp by
default, and it's clear that customizing again based on an existing
topology tree won't work.

Therefore, once user wants to customize topology by "-machine
custom-topo=on", the machine, that supports custom topology, will skip
the default topology creation as well as the default CPU creation.

In the following figure, just as the "(X)" marked
machine_create_topo_tree() and x86_cpu_new() should be skipped.

Figure 2: Original machine initialization process (in QOM-topo v2 [2])

    qmp_x_exit_preconfig()                               
    │                                                    
    ├─── qemu_init_board()                               
    │    │                                               
    │    └── machine_run_board_init()                    
    │        │                                           
    │        ├───(*)machine_create_topo_tree()           
    │        │                                           
    │        └─── machine_class->init(machine)           
    │             │                                      
    │             ├─── x86_cpus_init()                   
    │             │    │                                 
    │             │    ├─── mc->possible_cpu_arch_ids(ms)
    │             │    │                                 
    │             │    └───(*)x86_cpu_new()              
    │             │                                      
    │             └───(*)Other initialization steps       
    │                    with CPU dependencies           
    │                                                    
    └─── qemu_create_cli_devices()                      


However, machine initialization may have some followup steps with CPU
dependencies after the default CPU initialization. If the default CPU
creation is skipped, such CPU-dependent steps will fail.

Therefore, to address these annoying CPU dependencies, and to replace
the default topology tree creation (machine_create_topo_tree() and
x86_cpu_new()) with CPU topology creation from CLI, this series reorders
the machine initialization steps and topology device creation from CLI
for the custom topology case:

Figure 3: New machine initialization process (in this series)

    qmp_x_exit_preconfig()                                  
    │                                                       
    ├─── qemu_init_board()                                  
    │    │                                                  
    │    ┼──── machine_run_board_init()                     
    │    │     │                                            
    │    │     ├───(X)machine_create_topo_tree()            
    │    │     │                                            
    │    │     └─── machine_class->init(machine)            
    │    │          │                                       
    │    │          ├─── x86_cpus_init()                    
    │    │          │    │                                  
    │    │          │    ┼─── mc->possible_cpu_arch_ids(ms) 
    │    │          │    │                                  
    │    │          │    └───(X)x86_cpu_new()               
    │    │          │                                       
    │    │          └───(X)Other initialization steps        
    │    │                 with CPU dependencies            
    │    │                                                  
    │    ├────(*)qemu_add_cli_devices_early()               
    │    │     │                                            
    │    │     └───(*)Create CPU topology devices          
    │    │            including CPUs                       
    │    │                                                  
    │    └────(*)machine_run_board_post_init()                
    │          │                                            
    │          └───(*)machine_class->post_init(machine)       
    │               │                                       
    │               └───(*)Other initialization steps        
    │                      with CPU dependencies            
    │                                                       
    └─── qemu_create_cli_devices()                          


As the above figure, "(*)" indicates the new interface/hook added in
this series:

  * (For the machine supports custom topology) split CPU dependent
    initialization setps into machine_class->post_init().

    - For example, in q35 machine, all the logic after x86_cpu_new() is
      placed in machine_class->post_init().

  * Between machine_class->init() and machine_class->post_init(),
    create CPU topology devices (including CPUs) from CLI early.

This effectively replaces the default CPU creation (as well as topology
tree creation) in the original initialization process with
qemu_add_cli_devices_early().


3. Patch Summary
================

Patch 01-03: Create topology device from CLI early.
Ptach 04,11: Separate the part following CPU creation from the machine
             initialization process into MachineClass.post_init().
Patch 05-08: Implement max parameters in -smp and use max limitations
             to initialize possible_cpus[].
Patch 09-10: Add Intel hybrid CPU support.
Patch    12: Allow user to customize topology tree for x86 machines.


4. Reference
============

[1]: [RFC 00/52] Introduce hybrid CPU topology
     https://lore.kernel.org/qemu-devel/20230213095035.158240-1-zhao1.liu@linux.intel.com/
[2]: [RFC v2 00/15] qom-topo: Abstract CPU Topology Level to Topology Device
     https://lore.kernel.org/qemu-devel/20240919015533.766754-1-zhao1.liu@intel.com/
[3]: [RFC 00/41] qom-topo: Abstract Everything about CPU Topology
     https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/


Thanks and Best Regards,
Zhao
---
Zhao Liu (12):
  qdev: Allow qdev_device_add() to add specific category device
  qdev: Introduce new device category to cover basic topology device
  system/vl: Create CPU topology devices from CLI early
  hw/core/machine: Split machine initialization around
    qemu_add_cli_devices_early()
  hw/core/machine: Introduce custom CPU topology with max limitations
  hw/cpu: Constrain CPU topology tree with max_limit
  hw/core: Re-implement topology helpers to honor max limitations
  hw/i386: Use get_max_topo_by_level() to get topology information
  i386: Introduce x86 CPU core abstractions
  i386/cpu: Support Intel hybrid CPUID
  i386/machine: Split machine initialization after CPU creation into
    post_init()
  i386: Support custom topology for microvm, pc-i440fx and pc-q35

 MAINTAINERS                 |   1 +
 hw/core/machine-smp.c       |  10 ++-
 hw/core/machine.c           |  47 ++++++++++
 hw/core/meson.build         |   2 +-
 hw/cpu/cpu-slot.c           | 168 ++++++++++++++++++++++++++++++++++++
 hw/cpu/cpu-topology.c       |   2 +-
 hw/i386/microvm.c           |   8 ++
 hw/i386/pc_piix.c           |  41 +++++----
 hw/i386/pc_q35.c            |  37 +++++---
 hw/i386/x86-common.c        |  25 ++++--
 hw/i386/x86.c               |  20 +++--
 hw/net/virtio-net.c         |   2 +-
 hw/usb/xen-usb.c            |   3 +-
 include/hw/boards.h         |  13 ++-
 include/hw/cpu/cpu-slot.h   |  12 +++
 include/hw/i386/pc.h        |   3 +
 include/hw/qdev-core.h      |   6 ++
 include/monitor/qdev.h      |   4 +-
 qapi/machine.json           |  22 ++++-
 stubs/machine-stubs.c       |  21 +++++
 stubs/meson.build           |   1 +
 system/cpus.c               |   2 +-
 system/qdev-monitor.c       |  13 ++-
 system/vl.c                 |  59 ++++++++-----
 target/i386/core.c          |  56 ++++++++++++
 target/i386/core.h          |  53 ++++++++++++
 target/i386/cpu.c           |  58 +++++++++++++
 target/i386/cpu.h           |   5 ++
 target/i386/meson.build     |   1 +
 tests/unit/test-smp-parse.c |   4 +-
 30 files changed, 618 insertions(+), 81 deletions(-)
 create mode 100644 stubs/machine-stubs.c
 create mode 100644 target/i386/core.c
 create mode 100644 target/i386/core.h

-- 
2.34.1


