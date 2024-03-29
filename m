Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817B7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qq-0004YM-Sj; Fri, 29 Mar 2024 02:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5ql-0004Vw-8h
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:27 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002VS-Gy
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694183; x=1743230183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wuhLrD6nDKASM1GZwEy/EhBT98EFm0ZU9lZPPyQH+DE=;
 b=OART/vJ4sCnGjeJ1ZZygNVoF7dHn7tA9ieCeCH7upvA2KlC8Ot4n0zMc
 zZ7T060WNL18+2lFluqs/7s4cecdtvyODkQi7wv44RgcuGENkhVY5FcV2
 e/zVKrhZwq/oKtyt9UvCdMER4kjCeDZsdVhDfL0Ehn02usm+jqa7zvxcW
 57tlhbjU+z60dBFwN4piZSa5gc1mvtnGXc7/6rdZVNaiDNG0MLtt5MyzT
 ta+3h7mCu3x16OUwJa+e+DHS00ayvDiJ61rVOlr/g5y4fSxVoXG7zr9eH
 JRf19ECXIdyq+MXdzFCG7HXtoQuW/thtDg9gG1qo05vQqkfV8g6BLaAB1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="142199696"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="142199696"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:19 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9753ADCC05
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B26A715A16
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A13C224950
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D019B1A006A;
 Fri, 29 Mar 2024 14:36:15 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
Date: Fri, 29 Mar 2024 14:36:11 +0800
Message-Id: <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--9.462200-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiIJoDeiZ6YZhB1kSRHxj+Z5/OuUJVcMZhtdXeeZrNJbgiu5
 iQ9EM64EjZRdXn3Xp9M6uZyF2AGJsLVQ6XPWwtdyEXjPIvKd74BUENBIMyKD0cSiwizsgluQ9my
 Umu4fZeT7dV04rak8k5t7C5yK9FBjJBgtEIxUn4HfSQNpZkETVBgff28UuvITicvz9DxarMHQSo
 WMT37bqFIeZmiiCQMfIdXPCd0ceGWvvxILmKK/HBRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7qYgz
 NcfPy5s9/7GOwz/1iinIjtl5KwpMUvyE7CVOX4olExlQIQeRG0=
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

The GMER only has "Physical Address" field, no such one indicates length.
So, when a poison event is received, we could use GET_POISON_LIST command
to get the poison list.  Now driver has cxl_mem_get_poison(), so
reuse it and add a parameter 'bool report', report poison record to MCE
if set true.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 8 ++++++--
 drivers/cxl/core/memdev.c | 4 ++--
 drivers/cxl/core/region.c | 8 ++++----
 drivers/cxl/cxlmem.h      | 2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 31b1b8711256..19b46fb06ed6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1309,7 +1309,7 @@ void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 EXPORT_SYMBOL_NS_GPL(cxl_mem_report_poison, CXL);
 
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+		       struct cxl_region *cxlr, bool report)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
@@ -1340,10 +1340,14 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		for (int i = 0; i < le16_to_cpu(po->count); i++)
+		for (int i = 0; i < le16_to_cpu(po->count); i++) {
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
+			if (report)
+				cxl_mem_report_poison(cxlmd, cxlr,
+						      &po->record[i]);
+		}
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d4e259f3a7e9..e976141ca4a9 100644
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
index 5c186e0a39b9..e83c46cb4dea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2585,7 +2585,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	if (ctx->mode == CXL_DECODER_RAM) {
 		offset = ctx->offset;
 		length = resource_size(&cxlds->ram_res) - offset;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT)
 			rc = 0;
 		if (rc)
@@ -2603,7 +2603,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		return 0;
 	}
 
-	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 }
 
 static int poison_by_decoder(struct device *dev, void *arg)
@@ -2637,7 +2637,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL, false);
 		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 			rc = 0;
 		if (rc)
@@ -2646,7 +2646,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region, false);
 	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 		rc = 0;
 	if (rc)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 82f80eb381fb..1f03130b9d6a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -832,7 +832,7 @@ void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
 			   struct cxl_region *cxlr,
 			   struct cxl_poison_record *poison);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr);
+		       struct cxl_region *cxlr, bool report);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.34.1


