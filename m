Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7517FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVLf-0008At-U7; Thu, 30 Oct 2025 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEVLc-0008A2-9h
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:18:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEVLU-0007mg-KP
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761841073; x=1793377073;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=auefPtati7woFejgoYeBYbRyUtIZoiPQxj0zexbepbI=;
 b=eOjjmIO56t8f1ycT6ORgu9w7+8bvqT0fvqEEhGQdczNweSDGrXrTSdpX
 7uPYrub6KRZoXazB4uOcPoLALPi+0FPfJwZATzYY2Wz3yHV++y4wePIja
 dw7dhpBg7rjBRPyemOe7vdozMR/074TYqKzrI+6q/8N5iN77S6JVZHXYL
 f/0IIvj9f1h47R+FQSBJfgn3PGHMgDRM81lEJMvXP69kRz2cTy2TbxXSl
 quBuHATOgBRLvgpUs2NesCM7RneXhltsUMel3bELkFIYLrd92aVsHh9Rw
 wMjMyq5SkpONraS5jXsMaBWacgxJ4j6DK69b5NDawhtDJ6tFXfkwCsk/w A==;
X-CSE-ConnectionGUID: 76tsrKooR/aPAdEtLYdOiQ==
X-CSE-MsgGUID: cMs5DbQzShmm4NBdMTy3XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64139286"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="64139286"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 09:17:43 -0700
X-CSE-ConnectionGUID: OkNRYvrMSTOBfjcMIEUxlw==
X-CSE-MsgGUID: mFXhO+JLRLauSgZJr98RhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="185932717"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 30 Oct 2025 09:17:40 -0700
Date: Fri, 31 Oct 2025 00:39:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chao Gao <chao.gao@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: Re: [PATCH v3 11/20] i386/cpu: Enable xsave support for CET states
Message-ID: <aQOU1/kR7w7U2NxD@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-12-zhao1.liu@intel.com>
 <aQGe66NsIm7AglKb@intel.com>
 <4806bc74-e4c2-4aa1-b003-e72895a11f11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4806bc74-e4c2-4aa1-b003-e72895a11f11@intel.com>
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

> > It just occurred to me that KVM_GET/SET_XSAVE don't save/restore supervisor
> > states. Supervisor states need to be saved/restored via MSR APIs. So, there
> > is no need to add supervisor states (including ARCH_LBR states) to
> > x86_ext_save_areas[].
> 
> x86_ext_save_areas[] is not used only for xsave state, it's also used for
> the setup of xsave features, i.e., CPUID leaf 0xD.

Yes. And it can also maintain dependencies.

> And you did catch the missing part of this series, it lacks the save/restore
> of CET XSAVE state in x86_cpu_xsave_all_areas()/x86_cpu_xrstor_all_areas()

Not a missing part. CET's xstates contain CET related MSRs and actually
is saved/restored via MSR ioctls, not KVM_GET/SET_XSAVE.

Regards,
Zhao


