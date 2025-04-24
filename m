Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD26C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xce-0006t0-6a; Thu, 24 Apr 2025 10:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7xca-0006sH-L4
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:32:14 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7xcU-0003CW-GB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745505127; x=1777041127;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GE0hFtDyF9YEdLhXifRl+/HPP948KEXYy2V669a4+8w=;
 b=f2xzV3PNcQcPfPHmmdzmfpCgQ4V0sBw1G+VHG8npTrJ+iiBVrn4Z3pz6
 9Yjw6nCQvenUCaOvosvIJT/IpxoTmFhj6hSJM323gumY5t8SHpcVlktD4
 ap7RVkhJPRWy4DQC9MC0yL1BUkb9p2fdwUGlB02taBOGu0DeqbCqmSi8F
 G9lyNxJFY4K/XRHFln1mrxEaWncF9Xv6MJ4cU0RoNbjzvo9tBdJZ7qaRW
 tNR4YGPaG1YAXkZaxFzV/m6XHyhQSMYP3OwrENit7yfGRUONruWIi2Yvd
 LjIlRHVu5kPgum6Vz8zIhL2Hz2CTh4dhN6s5Tv6wPHE6nh2Xt4Cdg/GeS g==;
X-CSE-ConnectionGUID: pGxCbYS7Rw+uTgEYeArqag==
X-CSE-MsgGUID: eURf6MmqR0qdxdOV6Z4aBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="64559038"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="64559038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 07:32:03 -0700
X-CSE-ConnectionGUID: L9Qf74xYRviGBk4lVkWtsA==
X-CSE-MsgGUID: YkqTDrd0Qbatrnth7w5OnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="137734810"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 24 Apr 2025 07:32:00 -0700
Date: Thu, 24 Apr 2025 22:52:56 +0800
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
Subject: Re: [PATCH v8 19/55] i386/tdx: Don't initialize pc.rom for TDX VMs
Message-ID: <aApQSAeNCtOcEZwG@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-20-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-20-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:29AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:29 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 19/55] i386/tdx: Don't initialize pc.rom for TDX VMs
> X-Mailer: git-send-email 2.34.1
> 
> For TDX, the address below 1MB are entirely general RAM. No need to
> initialize pc.rom memory region for TDs.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> This is more as a workaround of the issue that for q35 machine type, the
> real memslot update (which requires memslot deletion )for pc.rom happens
> after tdx_init_memory_region. It leads to the private memory ADD'ed
> before get lost. I haven't work out a good solution to resolve the
> order issue. So just skip the pc.rom setup to avoid memslot deletion.
> ---
>  hw/i386/pc.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


