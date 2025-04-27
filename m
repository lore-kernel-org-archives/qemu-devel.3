Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3FDC369D8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 08:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8xez-0008A3-HY; Sun, 27 Apr 2025 04:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8xex-00089n-EK
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 04:46:47 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8xev-0000fz-PB
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 04:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745743606; x=1777279606;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/GTyDHMle3ldZMARhT3TCRkxS223RtuLA6EgdyJ3gxc=;
 b=kKT3rQ5QYEvgMwGhbmhfQ3ZPomkN119uHilSjvdL0cf38gKGd6Lu0j3f
 NM8WZwFfzrJtanDQngXBg6QzMbGQ77Y1Y0NiEeuiNtKhmRJcJJtI/BrMf
 /re/jzEGrnBb7F8L6FxA4zKDXYiw0xpLEEiOt7QpZOlBf3/xdQe4XbWUM
 ofA4ZRO067hS0HdGF5bvIF2sUDe7i1qj4w1qMsjtfktZnU19IQB6l4vrM
 hFcxhQ82nEdw/yXPnHsF+Gy83nT1lDcwnv2l3UH7nNYziqieExNusGU7P
 uDIAjbsLcoGy5JkAIwZ3dekTMJp5hX/xdiJoTQrRTRx10bggRnV7oNk4m g==;
X-CSE-ConnectionGUID: vcbFW9xlSz2fD5MsagmAcQ==
X-CSE-MsgGUID: oo+nfG65TaOef3XUazzTbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="58718488"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="58718488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 01:46:44 -0700
X-CSE-ConnectionGUID: YRqdoL6KTSuXeJYfUSnNBA==
X-CSE-MsgGUID: FfiRPcN2Q0SwK2mEVxa2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="138415772"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 27 Apr 2025 01:46:42 -0700
Date: Sun, 27 Apr 2025 17:07:38 +0800
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
Subject: Re: [PATCH v8 27/55] i386/tdx: Enable user exit on
 KVM_HC_MAP_GPA_RANGE
Message-ID: <aA3z2hyxuGzbV2nV@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-28-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-28-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
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

On Tue, Apr 01, 2025 at 09:01:37AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:37 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 27/55] i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
> X-Mailer: git-send-email 2.34.1
> 
> KVM translates TDG.VP.VMCALL<MapGPA> to KVM_HC_MAP_GPA_RANGE, and QEMU
> needs to enable user exit on KVM_HC_MAP_GPA_RANGE in order to handle the
> memory conversion requested by TD guest.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v6:
>  - new patch;
> ---
>  target/i386/kvm/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


