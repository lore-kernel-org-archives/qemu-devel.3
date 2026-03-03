Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAEFEB364F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFHj-0002Jv-De; Mon, 02 Mar 2026 21:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vxFHc-0002JE-S8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:14:49 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vxFHY-00076j-Rk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772504084; x=1804040084;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dJ+nM1rZKhBku7BTOAfFtjS+qxzVg3ZffgZLsBcQsMc=;
 b=VeQvmOOYrENe8MhSzZqfQHRkJkU52YcMCPuJstF8cVe8WxIlYBUev/Vo
 KVm91njqj59XNdL3T+KrhaKh56wF6HcizBXKAOBSj59GkCKq6lzi9GadM
 yA5nNNkXhKumfBjecV6waPWarsJfeWLfhUZnNAe1asknEkR0SZJMSOXSj
 Z6qO458BgPouQhJ+eJ1YXoF4/H3uIyV04L5QHvRvFKAMFroVpa4Nk336x
 tEO1MBzTgJs9XL+NL8gflL33DFkUKG4YPPrBm2TyQkc2x8n6zWdJ8FX55
 3AQx/q/cC3mY8XPqIjxJW6RT6gJPv1ayOPEiOUEi7Tx2poDuoIXUfrugg A==;
X-CSE-ConnectionGUID: vZY+WZi6RrOOAY1HmWXQyg==
X-CSE-MsgGUID: 2MJTJKtVSKegLQ8OWVQVqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73639420"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="73639420"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 18:14:37 -0800
X-CSE-ConnectionGUID: C3pJE05NQQmmHXC9hWpfTQ==
X-CSE-MsgGUID: y9yLDIXKSrmsSedM48/5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="214222021"
Received: from unknown (HELO [10.238.1.107]) ([10.238.1.107])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 18:14:36 -0800
Message-ID: <0d95d1ba-68d8-455d-b8f0-4ddaa90790c4@intel.com>
Date: Tue, 3 Mar 2026 10:14:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: i386: Default disable ignore guest PAT quirk
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: myrslint <qemu.haziness801@passinbox.com>
References: <20260227071852.86283-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260227071852.86283-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/27/2026 3:18 PM, Paolo Bonzini wrote:
> From: myrslint <qemu.haziness801@passinbox.com>
> 
> Add a new accelerator option that allows the guest to adjust the PAT.
> This is already the case for TDX guests and allows using virtio-gpu
> Venus with RADV or NVIDIA drivers.
> 
> The quirk is disabled by default.  Since this caused problems with
> Linux's Bochs video device driver, add a knob to leave it enabled,
> and for now do ont enable it by default.

s/do ont/do not/

> 
> Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
> Link: https://lore.kernel.org/r/175527721636.15451.4393515241478547957-1@git.sr.ht
> [Add property; for now leave it off by default. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/system/kvm_int.h |  1 +
>   accel/kvm/kvm-all.c      |  1 +
>   target/i386/kvm/kvm.c    | 50 +++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 51 insertions(+), 1 deletion(-)
> 

...

> +
> +    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
> +                                   &OnOffAuto_lookup,
> +                                   kvm_arch_get_honor_guest_pat,
> +                                   kvm_arch_set_honor_guest_pat);
> +    object_class_property_set_description(oc, "honor-guest-pat",
> +                                          "Disable KVM quirk that ignores guest PAT "
> +                                          "memory type settings (default: auto)");

s/default: auto/default: off/

With above fixed,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

