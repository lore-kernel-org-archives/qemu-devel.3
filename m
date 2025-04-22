Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B415C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ELD-00050u-To; Tue, 22 Apr 2025 10:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7EL8-0004zl-Ql
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:11:11 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7EL3-0008Db-R8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745331066; x=1776867066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Z9I8Tb6EoTQe5Dpwqkac3DXSUJWOdRq+ia/FgGC6D3k=;
 b=hqdW3DaPdJ/LU02/unKZACYLSR1joyffaD7KKEo8VKI7GiRnqAfp+Fyo
 +xS6/2xPqgRrp7uRPMFPOryiJTtHYpMqb8nj39XQfjQQSyKyedSlZ2FQv
 6Oc3WwD1LKma7bWSdfYsPx1PUo7s32OEqAf089XS/Rtk30LKphtypAT6U
 068+kZiYyx/tVAvWr9KEn+4EPvWlfUkUXYbgWi22E4Zg2gb6i/OKKTmzP
 IsbvulHULxdT+IRxyJGdahu4a8yV246ZjouTgYRUKdkWf9xfQ6rlw8+E0
 iCtt4SRrbabAZTzxVfq1yV7ylhwd/VxE+g3P3XawOt/scLjTF++k70+ps g==;
X-CSE-ConnectionGUID: Mqh00Mo1TGm5H7hOE+tMaA==
X-CSE-MsgGUID: lGOS09sGSa+eagmOtqASJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46126506"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46126506"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:11:03 -0700
X-CSE-ConnectionGUID: m1uAtiXeRYK9V5sfb54oOQ==
X-CSE-MsgGUID: cI8+0JS4Q1K9pds6/PZuyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="136105556"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2025 07:11:01 -0700
Date: Tue, 22 Apr 2025 22:31:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 07/55] kvm: Introduce kvm_arch_pre_create_vcpu()
Message-ID: <aAeoW9/sAGcr8ygN@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-8-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-8-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 01, 2025 at 09:01:17AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:17 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 07/55] kvm: Introduce kvm_arch_pre_create_vcpu()
> X-Mailer: git-send-email 2.34.1
> 
> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
> work prior to create any vcpu. This is for i386 TDX because it needs
> call TDX_INIT_VM before creating any vcpu.
> 
> The specific implemnet of i386 will be added in the future patch.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v7:
> - Implement stub for all the ARCHes instead of defining it with weak
>   attribute; (Philippe)
> 
> Changes in v3:
> - pass @errp to kvm_arch_pre_create_vcpu(); (Per Daniel)
> ---
>  accel/kvm/kvm-all.c        | 5 +++++
>  include/system/kvm.h       | 1 +
>  target/arm/kvm.c           | 5 +++++
>  target/i386/kvm/kvm.c      | 5 +++++
>  target/loongarch/kvm/kvm.c | 4 ++++
>  target/mips/kvm.c          | 5 +++++
>  target/ppc/kvm.c           | 5 +++++
>  target/riscv/kvm/kvm-cpu.c | 5 +++++
>  target/s390x/kvm/kvm.c     | 5 +++++
>  9 files changed, 40 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


