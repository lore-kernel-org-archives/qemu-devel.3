Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A3CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 01:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKpe0-0008GA-Iu; Fri, 21 Jun 2024 21:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akpm@linux-foundation.org>)
 id 1sKpdz-0008G0-M3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 21:34:19 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akpm@linux-foundation.org>)
 id 1sKpdx-0003tN-Dr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 21:34:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5FCD96257F;
 Sat, 22 Jun 2024 01:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16263C2BBFC;
 Sat, 22 Jun 2024 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1719020055;
 bh=qm2vMyK4qA3/y0Ko7/pKvfxx5RuC8dDvYU8t1o6RE0M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sDqwaRZLFfHd0f1KM1T9LFUkgNQ3fBnIJdbjPE/4sd9gdDOOCgF2/9GQpF8iF2ZlL
 gnrSdzqtK3iQ4xxFCtE49X5p5HjU0AFeCnkcB+Juai0z+YfstoWZyvB4nG/fTZcDFt
 4rOwheB3ecFSZ+f7JM2Z6NNVqXqvsmNczKzfjZ4E=
Date: Fri, 21 Jun 2024 18:34:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
Cc: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, "Gregory Price" <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>, "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>, "SeongJae Park"
 <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of
 memory tiers
Message-Id: <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
In-Reply-To: <20240621044833.3953055-1-horen.chuang@linux.dev>
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=akpm@linux-foundation.org; helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.465,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Fri, 21 Jun 2024 04:48:30 +0000 "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

> If we simply move the set_node_memory_tier() from memory_tier_init() to
> late_initcall(), it will result in HMAT not registering the
> mt_adistance_algorithm callback function,

Immediate reaction: then don't do that!

> because set_node_memory_tier()
> is not performed during the memory tiering initialization phase,
> leading to a lack of correct default_dram information.
> 
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
> 
> Besides, since default_dram_type may be checked/used during the
> initialization process of HMAT and drivers, it is better to keep the
> allocation of default_dram_type in memory_tier_init().

What is this patch actually aiming to do?  Is it merely a code cleanup,
or are there functional changes?

> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> ---
> Hi all,
> 
> The current memory tier initialization process is distributed across two
> different functions, memory_tier_init() and memory_tier_late_init(). This
> design is hard to maintain. Thus, this patch is proposed to reduce the
> possible code paths by consolidating different initialization patches into one.

Ah, there it is.  Please make this the opening paragraph, not an aside
buried below the ^---$.

I'll await review input before proceeding with this, thanks.

