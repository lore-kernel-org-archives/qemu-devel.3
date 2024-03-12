Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC01C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjz7k-0002uk-NM; Tue, 12 Mar 2024 06:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjz7d-0002u3-Gz; Tue, 12 Mar 2024 06:12:37 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjz7a-0002n1-4f; Tue, 12 Mar 2024 06:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710238354; x=1741774354;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wSqSiLG+NZqdAqTMJRfPpQD42L3+mQM4qj6rqb8R/OU=;
 b=mXz8m8i3gQJjOCOO0+PZLyNmMPe+4CdR3381BoEEiX9UAkaY9z/5TEfY
 HJdBMGNlQSZfZXIx1bKt7Q1puLR2IUFzuU5r9Pcs9EG7fUMhO5aBNf2Pf
 yylFA/7LpaeebmydEji+P0Lfdvd47d2/voUOVN8XFSzcRo43XmkYH/KJE
 3dt7sXdpxaxRmckOvEcSLvyvnGXnW5xHsPRQtiBqNLWwlylazgusEAfJa
 5wZnHrrq6Nq3lcZRWpI+yc0uSAFuzAsVXoT7hOOC4bvtRqNc5rUDRldrL
 F1yhjnK5sId8OFOiGrUys7+FSibrahPpO8cti3+FDGWK4kJpZ8vVca3yb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15665663"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="15665663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 03:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11944790"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 12 Mar 2024 03:12:26 -0700
Date: Tue, 12 Mar 2024 18:26:15 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <ZfAtx3fBR9KgsAWa@intel.com>
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <d48e5d05-0e1e-4bb0-b10a-f0c943b055f6@linaro.org>
 <ZfAVsQTIOgAOjd0Y@intel.com>
 <4ba8e5dc-cda0-4ed4-8baa-82687a235627@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba8e5dc-cda0-4ed4-8baa-82687a235627@redhat.com>
Received-SPF: none client-ip=192.198.163.9;
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

On Tue, Mar 12, 2024 at 09:50:25AM +0100, Thomas Huth wrote:
> Date: Tue, 12 Mar 2024 09:50:25 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH v2 00/29] Cleanup up to fix missing ERRP_GUARD() for
>  error_prepend()
> 
> On 12/03/2024 09.43, Zhao Liu wrote:
> > Hi Thomas/Markus/Michael,
> > 
> > For the remaing patches, could you please help me merge them next?
> > 
> > Many thanks!
> 
> Yes, I'm currently reviewing the ones that don't have a Reviewed-by yet. I
> can pick up the remaining patches if the other maintainers won't pick them
> up for the softfreeze today.
> 

Appreciate that you can help me get on the last train of releases.

If possible, could you please also help me pick up two other ERRP_GUARD()
related cleanups (total 8 patches, both got r/b)? ;-)

My cleanup is too fragmented, I'll try to centralize my work to make it easier
for maintainer to review and merge in the future!

[1]: https://lore.kernel.org/qemu-devel/20240223085653.1255438-1-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20240312060337.3240965-1-zhao1.liu@linux.intel.com/

Many thanks,
Zhao


