Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2866DCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qr-0004YO-0c; Fri, 29 Mar 2024 02:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5ql-0004Vf-0J
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:27 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002VD-Gx
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694183; x=1743230183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eaTURs2DX3hFrascB0JmgCheHmdrmF0RLNDE+Or7F2I=;
 b=dd3AWtq5Qxd9SS6BeBBVg6xGOl4Xmnr8slXz5AKM85JiIdmRr7Vq2ZcT
 CmQSRWnrUhAzmpOmh00BEtzhbyopKtYCHjQDWazP4zcL564Oa2lCbANK5
 oA2lgQO4M5mNUO/npZkMRm+5p1MXG1WGpvM/JNvobIPxf+xHDunrdZa8n
 knGSkBOykAVeScr0Nr7lXNEhjWYMjstKYnV1IHsVFByOYtKqVyhtFqkKw
 QNzMgc/wU8OG1XVymaLf/3D7jRuGxBA9GOoDPLcaCUoVvajxx3PmgTVEV
 nUpyNc3nI+WLXX3JESU1z+NbXGfX+EPOJc6dlBu5+UqIfg4Nss7RRYMZY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="153191538"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="153191538"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:19 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 08219D4801
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C1B020538E
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B64C72288EB
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 378B31A006D;
 Fri, 29 Mar 2024 14:36:15 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, stable@vger.kernel.org
Subject: [RFC PATCH v2 1/6] cxl/core: correct length of DPA field masks
Date: Fri, 29 Mar 2024 14:36:09 +0800
Message-Id: <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10-1.936900-10.000000
X-TMASE-MatchedRID: 6KVfooacCZzo4fT4WEihVSQWufwDJ4K9T5ysQDj6eFnIPbn2oQhptW4j
 6HJSTgstiC69Gex0rT0XkIT0cenSu+BRuAss+FbmEXjPIvKd74BUENBIMyKD0ceQfu6iwSfsePr
 7SQbqKPDi8zVgXoAltsIJ+4gwXrEtJ0RPnyOnrZINUgM7QdTcfXGwKxjdKzHf8Yi1jddtlC4HZ7
 7a2hmTYf2ng54tmDQpuA2+Y9lsxTCcrrRiTSKATNx+1ANNyC8exuBs026550TAYLx7rnbR8rDQ8
 m3TqgloelpCXnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
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

The length of Physical Address in General Media Event Record/DRAM Event
Record is 64-bit, so the field mask should be defined as such length.
Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
mask off the upper-32-bits of DPA addresses. The cxl_poison event is
unaffected.

If userspace was doing its own DPA-to-HPA translation this could lead to
incorrect page retirement decisions, but there is no known consumer
(like rasdaemon) of this event today.

Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
Cc: <stable@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..e2d1f296df97 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_FLAGS_MASK			0x3FULL
 #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
 
-#define CXL_DPA_VOLATILE			BIT(0)
-#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define CXL_DPA_VOLATILE			BIT_ULL(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
 #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
-- 
2.34.1


