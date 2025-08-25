Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B49CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqY5u-0007S0-3I; Mon, 25 Aug 2025 10:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqY5m-0007ON-FY
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:22:39 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqY5f-0000Dm-Pk
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756131752; x=1787667752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7Do+ue8SHojf7E+VRb/MMBabPlqhd0kgEyJpk4hARig=;
 b=ikaWkhmp+6OpD/oPpw3UAv0rKKZdzz7u8BPOle77+xzFFbVs+CQP/n/i
 7VJhYgdQSTWMU52eBZcSpAf73JWeKpuiL9Tbw8N/60AxdH55ANaVZ/KyX
 CKmwpbZE2KAU1XaXl5x+qI5T5xdO+pwgzI77O6Y/2TEf0z176vZDa5OBU
 JpsGruj9WPUYHxMwMduNp3cHtqNvosj2DYX61QTbH6On9qjsPafcCBo7I
 9m/mzCc8ufGnE4sl7jQTx1JteFpUYP+kuim61pibjjeI6TbZO+GEk48TV
 z6pCPmlPDyocWFXFvjSE6Sw+w14ADmhBmEM77bueJa/TarT1jzVC36MAN g==;
X-CSE-ConnectionGUID: 4nRXqaE0QuG95e4dss7C0w==
X-CSE-MsgGUID: HIl458wmTdiyHVDxutXlYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="60976499"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="60976499"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 07:22:27 -0700
X-CSE-ConnectionGUID: aQ9x9LrgSdKk/csfV9q7Tw==
X-CSE-MsgGUID: 20s9UCpdQkWN0nq5ux/Mwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="168521033"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 25 Aug 2025 07:22:25 -0700
Date: Mon, 25 Aug 2025 22:44:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com
Subject: Re: [PATCH v4 4/8] hpet: move out main counter read into a separate
 block
Message-ID: <aKx2uwN8PnHsiV7p@intel.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-5-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814160600.2327672-5-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 06:05:56PM +0200, Igor Mammedov wrote:
> Date: Thu, 14 Aug 2025 18:05:56 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v4 4/8] hpet: move out main counter read into a separate
>  block
> 
> Follow up patche will switch main counter read to
> lock-less mode. As preparation for that move relevant
> branch into a separate top level block to make followup
> patch cleaner/simplier by reducing contextual noise
> when lock-less read is introduced.
> 
> no functional changes.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
>   * drop 'addr <= 0xff' as addr == HPET_COUNTER is sufficient
>      Peter Xu <peterx@redhat.com>
> ---
>  hw/timer/hpet.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


