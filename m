Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 14:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxooo-0005DD-6q; Fri, 19 Apr 2024 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxooQ-00056E-DS
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:01:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rxooN-0003T7-Cz
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:01:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLbsq4rHjz6K8x1;
 Fri, 19 Apr 2024 22:01:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E2C3E140B2A;
 Fri, 19 Apr 2024 22:01:36 +0800 (CST)
Received: from localhost (10.48.153.65) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 15:01:36 +0100
Date: Fri, 19 Apr 2024 15:01:34 +0100
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@gmail.com>, <qemu-devel@nongnu.org>, Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Message-ID: <20240419150134.000032ff@Huawei.com>
In-Reply-To: <20240405000707.2670063-3-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.65]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri,  5 Apr 2024 00:07:06 +0000
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> The current implementation treats emulated memory devices, such as
> CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
> (E820_TYPE_RAM). However, these emulated devices have different
> characteristics than traditional DRAM, making it important to
> distinguish them. Thus, we modify the tiered memory initialization process
> to introduce a delay specifically for CPUless NUMA nodes. This delay
> ensures that the memory tier initialization for these nodes is deferred
> until HMAT information is obtained during the boot process. Finally,
> demotion tables are recalculated at the end.
> 
> * late_initcall(memory_tier_late_init);
> Some device drivers may have initialized memory tiers between
> `memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
> online memory nodes and configuring memory tiers. They should be excluded
> in the late init.
> 
> * Handle cases where there is no HMAT when creating memory tiers
> There is a scenario where a CPUless node does not provide HMAT information.
> If no HMAT is specified, it falls back to using the default DRAM tier.
> 
> * Introduce another new lock `default_dram_perf_lock` for adist calculation
> In the current implementation, iterating through CPUlist nodes requires
> holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
> trying to acquire the same lock, leading to a potential deadlock.
> Therefore, we propose introducing a standalone `default_dram_perf_lock` to
> protect `default_dram_perf_*`. This approach not only avoids deadlock
> but also prevents holding a large lock simultaneously.
> 
> * Upgrade `set_node_memory_tier` to support additional cases, including
>   default DRAM, late CPUless, and hot-plugged initializations.
> To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
> handle cases where memtype is not initialized and where HMAT information is
> available.
> 
> * Introduce `default_memory_types` for those memory types that are not
>   initialized by device drivers.
> Because late initialized memory and default DRAM memory need to be managed,
> a default memory type is created for storing all memory types that are
> not initialized by device drivers and as a fallback.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

