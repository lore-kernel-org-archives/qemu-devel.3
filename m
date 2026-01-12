Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018E9D25032
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfCTL-00014c-6W; Mon, 12 Jan 2026 02:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCT4-0000sq-1c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:36:04 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vfCT2-00008Y-8t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768203360; x=1799739360;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=V2y9jR5BLpe3D/6SpLQolujjrx0LqpdtXifG3y9ZbwQ=;
 b=J7ehcyr/SNn4CIB09ifOEiyKmS4xm1I3MpUHOTyvqw7x+ELiyiLT0zCZ
 y5XWfvMyh+9SpbplqMRT9pr1iO28AnN2cMvZTuIHxlz3atZiZ3vZUI0nJ
 504mEZYZI6CiRp+RJhIsvAwkDFNWcKRwnEMIS3vMRlgROMID84m/pEElu
 7J/N0hrw6dleMVTL59L929rY3e+ONDb1UA5lH1NvzYbrTZ/kTd9YHPdKu
 vq2mrJ033mUfOPl41UIEcnIkFwkdWOaeC2oudcY4JGjPsjEYW7qofgIDE
 s7LtVYNjUC0ZUWdGHb6SWkACJrAPBqD+zjnb1xlRRTfrhaPPwaomFisKY A==;
X-CSE-ConnectionGUID: KYd3LZA5QPCRPXgHVnFPeA==
X-CSE-MsgGUID: CTQeqv7MS5+MmLBddM5YFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="72051205"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="72051205"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 23:35:57 -0800
X-CSE-ConnectionGUID: KvJwy6cTRvShJ62gP2sunA==
X-CSE-MsgGUID: eNjkj5SZREq7cebp4o5s4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="204304266"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 11 Jan 2026 23:35:55 -0800
Date: Mon, 12 Jan 2026 16:01:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, seanjc@google.com, santosh.shukla@amd.com,
 nikunj.dadhania@amd.com, ravi.bangoria@amd.com, babu.moger@amd.com,
 K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH 1/5] i386: Implement CPUID 0x80000026
Message-ID: <aWSqUylwHmhIeBjq@intel.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-2-shivansh.dhiman@amd.com>
 <aV4KVjjZXZSB5YGw@intel.com>
 <eb712000-bc67-468a-b691-097688233659@amd.com>
 <aWDEYEfB4va41+Tv@intel.com>
 <df23391a-599a-495b-a1b2-ed548215e2c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df23391a-599a-495b-a1b2-ed548215e2c5@amd.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> >> The current kernel doesn't have sensitivity to a level between L3 boundary and
> >> socket. Also, most production systems in current AMD CPU landscape have CCD=CCX.
> >> Only a handful of models feature CCD=2CCX, so this isn't an immediate pressing need.
> >>
> >> In QEMU's terminology, socket represents an actual socket and die represents the
> >> L3 cache boundary. There is no intermediate level between them. Looking ahead,
> >> when more granular topology information (like CCD) becomes necessary for VMs,
> >> introducing a "diegroup" level would be the logical approach. This level would
> >> fit naturally between die and socket, as its role cannot be fulfilled by
> >> existing topology levels.
> > 
> > With your nice clarification, I think this problem has become a bit easier.
> > 
> > In fact, we can consider that CCD=CCX=die is currently the default
> > assumption in QEMU. When future implementations require distinguishing between
> > these CCD/CCX concepts, we can simply introduce an additional "smp.tiles" and
> > map CCX to it. This may need a documentation or a compatibility option, but I
> > believe these extra efforts are worthwhile.
> > 
> > And "smp.tiles" means "how many tiles in a die", so I feel it's perfect
> > to describe CCX.
> 
> That indeed looks like a cleaner solution. However, I'm concerned about
> retaining compatibility with existing "dies". But yeah, that's a task for a
> later time.

Yes, it may be necessary to address some compatibility issues. But I think
this way could align with the topology mapping of the Linux kernel as much
as possible.

Thanks,
Zhao


