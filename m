Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CFFC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDco-0007qs-I2; Wed, 14 May 2025 11:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDcd-0007iz-8B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:02:15 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDca-0003mQ-Ji
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747234932; x=1778770932;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zFXxawauuxtm7HBHWeV3O57mNyIF/zheVg9ulo2+hHg=;
 b=WdTpGEyw3cl6Kr62J1ltVVlbN6LkWRzCGKqKdLqzRA5sRVV43GL3U0KS
 i1Jod5GpF8zgYkBseaDVwWMLKF9D2tI15mP74pyjc7D7Y+pTRH7WU2SNl
 Ur/r/ID0k4Pw+QCdQFMmtnf2MKSuWg56g0PFLOPoS3P7YR4nhZq5mabFx
 XkpzX609pbb00nFvDyIgsPdl69ucnEQiEJQnd4fk9WslZWsPDB30fddHc
 YB1Truoa700xRLwnU7/Bwg5qYEGiflC25viueoF950wl3yJdiDv1aLMp3
 th7+3pa48hey32zdLSQiWRGACfa/9wT+EIcPKGFeaW0IW62nF91FDRyNJ w==;
X-CSE-ConnectionGUID: wjMsBcFSSuymfQgc73ehpg==
X-CSE-MsgGUID: mXlB5GAmQhCTX5YRlgZLJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49252083"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="49252083"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 08:02:08 -0700
X-CSE-ConnectionGUID: 1u1skXxNT/KxXkr/t6GMug==
X-CSE-MsgGUID: C+LSK1wxQ92J/Kt+Ibpnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="138117958"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 May 2025 08:02:06 -0700
Date: Wed, 14 May 2025 23:23:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Tejus GK <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <aCS1XVotdnLw+kqX@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-7-zhao1.liu@intel.com>
 <20250513144515.37615651@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144515.37615651@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Hi Igor, thanks for your review!

On Tue, May 13, 2025 at 02:45:15PM +0200, Igor Mammedov wrote:
> Date: Tue, 13 May 2025 14:45:15 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force
>  exposing CPUID 0x1f
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
> 
> On Wed, 23 Apr 2025 19:46:58 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> > when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> > module level, are configured for the guest, e.g., -smp xx,dies=2.
> > 
> > However, TDX architecture forces to require CPUID 0x1f to configure CPU
> > topology.
> > 
> > Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
> > requires CPUID leaf 0x1f to be exposed to guest.
> > 
> > Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
> > cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> > to enable cpuid leaf 0x1f for the guest.
> 
> that reminds me about recent attempt to remove enable_cpuid_0xb,
>
> So is enable_cpuid_0x1f inteded to be used by external users or
> it's internal only knob for TDX sake?

TDX needs this and I also try to apply this to named CPU models. For
max/host CPUs, there are no explicit use cases. I think it's enough to
make named CPU models have 0x1f.

Then this should be only used internally.

> I'd push for it being marked as internal|unstable with the means
> we currently have (i.e. adding 'x-' prefix)

Sure, 'x-' is good. (If there is the internal property in the future,
I can also convert this unsatble property into internal one.)

This patch is picked from the TDX series, and in this patch Xiaoyao
doesn't make 0x1f enabling as property. In the next patch (RFC patch 7),
I add the "cpuid-0x1f" property. I'll rename that property as
"x-cpuid-0x1f".

> and also enable_ is not right here, the leaf is enabled when
> topology requires it.
> perhaps s/enable_/force_/

Thanks, I agree force_cpuid_0x1f is a better name.

@Xiaoyao, do you agree with this idea?

But probably TDX won't have v10 though, I can rename the field in my v2
after TDX.

Regards,
Zhao


