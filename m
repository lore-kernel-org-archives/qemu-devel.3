Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A68CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzqA-00018O-B2; Wed, 29 Oct 2025 02:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDzq8-000176-5M
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:39:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDzq1-0001Nm-Ny
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761719958; x=1793255958;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DnS0Yvs1z03uEdqAFXx0ktOv4LAyDh0CIIGIB1D7S/Y=;
 b=P29xRvw3gJ6bjKSpoXYUPlr3PQglhjvCOj5rDzQkT7M0EFpfPp5Zl7EC
 YUcxxDmB4DQK0yWo+dloWtFZ7+7pD4GIvGGc0jBBOpEev3QClrwSV9CEm
 fs0etog3pxjcUKPlQKaziFRkHbYIkdicwFncgt6z03i6eyGYIyeC8oKL5
 ylIWRh8uU6O0sly51PEenqzjUqVPcZe5o+0ErsqbnKA0ZNFX2pczGbm70
 Im09U1xj6U5wv2r2iOmyercZqnaWuwqTm5E47GtmiqFgEpRDNwfMBxY23
 JKeFkdp2n/qBZ/rnbkE5sloTgfRvQ5aLRe5j27treoIKcSG8ETwDUcgnq w==;
X-CSE-ConnectionGUID: 5+BnHJ9TQPyKyvIY5w/Vag==
X-CSE-MsgGUID: 3hvH1PS/SkGVCZzdgvCrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63927854"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="63927854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 23:39:11 -0700
X-CSE-ConnectionGUID: 2w9DHdp4SzGrhqX1jWNNlA==
X-CSE-MsgGUID: ZkcHdB29Re+v+kNTSNil6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="189926654"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 28 Oct 2025 23:39:10 -0700
Date: Wed, 29 Oct 2025 15:01:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 02/18] i386/kvm/cpu: Init SMM cpu address space for
 hotplugged CPUs
Message-ID: <aQG7wdY/lBjgzho3@intel.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028173430.2180057-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 7512be64d67..5716191fff1 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -183,6 +183,17 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
>          fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>      }
>  
> +    /*
> +     * Non-hotplugged CPUs get their SMM cpu address space initialized in
> +     * machine init done notifier: register_smram_listener().
> +     *
> +     * We need initialize the SMM cpu address space for the hotplugged CPU
> +     * specifically.
> +     */
> +    if (kvm_enabled() && dev->hotplugged && x86_machine_is_smm_enabled(x86ms)) {
> +        kvm_smm_cpu_address_space_init(cpu);
> +    }
> +

Unfortunately, the original KVM SMM patch caused this bug, but even
more unfortunately, CPU_FOREACH in the machine_done callback is more
fragile than I originally anticipated, now requiring more hack checks to
fix. :-(

IMO, the root of the chaos is that KVM SMM doesn't do this in the CPU
context like TCG did for a long time. I'll find time to sort all this
out.

Regards,
Zhao


