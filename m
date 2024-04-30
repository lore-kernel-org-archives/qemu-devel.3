Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C9DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 21:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1uai-0006VF-Go; Tue, 30 Apr 2024 17:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1s1uad-0006Ut-Se
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:00:40 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1s1uaa-0003BO-R8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714510836; x=1746046836;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vdWN7QRH0YXJmkbLF+hixAQIFdQAmc9j6LgT2dm/sKo=;
 b=mxyYaODNtfnxf1d+m0G7b//QIl3K9EHQW33OcYDHmo4sp6vw1LqhBu4P
 fIGTjlzOHZLrQecfHm43Xi/RLYn8V1/7qh+KqUQfNN9KUOkJz531JXb7U
 4xAk1EA9NRSE9Qx7XEKqyMOqzVFNGu2pkDsdbqExvP2VGUglg08nNbtdO
 UflJFKOC/osLt5SYR9vAm1uv+kwVdfFjAm7FK+AmPSIbpxOecvPaviFJH
 i8tU37K3S/sqtIgC4S4GYXZDYQVXbWBFWiu/oebofWeGBIz0ZggxE1/4d
 WvoFHWmu0O+HD8EjQxGiuJSD+60dxKKc1m+cB1+zvhRggQPNc2NVbRP06 Q==;
X-CSE-ConnectionGUID: WH0VwiANR5Kh/XIkzTHaqg==
X-CSE-MsgGUID: rH5vMIuYQo+PlcdwSHMUKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21390711"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; d="scan'208";a="21390711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 14:00:32 -0700
X-CSE-ConnectionGUID: tpGZ1fq7SomA55V7CuCaRg==
X-CSE-MsgGUID: x0D8q4GfSfmds34g6CSnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; d="scan'208";a="57474316"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2)
 ([10.251.17.48])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 14:00:32 -0700
Date: Tue, 30 Apr 2024 14:00:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=alison.schofield@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Hi Ruan,

This fixup is important for the Event DPA->HPA translation work, so I
grabbed it, updated it with most* of the review comments, and posted
with that set. I expect you saw that in your mailbox.

DaveJ queued it in a topic branch for 6.10 here:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.10/dpa-to-hpa

*I did not create a common mask for events and poison because I wanted to
limit the changes. If you'd like to make that change it would be welcomed.

-- Alison

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
> -- 
> 2.34.1
> 

