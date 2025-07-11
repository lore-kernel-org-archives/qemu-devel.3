Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E9FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6bM-0004l1-KC; Fri, 11 Jul 2025 01:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua6bD-0004dJ-Vl
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:47:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua6b8-0001Nx-JH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752212823; x=1783748823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XTfMWWxfBoVL7TGsRDBfdi697a8eROg4D315DGUogFU=;
 b=Ejg54iCLFZ8FSTWyRq0amO4e+m1QuY3REZzqIK5MDZhfA6SI9foLiNGd
 8NN7A4tejXWeYQOOYfpcFXx8Pckv9wLyoMn2VAdS335ScGyFXtKW/Iiux
 rEQeBNTHkJNrnVfwcVJpcsoyECRKfDpNv38Ch2dNMsL5XE7SLHc2KmNox
 IgoBTnuzwcIskn4/Jd8apKhvUBGQ3cvSy3CLip+W76MC++Vm/yAleh+xX
 COZoKwkPWZez4sI2mUCeJo80h9KAGFbjuzQujZKOJgKxIZi5s+wyCXkfA
 2K0ti3Q6xr7+xaaIWUUD2kTfZvnCd6UyNwYCb/I+kAFujsYvsXkzl/i9d Q==;
X-CSE-ConnectionGUID: SeZcKT/uTjibN4CZTEq44g==
X-CSE-MsgGUID: VwKG+TXjRzGoG1rdh8cMWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54222488"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="54222488"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 22:47:00 -0700
X-CSE-ConnectionGUID: t2EJHNAXRkaXJ5f/jG8VBQ==
X-CSE-MsgGUID: taI+nktERLmp2bPmzlzT2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="156627222"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2025 22:46:58 -0700
Date: Fri, 11 Jul 2025 14:08:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: Re: [PATCH 3/4] target/i386: allow reordering max_x86_cpu_initfn vs
 accel CPU init
Message-ID: <aHCqW7GkeUy6le4E@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711000603.438312-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jul 11, 2025 at 02:06:02AM +0200, Paolo Bonzini wrote:
> Date: Fri, 11 Jul 2025 02:06:02 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/4] target/i386: allow reordering max_x86_cpu_initfn vs
>  accel CPU init
> X-Mailer: git-send-email 2.50.0
> 
> The PMU feature is only supported by KVM, so move it there.  And since
> all accelerators other than TCG overwrite the vendor, set it in
> max_x86_cpu_initfn only if it has not been initialized by the
> superclass.  This makes it possible to run max_x86_cpu_initfn
> after accelerator init.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c         | 24 ++++++++++++------------
>  target/i386/kvm/kvm-cpu.c |  2 ++
>  2 files changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


