Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E288EC3814E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPz4-00040Y-EF; Thu, 04 Jul 2024 13:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPz2-00040Q-QV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:11:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPz1-0007hc-1s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:11:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNSQ1d8dz6JBH9;
 Fri,  5 Jul 2024 01:10:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FEEC1409EA;
 Fri,  5 Jul 2024 01:10:56 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:10:55 +0100
Date: Thu, 4 Jul 2024 18:10:54 +0100
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
 <dave.jiang@intel.com>, "Dan Williams" <dan.j.williams@intel.com>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704181054.00001f67@Huawei.com>
In-Reply-To: <20240704072646.437579-1-horen.chuang@linux.dev>
References: <20240704072646.437579-1-horen.chuang@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  4 Jul 2024 07:26:44 +0000
"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

> The current memory tier initialization process is distributed across
> two different functions, memory_tier_init() and memory_tier_late_init().
> This design is hard to maintain. Thus, this patch is proposed to reduce
> the possible code paths by consolidating different
> initialization patches into one.
> 
> The earlier discussion with Jonathan and Ying is listed here:
> https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/
> 
> If we want to put these two initializations together, they must be
> placed together in the later function. Because only at that time,
> the HMAT information will be ready, adist between nodes can be
> calculated, and memory tiering can be established based on the adist.
> So we position the initialization at memory_tier_init() to the
> memory_tier_late_init() call. Moreover, it's natural to keep
> memory_tier initialization in drivers at device_initcall() level.
> 
> If we simply move the set_node_memory_tier() from memory_tier_init()
> to late_initcall(), it will result in HMAT not registering
> the mt_adistance_algorithm callback function, because
> set_node_memory_tier() is not performed during the memory tiering
> initialization phase, leading to a lack of correct default_dram
> information.
> 
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
> 
> This patchset is based on commits <cf93be18fa1b> ("memory tier: create
> CPUless memory tiers after obtaining HMAT info") and
> <a72a30af550c> ("memory tier: dax/kmem: introduce an abstract layer for
> finding, allocating, and putting memory types"):
> [0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


