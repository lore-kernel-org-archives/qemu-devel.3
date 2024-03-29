Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFA6CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qq-0004Xb-2q; Fri, 29 Mar 2024 02:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qk-0004Vc-V8
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:27 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002VJ-Gm
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694184; x=1743230184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WjXkq8DjQjakIlilkVzxIex2qly8t8WwbQWxANAhOWU=;
 b=tHX7oZgN1+7oVrzCRscKpjA2FrqXWXPF8E4q47CiN5tk+SK9toFflZn4
 0Gxk6IJTwATM/Yh9gAgIy/k+sXntzn+Yuh/be3Keg64iEPzs3J0DJLbgJ
 JjoKm91qwJPjsqnhj+XB9xAlz8Zjren50SpI09FIONpgxTy1oQz/O2C7t
 tk0sGz/+usDPbPm3LyOqm5Kqc2XmpG8QIw+rPe7BkQw35b6QmSRgV7ZZX
 /NNzsv3uKFa5J51ub4ew8u/Bs+totgIwpLbhM4MXqkOm1FJPR58M5yENl
 BUJKy23TsZiiKdFxdRPtlx7jRYb58RpjUfWO4ywNLc/BRhsUeqirAuPUs g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="153723887"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="153723887"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:20 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4D806D6286
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6BE97D3F31
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 00566200A7F2A
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 86FCE1A006E;
 Fri, 29 Mar 2024 14:36:15 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 2/6] cxl/core: introduce cxl_mem_report_poison()
Date: Fri, 29 Mar 2024 14:36:10 +0800
Message-Id: <20240329063614.362763-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--4.197900-10.000000
X-TMASE-MatchedRID: 53aa+u+VJBkM5CG8CYBPxRhvfWx0TE/bQR7lWMXPA1uWGhlHXorXXRZa
 DvoiUT/Mg1jj+Zp5wfm12HagvbwDji/7QU2czuUNA9lly13c/gEgltMEWVygJifJTn+dmnFQcHj
 giTON9jJvu+EAUOCx01Q+BXcIki7EZEHJCRAt0NqeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
 vEGAbTDo3PgYtyDuTWI3WPpm6ecjdp0YLTMI01adj70x37BoN8/h4BuZEnt4Io/4nN6pA2LIkSU
 kMsH+K04A1LMJVhA4LWGNvCCott3luMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If poison is detected(reported from cxl memdev), OS should be notified to
handle it. So, introduce this helper function for later use:
  1. translate DPA to HPA;
  2. enqueue records into memory_failure's work queue;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---

Currently poison injection from debugfs always create a 64-bytes-length
record, which is fine.  But the injection from qemu's QMP API:
qmp_cxl_inject_poison() could create a poison record contains big length,
which may cause many many times of calling memory_failure_queue().
Though the MEMORY_FAILURE_FIFO_SIZE is 1 << 4, it seems not enougth.

---
 drivers/cxl/core/mbox.c | 18 ++++++++++++++++++
 drivers/cxl/cxlmem.h    |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..31b1b8711256 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1290,6 +1290,24 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+			   struct cxl_region *cxlr,
+			   struct cxl_poison_record *poison)
+{
+	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
+	u64 len = PAGE_ALIGN(le32_to_cpu(poison->length) * CXL_POISON_LEN_MULT);
+	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+	unsigned long pfn = PHYS_PFN(hpa);
+	unsigned long pfn_end = pfn + len / PAGE_SIZE - 1;
+
+	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		return;
+
+	for (; pfn <= pfn_end; pfn++)
+		memory_failure_queue(pfn, MF_ACTION_REQUIRED);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_report_poison, CXL);
+
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..82f80eb381fb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -828,6 +828,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
+void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
+			   struct cxl_region *cxlr,
+			   struct cxl_poison_record *poison);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
-- 
2.34.1


