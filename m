Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ACCC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hj1-0003jp-Kl; Tue, 29 Apr 2025 05:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hiw-0003fr-RC
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:57:59 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hiv-000233-5t
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920678; x=1777456678;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nUvgRZr7PxeFiRuazO+SyoDLaFJgVgHxPZPIpSHsEF4=;
 b=izmf5sf7q+8mOXZB5J1QzICaQtepxrLQy07mwSNrLC7VS4xcfHvHQbNu
 S14+8bnsEX2CxTwPjwFnl0uqdW0+QK2FN43+2h7/U5zZtuEk9I4qhXNK/
 F4bU2IeCd4itvJCUptkiXN0RdvgJPhmo4+MFcxGmi/aEdtGLUOkpdX+wX
 D/KNG7ENRj749ISQahBTsYtX/n2g6UavawBg7HKNz9S6QYjkYilaJ7Djz
 Av8nhSDe9ILciiIXgjk10Vyu9kC5rm7+ForjAh3uBYvHUq+4tTgsCHi6H
 WPdQM5NP2z5qeNfMIDvZHhheBPlkT7HRv4Cb8TDAEux/nggDq5NaQi+GH g==;
X-CSE-ConnectionGUID: 6BIgnd4mSreibM4GQ0DeNg==
X-CSE-MsgGUID: l7AU8FXZTemu1+FHB9QN6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="70038053"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="70038053"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:57:55 -0700
X-CSE-ConnectionGUID: tSKQWvGzSnWs8YXULbuXsg==
X-CSE-MsgGUID: NuXCa5TkQfyHs9xcaAmIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="134284798"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 29 Apr 2025 02:57:53 -0700
Date: Tue, 29 Apr 2025 18:18:50 +0800
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
Subject: Re: [PATCH v8 39/55] i386/tdx: Don't synchronize guest tsc for TDs
Message-ID: <aBCnimklo0RI7Lbc@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-40-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-40-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:49AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:49 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 39/55] i386/tdx: Don't synchronize guest tsc for TDs
> X-Mailer: git-send-email 2.34.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TSC of TDs is not accessible and KVM doesn't allow access of
> MSR_IA32_TSC for TDs. To avoid the assert() in kvm_get_tsc, make
> kvm_synchronize_all_tsc() noop for TDs,
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Connor Kuehl <ckuehl@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


