Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E332BC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJc5H-0004IJ-QX; Tue, 18 Jun 2024 12:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sJc5F-0004H8-QN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:53:25 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sJc5C-0007IW-L6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1718729602; x=1750265602;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ag5fOqmarH0K6nwAnznY+zumpXxV86AOoh/to2a+V3g=;
 b=sgg2HEJvTqlnxVmexHTjSSaT4Dv+Q+xwfJdELt1v0n2gNR7ltcdLDBQS
 xsi9ZaycyxT5B36MvYtluooPfG0ENwq7EueJxRJxqX2YvzCjRBiNKaFZH
 QFqeLNJs2mdfCpnNOL0tpuD+TntBDucwofqny+fK/BwH+X4Cx0WVUveut
 oxIbAXzuAh5OBhkzBcaISdqbQV2Am7WlCFz8VnmmBbW1QJDVdXIk3uCJO
 3ns3fIi+L//VZJ3674icrFNPC3W0m7b1OHngQQ/P8XtDhmCGVfWXWZSVp
 n1P6uLsp/+vidciitJgbZN3V+tbouiHCxSlW5S4YcaWwNiPTR8wfvW96U g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="152244467"
X-IronPort-AV: E=Sophos;i="6.08,247,1712588400"; d="scan'208";a="152244467"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 01:53:15 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0466CD6EEE
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 01:53:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 34D93D50B5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 01:53:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id AD00EE20E5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 01:53:11 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id BFD501A000A;
 Wed, 19 Jun 2024 00:53:10 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com
Subject: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Date: Wed, 19 Jun 2024 00:53:10 +0800
Message-Id: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28462.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28462.000
X-TMASE-Result: 10--15.424000-10.000000
X-TMASE-MatchedRID: tyQFqoka1ycZHQl0dvECsdMJkd+MUUHPSdIdCi8Ba4C3Vbk+OCY1YaxI
 jSYfsSaZmC+wH+KoDcqFDet6pUjZELWmEBjwFcVelTsGW3DmpUul9VzHf0qr7txq159FIVQpY3G
 dDr1JjFoMI2dvwKu82gsCbakizIq3jzShsBdWTBdZRmuDptXfZ5zZ8Jvlwu9xUStSH0U1R4fZ6K
 rkcB2NweIiMBSBul+8ApIqu01NKaojsTVCecYbuMQ4mpKyfkqZMzbF1gbxlQZXy2/vm0e6zmNok
 eyvFnLMF40HISqSK6q12HagvbwDji/7QU2czuUNA9lly13c/gH4uJ1REX4MHb5TVqwOzxj8vf9f
 i5QQ71M4p1iHssV7ht6ME/2Pq5BIhcAT8+NWWH/HyCtnYFmFhoIw3bnTjwR6icvz9DxarMGk86u
 MB98iNvBn25uFP/vzYcMGA+vBhsriaPUT+aN6kp4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gKq
 42LRYkLkqlPbQWFY4NzD7jlMx6pfoCEAOPEbM1RDpcC2OvH3d+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Background:
Since CXL device is a memory device, while CPU consumes a poison page of 
CXL device, it always triggers a MCE by interrupt (INT18), no matter 
which-First path is configured.  This is the first report.  Then 
currently, in FW-First path, the poison event is transferred according 
to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
 -> CPER -> trace report.  This is the second one.  These two reports
are indicating the same poisoning page, which is the so-called "duplicate
report"[1].  And the memory_failure() handling I'm trying to add in
OS-First path could also be another duplicate report.

Hope the flow below could make it easier to understand:
CPU accesses bad memory on CXL device, then
 -> MCE (INT18), *always* report (1)
 -> * FW-First (implemented now)
      -> CXL device -> FW
	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
    * OS-First (not implemented yet, I'm working on it)
      -> CXL device -> MSI
	      -> OS:CXL driver -> memory_failure() (2.b)
so, the (1) and (2.a/b) are duplicated.

(I didn't get response in my reply for [1] while I have to make patch to
solve this problem, so please correct me if my understanding is wrong.)

This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
to check whether the current poison page has been reported (if yes,
stop the notifier chain, won't call the following memory_failure()
to report), into `x86_mce_decoder_chain`.  In this way, if the poison
page already handled(recorded and reported) in (1) or (2), the other one
won't duplicate the report.  The record could be clear when
cxl_clear_poison() is called.

[1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 arch/x86/include/asm/mce.h |   1 +
 drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c  |   6 +-
 drivers/cxl/cxlmem.h       |   3 +
 4 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dfd2e9699bd7..d8109c48e7d9 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -182,6 +182,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_NFIT,
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
+	MCE_PRIO_CXL,
 	MCE_PRIO_EARLY,
 	MCE_PRIO_CEC,
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..0eb3c5401e81 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,8 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <asm/mce.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		if (cxlr)
 			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
 
+		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
+			return;
+
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						&evt->gen_media);
@@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
+struct cxl_mce_record {
+	struct list_head node;
+	u64 hpa;
+};
+LIST_HEAD(cxl_mce_records);
+DEFINE_MUTEX(cxl_mce_mutex);
+
+bool cxl_mce_recorded(u64 hpa)
+{
+	struct cxl_mce_record *cur, *next, *rec;
+	int rc;
+
+	rc = mutex_lock_interruptible(&cxl_mce_mutex);
+	if (rc)
+		return false;
+
+	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
+		if (cur->hpa == hpa) {
+			mutex_unlock(&cxl_mce_mutex);
+			return true;
+		}
+	}
+
+	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
+	rec->hpa = hpa;
+	list_add(&cxl_mce_records, &rec->node);
+
+	mutex_unlock(&cxl_mce_mutex);
+
+	return false;
+}
+
+void cxl_mce_clear(u64 hpa)
+{
+	struct cxl_mce_record *cur, *next;
+	int rc;
+
+	rc = mutex_lock_interruptible(&cxl_mce_mutex);
+	if (rc)
+		return;
+
+	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
+		if (cur->hpa == hpa) {
+			list_del(&cur->node);
+			break;
+		}
+	}
+
+	mutex_unlock(&cxl_mce_mutex);
+}
+
+struct cxl_contains_hpa_context {
+	bool contains;
+	u64 hpa;
+};
+
+static int __cxl_contains_hpa(struct device *dev, void *arg)
+{
+	struct cxl_contains_hpa_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	struct range *range;
+	u64 hpa = ctx->hpa;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	range = &cxled->cxld.hpa_range;
+
+	if (range->start <= hpa && hpa <= range->end) {
+		ctx->contains = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
+{
+	struct cxl_contains_hpa_context ctx = {
+		.contains = false,
+		.hpa = hpa,
+	};
+	struct cxl_port *port;
+
+	port = cxlmd->endpoint;
+	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
+
+	return ctx.contains;
+}
+
+static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
+			  void *data)
+{
+	struct mce *mce = (struct mce *)data;
+	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
+						    mce_notifier);
+	u64 hpa;
+
+	if (!mce || !mce_usable_address(mce))
+		return NOTIFY_DONE;
+
+	hpa = mce->addr & MCI_ADDR_PHYSADDR;
+
+	/* Check if the PFN is located on this CXL device */
+	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
+	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
+		return NOTIFY_DONE;
+
+	/*
+	 * Search PFN in the cxl_mce_records, if already exists, don't continue
+	 * to do memory_failure() to avoid a poison address being reported
+	 * more than once.
+	 */
+	if (cxl_mce_recorded(hpa))
+		return NOTIFY_STOP;
+	else
+		return NOTIFY_OK;
+}
+
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
@@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	mds->mce_notifier.notifier_call = cxl_handle_mce;
+	mds->mce_notifier.priority = MCE_PRIO_CXL;
+	mce_register_decode_chain(&mds->mce_notifier);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..aa3ac89d17be 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		goto out;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
-	if (cxlr)
+	if (cxlr) {
+		u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+
+		cxl_mce_clear(hpa);
 		dev_warn_once(mds->cxlds.dev,
 			      "poison clear dpa:%#llx region: %s\n", dpa,
 			      dev_name(&cxlr->dev));
+	}
 
 	record = (struct cxl_poison_record) {
 		.address = cpu_to_le64(dpa),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..fbf8d9f46984 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -501,6 +501,7 @@ struct cxl_memdev_state {
 	struct cxl_fw_state fw;
 
 	struct rcuwait mbox_wait;
+	struct notifier_block mce_notifier;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
 			 struct cxl_mbox_cmd *cmd);
 };
@@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
+bool cxl_mce_recorded(u64 pfn);
+void cxl_mce_clear(u64 pfn);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.34.1


