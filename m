Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E12C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 03:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEgDN-0006Lx-5J; Mon, 12 May 2025 23:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEgDF-0006Lc-HF; Mon, 12 May 2025 23:21:49 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEgDC-0004r0-S4; Mon, 12 May 2025 23:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747106507; x=1778642507;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1SxtCsvQm+6GQra5FO8dY+JeqK+tU2JEpNuEls3/v48=;
 b=MswjL3wt+fApYpsM4OyRq2Bk1J/D43ciGGmOxop+f4YvIF+4jPH6hqwc
 JeNI7KsJ778Iygviic5eQs6X7nKzNOYBjpz3zC0rPEOhfCnFvM6Nrd1mp
 biOVjxSrD9+vMaCexqpbtVfVkyJpSZTYj5zHoDaBsnWitwSLrPXPmdn3G
 U6WxtHMlqKT0IG4lH+eKAJWRImiKoePWXKrGyaeIb//sg40lvWT4La9CT
 2LX7cP4ciPpNDlH4bm22mRNU0KIdo7+xGCKDdg5Mh0ktaSqgh6HsjzOio
 dmx3PnZeBl8i2ikZND/UsOG0BJP7iD8lCtdUYylmF1rwPjp8RdzrSfHS3 A==;
X-CSE-ConnectionGUID: xlFAYbZ8QxWn5G6yhUuSjA==
X-CSE-MsgGUID: 86Nz985rSne8yfW/IalGuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48856755"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="48856755"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 20:21:44 -0700
X-CSE-ConnectionGUID: RFdNaYxpTY67TN+0Me7LuQ==
X-CSE-MsgGUID: g2ct4n0oSwqWSlt+efelxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="168476532"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 12 May 2025 20:21:41 -0700
Date: Tue, 13 May 2025 11:42:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Babu Moger <babu.moger@amd.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH 1/4] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Message-ID: <aCK/tDklG64EZEw2@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
 <20250227062523.124601-2-zhao1.liu@intel.com>
 <84c154b8-c4ab-4a51-8b27-48ec783e0758@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c154b8-c4ab-4a51-8b27-48ec783e0758@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

Hi Paolo,

Kindly ping. I think this series is still needed. Could you pls take
a look at here?

Thanks,
Zhao

On Mon, May 12, 2025 at 12:32:31PM +0300, Michael Tokarev wrote:
> Date: Mon, 12 May 2025 12:32:31 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH 1/4] i386/cpu: Fix number of addressable IDs field for
>  CPUID.01H.EBX[23:16]
> 
> On 27.02.2025 09:25, Zhao Liu wrote:
> > From: Chuang Xu <xuchuangxclwt@bytedance.com>
> > 
> > When QEMU is started with:
> > -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> > -smp 180,sockets=2,dies=1,cores=45,threads=2
> > 
> > On Intel platform:
> > CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> > logical processors in the physical package".
> > 
> > When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> > CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> > executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> > CPUID.04H.EAX[31:26], which matches the expected result.
> > 
> > As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> > it's necessary to round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> > integer too. Otherwise there would be unexpected results in guest with
> > older kernel.
> > 
> > For example, when QEMU is started with CLI above and xtopology is disabled,
> > guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> > calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> > as the result, even though threads-per-core should actually be 2.
> > 
> > And on AMD platform:
> > CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
> > result meets our expectation.
> > 
> > So round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer only
> > for Intel platform to solve the unexpected result.
> > 
> > This change doesn't need to add compat property since it does not affect
> > live migration between different versions of pc machines.
> > 
> > Cc: qemu-stable@nongnu.org
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Ping?
> 
> Is this series still needed ?
> 
> Thanks,
> 
> /mjt

