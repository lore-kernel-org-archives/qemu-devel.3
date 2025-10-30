Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39412CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUQ7-0003bh-09; Thu, 30 Oct 2025 11:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUQ3-0003as-NN
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:18:31 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUPs-0005nT-BQ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761837501; x=1793373501;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VduxXOP15hvnXVLVHD1DZz+vUQBwNvjKz8GA04d6gnA=;
 b=ae5hFjKmXGG4s75teN+WXbBKSfOMP5N8aAvcTTPt7FeagFUHSFHSna6x
 jTKuuAZLKLx09Zzah39cWC4qo52lwaPw2pOjnZOQ4Cvm2ihz3S6ASUj/l
 we8qpA4YnWrAonDCxYszai+CemychsGZT9yqR0HchQ8oQuHl3hP4R7e3F
 34qyN1UP6lpZadDapw2r91V4bXWh1/4sZ4+MzoA7JO/2KpVFej1SQx+Ys
 DxQX+EuZV9aUMsHvO1lvZY2dQAC74AoRqR1oclD6BC1FJPkLD0G2aDy0o
 FKehLky+x65F/oZY2duvXBsjN/jR2dsxCHJ9Ckduf2eK80id/1nMVKKW6 A==;
X-CSE-ConnectionGUID: 2iuUkdYHQmm2/dlBGe6Mrw==
X-CSE-MsgGUID: 8VRvKYG6RJy4bzOLK7fgAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75432577"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="75432577"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:18:10 -0700
X-CSE-ConnectionGUID: BKpDafh+SFqWINZpG9uYXQ==
X-CSE-MsgGUID: fHZzOJB/SU2rlTrR2rLt/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="185862013"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2025 08:18:04 -0700
Date: Thu, 30 Oct 2025 23:40:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 07/20] i386/cpu: Reorganize dependency check for arch
 lbr state
Message-ID: <aQOG4O37f/hY9+iN@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-8-zhao1.liu@intel.com>
 <d34f682a-c6c0-4609-96e8-2a0b76585c7d@intel.com>
 <aP9FfUKoP2azthS8@intel.com>
 <b70c5b82-815b-4c4d-a1c6-f3f011d951f9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70c5b82-815b-4c4d-a1c6-f3f011d951f9@intel.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Before this patch, if pmu is enabled and ARCH_LBR is configured, the leaf
> (0xd, 0xf) is constructed by
> 
> 	x86_cpu_get_supported_cpuid()
> 
> after this patch, it's constructed to
> 
> 	*eax = esa->size;
> 	*ebx = 0;
>         *ecx = 1;

Ah, there should be another 2 cases which need refactor/cleanup:
 * fill all registers with info from x86_ext_save_areas
 * fill info of x86_ext_save_areas from x86_cpu_get_supported_cpuid()

Regards,
Zhao


