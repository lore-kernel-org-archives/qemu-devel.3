Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E4CC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QUZ-0002jl-0G; Mon, 28 Apr 2025 11:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9QUV-0002ja-SD
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:33:55 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9QUT-0001tL-5h
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745854433; x=1777390433;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wswP+HA8KTMZdO/SBHYyhfxZ5GAUgt+9rWEblXdkppg=;
 b=KazGbNFz3QQnwoYFueeg7b1e7KGqfNMgXzKyKJ48+GGHuAkQIWk05oZp
 VXkZ2esbqmjcK/Dn43eWagAT/8ZpObSnuPUk6sTdhsZvjakpYCB26XZbi
 m/Ot5eTMmYw+HGXZbgrclOpzPpKMo242mtAn11vXcYc6lC120fYPbezi1
 JHpM8cQRr0il/++gSpQ6VBBv8jYvR790PrF0CpZcfaheldZYvDqSEDnzW
 Ng4ffXQy1FpN0yBOxtCB2PsHZHD3ndIhCphCA0AOFPUCYRKNFygXkPuxO
 0aO8bHFVQimgFRNdjcLm2zylKRdi7fE44y5H+jSEBa7FLFH/dr+z+mFnJ A==;
X-CSE-ConnectionGUID: lN5Fr6n7TvaMJBP9Y8l9YQ==
X-CSE-MsgGUID: uUr/6XfcQQq/FfnQOAUeSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47329339"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="47329339"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:33:49 -0700
X-CSE-ConnectionGUID: rg+VIkAyS1O1SgvfXRzthA==
X-CSE-MsgGUID: haNYjhnLSrW5zz5swibuiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="138647064"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 28 Apr 2025 08:33:47 -0700
Date: Mon, 28 Apr 2025 23:54:44 +0800
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
Subject: Re: [PATCH v8 30/55] kvm: Check KVM_CAP_MAX_VCPUS at vm level
Message-ID: <aA+kxC91ySHSSORt@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-31-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-31-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:40AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:40 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 30/55] kvm: Check KVM_CAP_MAX_VCPUS at vm level
> X-Mailer: git-send-email 2.34.1
> 
> KVM with TDX support starts to report different KVM_CAP_MAX_VCPUS per
> different VM types. So switch to check the KVM_CAP_MAX_VCPUS at vm level.
> 
> KVM still returns the global KVM_CAP_MAX_VCPUS when the KVM is old that
> doesn't report different value at vm level.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


