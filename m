Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C1C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 06:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN4nv-00043E-Ko; Fri, 28 Jun 2024 02:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horen.chuang@linux.dev>)
 id 1sN4nr-00042r-T6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 02:09:48 -0400
Received: from out-188.mta1.migadu.com ([95.215.58.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horen.chuang@linux.dev>)
 id 1sN4np-0000o6-9u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 02:09:47 -0400
X-Envelope-To: jonathan.cameron@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1719554978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6gy0NOjp3fgzujNjn03YIvDzl9Fqj+1fNboTj9KDJII=;
 b=olAC4XjDPP/fIYuqIYhACcF5/4Q/28Tl5xNDSEpQwyykCTBPOuIffDA6Vg7OoyDUv/ACQE
 t2gRmiHkZ3W6SiC5zFK41pzhkDaP67L2UU8+WDsLIugF6N50jPTwOkvMeketPUCelsYeYv
 +ej74ibV2rxmx1qy02CHp5rhyLw7Ap4=
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: horen.chuang@linux.dev
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 "SeongJae Park" <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] memory tier: consolidate the initialization of memory
 tiers
Date: Fri, 28 Jun 2024 06:09:22 +0000
Message-Id: <20240628060925.303309-1-horen.chuang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.188;
 envelope-from=horen.chuang@linux.dev; helo=out-188.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

The current memory tier initialization process is distributed across
two different functions, memory_tier_init() and memory_tier_late_init().
This design is hard to maintain. Thus, this patch is proposed to reduce
the possible code paths by consolidating different
initialization patches into one.

The earlier discussion with Jonathan and Ying is listed here:
https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/

If we want to put these two initializations together, they must be
placed together in the later function. Because only at that time,
the HMAT information will be ready, adist between nodes can be
calculated, and memory tiering can be established based on the adist.
So we position the initialization at memory_tier_init() to the
memory_tier_late_init() call.

Moreover, it's natural to keep memory_tier initialization in drivers at
device_initcall() level.

- v2:
 Thanks to Huang, Ying's and Andrew's comments
 * Add cover letter
 * Add Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 * Add get/put_online_mems() protection in memory_tier_late_init()
 * If memtype is set, skip initializing its node
 * Remove redundant code/comments or rewrite code in a cleaner manner
- v1:
 * https://lore.kernel.org/all/20240621044833.3953055-1-horen.chuang@linux.dev/

This patchset is based on commits cf93be18fa1b and a72a30af550c:
[0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
[1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
[1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com

Ho-Ren (Jack) Chuang (1):
  memory tier: consolidate the initialization of memory tiers

 drivers/acpi/numa/hmat.c     |  5 +--
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            | 59 +++++++++++++++---------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

-- 
Ho-Ren (Jack) Chuang


