Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EF2CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 18:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGk1-00063h-2r; Fri, 29 Mar 2024 14:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqGjv-00062i-I3
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:14:07 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqGjs-0003c7-8s
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711736044; x=1743272044;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=spDdkp5at93t5uLpTXXyW7vLLkVTjvAI4OLZ+91XLjg=;
 b=Qr2M3s/h4XUAutvlAUj2jQzSADExoAEUiA+Kvz36RQPlFzxt1k3IoKh7
 NpDZLb4HRwoIz+ofyiyuRVLsegDMlv3+Yx+qgFP/EDdEIShby/E6U/0ws
 Xja2rqhLVzv3I4gRa4JRI4pigwa16WlwpbBnQjmCrSwVBXLdll5Y7JHyz
 526JCJDSbOcM+KWS7RwnpqVReeHfjVp9/i3s9mc2l14wVNNqy/H6GWLmv
 DKDU092kv4mC52xg/h+nh2sUk8LS25IT2cM5+no5FU51VIAHaJVxPCyyI
 jCBVOajk84hnxkOPqyaffMvVAxf5sXlGfn/OfpkneSLlvK3fzZ15vtJ5u w==;
X-CSE-ConnectionGUID: 1kYG4XQKRD2qAcQ8LNEpkQ==
X-CSE-MsgGUID: /AEHg2sPQIq9FPQBFDQb2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7151663"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7151663"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 11:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="48245285"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2)
 ([10.209.86.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 11:13:17 -0700
Date: Fri, 29 Mar 2024 11:13:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from
 debugfs
Message-ID: <ZgcEu9q/k+jjojOj@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=alison.schofield@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, Mar 29, 2024 at 02:36:12PM +0800, Shiyang Ruan wrote:
> Poison injection from debugfs is silent too.  Add calling
> cxl_mem_report_poison() to make it able to do memory_failure().

Curious as to why it is silent? Will a GMER poison event occur
and trigger the path to report it via memory_failure?

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/memdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e976141ca4a9..b0dcbe6f1004 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -366,6 +366,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> +	cxl_mem_report_poison(cxlmd, cxlr, &record);
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  	up_read(&cxl_region_rwsem);
> -- 
> 2.34.1
> 
> 

