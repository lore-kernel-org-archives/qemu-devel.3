Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C28C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qt-0004Yo-2b; Fri, 29 Mar 2024 02:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5ql-0004WB-AN
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:27 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002Vp-Ge
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694183; x=1743230183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=shtuRfAxtrYc7R8K9/CJ4Azd4LkSM+WTHpdkGRJ63DM=;
 b=cXzYA3CkIaQU4SHueVOiKYDohFMRnPbmcZsPytXkasL+JjyJYGoFFLom
 Bo+2G/nIyeJ3drtVxiWM3Dvfw+rQfk6zR5bhfMGnr3sh4UzEO0b8dWOZf
 xPD1Vo28YoDPtsQeIzn6vMpQ1JmXOnxn9ywHF2tZGHTPQ3xJvwDVH/iqf
 ZSSc9r6daTwfwbhXafQdKEx2sL1B6oKUhdwzsxYNe8iHUpiF27uqDQp+1
 QH9Pe1dFyUpc8EZ72xnyCWtBM0SsX6z5KeJzZSzBZ5hWkpD/QyP3hK/ZW
 YyH0BOqw3tCPH/VAkTcwEG18AKtLesUj4B4exYZ/liVvGC7ctGP5u0up3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="141726405"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="141726405"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D39AE9A25
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A78ACC7261
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 386B2224612
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C10561A006E;
 Fri, 29 Mar 2024 14:36:16 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 6/6] cxl/core: add poison injection event handler
Date: Fri, 29 Mar 2024 14:36:14 +0800
Message-Id: <20240329063614.362763-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--21.177000-10.000000
X-TMASE-MatchedRID: iooG+Wyw6IPvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsshTvdDYMpJmdv
 IBM8UuLSlD/Z1FnrlIQq1udiYlzzOw+AJDU3H+qgMGAKZueP0mZcsgu/IQFPzlFcLhxfrlwkrEi
 NJh+xJpmolk6IAqhmvEZXTR3Us53S8Aj+/7+3oKUFxov+3JYvY35Lmbb/xUuaOhR0VsdhRrC/BR
 68O365bn9eOltIlLtrGYYZJnYtPhnonyaWYsETGxmCYUYerLHruJpeHGRhXLFHpEd1UrzmFevn/
 O99cHKFCazasHFXmjvJI5NrSJkuqtnzIBSf0ZiSBe3KRVyu+k2fmd9HsjZ0Uw3H/quqvfm4NUIc
 8ma/DM+LYCqQJUBx8PD9KdZg9ohhrVSkkKFNk8GJXSm2bBmGrSCW0wRZXKAmmyiLZetSf8mfop0
 ytGwvXiq2rl3dzGQ1A/3R8k/14e0=
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

Currently driver only traces cxl events, poison injection (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison range in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver
    a. parse the POISON event from GMER;        <-- this patch
    b. retrieve POISON list from memdev;
    c. translate poisoned DPA to HPA;
    d. enqueue poisoned PFN to memory_failure's work queue;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---

the reply to Jonathan's comment in last version:
> I'm not 100% convinced this is necessary poison causing.  Also
> the text tells us we should see 'an appropriate event'.
> DRAM one seems likely to be chosen by some vendors.
I think it's right to use DRAM Event Record for volatile-memdev, but 
should poison on a persistent-memdev also use DRAM Event Record too? 
Though its 'Physical Address' feild has the 'Volatile' bit too, which is 
same as General Media Event Record.  I am a bit confused about this.

---
 drivers/cxl/core/mbox.c | 100 ++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxlmem.h    |   8 ++--
 2 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 19b46fb06ed6..97ef45d808b8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -837,25 +837,99 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt)
+struct cxl_event_poison_context {
+	u64 dpa;
+	u64 length;
+};
+
+static int __cxl_report_poison(struct device *dev, void *arg)
+{
+	struct cxl_event_poison_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
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
+	if (ctx->dpa > cxled->dpa_res->end || ctx->dpa < cxled->dpa_res->start)
+		return 0;
+
+	cxlmd = cxled_to_memdev(cxled);
+	cxl_mem_get_poison(cxlmd, ctx->dpa, ctx->length, cxled->cxld.region,
+			   true);
+
+	return 1;
+}
+
+static void cxl_event_handle_poison(struct cxl_memdev *cxlmd,
+				    struct cxl_event_gen_media *rec)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+	u64 phys_addr = le64_to_cpu(rec->phys_addr);
+	struct cxl_event_poison_context ctx = {
+		.dpa = phys_addr & CXL_DPA_MASK,
+	};
+
+	/* No regions mapped to this memdev, that is to say no HPA is mapped */
+	if (!port || !is_cxl_endpoint(port) ||
+	    cxl_num_decoders_committed(port) == 0)
+		return;
+
+	/*
+	 * Host Inject Poison may have a range of DPA, but the GMER only has
+	 * "Physical Address" field, no such one indicates length.  So it's
+	 * better to call cxl_mem_get_poison() to find this poison record.
+	 */
+	ctx.length = phys_addr & CXL_DPA_VOLATILE ?
+			resource_size(&cxlmd->cxlds->ram_res) :
+			resource_size(&cxlmd->cxlds->pmem_res) - ctx.dpa;
+
+	device_for_each_child(&port->dev, &ctx, __cxl_report_poison);
+}
+
+static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
+					   enum cxl_event_log_type type,
+					   struct cxl_event_gen_media *rec)
+{
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_event_handle_poison(cxlmd, rec);
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
-	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
 		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-	else if (event_type == CXL_CPER_EVENT_DRAM)
+		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
+	} else if (event_type == CXL_CPER_EVENT_DRAM)
 		trace_cxl_dram(cxlmd, type, &evt->dram);
 	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
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
@@ -867,7 +941,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 
-	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
+	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -978,8 +1052,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			__cxl_event_trace_record(cxlmd, type,
-						 &payload->records[i]);
+			__cxl_event_handle_record(cxlmd, type,
+						  &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1f03130b9d6a..dfd7bdd0d66a 100644
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
 void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
-- 
2.34.1


