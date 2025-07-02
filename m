Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB5C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxSh-0004is-Kz; Wed, 02 Jul 2025 09:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWxSe-0004iI-8Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:25:16 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWxSX-0002DQ-II
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751462710; x=1782998710;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LLsGRaXjJS5cplqAIIAuiTCSwTmClG6GpcVEPe+JNEA=;
 b=Ejt9LQJHTRWsWhZOQbRrjX5oAaxpn8S6eUNdYtEuokY+fyLPrB7TNkOv
 zKG67jXi+yazIZITAht7+yko558fy8H/S27LKpDBm1YFUwdrYpyyHDx+Q
 4pn3Y/soS8iU7MLvXVgui9gK2W6hkDbfBMNlsyubVo2+RP8pBKXJZ9YDS
 ofsUDWj7+JT1HwW7tcBXKaPgOu9OoYCKTrnC1hYYFxs9MCquIUlXzuy/I
 +mcJCoGJiIDDX/SraDiMzS/NLZNoAsB7R3blyeS/Vjo1+aJjrDA7ZA5CW
 rN5qv8vEv30dhUWDrPjqTaAsNwsKPpeeYXZ++x017XoAVqrVuNzVO9x1n g==;
X-CSE-ConnectionGUID: 5KPi9MOPTVueew/V7J9XDw==
X-CSE-MsgGUID: FFdam4MUQj6CI8NYsi2NbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="56377305"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="56377305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:24:59 -0700
X-CSE-ConnectionGUID: Icm6SKdIQSOg/3DDyB06ng==
X-CSE-MsgGUID: VHciT/tvSp2zHkCk3ujgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="154230509"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:24:57 -0700
Message-ID: <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
Date: Wed, 2 Jul 2025 21:24:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com> <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/2/2025 8:12 PM, Paolo Bonzini wrote:
> Il mer 2 lug 2025, 07:42 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> 
>> Back to Paolo's example of "a compat property will be set on a device
>> *after* the class's post_init callback has run". I think the behavior of
>> compat property is applied after the class's post_init callback is also
>> what we want. If reversing the order, then compat prop can be
>> overwritten by subclass's post_init callback, and doesn't it fail the
>> purpose of compat prop?
>>
> 
> I wrote the patch because of a latent issue with TDX. The issue was roughly
> that a compat property was overwriting the TDX-specific modifications to
> CPUID. I think this case shows that you *do* want the subclass to overwrite
> the compat property—of course the subclass code must be aware that compat
> properties exist and limit changes appropriately.

IIRC that's on rhel QEMU which ports the TDX code before it's merged 
upstream. Now TDX is upstreamed, it works with upstream compat property 
and I think future new compat property won't affect TDX or anything, 
since it's compat property and it's to guarantee the existing behavior 
when introducing new behavior?

> In general I don't see how the reverse order makes sense: the subclass
> knows what the superclass does, so it can do the right thing if it runs
> last; but the superclass cannot know what all of its subclasses do in
> post_init, so it makes less sense to run it last.

I agree in general the parent to child order makes more sense, 
especially when we treat .instance_init() as the phase 1 init and 
.post_instance_init() as the phase 2 init.

But the original purpose of introducing .post_instance_init() was to 
ensure qdev_prop_set_globals() is called at last for Device. Reverse the 
order breaks this purpose.

It seems not good option like the reversed order from child to parent 
that can achieve it by just putting the last step in top parent's.

I'm looking forward to seeing a better solution.

> Paolo
> 
> 
>> So I think we might revert this patch, and document clearly the reverse
>> order of .post_instance_init() callback.
>>
>>> X86 CPUs have the issue (e.g., "vendor" doesn't work) now because
>>> they - as leaf class, don't care about the property values of
>>> superclass - the DeviceState. If a property is just for initialization,
>>> like "vendor", it should be placed in the instance_init() instead of
>>> instance_post_init().
>>>
>>> In addition, if other places handle it similarly, the device's
>>> post_init seems pointless. :-(
>>>
>>> Thanks,
>>> Zhao
>>>
>>
>>
> 


