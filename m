Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2D7C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hl1-00051v-8S; Tue, 29 Apr 2025 06:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hl0-00051Y-27
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:00:06 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hkx-0002Ng-KV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920804; x=1777456804;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sMsJ5qHPHTmJfzHu/ec0CYmK0AWN9SeIEx/Gc3iUK88=;
 b=VKDvOUGlAKSn5xGY+gujtgK+DfCzcH4SiYZtOq1DSOeviSgdO08BWa1a
 mwMqKyXzH/QOFkF2WTrlEA3LMHlLzWhLTitHYOngFlYSjvKOwBZir7VDh
 u16nAiTNOWyJE/845CZHB1T89YvWTjVjskAX9X09Wncfwz5+bJKHAVUSa
 kuwwE90HqTySq7JtLUlN3dfly9lace09nf7F+O2GSume2V7hTACSIPThr
 n98bodUowKOWXL2Zh7whGC0/MmKY4BFkqFDuFE1VMcL/kpO1lmjx4hHN7
 +JM9LfHPoNRf7jwamPIOAz3TzymRRjIhFel1t4Kws+uhR2VR9CtmEX6db A==;
X-CSE-ConnectionGUID: NGAMsXHWSYyd9jHzFBPYaQ==
X-CSE-MsgGUID: 2y3drpQOTsWRAhgoD+tHzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58521844"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58521844"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 03:00:02 -0700
X-CSE-ConnectionGUID: q5SY9WLSQQOoQ43/tbBFPA==
X-CSE-MsgGUID: CyHCJLDNRSmwVfhjgrpn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="138575115"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 29 Apr 2025 02:59:59 -0700
Date: Tue, 29 Apr 2025 18:20:56 +0800
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
Subject: Re: [PATCH v8 40/55] i386/tdx: Only configure MSR_IA32_UCODE_REV in
 kvm_init_msrs() for TDs
Message-ID: <aBCoCL3zj3E+mYKp@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-41-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-41-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:50AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:50 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 40/55] i386/tdx: Only configure MSR_IA32_UCODE_REV in
>  kvm_init_msrs() for TDs
> X-Mailer: git-send-email 2.34.1
> 
> For TDs, only MSR_IA32_UCODE_REV in kvm_init_msrs() can be configured
> by VMM, while the features enumerated/controlled by other MSRs except
> MSR_IA32_UCODE_REV in kvm_init_msrs() are not under control of VMM.
> 
> Only configure MSR_IA32_UCODE_REV for TDs.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 44 ++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


