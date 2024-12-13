Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE60E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvF4-00055G-Jc; Thu, 12 Dec 2024 21:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLvF2-00051v-T6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:17:21 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLvEz-0007kh-P3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734056238; x=1765592238;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6v6IK8e6GTjV62O9Xce89aJRqqN9VTHtXnDFsGTJg3U=;
 b=Qdhpocp7LglxgzziRSnC030eKzBHPrCO9F60NBzyjQXQIfO9p9REe0NU
 Pvaj5dZB8fq37mEKz/4XBkZzxUSs4psIlExkQDuK3DHqh3pxGzw3St0BH
 FJ/JpZhuexFO4Nw2ga/2r86QS487L0i6qNSOP+xDzKDNDg1BUuB6it84z
 Qd29qQKoOw0Rzg9QVwLz0vBuXkqVK7PoKTP8o94Lnv3p1g8gIq391gcPU
 iZQy9u/rH94yEDj2NxUREX3v4NREY0q+zD1AQbhIXzwTkgGg9aj46rYaZ
 VF9BYijDMhOXobXZon59CRk4dfnp7Lr7+1sjiIu9zy04tluYvkAVSTg5n Q==;
X-CSE-ConnectionGUID: FMhXA1hZRxu2A4rsdIWwpA==
X-CSE-MsgGUID: qK2/nc55SMWcOAE+LdiAhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45190270"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="45190270"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 18:17:14 -0800
X-CSE-ConnectionGUID: KlcUobjGSN2REGqwyFKszw==
X-CSE-MsgGUID: O3V+xvR7Rwuhzi7Mki23mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="97206121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 12 Dec 2024 18:17:14 -0800
Date: Fri, 13 Dec 2024 10:35:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, binbin.wu@linux.intel.com
Subject: Re: [PATCH] kvm: consistently return 0/-errno from kvm_convert_memory
Message-ID: <Z1udcRGw8ay6pHzX@intel.com>
References: <20241212155719.524637-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212155719.524637-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 12, 2024 at 04:57:19PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 16:57:19 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] kvm: consistently return 0/-errno from kvm_convert_memory
> X-Mailer: git-send-email 2.47.1
> 
> In case of incorrect parameters, kvm_convert_memory() was returning
> -1 instead of -EINVAL.  The guest won't notice because it will move
> anyway to RUN_STATE_INTERNAL_ERROR, but fix this for consistency and
> clarity.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


