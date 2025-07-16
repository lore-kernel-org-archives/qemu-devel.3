Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF87C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 04:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubtqT-0006sz-0y; Wed, 16 Jul 2025 00:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubtqP-0006lE-On
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:34:13 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubtqN-0002cp-Rs
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752640452; x=1784176452;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hup3CwDErWU2vwExe2NkM/8/9ILhHcpWQJJ/GZbPCH0=;
 b=ZPjhuDkKsYG5vnVmJoAj34cUKqbVYRz049Fnslos9DBpyCqtvW5xVleR
 ZSMgwzPBzrVyTIFqPMtzIhVY5xfGi8WAbTbgZJ9061lub9RZ/mb5nWEXZ
 xDvhYCpe/2qW4SLWY6frN6BBXSp/qjBnp0o/S1VKqDYlGtHO2uKGuWT3S
 UDRsUgNpAlctQhpKBSjt80cCDmnuDFZbGASwQpIxD3lR0xp7ThOOK1ASL
 zG9jhw5U3897CwWY6qesKHbIB3r4fcmLPurciavthhwA2NtD5Zwh3rBlb
 E63adFBCXu4Kjm31V0e9gkSmxbIaaaTfTdSx9bwXmpXbT4ZnXna8Is1NH w==;
X-CSE-ConnectionGUID: KnzonnSKRwCkDXXIbsgcYA==
X-CSE-MsgGUID: sw778RR+Te6F4d1vEbOUeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54997134"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="54997134"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 21:34:11 -0700
X-CSE-ConnectionGUID: DZbXId9MRSWw5oqweECDvw==
X-CSE-MsgGUID: u56ysXoBR8SStOEa8o1s+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="163039185"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 15 Jul 2025 21:34:09 -0700
Date: Wed, 16 Jul 2025 12:55:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, bp@alien8.de, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] target/i386: Add TSA feature flag verw-clear
Message-ID: <aHcwy7BRIh219WHh@intel.com>
References: <12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com>
 <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 10, 2025 at 02:46:11PM -0500, Babu Moger wrote:
> Date: Thu, 10 Jul 2025 14:46:11 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v2 2/2] target/i386: Add TSA feature flag verw-clear
> X-Mailer: git-send-email 2.34.1
> 
> Transient Scheduler Attacks (TSA) are new speculative side channel attacks
> related to the execution timing of instructions under specific
> microarchitectural conditions. In some cases, an attacker may be able to
> use this timing information to infer data from other contexts, resulting in
> information leakage
> 
> CPUID Fn8000_0021 EAX[5] (VERW_CLEAR). If this bit is 1, the memory form of
> the VERW instruction may be used to help mitigate TSA.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: Split the patches into two.
>     Not adding the feature bit in CPU model now. Users can add the feature
>     bits by using the option "-cpu EPYC-Genoa,+verw-clear".
> 
> v1: https://lore.kernel.org/qemu-devel/20250709104956.GAaG5JVO-74EF96hHO@fat_crate.local/
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


