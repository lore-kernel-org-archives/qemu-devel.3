Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E407C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFSJl-0008Q0-5M; Thu, 15 May 2025 02:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFSJi-0008OC-UD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:43:43 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFSJg-0007Zy-Tm
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747291421; x=1778827421;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=I09ea2kKf9RnKIED493f/5AWWrQRUzEO3KzDsvyoMOY=;
 b=TcgkhbcPqF36O7WWVTvEGUyh3SZ0Pb0fdeRYFs51NFJ/NTKn2iwRVAld
 xr9D8ytOUCX0RbygrMIgZgWK3viwA8rX1YlTQlAekjdk84sio1ho6o/Vo
 CETJ/Y6Laq7iGkuCoxzKvbtcWmWgqDdw7xR8zfjesqTGxjNpTIUXWGcWK
 VAF6E0NRpuJY7fpl+yGQMT2DJYZLHvm0OA7ledkBzsY35nCOxSMmiuJOT
 1cjVCVW2bDy0BtgtabDylS3U35Mx9J8YOXUeDSiLL2LjixJUrnDCiG3oi
 cNBBNS8YOjldA+ihzF1YU/cCOoGBeLmn0Cegg54+zrP5riPa9k0NU86H+ Q==;
X-CSE-ConnectionGUID: 7QJflad3Q6msUil1FjCKhQ==
X-CSE-MsgGUID: upVF/OplQMWbsFI2jEwKMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60222688"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="60222688"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 23:43:34 -0700
X-CSE-ConnectionGUID: OyFXNiyCS+KrRiFuXOWz3w==
X-CSE-MsgGUID: kg+8aFfdQHadJbEhcLz3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="143153675"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 23:43:30 -0700
Message-ID: <f825c105-9a19-4b17-9798-57d6cff76f95@intel.com>
Date: Thu, 15 May 2025 14:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
To: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-7-zhao1.liu@intel.com>
 <20250513144515.37615651@imammedo.users.ipa.redhat.com>
 <aCS1XVotdnLw+kqX@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aCS1XVotdnLw+kqX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/14/2025 11:23 PM, Zhao Liu wrote:
> Hi Igor, thanks for your review!
> 
> On Tue, May 13, 2025 at 02:45:15PM +0200, Igor Mammedov wrote:
>> Date: Tue, 13 May 2025 14:45:15 +0200
>> From: Igor Mammedov <imammedo@redhat.com>
>> Subject: Re: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force
>>   exposing CPUID 0x1f
>> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
>>
>> On Wed, 23 Apr 2025 19:46:58 +0800
>> Zhao Liu <zhao1.liu@intel.com> wrote:
>>
>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>>
>>> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
>>> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
>>> module level, are configured for the guest, e.g., -smp xx,dies=2.
>>>
>>> However, TDX architecture forces to require CPUID 0x1f to configure CPU
>>> topology.
>>>
>>> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
>>> requires CPUID leaf 0x1f to be exposed to guest.
>>>
>>> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
>>> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
>>> to enable cpuid leaf 0x1f for the guest.
>>
>> that reminds me about recent attempt to remove enable_cpuid_0xb,
>>
>> So is enable_cpuid_0x1f inteded to be used by external users or
>> it's internal only knob for TDX sake?
> 
> TDX needs this and I also try to apply this to named CPU models. For
> max/host CPUs, there are no explicit use cases. I think it's enough to
> make named CPU models have 0x1f.
> 
> Then this should be only used internally.
> 
>> I'd push for it being marked as internal|unstable with the means
>> we currently have (i.e. adding 'x-' prefix)
> 
> Sure, 'x-' is good. (If there is the internal property in the future,
> I can also convert this unsatble property into internal one.)
> 
> This patch is picked from the TDX series, and in this patch Xiaoyao
> doesn't make 0x1f enabling as property. In the next patch (RFC patch 7),
> I add the "cpuid-0x1f" property. I'll rename that property as
> "x-cpuid-0x1f".
> 
>> and also enable_ is not right here, the leaf is enabled when
>> topology requires it.
>> perhaps s/enable_/force_/
> 
> Thanks, I agree force_cpuid_0x1f is a better name.
> 
> @Xiaoyao, do you agree with this idea?
> 
> But probably TDX won't have v10 though, I can rename the field in my v2
> after TDX.

I'm OK with it.

The TDX series won't be merged by Paolo soon. It has to be after the KVM 
part being in linux v6.16-rc1, i.e., about one month later.

And there are rebase conflicts when I rebase the TDX-QEMU series against 
upstream QEMU master daily. It seems to have a newer version of TDX-QEMU 
when it's going to be picked up by Paolo for Paolo's convenience. If a 
v10 needed, I can rename in it.

Let's see how it goes.

> Regards,
> Zhao
> 


