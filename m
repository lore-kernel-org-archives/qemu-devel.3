Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A80EC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4pl-0007Up-M5; Thu, 08 Aug 2024 11:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sc4ph-0007Rr-8f
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:13:41 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sc4pe-0003aE-SV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1723130018; x=1754666018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KgIqmjD+KlW1kjDaEXej5x0fZ6oZID/cY1gsTrU8Dv4=;
 b=QqhsuvQdaFcqxKbI1PIXAaSOIEjr1nw2VbY0INvDmxRF5+aC0cTxGd4W
 jLXUPfLFy7mAeY4+wvR6AkY+HMdNq6iOvcL40S+U2RcrTLnEpOx1K8hjh
 aGGFr2U26X7+H1FdgE3tFswtOvMraUWhBBcmJwD9Q1k9S6SlFIHz25oEy
 4iFMH5vNOG60DKQlNc1DiBzw9Oi9qQvgDx7duYQSU1nQWzO8a4V4lE+05
 vDEjoOF9RowQYaOZixrLul9JMSUeCk9qwbSaTUNFbdCPiLNl2joWbRgcB
 KlSV9LgkLrNDLzmn8PlNK4IORvX88XbnvvCIKaoJSq8WXqRXtP7PGwMq5 Q==;
X-CSE-ConnectionGUID: PT6NJYJVSF6qGHp4sEnH4Q==
X-CSE-MsgGUID: Ktoe5StSRgS7qdKTpskvUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="158186002"
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; d="scan'208";a="158186002"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 00:13:34 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B5DB2D5A46
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:32 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id F3394D3F20
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F33C2289DA
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2024 00:13:31 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8C5951A000C;
 Thu,  8 Aug 2024 23:13:30 +0800 (CST)
To: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com
Cc: bp@alien8.de, dave.jiang@intel.com, dave@stgolabs.net, ira.weiny@intel.com,
 james.morse@arm.com, linmiaohe@huawei.com, mchehab@kernel.org,
 nao.horiguchi@gmail.com, rric@kernel.org, tony.luck@intel.com,
 ruansy.fnst@fujitsu.com
Subject: [PATCH v4 1/2] cxl/core: introduce device reporting poison hanlding
Date: Thu,  8 Aug 2024 23:13:27 +0800
Message-Id: <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.000
X-TMASE-Result: 10--14.315400-10.000000
X-TMASE-MatchedRID: xXA8JSLb31sZHQl0dvECsQ0QY5VnQyAN9LMB0hXFSeinw6VQ+/MY/aJf
 gPmvd/XOfBnw4TEwb3JFUO4Lwe1qd/mi+iQw41eA/sUSFaCjTLw7x+Tuf7McDOjMOEZ5AL0SmRD
 Sh3pCEkOqbnUbIrDbhZdYXl3VkvoTqUUaBCb+VbHEOJqSsn5KmRYHLuVbwKXA33Nl3elSfsqyEH
 XzDCqxQcYS7GmsALUGD+giDHW5zvvQ9t8zINQJxDe9MF4SNA1+eF6MevMVZUDWeQtrcncLfegoS
 vaKsl/kIvrftAIhWmLy9zcRSkKatcOJmY4XRXkVyRfzRkrgkUH5UnqVnIHSzyxMw0FMkBlZLy7E
 GpbOGkod28lWFjU6v6bDnpxC0iz1mtdd6hGWj/x1e7Xbb6Im2resiCwR1MqZemnPKw9dcAo7/6w
 m+1WoGTE7bCG779IoSUJkKHLyNuXlFpsfMgM6DNyBRU/cKn690VvRkjCHhK6bKItl61J/yZ+inT
 K0bC9eKrauXd3MZDX+2MfnmxupmrdgHidVdLaElLjCcbrd1WCkN9kx8PZr3bjg6uqJ6r4l
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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

CXL device can find&report memory problems, even before MCE is detected
by CPU.  AFAIK, the current kernel only traces POISON error event
from FW-First/OS-First path, but it doesn't handle them, neither
notify processes who are using the POISON page like MCE does.

Thus, user have to read logs from trace and find out which device
reported the error and which applications are affected.  That is not
an easy work and cannot be handled in time.  Thus, it is needed to add
the feature to make the work done automatically and quickly.  Once CXL
device reports the POISON error (via FW-First/OS-First), kernel
handles it immediately, similar to the flow when a MCE is triggered.

The current call trace of error reporting&handling looks like this:
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure()

2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
                                                  \-> memory_failure()
                                                      ^----- ADD
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
                        \-> memory_failure()
                            ^------------------------------- ADD
```
This patch adds calling memory_failure() while CXL device reporting
error is received, marked as "ADD" in figure above.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 75 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxlmem.h      |  8 ++---
 drivers/cxl/pci.c         |  4 +--
 include/linux/cxl-event.h | 16 ++++++++-
 4 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..0cb6ef2e6600 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -849,10 +849,55 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt)
+static void cxl_report_poison(struct cxl_memdev *cxlmd, u64 hpa)
+{
+	unsigned long pfn = PHYS_PFN(hpa);
+
+	memory_failure_queue(pfn, 0);
+}
+
+static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
+					   enum cxl_event_log_type type,
+					   u64 hpa,
+					   struct cxl_event_gen_media *rec)
+{
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->media_hdr.transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_report_poison(cxlmd, hpa);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
+				  enum cxl_event_log_type type,
+				  u64 hpa,
+				  struct cxl_event_dram *rec)
+{
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->media_hdr.transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_report_poison(cxlmd, hpa);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void cxl_event_handle_record(struct cxl_memdev *cxlmd,
+			     enum cxl_event_log_type type,
+			     enum cxl_event_type event_type,
+			     const uuid_t *uuid, union cxl_event *evt)
 {
 	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
 		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
@@ -880,18 +925,22 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		if (cxlr)
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
-		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						&evt->gen_media);
-		else if (event_type == CXL_CPER_EVENT_DRAM)
+			cxl_event_handle_general_media(cxlmd, type, hpa,
+						&evt->gen_media);
+		} else if (event_type == CXL_CPER_EVENT_DRAM) {
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+			cxl_event_handle_dram(cxlmd, type, hpa, &evt->dram);
+		}
 	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
 
-static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				     enum cxl_event_log_type type,
-				     struct cxl_event_record_raw *record)
+static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
+				      enum cxl_event_log_type type,
+				      struct cxl_event_record_raw *record)
 {
 	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
 	const uuid_t *uuid = &record->id;
@@ -903,7 +952,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 
-	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
+	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -1012,8 +1061,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			__cxl_event_trace_record(cxlmd, type,
-						 &payload->records[i]);
+			__cxl_event_handle_record(cxlmd, type,
+						  &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..5c4810dcbdeb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -826,10 +826,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt);
+void cxl_event_handle_record(struct cxl_memdev *cxlmd,
+			     enum cxl_event_log_type type,
+			     enum cxl_event_type event_type,
+			     const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..6e65ca89f666 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1029,8 +1029,8 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
 	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
 
-	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
-			       &uuid_null, &rec->event);
+	cxl_event_handle_record(cxlds->cxlmd, log_type, ev_type,
+				&uuid_null, &rec->event);
 }
 
 static void cxl_cper_work_fn(struct work_struct *work)
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 0bea1afbd747..be4342a2b597 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -7,6 +7,20 @@
 #include <linux/uuid.h>
 #include <linux/workqueue_types.h>
 
+/*
+ * Event transaction type
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+enum cxl_event_transaction_type {
+	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
+	CXL_EVENT_TRANSACTION_READ,
+	CXL_EVENT_TRANSACTION_WRITE,
+	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
+	CXL_EVENT_TRANSACTION_INJECT_POISON,
+	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
+	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
+};
+
 /*
  * Common Event Record Format
  * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
@@ -26,7 +40,7 @@ struct cxl_event_media_hdr {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	/*
 	 * The meaning of Validity Flags from bit 2 is
 	 * different across DRAM and General Media records
-- 
2.34.1


