Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B5C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8DlP-0005QC-SC; Fri, 25 Apr 2025 03:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8DlN-0005PG-DD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:46:22 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8DlK-0004YZ-19
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745567178; x=1777103178;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4mZRmJVx+XVyCH/bdyS3TfV2zCh3V/UMRqrDdsKYcnc=;
 b=ho08yuimG6DC7Kc6eUGQL6yN9TMGx0/PehdXah1SffDzpsGq8QaNZCHs
 6M9XuALxNNX/ay7LwMODShIuHrpv2VKSqEvAZQG9CPFvi8gJeVSCCF72+
 HR/hbwiayreIB6dONPs7yCujMyF3IG3PxmSLvYU4Pa5wE7XVaZUconI7D
 ea8So9mprTb1JVsGGxkwmPwWVJ+C+zBIZCvdYRcB93cQZHc+KJOyvPBmB
 XotUn++6uzEjLjyHKFlZN4o9jLzgzhE/ImElJIJVvHdhcUBbbS1fqi9Ub
 Go0aVQRNs4cv/MrYJNb+OROAa0o68rt8XDNNlIOLKvyoGwOWCxPhLd3a+ w==;
X-CSE-ConnectionGUID: k2LBF18zT4mYm0JWCZs3NQ==
X-CSE-MsgGUID: L9nWJkX7Q/WIOj/gQGkScQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47133260"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47133260"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2025 00:46:14 -0700
X-CSE-ConnectionGUID: a/Ely33TRu6tK+A1D1CKDQ==
X-CSE-MsgGUID: JoPRMRv0SXWC7OiW+Ypvjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="132829709"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Apr 2025 00:46:12 -0700
Date: Fri, 25 Apr 2025 16:07:08 +0800
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
Subject: Re: [PATCH v8 24/55] i386/tdx: Add TDVF memory via
 KVM_TDX_INIT_MEM_REGION
Message-ID: <aAtCrMkLX4MaTDUS@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-25-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-25-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, Apr 01, 2025 at 09:01:34AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:34 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 24/55] i386/tdx: Add TDVF memory via
>  KVM_TDX_INIT_MEM_REGION
> X-Mailer: git-send-email 2.34.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDVF firmware (CODE and VARS) needs to be copied to TD's private
> memory via KVM_TDX_INIT_MEM_REGION, as well as TD HOB and TEMP memory.
> 
> If the TDVF section has TDVF_SECTION_ATTRIBUTES_MR_EXTEND set in the
> flag, calling KVM_TDX_EXTEND_MEMORY to extend the measurement.
> 
> After populating the TDVF memory, the original image located in shared
> ramblock can be discarded.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v6:
>  - switch back to use KVM_TDX_INIT_MEM_REGION according to KVM's change;
> ---
>  target/i386/kvm/tdx.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


