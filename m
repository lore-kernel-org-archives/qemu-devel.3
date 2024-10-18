Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE7D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jSm-00065o-4e; Fri, 18 Oct 2024 05:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jSj-00064q-7E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:40:01 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jSh-0001Lc-UY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244400; x=1760780400;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OMNOjeB+z702vWWH/X5SdpIrPa9R5ovN/1+pSIlTNIM=;
 b=AHPTIyaFxmNspoQQmfrMet1xLhDYH2Q6gPk1LdLYje79lBpnB4f9rYS7
 uA3Z0+093CPe8DGymc13UsksoDiWaV0D4VELOQt96PS1GVbXny9yKKKs4
 0WxsA2BZ73xRUYHZRGWYOBbrhXwU4jN+3n5lVbdWTipC+Aq5KK5sxELpD
 4OvF0Z8NCYwo8u0SvPuQLgVg2w6J2hmwh9WobMf3TLq1HA21ssBUM3M+4
 V4+QUohSsTs3n6VnANW2wy24IOoS/kgqnnnkQnXS4cxeH5aezkaKSOqde
 SZ7fCm/TjL+UUoC7Kl6eY2d5Rh2OtjPnJpJbXdkiCGLvRooF/h2pudIk/ Q==;
X-CSE-ConnectionGUID: DZbe5DsHQEW9SZxRGEi7bw==
X-CSE-MsgGUID: Zydhm3CNRyyYuWAZWn+5Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28558464"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28558464"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:39:58 -0700
X-CSE-ConnectionGUID: J69q8Q0XSZeW654cCtnsoA==
X-CSE-MsgGUID: DAOSQ7HQT0+uisAT9rjUgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="79236292"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 18 Oct 2024 02:39:57 -0700
Date: Fri, 18 Oct 2024 17:56:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 11/31] migration: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIwvHso/asZdscz@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-12-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-12-berrange@redhat.com>
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

On Thu, Oct 17, 2024 at 12:33:23PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:23 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 11/31] migration: adapt to new import path for qobject
>  data type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  migration/dirtyrate.c          | 2 +-
>  migration/migration-hmp-cmds.c | 2 +-
>  migration/migration.c          | 2 +-
>  migration/migration.h          | 2 +-
>  migration/options.c            | 2 +-
>  migration/vmstate.c            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


