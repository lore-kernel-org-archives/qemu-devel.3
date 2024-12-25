Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752DCE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 03:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQI6i-00033A-AK; Tue, 24 Dec 2024 22:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQI6Z-00031h-KD
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 22:30:46 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQI6X-0001hm-9w
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 22:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735097437; x=1766633437;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3iKFT4z2oDkIUweu+RodEq/bkoPWuslvhF1RfRv3KD4=;
 b=jZ7yjmy4ZHndvv/fdFWlQpIINO2OmCMw/g62ojcMokduRkC+C4I3TfDB
 utlcl9DAhCEwGQc9TG0E1V/IYDbgTxpSaUc03tVIlZ3qdeRP3BJlt5XS4
 PIvmT1QoDfVZzqD6G/B+mGmOQDinE8D32pdSZZFWXO3Ga4RIhqTPfzyD6
 erfGEaXl2U1ZKDU/fGNGG5RfuOJdCLeKft5lEx3VKd47pnOOf87fR+AmG
 k5AcUiZ2MQPOUbGXsM0TYDdbytM2onR92XF0R0HPqlRsHoCne/tDMbf75
 d3O0XYxLjhzCl0VTXaiBrsfGTFlApYw4o0UaGYqwRwRCe1noZqjbMlAAZ Q==;
X-CSE-ConnectionGUID: kioJggVPSamhxti36xsKPg==
X-CSE-MsgGUID: LJvM7ATiS8y2H84YJMwS4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35721418"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="35721418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 19:30:34 -0800
X-CSE-ConnectionGUID: 1i829XcrTwm/HZyv+8aUBg==
X-CSE-MsgGUID: TujlvUd2Sc+92wxfcfh4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="104250933"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 24 Dec 2024 19:30:32 -0800
Date: Wed, 25 Dec 2024 11:49:14 +0800
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
Subject: Re: [PATCH v5 05/11] target/i386/kvm: Save/load MSRs of kvmclock2
 (KVM_FEATURE_CLOCKSOURCE2)
Message-ID: <Z2uAupHhVT7/HfWw@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-6-zhao1.liu@intel.com>
 <af13d0c9-1d73-4cdd-8fd0-eff86a5711d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af13d0c9-1d73-4cdd-8fd0-eff86a5711d3@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Tue, Dec 24, 2024 at 04:32:42PM +0100, Paolo Bonzini wrote:
> Date: Tue, 24 Dec 2024 16:32:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v5 05/11] target/i386/kvm: Save/load MSRs of kvmclock2
>  (KVM_FEATURE_CLOCKSOURCE2)
> 
> On 11/6/24 04:07, Zhao Liu wrote:
> > MSR_KVM_SYSTEM_TIME_NEW and MSR_KVM_WALL_CLOCK_NEW are bound to
> > kvmclock2 (KVM_FEATURE_CLOCKSOURCE2).
> > 
> > Add the save/load support for these 2 MSRs just like kvmclock MSRs.
> 
> As mentioned in the previous patch, this is not necessary.  If it was
> needed, you'd have to also add VMSTATE fields in machine.c
> 

I see, thanks!

Regards,
Zhao


