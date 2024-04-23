Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0CDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKAZ-0002TN-47; Tue, 23 Apr 2024 13:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rzKAX-0002T1-1X
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:43:01 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rzKAP-0005OG-TQ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713894174; x=1745430174;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ock0VCrBpI7qAgfi6oLSfb/6Aqj77P5qLwRspEkgA+0=;
 b=bXo2uPxbz48p5O8Wab5pDLB0Sh0HPLwR5ZdsKM8v1/JhDFp0zMT0toH2
 zog3yByewdfxL/1CRUcE0hNO3FTczjOEjovFSyHf1O+aZkH574xPHe1oH
 NNha0TXRzGSwk0rzBOWYQZ9Zqv/U1RpxbGgKspYeykRYWd9dD85zhgjj3
 j4a3UwwOWbSmQPGI5bzKs05VrldEb1GZe/cmLFrryGRcZAC4XbjdDRsSn
 xr0En7toQq9frMI+RyXOyMUcZGX6wksSjtnbSwMgkeHNdQr+AtZB3C10S
 8HF5UNH2j5+PKBXdiGYeuHu1Yqjxh87j+i5PXirq2zvqhY+OgKRD3oXYz A==;
X-CSE-ConnectionGUID: F5VxsoEyRz2h12a8f6HsEA==
X-CSE-MsgGUID: XM4GDATVRlm8DoY90NU31w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20190154"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="20190154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 10:42:49 -0700
X-CSE-ConnectionGUID: 8ZFtQpYoRle0DVMZKA1F/A==
X-CSE-MsgGUID: ypecsz0uS+eYg2VyLCsuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="24321377"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2)
 ([10.209.29.57])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 10:42:49 -0700
Date: Tue, 23 Apr 2024 10:42:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <ZifzF8cXObFiDiIK@aschofie-mobl2>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=alison.schofield@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 

So, an invalid DPA is emitted in the trace event log and that could
lead to 'incorrect page retirement decisions...'

> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..cdfce932d5b1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)

This works but I'm thinking this is the time to convene on one 
CXL_EVENT_DPA_MASK for both all CXL events, rather than having
cxl_poison event be different.

I prefer how poison defines it:

cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)

Can we rename that CXL_EVENT_DPA_MASK and use for all events?

--Alison

> -- 
> 2.34.1
> 

