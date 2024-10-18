Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A8DD2FFE1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jVp-0000az-Db; Fri, 18 Oct 2024 05:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jVo-0000aR-60
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:43:12 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jVm-0001oc-PX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244591; x=1760780591;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UQuq5A1z/MNlbur7Ltl6uq9ORRqaDncA2p1pjqgOigY=;
 b=WO0o3IqTWlpwnd+YrhC1sQa9wT/X/BzWyVramsMW5/u8D+k7ZyOpFMYW
 t8vqQqj82Cj8Bw1nS3P+WEDMvVg4MdkxmzKkEj/9l2al0qo8Fd5YLSBkE
 pbI1frSp74xPfYoituQqNArkyA/I3WDUBMvMr+Gh358yGyQNunjD2Koie
 PjR/8sfXnwkaq3MlBuOg6Wpd8zJuv35vjH7dMDDHOnaXQ86RRGkNgS63+
 c3agpT1iCiCU0II1itNneqElKikD+SO8mL862CpOmRNm/p+yI4vrdEOQx
 UXncWZtyG0u0+AZIL/nwLSS5CZdneUuhGxIozS8k703WxgONoE3/hC0v3 w==;
X-CSE-ConnectionGUID: /ZZ0TPfbQZi6RoLp6v/KHw==
X-CSE-MsgGUID: ywJbLg6cQUyeruvZ1WioMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28558668"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28558668"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:43:09 -0700
X-CSE-ConnectionGUID: xj6eWwiDQ224HGBfPYCa8A==
X-CSE-MsgGUID: aMn+OGoPQu+uA+QDwiOqWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="79237392"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 18 Oct 2024 02:43:08 -0700
Date: Fri, 18 Oct 2024 17:59:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 15/31] qga: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIxez6JMYx3Owe0@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-16-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-16-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 17, 2024 at 12:33:27PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:27 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 15/31] qga: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qga/guest-agent-core.h | 2 +-
>  qga/main.c             | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


