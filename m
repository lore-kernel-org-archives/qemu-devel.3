Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6bx-0000g2-Cv; Tue, 25 Jun 2024 09:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM6bv-0000fn-Sg
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:53:27 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sM6bs-00085b-Mo
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719323605; x=1750859605;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VDqj8FLLXt2GlyHOeiwwgvCcHIxT7PLjCZ1Sav3JPg4=;
 b=ACOlRgsdXmeJ/JP9b3X6ZZyykynpWxFZroQVGEAgFz19CfUu3f8N7vgC
 XCGff00fQF++4oRUpkS1rqeC3aaFH4DPjiPUTAml6bjSbQz+IZf6PiDJ0
 ojL/7sqH4pMHCbnBKE3d5vNh8aOfYGxYPusi/hQl5IQuZTZgvu9yvgYhF
 10qJMslDsNLZep2r8IxNTr1Br5scNtqiMyEPoH0kI1k1pPkJN4HouDglN
 4fr0QT9+hMp9lW55lNXNZ/1F7ejjGBZgwZU2KqwbavGCxx2015tK7+9DQ
 6v06zY87MH0wORlh14paCM4v+NiaxtiMOnXyJfdwpz2ArEvfs66J9NQZC g==;
X-CSE-ConnectionGUID: PU10bj/mQDqTENPDpUPnNw==
X-CSE-MsgGUID: N+deJ68DQzKR/EsMxIRNRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20119523"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="20119523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 06:53:22 -0700
X-CSE-ConnectionGUID: JQb3GVzcQ+6FV7eH1DDqzg==
X-CSE-MsgGUID: Gt67F+chRiWxW5GuUeWN4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; d="scan'208";a="43539764"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 25 Jun 2024 06:53:19 -0700
Date: Tue, 25 Jun 2024 22:08:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH v3] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Message-ID: <ZnrPdZdgcBSY1sMi@intel.com>
References: <20240624095806.214525-1-ewanhai-oc@zhaoxin.com>
 <ZnqSj4PGrUeZ7OT1@intel.com>
 <53119b66-3528-41d6-ac44-df166699500a@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53119b66-3528-41d6-ac44-df166699500a@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

[snip]

> > Additionally, has_msr_vmx_vmfunc has the similar compat issue. I think
> > it deserves a fix, too.
> > 
> > -Zhao
> Thanks for your reply. In fact, I've tried to process has_msr_vmx_vmfunc in
> the same
> way as has_msr_vmx_procbased_ctls in this patch, but when I tested on Linux
> kernel
> 4.19.67, I encountered an "error: failed to set MSR 0x491 to 0x***".
> 
> This issue is due to Linux kernel commit 27c42a1bb ("KVM: nVMX: Enable
> VMFUNC
> for the L1 hypervisor", 2017-08-03) exposing VMFUNC to the QEMU guest
> without
> corresponding VMFUNC MSR modification code, leading to an error when QEMU
> attempts
> to set the VMFUNC MSR. This bug affects kernels from 4.14 to 5.2, with a fix
> introduced
> in 5.3 by Paolo (e8a70bd4e "KVM: nVMX: allow setting the VMFUNC controls
> MSR", 2019-07-02).

It looks like this fix was not ported to the 4.19 stable kernel.

> So the fix for has_msr_vmx_vmfunc is clearly different from
> has_msr_vmx_procbased_ctls2.
> However, due to the different kernel support situations, I have not yet come
> up with a suitable
> way to handle the compatibility of has_msr_vmx_procbased_ctls2 across
> different kernel versions.
> 
> Therefore, should we consider only fixing has_msr_vmx_procbased_ctls2 this
> time and addressing
> has_msr_vmx_vmfunc in a future patch when the timing is more appropriate?
> 

I agree this fix should focus on MSR_IA32_VMX_PROCBASED_CTLS2.

But I think at least we need a comment (maybe a TODO) to note the case of
has_msr_vmx_vmfunc in a followup patch.

Let's wait and see what Paolo will say.

-Zhao

