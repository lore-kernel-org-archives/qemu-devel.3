Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78875D3C548
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 04:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1eJr-00014Q-DF; Fri, 18 Oct 2024 00:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1eJm-00013F-Jh; Fri, 18 Oct 2024 00:10:26 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1eJj-0007it-Lo; Fri, 18 Oct 2024 00:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729224624; x=1760760624;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UO03l2WlkbGHRPPhQ1W7PzTfDWTByRjaEAMTt2eMXo4=;
 b=ZJqJbmLhLUQTiG3qv5hrqmn38XXExs8JItCwPjazTw6RcJtL0K8/0AA3
 o+AuJjcyqaQYmzSA0mrV8oyGin3R8clLdjvlLFzAmcD2EoPuk03vNqznF
 EDOLxZzeZAiLY8vtzGSuaV+C9U7toJ+TakO4rFZFXKOh3mO258iOd08dO
 BQvLTn9j1T6cJOp4bLpzO2ds1HxOfZHrTAHHjeztcrdflcyfYGc73zk3o
 KXz4Zwf//pN4pMT67TDCXMyh7nzJ3U7+02oUVK0fyZyIy8rpmSoAQJnbM
 kouwENoz5nqtxB7ojLOAh+K0bI2mvBhFEy4cpUgy0O1nyChZrf+EjkBn8 g==;
X-CSE-ConnectionGUID: htz/JM3SRlKN1yEwz9hzZQ==
X-CSE-MsgGUID: BFBE/mAPSu6a2gz2BmGpjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28621476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28621476"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 21:10:20 -0700
X-CSE-ConnectionGUID: 7spyyLOrQh+idBbFxWPV8A==
X-CSE-MsgGUID: 9z7etmnrTL23n7mV1FIhiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; d="scan'208";a="109568860"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 21:10:14 -0700
Date: Fri, 18 Oct 2024 12:26:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZxHjdWSXyYKBAVWZ@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
 <0b884126-1fcb-40d2-9fc2-ab0944370fd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b884126-1fcb-40d2-9fc2-ab0944370fd9@linaro.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Marcin,

On Thu, Oct 17, 2024 at 06:19:59PM +0200, Marcin Juszkiewicz wrote:
> Date: Thu, 17 Oct 2024 18:19:59 +0200
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
>  arch-agnostic
> 
> W dniu 12.10.2024 o 12:44, Zhao Liu pisze:
> > Cache topology needs to be defined based on CPU topology levels. Thus,
> > define CPU topology enumeration in qapi/machine.json to make it generic
> > for all architectures.
> 
> I have a question: how to create other than default cache topology in C
> source?

What does "C source" mean? Does it refer to the C code for sbsa-ref?

There's the ARM change to support cache topology for virt machine:

https://lore.kernel.org/qemu-devel/20241010111822.345-5-alireza.sanaee@huawei.com/

If you're looking to store cache information for some common purposes,
you could also define a cache model structure similar to how it's done
for x86:

static const CPUCaches epyc_cache_info = {
    .l1d_cache = &(CPUCacheInfo) {
        .type = DATA_CACHE,
        .level = 1,
        .size = 32 * KiB,
        .line_size = 64,
        .associativity = 8,
        .partitions = 1,
        .sets = 64,
        .lines_per_tag = 1,
        .self_init = 1,
        .no_invd_sharing = true,
        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
    },
    .l1i_cache = &(CPUCacheInfo) {
        .type = INSTRUCTION_CACHE,
        .level = 1,
        .size = 64 * KiB,
        .line_size = 64,
        .associativity = 4,
        .partitions = 1,
        .sets = 256,
        .lines_per_tag = 1,
        .self_init = 1,
        .no_invd_sharing = true,
        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
    },
    .l2_cache = &(CPUCacheInfo) {
        .type = UNIFIED_CACHE,
        .level = 2,
        .size = 512 * KiB,
        .line_size = 64,
        .associativity = 8,
        .partitions = 1,
        .sets = 1024,
        .lines_per_tag = 1,
        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
    },
    .l3_cache = &(CPUCacheInfo) {
        .type = UNIFIED_CACHE,
        .level = 3,
        .size = 8 * MiB,
        .line_size = 64,
        .associativity = 16,
        .partitions = 1,
        .sets = 8192,
        .lines_per_tag = 1,
        .self_init = true,
        .inclusive = true,
        .complex_indexing = true,
        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
    },
};

> If I would like to change default cache structure for sbsa-ref then how
> would I do it?

I'm not very familiar with sbsa-ref. How is the cache model defined? Does
it use ACPI PPTT like the virt machine? If so, you can refer to the virt
machine series link I provided above.

> QEMU has powerful set of command line options. But it is hard to convert set
> of cli options into C code.

The CLI is currently quite complex, as different machine configurations
may vary. But don't worry. The general steps for enabling smp-cache here
are:

1. Set cache levels support in sbsa_ref_class_init(). You can refer my
   patch 6, to set ture for which cache level you need.
2. Then, the cli can support "-machine smp-cache" for sbsa-ref machine.
   You can refer the doc in my patch 6 to get the correct format.
3. Next, the MachineState will store the user's cache topology in "smp_cache".
   You can refer my patch 5 to get cache topology level from machine.
4. Finally, it's architecture-specific code, depending on whether you
   want to express cache information in the same pptt table as virt
   machine.

Regards,
Zhao



