Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CEDC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXtS-00042j-OZ; Fri, 08 Mar 2024 05:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riXtO-0003y9-96; Fri, 08 Mar 2024 05:55:58 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riXtL-0005y8-7p; Fri, 08 Mar 2024 05:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709895355; x=1741431355;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4oIgtf+paer8ClkmhTXjdZdJb9xaIV/5IsWivs9QhTs=;
 b=Lx4IIjt4wV/KL9BUhxRyS8+Q4fvtbrR5X1HS7olOE4qQTpOfQo8cESRH
 MJhadtIOV5waJlnbYX8U60Yu4wk/TFn2gZE7a5tZieERFEQBAW+Iszi4g
 ZdqJXPgDuQdjIfUQn9PxHULJMuOBJOJ+/TsagQ5sr2ogfiJt9GTbLKhuf
 oKc1UaNfNKMbhTJz9G6VxVgmwzbWheeuBf5uUNZoeXlBYsnmVGY4KKP7c
 BsYiIZbthlGhw8QUy1SCmQoGTOP8g7F3umlHfL9s14M06VBTc+y23n2bQ
 sa1ZI7/a/fMOI0QRrz7cTFtlNb+W6G1zFosDsmStYr5i+nrtL2hwf69ea g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4779047"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4779047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 02:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="10836852"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 08 Mar 2024 02:55:50 -0800
Date: Fri, 8 Mar 2024 19:09:36 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 03/16] block: Fix missing ERRP_GUARD() for error_prepend()
Message-ID: <Zerx8HOvpcOeoBWt@intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-4-zhao1.liu@linux.intel.com>
 <gmziaj7f2xj6qxharirunbm5apnqffz6tl33emtjsdkn5uqkxb@hdfllvc76gdk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gmziaj7f2xj6qxharirunbm5apnqffz6tl33emtjsdkn5uqkxb@hdfllvc76gdk>
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On Thu, Feb 29, 2024 at 01:51:16PM -0600, Eric Blake wrote:
> Date: Thu, 29 Feb 2024 13:51:16 -0600
> From: Eric Blake <eblake@redhat.com>
> Subject: Re: [PATCH 03/16] block: Fix missing ERRP_GUARD() for
>  error_prepend()
> 
> On Thu, Feb 29, 2024 at 12:37:10AM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > As the comment in qapi/error, passing @errp to error_prepend() requires
> > ERRP_GUARD():
> > 
> 
> > 
> > In block.c, there're 4 functions passing @errp to error_prepend()
> > without ERRP_GUARD():
> >  - bdrv_co_create_opts_simple()
> >  - parse_json_filename()
> >  - bdrv_open_backing_file()
> >  - bdrv_append_temp_snapshot()
> > 
> > bdrv_co_create_opts_simple(), as an implementation of
> > BolckDriver.bdrv_co_create_opts(), its @errp parameter is so widely
> 
> BlockDriver
>

Good catch! Thanks and will fix!

Regards,
Zhao


