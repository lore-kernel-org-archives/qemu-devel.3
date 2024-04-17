Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53254C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 07:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx04W-00057B-Bp; Wed, 17 Apr 2024 03:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rx04T-00056c-CP
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:51:09 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rx04N-00023B-FP
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713340263; x=1744876263;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=89O176AgrkL1yroy9Jo+jq3lmWUoJwoXlAdzQfc3vn0=;
 b=En2bxBeO9+v+G6sc8HtfdvywOf8eeJ4LCLlyRgBPwLDmpBzVQ6hwOsM0
 lJxh7MQ7eMwO+7XB4JYDvgTEhTnXPIvAn4p/ES/lCj131+IgPqY8N8wjY
 uEoNVzs9AMR0JjXHlj1tjsjKSxZZv749mwuW2S2hTJjIkM22Hz1mfKBJi
 7I1+W492B6totQi2IlaY8XRvKgwNXPiuSFAR7zv3keHObh8AnvXqR/o8B
 qyyWG578txq6YzoOEI9FAcuOV4Inw8HCDx+Nz91pF7H6dAtGf/xAwsQod
 LnQKOq647zqQ91my0z343/AwHWOGtsZU2gXM5PS+T0eJHs7zRMU7s094b A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="144302857"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; d="scan'208";a="144302857"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 16:50:58 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1FD0FD4804
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4696A1CA52C
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CD0A62030C7D2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 54CCB1A000A;
 Wed, 17 Apr 2024 15:50:54 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com
Subject: [PATCH v3 2/2] cxl/core: add poison creation event handler
Date: Wed, 17 Apr 2024 15:50:53 +0800
Message-Id: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.005
X-TMASE-Result: 10--16.044500-10.000000
X-TMASE-MatchedRID: DIEPoA0d9jzvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsshTvdDYMpJmdv
 IBM8UuLSeJaFFPX0aSQzZRFJRee/WnuDhljfG03rTuctSpiuWyUUi4Ehat0545Tx+2LIqNmteVs
 0skyEaS3LfxMfp01yFeQEkglipGR3fDPEC/yQgPRFThfcy7XcjI5UafLmrvaGvn+2qfQyWg0Skx
 jSj8Gsp+GmDaCURky8QvDfXpsV7A2f80tdhYBdg9Hu43wY4QfHfrTt+hmA5bK7Iv2OMTayQWlwp
 eAR2tzqI0ExTNeC7Ia4Yr4jUnU84qqoNk0mVBa9MrR3zbmt+0V9LQinZ4QefPcjNeVeWlqY+gtH
 j7OwNO0CpgETeT0ynA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
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

Currently driver only traces cxl events, poison creation (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison pages in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison creation event handler in OS-First method:
  - Qemu:
    - CXL device reports POISON creation event to OS by MSI by sending
      GMER/DER after injecting a poison record;
  - CXL driver:
    a. parse the POISON event from GMER/DER;
    b. translate poisoned DPA to HPA (PFN);
    c. enqueue poisoned PFN to memory_failure's work queue;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h      |   8 +--
 include/linux/cxl-event.h |  18 +++++-
 3 files changed, 125 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f0f54aeccc87..76af0d73859d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt)
+static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
+			      u64 dpa)
 {
-	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+	unsigned long pfn = PHYS_PFN(hpa);
+
+	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		return;
+
+	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
+}
+
+static int __cxl_report_poison(struct device *dev, void *arg)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	u64 dpa = *(u64 *)arg;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	if (cxled->mode == CXL_DECODER_MIXED) {
+		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
+		return 0;
+	}
+
+	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+		return 0;
+
+	cxlmd = cxled_to_memdev(cxled);
+	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
+
+	return 1;
+}
+
+static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+
+	/*
+	 * No region is mapped to this endpoint, that is to say no HPA is
+	 * mapped.
+	 */
+	if (!port || !is_cxl_endpoint(port) ||
+	    cxl_num_decoders_committed(port) == 0)
+		return;
+
+	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
+}
+
+static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
+					   enum cxl_event_log_type type,
+					   struct cxl_event_gen_media *rec)
+{
+	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
+
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_event_handle_poison(cxlmd, dpa);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
+				  enum cxl_event_log_type type,
+				  struct cxl_event_dram *rec)
+{
+	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
+
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_event_handle_poison(cxlmd, dpa);
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
+{
+	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
 		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-	else if (event_type == CXL_CPER_EVENT_DRAM)
+		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
+	} else if (event_type == CXL_CPER_EVENT_DRAM) {
 		trace_cxl_dram(cxlmd, type, &evt->dram);
-	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
+		cxl_event_handle_dram(cxlmd, type, &evt->dram);
+	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
 		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
 	else
 		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
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
@@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 
-	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
+	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			__cxl_event_trace_record(cxlmd, type,
-						 &payload->records[i]);
+			__cxl_event_handle_record(cxlmd, type,
+						  &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 36cee9c30ceb..ba1347de5651 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
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
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..8189bed76c12 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -23,6 +23,20 @@ struct cxl_event_generic {
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
 
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
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
@@ -33,7 +47,7 @@ struct cxl_event_gen_media {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
@@ -52,7 +66,7 @@ struct cxl_event_dram {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
-- 
2.34.1


