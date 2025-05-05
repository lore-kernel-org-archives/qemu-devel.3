Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EC5C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxbf-0003m6-5L; Mon, 05 May 2025 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxbe-0003lx-88
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:19:46 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBxbb-0008G1-LD
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746458383; x=1777994383;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7GC1k68l50k5cSSxxSPhvYp3s4QfgioSkR4NaUvGao4=;
 b=FNE5Jd/U9ci3p5kHuhjic4dBkX8FwBkITS4P7cL6/L6OuZeRfhbMoazv
 DGbEjI9npd9eBMvFtKE18DiLUkQ53F2RfAfHGZYsB9mw0lPLrAyvW1Q3m
 LkT9rYkng32xf+d4sRm0ynhmWAOxKz0xcr0A1hBQ3YrzmqQeyJfC9vxL+
 wycZ9mKrYGvQXpaAtZ9UCsv9ylq24toAxf0npAgBnMsHLYtOHVcWSBp2A
 oSJ8hXbbs09uhdkZeIvO/7+HsfhSCfX5E+iJcTpJXYA2K9arlE4+Tm9sn
 7jzWUDRQtLyVa6in+ex0OA0BJMcVVkv/J5kkHwrJ5oUDyxzxSgAkxo8yB Q==;
X-CSE-ConnectionGUID: rlJUdFvMTAWoZZS9eO8zPw==
X-CSE-MsgGUID: A5ztgS2LSmazbb1BHVvCGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47973994"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="47973994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2025 08:19:40 -0700
X-CSE-ConnectionGUID: BbQzuZ1WRYeZNWx/SeVpCg==
X-CSE-MsgGUID: 50Oue0XzT+SUihxzcabaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="139297657"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 05 May 2025 08:19:38 -0700
Date: Mon, 5 May 2025 23:40:38 +0800
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
Subject: Re: [PATCH v8 52/55] i386/tdx: Don't treat SYSCALL as unavailable
Message-ID: <aBjb9m+h3jL0/m65@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-53-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-53-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:02:02AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:02:02 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 52/55] i386/tdx: Don't treat SYSCALL as unavailable
> X-Mailer: git-send-email 2.34.1

It's better to add the commit message (for example, your additional
comment at v6 [1]).

[1]: https://lore.kernel.org/qemu-devel/3345330e-c111-4d08-9852-9dede46957d2@intel.com/

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v7:
>  - fix CPUID_EXT2_SYSCALL by adding it to actual;
> ---
>  target/i386/kvm/tdx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


