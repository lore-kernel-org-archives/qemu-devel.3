Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E3BCF8863
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5k2-0004gt-GG; Thu, 20 Nov 2025 09:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5k1-0004eG-F5; Thu, 20 Nov 2025 09:34:33 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5jz-0006go-JS; Thu, 20 Nov 2025 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649272; x=1795185272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yPcH1deYy75uCsECvsB0OJbTIL54O9dmOmpsEpMttdo=;
 b=RoVTDXuy6hhrt+AEtRtE2cwmflz4dmelLWryNihjcQdw7sOLfUNkWHMG
 OsGifk1ROxvrvytKjGNCKKvf1KkUArSHYSceKpM7mlRe+1rb30x305DpI
 otwK8VnwNziymO8uSpGDNzI5OuW+Wik5VhBFmowHIVlmmP1irKDYwk/xV
 fVVBSbVV5rGKW6tOTG+Y82sEQ0pDSY+tIun4acDMjGGpqIWTT00MR9QbE
 aW/zhMULOSbiNbVUBazQap1+3b0yWD62I8ULzRyBnSjvprallRGUcB+5S
 l/3QzMdXUtD7+eXZ1u/5TtQ+6+6awhdXp/d9+z1QQMukvWuZyvbxhAsHD Q==;
X-CSE-ConnectionGUID: VIfjTFhgQTKE+GwEPv/9Wg==
X-CSE-MsgGUID: czabIKeLRWuEPslz37rkxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69336176"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="69336176"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:34:29 -0800
X-CSE-ConnectionGUID: 0vCE/3psQMyRUX3wO3xbCA==
X-CSE-MsgGUID: urw9h5M8Q0CbV8xchmpPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="222028345"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 20 Nov 2025 06:34:15 -0800
Date: Thu, 20 Nov 2025 22:56:34 +0800
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
Subject: Re: [PATCH 4/5] error: error_free(NULL) is safe, drop unnecessary
 conditionals
Message-ID: <aR8sIlSfRc93wTSh@intel.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-5-armbru@redhat.com>
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

On Wed, Nov 19, 2025 at 02:08:54PM +0100, Markus Armbruster wrote:
> Date: Wed, 19 Nov 2025 14:08:54 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 4/5] error: error_free(NULL) is safe, drop unnecessary
>  conditionals
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/acpi/pcihp.c             | 4 +---
>  io/channel-websock.c        | 4 +---
>  io/task.c                   | 4 +---
>  migration/migration.c       | 6 ++----
>  tests/unit/test-smp-parse.c | 5 +----
>  5 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


