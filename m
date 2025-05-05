Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0CCC3ABB8
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBx9s-0002kX-4G; Mon, 05 May 2025 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBx9p-0002k2-G0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:51:02 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBx9n-0005Gr-9i
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746456659; x=1777992659;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UpQhLtyKILoGDwAGkNb0qEyJDlTnIuNmPqIzOfU81FE=;
 b=Vutts8VnosoP+sYzST1Cuwq8F+YAXBMwI9wMlnZ6jp9clCVHo4ArUu2i
 loWLl8oqMYRpP3FXZzO/HXoVnXXiG13xgvPG1Vs29QBMJ6Wp/3ig4aNhv
 H3TyH36xxT3HVGEYePotw5Urramk1KZ7H1yiEt8cvOQpXV2oif5feDOR7
 PF5iTz5lVzn74bqjNVzzMpV2+EtNhgg/mLTa4/mInq3Ns/Lrh1/YE5QvX
 dliax4TDekqmzIGIND0xbbz27UZLh1Bu5FKqOVFcNUg2NDhm/VZUwC521
 ANEae+/BLS94fT05Xwxyi4NA97dyyXwHEQ3GR9OuTtKpdNhzoyBuxA/Wf A==;
X-CSE-ConnectionGUID: hA+PbBttTROLNYMhCexw0g==
X-CSE-MsgGUID: otHWmhBrQ2uzFiuGNz4WUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="35688152"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="35688152"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2025 07:50:56 -0700
X-CSE-ConnectionGUID: tGu0cY40RQ2vtlq2N4a96w==
X-CSE-MsgGUID: Wjyvn+yuRIOW5zyLsRdyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="135011432"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 05 May 2025 07:50:54 -0700
Date: Mon, 5 May 2025 23:11:54 +0800
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
Subject: Re: [PATCH v8 50/55] i386/cgs: Introduce
 x86_confidential_guest_check_features()
Message-ID: <aBjVOqNbBCcCnTwy@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-51-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-51-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, Apr 01, 2025 at 09:02:00AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:02:00 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 50/55] i386/cgs: Introduce
>  x86_confidential_guest_check_features()
> X-Mailer: git-send-email 2.34.1
> 
> To do cgs specific feature checking. Note the feature checking in
> x86_cpu_filter_features() is valid for non-cgs VMs. For cgs VMs like
> TDX, what features can be supported has more restrictions.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/confidential-guest.h | 13 +++++++++++++
>  target/i386/kvm/kvm.c            |  8 ++++++++
>  2 files changed, 21 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


