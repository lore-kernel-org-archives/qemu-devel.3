Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FE8CD11DC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpAD-0000IP-Hx; Wed, 20 Mar 2024 02:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmpAC-0000ID-6M
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:11:00 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rmpA1-0006TC-M6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:10:59 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78a052a3fc5so155833485a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710915048; x=1711519848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwGW4X7oulIIcxRnBbYYicnOB+KsMIm/U2BqanKa/fk=;
 b=MCgYn8sIbPIxHCxz7lRse8kARSrTR37oEcchDCOXap3iSdisIL3kZkCDxA+uIfVb8Q
 LFvS/2tHn1UHx50uuTX2ypIN96/+tfIVDEKckaK3BIqcsm+d5x5F5gkabFwWLbBRZXvL
 Vn3hqdp8hSmG1s0h1QTiO9r+DIavZeF6ap1pY+UHH+HwxVQ7CgTj3uL+5ZOSMnqqg358
 CGprmeOekrZoTpz5WR+eBcOwZlFVahAoWpccJAIZa5NNfwTbwN4LRfb6BvrysYn7qdPd
 ESONVz1TQG2nEZQFE1qpC3mREp3XyY20l51w6LOd95MJg21PMRS2jWTfSOjH2KAFzmta
 L20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710915048; x=1711519848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwGW4X7oulIIcxRnBbYYicnOB+KsMIm/U2BqanKa/fk=;
 b=L1Z1hQ/mZ7Lq1XCfxEiA/MetoSsd999W7+0gPjBZPLvldQC896uMsuhB1giv+gYLt9
 Yc9IScoLe1VWcRTjRZEJ21Lkp+BAx7oygkInSPcB+141M5hJtvkKpEB3cFtmcdDooHTs
 tu4/7pl7Ki5kd2hQ2A08CheoygCMmAHg8korhNvHIuc8LnkA4c9Jd6E47Em79DtjQ8ss
 sWf2g+wWgw9lfcojRfUEts96rV+vu5oZmuu90GZAzS1Ao4Hnwdq6ok515SXC5AQR7QXx
 EmYFJX9fRvlK8cVGAxANz/4GgWBmBZ8x6Wa5yCORs+w18p+7z8Z7WyvNIbY/1IZ9svJE
 rkIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfZKWi3djIoWOiRS07cryNspMMsjnswzpf+k9lVNJsN3esQIt66ZC34Y5RvGKgF7PakVHRY+TkvbwqDt7iObzYjT45s54=
X-Gm-Message-State: AOJu0YyOHu0E//Wa3SqFtVzNAEEC6x6dpdvxSGzDdBddpDTKWJlrsiyt
 ARWDgwYou8+jccbqKNajuDK9h9M+TcYH68NCum7KzBhXWhIosOTQ07z5h8N7XtM=
X-Google-Smtp-Source: AGHT+IHdkJX6NQs9WDxlJlRWWOdNZMk+MQxYM/ZXt6WuZ6YnuVS9Rv2sdEvJFxxXOqmF9Wn7sJFtAA==
X-Received: by 2002:a05:620a:884:b0:78a:4d4:92f1 with SMTP id
 b4-20020a05620a088400b0078a04d492f1mr4703702qka.72.1710915048681; 
 Tue, 19 Mar 2024 23:10:48 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.123])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a05620a03cf00b0078a042376absm2295914qkm.22.2024.03.19.23.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 23:10:48 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
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
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] memory tier: dax/kmem: abstract memory types put
Date: Wed, 20 Mar 2024 06:10:40 +0000
Message-Id: <20240320061041.3246828-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240320061041.3246828-1-horenchuang@bytedance.com>
References: <20240320061041.3246828-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x735.google.com
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

Abstract `kmem_put_memory_types()` into `mt_put_memory_types()` to
accommodate various memory types and enhance flexibility,
similar to `mt_find_alloc_memory_type()`.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 drivers/dax/kmem.c           |  7 +------
 include/linux/memory-tiers.h |  6 ++++++
 mm/memory-tiers.c            | 12 ++++++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index de1333aa7b3e..01399e5b53b2 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -66,13 +66,8 @@ static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 
 static void kmem_put_memory_types(void)
 {
-	struct memory_dev_type *mtype, *mtn;
-
 	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
-		list_del(&mtype->list);
-		put_memory_type(mtype);
-	}
+	mt_put_memory_types(&kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 }
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index b2135334ac18..a44c03c2ba3a 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -50,6 +50,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
 struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 							struct list_head *memory_types);
+void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -143,5 +144,10 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *m
 {
 	return NULL;
 }
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index d9b96b21b65a..6246c28546ba 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -662,6 +662,18 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *m
 }
 EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
 
+
+void mt_put_memory_types(struct list_head *memory_types)
+{
+	struct memory_dev_type *mtype, *mtn;
+
+	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
+		list_del(&mtype->list);
+		put_memory_type(mtype);
+	}
+}
+EXPORT_SYMBOL_GPL(mt_put_memory_types);
+
 /*
  * This is invoked via late_initcall() to create
  * CPUless memory tiers after HMAT info is ready or
-- 
Ho-Ren (Jack) Chuang


