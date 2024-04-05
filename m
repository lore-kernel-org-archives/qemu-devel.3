Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF79CD1299
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 00:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsX79-0006CB-2D; Thu, 04 Apr 2024 20:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX76-0006BP-P3
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:24 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsX6y-00026E-99
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 20:07:19 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78d33e20cbfso94268485a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712275633; x=1712880433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQdaNIkqtZaYcZaz2No7Lv3UsoB6KJKx8p/n/NpKY8s=;
 b=XnVC6DtnWlWetXIX+lNXhknDDmP1RNlH9PDDbpvqsEheDn16UR38g0Z1okn43fsgl5
 JePr6lx4BnHOzD3ib/OwhxP+Hlz57E6C0KjaJSQyLa9ilFJV/MWKxl7nrz/swLL7ZfZ4
 GZyN+UYm+oA/pQkYnQ6As0DAodbRLX9jpVMXw6nM1JYxDKU2PhB5JJRUToGEJGBARth4
 Ebp2gQla3o2Qbr4HC/+Qx8jZ3Zewmsn1YcdpMIY4cE4xOP1pvY3QBZXHDGtvydW+s3GE
 BclpwEC38po+RuvPhxw6Cyvpf6PPvktTLKk8SChjMTX3FStGvw98CUuIdr+G7Z5TBJSj
 wJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712275633; x=1712880433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQdaNIkqtZaYcZaz2No7Lv3UsoB6KJKx8p/n/NpKY8s=;
 b=kahPmAM8jnk/5LYgdnlZzhju7djWSeMb9u+xM8XSiYroAFEIC2sT+VkEprCySJ7dx0
 qoJDWhT3Mera9CY+C0VdVc4SykJ7W7cou+zuf2TrU/Efm8/FLgMH6WSjQKDftKHuDjL2
 I/Qwno2a3T9W8my4E1cqLKp5/qzQ2U4CcSKwzVnW9aiEE+pQcaLNODkgzcZhGpzqAZ5K
 270ST7UULUNeNXnR3R/Lcuq4K+Rj+ZvOKcCZA719TYdiXnM6SjarG9n+ElEYolpmJTot
 LaL+Sf9uJMl7d5sMHyPgb02mx5rx7WIlgYejdmLt7xtjpWwvukpHGaMP/XSpVlIO6trP
 juiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmZmtAp7DLJCtIGrW33LiIpmeQ4lL/Vpd/o8L7GJyGVm4Z4vv3xCDNdiWUdkSmbPs114BSglCZ39AY9KvKGQNS+WRESFM=
X-Gm-Message-State: AOJu0YxesatvwmUEudLNPJ2oVDAcam+Hz702btDOkySbLBkFLio+yQFB
 3hKod5NK3B/CUdXCGplqeKqcnOJSy18W/LzVjxWlWS5SoBJ6Z849k60g32SzAgA=
X-Google-Smtp-Source: AGHT+IHaVrcMfgZoSTOIj9tov+jFGpMHgFpeZLuchTMnvsxDYr39S3klFlyhMYGWZAw/tV8qmXpn0w==
X-Received: by 2002:a05:620a:c84:b0:78a:5dac:3e59 with SMTP id
 q4-20020a05620a0c8400b0078a5dac3e59mr3411783qki.76.1712275632825; 
 Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,
 "SeongJae Park" <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
Date: Fri,  5 Apr 2024 00:07:06 +0000
Message-Id: <20240405000707.2670063-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240405000707.2670063-1-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The current implementation treats emulated memory devices, such as
CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
(E820_TYPE_RAM). However, these emulated devices have different
characteristics than traditional DRAM, making it important to
distinguish them. Thus, we modify the tiered memory initialization process
to introduce a delay specifically for CPUless NUMA nodes. This delay
ensures that the memory tier initialization for these nodes is deferred
until HMAT information is obtained during the boot process. Finally,
demotion tables are recalculated at the end.

* late_initcall(memory_tier_late_init);
Some device drivers may have initialized memory tiers between
`memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
online memory nodes and configuring memory tiers. They should be excluded
in the late init.

* Handle cases where there is no HMAT when creating memory tiers
There is a scenario where a CPUless node does not provide HMAT information.
If no HMAT is specified, it falls back to using the default DRAM tier.

* Introduce another new lock `default_dram_perf_lock` for adist calculation
In the current implementation, iterating through CPUlist nodes requires
holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
trying to acquire the same lock, leading to a potential deadlock.
Therefore, we propose introducing a standalone `default_dram_perf_lock` to
protect `default_dram_perf_*`. This approach not only avoids deadlock
but also prevents holding a large lock simultaneously.

* Upgrade `set_node_memory_tier` to support additional cases, including
  default DRAM, late CPUless, and hot-plugged initializations.
To cover hot-plugged memory nodes, `mt_calc_adistance()` and
`mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
handle cases where memtype is not initialized and where HMAT information is
available.

* Introduce `default_memory_types` for those memory types that are not
  initialized by device drivers.
Because late initialized memory and default DRAM memory need to be managed,
a default memory type is created for storing all memory types that are
not initialized by device drivers and as a fallback.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 516b144fd45a..6632102bd5c9 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -36,6 +36,11 @@ struct node_memory_type_map {
 
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
+/*
+ * The list is used to store all memory types that are not created
+ * by a device driver.
+ */
+static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
@@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_mostly;
 
 static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
 
+/* The lock is used to protect `default_dram_perf*` info and nid. */
+static DEFINE_MUTEX(default_dram_perf_lock);
 static bool default_dram_perf_error;
 static struct access_coordinate default_dram_perf;
 static int default_dram_perf_ref_nid = NUMA_NO_NODE;
@@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 static struct memory_tier *set_node_memory_tier(int node)
 {
 	struct memory_tier *memtier;
-	struct memory_dev_type *memtype;
+	struct memory_dev_type *memtype = default_dram_type;
+	int adist = MEMTIER_ADISTANCE_DRAM;
 	pg_data_t *pgdat = NODE_DATA(node);
 
 
@@ -514,7 +522,16 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	mt_calc_adistance(node, &adist);
+	if (!node_memory_types[node].memtype) {
+		memtype = mt_find_alloc_memory_type(adist, &default_memory_types);
+		if (IS_ERR(memtype)) {
+			memtype = default_dram_type;
+			pr_info("Failed to allocate a memory type. Fall back.\n");
+		}
+	}
+
+	__init_node_memory_type(node, memtype);
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
@@ -652,6 +669,35 @@ void mt_put_memory_types(struct list_head *memory_types)
 }
 EXPORT_SYMBOL_GPL(mt_put_memory_types);
 
+/*
+ * This is invoked via `late_initcall()` to initialize memory tiers for
+ * CPU-less memory nodes after driver initialization, which is
+ * expected to provide `adistance` algorithms.
+ */
+static int __init memory_tier_late_init(void)
+{
+	int nid;
+
+	guard(mutex)(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY) {
+		/*
+		 * Some device drivers may have initialized memory tiers
+		 * between `memory_tier_init()` and `memory_tier_late_init()`,
+		 * potentially bringing online memory nodes and
+		 * configuring memory tiers. Exclude them here.
+		 */
+		if (node_memory_types[nid].memtype)
+			continue;
+
+		set_node_memory_tier(nid);
+	}
+
+	establish_demotion_targets();
+
+	return 0;
+}
+late_initcall(memory_tier_late_init);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -663,25 +709,19 @@ static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source)
 {
-	int rc = 0;
-
-	mutex_lock(&memory_tier_lock);
-	if (default_dram_perf_error) {
-		rc = -EIO;
-		goto out;
-	}
+	guard(mutex)(&default_dram_perf_lock);
+	if (default_dram_perf_error)
+		return -EIO;
 
 	if (perf->read_latency + perf->write_latency == 0 ||
-	    perf->read_bandwidth + perf->write_bandwidth == 0) {
-		rc = -EINVAL;
-		goto out;
-	}
+	    perf->read_bandwidth + perf->write_bandwidth == 0)
+		return -EINVAL;
 
 	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
 		default_dram_perf = *perf;
 		default_dram_perf_ref_nid = nid;
 		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
-		goto out;
+		return 0;
 	}
 
 	/*
@@ -709,27 +749,25 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 		pr_info(
 "  disable default DRAM node performance based abstract distance algorithm.\n");
 		default_dram_perf_error = true;
-		rc = -EINVAL;
+		return -EINVAL;
 	}
 
-out:
-	mutex_unlock(&memory_tier_lock);
-	return rc;
+	return 0;
 }
 
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 {
+	guard(mutex)(&default_dram_perf_lock);
 	if (default_dram_perf_error)
 		return -EIO;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
-
 	if (perf->read_latency + perf->write_latency == 0 ||
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
+		return -ENOENT;
+
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -742,7 +780,6 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
 
 	return 0;
 }
@@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
-	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
+						      &default_memory_types);
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
@@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on
+			 * CPUless numa nodes. These will be initialized
+			 * after firmware and devices are initialized.
+			 */
+			continue;
+
 		memtier = set_node_memory_tier(node);
 		if (IS_ERR(memtier))
 			/*
-- 
Ho-Ren (Jack) Chuang


