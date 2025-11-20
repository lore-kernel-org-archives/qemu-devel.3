Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D20CF8861
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5iH-00036t-SV; Thu, 20 Nov 2025 09:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5iG-00035n-BV; Thu, 20 Nov 2025 09:32:44 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5iE-0006X6-Uy; Thu, 20 Nov 2025 09:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649163; x=1795185163;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8p5BU/PNBU0Ifp6tqvnI7Xm0gUktsLgYRPE5lSj1HzQ=;
 b=GNviRFOyMe0CoEqEKMy1qS3TL/iR+HO5XGFy+hJhBzKnHbOdfuEo69g7
 J7c6YZugicc2iqpMv6nkpsWyB6F/w5Ng5fOdEGgat3JRtCwANWhxM/DET
 3hQ5z+hBlZPTgKjM7Mtz2PSV7sEY0PgE6lQ2fPVwxNHECNbw2Vd5m8JYa
 WhDQJ40w/5feN4Q9nwl/RpaziGh8CxYrQsD3W8vGkH/7fReLRYRR518fi
 9Ej6G4nsIS6co/XgEvr5Nbwba4YVRNYREcrezOzHws1NZ9+PDg8s43pcP
 +uflGuq3W9Ph6iGSWUoOmN1KVUThLJ41pMf+RNPu3OxKEcV8PHnabo2Y9 w==;
X-CSE-ConnectionGUID: 5q+mZuENTaSeorqITs59Ug==
X-CSE-MsgGUID: deQeZZRjTKG7BzE/xDvmyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69335887"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="69335887"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:32:40 -0800
X-CSE-ConnectionGUID: zqy/H3FmTvG0yY2xg8n9SA==
X-CSE-MsgGUID: 2boN41jpSnqTQwUO/BTgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="222027958"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 20 Nov 2025 06:32:32 -0800
Date: Thu, 20 Nov 2025 22:54:51 +0800
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
Subject: Re: [PATCH 2/5] hw/nvram/xlnx-bbram: More idiomatic and simpler
 error reporting
Message-ID: <aR8ruxdVFa/XdQo7@intel.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-3-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 02:08:52PM +0100, Markus Armbruster wrote:
> Date: Wed, 19 Nov 2025 14:08:52 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 2/5] hw/nvram/xlnx-bbram: More idiomatic and simpler error
>  reporting
> 
> bbram_bdrv_error() interpolates a "detail" string into a template with
> error_setg_errno(), then reports the result with error_report().
> Produces error messages with an unwanted '.':
> 
>     BLK-NAME: BBRAM backstore DETAIL failed.: STERROR
> 
> Replace both calls of bbram_bdrv_error() by straightforward
> error_report(), and drop the function.  This is less code, easier to
> read, and the error message is more greppable.
> 
> Also delete the unwanted '.'.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/nvram/xlnx-bbram.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


