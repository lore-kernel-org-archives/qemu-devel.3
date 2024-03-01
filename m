Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8197AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyBl-0002he-0I; Fri, 01 Mar 2024 03:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rfyBe-0002gJ-Lq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:24:11 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rfyBb-0001Hg-PO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:24:09 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-690105304b4so8935026d6.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 00:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709281443; x=1709886243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/6TShqh1i4+cFFfpKPT0xQIuYg06VEOVkdOiTtXAx9c=;
 b=cwP+W75qd5ZRnunTQXnC96XJlnJLGZfXjwceR2LgtUCHdfBGjVS+rmA6sBqh48VxBm
 qhPH31vgjQmO+4XXLiQi3TyfojZwFdP3sMYW1msxCrp0lr3Wk/LaClF2/J5OAr24ozaU
 JavcUcJCWo3b0zh/hbJ2jvfN94lH9VpJDT3TvaWFOwpxICo9z5tcSP0kmYpAd1O8kPuo
 SzeRyl1M+lIvIn4vlkL58N8ne//E85nvEh+oSZPis3N8zX28eZvWycZSmashPtyMRRKp
 ErrvXjnDtmm0M8xto44OYVmsmizF4RDoSOGS250hbs7B9pfmiHC0EW/droQ//KSsw7MJ
 SOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709281443; x=1709886243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6TShqh1i4+cFFfpKPT0xQIuYg06VEOVkdOiTtXAx9c=;
 b=q1FeXSMCWrBpBzGTMRJYoCETFL5ligCgDZgl/4I0vn7IL0JF8/BTyWSuD88hWWJCU+
 hb93ZnVKBBUEzonHi0w0MAbRy/8vfpl/naUQ108XaYq7sL5Yo+j5wzgljZnsrWQobtcj
 cctoQjTATwNr9dsjJXumM2uuq4sgN5WBEpPqGSR6VqpBEai8rbNN+wpbbUd6LsLkRuVC
 EHsT3o8FjgWdPwc8xaxg49rbA5aPiB5t/6HMX2sF+zz+gE7dMM31w0RxigSGGWCSkc9K
 5yXe7jtVjnfDHrdujcnjga/IDaVClO/r5EBxz6KyfZKIW05PqQYGWk+VlzBEOxhpRKuk
 9uJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNGf/Ar05oKbu60v7qWqctLe6OoqgtjhZb2mg2y77G9ARkgpNHm0ZKpT5EsEgv6GjN50erIaUKW2WWiB9yU0W9T2GTu+M=
X-Gm-Message-State: AOJu0YzVuipg/t9/Kz8YoQLqVMx2lNRZXgRbBYva3WtlX3h380ZtDHNa
 TX7P/P5gBOvsc5bA5vK7ZrN78EwFfSttMjCpv9IiqzkhS6xTLKhbd6X3uxyG7kg=
X-Google-Smtp-Source: AGHT+IFOE//de5gW8/t5EN6iDGtxoPupJsqmHB+gIs7CE75HdwkbfH6RIWi1eK5iB+kKO7THZmG8hQ==
X-Received: by 2002:a05:6214:42:b0:68f:280f:14cc with SMTP id
 c2-20020a056214004200b0068f280f14ccmr982605qvr.35.1709281443055; 
 Fri, 01 Mar 2024 00:24:03 -0800 (PST)
Received: from n231-228-171.byted.org ([130.44.215.123])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a0cd993000000b0068fc392f526sm1631907qvj.127.2024.03.01.00.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 00:24:02 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Hao Xiang" <hao.xiang@bytedance.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huang Ying <ying.huang@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] memory tier: acpi/hmat: create CPUless memory tiers
 after obtaining HMAT info
Date: Fri,  1 Mar 2024 08:22:45 +0000
Message-Id: <20240301082248.3456086-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com>
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=horenchuang@bytedance.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

* Introduce `mt_init_with_hmat()`
We defer memory tier initialization for those CPUless NUMA nodes
until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
post-create CPUless memory tiers after obtaining HMAT info.
It iterates through each CPUless memory node, creating memory tiers if
necessary. Finally, it calculates demotion tables again at the end.

* Introduce `hmat_find_alloc_memory_type()`
Find or allocate a memory type in the `hmat_memory_types` list.

* Make `set_node_memory_tier()` more generic
This function can also be used for setting other memory types for a node.
To do so, a new argument is added to specify a memory type.

* Handle cases where there is no HMAT when creating memory tiers
If no HMAT is specified, it falls back to using `default_dram_type`.

* Change adist calculation code to use another new lock, mt_perf_lock.
Iterating through CPUlist nodes requires holding the `memory_tier_lock`.
However, `mt_calc_adistance()` will end up trying to acquire the same lock,
leading to a potential deadlock. Therefore, we propose introducing a
standalone `mt_perf_lock` to protect `default_dram_perf`. This approach not
only avoids deadlock but also prevents holding a large lock simultaneously.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 drivers/acpi/numa/hmat.c     |  3 ++
 include/linux/memory-tiers.h |  6 +++
 mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..9f57338b3cb5 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
 	if (!hmat_set_default_dram_perf())
 		register_mt_adistance_algorithm(&hmat_adist_nb);
 
+	/* Post-create CPUless memory tiers after getting HMAT info */
+	mt_init_with_hmat();
+
 	return 0;
 out_put:
 	hmat_free_structures();
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..2f845e90c033 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+void mt_init_with_hmat(void);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+static inline void mt_init_with_hmat(void)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..7a0a579b3deb 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -35,7 +35,9 @@ struct node_memory_type_map {
 };
 
 static DEFINE_MUTEX(memory_tier_lock);
+static DEFINE_MUTEX(mt_perf_lock);
 static LIST_HEAD(memory_tiers);
+static LIST_HEAD(hmat_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
@@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 	}
 }
 
-static struct memory_tier *set_node_memory_tier(int node)
+static struct memory_tier *set_node_memory_tier(int node, struct memory_dev_type *new_memtype)
 {
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
@@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	__init_node_memory_type(node, new_memtype);
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
@@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+static struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, &hmat_memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, &hmat_memory_types);
+	}
+	return mtype;
+}
+
+static void mt_create_with_hmat(int node)
+{
+	struct memory_dev_type *mtype = NULL;
+	int adist = MEMTIER_ADISTANCE_DRAM;
+
+	mt_calc_adistance(node, &adist);
+	if (adist != MEMTIER_ADISTANCE_DRAM) {
+		mtype = hmat_find_alloc_memory_type(adist);
+		if (IS_ERR(mtype))
+			pr_err("%s() failed to allocate a tier\n", __func__);
+	} else {
+		mtype = default_dram_type;
+	}
+
+	set_node_memory_tier(node, mtype);
+}
+
+void mt_init_with_hmat(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY)
+		if (!node_state(nid, N_CPU))
+			mt_create_with_hmat(nid);
+
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(mt_init_with_hmat);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 	return rc;
 }
 
@@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 
 	return 0;
 }
@@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 		break;
 	case MEM_ONLINE:
 		mutex_lock(&memory_tier_lock);
-		memtier = set_node_memory_tier(arg->status_change_nid);
+		memtier = set_node_memory_tier(arg->status_change_nid, default_dram_type);
 		if (!IS_ERR(memtier))
 			establish_demotion_targets();
 		mutex_unlock(&memory_tier_lock);
@@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
-		memtier = set_node_memory_tier(node);
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on CPUless numa nodes.
+			 * These will be initialized when HMAT information is
+			 * available.
+			 */
+			continue;
+
+		memtier = set_node_memory_tier(node, default_dram_type);
 		if (IS_ERR(memtier))
 			/*
 			 * Continue with memtiers we are able to setup
-- 
Hao Xiang and Ho-Ren (Jack) Chuang


