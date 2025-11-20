Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71653CF8863
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5h2-00021R-BQ; Thu, 20 Nov 2025 09:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5gy-00020X-Ba; Thu, 20 Nov 2025 09:31:24 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5gw-0006Rx-1E; Thu, 20 Nov 2025 09:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649083; x=1795185083;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BJQ0ePr3LQV5SiK/Z+mX4/dVwor8ikb3J0AbLLg45uc=;
 b=RGpdj/Xxf8P+DPHI+VGrITTvTraO+WEDdNw/+HlVq+rVkR6YwP5J8CIQ
 8aRSi/9GXA6eE3kCTbdJP4NmKBJqkd6Ly4MaDzWmSwXq2o9pNKZs17lMu
 d+O7K6pUXxDOFotliv+eZtRUaKzYu4qx0w/HrMibGOm+3kXRFZjdmgz/N
 ZKhE03NN6K10SWdLJj5undNQWsPfVGqnycTGjgPVrLn1g0F8fx4kA2N8E
 aLLxRNtEHHYWlRPrzqTqgHYr26JeMmYzJQ4WDwdrk7zUzx8Tx5xTUB9ju
 l97qijFdQDuNTcDJiM471TnJK3g7MAHZ1ec02Nbz1+ARHAyie1CZj4hGS A==;
X-CSE-ConnectionGUID: GcyFchWIQA6SVsn9a27wQQ==
X-CSE-MsgGUID: F2Ajblc9RgOzHJ6H35kTiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65651091"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="65651091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:31:19 -0800
X-CSE-ConnectionGUID: IHUmIxu8STWCMdWRCOkkHQ==
X-CSE-MsgGUID: r9ZK/qnPSHODU6gCYG74XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="190664714"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 06:31:10 -0800
Date: Thu, 20 Nov 2025 22:53:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
Message-ID: <aR8rajtQm+kppR87@intel.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-2-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 02:08:51PM +0100, Markus Armbruster wrote:
> Date: Wed, 19 Nov 2025 14:08:51 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
>  simplify caller
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/loader.h |  4 +++-
>  hw/arm/boot.c       |  6 +-----
>  hw/core/loader.c    |  8 ++++++--
>  hw/riscv/spike.c    | 10 +---------
>  4 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


