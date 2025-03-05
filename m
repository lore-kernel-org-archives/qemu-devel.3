Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9ACC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpphl-0006Ry-NG; Wed, 05 Mar 2025 09:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpphk-0006Qh-0Y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:26:36 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpphi-0006Jk-7U
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741184794; x=1772720794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BVqqC4oAStGeOipkGPpjlWcVg3qYzVoBzqOa6HasjaM=;
 b=dTubrwu0xWC7OWTf7681dwdt3N0XQrSZeZgo0ClEW8Mz0DJ2SOEsv5cc
 pZkXsZTDnbVG6VjPhjOtT9H/Gq49z2Fs0/lp2MmDMDlYkNtYmfop7hKiB
 A8yFIV5XvLKQCn9rKQ77KlBMBbOkGcrmCvgraVQB8e0tYpCndZrMSlmsv
 pVkbdOIzrx7gvS0Wz1IiWxLtuqfIvMiENFewHHnY5pMft0YPGn3i3Y0D7
 LX4gVO4601c+EOL69UbR13P7NCuIjbJurvkQa2kY+OVFwWp8tWHaKSbGq
 /qef++CyFDb9YVmoi9LhtEWDAw7Hj+4mA5t+8z58KOYY3uSPBV8RGx1u1 A==;
X-CSE-ConnectionGUID: RmgL9yDySJGPgEm+busHMg==
X-CSE-MsgGUID: UyQqLHPCR9ObW6fTxRRwxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42277571"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="42277571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 06:26:32 -0800
X-CSE-ConnectionGUID: hqljol+XQH62Na0I4uq5aw==
X-CSE-MsgGUID: IBDtrwGBQb27aA9PkdRS0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="119396142"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 05 Mar 2025 06:26:28 -0800
Date: Wed, 5 Mar 2025 22:46:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 03/10] [DO NOT MERGE] kvm: Introduce
 kvm_arch_pre_create_vcpu()
Message-ID: <Z8hjy/8OBTXEA1kp@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-4-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-4-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Sun, Mar 02, 2025 at 02:00:11PM -0800, Dongli Zhang wrote:
> Date: Sun,  2 Mar 2025 14:00:11 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v2 03/10] [DO NOT MERGE] kvm: Introduce
>  kvm_arch_pre_create_vcpu()
> X-Mailer: git-send-email 2.43.5
> 
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
> work prior to create any vcpu. This is for i386 TDX because it needs
> call TDX_INIT_VM before creating any vcpu.
> 
> The specific implemnet of i386 will be added in the future patch.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Your Signed-off is missing...

(When you send the patch, it's better to attach your own Signed-off :-))

> ---
> I used to send a version:
> https://lore.kernel.org/all/20221119122901.2469-2-dongli.zhang@oracle.com/
> Just pick the one from Xiaoyao's patchset as Dapeng may use this version
> as well.
> https://lore.kernel.org/all/20250124132048.3229049-8-xiaoyao.li@intel.com/
> 
>  accel/kvm/kvm-all.c        | 5 +++++
>  include/system/kvm.h       | 1 +
>  target/arm/kvm.c           | 5 +++++
>  target/i386/kvm/kvm.c      | 5 +++++
>  target/loongarch/kvm/kvm.c | 5 +++++
>  target/mips/kvm.c          | 5 +++++
>  target/ppc/kvm.c           | 5 +++++
>  target/riscv/kvm/kvm-cpu.c | 5 +++++
>  target/s390x/kvm/kvm.c     | 5 +++++
>  9 files changed, 41 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


