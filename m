Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1659C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Yjn-0000hq-1I; Wed, 23 Apr 2025 07:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YjW-0000cf-MG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:57:44 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YjT-0007Kx-Ji
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745409460; x=1776945460;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xEnO712NCweBry5O2/wXnH8yKP+dLPLUx43ztiaVR1M=;
 b=lsQ2oZf6lhlXWSZq2fwoPSnM6iZ/JslxGekb8C/ZnAnAY/E0NPTfh2mI
 YbB2vZlc+ma0235vvvENqH11M2CfDzubnuPyMvSeAwsE/NfuHKsZHRQWw
 wqXfJSU/EFzaO7IYgA93GRYQBtBqtdDbpvC6m5W7XvsgiAhJdeexONRY2
 3bIzFsAYOQUKBiWYkUVL5rbXZVcUG0goVHNbK28vXDmbE3RE1327W95jW
 o5D5/hqCVxeyicSs+Z0zjiuD8Ts7ypgXFsZKG6fBPgzAikGrQktqfMqE4
 vBoZ9V2WJimkonP5Uo3ViWul/TZAKMa+7fjSMk/dk1T5RqcvO/RA4ktC0 g==;
X-CSE-ConnectionGUID: nGE8HQImQK21GtYGKT8S4g==
X-CSE-MsgGUID: 7GeEKg1bTKmcE2soy/tmwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50828238"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50828238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:57:34 -0700
X-CSE-ConnectionGUID: iI7r3u/9TfWv8trn+yvcSw==
X-CSE-MsgGUID: VjgZGu3sTZ+1vpYuxidefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="169511083"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 23 Apr 2025 04:57:31 -0700
Date: Wed, 23 Apr 2025 20:18:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <aAjakhEqjAi5feMy@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com>
 <Z-0iV-xIeu0hoaaC@redhat.com>
 <54c19255-0b05-4f50-83a5-256567724df4@intel.com>
 <aAe27bMcwIwpDB6m@intel.com>
 <dd516742-ceae-44a4-8f80-23f7c73e596f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd516742-ceae-44a4-8f80-23f7c73e596f@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

> > A little suggestion:
> > 
> > With error_append_hint(local_err, ...), you can add "ERRP_GUARD()" at
> > the beginning of tdx_pre_create_vcpu(), just like the commit 95e9053a34ca.
> 
> I don't think ERRP_GUARD() is needed.
> 
> ERRP_GUARD() is used to guard @errp, while here error_append_hint() is used
> on @local_err.

Yes, you're right. My bad and thanks for correction!


