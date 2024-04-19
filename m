Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjhU-0005OR-RF; Fri, 19 Apr 2024 04:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxjhE-0005AN-R3; Fri, 19 Apr 2024 04:34:14 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxjhB-0004Np-F6; Fri, 19 Apr 2024 04:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713515650; x=1745051650;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hserpj6q14WZ6B3U/Wc1hUKv25yTQ7nE6LIyJ+kOzis=;
 b=icWZwcbV4VBXdboP3itRY5vh6VwxRUpyrnCV0Rm0CiOMjrKvM3AEYcks
 gGC2zUY+qTGf1YMBZddXTftlWHZsyI6R0YUfwpaXvauPajM3o9oyTb/rH
 C5URSeoHQ+vOwGs2kcvWZNma6FR/8vCbZZ9hQMhhM14/m69h/mq8Et1j6
 G7TzFz/V2IpmKXEbNfi+V7f1X8nzZJlA/WBPUEsfabS+H/sxNIIcLfC67
 UKTwI9Ri0Eq6LnqtCTpLw0M+ToIXqiupOY70WWFhUXkqPLz44/VOHWWhh
 qe8RnIrYsf+6MxO9Cq8ra/EzDaJJoF5arB6YR/9/QuffIN6DmtbyvbFgb Q==;
X-CSE-ConnectionGUID: 3lKFCrK6QYelplEUZfQVhQ==
X-CSE-MsgGUID: cFRcYC5tSi+/j/XXTGD6mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20248505"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="20248505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 01:34:06 -0700
X-CSE-ConnectionGUID: 05K86+1lSJKd7C5LvwGpPQ==
X-CSE-MsgGUID: ASActitdR3GaF2rqDQz7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="27887496"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 19 Apr 2024 01:34:02 -0700
Date: Fri, 19 Apr 2024 16:48:07 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/6] target/s390x/cpu_model: Drop local @err in
 s390_realize_cpu_model()
Message-ID: <ZiIvx+r/O8tt4sl7@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-3-zhao1.liu@linux.intel.com>
 <a71e2142-9e83-4fa5-b605-7d73b04693d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71e2142-9e83-4fa5-b605-7d73b04693d8@redhat.com>
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 19, 2024 at 09:39:53AM +0200, Thomas Huth wrote:
> Date: Fri, 19 Apr 2024 09:39:53 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH 2/6] target/s390x/cpu_model: Drop local @err in
>  s390_realize_cpu_model()
> 
> On 19/04/2024 08.57, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Use @errp to fetech error information directly and drop the local
> 
> s/fetech/fetch/
> 
> > virable @err.
> 
> s/virable/variable/
> 
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   target/s390x/cpu_models.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> With the typos fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

Thanks! --codespell check also missed them. Will fix!

Regards,
Zhao



