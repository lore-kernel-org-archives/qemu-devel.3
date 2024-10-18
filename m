Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52269D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jjC-0001x3-VT; Fri, 18 Oct 2024 05:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jjA-0001np-Pu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:57:00 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jj7-0003DW-Pb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245418; x=1760781418;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WDQO2UX3UvyY9vwPgER423gii0g9dbmDhIXVJLaLDAQ=;
 b=D4BKk0oyXtu4gaeZniQk2jjGgfVPi4FP/9GT8mWOKO+kTOrN7guPH+Fk
 sCjFSxrsSTm03DjmO+f9DKcCuY9LnMfFxzbhRALLv/1quScbU0CBM8T1C
 sq0VKrdoqRsKL2HtuxVjrae8rHyLCeF5GuTVWkzeC1ZSyY1/0Pbg7R1cF
 OMjVQvcVjnXiUuhjBC9Z6VvcnSGzQfC5YU/1dAENNca0IiZGBGl0K4fQY
 iBBCuETBf2DSa7XoLIcXSkItGNZJJghmbcCUW09Dp3aCG462BzVEnKchy
 CZuWlxNY5aeSoPDjLXbNiN1Gq6YR64brf50ixees+vv+M1mpfKcDvKmx/ g==;
X-CSE-ConnectionGUID: JH26WxYvTiyuPTYdSBOkBw==
X-CSE-MsgGUID: +Izb2QZjSgCjPxqsv/sPjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28874028"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28874028"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:56:56 -0700
X-CSE-ConnectionGUID: +2mHIZI0T4CxprmKa19hAw==
X-CSE-MsgGUID: iaEPtiwDSOmRSqvGvMpVtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78866329"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2024 02:56:54 -0700
Date: Fri, 18 Oct 2024 18:13:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 28/31] util: adapt to new import path for qobject data
 type headers
Message-ID: <ZxI0tjPia+PV+X0s@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-29-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-29-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:40PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:40 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 28/31] util: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/keyval.c      | 6 +++---
>  util/qemu-config.c | 4 ++--
>  util/qemu-option.c | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


