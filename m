Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA844C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROQ-0003IZ-QW; Fri, 09 Feb 2024 08:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSk-0003Fw-9o
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:34 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSi-0001eE-I1
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479673; x=1739015673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dd68uTGB7iPzp9l3yUK2O0dGF5QgWSOWWKlkuSfj+PQ=;
 b=c0qhxsXLQqK8RTq7xHDk+mWSDy/PUhE3e+1HI9jBxGd6JMw4Ya06uNqu
 OqqjhsEC3cSeWZ+ezNrNLir1sQWwsrdxSD1N+bvYI2duMjsO5/LKPrnz/
 q+1JXb5cRaUdkjcti3BDh9uq6jSUPIlgr35ClONbqeG4pWcFBUQybN/Zp
 UTYXwZDMUvrWk0vgf9h4YPDkrSiJ16R3/OvzOq8bjAtONNCkKhUkg2TOv
 76lhwLvWn8BIwN/VzWdn14RETXU29/1e791Hyx9wuacbRdiDMBz11HQGc
 lShQ/2iu9X12Pdk2ZlJCudVIPM/5DH7HxxXHGCkUwUl0/wnftql0zQ7G2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="148405992"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="148405992"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6709F615AB
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:21 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 53813D3E93
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EF74321BD64
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 937301A006A;
 Fri,  9 Feb 2024 19:54:19 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 4/5] cxl/core: add report option for cxl_mem_get_poison()
Date: Fri,  9 Feb 2024 19:54:16 +0800
Message-Id: <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--10.285100-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2sJoDeiZ6YZhB1kSRHxj+Z5/OuUJVcMZhtdXeeZrNJbgiu5
 iQ9EM64EjZRdXn3Xp9M6uZyF2AGJsLVQ6XPWwtdyEXjPIvKd74BMkOX0UoduuR+GgVvXmL4ONE6
 mRLCupPjovSNS3Zhlaq9YGVc6ZwjYP7A6mmzUskBKzjuZtPtIBMMKxxeacM3vnhD4vcFcha6N3H
 kV2EiaA9TrK+6tlqkXumMCMwce1mUfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPBSuOQCfu1OIEDum
 0PDABnfH5DUKb843LaYU+MayamLEm3qeHSd7sch
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:58 -0500
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

When a poison event is received, driver uses GET_POISON_LIST command
to get the poison list.  Now driver has cxl_mem_get_poison(), so
reuse it and add a parameter 'bool report', report poison record to MCE
if set true.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 7 +++++--
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 ++++----
 drivers/cxl/cxlmem.h      | 2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f9b6f50fbe80..e1c67159acc4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1324,7 +1324,7 @@ static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 }
 
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+		       struct cxl_region *cxlr, bool report)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
@@ -1355,10 +1355,13 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		for (int i = 0; i < le16_to_cpu(po->count); i++)
+		for (int i = 0; i < le16_to_cpu(po->count); i++) {
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
+			if (report)
+				cxl_mem_report_poison(cxlmd, &po->record[i]);
+		}
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c304e709ef0e..320bcb8af5b0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -200,14 +200,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 	if (resource_size(&cxlds->pmem_res)) {
 		offset = cxlds->pmem_res.start;
 		length = resource_size(&cxlds->pmem_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc)
 			return rc;
 	}
 	if (resource_size(&cxlds->ram_res)) {
 		offset = cxlds->ram_res.start;
 		length = resource_size(&cxlds->ram_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		/*
 		 * Invalid Physical Address is not an error for
 		 * volatile addresses. Device support is optional.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ce0e2d82bb2b..b008c7e13560 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2386,7 +2386,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	if (ctx->mode == CXL_DECODER_RAM) {
 		offset = ctx->offset;
 		length = resource_size(&cxlds->ram_res) - offset;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT)
 			rc = 0;
 		if (rc)
@@ -2404,7 +2404,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		return 0;
 	}
 
-	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 }
 
 static int poison_by_decoder(struct device *dev, void *arg)
@@ -2438,7 +2438,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 			rc = 0;
 		if (rc)
@@ -2447,7 +2447,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region, false);
 	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 		rc = 0;
 	if (rc)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 97ddab421e63..f0877f055f53 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -831,7 +831,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr);
+		       struct cxl_region *cxlr, bool report);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.34.1


