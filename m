Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52775C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTKpa-0004GE-Gu; Mon, 15 Jul 2024 08:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTKpR-0004Do-Fj; Mon, 15 Jul 2024 08:29:18 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTKpP-0000lx-BE; Mon, 15 Jul 2024 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721046555; x=1752582555;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=miQmptctDvyLsHlxDcDl05oZOCrd2/ChwcgEgwkHaSY=;
 b=I/4dK68YkTGmP7zhJIcPi2FdtJaZplGBQQ6VwEwSCm/cOP4HOz2vAWST
 14E6eKItVlvibgxkUAw0cjHaoXNYIfzGSkIJX5OeJIaHGkMc0fUjDyAJK
 CZyBHlcNvOXB85spEFZT4+vyqmhIISg1FFpuLxefein4frU3cVypWhbGv
 KpSEdA4t2KB8XNTmroUAxTmd8wAyOcoBsWNZZERwNVoOlx9F2eXjuL9Ql
 shM5myXzRsmdE/lCVDc+qbq80HMbXFrQLcpgNZE6l15Ahx3AEtV6KlamS
 8MSs23Eer6vaKRvJZ0zDs4W9HmdgsLbXPlA6xWfkUd+Eqt+puCfrRwb9a A==;
X-CSE-ConnectionGUID: XMEfipIBRvaY2QTPig5oXw==
X-CSE-MsgGUID: fPibITHZRf2WHu7gYAJkTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="29101237"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="29101237"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 05:29:10 -0700
X-CSE-ConnectionGUID: 4FassazaS6CBTnaC9ALH8A==
X-CSE-MsgGUID: d5R9Ej9kRfCkJTP2osMhWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="54533618"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 15 Jul 2024 05:29:08 -0700
Date: Mon, 15 Jul 2024 20:44:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
Message-ID: <ZpUZwfH7OWvlXj08@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-8-zhao1.liu@intel.com>
 <01245850-b5df-4bf6-9a22-775d12fc07a0@linaro.org>
 <ZpT1iy5NPqwjqaLB@intel.com>
 <487ea08d-d374-4591-bb68-b29e50013864@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487ea08d-d374-4591-bb68-b29e50013864@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jul 15, 2024 at 02:07:00PM +0300, Michael Tokarev wrote:
> Date: Mon, 15 Jul 2024 14:07:00 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
> 
> 15.07.2024 13:10, Zhao Liu wrote:
> ...
> > Thanks Philippe! I'll wait patch 1's comment, after that I can post a
> > new version with the change you mentioned.
> 
> I don't think either of this is necessary.  Patch 1 LGTM, and I'll
> drop the comment while applying.
> 

Many thanks!


