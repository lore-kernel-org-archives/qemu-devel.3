Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC87FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVGW-00059L-P4; Mon, 26 Feb 2024 02:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1reVGU-00058G-NA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:19:06 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1reVGS-00081L-8h
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708931944; x=1740467944;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=8A/jJ2m/3qZZONrgehnuQgaoG3GipGohMVn4Zn5LewU=;
 b=mlBecbhsZkIxW8Aw9R5j1BiAmUQ0sv+v4wDBkRimrk786g3B8/K0TPGi
 MXdVHPzXQBn8xG/TNzJOYk5GlW0ZH4rG5pwNsS9rUyXSBDlW6TC2FCOFZ
 UXEgLZn1XdMmmJo7ud6+aR/gQCjVY3bL+esgQPLW9NrMkkuTLTA1NZgyO
 mMTM6wTBAj1A3il/4EhctD3u07T4Q7UfWxteFlMVIZwpspKKCcetiogk/
 K9uMjPRy6iMM4eDfyvH3mZPl1h9tUphmp0sOxliuMmSHQlNSuFDgaCfqU
 XtlMb32Q4VIo4xK/zWv5A7hNDaDyWulADtQnHpz5gY+fTsBVJAjJnYth/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13895119"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13895119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6713886"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.212.40])
 ([10.238.212.40])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:18:58 -0800
Message-ID: <53205040-fd1b-4ced-abd8-fde5275d472f@intel.com>
Date: Mon, 26 Feb 2024 15:18:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] migration/multifd: Add new migration option
 zero-page-detection.
To: Hao Xiang <hao.xiang@bytedance.com>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <20240216224002.1476890-2-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/17/2024 6:39, Hao Xiang wrote:
> This new parameter controls where the zero page checking is running.
> 1. If this parameter is set to 'legacy', zero page checking is
> done in the migration main thread.
> 2. If this parameter is set to 'none', zero page checking is disabled.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  hw/core/qdev-properties-system.c    | 10 ++++++++++
>  include/hw/qdev-properties-system.h |  4 ++++
>  migration/migration-hmp-cmds.c      |  9 +++++++++
>  migration/options.c                 | 21 ++++++++++++++++++++
>  migration/options.h                 |  1 +
>  migration/ram.c                     |  4 ++++
>  qapi/migration.json                 | 30 ++++++++++++++++++++++++++---
>  7 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 1a396521d5..63843f18b5 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode = {
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };
>  
> +const PropertyInfo qdev_prop_zero_page_detection = {
> +    .name = "ZeroPageDetection",
> +    .description = "zero_page_detection values, "
> +                   "multifd,legacy,none",

Nit: Maybe multifd/legacy/none?

