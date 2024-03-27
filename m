Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FC3C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOKH-0008KJ-PC; Wed, 27 Mar 2024 04:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpOKD-0008Jk-1B
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:07:58 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpOKA-0002US-Sb
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711526875; x=1743062875;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HKULoIopCsTwAep+hILqmFUGcig9iPX8QBi+Y4ITq+A=;
 b=i7TxUDUWHHGkb/GwP0oklCJN2OZjlMeC/PxYcHhxgQZA0spav8tjzgXH
 oUs20sBYU4VlDgMRVS1PhZticYqCAqmywZvsPrAN6VSpGJ3CbFDuBLYFj
 cFK8G2/tajBdFHg0ijLKdFAOuFSB14deiDMLjNNJaWTImJ/KA2wuDWLWr
 isWHpqyQ4xLZkp1sFqNdeEimUYv/rJ68q++r14ZZc+bV7wjWkrsRVQHBo
 kp0nF+23fJkhymvEN0wmZxlV1sSwjmVz0Sx3wSsBemc0+Gl5TN3NOuqPq
 CvXYSjRF90Mu0kF3MdFm6pnRfhvcp1z3UlsLqvPbBvUPAF5EE+u+RCiC9 Q==;
X-CSE-ConnectionGUID: rhlPZmJSSRafE/7euawLgg==
X-CSE-MsgGUID: +uEIEdncRN2c2KyJUtYAfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="32054040"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="32054040"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 01:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16204181"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2024 01:07:49 -0700
Date: Wed, 27 Mar 2024 16:21:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH for-9.1 v5 3/3] kvm: add support for guest physical bits
Message-ID: <ZgPXGIufIBnC9xCj@intel.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141422.1380087-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

On Mon, Mar 25, 2024 at 03:14:22PM +0100, Paolo Bonzini wrote:
> Date: Mon, 25 Mar 2024 15:14:22 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 v5 3/3] kvm: add support for guest physical bits
> X-Mailer: git-send-email 2.44.0

[snip]

>  static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
> +    bool ret;
>  
>      /*
>       * The realize order is important, since x86_cpu_realize() checks if
> @@ -50,7 +72,17 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                     MSR_IA32_UCODE_REV);
>          }
>      }
> -    return host_cpu_realizefn(cs, errp);
> +    ret = host_cpu_realizefn(cs, errp);
> +    if (!ret) {
> +        return ret;
> +    }
> +
> +    if ((env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) &&
> +        cpu->guest_phys_bits == -1) {
> +        kvm_set_guest_phys_bits(cs);
> +    }
> +
> +    return true;
>  }
>

Just nit, it seems the comment about "realize order" in
kvm_cpu_realizefn() should also be updated to include this new
kvm_set_guest_phys_bits().

Or, I feel the guest_phys_bits could also be set in host_cpu_realizefn()
since it also indicates the host support.

Anyway, this won't affect this current series. LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


