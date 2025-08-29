Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269E5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN65-00077h-4u; Sat, 30 Aug 2025 11:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtXf-0005Jn-3i
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:28:59 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtXb-0001iB-Bn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756452536; x=1787988536;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XDoflb1z6uV+m7t5bBomDLPKLaOuGR6Fg/aQ7zz+4+w=;
 b=jnu90OpjTV6eajvsMMN7wwZcuSMAHG/aj6QYkpmwQzv5a0CRHibQgaTm
 FAXkvhLuH4QUunRp4g6DM/9YMzQq2l63zH7n3SiS9ykgoInrNJn7MPxZY
 ZzNgItMMYXN/1Tc6XlBx5Ofz8PFnq/lE5kA0RiGM+c1cLhEQO0ZYvJpMi
 jjEFYegfsJsq3Lv/DzBtxruDeBPAYrJ9/cDHu5d2Q5pSrn0ugjGvqF1TY
 ud2TQJ3RUQFKG3ZtN1WXlQ3xCyYRGr5qIqEdkjHCXdWojqvlIAS02pGtH
 a4PPo/hG0Ew6atVrXJU5CjSuI1+wn+5hCBgiCPhYbsnUX6+Wt5QFOU8gf w==;
X-CSE-ConnectionGUID: ni52fRrLTJWVNP/5a4/igg==
X-CSE-MsgGUID: PgvekRVNS2WUGzP9UWYxJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62566888"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62566888"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:28:53 -0700
X-CSE-ConnectionGUID: qhGLGVW3QEeWU8Jwc5YdXg==
X-CSE-MsgGUID: 2oiBc1k7SU2dBDFinzNngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="169843616"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 29 Aug 2025 00:28:46 -0700
Date: Fri, 29 Aug 2025 15:50:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 kvm@vger.kernel.org, aharivel@redhat.com
Subject: Re: [PATCH 2/2] vfio scsi ui: Error-check
 qio_channel_socket_connect_sync() the same way
Message-ID: <aLFbyaluXSmmhUFk@intel.com>
References: <20250723133257.1497640-1-armbru@redhat.com>
 <20250723133257.1497640-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723133257.1497640-3-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 23, 2025 at 03:32:57PM +0200, Markus Armbruster wrote:
> Date: Wed, 23 Jul 2025 15:32:57 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 2/2] vfio scsi ui: Error-check
>  qio_channel_socket_connect_sync() the same way
> 
> qio_channel_socket_connect_sync() returns 0 on success, and -1 on
> failure, with errp set.  Some callers check the return value, and some
> check whether errp was set.
> 
> For consistency, always check the return value, and always check it's
> negative.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/vfio-user/proxy.c     | 2 +-
>  scsi/pr-manager-helper.c | 9 ++-------
>  ui/input-barrier.c       | 5 +----
>  3 files changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


