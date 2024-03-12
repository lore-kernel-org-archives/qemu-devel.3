Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC5C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxW9-0001Ne-Qa; Tue, 12 Mar 2024 04:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjxW7-0001Mi-Ed; Tue, 12 Mar 2024 04:29:47 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjxW5-00026n-8A; Tue, 12 Mar 2024 04:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710232185; x=1741768185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZSSpFddo5gHNV5jEQzmHwmnXBeHiCAwgL53FK035/cE=;
 b=FChstYSt8YDLWwefwlcVoOF+0lZDAK9J2ff4nWSlCLEowPYt7WIZl3JK
 4Wa/dj86tKDseBdAANwa/9hIkrYgL6dp7HVDdnqjvJ1eg/TrBx4nM+80+
 5jotLnKIuXpwv2OACbQK5127XxDUSAgf5GpRi316quOQkovuKoTHBTQsL
 /IzlCmOkrzLieBCspJy4qRcIj9+KNPWirmIRLdv6mQVP1ewJM6fxt/QUM
 IGgZxm1z1rW9YKN4SseSqPVJGYdtHjgPLCPKWIQs+qMeoCvd8VzzZUtNe
 byBQMaiK0Ij8LG4hg8gTA3dY7tkgPBGeGImuCcZegseUgREwNDPaZA7Dv w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="7873312"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="7873312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 01:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="15953968"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 12 Mar 2024 01:29:40 -0700
Date: Tue, 12 Mar 2024 16:43:29 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <ZfAVsQTIOgAOjd0Y@intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <d48e5d05-0e1e-4bb0-b10a-f0c943b055f6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d48e5d05-0e1e-4bb0-b10a-f0c943b055f6@linaro.org>
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Thomas/Markus/Michael,

For the remaing patches, could you please help me merge them next?

Many thanks!
Zhao

On Tue, Mar 12, 2024 at 09:17:30AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 12 Mar 2024 09:17:30 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
>  error_prepend()
> 
> On 11/3/24 04:37, Zhao Liu wrote:
> 
> > ---
> > Zhao Liu (29):
> 
> >    hw/core/loader-fit: Fix missing ERRP_GUARD() for error_prepend()
> >    hw/core/qdev-properties-system: Fix missing ERRP_GUARD() for
> >      error_prepend()
> >    hw/misc/ivshmem: Fix missing ERRP_GUARD() for error_prepend()
> 
> I'm queuing these 3 patches, thanks!




