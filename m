Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792C6D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jcY-0007Yq-0M; Fri, 18 Oct 2024 05:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jcW-0007Yf-FY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:50:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jcU-0002be-DN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245007; x=1760781007;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=keBIetwaVJRonVGv7gyfRe5rqOyEaYKmb91WiBZqkoQ=;
 b=mkxbwu5/ay6G0qo6DVJmpmM/WHA41mznMtEKfMmCnHhRtEkY4iy0K2Xi
 4OPtSgMdqgN1DQIPh1H65DrL3bE5fgExPQ7b22WmVvIeL/6X9JM3GKVMj
 eW1h4nlPEr6MFIYpCR4eOP+b9EnFw6kwPyVQ7l/4z2jZ9sC9LEEsd5dSA
 VsTxH6AIJ8kx1djDeWVvHcIdSh0C+RbjPHNDnWx5pqJIYFmBOMxEHz+LX
 JYpG7efFKkS0wC33bGwh6GE877TBG/Ipd9k9TmaubWnBKP/YzlbafUUX6
 GwW0nEoY1g6CirU+1fA0wopgctzhVhXQGyiK7HsYTiJI2DjloV+gQGaih g==;
X-CSE-ConnectionGUID: IgGFCnQdQu20vXNtDVE81A==
X-CSE-MsgGUID: qgIvJI89SmmHmqgOLqmWkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28922218"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28922218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:50:04 -0700
X-CSE-ConnectionGUID: DIRbAyDWQRCetzyRJIMh4g==
X-CSE-MsgGUID: jl7Wk/iwRpCr+7yKZFhEew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78778000"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 02:50:03 -0700
Date: Fri, 18 Oct 2024 18:06:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 23/31] system: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIzGtYb6nsk38A5@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-24-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-24-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

Hi Daniel,

On Thu, Oct 17, 2024 at 12:33:35PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:35 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 23/31] system: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/device_tree.c       | 2 +-
>  system/dirtylimit.c        | 2 +-
>  system/qdev-monitor.c      | 6 +++---
>  system/rtc.c               | 1 +
>  system/runstate-hmp-cmds.c | 2 +-
>  system/vl.c                | 6 +++---
>  6 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/system/rtc.c b/system/rtc.c
> index 216d2aee3a..e3bc2095f9 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"

Is this a typo?

>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/timer.h"

Regards,
Zhao


