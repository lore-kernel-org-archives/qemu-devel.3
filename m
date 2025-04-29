Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14AEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hfn-0000yF-2U; Tue, 29 Apr 2025 05:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hfl-0000y4-6g
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:54:41 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hfj-0001eo-9S
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745920480; x=1777456480;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jBZBe/F/2cyGm9mgTgzqjef8Vum0lh7AQsSW7Ul0Ev0=;
 b=hEiuw42T7mFxN751FQ9g/lS2AWcioSV/8/6/kSwTTUm8srLIdbS0b/Uy
 JRQn5Je4+fLF9CQC/12UeUv9hE0gTsKL75gu71KS5mgqNSYRuK5030OHn
 VzsvjWb9meqqGd2N06thehpI2ALUc4aouB32eJTxvRsLzb7a7WAECXgfm
 Ww7ILXQtXANFGpfXjizlGCuzhPAMy/UGf28jjAhmRb2JqhKvNddWWM9mZ
 lyVCDcvgM99iB+muX/QghZxUZ04yFS1lQfUPRyCJcxS8k3056iEKzUAvZ
 nJI2AHgFY0ebRsL6OrjjI2JSAMhn3kv8YYQipdRCazzQWhuPJ89/AW6ld Q==;
X-CSE-ConnectionGUID: XiTPCarKTQWxZo7a8n9PTw==
X-CSE-MsgGUID: UWsguhJ8S8iAabd+XIJtgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47623590"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="47623590"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:54:37 -0700
X-CSE-ConnectionGUID: +C/DcRuPS0WHAN4Y6o7qrw==
X-CSE-MsgGUID: X9rkAW0MTDCwLpFfHZRbQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="134287234"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2025 02:54:33 -0700
Date: Tue, 29 Apr 2025 18:15:31 +0800
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
Subject: Re: [PATCH v8 36/55] i386/tdx: Disable SMM for TDX VMs
Message-ID: <aBCmw9JkpRkXXuBs@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-37-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-37-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:46AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:46 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 36/55] i386/tdx: Disable SMM for TDX VMs
> X-Mailer: git-send-email 2.34.1
> 
> TDX doesn't support SMM and VMM cannot emulate SMM for TDX VMs because
> VMM cannot manipulate TDX VM's memory.
> 
> Disable SMM for TDX VMs and error out if user requests to enable SMM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/tdx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


