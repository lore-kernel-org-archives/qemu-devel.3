Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D40CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySBY-0001xX-Fz; Wed, 09 Oct 2024 04:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sySBW-0001xJ-P9
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:36:42 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sySBT-00014j-PU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728463000; x=1759999000;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=puO2yolwMmXZ4+1/AaWo0WiUXGvYXZVPtqYsDlpyI2g=;
 b=SIu9CUAWvipbPxcMIYm12vHTRxeK+8F+6s0HS1dtHN+kbdxcuhw630kX
 XElaFrQpFn8UFCI/1BSs62OFt8WuOx6EswcwgYaiwR6Fy5TEKntsi+813
 hRTHfRcLMlfnj01MEa5ivmzc/1I7jLZdmYK9W4eO+FNlc/BC2Y+vHguX5
 L7NwHHCQQ6PQ8RsDLlZ53GEQ1iBVKhNp4cpGqskcJqwC6FVd5QiecocmS
 WHhoFBbsZESQ3p2UGQyZj8kzZKuMazx8r+0ebA9gdEQdA3qrwdVL7lmSP
 ubUln4k1J4M3RnOxOQdpEKENGFWbiUMwGfNmz0mEcNKKZLQRbQ5uji/4J g==;
X-CSE-ConnectionGUID: SziPB5l9Rpi6L0Mq5zgOLA==
X-CSE-MsgGUID: S2mKf4uzQ7yRfd9IQTz2qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27639446"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27639446"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 01:36:36 -0700
X-CSE-ConnectionGUID: fWS+miooRGaMtvJG25pO9g==
X-CSE-MsgGUID: HRCGbfD0TnGkXyc1GgsmiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="75764406"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 09 Oct 2024 01:36:35 -0700
Date: Wed, 9 Oct 2024 16:52:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86: Add support save/load HWCR MSR
Message-ID: <ZwZEXyRvZeb4eO6q@intel.com>
References: <20240926040808.9158-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926040808.9158-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Hi Shiyuan,

On Thu, Sep 26, 2024 at 12:08:08PM +0800, Gao Shiyuan via wrote:
> Date: Thu, 26 Sep 2024 12:08:08 +0800
> From: Gao Shiyuan via <qemu-devel@nongnu.org>
> Subject: [PATCH v1 1/1] x86: Add support save/load HWCR MSR
> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
> 
> KVM commit 191c8137a939 ("x86/kvm: Implement HWCR support")
> introduced support for emulating HWCR MSR.
> 
> Add support for QEMU to save/load this MSR for migration purposes.
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>  target/i386/cpu.c     |  1 +
>  target/i386/cpu.h     |  5 +++++
>  target/i386/kvm/kvm.c | 12 ++++++++++++
>  target/i386/machine.c | 20 ++++++++++++++++++++
>  4 files changed, 38 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..339131a39a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7093,6 +7093,7 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>      env->a20_mask = ~0x0;
>      env->smbase = 0x30000;
>      env->msr_smi_count = 0;
> +    env->hwcr = 0;

Why we need to clear it here? This needs to be explained in the commit
message.

>      env->idt.limit = 0xffff;
>      env->gdt.limit = 0xffff;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 14edd57a37..a19b1ceda4 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -539,6 +539,8 @@ typedef enum X86Seg {
>  
>  #define MSR_AMD64_TSC_RATIO_DEFAULT     0x100000000ULL
>  
> +#define MSR_K7_HWCR                     0xc0010015
> +
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
>  #define MSR_IA32_XFD                    0x000001c4
> @@ -1859,6 +1861,9 @@ typedef struct CPUArchState {
>      uint64_t msr_lbr_depth;
>      LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
>  
> +    /* Hardware Configuration MSR */

We can keep the same comment as msr_hwcr in KVM to emphasize this is an
AMD-specific MSR, i.e.,

/* AMD MSRC001_0015 Hardware Configuration */

> +    uint64_t hwcr;

Add the msr_ prefix to indicate that this value is only intended to
store the MSR. Currently, for similar members, some have the msr_ prefix
and some do not, but it is better to have it for clarity.

> +
>      /* exception/interrupt handling */
>      int error_code;
>      int exception_is_int;

-Zhao


