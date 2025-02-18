Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA40EC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 01:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkCSG-0006oA-MG; Mon, 17 Feb 2025 20:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tkCS6-0006nY-3X; Mon, 17 Feb 2025 20:31:11 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tkCRz-0007sI-PN; Mon, 17 Feb 2025 20:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739842264; x=1771378264;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D3nt0FvopqfK1AIdRkjzth47H089lFwJTkPvYnO/q0c=;
 b=fmW1E+raSVxzyKcTSfsWUDZLqHU63CJHS3vo+QnFrrPDV7BHkvt33Enz
 aC52Dj3Je9MZjZhT9rwAMnMiGhNokX08aWGIKsA/R7XKNz4xQ2RbNdla8
 UwH0MvCKSjSiXsH9uIM8A+tNPhX3SphTO6gqiGcJAmhSc1s+qastMy115
 1KYFyTECTFRj8OHRm+ek2LH9ATGGDLFtuZ+yN8chvEjLTkx2V5lIKaGKV
 HSjPAvaXtuW50HMYg6ZJGTGKh/1CO5bZilnySp+BK7Iwo1HlBYM1Jv8h+
 W/kijqeJhnhEoECJlg/0S7S4je0dUuwaBJgGBVzdZ/BnmHmoC7s3ce18h Q==;
X-CSE-ConnectionGUID: lclTVrbfTn2WFcuKnH736A==
X-CSE-MsgGUID: cspi2CjBQpWdp7lqmgZq+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51931922"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="51931922"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 17:30:58 -0800
X-CSE-ConnectionGUID: DJMF4BZxRnyTeBFR4y9inw==
X-CSE-MsgGUID: QJg3CKcGRhyRSWkPhREpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118384471"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 17:30:56 -0800
Message-ID: <be7be014-8652-4a3c-8a5b-a851d5bf4958@intel.com>
Date: Tue, 18 Feb 2025 09:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace assertion with error
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/17/2025 8:08 PM, Paolo Bonzini wrote:
> It is possible to start QEMU with a confidential-guest-support object
> even in TCG mode.  While there is already a check in qemu_machine_creation_done:
> 
>      if (machine->cgs && !machine->cgs->ready) {
>          error_setg(errp, "accelerator does not support confidential guest %s",
>                     object_get_typename(OBJECT(machine->cgs)));
>          exit(1);
>      }
> 
> the creation of RAMBlocks happens earlier, in qemu_init_board(), if
> the command line does not override the default memory backend with
> -M memdev.  Then the RAMBlock will try to use guest_memfd (because
> machine_require_guest_memfd correctly returns true; at least correctly
> according to the current implementation) and trigger the assertion
> failure for kvm_enabled().  This happend with a command line as
> simple as the following:
> 
>      qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
>         -M q35,kernel-irqchip=split,confidential-guest-support=sev0
>      qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   system/physmem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9daad..1ddf9fb10d0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       if (new_block->flags & RAM_GUEST_MEMFD) {
>           int ret;
>   
> -        assert(kvm_enabled());
> +        if (!kvm_enabled()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }
>           assert(new_block->guest_memfd < 0);
>   
>           ret = ram_block_discard_require(true);


