Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA52C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq9F-0000cB-On; Tue, 27 May 2025 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJq9E-0000br-AW
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:59:00 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJq99-0002nI-20
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748336335; x=1779872335;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2gCAULFo/IOpFtt61/UupNVGk18dcBLikbAW8DfnHl4=;
 b=jxswlBpNm6kjzmL1VqcD2hnVu8jFgmw8KkvXC/376T/rKecW9nFSBqT7
 wjb52pPb1RSW36Su1bwTpk1nFM10n353PNWHz+Xrjqsl1ftQq9c+Q0aua
 XRxi9vTkIQum08IBGTuGEWuffdbGgp8ZJVlfbwKOQQ2Gp6KF+iCz3vZ7E
 Mj4Xh2lvdHFE3zMObgKp4lq7hrB+Jw1W8Vjrl/zpsVTYAZFzM2zxIWQax
 HQyRduaKg7KAJN9UWAr1bZ3cvYd83ukt1ABXV1/V32gLzjo72Tlt2ObQO
 ERdE8p6Dm79OX46rMlWhSnTRI4v9eR5TQBu8HigGzX4CFC8ApvFGnwW5R Q==;
X-CSE-ConnectionGUID: owS10EikTfiCZGVdhGELZg==
X-CSE-MsgGUID: yncD7CsoSQCQx4ChJn4ZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50473441"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50473441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 01:58:52 -0700
X-CSE-ConnectionGUID: JDtiriPCQa2w8bN8MvuNTA==
X-CSE-MsgGUID: Jqgwy1lvR2iu/TnDJffqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="165919442"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 27 May 2025 01:58:49 -0700
Date: Tue, 27 May 2025 17:19:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 00/10] i386/cpu: Cache CPUID fixup, Intel cache model &
 topo CPUID enhencement
Message-ID: <aDWDvygfMR/cHJx2@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <c3ecc32c-badd-487e-a2df-0594661bc65e@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ecc32c-badd-487e-a2df-0594661bc65e@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 26, 2025 at 06:52:41PM +0800, Ewan Hai wrote:
> Date: Mon, 26 May 2025 18:52:41 +0800
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [RFC 00/10] i386/cpu: Cache CPUID fixup, Intel cache model &
>  topo CPUID enhencement
> 
> 
> 
> On 4/23/25 7:46 PM, Zhao Liu wrote:
> > Hi all,
> > 
> > (Since patches 1 and 2 involve changes to x86 vendors other than Intel,
> > I have also cc'd friends from AMD and Zhaoxin.)
> > 
> > These are the ones I was going to clean up a long time ago:
> >   * Fixup CPUID 0x80000005 & 0x80000006 for Intel (and Zhaoxin now).
> >   * Add cache model for Intel CPUs.
> >   * Enable 0x1f CPUID leaf for specific Intel CPUs, which already have
> >     this leaf on host by default.
> 
> If you run into vendor specific branches while refactoring the
> topology-related code, please feel free to treat Intel and Zhaoxin as one
> class. For every topology CPUID leaf(0x0B, 0x1F, ...) so far, Zhaoxin has
> followed the Intel SDM definition exactly.

Thank you for your confirmation. I'll post v2 soon (If things go well,
it'll be in the next two weeks. :-) )

Regards,
Zhao


