Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB9C25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 03:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Gc6-0000cP-Hc; Thu, 09 May 2024 23:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Gc4-0000c9-Fg; Thu, 09 May 2024 23:08:00 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Gc1-0007L5-Gj; Thu, 09 May 2024 23:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715310477; x=1746846477;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lYBfDHg9AieJIAdlgk9noVfnLMDkO62rNJNLtajijaA=;
 b=hDsT4JQLs4QAgU6IACbpRzMDyxZnGfRU4ysGKytAdxB+pvMOgYYfDIUi
 CQOO2I7iXcHA4d9j0hv5ZM3oqcDFhlIGiZTf3+yCBEuhMogxT0P5+0GKu
 uhdSJdtdapZA+P2TWvqDzs89rMB8tJgjstMoSrxu75BYH+j11mINyUGCo
 Wtl2bpE+srVJttl5AnxnN+U73joNP5J8baXjus8VFIpJOvNcvtZU0ttax
 FHzqQgFW/0Tnrc40eH3HPxZirtw8x85uFDJXQ3mrOBQuLHLVO/8UJ/aOm
 +SKcczeG1BOj+1Xz5XsnUvqIiyPYy0jBFXoJp9W+6EsyEqoqihjyuJKeZ A==;
X-CSE-ConnectionGUID: g1f+dFNdSCCVI0weWlht5g==
X-CSE-MsgGUID: tNFKsSxJQwGNswra6iDYaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15069954"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="15069954"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 20:07:53 -0700
X-CSE-ConnectionGUID: jODW4HGwS8eq5LdkEHFUPQ==
X-CSE-MsgGUID: mTX/FzpgQ9WAPX9GBBJlrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="34243785"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 09 May 2024 20:07:52 -0700
Date: Fri, 10 May 2024 11:22:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: fix feature dependency for WAITPKG
Message-ID: <Zj2S3QrJkxmeX1Cw@intel.com>
References: <20240509153950.143766-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509153950.143766-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 09, 2024 at 05:39:50PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 17:39:50 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: fix feature dependency for WAITPKG
> X-Mailer: git-send-email 2.45.0
> 
> The VMX feature bit depends on general availability of WAITPKG,
> not the other way round.
> 
> Fixes: 33cc88261c3 ("target/i386: add support for VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE", 2023-08-28)
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


