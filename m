Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCiC-00048R-9F; Wed, 03 Jul 2024 23:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCi7-000478-UP; Wed, 03 Jul 2024 23:00:39 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCi5-0003uz-Q4; Wed, 03 Jul 2024 23:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720062038; x=1751598038;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KBoR7Jmf7Pr5F6X5IGhcrEKtNKryr9HfJ/qoLYd34tM=;
 b=edPyGbco9XyA5E6z1Gu4klSHOVg6N7hR0jzoUGxULZQyTb83HtwgIo9U
 2wJH40rzRVHxcKN2RPjvTDCJANoxCezIeDIMAVarGuKAPsGY6wVKabZ9a
 CiJXgeEwT0Hs+ve62OYKcwtPPzxEqr1uWLrAF5FQ4xtkY/Mpxf2VDCuQi
 RJ99q9+dRrZsW6hBA5QGgAuGRdGKQKqH9YTEqzLEG0pTSr4yHaPSv/PyY
 5R9ZkJS4xB2VdghKUXLPhthKsteisOtwRIfXtE1Ny5KNxOx22m8tK+2No
 8+CZur1dbLhD/TjHEX0ldDCZ6Hx2h2S7SzH6/U7WJ58lWn7jJy9fgiicM g==;
X-CSE-ConnectionGUID: CkuLZ9OPSkSkp7cTO3VHuw==
X-CSE-MsgGUID: qKcQkr1tTimXoPd1hMunJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39838046"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="39838046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:00:33 -0700
X-CSE-ConnectionGUID: dGDY2TfnTCKtQ4Qs7N3qfQ==
X-CSE-MsgGUID: R7lm3lAoSgCI7aZI4Ltnlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51052086"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2024 20:00:27 -0700
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
Subject: [PATCH 0/8] Introduce SMP Cache Topology
Date: Thu,  4 Jul 2024 11:15:55 +0800
Message-Id: <20240704031603.1744546-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Since the previous RFC v2, I've reimplemented smp-cache object based on
Daniel's comment (thanks Daniel!), which is both flexible to support
current cache topology requirements and extensible.

So, I officially convert the RFC to PATCH.

Background on smp cache topology can be found in the previous RFC v2
cover letter:

https://lore.kernel.org/qemu-devel/20240530101539.768484-1-zhao1.liu@intel.com/

The following content focuses on this series implementation of the
smp-cache object.


About smp-cache
===============

In fact, the smp-cache object introduced in this series is a bit
different from Daniel's original suggestion. Instead of being integrated
into -smp, it is created explicitly via -object, and the smp-cache
property is added to -machine to link to this object.

An example is as follows:

-object '{"qom-type":"smp-cache","id":"cache0","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"socket"}]}'
-machine smp-cache=cache0


Such the design change is based on the following 2 reasons:
 * Defining the cache with a JSON list is very extensible and can
   support more cache properties.

 * But -smp, as the sugar of machine property "smp", is based on keyval
   format, and doesn't support options with JSON format. Thus it's not
   possible to add a JSON format based option to -smp/-machine for now.

So, I decoupled the creation of the smp-cache object from the -machine
to make both -machine and -object happy!


Welcome your feedback!


Thanks and Best Regards,
Zhao
---
Changelog:

Main changes since RFC v2:
 * Dropped cpu-topology.h and cpu-topology.c since QAPI has the helper
   (CpuTopologyLevel_str) to convert enum to string. (Markus)
 * Fixed text format in machine.json (CpuTopologyLevel naming, 2 spaces
   between sentences). (Markus)
 * Added a new level "default" to de-compatibilize some arch-specific
   topo settings. (Daniel)
 * Moved CpuTopologyLevel to qapi/machine-common.json, at where the
   cache enumeration and smp-cache object would be added.
   - If smp-cache object is defined in qapi/machine.json, storage-daemon
     will complain about the qmp cmds in qapi/machine.json during
     compiling.
 * Referred to Daniel's suggestion to introduce cache JSON list, though
   as a standalone object since -smp/-machine can't support JSON.
 * Linked machine's smp_cache to smp-cache object instead of a builtin
   structure. This is to get around the fact that the keyval format of
   -machine can't support JSON.
 * Wrapped the cache topology level access into a helper.
 * Split as a separate commit to just include compatibility checking and
   topology checking.
 * Allow setting "default" topology level even though the cache
   isn't supported by machine. (Daniel)
 * Rewrote the document of smp-cache object.

Main changes since RFC v1:
 * Split CpuTopology renaimg out of this RFC.
 * Use QAPI to enumerate CPU topology levels.
 * Drop string_to_cpu_topo() since QAPI will help to parse the topo
   levels.
 * Set has_*_cache field in machine_get_smp(). (JeeHeng)
 * Use "*_cache=topo_level" as -smp example as the original "level"
   term for a cache has a totally different meaning. (Jonathan)
---
Zhao Liu (8):
  hw/core: Make CPU topology enumeration arch-agnostic
  qapi/qom: Introduce smp-cache object
  hw/core: Add smp cache topology for machine
  hw/core: Check smp cache topology support for machine
  i386/cpu: Support thread and module level cache topology
  i386/cpu: Update cache topology with machine's configuration
  i386/pc: Support cache topology in -machine for PC machine
  qemu-options: Add the description of smp-cache object

 MAINTAINERS                 |   2 +
 hw/core/machine-smp.c       |  86 ++++++++++++++++++++++++++++++
 hw/core/machine.c           |  22 ++++++++
 hw/core/meson.build         |   1 +
 hw/core/smp-cache.c         | 103 ++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c                |   4 ++
 include/hw/boards.h         |  11 +++-
 include/hw/core/smp-cache.h |  27 ++++++++++
 include/hw/i386/topology.h  |  18 +------
 qapi/machine-common.json    |  97 ++++++++++++++++++++++++++++++++-
 qapi/qapi-schema.json       |   4 +-
 qapi/qom.json               |   3 ++
 qemu-options.hx             |  58 ++++++++++++++++++++
 target/i386/cpu.c           |  83 +++++++++++++++++++++--------
 target/i386/cpu.h           |   4 +-
 15 files changed, 478 insertions(+), 45 deletions(-)
 create mode 100644 hw/core/smp-cache.c
 create mode 100644 include/hw/core/smp-cache.h

-- 
2.34.1


