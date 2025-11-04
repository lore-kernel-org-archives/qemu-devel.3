Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF0CCFA0D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIru-0002rs-VO; Tue, 04 Nov 2025 10:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIrr-0002lB-Hi; Tue, 04 Nov 2025 10:22:44 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIro-00041Y-JS; Tue, 04 Nov 2025 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762269760; x=1793805760;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/BnBQU1LtkrdDTDb4VMuCD1GoL9kIYaFPhX1uKSNDG4=;
 b=gifhfElhyPdVlbH1kV3ap0wiurTI2tUrB8mz4Eob+saK5joWBEOjX8xe
 sffljIKEuQg8HrYGfNkfr9N6idbQBMwY93rM+ePuq6b3O7t3J+sEwKNGW
 AVJ4da525N02b+byj9owU5GFECq1oAil3euk6Nvp40kjjw4izEVWaJ1fo
 yBphZFMGr5xWOyZ7kEaDtSmB3UjUqStKuB6JFS8OSrgCTT6iPVNysqdOM
 7pLq5FmcRoB79ws5QLXMQ9k/TH72n1VMPR2JcCVUOGk+Z3imeoPNPDlfb
 UcuFIgdStOClegyJDTL7Rkuj4NcGsHv3lfV32cGzYgiK7PSCAyu8RNaqu A==;
X-CSE-ConnectionGUID: 7Ft5pF5pQdmlRB2Z9zwtrQ==
X-CSE-MsgGUID: kPZXPNsgQZOnF2GBC+2iLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64251258"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="64251258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 07:22:37 -0800
X-CSE-ConnectionGUID: cKZZ++qKTA+JrgagRzGEDw==
X-CSE-MsgGUID: 3sEjBQPWRbOYc17tTPChwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="191535833"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 04 Nov 2025 07:22:36 -0800
Date: Tue, 4 Nov 2025 23:44:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/4] rust/util: replace Error::err_or_unit/err_or_else
 with Error::with_errp
Message-ID: <aQofcuaXMzkzqTGE@intel.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
 <20251031152540.293293-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152540.293293-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Fri, Oct 31, 2025 at 04:25:38PM +0100, Paolo Bonzini wrote:
> Date: Fri, 31 Oct 2025 16:25:38 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/4] rust/util: replace Error::err_or_unit/err_or_else with
>  Error::with_errp
> X-Mailer: git-send-email 2.51.1
> 
> Introduce a simpler function that hides the creation of the Error**.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/util/src/error.rs | 52 ++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 32 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


