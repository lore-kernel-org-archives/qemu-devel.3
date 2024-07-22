Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnJR-0003DS-FK; Mon, 22 Jul 2024 03:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVnJG-0002hX-9f; Mon, 22 Jul 2024 03:18:15 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVnJD-0001Bm-J7; Mon, 22 Jul 2024 03:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721632692; x=1753168692;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PWz4Ht0qlbweAS5o60cJFbGqE0cijiCuaXDbGXRSJ3Q=;
 b=XBx4TgKu3q8b14A+G3b43wRf6uJObklYzONohPCGvLBMJC41eiN13pPd
 vZ2QYfCQ1GZuKszknLcWDKlDGFANou7T6j6at/EycXp7GvDL5suKcNUS0
 jc6kUCQe2GVyT2lJtpRJbhhIKihlxZF+tJ4g2ZoJaiSVEJBfEDIcHE3Vf
 f6ookgnogqeU0CFP4HFhcb5lqIToTKCRs/JhDwlAVgZNVdHtkPQvikrhL
 WuhO4CU+nXYhsVbIRgWg4KlHDmdSTHC9uYH5ZLkEkPHuN+b9hPmIwYR4s
 iiQ/KVsXVULPF/Xnz50YYZGfG6orMKrsNZBsl3869yEdOTiVZw+lwgR8l A==;
X-CSE-ConnectionGUID: 2+it0vNZQbm3Be1s14/BBQ==
X-CSE-MsgGUID: C1lpF1pOSnahfp5Bt1kr0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="29843695"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="29843695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:17:59 -0700
X-CSE-ConnectionGUID: S294LoMoTdKgKC7BnmarJQ==
X-CSE-MsgGUID: cpwVM0ovRbS97rMy+BQXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="56350156"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 22 Jul 2024 00:17:53 -0700
Date: Mon, 22 Jul 2024 15:33:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 0/8] Introduce SMP Cache Topology
Message-ID: <Zp4LUSXlwXqI880x@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704031603.1744546-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Hi Daniel and Markus,

A gentle ping. Would you kindly have a look at this version of the API
design? If it could meet your satisfaction, I¡¯ll continue iterating.

Thanks,
Zhao

On Thu, Jul 04, 2024 at 11:15:55AM +0800, Zhao Liu wrote:
> Date: Thu, 4 Jul 2024 11:15:55 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH 0/8] Introduce SMP Cache Topology
> X-Mailer: git-send-email 2.34.1
> 
> Hi all,
> 
> Since the previous RFC v2, I've reimplemented smp-cache object based on
> Daniel's comment (thanks Daniel!), which is both flexible to support
> current cache topology requirements and extensible.
> 
> So, I officially convert the RFC to PATCH.
> 
> Background on smp cache topology can be found in the previous RFC v2
> cover letter:
> 
> https://lore.kernel.org/qemu-devel/20240530101539.768484-1-zhao1.liu@intel.com/
> 
> The following content focuses on this series implementation of the
> smp-cache object.
> 
> 
> About smp-cache
> ===============
> 
> In fact, the smp-cache object introduced in this series is a bit
> different from Daniel's original suggestion. Instead of being integrated
> into -smp, it is created explicitly via -object, and the smp-cache
> property is added to -machine to link to this object.
> 
> An example is as follows:
> 
> -object '{"qom-type":"smp-cache","id":"cache0","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"socket"}]}'
> -machine smp-cache=cache0
> 
> 
> Such the design change is based on the following 2 reasons:
>  * Defining the cache with a JSON list is very extensible and can
>    support more cache properties.
> 
>  * But -smp, as the sugar of machine property "smp", is based on keyval
>    format, and doesn't support options with JSON format. Thus it's not
>    possible to add a JSON format based option to -smp/-machine for now.
> 
> So, I decoupled the creation of the smp-cache object from the -machine
> to make both -machine and -object happy!
> 
> 
> Welcome your feedback!
> 
> 
> Thanks and Best Regards,
> Zhao
> ---
> Changelog:
> 
> Main changes since RFC v2:
>  * Dropped cpu-topology.h and cpu-topology.c since QAPI has the helper
>    (CpuTopologyLevel_str) to convert enum to string. (Markus)
>  * Fixed text format in machine.json (CpuTopologyLevel naming, 2 spaces
>    between sentences). (Markus)
>  * Added a new level "default" to de-compatibilize some arch-specific
>    topo settings. (Daniel)
>  * Moved CpuTopologyLevel to qapi/machine-common.json, at where the
>    cache enumeration and smp-cache object would be added.
>    - If smp-cache object is defined in qapi/machine.json, storage-daemon
>      will complain about the qmp cmds in qapi/machine.json during
>      compiling.
>  * Referred to Daniel's suggestion to introduce cache JSON list, though
>    as a standalone object since -smp/-machine can't support JSON.
>  * Linked machine's smp_cache to smp-cache object instead of a builtin
>    structure. This is to get around the fact that the keyval format of
>    -machine can't support JSON.
>  * Wrapped the cache topology level access into a helper.
>  * Split as a separate commit to just include compatibility checking and
>    topology checking.
>  * Allow setting "default" topology level even though the cache
>    isn't supported by machine. (Daniel)
>  * Rewrote the document of smp-cache object.
> 
> Main changes since RFC v1:
>  * Split CpuTopology renaimg out of this RFC.
>  * Use QAPI to enumerate CPU topology levels.
>  * Drop string_to_cpu_topo() since QAPI will help to parse the topo
>    levels.
>  * Set has_*_cache field in machine_get_smp(). (JeeHeng)
>  * Use "*_cache=topo_level" as -smp example as the original "level"
>    term for a cache has a totally different meaning. (Jonathan)
> ---
> Zhao Liu (8):
>   hw/core: Make CPU topology enumeration arch-agnostic
>   qapi/qom: Introduce smp-cache object
>   hw/core: Add smp cache topology for machine
>   hw/core: Check smp cache topology support for machine
>   i386/cpu: Support thread and module level cache topology
>   i386/cpu: Update cache topology with machine's configuration
>   i386/pc: Support cache topology in -machine for PC machine
>   qemu-options: Add the description of smp-cache object
> 
>  MAINTAINERS                 |   2 +
>  hw/core/machine-smp.c       |  86 ++++++++++++++++++++++++++++++
>  hw/core/machine.c           |  22 ++++++++
>  hw/core/meson.build         |   1 +
>  hw/core/smp-cache.c         | 103 ++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c                |   4 ++
>  include/hw/boards.h         |  11 +++-
>  include/hw/core/smp-cache.h |  27 ++++++++++
>  include/hw/i386/topology.h  |  18 +------
>  qapi/machine-common.json    |  97 ++++++++++++++++++++++++++++++++-
>  qapi/qapi-schema.json       |   4 +-
>  qapi/qom.json               |   3 ++
>  qemu-options.hx             |  58 ++++++++++++++++++++
>  target/i386/cpu.c           |  83 +++++++++++++++++++++--------
>  target/i386/cpu.h           |   4 +-
>  15 files changed, 478 insertions(+), 45 deletions(-)
>  create mode 100644 hw/core/smp-cache.c
>  create mode 100644 include/hw/core/smp-cache.h
> 
> -- 
> 2.34.1
> 

