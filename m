Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AEAC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 07:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFU47-0004ua-7c; Fri, 07 Jun 2024 03:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFU3u-0004tV-4F
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:30:58 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFU3r-0003I5-I3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 03:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717745456; x=1749281456;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HZj6cqJei0vlasAbvR9hW59bmim6mnCGbmE1jDXvsK8=;
 b=mEuSPrmBhsstmR6tCWAnMCSkErD5XLtpgEJRCO8E+mPRxum78taKaCRr
 OuIjAcVP4AYXhQYgt586YKOvAEYMvxBZHQ0fuXFBBSdgYScNGtHved0za
 APAugHciAWJXe5JCMdopEprDQUtSssmmwQALRf+vIvRp2KN5+Yn9uIScw
 OSd9zNjcvMMap1yjlOMaZYBn2HCsCGXgFjtvKpapx+LM/DjMjfcCOqN3E
 JkJI3HkLE3RWJUM+O8fITcc9K3aIh0tU6sDTsLqMytpM0S/BgsIMCaQ32
 I7QdO3gLMttZECQtStCH8mspX/p52+6f1OK2mXykBiHk3y5O2DZOIi7uA g==;
X-CSE-ConnectionGUID: Z6CjVbvRQIuRoZLAnkh4hg==
X-CSE-MsgGUID: SQUYb7qgQr6H8peVrk0Fbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14635089"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; d="scan'208";a="14635089"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2024 00:30:49 -0700
X-CSE-ConnectionGUID: 4FnxPDdkR2WBcD40dQELsg==
X-CSE-MsgGUID: yeaurieGTbaNWDttoDJBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; d="scan'208";a="38804935"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 07 Jun 2024 00:30:47 -0700
Date: Fri, 7 Jun 2024 15:46:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/apic: Add hint on boot failure because of disabling
 x2APIC
Message-ID: <ZmK6xuhlR7K4CXCP@intel.com>
References: <20240606140858.2157106-1-zhao1.liu@intel.com>
 <58ea1275-b71c-4098-b7e6-cde428a2eabb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58ea1275-b71c-4098-b7e6-cde428a2eabb@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Fri, Jun 07, 2024 at 08:17:36AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 7 Jun 2024 08:17:36 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] i386/apic: Add hint on boot failure because of
>  disabling x2APIC
> 
> On 6/6/24 16:08, Zhao Liu wrote:
> > Currently, the Q35 supports up to 4096 vCPUs (since v9.0), but for TCG
> > cases, if x2APIC is not actively enabled to boot more than 255 vCPUs (
> > e.g., qemu-system-i386 -M pc-q35-9.0 -smp 666), the following error is
> > reported:
> > 
> > Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:449:
> > qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> > Aborted (core dumped)
> > 
> > This error can be resolved by setting x2apic=on in -cpu. In order to
> > better help users deal with this scenario, add the error hint to
> > instruct users on how to enable the x2apic feature.
> 
> Why not automatically set x2apic=on in this case instead?

The default CPU model is qemu64 without x2APIC. I think it might be
necessary to update the version to add x2APIC in qemu64, and I'd like to
look into it again for any other potential issues.

In addition to adding x2APIC directly to the qemu64, this hint can also
help some users who want a large number of vCPUs based on other older
CPU models. Though, it's not very common but this hint would be helpful.

> > Then, the error
> > report becomes the following:
> > 
> > Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:448:
> > qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> > Try x2apic=on in -cpu.
> > Aborted (core dumped)
> > 
> > Note since @errp is &error_abort, error_append_hint() can't be applied
> > on @errp. And in order to separate the exact error message from the
> > (perhaps effectively) hint, adding a hint via error_append_hint() is
> > also necessary. Therefore, introduce @local_error in
> > apic_common_set_id() to handle both the error message and the error
> > hint.
> > 
> > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/intc/apic_common.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!


