Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F09E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 04:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNPBZ-0007SQ-Eu; Mon, 16 Dec 2024 23:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNPBX-0007S2-3i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 23:27:51 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNPBR-0007YR-Re
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 23:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734409666; x=1765945666;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a7SOYsckgzbJ2IhBtbx6TFv6Y0JwRMRvfwJSihNSIiM=;
 b=nPbpJUmr//YfoenxYBlFXBd0YjL20XYjNi7j2w389VJRbT+yf0FtUqwo
 gIfYao7Lgt8mRFXJ0/e9dV39BooJopZMxR8LlzxM7mjiDYqPZi18h4UjT
 N40rzhlAxE7mXCYotiKuhzLgsyKhwqO0Lgfkl7WDB/RvygVKebOcRqZaa
 +/QguimVoZ9+v0P6pjI7lBVoyFc9qNTOSpa2YHJ1ynJhOQ1aLYPNY8zLd
 HtPLgrx7+hcYZSUZ6CfsMIrNlF5JHgKmolzmhbdqDyfbenFPE83JBH9hX
 GquXTF+9H0k0MxrUM4DKbxuvAvEGSaM5tQut1/wd1hMzaVwApczgNUKMz A==;
X-CSE-ConnectionGUID: xxCN9cHhS2mR8vMqCpGPOw==
X-CSE-MsgGUID: Bs+SDlWrR3aTgSp7vqb3pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52231196"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; d="scan'208";a="52231196"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 20:27:39 -0800
X-CSE-ConnectionGUID: Yx7LxBZvRUW6GNRiShxAzw==
X-CSE-MsgGUID: 1wfG0Y1bSKmoORcFDq76Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; d="scan'208";a="97985121"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 20:27:35 -0800
Message-ID: <eedbef51-ab8f-4d28-af8b-ba405d060015@intel.com>
Date: Tue, 17 Dec 2024 12:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (Proposal) New TDX Global Metadata To Report FIXED0 and FIXED1
 CPUID Bits
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Kai Huang <kai.huang@intel.com>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Yan Y Zhao <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <43b26df1-4c27-41ff-a482-e258f872cc31@intel.com>
 <d63e1f3f0ad8ead9d221cff5b1746dc7a7fa065c.camel@intel.com>
 <e7ca010e-fe97-46d0-aaae-316eef0cc2fd@intel.com>
 <269199260a42ff716f588fbac9c5c2c2038339c4.camel@intel.com>
 <Z2DZpJz5K9W92NAE@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z2DZpJz5K9W92NAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/17/2024 9:53 AM, Sean Christopherson wrote:
> On Tue, Dec 10, 2024, Rick P Edgecombe wrote:
>> On Tue, 2024-12-10 at 11:22 +0800, Xiaoyao Li wrote:
>>>> The solution in this proposal decreases the work the VMM has to do, but
>>>> in the long term won't remove hand coding completely. As long as we are
>>>> designing something, what kind of bar should we target?
>>>
>>> For this specific #VE reduction case, I think userspace doesn't need to
>>> do any hand coding. Userspace just treats the bits related to #VE
>>> reduction as configurable as reported by TDX module/KVM. And userspace
>>> doesn't care if the value seen by TD guest is matched with what gets
>>> configured by it because they are out of control of userspace.
>>
>> Besides a specific problem, here reduced #VE is also an example of increasing
>> complexity for TD CPUID. If we have more things like it, it could make this
>> interface too rigid.
> 
> I agree with Rick in that having QEMU treat them as configurable is going to be
> a disaster.  But I don't think it's actually problematic in practice.

Correct the proposal. It should be QEMU treats them as what KVM reports.

TDX module reports these #VE reduction related CPUIDs as configurable 
because it allows VMM to paravirt them. If KVM doesn't support the 
paravirt of them, KVM can clear them from configurable bits and add them 
to fixed0 bits when KVM reports to userspace.

> If QEMU (or KVM) has no visibility into the state of the guest's view of the
> affected features, then it doesn't matter whether they are fixed or configurable.
> They're effectively Schrödinger's bits: until QEMU/KVM actually looks at them,
> they're neither dead nor alive, and since QEMU/KVM *can't* look at them, who cares?

To some degree, I think it matters. As I explained above, if KVM reports 
it as configurable to userspace, it mean TDX module allows it to be 
configured and KVM allows it to be paravirtualized as well. So userspace 
can configure it as 1 when users wants it. This is how VMM is going to 
present the feature to TD guest.

However, how TD guest is going to use it depends on itself.
1) when TD guest doesn't enable #VE reduction: the configuration from 
VMM doesn't matter. The CPUIDs are fixed1 and related operation leads to 
#VE.

2) When TD guest enables #VE reduction and doesn't enable 
TDCS.FEATURE_PARAVIRT_CTRL of the related bit: the configuration from 
VMM doesn't matter. The CPUIDs are fixed0 and related operation leads to 
#GP.

3) When TD guest enables #VE reduction and enable 
TDCS.FEATURE_PARAVIRT_CTRL of the related bit: the configuration from 
VMM matters.
   - When VMM configures the bits to 1, the related operation leads to 
#VE (for paravirtualization).
   - When VMM configures the bits to 0, the related operation leads to #GP.

So for case 3), it does matters.

> So, if the TDX Module *requires* them to be set/cleared when the TD is created,
> then they should be reported as fixed.  If the TDX module doesn't care, then they
> should be reported as configurable.  The fact that the guest can muck with things
> under the hood doesn't factor into that logic.

yes, I agree on it.

> If TDX pulls something like this for features that KVM cares about, then we have
> problems, but that's already true today.  If a feature requires KVM support, it
> doesn't really matter if the feature is fixed or configurable.  What matters is
> that KVM has a chance to enforce that the feature can be used by the guest if
> and only if KVM has the proper support in place.  Because if KVM is completely
> unaware of a feature, it's impossible for KVM to know that the feature needs to
> be rejected.

I agree.

With the proposed fixed/fixed1 information, and in addition to the 
configurable bits, KVM can fully validate the TDX module against its 
capabilities. When violation occurs (e.g., some KVM unsupported bit 
being reported as fixed1 by TDX module), KVM can just refuse to enable TDX.

> This isn't unique to TDX, CoCo, or firmware.  Every new feature that lands in
> hardware needs to either be "benign" or have the appropriate virtualization
> controls.  KVM already has to deal with cases where features can effectively be
> used without KVM's knowledge.  E.g. there are plenty of instruction-level
> virtualization holes, and SEV-ES doubled down by essentially forcing KVM to let
> the guest write XCR0 and XSS directly.
> 
> It all works, so long as the hardware vendor doesn't screw up and let the guest
> use a feature that impacts host safety and/or functionality, without the hypervisor's
> knowledge.
> 
> So, just don't screw up :-)


