Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3D0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qCZ-0004ot-In; Thu, 24 Apr 2025 02:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7qCV-0004nj-6b
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:36:47 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7qCR-00078e-R6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745476604; x=1777012604;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N/1BTUctU2lb6VBk1Oib3IvM00J9hBOuNikf/9LtMQ4=;
 b=F9P5pmnx1GH7xB6tzAEbK6Qqwqs64moY8t4ANVFO4Fn+HhTfMPvVmolO
 ao/ncN/d4/Ic88HU5li/cH+i6fTik/obAi8IPZUQh3YpCUfRb5EDcJuCX
 48J9JdzqTV0gsJy7ZjSidcu+3cmtqyFaZhXLXY3EevXw4AX/lhDDxmEcX
 cD+UjRJgsnZC5jUB2z4fMnavVNSujtdIc/8fTNDwX6qXDpfhXngwYWeWg
 gpVxqDl/+7G7wua5cJJPyspOvXfeNy+TUoByQaKC3V1/hlRAdYqyN54oT
 FSDDO86Rph0k0Y4jAtVZ0jDNQWYEp6uOgtgon21Ff4D8WT7TdISdgSge5 Q==;
X-CSE-ConnectionGUID: ATgD0X4NQIOOJiDkJAE48Q==
X-CSE-MsgGUID: NuCzeEMMTDWxZhVoCQxkHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46977821"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="46977821"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:36:42 -0700
X-CSE-ConnectionGUID: XojoAA55T+emk4kqIX2xaA==
X-CSE-MsgGUID: ZM7pO4HHRjeXITCKypZmig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="155756304"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2025 23:36:38 -0700
Date: Thu, 24 Apr 2025 14:57:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Tao Su <tao1.su@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC 00/10] i386/cpu: Cache CPUID fixup, Intel cache model &
 topo CPUID enhencement
Message-ID: <aAng3b6hSiZw9MzP@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423114702.1529340-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, Apr 23, 2025 at 07:46:52PM +0800, Zhao Liu wrote:
> Date: Wed, 23 Apr 2025 19:46:52 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [RFC 00/10] i386/cpu: Cache CPUID fixup, Intel cache model & topo
>  CPUID enhencement
> X-Mailer: git-send-email 2.34.1
> 
> Hi all,
> 
> (Since patches 1 and 2 involve changes to x86 vendors other than Intel,
> I have also cc'd friends from AMD and Zhaoxin.)
> 
> These are the ones I was going to clean up a long time ago:
>  * Fixup CPUID 0x80000005 & 0x80000006 for Intel (and Zhaoxin now).
>  * Add cache model for Intel CPUs.
>  * Enable 0x1f CPUID leaf for specific Intel CPUs, which already have
>    this leaf on host by default.
> 
> Overall, the enhancements to the Intel CPU models are still based on
> feedback received over time, for a long time...
> 
> I'll introduce my changes one by one in the order of importance as I
> see it. (The doc update is missing in this version.)
> 
> 
> Intel Cache Model
> =================
> 
> AMD has supports cache model for a long time. And this feature strats
> from the Eduardo's idea [1].
> 
> Unfortunately, Intel does not support this, and I have received some
> feedback (from Tejus on mail list [2] and kvm forum, and from Jason).

I need to add more background:

the legacy "host-cache-info" is becoming failing... On SRF, we have
observed that it cannot accurately identify cache topology, so we have
to use "smp-cache" to set the cache topology.

However, once "host-cache-info" is disabled, we lose the cache info
that matches the real silicon... Therefore, we can only add the cache
model for the named CPU model.


