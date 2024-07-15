Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A46C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLJK-0005QV-VM; Mon, 15 Jul 2024 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTLJJ-0005NA-1A
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:00:09 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTLJD-000841-Pw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721048404; x=1752584404;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=msFGL9O2FG1ZiIjc/Rz/0KRBRpv3Wzr7X0GIM0OyuUk=;
 b=aXqm/TTij4MxscmQpZWJZv2zLi6f2nNQLMJ6luwpZDhZ54j6ZQn07fmZ
 sLp2ttYyJYPbiSIFKlxZjMf6wAYiicDl7pNDCdlun88ThXgl09CXrdhMz
 6fYsck8hCF+z+JsT1a+MT8yJ/jAhh7Y+SVzi+tVyQdP3oZQt6orR3aQ1q
 dvh0usP2l0GXdIkcN6C0ySA/yIRny1XPSlV9HJUU8dLVuG1J5TVNww7mk
 c6XJ/kFX1IwmfHhhnnZY+AqZi9z2I70DfMRsVDh7Rmf25VTNX/kYvEne3
 cXD5RwpvmEmkOszi9tYe32bDfS/3WNskfQGhgOOjAjqYVClUKBllKCxxA w==;
X-CSE-ConnectionGUID: re7N7gQFRYWYgmwQQVCJow==
X-CSE-MsgGUID: zvkFt7IkR+KUUGvUQUZ2IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18378834"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="18378834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 05:59:59 -0700
X-CSE-ConnectionGUID: NRovJIe8RciP8MhJ/qAoCw==
X-CSE-MsgGUID: nikLPMm5QPWghVjg2TScEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="87121177"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 15 Jul 2024 05:59:58 -0700
Date: Mon, 15 Jul 2024 21:15:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 zhao1.liu@intel.com
Subject: Re: [PATCH 0/3] target/i386/cpu: Misc Cleanup on host-cache-info
Message-ID: <ZpUg+7vqXCZEk6Sc@intel.com>
References: <20240619144215.3273989-1-zhao1.liu@intel.com>
 <ZotNnot6LmB5og1T@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZotNnot6LmB5og1T@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Igor,

Just a friendly ping :-)

May I ask if you are satisfied with the clarification in this series?

Thanks,
Zhao

On Mon, Jul 08, 2024 at 10:23:26AM +0800, Zhao Liu wrote:
> Date: Mon, 8 Jul 2024 10:23:26 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 0/3] target/i386/cpu: Misc Cleanup on host-cache-info
> 
> Hi Igor,
> 
> Just a gentle poke and what do you think about this minor series?
> 
> Thanks,
> Zhao
> 
> On Wed, Jun 19, 2024 at 10:42:12PM +0800, Zhao Liu wrote:
> > Date: Wed, 19 Jun 2024 22:42:12 +0800
> > From: Zhao Liu <zhao1.liu@intel.com>
> > Subject: [PATCH 0/3] target/i386/cpu: Misc Cleanup on host-cache-info
> > X-Mailer: git-send-email 2.34.1
> > 
> > Hi,
> > 
> > This series is mainly to addresss Igor's comment about if one check in
> > host-cache-info could be removed [1], i.e., whether Guest's cache
> > topology should be self-consistent (able to correspond to Guest's CPU
> > topology level, as we currently do with the Guest cache topo).
> > 
> > I originally thought (in the mail thread with Igor) that host-cache-info
> > should allow Guest and Host to have the same topology level information,
> > e.g. if Host shares cache on core level, then via host-cache-info, Guest
> > should also share on core level.
> > 
> > But in practice, I gave up on this idea, because in the cache info
> > passthrough case, it should be possible for Guest to get the original
> > Host cache info (including the original threads sharing cache) without
> > further modifying the info to Guest.
> > 
> > Therefore, I simply added the comment in PATCH 3 to hopefully illustrate
> > the need for such a check.
> > 
> > Hope my explanation is clear enough so that my poor English doesn't
> > bother you!
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20240527170317.14520a2f@imammedo.users.ipa.redhat.com/
> > 
> > Thanks and Best Regards,
> > Zhao
> > ---
> > Zhao Liu (3):
> >   target/i386/cpu: Use hex mask to check for valid cache CPUID leaf
> >   target/i386/cpu: Check guest_thread_ids_per_pkg for host-cache-info
> >     case
> >   target/i386/cpu: Add comment about adjusting the Guest cache topo for
> >     host-cache-info
> > 
> >  target/i386/cpu.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 

