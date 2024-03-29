Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DBECD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 19:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqI3N-0005RX-2r; Fri, 29 Mar 2024 15:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqI3J-0005RJ-N3
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 15:38:15 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqI3G-0003lL-Ka
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 15:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711741090; x=1743277090;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+vKbkzFZ4eZd1MQh5+5s+z854meqlngn22v4O+87I90=;
 b=QsLWq0bPOT9Ebb52sTS+O8YeRJKh7QHn3ZikCNlHH7KdDFhGIW+Xww0a
 5F2x8x3F5hxUqYqWmdfJXsDmXQFLg4CfZ+LQ1qYEzoPZ1miPGVG1criLp
 UWA2vU6q3Kest4beigjHT49Wa7pN3h4rVT5vBTvEv1ezxalBEHCJKLN81
 4k2BVaSQK3kp8XFRdwh9/5x19E9IYaTFrJzU+oxOs1NK6rxOaGFfAmBkI
 lTXo9Tl/kZFe6VcjjV1haGjNqnKWyz+WYl2lpNb8wHp9c2JiKclYiLCSz
 Vf69mdAPHi+yd6tfDbh3ljgP91lICgyIquR4sY2VcFfHfihWDQbhxyI6j w==;
X-CSE-ConnectionGUID: ezZ9WmrXRNOAU96ZdqWK5g==
X-CSE-MsgGUID: iAgHgGo4SnGTZRjh3siPpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="29422398"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="29422398"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 12:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="17042956"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2)
 ([10.209.86.126])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 12:38:06 -0700
Date: Fri, 29 Mar 2024 12:38:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
 dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <ZgcYnCr19aVhCO93@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
 <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Received-SPF: pass client-ip=198.175.65.9;
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

On Fri, Mar 29, 2024 at 11:22:32AM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> [..]
> > Upon receipt of that new poison list, call memory_failture_queue()
> > on *any* poison in a mapped space. Is that OK?  Can we call
> > memory_failure_queue() on any and every poison report that is in
> > HPA space regardless of whether it first came to us through a GMER?
> > I'm actually wondering if that is going to be the next ask anyway -
> > ie report all poison.
> 
> memory_failure_queue() should be called on poison creation events. Leave
> the MF_ACTION_REQUIRED flag not set so that memory_failure() performs
> "action optional" handling.  So I would expect memory_failure_queue()
> notification for GMER events, but not on poison list events.

Seems I totally missed the point of this patch set.
Is it's only purpose to make sure that poison that is injected gets
reported to memory_failure?

So this single patch only:
1. Poison inject leads to this GMER/CXL_EVENT_TRANSACTION_INJECT_POISON 
2. Driver sees GMER/CXL_EVENT_TRANSACTION_INJECT_POISON and reads poison
list to get accurate length.
3. Driver reports that to memory_failure_queue()

Still expect there's some code sharing opportunities and I still wonder
about what is next in this area.

--Alison


