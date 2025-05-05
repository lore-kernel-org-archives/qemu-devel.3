Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA62C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxC6-0003cc-TH; Mon, 05 May 2025 10:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxC4-0003cF-VJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:53:20 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxC3-0005Tl-5m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746456799; x=1777992799;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Sx59c+TfgrWq5iDqojXTU8HmVLf95cMUxGM+E4boaoA=;
 b=ckU6KCT4lTWni+6Q1Vkh4SccBqIEQgHOkn248fd1PvM3YamnTCLc9S++
 /yJnVeigOEEgdDdYXdia79QSojgzIe/awrSOviXO7E5Q+doGxPAuVLoup
 Y8+WhQu0C7zpNPZ9ys5f+VETtkt/FP+g6+rKaBxtsJyg0ywvLL6g+pAEB
 FlV5eZnJ5iQ4ztMtzemnpo1wzL3SsOvf61RzjbPPle9/jE4gDevTIRpo6
 9PFD664eIyokBodDbCht+0ATMAQ/Ibyrz6m+Xqz3qq3ZGcD5Zgb4VyPPw
 iMEIF5hfls7CLcA44EFUqoyK6CI5KJY28/D+Qg0HVvO7pX/m2iiBFpFQJ Q==;
X-CSE-ConnectionGUID: nc/wUPxOTW+M9VF/YHhOAw==
X-CSE-MsgGUID: bU2VsqRXS+erH8p9kBWOFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="35688444"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="35688444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2025 07:53:17 -0700
X-CSE-ConnectionGUID: lwg7QG7mRiqlnui0xxw65w==
X-CSE-MsgGUID: V2FrvTBmSL2yNllm0ZAXuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="140428315"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 05 May 2025 07:53:14 -0700
Date: Mon, 5 May 2025 23:14:15 +0800
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
Subject: Re: [PATCH v8 53/55] i386/tdx: Make invtsc default on
Message-ID: <aBjVx1athm3JJ+DK@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-54-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-54-xiaoyao.li@intel.com>
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

On Tue, Apr 01, 2025 at 09:02:03AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:02:03 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 53/55] i386/tdx: Make invtsc default on
> X-Mailer: git-send-email 2.34.1
> 
> Because it's fixed1 bit that enforced by TDX module.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


