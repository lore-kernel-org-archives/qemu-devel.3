Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E09C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMvZ-00066Z-3n; Wed, 28 Feb 2024 11:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMv6-00063d-Op; Wed, 28 Feb 2024 11:36:37 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfMv3-0004GU-Dy; Wed, 28 Feb 2024 11:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709138193; x=1740674193;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZwWzALbivLFaEzSRE1bkC29w10a/LaMW8r5ZnpQ2n0U=;
 b=Xsku7iKS1JiBF74fIp0igxrGgZYq+nnBb7x+PB+ez0Ehg7cuTd2D42hk
 1GBKGbv4W+96ajSNXCR1zURapAZ/NTYUII7bir7us2n1m1Fngvi+v7ntj
 xIqWO6iCjPaxqY8H9u2+CBpdb/38PXoZnN1luTyTO+kTrUopfHMcYOXHw
 Qtfdqwu8brb2mlhoCQ9Dfdmjql3rvHf5oSHGCdkHXwSIgF0QUFrl/PjWr
 wtqJX6inqhqR/A/qZOk61aO1i/BfEm/oUFr7C5K4a/4kwdyB+HaZU2EOm
 uz6KoonYmpTNVRzW2wm4+RtGTOi1Yu/x6wE9EdqVPhbzl5y7kJOdiw0KP A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21095735"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="21095735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 08:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7348961"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 28 Feb 2024 08:36:28 -0800
Date: Thu, 29 Feb 2024 00:50:11 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 04/16] block/cbw: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <Zd9kQyQeB6HriBkD@intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-5-zhao1.liu@linux.intel.com>
 <217e42c9-a316-4b98-9050-fd5967e825f3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217e42c9-a316-4b98-9050-fd5967e825f3@yandex-team.ru>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Vladimir,

> > Signed-off-by: Zhao Liu<zhao1.liu@intel.com>
> 
> Your actual email is at linux.intel.com, is it all OK?

Yes, I'm used to sending patches from linux.intel.com, and both
addresses are OK.

> 
> I'd prefer not to abbreviate copy-before-write in subject, but anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Thanks! I'll take care of this in the future.

Regards,
Zhao


