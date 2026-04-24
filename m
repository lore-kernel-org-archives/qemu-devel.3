Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4387DFED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLC6-0008NA-7N; Fri, 24 Apr 2026 14:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wGLBt-0008Jq-8W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:23:54 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wGLBo-0004rm-KT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777055025; x=1808591025;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uGXwfDYO1jrYIQbonz7msTpOo+ktrOsz3dzPbT8IDdE=;
 b=VXy9Y+8TRWhfvV2oK6y9ICNyioyh6hRq5+d82ngmhIo7Pfn27+CeMjvS
 LL40qG8DCTXI0wBg5G/A5ihN0YRjdvxLaMMPUdKhIhAU6j5K+eJGyE8wi
 TD0SDNLjIv2w0LBzdwCq9CaWV1izYUWF2av9ItPOE5VHJbDV2uXR1O6Fu
 G/2cO34Fv++2l5W3DxnXPVJkrS74d/v3oDCoW2rI7Os6mOmyr0lwDt+U5
 zemeBDgZ/T7XOG6dulsHtlgr/c7snBlOlQhhdpcgeFGXlv0jOymb+DxGb
 vWv2VlSzVb7ERvTCc0jG6Lwncd1yGHfc6E1RZBsYSXos17mMGhIjcBYLb w==;
X-CSE-ConnectionGUID: 5ecQg57CRwquTdk3kA+1Nw==
X-CSE-MsgGUID: zURtZywhQAikFjndQ2e7Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="88348928"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="88348928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 11:23:34 -0700
X-CSE-ConnectionGUID: xSpqcdfASdODhtW3574+kA==
X-CSE-MsgGUID: Ghdv6X/KQPO9aTj3wKiycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="232027376"
Received: from unknown (HELO [10.241.240.162]) ([10.241.240.162])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 11:23:33 -0700
Message-ID: <0e1eb66a-9c06-4c75-98d0-dc3b9b1296de@intel.com>
Date: Fri, 24 Apr 2026 11:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-2-zide.chen@intel.com> <aeid0QluufANcH59@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aeid0QluufANcH59@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/22/2026 3:07 AM, Zhao Liu wrote:
> On Wed, Mar 04, 2026 at 10:07:00AM -0800, Zide Chen wrote:
>> Date: Wed, 4 Mar 2026 10:07:00 -0800
>> From: Zide Chen <zide.chen@intel.com>
>> Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
>> X-Mailer: git-send-email 2.53.0
>>
>> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
>> (bit 11), is deprecated and has been superseded by LBR and Intel PT.
> 
> I'm not clear from which platform this bit will be set by default?

My apologies, my statement was inaccurate and misleading. Newer PMU
features may cover most of the use cases addressed by BTS, and BTS
appears to see limited use in practice. However, it remains supported in
the latest CPUs.

> 
>> KVM yields control of this bit to userspace since KVM commit
>> 9fc222967a39 ("KVM: x86: Give host userspace full control of
>> MSR_IA32_MISC_ENABLES").
> 
> If KVM won't support it, it's better to only configure for KVM.

But QEMU doesn't support PMU for other hypervisors.

> 
>> However, QEMU does not set this bit, which allows guests to write the
>> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
>> this may lead to unexpected MSR access errors.
> 
> But overall, this way is a bit user-unfriendly. For cases where CPUID
> is unavailable, it would be more proper to check the KVM API to
> determine whether support is available; making this change in userspace
> feels a bit like applying the special patch for a corner case.
> 
> I found there's another patch where Paolo and Sean didn't want to make
> such changes directly earlier on....
> https://lore.kernel.org/qemu-devel/20220718032206.34488-1-zhenzhong.duan@intel.com/

Old KVM (prior to 9fc222967a39): KVM silently set BTS_UNAVAIL to hide
BTS from the guest. It worked fine.

New KVM (since 9fc222967a39): KVM gives userspace full control of
MSR_IA32_MISC_ENABLES and stopped sanitizing it. As shown in the KVM
snippet below, if KVM advertises PEBS, X86_FEATURE_DS could be exposed
and the guest incorrectly concludes BTS is available.

        if (vmx_pebs_supported()) {
                kvm_cpu_cap_check_and_set(X86_FEATURE_DS);
                kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
        }

Paolo pointed out that a QEMU-only fix is insufficient because old QEMU
+ new KVM remains broken. Two KVM-side approaches were proposed:

Option 1 (quirk): adding a KVM quirk to restore the old sanitizing
behavior for MSR_IA32_MISC_ENABLES when running with old userspace.

Option 2 (synthetic feature MSR): KVM exposes a new synthetic MSR for
userspace to explicitly control BTS/PEBS guest visibility, with a safe
default of hidden.

It is debatable whether either fix is worth the effort for such a rarely
used feature.


