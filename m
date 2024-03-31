Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4256CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 20:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr1Zx-0000E9-6B; Sun, 31 Mar 2024 16:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sj@kernel.org>) id 1rr0YN-0005vd-Gq
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 15:09:15 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sj@kernel.org>) id 1rr0YL-0005gK-DX
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 15:09:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1694FCE0B3B;
 Sun, 31 Mar 2024 19:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A7C433C7;
 Sun, 31 Mar 2024 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711912140;
 bh=v/zuC8dt4PV8gMPcCnVwh1IagNNndASoACR2DPKF6zg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EkdU9EiU/fOn+VGtH/tMC4xLPQef/k8wjFWti0XMQjY0ZC+CwZadjgwdsOnuiSFvw
 xPviXDAw+R09SJt/zL1282C9RYbrWZujNgIu13gna1VsZUMsilrog1MuCyndMg90jK
 lSN7+qQFSB18Qru/PmhPexFbSbL/AZ6BJLjFFB49RRi2WZvV/NX00if0UIeggw3ap/
 aCdVgYMQmXvS2iKJAx+VPbDgaQjccZ+aQPZbOtAsmH8KrnMRMqubWTturx7IEni3/d
 oWhO8Gsuegc5AQVQDzgSjEth8LXHD3AnBaFIz6b41Onab2Mhk+86ujvXyomS1dCkke
 6DLAsl7U8CMRg==
From: SeongJae Park <sj@kernel.org>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: SeongJae Park <sj@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 1/2] memory tier: dax/kmem: introduce an abstract layer
 for finding, allocating, and putting memory types
Date: Sun, 31 Mar 2024 12:08:57 -0700
Message-Id: <20240331190857.132490-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329053353.309557-2-horenchuang@bytedance.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sj@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Mar 2024 16:14:51 -0400
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

Hi Ho-Ren,

On Fri, 29 Mar 2024 05:33:52 +0000 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Since different memory devices require finding, allocating, and putting
> memory types, these common steps are abstracted in this patch,
> enhancing the scalability and conciseness of the code.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  drivers/dax/kmem.c           | 20 ++------------------
>  include/linux/memory-tiers.h | 13 +++++++++++++
>  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 18 deletions(-)
> 
[...]
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..a44c03c2ba3a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);
> +void mt_put_memory_types(struct list_head *memory_types);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	return NULL;
> +}
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +
> +}

I found latest mm-unstable tree is failing kunit as below, and 'git bisect'
says it happens from this patch.

    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    [11:56:40] Configuring KUnit Kernel ...
    [11:56:40] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:In file included from .../mm/memory.c:71:
    .../include/linux/memory-tiers.h:143:25: warning: no previous prototype for ‘mt_find_alloc_memory_type’ [-Wmissing-prototypes]
      143 | struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
    .../include/linux/memory-tiers.h:148:6: warning: no previous prototype for ‘mt_put_memory_types’ [-Wmissing-prototypes]
      148 | void mt_put_memory_types(struct list_head *memory_types)
          |      ^~~~~~~~~~~~~~~~~~~
    [...]

Maybe we should set these as 'static inline', like below?  I confirmed this
fixes the kunit error.  May I ask your opinion?

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index a44c03c2ba3a..ee6e53144156 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -140,12 +140,12 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
        return -EIO;
 }

-struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
 {
        return NULL;
 }

-void mt_put_memory_types(struct list_head *memory_types)
+static inline void mt_put_memory_types(struct list_head *memory_types)
 {

 }


Thanks,
SJ

