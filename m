Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F61C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxid-0003FO-BU; Thu, 06 Feb 2025 03:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfxiZ-0003F6-A6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:58:39 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfxiX-0004WJ-O4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738832318; x=1770368318;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eeuulv5JLGftzUOJMSAtkOWvy58gJZCXRj6UIl2qTYg=;
 b=B5u+j8E5HnAf1vu1Ksfcw4c+Mbb97iuIOU+vZEoL23VV2cecFP70SYJW
 yIU3wmGSl4UtkD8zhzWoK8tCgT2q7ectUecJ8fvAlSyPJzQTHEBHhYOMa
 dGLvjg3ai5nIim+OR8JiN1ngYsLWVDszhqvkFQvXn0dwv4MxuErf3uuDS
 FUMRILCCVnUtaA+14b1uduFcHvRF31kCVqMgnsYkkO7vVnjr1/LDYnVTc
 ebSAZk9sY1HsIJOEx1LY/lU62ijwyXDX89GN5dGKufQd4Hj4JtD66eDwt
 HNf7UsgNxvxe0T43wh01SDwx3VHmGqnr3mNPeEygNu9UyjK+bGBMSXjtr g==;
X-CSE-ConnectionGUID: 0xzSH2z+RqejNtlJwUBVUA==
X-CSE-MsgGUID: 1W71PJ37QDuyFRTLXzxPHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64779127"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="64779127"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 00:58:32 -0800
X-CSE-ConnectionGUID: J1i99jh2QnOK8baB8N2FXg==
X-CSE-MsgGUID: uq7B1JZ1QNmZ9MO8yBtwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="116184254"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2025 00:58:29 -0800
Date: Thu, 6 Feb 2025 17:17:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
Message-ID: <Z6R+RpFGJHWyE5iq@intel.com>
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
 <87jza4zi5o.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jza4zi5o.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Wed, Feb 05, 2025 at 01:32:19PM +0100, Markus Armbruster wrote:
> Date: Wed, 05 Feb 2025 13:32:19 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi folks,
> >
> > This is my v7 resend version (updated the commit message of origin
> > v7's Patch 1).
> 
> If anything changed, even if it's just a commit message, make it a new
> version, not a resend, to avoid confusion.  Next time :)
> 
> [...]

Thanks Markus! I'll keep in my mind about this :-).


