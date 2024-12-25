Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8181E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQHak-00051g-Os; Tue, 24 Dec 2024 21:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHaj-00051P-2T
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:57:45 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQHah-00038e-AE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735095463; x=1766631463;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9A/iqk1plgz2s/gWjaqcCmE2nOGsWYjIqYnHAEJG6IU=;
 b=TRt/WaXCwdhGPzPEwRLiLk46II75+nIiJgFnpQ6OfeLU9phPL7YoJC+7
 n6MCSoWOLkF4Q8Jnzt59Qpoj5NKSwMrFwxxj3QNNsIBeZ6gafSe8E3NTt
 Mqbe+fR0TvNdb01OTYtIPA5zWn1M/MMKGtj6BdLl1K2xF6SPGLy0sC5k0
 Fee54ZbyL7ymgtucnJVe5LYopKvl50jWogK4NJX1ybeTr50sJd0y4gMC4
 QbW8xdH7sACwyxU0p5yY42kRiKP24Z8eex0OI7oaGxlrGKXA4lklj25Gq
 3G2V4IpS5SWdFeEu8hMzuZcONOFCULMKycEx4N9EV6bFYw7XFXWw8pkoP Q==;
X-CSE-ConnectionGUID: M53qBwM/R4m3QTnNTD6S3g==
X-CSE-MsgGUID: Sv1W9zlaSk2kTlTXRoOPNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34830117"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="34830117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 18:57:39 -0800
X-CSE-ConnectionGUID: 5lcW9VqiSXefn+HpcsTR3g==
X-CSE-MsgGUID: vAD5X8TETTaJz3x1DgAQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="103713460"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 24 Dec 2024 18:57:36 -0800
Date: Wed, 25 Dec 2024 11:16:19 +0800
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
Subject: Re: [PATCH v5 11/11] target/i386/kvm: Replace
 ARRAY_SIZE(msr_handlers) with KVM_MSR_FILTER_MAX_RANGES
Message-ID: <Z2t5AxDxRvQ1sIO8@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-12-zhao1.liu@intel.com>
 <5463356b-827f-4c9f-a76e-02cd580fe885@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5463356b-827f-4c9f-a76e-02cd580fe885@redhat.com>
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

On Tue, Dec 24, 2024 at 04:54:41PM +0100, Paolo Bonzini wrote:
> Date: Tue, 24 Dec 2024 16:54:41 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v5 11/11] target/i386/kvm: Replace
>  ARRAY_SIZE(msr_handlers) with KVM_MSR_FILTER_MAX_RANGES
> 
> On 11/6/24 04:07, Zhao Liu wrote:
> > kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
> > when traversing msr_handlers[], while other places still compute the
> > size by ARRAY_SIZE(msr_handlers).
> > 
> > In fact, msr_handlers[] is an array with the fixed size
> > KVM_MSR_FILTER_MAX_RANGES, so there is no difference between the two
> > ways.
> > 
> > For the code consistency and to avoid additional computational overhead,
> > use KVM_MSR_FILTER_MAX_RANGES instead of ARRAY_SIZE(msr_handlers).
> 
> I agree with the consistency but I'd go the other direction.
>

OK, I'll switch to the other way.

Thanks,
Zhao


