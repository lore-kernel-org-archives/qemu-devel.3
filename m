Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F09C4829D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 00:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZgXA-00082h-Dn; Mon, 12 Feb 2024 19:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rZgX8-00082X-UX
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 19:20:22 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rZgX6-00053p-Gm
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 19:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707783621; x=1739319621;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rXqBG2xEQQHC3OE/2/MNY2l1cdoK9SxwhRmgdu82Jw0=;
 b=R75BhPGRP6q4lT8GK203on6J/m9kYF5aex1y6lwH7Qa1Evdb6Vxp+6zD
 m/KEj63QwHhFy5+bpchrnURhhsYRNts3IJ+AdBRhqRkN4U/xqH8B+fsZ5
 rgWJKRkUxq5uZv7/dc+wSbrPda9bp3HIdfRHQr728jqJZBtwnTKCfkMyh
 T6Go8vmD9lbibM/j8c3Hs/Vtl/duFjBham8WqQCjAeZvkuhsnyDXqj+Jy
 gh9I/wkA+FY5ryFywYXKkQCBZh8Pq+lKoM4Jnj477rXPPmo7MWLgU75p0
 9r38timD/kqAXT9OEwZYd1Jmjf/Wi1oS9l69rghgmk7BoFTkV5CbqzziI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24251020"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; d="scan'208";a="24251020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2024 16:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935210031"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; d="scan'208";a="935210031"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.42])
 ([10.246.113.42])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2024 16:20:13 -0800
Message-ID: <fd03964a-0b16-42f3-8572-0a7686beda93@intel.com>
Date: Mon, 12 Feb 2024 17:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH SET] cxl: add poison event handler
Content-Language: en-US
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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



On 2/9/24 4:54 AM, Shiyang Ruan wrote:
> Currently driver only trace cxl events, poison injection on cxl memdev
> is silent.  OS needs to be notified then it could handle poison range
> in time.  Per CXL spec, the device error event could be signaled through
> FW-First and OS-First methods.
> 
> This draft patchset adds poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record
>   - CXL driver
>     a. read the POISON event through GMER;
>     b. get POISON list;
>     c. translate DPA to HPA;
>     d. construct a mce instance, then call mce_log() to queue this mce
>        instance;
> 
> This patchset includes 2 patches for qemu, 5 patches for cxl driver.

Hi Ruan,
Next time please split this out and post as 2 different series. You can have the CXL driver series cover letter reference the QEMU changes. And please add QEMU to subject prefix for the QEMU patches. Thank you!

> 
> Shiyang Ruan (5):
>   cxl/core: correct length of DPA field masks
>   cxl/core: introduce cxl_memdev_dpa_to_hpa()
>   cxl/core: introduce cxl_mem_report_poison()
>   cxl/core: add report option for cxl_mem_get_poison()
>   cxl/core: add poison injection event handler
> 
>  arch/x86/kernel/cpu/mce/core.c |  1 +
>  drivers/cxl/core/mbox.c        | 82 +++++++++++++++++++++++++++-------
>  drivers/cxl/core/memdev.c      | 16 ++++++-
>  drivers/cxl/core/region.c      |  8 ++--
>  drivers/cxl/core/trace.h       |  6 +--
>  drivers/cxl/cxlmem.h           | 11 ++---
>  drivers/cxl/pci.c              |  4 +-
>  7 files changed, 97 insertions(+), 31 deletions(-)
> 

