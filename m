Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DF3C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rQV-0006ou-6l; Thu, 24 Apr 2025 03:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rQR-0006mx-MH
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:55:15 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7rQQ-00079w-1r
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745481314; x=1777017314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ChiWCOWFQYT90EDrHxtI3Sk73YKHofiCkjzg2l9zeWY=;
 b=NFL0Vj2hBS3n2BLhKPebpQ0S2ANson5k2yu/72FUT+rEkFN3wDp7HJOB
 QvUsDK9bKw/p4lARar4oXZsOgnLOscEEzpRz7hlR3cVKqh4mppKRK2mCk
 ZR8VYmUrCHjCRZ47eB3HW4jmsMlD4/ZveyVWOh7GcdxMXoNAGzYL3ouQb
 yAPTC/fU+51yr0mrdoZ/M+apyplW2X7rZRUdyhzBwrNEGbFq2RS9Km87m
 f0M1zmtwTWwUam/eQmqkwtENdQAEc5AUMinB7ohGC3Q7/MVkgFDsnOqoq
 yQpNzmiNfCrs6d6r2de7JW1WD+2oI94uFs+GCtYM8zFnz8eR0ev242eht Q==;
X-CSE-ConnectionGUID: ZDewpKpwTnqkWAjEUTP8Jw==
X-CSE-MsgGUID: akuGvf5wRIidrpNyz14EWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50761676"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="50761676"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 00:55:13 -0700
X-CSE-ConnectionGUID: KCQ2OuQ8Sl6PzTexsgnBlA==
X-CSE-MsgGUID: UEODE1gcQNyKGWAoRxn3gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="133510121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2025 00:55:09 -0700
Date: Thu, 24 Apr 2025 16:16:04 +0800
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
Subject: Re: [PATCH v8 18/55] i386/tdx: Parse TDVF metadata for TDX VM
Message-ID: <aAnzRDuk4gBgDFsf@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-19-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-19-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Tue, Apr 01, 2025 at 09:01:28AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:28 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 18/55] i386/tdx: Parse TDVF metadata for TDX VM
> X-Mailer: git-send-email 2.34.1
> 
> After TDVF is loaded to bios MemoryRegion, it needs parse TDVF metadata.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/pc_sysfw.c         | 7 +++++++
>  target/i386/kvm/tdx-stub.c | 5 +++++
>  target/i386/kvm/tdx.c      | 5 +++++
>  target/i386/kvm/tdx.h      | 3 +++
>  4 files changed, 20 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


