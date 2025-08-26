Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9F1CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquR7-00082A-Cu; Tue, 26 Aug 2025 10:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uquR1-0007v2-AY
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:14:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uquQp-0008Ml-TE
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756217632; x=1787753632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XUMwyANYoN9LqU5IRvdqCPCHLe1EThn+0cki44O6i8E=;
 b=UsdWwWcYRRW0UEUe+vyOlcXtScBSa/CzFZrLlfio3bhTqo+Z8TQyvI1y
 iSpc17FCufmUMC1KvmOU+2IfcrEyUEZR38fvBUfSPdzhJRExvr5VloaEt
 MWWI6Br2OaPdqNw46feY7ouq9w5mQc1t2P17YhoSzHHZs8cg4n/XN1rE0
 5mRUMxeYLq90fyOVIGKziIpGrvxpKUGHMvLpm+//5TXJs5Tm6HkcPUPDP
 kRKI0wEsAWz1MD0/CVJwlq5/J44KQgjB+anPlVPiVK7BpXiYeqTvESsPa
 b7AZCvy7KXQmZTojA80lSEBx8WqjwI/nREgwWTV9r9xZdMzaUYBHu9rNg A==;
X-CSE-ConnectionGUID: cP4sDZiHQyOUdzcb0YOQbA==
X-CSE-MsgGUID: b4RsOR8cSU+puMVO4oUKSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="68725307"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="68725307"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 07:13:18 -0700
X-CSE-ConnectionGUID: fkmkoWmdQxWzwXBvKrPNZw==
X-CSE-MsgGUID: TdnUtjC3Qo2ip6ZvO42CCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173753410"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 07:13:16 -0700
Date: Tue, 26 Aug 2025 22:35:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
Message-ID: <aK3GFpAxCuTWfjEn@intel.com>
References: <20250815065445.8978-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815065445.8978-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 15, 2025 at 12:24:45PM +0530, Ani Sinha wrote:
> Date: Fri, 15 Aug 2025 12:24:45 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
>  kvm-all.c
> X-Mailer: git-send-email 2.50.1
> 
> kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Declare it
> static, remove it from common header file and make it local to kvm-all.c
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c  |  4 ++--
>  include/system/kvm.h | 17 -----------------
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> changelog:
> unexport  kvm_unpark_vcpu() as well and remove unnecessary forward
> declarations.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


