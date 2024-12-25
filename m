Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1033E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 03:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQI60-0002rA-SX; Tue, 24 Dec 2024 22:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQI5y-0002qz-OQ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 22:30:03 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQI5v-0001LS-NA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 22:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735097400; x=1766633400;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6KRt73S8jyUxIj99alg4jIGUdSNAt1sqLCp/xyskvtI=;
 b=O7rL09kKI2RrdA2R5otIZQNRHUmewnE3Uo9HphEnPShZGrIfsEf6J4oU
 tge22/4X+xf4E8lLjPCOo7Od/2EuHkVIZvosvUvSuU2Lonp2eLyDvZezI
 s3xOsLOfCmAzs5zWgqRLLWsDLNb1Uousj5JFgd6lBwPErmGeRv5mITHJ3
 7FkB6SCGQr49dO+jToAwCalh3v8MPdqdiCZJEunwZZHoeOzx/QaWLMAt8
 N+txRnn0fzctIjDHcmrK+qemWQo9hxgpqGXsewkbEisMEs97ccfe7+5eq
 yxVBEWJIzMOZtHP+28ziOUNv4RWtl9OZXp48ohqpWxCPdUqW0upwSg8YW g==;
X-CSE-ConnectionGUID: RoRifizRTiiS8vic1ku3Bg==
X-CSE-MsgGUID: DbSPKMM4TUawsfKzrelH5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34831965"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="34831965"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 19:29:56 -0800
X-CSE-ConnectionGUID: qpRstatgSFupSRXCMiNDug==
X-CSE-MsgGUID: 3kiwq8OCSB+FFsUsg79H2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="104623068"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 24 Dec 2024 19:29:53 -0800
Date: Wed, 25 Dec 2024 11:48:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Tao Su <tao1.su@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v5 04/11] target/i386/kvm: Only save/load kvmclock MSRs
 when kvmclock enabled
Message-ID: <Z2uAk84u4JYON5tW@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-5-zhao1.liu@intel.com>
 <9d60933c-4713-4d61-b11f-64d4bb667e04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d60933c-4713-4d61-b11f-64d4bb667e04@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Tue, Dec 24, 2024 at 04:31:28PM +0100, Paolo Bonzini wrote:
> Date: Tue, 24 Dec 2024 16:31:28 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v5 04/11] target/i386/kvm: Only save/load kvmclock MSRs
>  when kvmclock enabled
> 
> On 11/6/24 04:07, Zhao Liu wrote:
> > MSR_KVM_SYSTEM_TIME and MSR_KVM_WALL_CLOCK are attached with the (old)
> > kvmclock feature (KVM_FEATURE_CLOCKSOURCE).
> > 
> > So, just save/load them only when kvmclock (KVM_FEATURE_CLOCKSOURCE) is
> > enabled.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> 
> The MSRs contains the same values as the "new" pair; QEMU only has to
> save/restore one of them but the code should be active for both feature bits
> and thus use
> 
> +        if (env->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
> +                                           CPUID_KVM_CLOCK2)) {
> 

This is the correct way, thanks.

Regards,
Zhao



