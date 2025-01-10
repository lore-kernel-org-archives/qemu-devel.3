Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BD2E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWG4P-0002DX-OE; Fri, 10 Jan 2025 09:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4N-0002CT-Ks
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:03 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4K-0006dO-2h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736519580; x=1768055580;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wQakl14sIa/TQlT+I/DKr4worOCNT8tEroVig3IR2oY=;
 b=g/0tbY+tP+Y6PSMYhaHEPwQUB/530LpE9nbD1aR5ips6GgaYtDab8nc8
 Wjrbtz928FZM526XnRHKPfhmBbsbrPbEnYGBTLuqdJgrfiCTTNMzCd4VW
 nrWaKfLiVGhDLYacUXGEYStS/uB5cNVGzP+krlKLOegI3zR9z3B8W1m0E
 KdHavJHtWz70ZDpOrN4LFLvTgI0dpAH39/k+g/W71603anBZUvglKeL+b
 9OVGOP8wn/BC/hfo8OLSmScErAKfyQUWb/SYaXLahU9VB+g/Xp6inyCUK
 StvWu6ZzsfZOVxFFX68HrOR8qnh4D+3nZT1wFnfS6VG+RWaAZHJEdLDOa g==;
X-CSE-ConnectionGUID: OYOgOFEyQvC2k+VBopUsmA==
X-CSE-MsgGUID: 8sNoVPSwS66zDw2mEXGiwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62185484"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="62185484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 06:32:49 -0800
X-CSE-ConnectionGUID: 1NZVCdmoSluNKfvaeEt6Dg==
X-CSE-MsgGUID: +ATDI3lWQk+/tDoMUiKj2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="108790792"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Jan 2025 06:32:45 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
Date: Fri, 10 Jan 2025 22:51:10 +0800
Message-Id: <20250110145115.1574345-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Hi folks,

This is my v7 resend version (updated the commit message of origin
v7's Patch 1).

Compared with v6 [1], v7 dropped the "thread" level cache topology
(cache per thread):

 - Patch 1 is the new patch to reject "thread" parameter for smp-cache.
 - Ptach 2 dropped cache per thread support.
 (Others remain unchanged.)

There're several reasons:

 * Currently, neither i386 nor ARM have real hardware support for per-
   thread cache.
 * ARM can't support thread level cache in device tree. [2].

So it is unnecessary to support it at this moment, even though per-
thread cache might have potential scheduling benefits for VMs without
CPU affinity.

In the future, if there is a clear demand for this feature, the correct
approach would be to add a new control field in MachineClass.smp_props
and enable it only for the machines that require it.


This series is based on the master branch at commit aa3a285b5bc5 ("Merge
tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into
staging").

Smp-cache support of ARM side can be found at [3].


Background
==========

The x86 and ARM (RISCV) need to allow user to configure cache properties
(current only topology):
 * For x86, the default cache topology model (of max/host CPU) does not
   always match the Host's real physical cache topology. Performance can
   increase when the configured virtual topology is closer to the
   physical topology than a default topology would be.
 * For ARM, QEMU can't get the cache topology information from the CPU
   registers, then user configuration is necessary. Additionally, the
   cache information is also needed for MPAM emulation (for TCG) to
   build the right PPTT. (Originally from Jonathan)


About smp-cache
===============

The API design has been discussed heavily in [4].

Now, smp-cache is implemented as a array integrated in -machine. Though
-machine currently can't support JSON format, this is the one of the
directions of future.

An example is as follows:

smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die

"cache" specifies the cache that the properties will be applied on. This
field is the combination of cache level and cache type. Now it supports
"l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
cache) and "l3" (L3 unified cache).

"topology" field accepts CPU topology levels including "core", "module",
"cluster", "die", "socket", "book", "drawer" and a special value
"default". (Note, now, in v7, smp-cache doesn't support "thread".)

The "default" is introduced to make it easier for libvirt to set a
default parameter value without having to care about the specific
machine (because currently there is no proper way for machine to
expose supported topology levels and caches).

If "default" is set, then the cache topology will follow the
architecture's default cache topology model. If other CPU topology level
is set, the cache will be shared at corresponding CPU topology level.

[1]: Patch v6: https://lore.kernel.org/qemu-devel/20241219083237.265419-1-zhao1.liu@intel.com/
[2]: Gap of cache per thread for ARM: https://lore.kernel.org/qemu-devel/20250110114100.00002296@huawei.com/T/#m50c37fa5d372feac8e607c279cd446da3e22a12c
[3]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20250102152012.1049-1-alireza.sanaee@huawei.com/
[4]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/

Thanks and Best Regards,
Zhao
---
Alireza Sanaee (1):
  i386/cpu: add has_caches flag to check smp_cache configuration

Zhao Liu (4):
  hw/core/machine: Reject thread level cache
  i386/cpu: Support module level cache topology
  i386/cpu: Update cache topology with machine's configuration
  i386/pc: Support cache topology in -machine for PC machine

 hw/core/machine-smp.c |  9 ++++++
 hw/i386/pc.c          |  4 +++
 include/hw/boards.h   |  3 ++
 qemu-options.hx       | 30 +++++++++++++++++-
 target/i386/cpu.c     | 71 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.34.1


