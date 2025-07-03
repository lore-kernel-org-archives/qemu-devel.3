Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F003C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 07:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEKo-0000vE-Hk; Thu, 03 Jul 2025 03:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEKn-0000uz-OL
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:26:17 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXEKl-0004qa-HM
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751527576; x=1783063576;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3tAVBMJz1cgvIFrjrSwAWbsjRKTYk2yoea1N3PHem44=;
 b=YyDWUl0pGXdsxd+1KhxmhpAmx5XH0tmg0iJ+j/n/0hQwK7hNRHLt9eDa
 xldXBGIV5b5C8Utfbf1smlMv3YnrBNiCMcxRnBAv8YZz/s1An27CRgkCX
 h1dXhsCP2RVqFJjRm23rbHGhOLzyO0dcQ6Xeg+2zjFo9VU29WGh1ODwyD
 JuDFj4CSkax06mckop8jpX5bqJKSkUmQ8K46ovfrHVjSMUmUx/TUxyRmb
 ohA33TkXtllLJSlb/ljb/IXSDSISyOP3ap6Lx6oMy0deeKRtEGgYSbnGc
 MkGahq1kavgQd3eMNxrDynj6N1iezDNDy15EOOgNzQ+NiBppPVEdIUw9n w==;
X-CSE-ConnectionGUID: xCtrGqbpSoC75jYazcAVFQ==
X-CSE-MsgGUID: ITnTIYUGTbOqY/cqMKU8lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="41467333"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="41467333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:26:13 -0700
X-CSE-ConnectionGUID: HCE289wUS4mKi25F3mAoUw==
X-CSE-MsgGUID: MT9r+anOR4mYdgY7IIJqfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158340963"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 03 Jul 2025 00:26:09 -0700
Date: Thu, 3 Jul 2025 15:47:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 03/16] i386/cpu: Add default cache model for Intel CPUs
 with level < 4
Message-ID: <aGY1llcyArD3T5wD@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-4-zhao1.liu@intel.com>
 <c93dce97-735b-4a1d-b766-f882e53eb50e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93dce97-735b-4a1d-b766-f882e53eb50e@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > +/*
> > + * Only used for the CPU models with CPUID level < 4.
> > + * These CPUs (CPUID level < 4) only use CPUID leaf 2 to present
> > + * cache information.
> > + *
> > + * Note: This cache model is just a default one, and is not
> > + *       guaranteed to match real hardwares.
> > + */
> > +static const CPUCaches legacy_intel_cpuid2_cache_info = {
> > +    .l1d_cache = &(CPUCacheInfo) {
> > +        .type = DATA_CACHE,
> > +        .level = 1,
> > +        .size = 32 * KiB,
> > +        .self_init = 1,
> > +        .line_size = 64,
> > +        .associativity = 8,
> > +        .sets = 64,
> > +        .partitions = 1,
> > +        .no_invd_sharing = true,
> > +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> > +    },
> > +    .l1i_cache = &(CPUCacheInfo) {
> > +        .type = INSTRUCTION_CACHE,
> > +        .level = 1,
> > +        .size = 32 * KiB,
> > +        .self_init = 1,
> > +        .line_size = 64,
> > +        .associativity = 8,
> > +        .sets = 64,
> > +        .partitions = 1,
> > +        .no_invd_sharing = true,
> > +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> > +    },
> > +    .l2_cache = &(CPUCacheInfo) {
> > +        .type = UNIFIED_CACHE,
> > +        .level = 2,
> > +        .size = 2 * MiB,
> > +        .self_init = 1,
> > +        .line_size = 64,
> > +        .associativity = 8,
> > +        .sets = 4096,
> > +        .partitions = 1,
> > +        .no_invd_sharing = true,
> > +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> > +    },
> > +    .l3_cache = &(CPUCacheInfo) {
> > +        .type = UNIFIED_CACHE,
> > +        .level = 3,
> > +        .size = 16 * MiB,
> > +        .line_size = 64,
> > +        .associativity = 16,
> > +        .sets = 16384,
> > +        .partitions = 1,
> > +        .lines_per_tag = 1,
> > +        .self_init = true,
> > +        .inclusive = true,
> > +        .complex_indexing = true,
> > +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> > +    },
> 
> Does this cache information match the real legacy HW or just an emulation
> of Qemu?

This is the pure emulation and it doesn't macth any HW :-(, and is a
"hybrid" result of continuously modifying and adding new cache features
(like the virtual L3). But for compatibility reasons, I abstracte it
into this special cache model, used only for older CPUs.

This way, at least modern CPUs won't be burdened by old historical
issues.

Thanks,
Zhao



